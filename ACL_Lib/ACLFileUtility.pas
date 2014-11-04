Unit ACLFileUtility;

Interface

uses
  SysUtils, Classes;

// Expands the path given, relative to BaseDir
Function ExpandPath( BaseDir: string;
                     Path: string ): string;

Function ParentDir( Dir: string ): string;

Function StripDrive( Path: string ): string;

Function ChangeDrive( Path: string;
                      NewDrive: string ): string;
                      
Procedure MakeFileReadOnly( Filename: string );

Procedure MakeFileReadWrite( Filename: string );

// Deletes files incl readonly
Function MyDeleteFile( Path: string ): boolean;

// Adds a slash to dir if not present
Function AddSlash( Dir: string ): string;

// Remove slash from end of dir if present
Function RemoveSlash( Dir: string ): string;

// Returns true if it succeeds in removing the directory
// Always removes readonly files
Function DeleteTree( path: string ): boolean;

Procedure ClearDirectory( Directory: string );

// Get the TMP directory
Function TempDir: string;

// Return a list of files in the given Dir
Procedure GetFilesForDir( Dir: string; List: TStrings );

// Return a list of files in the given Dir. using the given filter
Procedure GetFilteredFilesForDir( Dir: string;
                                  Filter: string;
                                  List: TStrings );

// Returns list of files given dir, using given mask (
// Mask may contain more than one filter e.g. *.c;*.h
Procedure GetMaskedFilesForDir( Dir: string;
                                Mask: string;
                                List: TStrings );

// Return a list of files in the given path
Procedure GetFilesForPath( PathEnvVar: string;
                           Mask: string;
                           List: TStrings );

// In the directory startpath, create directory and subdirectories
// specified in DirsString
// e.g. bob\bill\fred will make bob, then bill in bob, then fred in bob
// returns path to lowest dir created
Function MakeDirs( FullPath: string ):string;

// Returns current path incl drive
Function GetCurrentDir: string;

// Returns date/time of last modification of file
// Returns 0.0 if error
Function FileDateTime( filename: string ): TDateTime;

// Returns true if file exists and is read only
Function FileIsReadOnly( filename: string ):Boolean;

{$ifdef os2}
Function ExtractFileDrive( Path: string ): string;

Function DirectoryExists( Dir: string ):boolean;

Procedure AnsiReadLn( Var TheFile: Text;
                      Var Line: AnsiString );

Function GetFileSize( Filename: string ): longint;

{$endif}

Function SearchPath( PathEnvVar: string;
                     Filename: string;
                     Var FilenameFound: string ): boolean;

Function RunProgram( FileName: string;
                     Parameters: string ): boolean;

Implementation

uses
{$ifdef os2}
  BseDos, DOS, Os2Def,
{$else}
  Windows, FileCtrl,
{$endif}
  ACLFindFunctions, ACLStringUtility, ACLPCharUtility, ACLString;

Function ParentDir( Dir: string ): string;
var
  SlashPos: integer;
begin
  for SlashPos := Length( Dir ) downto 1 do
  begin
    if Dir[ SlashPos ] = '\' then
    begin
      result:= StrLeft( Dir, SlashPos );
      exit;
    end;
  end;
  result:= '';
end;

Function ExpandPath( BaseDir: string;
                     Path: string ): string;
var
  Dir: string;
begin
  Result:= AddSlash( BaseDir );
  Path := trim( path );
  if Length( Path ) > 2 then
  begin
    if Path[ 2 ] = ':' then
    begin
      Result := StrLeft( Path, 2 );
      Path := StrRightFrom( Path, 3 );
    end;
  end;
  while Length( Path ) > 0 do
  begin
    Dir := ExtractNextValue( Path, '\' );
    if Dir = '..' then
    begin
      Result := ParentDir( Result );
    end
    else if Dir = '.' then
    begin
      ; // nothing to do
    end
    else
    begin
      Result := Result + Dir + '\';
    end;
  end;
end;

{$ifdef os2}
Function ExtractFileDrive( Path: string ): string;
begin
  Result:= '';
  if Length( Path ) < 2 then
    exit;
  if Path[ 2 ] = ':' then
    Result:= Copy( Path, 1, 2 );
end;
{$endif}

Function ChangeDrive( Path: string;
                      NewDrive: string ): string;
var
  CurrentDrive: string;
begin
  Result:= Path;
  CurrentDrive:= ExtractFileDrive( Path );
  Result:= RemoveSlash( NewDrive )
           + StrRightFrom( Path, Length( CurrentDrive ) + 1 );
end;

Function StripDrive( Path: string ): string;
begin
  Result:= ChangeDrive( Path, '' );
end;

Procedure MakeFileReadOnly( Filename: string );
var
  Attributes: longint;
begin
  Attributes:= FileGetAttr( FileName );
  Attributes:= Attributes or faReadonly;
  FileSetAttr( FileName, Attributes );
end;

Procedure MakeFileReadWrite( Filename: string );
var
  Attributes: longint;
begin
  Attributes:= FileGetAttr( FileName );
  Attributes:= Attributes and not faReadonly;
  FileSetAttr( FileName, Attributes );
end;

// Deletes files incl readonly
Function MyDeleteFile( Path: string ): boolean;
begin
  MakeFileReadWrite( Path );
  {$ifdef os2}
  Result:= DeleteFile( Path );
  {$else}
  Result:= DeleteFile( PChar( Path ) );
  {$endif}
end;

// Adds a slash if need to Dir
function AddSlash( Dir: string ): string;
begin
  if Dir='' then
    Result:= '\'
  else
    if Dir[ length( Dir ) ]<>'\' then
      Result:= Dir + '\'
    else
      Result:= Dir;
end;

// Remove slash from end of dir if present
function RemoveSlash( Dir: string ): string;
begin
  Result:= Dir;
  if Dir<>'' then
    if Result[ length( Result ) ]='\' then
      Delete( Result, length( Result ), 1 );
end;

Function DeleteTree( path: string ): boolean;
Var
  SearchResults: TSearchData;
  rc:integer;
  Directories: TStringList;
  DirectoryIndex: longint;
  FullPath: string;
Begin
  path:= AddSlash( path );
  Directories:= TStringList.Create;
  rc:= MyFindFirst( path+'*', SearchResults );
  while rc = 0 do
  begin
    if ( SearchResults.Name <> '.' )
       and ( SearchResults.Name <> '..' ) then
    begin
      FullPath:= path + SearchResults.Name;
      if SearchResults.Attr And faDirectory > 0 then
        Directories.Add( FullPath )
      else
        MyDeleteFile( FullPath );
    end;
    rc:= MyFindNext( SearchResults );
  end;

  SysUtils.FindClose( SearchResults );

  // Now delete directories
  for DirectoryIndex:= 0 to Directories.Count-1 do
    DeleteTree( Directories[ DirectoryIndex ] );

  Directories.Destroy;

  // Finally remove the directory itself
  RmDir( StrLeftWithout( path, 1 ) );
  Result:= (IOResult=0);
End;

Procedure ClearDirectory( Directory: string );
Var
  SearchResults: TSearchData;
  rc:integer;
  FileName: string;
Begin
  Directory:= AddSlash( Directory );
  rc:= MyFindFirst( Directory + '*', SearchResults );
  while rc=0 do
  begin
    FileName:= Directory + SearchResults.Name;
    if SearchResults.Attr and faDirectory = 0 then
      MyDeleteFile( FileName );
    rc:= MyFindNext( SearchResults );
  end;
  SysUtils.FindClose( SearchResults );
End;

Function TempDir: string;
{$ifdef win32}
var
  Buffer: array[ 0.. MAX_PATH ] of char;
{$endif}
Begin
{$ifdef os2}
  Result:= GetEnv( 'TMP' );
{$else}
  GetTempPath( sizeof( Buffer ), Buffer );
  Result:= StrPas( Buffer );
{$endif}
  Result:= AddSlash( Result );
end;

// Return a list of files in the given Dir. using the given filter
Procedure GetFilteredFilesForDir( Dir: string;
                                  Filter: string;
                                  List: TStrings );
Var
  SearchResults: TSearchData;
  rc:integer;
Begin
  Dir:= AddSlash( Dir );
  rc:= MyFindFirst( Dir+Filter, SearchResults );
  while rc=0 do
  begin
    if SearchResults.Attr and faDirectory = 0 then
      List.Add( dir + SearchResults.Name );
    rc:= MyFindNext( SearchResults );
  end;
  MyFindClose( SearchResults );
End;

Procedure GetFilesForDir( Dir: string; List: TStrings );
Begin
  GetFilteredFilesForDir( Dir, '*', List );
End;

Procedure GetMaskedFilesForDir( Dir: string;
                                Mask: string;
                                List: TStrings );
Var
  Filter: string;
Begin
  while Mask <> '' do
  begin
    Filter:= ExtractNextValue( Mask, ';' );
    GetFilteredFilesForDir( Dir, Filter, List );
  end;
End;

Procedure GetFilesForPath( PathEnvVar: string;
                           Mask: string;
                           List: TStrings );
var
  pszPath: PChar;
  rc: APIRET;
  Path: TAString;
  Dir: TAstring;
  NextDir: longint;
{$ifdef os2}
  szEnvVar: cstring;
{$endif}
begin
{$ifdef os2}
  szEnvVar:= PathEnvVar;
  rc:= DosScanEnv( szEnvVar, pszPath );
{$endif}
  if rc <> 0 then
    exit;
  Path:= TAString.CreateFromPChar( pszPath );
  Dir:= TAstring.Create;

  NextDir:= 0;

  while NextDir < Path.Length do
  begin
    Path.ExtractNextValue( NextDir, Dir, ';' );
    GetMaskedFilesForDir( Dir.AsString, Mask, List );
  end;

  Dir.Destroy;
  Path.Destroy;

end;

Function MakeDirs( FullPath: string ): string;
Var
  RemainingDirs: string;
  NewDir: string;
  CreatePath:string;
Begin
  CreatePath:= '';

  // Iterate thru specified dirs
  RemainingDirs:= FullPath;
  while trim( RemainingDirs )<>'' do
  begin
    NewDir:= ExtractNextValue( RemainingDirs, '\' );
    if NewDir<>'' then
    begin
      CreatePath:= CreatePath + NewDir;
      if not DirectoryExists( CreatePath ) then
        MkDir( CreatePath );
      CreatePath:= CreatePath + '\';
    end;
  end;
  // Remove the end \
  Result:= RemoveSlash( CreatePath );
end;

// Returns current path incl drive
{$ifdef os2}
Function GetCurrentDir: string;
Var
  CurrentDir: cstring[ 200 ];
  CurrentDirLen: longword;
  CurrentDisk: longword;
  DiskMap: longword;
Begin
  CurrentDirLen:= sizeof( CurrentDir );
  DosQueryCurrentDisk( CurrentDisk, DiskMap );
  DosQueryCurrentDir( CurrentDisk,
                      CurrentDir,
                      CurrentDirLen );

  // Form drive part
  Result:= Chr( Ord( 'A' ) + CurrentDisk - 1 ) + ':\';
  // Add directory
  Result:= AddSlash( Result + CurrentDir );
End;
{$else}
Function GetCurrentDir: string;
begin
  GetDir( 0, Result );
end;
{$endif}

Function FileDateTime( filename: string ):TDateTime;
Var
  FileDate: longint;
Begin
  FileDate:=FileAge( filename );
  if FileDate=-1 then
  begin
    Result:=0.0;
    exit;
  end;
  Result:=FileDateToDateTime( FileDate );
end;

Function FileIsReadOnly( filename: string ):Boolean;
Begin
  Result:=( FileGetAttr( filename ) and faReadonly ) >0;
End;

Procedure AnsiReadLn( Var TheFile: Text;
                      Var Line: AnsiString );
Var
  C: Char;
  FoundCR: boolean;
Begin
  Line:= '';
  FoundCR:= false;
  while not eof( TheFile ) do
  begin
    Read( TheFile, C );
    if ( C=#10 ) then
    begin
      if FoundCR then
        exit; // reached end of line
    end
    else
    begin
      if FoundCR then
        // last CR was not part of CR/LF so add to string
        line:= line+#13;
    end;
    FoundCR:= (C=#13);
    if not FoundCR then // don't handle 13's till later
    begin
      line:= line+C;
    end;
  end;

  if FoundCR then
  // CR was last char of file, but no LF so add to string
    line:= line+#13;
End;

{$ifdef os2}
Function DirectoryExists( Dir: string ):boolean;
Var
  SearchRec: TSearchData;
  rc: longint;
  DriveMap: LongWord;
  ActualDrive: LongWord;
  Drive: Char;
  DriveNum: longword;
  DriveBit: longword;
Begin
  Result:= false;
  Dir:= RemoveSlash( Dir );
  if Dir = '' then
  begin
    Result:= true;
    exit;
  end;
  if length( Dir ) = 2 then
    if Dir[ 2 ] = ':' then
    begin
      // a drive only has been specified
      Drive:= UpCase( Dir[ 1 ] );
      if ( Drive < 'A' ) or ( Drive > 'Z' ) then
        exit;
      DosQueryCurrentDisk( ActualDrive, DriveMap );
      DriveNum:= Ord( Drive ) - Ord( 'A' ) + 1; // A -> 1, B -> 2...
      DriveBit:= 1 shl (DriveNum-1); // 2^DriveNum
      if ( DriveMap and ( DriveBit ) > 0 ) then
        Result:= true;
      exit;
    end;

  rc:= MyFindFirst( Dir, SearchRec );
  if rc = 0 then
    if ( SearchRec.Attr and faDirectory )>0 then
      Result:= true;
  MyFindClose( SearchRec );
End;

Function GetFileSize( Filename: string ): longint;
var
  szFilename: Cstring;
  FileInfo: FILESTATUS3;     /* File info buffer */
  rc: APIRET;                   /* Return code */
begin
  szFilename:= FileName;
  rc := DosQueryPathInfo( szFilename,
                          1,
                          FileInfo,
                          sizeof( FileInfo ) );
  if rc = 0 then
    Result:= FileInfo.cbFile
  else
    Result:= -1;
end;

Function SearchPath( PathEnvVar: string;
                     Filename: string;
                     Var FilenameFound: string ): boolean;
var
  szEnvVar: cstring;
  szFilename: cstring;
  szFilenameFound: cstring;
  rc: APIRET;
begin
  Result:= false;
  FilenameFound:= '';

  szEnvVar:= PathEnvVar;
  szFilename:= Filename;
  rc:= DosSearchPath( SEARCH_IGNORENETERRS
                      + SEARCH_ENVIRONMENT
                      + SEARCH_CUR_DIRECTORY,
                      szEnvVar,
                      szFilename,
                      szFilenameFound,
                      sizeof( szFilenameFound ) );

  if rc = 0 then
  begin
    Result:= true;
    FilenameFound:= szFilenameFound;
  end
end;

Function RunProgram( FileName: string;
                     Parameters: string ): boolean;
var
  Dir: string;
  Found: boolean;
  Dummy: string;
  rc: longint;
  Extension: string;
begin
  Dir:= ExtractFilePath( FileName );
  if Dir = '' then
    Found:= SearchPath( 'PATH',
                        Filename,
                        Dummy )
  else
    // file path specified...
    Found:= FileExists( FileName );

  if not Found then
  begin
    Result:= false;
    exit;
  end;

  Result:= true;

  Extension:= ExtractFileExt( FileName );
  if StringsSame( Extension, '.exe' ) then
    Exec( FileName,
          Parameters )
  else
    Exec( 'cmd.exe',
          '/c '
          + FileName
          + ' '
          + Parameters );

end;
{$else}
Function RunProgram( FileName: string;
                     Parameters: string ): boolean;
Var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  NameAndArgs: string;
Begin
  NameAndArgs:= FileName+' '+Parameters;

  // Initialize some variables to create a process
  ZeroMemory( @StartupInfo, SizeOf( StartupInfo ) );

  StartupInfo.cb := SizeOf( StartupInfo );
  StartupInfo.dwFlags := STARTF_USESTDHANDLES;

  // Create the process
  Result:= CreateProcess( Nil, // use next param for exe name
                          PChar( NameAndArgs ), // command line
                          Nil, // no security attributes
                          Nil, // no thread security attributes
                          True, // do inherit handles
                          CREATE_NEW_PROCESS_GROUP, // so we can send
                          // it Ctrl signals
                          Nil, // no new environment
                          Nil, // use current directory
                          StartupInfo,
                          ProcessInfo );
  if not Result then
    exit;

end;
{$endif}

Initialization
End.
