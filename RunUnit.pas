//-----------------------------------------
//П-панель (DeskHalf), ??.08.03
Unit RunUnit;

Interface

Uses
  Classes, Forms, Graphics, StdCtrls, Buttons, ExtCtrls, Dialogs, SysUtils
  , pdeDlgs, pdeNLS;

Type
  TRunForm = Class (TForm)
    cbFName: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Image1: TImage;
    Button1: TButton;
    Procedure RunFormOnCreate (Sender: TObject);
    Procedure RunFormOnShow (Sender: TObject);
    Procedure BitBtn2OnClick (Sender: TObject);
    Procedure BitBtn1OnClick (Sender: TObject);
    Procedure Label2OnClick (Sender: TObject);
    Procedure RunFormOnTranslateShortCut (Sender: TObject; KeyCode: TKeyCode;
      Var ReceiveR: TForm);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

Var
  RunForm: TRunForm;

Implementation

Uses Unit2;

Procedure TRunForm.RunFormOnCreate (Sender: TObject);
Begin
{  caption := pdeLoadNLS('ppRun', 'Выполнить');
  label1.caption := pdeLoadNLS('ppRunName', 'Имя программы:');
  bitBtn1.caption := pdeLoadNLS('dlgOkButton', 'ОК');
  bitBtn2.caption := pdeLoadNLS('dlgCancelButton', 'Отмена');}
End;

Procedure TRunForm.RunFormOnShow (Sender: TObject);
Begin
  caption := pdeLoadNLS('ppRun', 'Выполнить');
  label1.caption := pdeLoadNLS('ppRunName', 'Имя программы:');
  bitBtn1.caption := pdeLoadNLS('dlgOkButton', 'ОК');
  bitBtn2.caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
  Top:=Screen.Height-Height;
  Left:=Screen.Width-Width;
End;

Procedure TRunForm.BitBtn2OnClick (Sender: TObject);
Begin
  RunForm.Hide;
End;

Procedure TRunForm.BitBtn1OnClick (Sender: TObject);
Begin
if cbFName.Text<>'' then
  begin
    cbFName.Items.Add(cbFName.Text);
    MainForm.ShellExecute(cbFName.Text, extractfilepath(cbFName.Text), '');
  end;
  RunForm.Hide;
End;

Procedure TRunForm.Label2OnClick (Sender: TObject);
Begin
cbFName.Text:=pdeOpenFileDialog(pdeLoadNLS('ppOpenFile', 'Открытие файла'),
  'c:\', pdeLoadNLS('ppPrograms', 'Программы')+' (*.exe;*.com;*.cmd;*.bat)|');
End;

Procedure TRunForm.RunFormOnTranslateShortCut (Sender: TObject;
  KeyCode: TKeyCode; Var ReceiveR: TForm);
Begin
if (keycode=kbEsc) then
  RunForm.Hide;
End;

Initialization
  RegisterClasses ([TRunForm, TComboBox, TBitBtn, TLabel, TImage,
    TButton]);
End.
