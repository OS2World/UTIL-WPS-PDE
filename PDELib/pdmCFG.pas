//-----------------------------------------
//PDE Desktop, stVova 2003
//Desktop config dialog
//-----------------------------------------
unit pdmCFG;

Interface

Uses Classes, Forms, Graphics, Buttons, ComCtrls, StdCtrls, ExtCtrls
  , pdeNLS ,SysUtils, pdeDlgs, Dos;

Type

TPDMCfgForm = class(TForm)
  FWallpaper: String;
  FColor1: LongInt;
  FColor2: LongInt;
  lWallpaper: TLabel;
  lColor: TLabel;
  lIcons: TLabel;
  lGradient: TLabel;
  iWallpaper: TImage;
  shColor: TShape;
  Bevel1: TBevel;
  Bevel2: TBevel;
  rbCenter: TRadioButton;
  rbStretch: TRadioButton;
  rbTile: TRadioButton;
  rbLU: TRadioButton;
  rbRU: TRadioButton;
  rbLB: TRadioButton;
  rbRB: TRadioButton;
  rbGradient: TRadioButton;
  shGradient: TShape;
  edIcons: TEdit;
  bOK: TButton;
  bCancel: TButton;

  lLanguage: TLabel;
  edLanguage: TEdit;
  lLangChange: TLabel;
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    Constructor Create(AOwner:TComponent); Override;
    Procedure bOKClick (Sender: TObject);
    Procedure bCancelClick (Sender: TObject);
    Procedure iWallClick (Sender: TObject);
    Procedure ColorClick (Sender: TObject);
    Procedure Color2Click (Sender: TObject);
    Procedure lLangChangeClick (Sender: TObject);
  End;

function pdmCfgShow: Integer;

Implementation

//Uses pdmUnit1;

Constructor TPDMCfgForm.Create(AOwner:TComponent);
var
  fnt: TFont;
Begin
Inherited Create(AOwner);

BorderStyle := bsDialog;
BorderIcons := [biSystemMenu, biMinimize];
Font.Name := 'WarpSans:9';
Width := 420;
Height := 430;
Position := poScreenCenter;
Caption := pdeLoadNLS('pdmcfgstr1', 'Рабочий стол - Настройка');

fnt := screen.createcompatiblefont(font);
fnt.attributes := [fabold];

lWallpaper := TLabel.Create(Self);
lWallpaper.Parent := Self;
lWallpaper.Caption := pdeLoadNLS('pdmcfgstr2', 'Фоновый рисунок:');
lWallpaper.Font := fnt; //bold
lWallpaper.Width := 170;
lWallpaper.Left := 8;
lWallpaper.Top := 8;
lWallpaper.Align := alFixedLeftTop;

lColor := TLabel.Create(Self);
lColor.Parent := Self;
lColor.Caption := pdeLoadNLS('pdmcfgstr3', 'Цвет фона:');
lColor.Font := fnt;
lColor.Width := 170;
lColor.Left := 8;
lColor.Top := 160;
lColor.Align := alFixedLeftTop;

lIcons := TLabel.Create(Self);
lIcons.Parent := Self;
lIcons.Caption := pdeLoadNLS('pdmcfgstr4', 'Размер пиктограмм:');
lIcons.Font := fnt;
lIcons.Width := 170;
lIcons.Left := 8;
lIcons.Top := 310;
lIcons.Align := alFixedLeftTop;

//TImage
iWallpaper := TImage.Create(Self);
iWallpaper.Parent := Self;
iWallpaper.Width := 160;
iWallpaper.Height := 120;
iWallpaper.Left := 8;
iWallpaper.Top := 30;
iWallpaper.Align := alFixedLeftTop;
iWallpaper.OnClick := iWallClick;

shColor:=TShape.Create(Self);
shColor.Parent := Self;
shColor.Width := 160;
shColor.Height := 120;
shColor.Left := 8;
shColor.Top := 180;
shColor.Align := alFixedLeftTop;
shColor.OnClick := ColorClick;

Bevel1:=TBevel.Create(Self);
Bevel1.Parent := Self;
Bevel1.Width := 220;
Bevel1.Height := 270;
Bevel1.Left := 180;
Bevel1.Top := 30;
Bevel1.Align := alFixedLeftTop;

//RadioButton
rbCenter:=TRadioButton.Create(Self);
rbCenter.Parent := Self;
rbCenter.Caption := pdeLoadNLS('pdmcfgstr5', 'Расположить по центру');
rbCenter.Width := 200;
rbCenter.Left := 190;
rbCenter.Top := 35;
rbCenter.Align := alFixedLeftTop;

rbStretch:=TRadioButton..Create(Self);
rbStretch.Parent := Self;
rbStretch.Caption := pdeLoadNLS('pdmcfgstr6', 'Растянуть (масштабировать)');
rbStretch.Width := 200;
rbStretch.Left := 190;
rbStretch.Top := 60;
rbStretch.Align := alFixedLeftTop;

rbTile:=TRadioButton..Create(Self);
rbTile.Parent := Self;
rbTile.Caption := pdeLoadNLS('pdmcfgstr7', 'Выложить плиткой');
rbTile.Width := 200;
rbTile.Left := 190;
rbTile.Top := 85;
rbTile.Align := alFixedLeftTop;

rbLU:=TRadioButton..Create(Self);
rbLU.Parent := Self;
rbLU.Caption := pdeLoadNLS('pdmcfgstr8', 'Левый верхний угол');
rbLU.Width := 200;
rbLU.Left := 190;
rbLU.Top := 110;
rbLU.Align := alFixedLeftTop;

rbRU:=TRadioButton..Create(Self);
rbRU.Parent := Self;
rbRU.Caption := pdeLoadNLS('pdmcfgstr9', 'Правый верхний угол');
rbRU.Width := 200;
rbRU.Left := 190;
rbRU.Top := 135;
rbRU.Align := alFixedLeftTop;

rbLB:=TRadioButton..Create(Self);
rbLB.Parent := Self;
rbLB.Caption := pdeLoadNLS('pdmcfgstr10', 'Левый нижний угол');
rbLB.Width := 200;
rbLB.Left := 190;
rbLB.Top := 160;
rbLB.Align := alFixedLeftTop;

rbRB:=TRadioButton..Create(Self);
rbRB.Parent := Self;
rbRB.Caption := pdeLoadNLS('pdmcfgstr11', 'Правый нижний угол');
rbRB.Width := 200;
rbRB.Left := 190;
rbRB.Top := 185;
rbRB.Align := alFixedLeftTop;

rbGradient:=TRadioButton..Create(Self);
rbGradient.Parent := Self;
rbGradient.Caption := pdeLoadNLS('pdmcfgstr12', 'Цветовой переход (градиент)');
rbGradient.Width := 200;
rbGradient.Left := 190;
rbGradient.Top := 210;
rbGradient.Align := alFixedLeftTop;

lGradient:=TLabel.Create(Self);
lGradient.Parent := Self;
lGradient.Caption := pdeLoadNLS('pdmcfgstr13', 'Второй цвет:');
lGradient.Width := 100;
lGradient.Left := 205;
lGradient.Top := 240;
lGradient.Align := alFixedLeftTop;

//TShape
shGradient:=TShape.Create(Self);
shGradient.Parent := Self;
shGradient.Width := 80;
shGradient.Height := 20;
shGradient.Left := 310;
shGradient.Top := 235;
shGradient.OnClick := Color2Click;
//shGradient.Align := alFixedLeftTop;

edIcons:=TEdit.Create(Self);
edIcons.Parent := Self;
edIcons.Width := 100;
edIcons.Left := 180;
edIcons.Top := 305;
edIcons.NumbersOnly := True;
edIcons.Align := alFixedLeftTop;

Bevel2:=TBevel.Create(Self);
Bevel2.Parent := Self;
Bevel2.Shape := bsTopLine;
Bevel2.Width := 390;
Bevel2.Height := 4;
Bevel2.Left := 8;
Bevel2.Top := 355;
Bevel2.Align := alFixedLeftTop;

bOK:=TButton.Create(Self);
bOK.Parent := Self;
bOK.Command := cmOK;
bOK.ModalResult := cmOK;
bOk.Caption := pdeLoadNLS('dlgOkButton', 'OK');
bOK.Width := 100;
bOK.Left := 190;
bOK.Top := 365;
bOK.Default := True;
bOK.Align := alFixedLeftTop;
bOK.OnClick := bOKClick;

bCancel:=TButton.Create(Self);
bCancel.Parent := Self;
bCancel.Command := cmCancel;
bCancel.ModalResult := cmCancel;
bCancel.Caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
bCancel.Width := 100;
bCancel.Left := 300;
bCancel.Top := 365;
bCancel.Align := alFixedLeftTop;
bCancel.OnClick := bCancelClick;

lLanguage := TLabel.Create(Self);
lLanguage.Parent := Self;
lLanguage.Caption := pdeLoadNLS('pdmcfgstr15', 'Файл локализации:');
lLanguage.Font := fnt;
lLanguage.Width := 170;
lLanguage.Left := 8;
lLanguage.Top := 335;
lLanguage.Align := alFixedLeftTop;

edLanguage:= TEdit.Create(Self);
edLanguage.Parent := Self;
edLanguage.Width := 100;
edLanguage.Left := 180;
edLanguage.Top := 330;
edLanguage.Align := alFixedLeftTop;

lLangChange := TLabel.Create(Self);
lLangChange.Parent := Self;
lLangChange.Caption := '[...]';
lLangChange.Width := 30;
lLangChange.Left := 290;
lLangChange.Top := 335;
lLangChange.Align := alFixedLeftTop;
lLangChange.OnClick := lLangChangeClick;

End;

//-----------------------------------------

Procedure TPDMCfgForm.iWallClick (Sender: TObject);
var
  fname: String;
Begin
  fname := pdeOpenFileDialog(pdeLoadNLS('ppOpenFile', 'Открытие файла')
    , 'c:\', pdeLoadNLS('pdmcfgstr14', 'Рисунки')+' (*.bmp)|');
  if fname <> '' then
    begin
    iWallpaper.bitmap.loadfromfile(fname);
    FWallpaper := fname;
    end;
End;

//-----------------------------------------

Procedure TPDMCfgForm.ColorClick (Sender: TObject);
var
  Clr: TColor;
Begin
  if pdeColorDialog(Clr) then
    begin
    shColor.Brush.Color := Clr;
    FColor1 := Clr;
    shColor.Invalidate;
    end;
End;

//-----------------------------------------

Procedure TPDMCfgForm.Color2Click (Sender: TObject);
var
  Clr: TColor;
Begin
  if pdeColorDialog(Clr) then
    begin
    shGradient.Brush.Color := Clr;
    FColor2 := Clr;
    shGradient.Invalidate;
    end;
End;

//-----------------------------------------

Procedure TPDMCfgForm.lLangChangeClick (Sender: TObject);
var
  fname, fpath: String;
Begin
  fpath := getenv('PDE_HOME');
  if fpath = '' then
    fpath := 'c:\pde';
  if fpath[length(fpath)] <> '\' then
    fpath := fpath + '\';
  fpath := fpath + 'Languages\';

  fname := pdeOpenFileDialog(pdeLoadNLS('ppOpenFile', 'Открытие файла')
    , fpath, 'NLS (*.nls)|');

  if fname <> '' then
    begin
    fname := ExtractFileName(fname);
    delete(fname, length(fname)-3, 4);
    edLanguage.Text := fname;
    end;

End;

//-----------------------------------------

Procedure TPDMCfgForm.bOKClick (Sender: TObject);
Begin

End;

//-----------------------------------------

Procedure TPDMCfgForm.bCancelClick (Sender: TObject);
Begin

End;

//-----------------------------------------

function pdmCfgShow: Integer;
var
  pdmCfgForm: TPDMCfgForm;
  tmpstr: String;
  cfgdata: TStringList;
Begin
  try
    pdmCfgForm := TPDMCfgForm.Create(Application.MainForm);
    except
    pdmCfgForm.Free;
    Result := 1;
    exit;
    end;

  tmpstr := pdeLoadCfgStr('pdm.cfg', 'wallpaper');
  pdmCfgForm.FWallpaper := tmpstr;

  try
  if tmpstr[2]=':' then
    begin
    if FileExists(tmpstr) then
      pdmCfgForm.iWallpaper.bitmap.loadfromfile(tmpstr);
    end
    else
    begin
    if FileExists(extractfilepath(application.exename)+tmpstr) then
      pdmCfgForm.iWallpaper.bitmap.loadfromfile(extractfilepath(application.exename)+tmpstr);
    end;

    except

    end;

  pdmCfgForm.shColor.Brush.Color := pdeLoadCfgColor('pdm.cfg', 'desktopcolor');
  pdmCfgForm.shGradient.Brush.Color := pdeLoadCfgColor('pdm.cfg', 'secondcolor');
  pdmCfgForm.FColor1 := pdeLoadCfgColor('pdm.cfg', 'desktopcolor');
  pdmCfgForm.FColor2 := pdeLoadCfgColor('pdm.cfg', 'secondcolor');
  pdmCfgForm.edIcons.Text := pdeLoadCfgStr('pdm.cfg', 'iconsize');
  pdmCfgForm.edLanguage.Text := pdeLoadCfgStr('general.cfg', 'language');

  tmpstr := pdeLoadCfgStr('pdm.cfg', 'wallpaperstyle');

  if tmpstr = 'center' then
    pdmCfgForm.rbCenter.Checked := True
  else if tmpstr = 'tile' then
    pdmCfgForm.rbTile.Checked := True
  else if tmpstr = 'stretch' then
    pdmCfgForm.rbStretch.Checked := True
  else if tmpstr = 'vgradient' then
    pdmCfgForm.rbGradient.Checked := True
  else if tmpstr = 'lefttop' then
    pdmCfgForm.rbLU.Checked := True
  else if tmpstr = 'righttop' then
    pdmCfgForm.rbRU.Checked := True
  else if tmpstr = 'leftbottom' then
    pdmCfgForm.rbLB.Checked := True
  else if tmpstr = 'rightbottom' then
    pdmCfgForm.rbRB.Checked := True;

  Result := 0;

  if pdmCfgForm.ShowModal = cmOK then
    begin
    //save configuration
    if pdmCfgForm.rbCenter.Checked then
      tmpstr := 'center'
    else if pdmCfgForm.rbTile.Checked then
      tmpstr := 'tile'
    else if pdmCfgForm.rbStretch.Checked then
      tmpstr := 'stretch'
    else if pdmCfgForm.rbGradient.Checked then
      tmpstr := 'vgradient'
    else if pdmCfgForm.rbLU.Checked then
      tmpstr := 'lefttop'
    else if pdmCfgForm.rbRU.Checked then
      tmpstr := 'righttop'
    else if pdmCfgForm.rbLB.Checked then
     tmpstr := 'leftbottom'
    else if pdmCfgForm.rbRB.Checked then
      tmpstr := 'rightbottom';

    cfgdata := TStringList.Create;
    cfgdata.Add('//config file of the PDE desktop manager (pdm.exe)');
    cfgdata.Add('iconsize='+pdmCfgForm.edIcons.Text);
    cfgdata.Add('//desktop color');
    //cfgdata.Add('desktopcolor='+IntToStr(pdmCfgForm.shColor.Brush.Color));
    //cfgdata.Add('secondcolor='+IntToStr(pdmCfgForm.shGradient.Brush.Color));
    cfgdata.Add('desktopcolor='+IntToStr(pdmCfgForm.FColor1));
    cfgdata.Add('secondcolor='+IntToStr(pdmCfgForm.FColor2));
    cfgdata.Add('//wallpaper (full path or path from \..\pde\)');
    cfgdata.Add('wallpaper='+pdmCfgForm.FWallpaper);
    cfgdata.Add('//center, tile, stretch, vgradient, lefttop, righttop, leftbottom, rightbottom');
    cfgdata.Add('wallpaperstyle='+tmpstr);
    cfgdata.Add('//Screen-saver application');
    cfgdata.Add('screensaver='+pdeLoadCfgStr('pdm.cfg','screensaver'));
    cfgdata.Add('//Time (msec) for screen-saver');
    cfgdata.Add('savertime='+pdeLoadCfgStr('pdm.cfg', 'savertime'));
    pdeSaveCfgFile('pdm.cfg', cfgdata);
    cfgdata.free;

    cfgdata := TStringList.Create;
    cfgdata.Add('//General preferences for "PDE desktop"');
    cfgdata.Add('//pde_home= <-in config.sys "SET PDE_HOME=C:\PDE" for example');
    cfgdata.Add('//language= <-not in config.sys "SET LANG=ua_ua"');
    cfgdata.Add('language=' + pdmCfgForm.edLanguage.Text);
    cfgdata.Add('//1/0');
    cfgdata.Add('askforshutdown=' + pdeLoadCfgStr('general.cfg', 'askforshutdown'));
    cfgdata.Add('//ask user when delete file or folder');
    cfgdata.Add('askfordelete=' + pdeLoadCfgStr('general.cfg', 'askfordelete'));
    cfgdata.Add('//overwrite destination when copying (moving) files and destination exists');
    cfgdata.Add('overwritefiles=' + pdeLoadCfgStr('general.cfg', 'overwritefiles'));
    cfgdata.Add('//folders paths');
    cfgdata.Add('userhome=' + pdeLoadCfgStr('general.cfg', 'userhome'));
    cfgdata.Add('userdocs=' + pdeLoadCfgStr('general.cfg', 'userdocs'));
    cfgdata.Add('userdrives=' + pdeLoadCfgStr('general.cfg', 'userdrives'));
    cfgdata.Add('userstartup=' + pdeLoadCfgStr('general.cfg', 'userstartup'));
    cfgdata.Add('userprograms=' + pdeLoadCfgStr('general.cfg', 'userprograms'));
    cfgdata.Add('userbookmarks=' + pdeLoadCfgStr('general.cfg', 'userbookmarks'));
    pdeSaveCfgFile('general.cfg', cfgdata);
    cfgdata.free;
    end
    else
    Result := 1;

  if pdmCfgForm<>nil then
    pdmCfgForm.Free;
End;

//-----------------------------------------

Initialization
  RegisterClasses ([TPDMCfgForm]);
End.