unit RunProgramUnit;

interface

Uses
  Windows, ACLUtility;

// Runs a program in the given working directory.
// If PrintOutput is set, StdOut (and StdErr) will be piped to
// the PrintOutput method

// CheckTerminateCallback will be called regularly and if the
// process should be terminated, it should return true

// Function returns true if the program was started OK.
// ResultCode is set to 1 if the program did not start, otherwise
// the exit code of the process
Function RunProgram( ProgramName: string;
                     Parameters: string;
                     WorkingDir: string;
                     Var ResultCode: DWORD;
                     TerminateCheck: TTerminateCheck = nil;
                     PrintOutput: TPrintOutput = nil
                   ): boolean;
implementation

Uses
  SysUtils;

Function GetWindowsErrorString( ErrorCode: integer ): string;
var
  buffer: array[ 0..1000 ] of char;
begin
  if FormatMessage( FORMAT_MESSAGE_FROM_SYSTEM,
                   nil, // no special message source
                   ErrorCode,
                   0, // use default language
                   Buffer,
                   Sizeof( Buffer ),
                   nil ) > 0
  then // no arguments
    Result:= Buffer
  else
    Result:= '(Unknown error)';

end;

Function RunProgram( ProgramName: string;
                     Parameters: string;
                     WorkingDir: string;
                     Var ResultCode: DWORD;
                     TerminateCheck: TTerminateCheck;
                     PrintOutput: TPrintOutput
                   ): boolean;
Const
  PipeBufferSize = 10000;
  PipeName = '\\.\pipe\myoutputpipe';
Var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  rc: DWORD;
  NameAndArgs: string;

  pipeServer: hFile;
  buffer: array[ 0..PipeBufferSize ] of char;
  bytesRead: DWORD;
  SecAttrs: TSecurityAttributes;
  pipeClient: hFile;
Begin

  pipeServer:= 0;
  pipeClient:= 0;
  try
    NameAndArgs:= ProgramName+' '+Parameters;

    // Initialize some variables to create a process
    ZeroMemory( @StartupInfo, SizeOf( StartupInfo ) );

    StartupInfo.cb := SizeOf( StartupInfo );
    StartupInfo.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := SW_HIDE;

    if Assigned( PrintOutput ) then
    begin
      // Allow the started process to inherit our handles
      FillChar( SecAttrs, SizeOf( SecAttrs ), #0);
      SecAttrs.nLength              := SizeOf(SecAttrs);
      SecAttrs.lpSecurityDescriptor := nil;
      SecAttrs.bInheritHandle       := TRUE;

      // Create a pipe
      pipeServer:= CreateNamedPipe( PipeName,
                                    PIPE_ACCESS_DUPLEX,
                                    PIPE_TYPE_BYTE or PIPE_NOWAIT,
                                    PIPE_UNLIMITED_INSTANCES,
                                    PipeBufferSize, //out buffer
                                    PipeBufferSize, // in buffer
                                    100, // default timeout (ms)
                                    Addr( SecAttrs ) );

      // Get a handle to the other (client) end of the pipe
      pipeClient:= CreateFile( PipeName,
                               GENERIC_READ or GENERIC_WRITE,
                               FILE_SHARE_READ or FILE_SHARE_WRITE,
                               Addr( SecAttrs ),
                               OPEN_EXISTING,
                               FILE_ATTRIBUTE_NORMAL,
                               0 );

      // setup the process to write into the other end
      StartupInfo.hStdOutput:= pipeClient;
      StartupInfo.hStdError:= pipeClient;
    end;

    // Create the process
    Result:= CreateProcess( Nil, // use next param for exe name
                            PChar( NameAndArgs ), // command line
                            Nil, // no security attributes
                            Nil, // no thread security attributes
                            True, // do inherit handles
                            CREATE_NEW_PROCESS_GROUP, // so we can send
                            // it Ctrl signals
                            Nil, // no new environment
                            PChar( WorkingDir ), // directory
                            StartupInfo,
                            ProcessInfo );
    if not Result then
    begin
      PrintOutput( 'Could not run '+NameAndArgs );
      PrintOutput( 'Windows error text: ' + GetWindowsErrorString( GetLastError ) );
      ResultCode:= 1;
      exit;
    end;

    while true do
    begin
      if Assigned( TerminateCheck ) then
        if TerminateCheck then
        begin
          GenerateConsoleCtrlEvent( CTRL_BREAK_EVENT, ProcessInfo.dwProcessID );
          ResultCode:= 1;
          exit;
        end;

      // Wait 1 second to see if it finishes...
      rc:= WaitForSingleObject( ProcessInfo.hProcess, 1000);

      if Assigned( PrintOutput ) then
      begin
        repeat
          // Read the output from our end of the pipe
          ReadFile( pipeServer,
                    buffer,
                    PipeBufferSize,
                    bytesRead,
                    nil );
          buffer[ bytesRead ]:= #0; // null terminate
          if bytesRead > 0 then
            PrintOutput( buffer );

        until bytesRead=0;

      end;

      if rc<>WAIT_TIMEOUT then
      begin
        // finished
        GetExitCodeProcess( ProcessInfo.hProcess,
                            ResultCode );
        // terminate loop
        exit;
      end;
    end;
  finally
    if pipeClient<>0 then
      CloseHandle( pipeClient );
    if pipeServer<>0 then
      CloseHandle( pipeServer );
  end;

end;

end.
