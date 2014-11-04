Unit ACLProfile;
// Crude profiling functions. Accurate to single milliseconds
// (not just 1/18s). Writes profile to text file called 'profile' in
// current directory.
// Call ProfileEvent to log an event with time.

// Now logs delta times (time used) as well.
Interface

procedure StartProfile( Filename: string );

procedure ProfileEvent( Event: string );

procedure StopProfile;

Implementation

uses
{$ifdef os2}
  OS2Def, PMWin,
{$else}
  Windows,
{$endif}
  SysUtils;

var
  ProfileStartTime: ULONG;
  LastProfileTime: ULONG;
  ProfileFile: TextFile;

const
  Profiling: boolean = false;

function GetSystemMSCount: ULONG;
begin
{$ifdef os2}
  Result:= WinGetCurrentTime( AppHandle );
{$else}
  Result:= GetTickCount;
{$endif}
end;

procedure StartProfile( Filename: string );
begin
  ProfileStartTime:= GetSystemMSCount;
  LastProfileTime:= ProfileStartTime;
  Assign( ProfileFile, Filename );
  Rewrite( ProfileFile );
  Write( ProfileFile,
           'Profile start' );
  Close( ProfileFile );
  Profiling:= true;
end;

procedure ProfileEvent( Event: string );
var
  ThisProfileTime: ULONG;
begin
  if not Profiling then
    exit;
  Append( ProfileFile );
  ThisProfileTime:= GetSystemMSCount;

  WriteLn( ProfileFile,
           + ', Used: '
           + IntToStr( ThisProfileTime - LastProfileTime ) );

  Write( ProfileFile,
         Event + ': '
         + IntToStr( ThisProfileTime - ProfileStartTime ) );

  LastProfileTime:= ThisProfileTime;

  Close( ProfileFile );
end;

procedure StopProfile;
begin
  if not Profiling then
    exit;
  ProfileEvent( 'Profile stop' );
  Profiling:= false;
end;

Initialization
End.
