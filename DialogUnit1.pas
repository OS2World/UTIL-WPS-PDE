(*////////////////////////////////////////////////////
//    PDE -  graphical user shell for OS/2 Warp
//    Copyleft stVova, [PDE-Team], 2003
//    http://os2progg.by.ru/pde
//    FileHalf - copy dialog
/////////////////////////////////////////////////////*)

Unit DialogUnit1;

Interface

Uses
  Classes, Forms, Graphics, Buttons, TabCtrls, StdCtrls
  , pdeNLS, ExtCtrls;

Type
  TdlgCMD = Class (TForm)
    edDest: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edSource: TEdit;
    CancelButton: TButton;
    OkButton: TButton;
    Bevel1: TBevel;
    Procedure dlgCMDOnCreate (Sender: TObject);
    Procedure CancelButtonOnClick (Sender: TObject);
    Procedure OkButtonOnClick (Sender: TObject);
    Procedure dlgCMDOnShow (Sender: TObject);
    Private
      {Insert private declarations here}
    Public
      {Insert public declarations here}
  End;

Var
  dlgCMD: TdlgCMD;

Implementation

Procedure TdlgCMD.dlgCMDOnCreate (Sender: TObject);
Begin
  BorderStyle:=bsStealthDlg;
  label2.caption := pdeLoadNLS('dlgSourceName', 'Исходное имя:');
  label1.caption := pdeLoadNLS('dlgDestName', 'Новое имя:');
  okButton.Caption := pdeLoadNLS('dlgOkButton', 'ОК');
  cancelButton.Caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
End;

Procedure TdlgCMD.CancelButtonOnClick (Sender: TObject);
Begin

End;

Procedure TdlgCMD.OkButtonOnClick (Sender: TObject);
Begin

End;

Procedure TdlgCMD.dlgCMDOnShow (Sender: TObject);
Begin

End;

Initialization
  RegisterClasses ([TdlgCMD, TEdit, TLabel, TButton, TBevel]);
End.
