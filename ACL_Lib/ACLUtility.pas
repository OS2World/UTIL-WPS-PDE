Unit ACLUtility;

Interface

Uses
  Classes, SysUtils, Forms, StdCtrls;

Type
  TPrintOutput = procedure( TheText: string ) of object;
  TTerminateCheck = function: boolean of object;
  TProgressCallback = procedure( n, outof: integer;
                                 Message: string ) of object;

const
   _MAX_PATH = 260;    /* max. length of full pathname           */
   _MAX_DRIVE = 3;     /* max. length of drive component         */
   _MAX_DIR = 256;     /* max. length of path component          */
   _MAX_FNAME = 256;   /* max. length of file name component     */
   _MAX_EXT = 256;     /* max. length of extension component     */

procedure MemCopy( const Source, Dest: pointer; const Size: longint );

procedure FillMem( Dest: pointer;
                   Size: longint;
                   Data: Byte );

// Returns A - B
function PtrDiff( A, B: pointer ): longword;

function Min( a, b: longint ): longint;

function Max( a, b: longint ): longint;

function Between( Value, Limit1, Limit2: longint ): boolean;

Procedure AddList( Source, Dest: TList );

Procedure AssignList( Source, Dest: TList );

Procedure DestroyListObjects( List: TList );

// Returns the filename of the running app
// (including drive/directory)
Function GetApplicationFilename: string;

// Returns the starting directory of the app
Function GetApplicationDir: string;

{$ifdef win32}
type
  TDaylightSavingStatus =
  (
    dssDisabled,
    dssDaylightSaving,
    dssNormal
  );

function GetDaylightSavingStatus: TDaylightSavingStatus;
{$endif}

Implementation

Uses
{$ifdef os2}
  Dos, BseDos, Os2Def, BseTib,
{$else}
  Windows, FileCtrl,
{$endif}
  Dialogs,
  ACLFindFunctions;

// Originally a call to Move, now I've removed some extraneous fluff
// and it takes pointers. 
procedure MemCopy( const Source, Dest: pointer; const Size: longint );
begin
  Asm
{$ifdef win32}
  Move( Source^, Dest^, Size );
{$else}
  MOV ESI,Source
  MOV EDI,Dest
  MOV ECX,Size

  STD
  ADD ESI,ECX
  DEC ESI
  ADD EDI,ECX
  DEC EDI
  REP
  MOVSB
  CLD
!MoveEnd:
{$endif}
  end;
END;


procedure FillMem( Dest: pointer;
                   Size: longint;
                   Data: Byte );
begin
  FillChar( Dest^, Size, Data );
{  while Size > 0 do
  begin
    PBYTE( Dest )^:= Data;
    inc( Dest );
    dec( Size );
  end;}
end;

function PtrDiff( A, B: pointer ): longword;
begin
  result:= longword( A ) - longword( B );
end;

Procedure AddList( Source, Dest: TList );
var
  i: longint;
begin
  // expand the destination list
  // to what's required
  Dest.Capacity := Dest.Capacity
                   + Source.Capacity;
  for i:= 0 to Source.Count - 1 do
    Dest.Add( Source[ i ] );
end;

Procedure AssignList( Source, Dest: TList );
var
  i: longint;
begin
  Dest.Clear;
  AddList( Source, Dest );
end;

{$ifdef win32}
function GetDaylightSavingStatus: TDaylightSavingStatus;
var
  TimeZoneInfo: TIME_ZONE_INFORMATION;
  ZoneID: DWORD;
Begin
  ZoneID:= GetTimeZoneInformation( TimeZoneInfo );
  if TimeZoneInfo.DaylightBias = 0 then
    Result:= dssDisabled
  else if ZoneID = TIME_ZONE_ID_DAYLIGHT then
    Result:= dssDaylightSaving
  else
    Result:= dssNormal;
end;
{$endif}

Procedure DestroyListObjects( List: TList );
var
  Index: longint;
begin
  for Index := 0 to List.Count - 1 do
    TObject( List[ Index ] ).Destroy;
end;

function Min( a, b: longint ): longint;
begin
  if a<b then
   result:= a
  else
   result:= b;
end;

function Max( a, b: longint ): longint;
begin
  if a>b then
   result:= a
  else
   result:= b;
end;

function Between( Value, Limit1, Limit2: longint ): boolean;
begin
  if Limit1 < Limit2 then
    Result:= ( Value >= Limit1 ) and ( Value <= Limit2 )
  else
    Result:= ( Value >= Limit2 ) and ( Value <= Limit1 )
end;

Function GetApplicationFilename: string;
var
  pThreadInfo: PTIB;
  pProcessInfo: PPIB;
  ProcessName: cstring[ _MAX_PATH ];
begin
  DosGetInfoBlocks( pThreadInfo,
                    pProcessInfo );
  DosQueryModuleName( pProcessInfo^.pib_hmte,
                      sizeof( ProcessName ),
                      ProcessName );
  Result := ProcessName;
end;

Function GetApplicationDir: string;
begin
  Result := ExtractFilePath( GetApplicationFilename );
end;

Initialization
End.

