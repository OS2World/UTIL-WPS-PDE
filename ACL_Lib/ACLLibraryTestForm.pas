Unit ACLLibraryTestForm;

Interface

Uses
  Classes, Forms, Graphics, Buttons,
  ACLConstants, ACLFileIOUtility,
  ACLFileUtility, ACLFindFunctions,
  ACLPCharUtility, ACLProfile,
  ACLStringUtility, ACLUtility,
  PCharList,
  StdCtrls;

Type
  TACLLibraryTestForm = Class (TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Procedure ACLLibraryTestFormOnCreate (Sender: TObject);
    Procedure ACLLibraryTestFormOnDestroy (Sender: TObject);
    Procedure ACLLibraryTestFormOnDismissDlg (Sender: TObject);
    Procedure Button1OnClick (Sender: TObject);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

Var
  ACLLibraryTestForm: TACLLibraryTestForm;

Implementation

uses
  ACLString, SysUtils;

Procedure TACLLibraryTestForm.ACLLibraryTestFormOnCreate (Sender: TObject);
Begin
  Memo1.Lines.Add( GetApplicationDir );
End;

Procedure TACLLibraryTestForm.ACLLibraryTestFormOnDestroy (Sender: TObject);
Begin
  CheckAllAStringsDestroyed;
End;

Procedure TACLLibraryTestForm.ACLLibraryTestFormOnDismissDlg (Sender: TObject);
Begin

End;

Procedure TACLLibraryTestForm.Button1OnClick (Sender: TObject);
var
//  T: PChar;
  AString: TAString;
  AString2: TAString;
  a, b: string;
  TheInt: longint;
begin
  MemCopy( Addr( a ), Addr( b ), 256 );
//  T:= Memo1.Lines.GetText;
  AString:= TAString.CreateFromPCharWithDispose( Memo1.Lines.GetText );

  AString2:= TAString.CreateFrom( Edit1.Text );
  AString2.Trim;

  AString.Add( AString2 );

  Memo1.Lines.SetText( AString.AsPChar );

  AString.Destroy;
  AString2.Destroy;

  TheInt := HexToInt( Edit1.Text );
  Memo1.Lines.Add( IntToStr( TheInt ) );

End;

Initialization
  RegisterClasses ([TACLLibraryTestForm, TMemo, TButton, TEdit]);
End.
