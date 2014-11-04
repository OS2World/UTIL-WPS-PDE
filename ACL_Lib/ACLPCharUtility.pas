Unit ACLPCharUtility;

Interface

function StrNPas( const ps: PChar; const Length: integer ): String;

// Returns a - b
Function PCharDiff( const a: PChar; const b: Pchar ): longword;

// trims spaces and carriage returns of the end of Text
procedure TrimWhitespace( Text: PChar );

// Concatenates a pascal string onto a PCHar string
// Resizes if needed
procedure StrPCat( Var Dest: PChar;
                   StringToAdd: string );

// Trim endlines (#10 or #13) off the end of
// the given string.
Procedure TrimEndLines( S: PChar );

// Allocates enough memory for a copy of s as a PChar
// and copies s to it.
Function StrDupPas( const s: string ): PChar;

// Returns a copy of the first n chars of s
Function StrNDup( const s: PChar; const n: integer ): PChar;

// Returns a copy of the first line starting at lineStart
Function CopyFirstLine( const lineStart: PChar ): PChar;

// Returns next line p points to
Function NextLine( const p: PChar): PChar;

// Concatentate AddText to Text. Reallocate and expand
// Text if necessary. This is a size-safe StrCat
Procedure AddAndResize( Var Text: PChar;
                        AddText: PChar );

Implementation

Uses
  SysUtils, ACLConstants;

function StrNPas( const Ps: PChar; const Length: integer ): String;
var
  i: integer;
begin
  Result:= '';
  i:= 0;
  while ( Ps[ i ] <> #0 ) and ( i < Length ) do
  begin
    Result:= Result + Ps[ i ];
    inc( i );
  end;
end;

Function PCharDiff( const a: PChar; const b: Pchar ): longword;
begin
  Result:= longword( a ) - longword( b );
end;

Procedure CheckPCharSize( Var Text: PChar;
                          AddSize: longword );
var
  temp: PChar;
  NeededSize: longword;
  NewBufferSize: longword;
begin
  NeededSize:= strlen( Text ) + AddSize + 2;
  if NeededSize > StrBufSize( Text ) then
  begin
    // allocate new buffer, double the size...
    NewBufferSize:= StrBufSize( Text ) * 2;
    // or if that's not enough...
    if NewBufferSize < NeededSize then
      // double what we are going to need
      NewBufferSize:= NeededSize * 2;
    temp:= StrAlloc( NewBufferSize );

    StrCopy( temp, Text );
    StrDispose( Text );
    Text:= temp;
  end;
end;

Procedure AddAndResize( Var Text: PChar;
                        AddText: PChar );
begin
  CheckPCharSize( Text, strlen( AddText ) );
  StrCat( Text, AddText );
end;

// trims spaces and carriage returns of the end of Text
procedure TrimWhitespace( Text: PChar );
var
  P: PChar;
  IsWhitespace: boolean;
  TheChar: Char;
begin
  P:= Text + StrLen( Text );
  while P > Text do
  begin
    dec( P );
    TheChar:= P^;
    IsWhitespace:= TheChar in [ ' ', #13, #10, #9 ];
    if not IsWhiteSpace then
      // done
      break;
    P^:= #0;
  end;
end;

procedure StrPCat( Var Dest: PChar;
                   StringToAdd: string );
var
  Index: longint;
  DestP: PChar;
begin
  CheckPCharSize( Dest, Length( StringToAdd ) );
  DestP:= Dest + StrLen( Dest );
  for Index:= 1 to Length( StringToAdd ) do
  begin
    DestP^:= StringToAdd[ Index ];
    inc( DestP );
  end;
  DestP^:= #0;
end;

Procedure TrimEndLines( S: PChar );
var
  StringIndex: integer;
begin
  StringIndex:= strlen( S );
  while StringIndex > 0 do
  begin
    dec( StringIndex );
    if S[ StringIndex ] in [ #10, #13 ] then
      S[ StringIndex ]:= #0
    else
      break;
  end;
end;

Function StrDupPas( const s: string ): PChar;
Begin
  Result:=StrAlloc( length( s )+1 );
  StrPCopy( Result, S );
//  Result^:=s;
End;

// Returns a copy of the first n chars of s
Function StrNDup( const s: PChar; const n: integer ): PChar;
Begin
  Result:= StrAlloc( n+1 );
  Result[ n ]:= '6';
  StrLCopy( Result, s, n );
End;

// Returns a copy of the first line starting at lineStart
Function CopyFirstLine( const lineStart: PChar ): PChar;
Var
  lineEnd: PChar;
  lineLength: integer;
Begin
  // look for an end of line
  lineEnd:= strpos( lineStart, EndLine );
  if lineEnd <> nil then
  begin
    // found, line length is difference between line end position and start of line
    lineLength:= longword( lineEnd )-longword( lineStart ); // ugly but how else can it be done?
    Result:= StrNDup( lineStart, lineLength );
    exit;
  end;

  // no eol found, return copy of remainder of string
  Result:= StrNew( lineStart );
end;

// Returns next line p points to
Function NextLine( const p: PChar): PChar;
Var
  lineEnd: PChar;
Begin
  // look for an end of line
  lineEnd:=strpos( p, EndLine );
  if lineEnd<>nil then
  begin
    // Advance the linestart over the eol
    Result:=lineEnd+length( EndLine );
    exit;
  end;

  // no eol found, return pointer to null term
  Result:=p+strlen( p );
end;

Initialization
End.
