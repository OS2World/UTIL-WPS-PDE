//-----------------------------------------
//������ �������� ������ ��쥪�
Unit pdmUnit3;

Interface

Uses
  Classes, Forms, Graphics, Buttons, ExtCtrls, StdCtrls, XplorBtn, SysUtils,
  Dialogs, BSEDos, pdeNLS, pdedlgs;

Type
  TNewForm = Class (TForm)
    bOk: TBitBtn;
    bCancel: TBitBtn;
    Bevel1: TBevel;
    LType: TLabel;
    LCaption: TLabel;
    LBitmap: TLabel;
    LCoords: TLabel;
    LName: TLabel;
    LPath: TLabel;
    LParams: TLabel;
    edText: TEdit;
    edBitmap: TEdit;
    edY: TEdit;
    edName: TEdit;
    edPath: TEdit;
    edParams: TEdit;
    edX: TEdit;
    LPath1: TLabel;
    LPath2: TLabel;
    ExplorerButton1: TExplorerButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel2: TBevel;
    edType: TComboBox;
    edSesType: TEdit;
    LParams1: TLabel;
    ebPath: TExplorerButton;
    Procedure NewFormOnShow (Sender: TObject);
    Procedure ebPathOnClick (Sender: TObject);
    Procedure NewFormOnCreate (Sender: TObject);
    Procedure bCancelOnClick (Sender: TObject);
    Procedure ExplorerButton1OnClick (Sender: TObject);
    Procedure bOkOnClick (Sender: TObject);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

Var
  NewForm: TNewForm;

Implementation

Uses pdmUnit1;

Procedure TNewForm.NewFormOnShow (Sender: TObject);
Begin
  caption := pdeLoadNLS('pdmCreateCaption', '�������� ��쥪� ࠡ�祣� �⮫�');
  label1.caption := pdeLoadNLS('pdmCreate1', '��� ᮧ����� ������ ��쥪� �� ����祬 �⮫� �DE ��������');
  label2.caption := pdeLoadNLS('pdmCreate2', '���. ��������� ��������� � 䠩� ���䨣��樨 desktop.progs');
  lType.caption := pdeLoadNLS('pdmCreate3', '��� (APP/FOLDER)');
  lCaption.caption := pdeLoadNLS('pdmCreate4', '����� ��� ���⮣ࠬ���');
  lBitmap.caption := pdeLoadNLS('pdmCreate5', '���⮣ࠬ�� (.ico)');
  lCoords.caption := pdeLoadNLS('pdmCreate6', '���न���� �� ����祬 �⮫�');
  lName.caption := pdeLoadNLS('pdmCreate7', '������ ��� (���:\����\���)');
  lPath.caption := pdeLoadNLS('pdmCreate8', '����');
  lParams.caption := pdeLoadNLS('pdmCreate9', '��ࠬ���� ����᪠');
  lParams1.caption := pdeLoadNLS('pdmCreate10', '��� ��ᨨ');
  bOk.caption := pdeLoadNLS('dlgOkButton', '��');
  bCancel.caption := pdeLoadNLS('dlgCancelButton', '�⬥��');
End;

Procedure TNewForm.ebPathOnClick (Sender: TObject);
var
  tmpstr: String;
Begin
tmpstr := pdeOpenFileDialog(pdeLoadNLS('ppOpenFile', '����⨥ 䠩��')
  , extractfilepath(application.exename)+'bitmaps\pdm\'
  , pdeLoadNLS('ppPrograms', '�ணࠬ��')+' (*.exe;*.com;*.cmd;*.bat)|');

edName.Text:=tmpstr;
edPath.Text:=ExtractFilePath(tmpstr);

End;

Procedure TNewForm.NewFormOnCreate (Sender: TObject);
Begin
{  caption := pdeLoadNLS('pdmCreateCaption', '�������� ��쥪� ࠡ�祣� �⮫�');
  label1.caption := pdeLoadNLS('pdmCreate1', '��� ᮧ����� ������ ��쥪� �� ����祬 �⮫� �DE ��������');
  label2.caption := pdeLoadNLS('pdmCreate2', '���. ��������� ��������� � 䠩� ���䨣��樨 desktop.progs');
  lType.caption := pdeLoadNLS('pdmCreate3', '��� (APP/FOLDER)');
  lCaption.caption := pdeLoadNLS('pdmCreate4', '����� ��� ���⮣ࠬ���');
  lBitmap.caption := pdeLoadNLS('pdmCreate5', '���⮣ࠬ�� (.ico)');
  lCoords.caption := pdeLoadNLS('pdmCreate6', '���न���� �� ����祬 �⮫�');
  lName.caption := pdeLoadNLS('pdmCreate7', '������ ��� (���:\����\���)');
  lPath.caption := pdeLoadNLS('pdmCreate8', '����');
  lParams.caption := pdeLoadNLS('pdmCreate9', '��ࠬ���� ����᪠');
  lParams1.caption := pdeLoadNLS('pdmCreate10', '��� ��ᨨ');
  bOk.caption := pdeLoadNLS('dlgOkButton', '��');
  bCancel.caption := pdeLoadNLS('dlgCancelButton', '�⬥��');}

End;

Procedure TNewForm.bCancelOnClick (Sender: TObject);
Begin
  Hide;
End;

Procedure TNewForm.ExplorerButton1OnClick (Sender: TObject);
var
  tmpstr: String;
Begin

tmpstr := pdeOpenFileDialog(pdeLoadNLS('ppChoosePictogram', '�롥�� ���⮣ࠬ��')
  , extractfilepath(application.exename)+'bitmaps\pdm\'
  , pdeLoadNLS('ppPictograms', '���⮣ࠬ��')+' (*.ico)|');

    if (pos('bitmaps\pdm\', tmpstr) <> 0) then
      edBitmap.Text := 'bitmaps\pdm\'+ExtractFileName(tmpstr)
    else
      edBitmap.Text := tmpstr;

End;

Procedure TNewForm.bOkOnClick (Sender: TObject);
var
  afile: TextFile;
Begin
//������ ������ ��쥪� � pdm.cfg
assignfile(afile, extractfilepath(application.exename)+'pdeConf\desktop.progs');
reset(afile);
seek(afile, filesize(afile));
writeln(afile);
writeln(afile, edType.Text);
writeln(afile, edText.Text);
writeln(afile, edBitmap.Text);
writeln(afile, edX.Text);
writeln(afile, edY.Text);
writeln(afile, edName.Text);
writeln(afile, edPath.Text);
writeln(afile, edParams.Text);
write(afile, edSesType.Text);
closefile(afile);

Hide;

//���������� �� ����稩 �⮫
inc(diCount);
  di[diCount].di:=TDImage.Create(self);
  di[diCount].di.parent:=MainForm;
  di[diCount].di.width:=pdeLoadCfgInt('pdm.cfg', 'iconsize');
  di[diCount].di.height:=di[diCount].di.width;
  di[diCount].di.num:=diCount;
  di[diCount].di.pict:=formpicture;
  di[diCount].di.OnClick:=MainForm.diOnClick;
  di[diCount].di.OnDblClick:=MainForm.diOnDblClick;
  di[diCount].di.DragMode:=dmAutomatic;
  di[diCount].dc:=TLabel.Create(self);
  di[diCount].dc.parent:=MainForm;

  di[diCount].dtype:=edType.Text;
  di[diCount].dimage:=edBitmap.Text;
  di[diCount].dc.pencolor:=clWhite;
  di[diCount].dc.caption:=edText.Text;

  if (edBitmap.Text[2] = ':') then //full path
      di[diCount].di.icon.loadfromfile(edBitmap.Text)
    else
      di[diCount].di.icon.loadfromfile(extractfilepath(application.exename)+edBitmap.Text);

  di[diCount].di.left:=StrToInt(edX.Text);
  di[diCount].di.top:=StrToInt(edY.Text);
  di[diCount].dc.AutoSize:=True;
  di[diCount].dc.left:=di[diCount].di.left+(di[diCount].di.Width-di[diCount].dc.Width) div 2;
  di[diCount].dc.top:=di[diCount].di.top+di[diCount].di.height+5;
  di[diCount].dname:=edName.Text;
  di[diCount].dpath:=edPath.Text;
  di[diCount].dparam:=edParams.Text;
  di[diCount].ses_type:=StrToInt(edSesType.Text);

End;

Initialization
  RegisterClasses ([TNewForm, TBitBtn, TBevel, TLabel, TEdit, TExplorerButton,
    TComboBox]);
End.
