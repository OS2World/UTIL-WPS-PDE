(*////////////////////////////////////////////////////
//    PDE -  graphical user shell for OS/2 Warp
//    Copyleft stVova, [PDE-Team], 2003
//    http://os2progg.by.ru/pde
//    FileHalf - "Properties" dialog
/////////////////////////////////////////////////////*)

Unit PropUnit;

Interface

Uses
  Classes, Forms, Graphics, ExtCtrls, Buttons, StdCtrls, SysUtils, TabCtrls,
  PMWin, pdeNLS;

Type
  TPropForm = Class (TForm)
    Notes: TTabbedNotebook;
    chArchiv: TCheckBox;
    chHidden: TCheckBox;
    chSystem: TCheckBox;
    chReadOnly: TCheckBox;
    Bevel1: TBevel;
    Bevel4: TBevel;
    LProg: TLabel;
    LType: TLabel;
    LChDate: TLabel;
    LCreateDate: TLabel;
    LSize: TLabel;
    LDir: TLabel;
    LName: TLabel;
    Shape: TShape;
    Img: TImage;
    btnOK: TButton;
    btnCancel: TButton;
    Procedure LTypeOnClick (Sender: TObject);
    Procedure PropFormOnCreate (Sender: TObject);
    Procedure PropFormOnTranslateShortCut (Sender: TObject; KeyCode: TKeyCode;
      Var ReceiveR: TForm);
    Procedure CancelOnClick (Sender: TObject);
    Procedure OkOnClick (Sender: TObject);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

Var
  PropForm: TPropForm;

Implementation

Uses
  Unit1;

Procedure TPropForm.LTypeOnClick (Sender: TObject);
Begin

End;

Procedure TPropForm.PropFormOnCreate (Sender: TObject);
Begin
  BorderStyle:=bsStealthDlg;
  caption := pdeLoadNLS('popupmenuProperies', 'Свойства');
  Notes.Pages.Pages[0].Caption := pdeLoadNLS('dlgPropertiesFile', 'Файл');
  Notes.Pages.Pages[0].Hint := pdeLoadNLS('dlgPropertiesNotepage1', 'Свойства файла');
  Notes.Pages.Pages[1].Hint := pdeLoadNLS('dlgPropertiesNotepage2', 'Расш. атрибуты');
  Notes.Refresh;
  chSystem.Caption := pdeLoadNLS('dlgPropertiesSystem', 'Системный');
  chHidden.Caption := pdeLoadNLS('dlgPropertiesHidden', 'Скрытый');
  chReadonly.Caption := pdeLoadNLS('dlgPropertiesReadonly', 'Только чтение');
  chArchiv.Caption := pdeLoadNLS('dlgPropertiesArchive', 'Архивный');
  btnOk.Caption := pdeLoadNLS('dlgOkButton', 'ОК');
  btnCancel.Caption := pdeLoadNLS('dlgCancelButton', 'Отмена');

End;

Procedure TPropForm.PropFormOnTranslateShortCut (Sender: TObject;
  KeyCode: TKeyCode; Var ReceiveR: TForm);
Begin
if KeyCode=kbEsc then
  CancelOnClick (Sender);
End;

Procedure TPropForm.CancelOnClick (Sender: TObject);
Begin
  PropForm.Close;
  WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
End;

Procedure TPropForm.OkOnClick (Sender: TObject);
var
  attr: integer;
Begin
attr:=0;
if chSystem.Checked then
  attr:=attr or faSysFile;
if chHidden.Checked then
  attr:=attr or faHidden;
if chReadOnly.Checked then
  attr:=attr or faReadOnly;
if chArchiv.Checked then
  attr:=attr or faArchive;

FileSetAttr(LDir.Caption+LName.Caption, attr);
PropForm.Close;
End;

Uses Unit1;

Initialization
  RegisterClasses ([TPropForm, TBevel, TLabel, TCheckBox,
    TShape, TImage, TTabbedNotebook, TButton]);
End.
