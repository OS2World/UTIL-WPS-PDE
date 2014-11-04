Unit ACLFileIOUtility;
// Functions for working with OS/2 HFILE

Interface

uses
  BseDos;

// skips over Length bytes
Procedure MySkip( F: HFile; Length: longword );

Procedure MySeek( F: HFile; NewPos: longword );

function MyRead( F: HFile; Buffer: pointer; Length: LongWord ): boolean;

function MyReadLn( F: HFile; Var S: String ): boolean;

// Note: Buffer will be resized as needed.
function MyReadParagraph( F: HFile; Buffer: PChar ): boolean;

Procedure MyWrite( F: HFile; Buffer: pointer; Length: LongWord );

Procedure MyWriteLn( F: HFile; S: String );

Procedure WriteStringToFile( TheString: PChar; FileName: string );

Procedure ReadStringFromFile( TheString: PChar; FileName: string );

Implementation

uses
  OS2Def, SysUtils,
  ACLPCharUtility;

// skips over Length bytes
Procedure MySkip( F: HFile; Length: longword );
var
  Actual: ULong;
begin
  DosSetFilePtr( F, Length, FILE_CURRENT, Actual );
end;

Procedure MySeek( F: HFile; NewPos: longword );
var
  Actual: ULong;
begin
  DosSetFilePtr( F, NewPos, FILE_BEGIN, Actual );
end;

function MyRead( F: HFile; Buffer: pointer; Length: LongWord ): boolean;
var
  Actual: ULong;
begin
  Result:= DosRead( F, Buffer^, Length, Actual ) = 0;
  if Actual = 0 then
    Result:= false;
end;

function MyReadLn( F: HFile; Var S: String ): boolean;
var
  C: Char;
  NewFilePtr: ULONG;
begin
  Result:= MyRead( F, Addr( C ), 1 );
  while ( C <> #13 )
        and Result do
  begin
    S:= S + C;
    Result:= MyRead( F, Addr( C ), 1 );
  end;
  Result:= MyRead( F, Addr( C ), 1 );
  if C <> #10 then
  begin
    DosSetFilePtr( F, -1, FILE_CURRENT, NewFilePtr );
  end;
end;

function MyReadParagraph( F: HFile; Buffer: PChar ): boolean;
var
  CharBuffer: array[ 0..1 ] of Char;
  NewFilePtr: ULONG;
begin
  StrCopy( Buffer, '' );
  CharBuffer[ 1 ]:= #0;
  Result:= MyRead( F, Addr( CharBuffer ), 1 );
  while ( CharBuffer[ 0 ] <> #13 )
        and Result do
  begin
    AddAndResize( Buffer, CharBuffer );
    Result:= MyRead( F, Addr( CharBuffer ), 1 );
  end;

  if not Result then
    exit;

  // skip #10 if found
  Result:= MyRead( F, Addr( CharBuffer ), 1 );
  if Result then
    if CharBuffer[ 0 ] <> #10 then
      DosSetFilePtr( F, -1, FILE_CURRENT, NewFilePtr );
end;

Procedure MyWrite( F: HFile; Buffer: pointer; Length: LongWord );
var
  Actual: ULong;
begin
  DosWrite( F, Buffer^, Length, Actual );
end;

Procedure MyWriteLn( F: HFile; S: String );
var
  Buffer: PChar;
begin
  Buffer:= StrAlloc( Length( S ) + 3 );
  StrPCopy( Buffer, S );
  StrCat( Buffer, #13 );
  StrCat( Buffer, #10 );
  MyWrite( F, Buffer, StrLen( Buffer ) );
  StrDispose( Buffer );
end;

Procedure WriteStringToFile( TheString: PChar; FileName: string );
Var
  TheFile: File;
Begin
  Assign( TheFile, FileName );
  Rewrite( TheFile );
  BlockWrite( TheFile, TheString^, strlen( TheString ) );
  Close( TheFile );
End;

Procedure ReadStringFromFile( TheString: PChar; FileName: string );
Var
  TheFile: File;
Begin
  Assign( TheFile, FileName );
  Reset( TheFile );
  BlockRead( TheFile, TheString^, FileSize( TheFile ) );
  TheString[ FileSize( TheFile ) ]:=Chr( 0 );
  Close( TheFile );
End;

Initialization
End.
