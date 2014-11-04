//-----------------------------------------
//Диалог Создание нового обьекта
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
  caption := pdeLoadNLS('pdmCreateCaption', 'Создание обьекта рабочего стола');
  label1.caption := pdeLoadNLS('pdmCreate1', 'Для создания нового обьекта на Рабочем столе ПDE заполните');
  label2.caption := pdeLoadNLS('pdmCreate2', 'форму. Изменения запишутся в файл конфигурации desktop.progs');
  lType.caption := pdeLoadNLS('pdmCreate3', 'Тип (APP/FOLDER)');
  lCaption.caption := pdeLoadNLS('pdmCreate4', 'Текст под пиктограммой');
  lBitmap.caption := pdeLoadNLS('pdmCreate5', 'Пиктограмма (.ico)');
  lCoords.caption := pdeLoadNLS('pdmCreate6', 'Координаты на Рабочем Столе');
  lName.caption := pdeLoadNLS('pdmCreate7', 'Полное Имя (Диск:\Путь\Имя)');
  lPath.caption := pdeLoadNLS('pdmCreate8', 'Путь');
  lParams.caption := pdeLoadNLS('pdmCreate9', 'Параметры запуска');
  lParams1.caption := pdeLoadNLS('pdmCreate10', 'Тип сессии');
  bOk.caption := pdeLoadNLS('dlgOkButton', 'ОК');
  bCancel.caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
End;

Procedure TNewForm.ebPathOnClick (Sender: TObject);
var
  tmpstr: String;
Begin
tmpstr := pdeOpenFileDialog(pdeLoadNLS('ppOpenFile', 'Открытие файла')
  , extractfilepath(application.exename)+'bitmaps\pdm\'
  , pdeLoadNLS('ppPrograms', 'Программы')+' (*.exe;*.com;*.cmd;*.bat)|');

edName.Text:=tmpstr;
edPath.Text:=ExtractFilePath(tmpstr);

End;

Procedure TNewForm.NewFormOnCreate (Sender: TObject);
Begin
{  caption := pdeLoadNLS('pdmCreateCaption', 'Создание обьекта рабочего стола');
  label1.caption := pdeLoadNLS('pdmCreate1', 'Для создания нового обьекта на Рабочем столе ПDE заполните');
  label2.caption := pdeLoadNLS('pdmCreate2', 'форму. Изменения запишутся в файл конфигурации desktop.progs');
  lType.caption := pdeLoadNLS('pdmCreate3', 'Тип (APP/FOLDER)');
  lCaption.caption := pdeLoadNLS('pdmCreate4', 'Текст под пиктограммой');
  lBitmap.caption := pdeLoadNLS('pdmCreate5', 'Пиктограмма (.ico)');
  lCoords.caption := pdeLoadNLS('pdmCreate6', 'Координаты на Рабочем Столе');
  lName.caption := pdeLoadNLS('pdmCreate7', 'Полное Имя (Диск:\Путь\Имя)');
  lPath.caption := pdeLoadNLS('pdmCreate8', 'Путь');
  lParams.caption := pdeLoadNLS('pdmCreate9', 'Параметры запуска');
  lParams1.caption := pdeLoadNLS('pdmCreate10', 'Тип сессии');
  bOk.caption := pdeLoadNLS('dlgOkButton', 'ОК');
  bCancel.caption := pdeLoadNLS('dlgCancelButton', 'Отмена');}

End;

Procedure TNewForm.bCancelOnClick (Sender: TObject);
Begin
  Hide;
End;

Procedure TNewForm.ExplorerButton1OnClick (Sender: TObject);
var
  tmpstr: String;
Begin

tmpstr := pdeOpenFileDialog(pdeLoadNLS('ppChoosePictogram', 'Выберите пиктограмму')
  , extractfilepath(application.exename)+'bitmaps\pdm\'
  , pdeLoadNLS('ppPictograms', 'Пиктограммы')+' (*.ico)|');

    if (pos('bitmaps\pdm\', tmpstr) <> 0) then
      edBitmap.Text := 'bitmaps\pdm\'+ExtractFileName(tmpstr)
    else
      edBitmap.Text := tmpstr;

End;

Procedure TNewForm.bOkOnClick (Sender: TObject);
var
  afile: TextFile;
Begin
//запись нового обьекта в pdm.cfg
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

//добавление на Рабочий Стол
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
