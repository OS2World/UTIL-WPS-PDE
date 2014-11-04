Unit ACLStringUtility;

Interface

Uses
  Classes;

// Converts a hex string to a longint
// May be upper or lower case
// Does not allow a sign
// Is not forgiving as StrToInt: all characters
// must be valid hex chars.
function HexToInt( s: string ): longint;

{$ifdef os2}
procedure GetMemString( p: pointer;
                        Var s: string;
                        Size: byte );

function NewPString( const s: string ): PString;

procedure FreePString( Var ps: PString );
{$endif}

// Case insensitive compare
Function StringsSame( const a, b: string ): boolean;

// Returns S in double quotes
Function StrDoubleQuote( s: string ): string;

// Substitutes given character
Function SubstituteChar( const S: string; const Find: Char; const Replace: Char ): string;

// Returns the count rightmost chars of S
Function StrRight( const S:string; const count:integer ):string;

// Returns the remainder of S starting at start
Function StrRightFrom( const S:string; const start:integer ):string;

// Returns the count leftmost chars of S
Function StrLeft( const S:string; const count:integer ):string;

// Returns S minus count characters from the right
Function StrLeftWithout( const S:string; const count:integer ):string;

// Returns S with leftCount chars removed from the left and
// rightCount chars removed from the right.
Function StrRemoveEnds( const S:string; const leftCount:integer; const rightCount:integer ):string;

// Parses a line of the form
// key = value into it's components
Procedure ParseConfigLine( const S: string;
                           var keyName: string;
                           var keyValue: string );

// Removes and returns the first value in a separated
// value list (removes quotes if found)
Function ExtractNextValue( var CSVString: string;
                           const Separator: string ): string;

// Removes spaces around the separator in the given CSV string
Procedure RemoveSeparatorSpaces( var CSVString: string;
                                 const Separator:string );

// Returns true if c is a digit 0..9
Function IsDigit( const c: char ): boolean;

// Returns true if c is an alphabetic character a..z A..Z
Function IsAlpha( const c: char ): boolean;

// Produces a string from n padded on the left with 0's
// to width chars
Function StrLeft0Pad( const n: integer; const width: integer ): string;

// Returns true if s starts with start (case insensitive)
Function StrStarts( const start: string; const s: string ): boolean;

// Returns true if s ends with endstr (case insensitive)
Function StrEnds( const endStr: string; const s: string ): boolean;

// Adds NewValue to S as a separated list
Procedure AddToListString( Var S: string;
                           const NewValue: string;
                           const Separator: string );

Function ListToString( List: TStrings;
                       const Separator: string ): string;

procedure StringToList( S: String;
                        List: TStrings;
                        const Separator: string );

Function StrFirstWord( const S: String ): string;

// Given a string with a number on the end, increments that
// number by one.
// If there is no number it adds a one.
// If the number is left zero padded then the result is similarly
// padded
Function IncrementNumberedString( StartString: string ): string;

{$ifdef os2}
// Right & left trim that works with AnsiStrings.
Function AnsiTrim( const S: AnsiString ): AnsiString;

Procedure AnsiParseConfigLine( const S: Ansistring;
                               var keyName: Ansistring;
                               var keyValue: Ansistring );

Function AnsiExtractNextValue( var CSVString: AnsiString;
                               const Separator: AnsiString ): AnsiString;

{$endif}

// String list functions

// Reverse the given list. It must be set to not sorted
Procedure ReverseList( TheList: TStrings );

// Sort the given list into reverse alphabetical order
//Procedure ReverseSortList( TheList: TStringList );

// Find the given string in the given list, using
// case insensitive searching (and trimming)
// returns -1 if not found
Function FindStringInList( TheString: string; TheList:TStrings ):longint;

Procedure MergeStringLists( Dest: TStringList;
                            AdditionalList: TStringList );


Implementation

Uses
  SysUtils, ACLUtility;

// Hex conversion: sheer extravagance. Conversion from
// a hex digit char to int is done by creating a lookup table
// in advance.
var
  MapHexDigitToInt: array[ Chr( 0 ) .. Chr( 255 ) ] of longint;

procedure InitHexDigitMap;
var
  c: char;
  IntValue: longint;
begin
  for c := Chr( 0 ) to Chr( 255 ) do
  begin
    IntValue := -1;
    if ( c >= '0' )
       and ( c <= '9' ) then
      IntValue := Ord( c ) - Ord( '0' );

    if ( Upcase( c ) >= 'A' )
       and ( Upcase( c ) <= 'F' ) then
      IntValue := 10 + Ord( Upcase( c ) ) - Ord( 'A' );

    MapHexDigitToInt[ c ] := IntValue;
  end;
end;

function HexDigitToInt( c: char ): longint;
begin
  Result := MapHexDigitToInt[ c ];
  if Result = -1 then
    raise EConvertError.Create( 'Invalid hex char: ' + c );
end;

function HexToInt( s: string ): longint;
var
  i: integer;
begin
  if Length( s ) = 0 then
    raise EConvertError.Create( 'No chars in hex string' );
  Result := 0;
  for i:= 1 to Length( s ) do
  begin
    Result := Result shl 4;
    inc( Result, HexDigitToInt( s[ i ] ) );
  end;
end;

{$ifdef os2}
procedure GetMemString( p: pointer;
                        Var s: string;
                        Size: byte );
begin
  S[ 0 ]:= char( size );
  MemCopy( p, Addr( S[ 1 ] ), Size );
end;

procedure FreePString( Var ps: PString );
begin
  if ps = nil then
    exit;

  FreeMem( ps, Length( ps^ ) + 1 );
  ps:= nil;
end;

function NewPString( const s: string ): PString;
begin
  GetMem( Result, Length( S ) + 1 );
  Result^:= S;
end;
{$endif}

Function StringsSame( const a, b: string ): boolean;
begin
  Result:= CompareText( a, b ) = 0;
end;

Function StrDoubleQuote( s: string ): string;
begin
  Result:= '"' + s + '"';
end;

Function SubstituteChar( const S: string; const Find: Char; const Replace: Char ): string;
Var
  i: longint;
Begin
  Result:= S;
  for i:=1 to length( S ) do
    if Result[ i ] = Find then
      Result[ i ]:= Replace;
End;

Function StrRight( const S:string; const count:integer ):string;
Begin
  if count>=length(s) then
  begin
    Result:=S;
  end
  else
  begin
    Result:=copy( S, length( s )-count+1, count );
  end;
end;

Function StrLeft( const S:string; const count:integer ):string;
Begin
  if count>=length(s) then
    Result:=S
  else
    Result:=copy( S, 1, count );
end;

// Returns S minus count characters from the right
Function StrLeftWithout( const S:string; const count:integer ):string;
Begin
  Result:= copy( S, 1, length( S )-count );
End;

Function StrRemoveEnds( const S:string; const leftCount:integer; const rightCount:integer ):string;
Begin
  Result:= S;
  Delete( Result, 1, leftCount );
  Delete( Result, length( S )-rightCount, rightCount );
End;

Function StrRightFrom( const S:string; const start:integer ):string;
Begin
  Result:= copy( S, start, length( S )-start+1 );
end;

Procedure ParseConfigLine( const S: string;
                           var keyName: string;
                           var keyValue: string );
Var
  line: String;
  EqualsPos: longint;
Begin
  KeyName:= '';
  KeyValue:= '';

  line:= trim( S );
  EqualsPos:= Pos( '=', line );

  if ( EqualsPos>0 ) then
  begin
    KeyName:= line;
    Delete( KeyName, EqualsPos, length( KeyName )-EqualsPos+1 );
    KeyName:= Trim( KeyName );

    KeyValue:= line;
    Delete( KeyValue, 1, EqualsPos );
    KeyValue:= Trim( KeyValue );
  end;
end;

Function ExtractNextValue( var CSVString: string;
                           const Separator: string ): string;
Var
  SeparatorPos: integer;
Begin
  SeparatorPos:= Pos( Separator, CSVString );
  if SeparatorPos>0 then
  begin
    Result:= Copy( CSVString, 1, SeparatorPos-1 );
    Delete( CSVString, 1, SeparatorPos + length( Separator ) - 1 );
  end
  else
  begin
    Result:= CSVString;
    CSVString:= '';
  end;
  Result:= trim( Result );
  // Remove qyotes if present
  if Result <> '' then
  if ( Result[1] = chr(34) )
     and ( Result[ length(Result) ] = chr(34) ) then
  begin
    Delete( Result, 1, 1 );
    Delete( Result, length( Result ), 1 );
    // Result:=trim( RemoveEnds( Result, 1, 1 ) );
  end;
end;

Function IsDigit( const c: char ): boolean;
Begin
  Result:=( c>='0' ) and ( c<='9' );
End;

Function IsAlpha( const c: char ): boolean;
var
  UppercaseC: char;
Begin
  UppercaseC := UpCase( c );
  Result := ( UppercaseC >= 'A' ) and ( UppercaseC <= 'Z' );
end;

Function StrLeft0Pad( const n: integer; const width: integer ): string;
Begin
  Result:= IntToStr( n );
  while length( Result )<width do
    Result:= '0' +Result;
End;

// Returns true if s starts with start
{$ifdef win32}
Function StrStarts( const start: string; const s: string ): boolean;
Var
  i: integer;
  p1, p2: pchar;
  p1end: pchar;
  c1, c2: char;
Begin
  Result:= false;
  if length( start ) > length( s ) then
    exit;
  for i:= 1 to length( start ) do
    if UpCase( s[ i ] ) <> UpCase( start[ i ] ) then
      exit;
  Result:= true;
End;

{$else}

Function StrStarts( const start: string; const s: string ): boolean;
Begin
  Asm
  //Locals:
  //START at [EBP+12]
  //S at [EBP+8]

  // First get and check lengths
  MOV ESI,[EBP+12]   // get address of start into ESI
  MOV CL,[ESI]     // get length of start (set remainder of CL to zero)
  MOV EDI,[EBP+8]    // get address of s into EDI
  MOV DL,[EDI]       // get length of s
  CMP CL,DL
  JBE !StartLengthOK

  // start longer than s so false
  MOV EAX, 0
  LEAVE
  RETN32 8

!StartLengthOK:
  INC ESI            // skip ESI past length byte of start string

  // get ending address of start into EDX
  MOV EDX, ESI

  MOVZX ECX, CL      // widen CL 
  ADD EDX, ECX       // ecx is length of start, add to edx

  // get starting address of s
  INC EDI            // skip EDI past length byte of s

  JMP !StartsLoop

!StartsLoopStart:
  MOV AL, [ESI] // get next char of start string
  MOV BL, [EDI] // get next char of string

  // Convert chars to uppercase
  CMP AL,97
  JB !Upcase1
  CMP AL,122
  JA !Upcase1
  SUB AL,32 // convert lower to upper
!Upcase1:

  CMP BL,97
  JB !Upcase2
  CMP BL,122
  JA !Upcase2
  SUB BL,32 // convert lower to upper
!Upcase2:

  // Compare uppercased chars
  CMP AL,BL
  JE !StartsCharMatch
  // different.
  MOV EAX, 0
  LEAVE
  RETN32 8

!StartsCharMatch:
  INC ESI
  INC EDI

!StartsLoop:
  CMP ESI, EDX        // have we reached the end (EDX) of start string
  JB !StartsLoopStart

  // Match, return true
  MOV EAX, 1
  LEAVE
  RETN32 8
  End;
end;
{$endif}

// Returns true if s ends with endstr (case insensitive)
Function StrEnds( const endStr: string; const s: string ): boolean;
Var
  i, j: integer;
Begin
  Result:= false;
  if Length( s ) < length( endStr ) then
    exit;
  j:= Length( s );
  for i:= length( endstr ) downto 1 do
  begin
    if UpCase( s[ j ] ) <> UpCase( endStr[ i ] ) then
      exit;
    dec( j );
  end;
  Result:= true;
End;

Procedure RemoveSeparatorSpaces( var CSVString: string;
                                 const Separator:string );
Var
  SeparatorPos:integer;
  NewString: string;
Begin
  NewString:='';
  while CSVString<>'' do
  begin
    SeparatorPos:=pos( Separator, CSVString );
    if SeparatorPos>0 then
    begin
      NewString:=NewString+trim( copy( CSVString, 1, SeparatorPos-1 ) )+Separator;
      Delete( CSVString, 1, SeparatorPos );
    end
    else
    begin
      NewString:=NewString+trim( CSVString );
      CSVString:='';
    end;
  end;
  CSVString:=NewString;
End;

Procedure AddToListString( Var S: string;
                           const NewValue: string;
                           const Separator: string );
Begin
  if trim( S )<>'' then
    S:=S+Separator;
  S:=S+NewValue;
End;

Function ListToString( List: TStrings;
                       const Separator: string ): string;
Var
  i: longint;
Begin
  Result:= '';
  for i:= 0 to List.Count - 1 do
    AddToListString( Result, List[ i ], Separator );
End;

procedure StringToList( S: String;
                        List: TStrings;
                        const Separator: string );
var
  Item: string;
begin
  List.Clear;
  while S <> '' do
  begin
    Item:= ExtractNextValue( S, Separator );
    List.Add( Item );
  end;
end;

Function StrFirstWord( const S: String ): string;
Var
  SpacePos: longint;
  temp: string;
Begin
  temp:= trimleft( S );
  SpacePos:= pos( ' ', temp );
  if SpacePos>0 then
    Result:= Copy( temp, 1, SpacePos-1 )
  else
    Result:= temp;
End;

Function IncrementNumberedString( StartString: string ): string;
Var
  Number: string;
  NewNumber: string;
  i: integer;
begin
  // Extract any digits at the end of the string
  i:= length( StartString );
  Number:= '';
  while i>0 do
  begin
    if isDigit( StartString[i] ) then
    begin
       Number:= StartString[i] + Number;
       i:= i - 1;
    end
    else
      break;
  end;

  if Number<>'' then
  begin
    // Found a numeric bit to play with
    // Copy the first part
    Result:= StrLeftWithout( StartString, length( Number ) );
    NewNumber:= StrLeft0Pad( StrToInt( Number ) + 1,
                               length( Number ) );
    Result:= Result + NewNumber;
  end
  else
    // No build number, add a 1
    Result:= StartString + '1';
end;

{$ifdef OS2}

Function AnsiTrim( const S: AnsiString ): AnsiString;
Var
  i: longint;
Begin
  i:= 1;
  while i<length( S) do
  begin
    if S[ i ]<>' ' then
      break;
    inc( i );
  end;
  Result:= S;
  if i>1 then
    AnsiDelete( Result, 1, i-1 );
  i:= length( Result );
  while i>=1 do
  begin
    if S[ i ]<>' ' then
      break;
    dec( i );
  end;
  AnsiSetLength( Result, i );
End;

Procedure AnsiParseConfigLine( const S: Ansistring;
                               var keyName: Ansistring;
                               var keyValue: Ansistring );
Var
  line: AnsiString;
  EqualsPos: longint;
Begin
  KeyName:= '';
  KeyValue:= '';

  line:= AnsiTrim( S );
  EqualsPos:= AnsiPos( '=', line );

  if ( EqualsPos>0 ) then
  begin
    KeyName:= AnsiCopy( line, 1, EqualsPos-1 );
    KeyName:= AnsiTrim( KeyName );

    KeyValue:= AnsiCopy( line, EqualsPos+1, length( line )-EqualsPos );
    KeyValue:= AnsiTrim( KeyValue );
  end;
end;

Function AnsiExtractNextValue( var CSVString: AnsiString;
                               const Separator: AnsiString ): AnsiString;
Var
  SeparatorPos: integer;
Begin
  SeparatorPos:= AnsiPos( Separator, CSVString );
  if SeparatorPos>0 then
  begin
    Result:= AnsiCopy( CSVString, 1, SeparatorPos-1 );
    AnsiDelete( CSVString, 1, SeparatorPos + length( Separator ) - 1 );
  end
  else
  begin
    Result:= CSVString;
    CSVString:= '';
  end;
  Result:= AnsiTrim( Result );
  // Remove qyotes if present
  if ( Result[1] = chr(34) )
     and ( Result[ length(Result) ] = chr(34) ) then
  begin
    AnsiDelete( Result, 1, 1 );
    AnsiDelete( Result, length( Result ), 1 );
    Result:= AnsiTrim( Result );
  end;
end;
{$Endif}

Procedure ReverseList( TheList:TStrings );
Var
  TempList: TStringList;
  i: integer;
Begin
  TempList:= TStringList.Create;
  for i:=TheList.count-1 downto 0 do
  begin
    TempList.AddObject( TheList.Strings[i],
                        TheList.Objects[i] );
  end;
  TheList.Assign( TempList );
  TempList.Destroy;
end;

Function FindStringInList( TheString: string; TheList:TStrings ):longint;
Var
  i: longint;
Begin
  for i:=0 to TheList.count-1 do
  begin
    if StringsSame( TheString, TheList[ i ] ) then
    begin
      // found
      Result:=i;
      exit;
    end;
  end;
  Result:=-1;
End;

Procedure MergeStringLists( Dest: TStringList;
                            AdditionalList: TStringList );
var
  i: integer;
  s: string;
begin
  for i:= 0 to AdditionalList.Count - 1 do
  begin
    s:= AdditionalList[ i ];
    if FindStringInList( s, Dest ) = -1 then
      Dest.AddObject( s, AdditionalList.Objects[ i ] );
  end;
end;

Initialization
  InitHexDigitMap;
End.