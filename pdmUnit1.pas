//-----------------------------------------
//pdm - Рабочий Стол ПDE
//Последняя модификация - 15.08.2003
//-----------------------------------------
Unit pdmUnit1;

Interface

Uses
  Classes, Forms, Graphics, StdCtrls, ExtCtrls, Dialogs,
  pmwin, SysUtils, BSEDos, os2def, Messages, pdmUnit2,
  pdmUnit3, Mask, Spin, pdedlgs, pdeNLS, pmgpi, pmdev, pdmCFG;

//Name of the shared memory object
Const
    SharedMemName='DragDrop_ItemsInfo';

//Drag source identification
Const
    DragSourceId='File or Folder to Copy';

Type
    TMainForm = Class (TForm)
    PopupMenu1: TPopupMenu; //меню Рабочего стола
    Timer1: TTimer;         //прячет свернутые окна
    imgNone: TImage;        //рисунок для обьекта Раб.Стола, если тот не загрузит свой
    imgLogOn: TImage;
    mGroupIcons: TMenuItem;
    mCmd: TMenuItem;
    mOS2window: TMenuItem;
    mOS2fullscreen: TMenuItem;
    mDOSwindow: TMenuItem;
    mWINwindow: TMenuItem;
    MenuItem11: TMenuItem;
    mDOSfullscreen: TMenuItem;
    MenuItem12: TMenuItem;
    mWINfullscreen: TMenuItem;
    mReloadSettings: TMenuItem;
    MenuItem1: TMenuItem;
    mAbout: TMenuItem;
    mAlignIcons: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem4: TMenuItem;
    mNew: TMenuItem;
    MenuItem3: TMenuItem;
    mShootSystem: TMenuItem;
    mNewObject: TMenuItem;
    MenuItem8: TMenuItem;
    mSetup: TMenuItem;
    mScreenSaver: TMenuItem;
    mRefresh: TMenuItem;

    Procedure MainFormOnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X: LongInt; Y: LongInt);
    Procedure MainFormOnKeyPress (Sender: TObject; Var key: Char);
    Procedure mGroupIconsOnClick (Sender: TObject);
    Procedure mOS2windowOnClick (Sender: TObject);
    Procedure mOS2fullscreenOnClick (Sender: TObject);
    Procedure mDOSwindowOnClick (Sender: TObject);
    Procedure mDOSfullscreenOnClick (Sender: TObject);
    Procedure mWINwindowOnClick (Sender: TObject);
    Procedure mWINfullscreenOnClick (Sender: TObject);
    Procedure mReloadSettingsOnClick (Sender: TObject);
    Procedure mAlignIconsOnClick (Sender: TObject);
    Procedure MenuItem5OnClick (Sender: TObject);
    Procedure MainFormOnCloseQuery (Sender: TObject; Var CanClose: Boolean);
    Procedure MainFormOnTranslateShortCut (Sender: TObject; KeyCode: TKeyCode;
      Var ReceiveR: TForm);
    Procedure mNewObjectOnClick (Sender: TObject);
    Procedure MainFormOnCreate (Sender: TObject);
    Procedure MainFormOnClick (Sender: TObject);
    Procedure mPropertiesOnClick (Sender: TObject);
    Procedure MenuItem9OnClick (Sender: TObject);
    Procedure MenuItem10OnClick (Sender: TObject);
    Procedure mShootSystemOnClick (Sender: TObject);
    Procedure MainFormOnDestroy (Sender: TObject);
    Procedure MainFormOnPaint (Sender: TObject; Const rec: TRect);
    Procedure mRefreshOnClick (Sender: TObject);

    Procedure imgOnClick (Sender: TObject);
    Procedure imgOnDragDrop (Sender: TObject; Source: TObject; X: LongInt; Y: LongInt);
    Procedure imgOnDragOver (Sender: TObject; Source: TObject; X: LongInt; Y: LongInt; State: TDragState; Var Accept: Boolean);
    Procedure Timer1OnTimer (Sender: TObject);
    Procedure MainFormOnShow (Sender: TObject);

    Procedure diOnDblClick (Sender: TObject); //для DesktopItema
    Procedure diOnClick (Sender: TObject);
    Procedure lnRebootOnClick (Sender: TObject);
    Procedure lnOKOnClick (Sender: TObject);
  Private
    {Insert private declarations here}
  Protected
    Procedure MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongInt);Override;
  Public
    {Insert public declarations here}
    function ShellExecute(fname, fdir, fparam: string; ses_type: Word; shortcut: boolean): Boolean;
  End;

  TDragDropItem=Record
    Len:Byte;         //length of string
    Data:Array[0..0] Of Char;
  End;

  PDragDropInfo=^TDragDropInfo;

  TDragDropInfo=Record
    Count:LongWord;   //Count of elements
    Items:Array[0..0] Of TDragDropItem;
  End;

  TDImage = class (TImage)
    Protected
      Procedure MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongInt);Override;
    Public
      Procedure Redraw(Const rec:TRect);override;
      selected: boolean;
      num: integer;
      pict: TPicture;
  End;

  TLogOnForm = Class (TForm)
    Procedure LogOnFormOnShow (Sender: TObject);

  end;

  TDesktopItem = record
    di: TDImage;
    dc: TLabel;
    dimage: string;
    dtype: string;
    dname: string;
    dpath: string;
    dparam: string;
    ses_type: Word;
  end;
  {
  TDesktopItem2 = record
    di: TIcon;
    dc: String;
    x: Integer;
    y: Integer;
    selected: Boolean;
    dimage: string;
    dtype: string;
    dname: string;
    dpath: string;
    dparam: string;
    ses_type: Word;
  end;
  }
Var
  //new_item: TDesktopItem2;

  MainForm: TMainForm;
  formpicture: TPicture;
  secondcolor: TColor;
  formbitmap: TBitmap;
  di: array[1..44] of TDesktopItem;
  diCount: integer;
  wallpaper, wallpaperstyle, screensaver: string;
  savertime, idletime: ULong;
  wallpaper_present: Boolean;
  prev_x, prev_y: Integer;

  //log on
  LogOnForm: TLogOnForm;
  lnImage: TImage;
  lnLabel: TLabel;
  lnUserName: TEdit;
  lnPassword: TEdit;
  lnOk: TLabel;
  lnReboot: TLabel;

  Needlogon, LoggedOn: Boolean;
  pwd, user: String;

Implementation

Procedure TMainForm.MainFormOnMouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X: LongInt; Y: LongInt);
Begin
{  if (x > new_item.x) and (x < new_item.x + new_item.di.width)
    and (y > new_item.y) and (y < new_item.y + new_item.di.height) then
      new_item.selected := True
  else
      new_item.selected := False;}
End;

Procedure TMainForm.MainFormOnTranslateShortCut (Sender: TObject;
  KeyCode: TKeyCode; Var ReceiveR: TForm);
Begin

End;

Procedure TMainForm.MainFormOnKeyPress (Sender: TObject; Var key: Char);
Begin

End;

//-----------------------------------------
//командные строки (консоли)

Procedure TMainForm.mOS2windowOnClick (Sender: TObject);
Begin
//OS/2 VIO
  ShellExecute('cmd.exe', '', '', 2, true);
End;

Procedure TMainForm.mOS2fullscreenOnClick (Sender: TObject);
Begin
//OS/2
  ShellExecute('cmd.exe', '', '', 1, true);
End;

Procedure TMainForm.mDOSwindowOnClick (Sender: TObject);
Begin
//VDM window
  ShellExecute('command.com', '', '', 7, true);
End;

Procedure TMainForm.mDOSfullscreenOnClick (Sender: TObject);
Begin
//VDM
  ShellExecute('command.com', '', '', 4, true);
End;

Procedure TMainForm.mWINwindowOnClick (Sender: TObject);
Begin
//seamless WIN window
  ShellExecute('win.com', '', '', 7, true);
End;

Procedure TMainForm.mWINfullscreenOnClick (Sender: TObject);
Begin
//seamless WIN
  ShellExecute('winos2.com', '', '', 4, true);
End;
//-----------------------------------------

//-----------------------------------------
//перезагрузка файла конфигурации
Procedure TMainForm.mReloadSettingsOnClick (Sender: TObject);
var
  afile: TextFile;
  fcapt: string;
  //fcolor: longint;
  flt: integer;
  //rez: integer;
  //sr: TSearchRec;
  i: integer;
//  tmppict: TBitmap;
Begin

if diCount>0 then
  for i:=1 to diCount do
    begin
    di[i].di.free;
    di[i].dc.free;
    end;

diCount:=0;
wallpaper_present := false;
//formpicture.free;
//if formpicture = nil then
//  formpicture:=TPicture.Create(MainForm); //рисунок фона
  //tmppict := TBitmap.Create;

//desktop color
mainform.color := pdeLoadCfgColor('pdm.cfg', 'desktopcolor');
secondcolor := pdeLoadCfgColor('pdm.cfg', 'secondcolor');
//desktop image
wallpaper := pdeLoadCfgStr('pdm.cfg', 'wallpaper');
wallpaperstyle := 'stretch';
wallpaperstyle := pdeLoadCfgStr('pdm.cfg', 'wallpaperstyle');
if (wallpaperstyle <> 'vgradient') then
  begin
  if fileexists(wallpaper) or fileexists(extractfilepath(application.exename)+wallpaper) then
    begin
    try
      if (wallpaper[2] = ':') then
        formpicture.bitmap.loadfromfile(wallpaper)
      else
        formpicture.bitmap.loadfromfile(extractfilepath(application.exename)+wallpaper);
      //tmppict.loadfromfile(wallpaper);

      except
      formpicture.free;
      //tmppict.free;
      wallpaper_present:=false;
      end;
    //formpicture.bitmap.width:=MainForm.Width;
    //formpicture.bitmap.height:=MainForm.Height;
    //formpicture.bitmap.canvas.stretchdraw(0, 0, MainForm.Width, MainForm.Height, tmppict);
    //MainForm.canvas.draw(0, 0, formpicture.graphic);
    //MainForm.canvas.stretchdraw(0, 0, MainForm.Width, MainForm.Height, formpicture.graphic);
    wallpaper_present:=true;
    end
  else
    begin
    formpicture.free;
    //tmppict.free;
    wallpaper_present:=false;
    end;
  end;
  //tmppict.free;
//screensaver
screensaver := pdeLoadCfgStr('pdm.cfg', 'screensaver');
//time for screensaver
savertime := pdeLoadCfgInt('pdm.cfg', 'savertime');

assignfile(afile, extractfilepath(application.exename)+'PDEConf\desktop.progs');
reset(afile);
readln(afile);readln(afile);

//MessageBox('Вxод в цикл', mtInformation, [mbOK]);

while not(eof(afile)) do
  Begin
  inc(diCount);
  //if di[diCount].di=nil then
    di[diCount].di:=TDImage.Create(self);
  di[diCount].di.parent:=MainForm;
  di[diCount].di.width:=pdeLoadCfgInt('pdm.cfg','iconsize');
  di[diCount].di.height:=di[diCount].di.width;
  di[diCount].di.num:=diCount;
  if wallpaper_present then
    di[diCount].di.pict:=formpicture
  else
    di[diCount].di.pict:=nil;
  di[diCount].di.OnClick:=diOnClick;
  di[diCount].di.OnDblClick:=diOnDblClick;
  di[diCount].di.DragMode:=dmAutomatic;
  //if di[diCount].dc=nil then
    di[diCount].dc:=TLabel.Create(self);
  di[diCount].dc.parent:=MainForm;
  di[diCount].dc.PenColor:=clWhite;//not(MainForm.Color);

  readln(afile, di[diCount].dtype);
  readln(afile, fcapt);
  di[diCount].dc.caption:=fcapt;
  readln(afile, di[diCount].dimage);
  try
    if (di[diCount].dimage[2] = ':') then
      di[diCount].di.picture.{icon.}loadfromfile(di[diCount].dimage)
    else
      di[diCount].di.picture.{icon.}loadfromfile(extractfilepath(application.exename)+di[diCount].dimage);
  except
    di[diCount].di.bitmap:=imgNone.Picture.bitmap;
    end;
  readln(afile, flt);
  di[diCount].di.left:=flt;
  readln(afile, flt);
  di[diCount].di.top:=flt;

  di[diCount].dc.AutoSize:=True;
  di[diCount].dc.left:=di[diCount].di.left+(di[diCount].di.Width-di[diCount].dc.Width) div 2;
  di[diCount].dc.top:=di[diCount].di.top+di[diCount].di.height+5;

  readln(afile, di[diCount].dname);
  readln(afile, di[diCount].dpath);
  readln(afile, di[diCount].dparam);  //параметры запуска (необязательно)
  di[diCount].ses_type:=0;
  readln(afile, di[diCount].ses_type); //тип сессии (необязательно)
//  MessageBox('Загружено '+IntToStr(diCount), mtInformation, [mbOK]);
  End;
closefile(afile);

//--reload language--
caption := pdeLoadNLS('pdeDesktop', 'Рабочий стол');
mRefresh.caption := pdeLoadNLS('RefreshButton', 'Обновить');
mAlignIcons.caption := pdeLoadNLS('pdmAlignIcons', 'Выровнять значки');
mGroupIcons.caption := pdeLoadNLS('pdmGroupIcons', 'Упорядочить значки');
mSetup.caption := pdeLoadNLS('pdmSetup', 'Свойства');
mReloadSettings.caption := pdeLoadNLS('pdmReloadCfg', 'Обновить настройки');
mScreenSaver.caption := pdeLoadNLS('pdmScreenSaver', 'Хранитель экрана');
mShootSystem.caption := pdeLoadNLS('pdmShutdown', 'Закрыть систему');
mNew.caption := pdeLoadNLS('menuCreateNew', 'Создать новый');
mNewObject.caption := pdeLoadNLS('pdmObject', 'Обьект');
mCmd.caption := pdeLoadNLS('pdmCommandWindow', 'Командная строка');
mOS2window.caption := pdeLoadNLS('pdmOS2win', 'OS/2-окно');
mOS2fullscreen.caption := pdeLoadNLS('pdmOS2full', 'OS/2-сессия');
mDOSwindow.caption := pdeLoadNLS('pdmDOSwin', 'DOS-окно');
mDOSfullscreen.caption := pdeLoadNLS('pdmDOSfull', 'DOS-сессия');
mWINwindow.caption := pdeLoadNLS('pdmWINwin', 'Win-окно');
mWINfullscreen.caption := pdeLoadNLS('pdmWINfull', 'Win-сессия');
mAbout.caption := pdeLoadNLS('menuAbout', 'Информация о продукте');

End;
//--mReloadSettings-------------------------

Procedure TMainForm.mAlignIconsOnClick (Sender: TObject);
var
  isize, i, dx, dy: integer;
Begin
  //выравнивание значков iconsize х 2
  isize := pdeLoadCfgInt('pdm.cfg', 'iconsize');
if diCount>0 then
  for i:=1 to diCount do
    begin
    dx:=di[i].di.left mod isize*2;
    if dx>isize then
      di[i].di.left:=di[i].di.left+isize*2-dx
      else
      di[i].di.left:=di[i].di.left-dx;
    if di[i].di.left<isize then di[i].di.left:=isize;
    dy:=di[i].di.top mod isize*2;
    if dy>isize then
      di[i].di.top:=di[i].di.top+isize*2-dy
      else
      di[i].di.top:=di[i].di.top-dy;
    if di[i].di.top<isize then di[i].di.top:=isize;

    di[i].dc.left:=di[i].di.left+(di[i].di.Width-di[i].dc.Width) div 2;
    di[i].dc.top:=di[i].di.top+di[i].di.height+5;
    di[i].di.Refresh;
    end;
End;

Procedure TMainForm.mGroupIconsOnClick (Sender: TObject);
var
  isize, i, j, h: Integer;
Begin
//упорядочить значки
isize := pdeLoadCfgInt('pdm.cfg', 'iconsize');
h:=Screen.Height-Screen.Height mod isize*2;
j:=0;

if diCount>0 then
  for i:=1 to diCount do
    begin
    if (i*isize*2-j*h)>=h then
      inc(j);
    di[i].di.top:=i*isize*2-j*h;
    di[i].di.left:=isize+j*isize*2;

    di[i].dc.left:=di[i].di.left+(di[i].di.Width-di[i].dc.Width) div 2;
    di[i].dc.top:=di[i].di.top+di[i].di.height+5;
    di[i].di.Refresh;
    end;
End;

Procedure TMainForm.MenuItem5OnClick (Sender: TObject);
var
  about, authors, thanks: TStringList;
  cptn, text, licensefile: String;
  logo: Pointer;
  prms: array[1..24] of ULONG;
  sz: integer;
Begin
//product information
//отображает окно с информацией о компе.
sz:=SizeOf(prms[1]);
//prms[1]:=WinQuerySysValue(HWND_DESKTOP, SV_ANIMATION);
//prms[2]:=WinQuerySysValue(HWND_DESKTOP, SV_CTIMERS);//count of timers available
//prms[3]:=WinQuerySysValue(HWND_DESKTOP, SV_CMOUSEBUTTONS); //mouse buttons count
//prms[4]:=WinQuerySysValue(HWND_DESKTOP, SV_SWAPBUTTON); //swap mouse btns
//prms[5]:=WinQuerySysValue(HWND_DESKTOP, SV_CXICON); //icon size
prms[6]:=WinQuerySysValue(HWND_DESKTOP, SV_CXSCREEN); //screen.width
prms[7]:=WinQuerySysValue(HWND_DESKTOP, SV_CYSCREEN);
//DosQuerySysInfo(QSV_MAX_PATH_LENGTH, QSV_MAX_PATH_LENGTH,     prms[8], sz);
//DosQuerySysInfo(QSV_MAX_TEXT_SESSIONS, QSV_MAX_TEXT_SESSIONS, prms[9], sz);
//DosQuerySysInfo(QSV_MAX_PM_SESSIONS, QSV_MAX_PM_SESSIONS,     prms[10], sz);
//DosQuerySysInfo(QSV_MAX_VDM_SESSIONS, QSV_MAX_VDM_SESSIONS,   prms[11], sz);
DosQuerySysInfo(QSV_BOOT_DRIVE, QSV_BOOT_DRIVE,               prms[12], sz);
//DosQuerySysInfo(QSV_MAX_WAIT, QSV_MAX_WAIT,                   prms[13], sz);
//DosQuerySysInfo(QSV_MIN_SLICE, QSV_MIN_SLICE,                 prms[14], sz);
//DosQuerySysInfo(QSV_MAX_SLICE, QSV_MAX_SLICE,                 prms[15], sz);
DosQuerySysInfo(QSV_VERSION_MAJOR, QSV_VERSION_MAJOR,         prms[16], sz);
DosQuerySysInfo(QSV_VERSION_MINOR, QSV_VERSION_MINOR,         prms[17], sz);
DosQuerySysInfo(QSV_VERSION_REVISION, QSV_VERSION_REVISION,   prms[18], sz);
//DosQuerySysInfo(QSV_MS_COUNT, QSV_MS_COUNT,                   prms[19], sz);
DosQuerySysInfo(QSV_TOTPHYSMEM, QSV_TOTPHYSMEM,               prms[20], sz);
DosQuerySysInfo(QSV_TOTRESMEM, QSV_TOTRESMEM,                 prms[21], sz);
DosQuerySysInfo(QSV_TOTAVAILMEM, QSV_TOTAVAILMEM,             prms[22], sz);
//DosQuerySysInfo(QSV_TIMER_INTERVAL, QSV_TIMER_INTERVAL,       prms[23], sz);

{MessageBox('OS/2 Warp '+floattostrf(prms[17]/10, ffFixed, 2, 1)+' ( '+inttostr(prms[16])+'.'+inttostr(prms[17])+' )'+chr(13)+chr(10)+
           chr(13)+chr(10)+
           'Папка: '+chr(64+prms[12])+':\OS2\'+chr(13)+chr(10)+
           'Память: '+inttostr(prms[20] div (1024*1024))+'Мб'+chr(13)+chr(10)+
           'Видео: '+inttostr(prms[6])+'x'+inttostr(prms[7])+chr(13)+chr(10)+
           chr(13)+chr(10)+
           'Размер кванта времени: '+inttostr(prms[14])+'-'+inttostr(prms[15])+'мсек'+chr(13)+chr(10)+
           'Максимум PM сессий: '+inttostr(prms[10])+chr(13)+chr(10)+
           'Максимум CMD сессий: '+inttostr(prms[9])+chr(13)+chr(10)+
           'Максимум DOS сессий: '+inttostr(prms[11])+chr(13)+chr(10)+
           chr(13)+chr(10)+
           'Интервал таймера: '+floattostrf(prms[23]/1000, ffFixed, 3, 3)+'мсек'+chr(13)+chr(10)+
           'Максимум таймеров: '+inttostr(prms[2])+chr(13)+chr(10)
           ,mtInformation, [mbOK]);}
//Информация о продукте
  about := TStringList.Create;
  about.Add('');
  about.Add(pdeLoadNLS('pdeName',' Полумух Desktop Environment')+' v.0.06');
  about.Add('');
  about.Add(pdeLoadNLS('pdeDescription1', 'Графическая оболочка пользователя для'));
  about.Add(pdeLoadNLS('pdeDescription2', 'операционных систем OS/2 Warp и eCS'));
  about.Add('');
  about.Add('OS/2 Warp '+floattostrf(prms[17]/10, ffFixed, 2, 1)+' ( '+inttostr(prms[16])+'.'+inttostr(prms[17])+' )');
  about.Add(pdeLoadNLS('pdeDescription8', 'Системная папка:')+' '+chr(64+prms[12])+':\OS2\');
  about.Add(pdeLoadNLS('pdeDescription9', 'Физическая память:')+' '+inttostr(prms[20] div (1024*1024))+'Мб');
  about.Add(pdeLoadNLS('pdeDescription10', 'Видеорежим:')+' '+inttostr(prms[6])+'x'+inttostr(prms[7]));
//pdeLoadNLS('', '')
  authors := TStringList.Create;
  authors.Add('');
  authors.Add(pdeLoadNLS('pdeAuthors1.1', 'Сергеев Владимир, stVova'));
  authors.Add('');
  authors.Add(pdeLoadNLS('pdeAuthors1.2', 'pазpаботчик'));
  authors.Add(pdeLoadNLS('pdeAuthors1.3', 'программирование, дизайн'));
  authors.Add(pdeLoadNLS('pdeAuthors1.4', 'stVova@ukrpost.com.ua'));
  thanks := TStringList.Create;
  thanks.Add('');
  thanks.Add(pdeLoadNLS('pdeThanks1.1', 'Сергеев Сергей, SERG'));
  thanks.Add('');
  thanks.Add(pdeLoadNLS('pdeThanks1.2', 'брат'));
  thanks.Add(pdeLoadNLS('pdeThanks1.3', 'критика и идеи'));
  thanks.Add(pdeLoadNLS('pdeThanks1.4', 'e-Mail отсутствует'));
  thanks.Add('');
  thanks.Add('KDE Team for graphics and icons');
  thanks.Add('www.kde.org');
  thanks.Add('');
  thanks.Add('GNOME Team for graphics and icons');
  thanks.Add('www.gnome.org');
  cptn := pdeLoadNLS('dlgAboutProgram', 'Информация о продукте');
  text := pdeLoadNLS('pdeDesktop', 'Рабочий стол');
  licensefile := 'c:\pde\copying';
  logo := MainForm.Icon;
  pdeAboutDialog(about, authors, thanks, cptn, text, licensefile, logo);
End;

Procedure TMainForm.MainFormOnCloseQuery (Sender: TObject; Var CanClose: Boolean);
var
  afile: TextFile;
  i: Integer;
Begin
if LoggedOn then
  Begin

Assignfile(afile, extractfilepath(application.exename)+'PDEConf\desktop.progs');
Rewrite(afile);
Writeln(afile, '//Objects on the Desktop, format of record is:');
Write(afile, '//type, caption, icon (full path or path from \..\pde\), X, Y, filename, path, parameters');
if diCount>0 then
for i:=1 to diCount do
  begin
  Writeln(afile);
  Writeln(afile, di[i].dtype);
  Writeln(afile, di[i].dc.caption);
  Writeln(afile, di[i].dimage);
  Writeln(afile, di[i].di.left);
  Writeln(afile, di[i].di.top);
  Writeln(afile, di[i].dname);
  Writeln(afile, di[i].dpath);
  Writeln(afile, di[i].dparam);
  Write(afile, di[i].ses_type);
  end;

  Closefile(afile);
End;
CanClose:=True;
End;

Procedure TMainForm.mNewObjectOnClick (Sender: TObject);
Begin
//создание нового значка на рабочем столе
NewForm.Show;
NewForm.BringToFront;
End;

Procedure TMainForm.MainFormOnCreate (Sender: TObject);
var
  afile: TextFile;
Begin
//
LogOnForm:=TLogOnForm.Create(Self);
LogOnForm.Caption:=pdeLoadNLS('pdmLogonCaption', 'Вход в системму'); //pdeLoadNLS('', '');
LogOnForm.BorderIcons:=[];
LogOnForm.BorderStyle:=bsStealthDlg;//bsDialog;
LogOnForm.ClientWidth:=365;
LogOnForm.ClientHeight:=105;
LogOnForm.Position:=poScreenCenter; LogOnForm.Font.Name:='WarpSans:9';
LogOnForm.Color:=12632256;

lnImage:=TImage.Create(LogOnForm);
lnImage.Parent:=LogOnForm;
lnImage.Width:=96; lnImage.Height:=82;
lnImage.Left:=7; lnImage.Top:=7;
lnImage.Align:=alFixedLeftTop;
lnImage.Bitmap:=imgLogOn.Bitmap;

lnLabel:=TLabel.Create(LogOnForm);
lnLabel.Parent:=LogOnForm;
lnLabel.Left:=115; lnLabel.Top:=7;
lnImage.Align:=alFixedLeftTop;
lnLabel.Font.Name:='WarpSans Bold:9';
lnLabel.Caption:=pdeLoadNLS('pdmLogonText', 'Введите имя пользователя и пароль');
lnLabel.AutoSize:=True;

lnUserName := TEdit.Create(LogOnForm);
lnUserName.Parent:=LogOnForm;
lnUserName.BorderStyle:=bsNone;
lnUserName.Left:=115; lnUserName.Top:=31;
lnImage.Align:=alFixedLeftTop;
lnUserName.Width:=235;

lnPassword := TEdit.Create(LogOnForm);
lnPassword.Parent:=LogOnForm;
lnPassword.Unreadable:=True;
lnPassword.BorderStyle:=bsNone;
lnPassword.Left:=115; lnPassword.Top:=56;
lnImage.Align:=alFixedLeftTop;
lnPassword.Width:=235;

lnOk := TLabel.Create(LogOnForm);
lnOk.Parent:=LogOnForm;
lnOk.Left:=115; lnOk.Top:=80;
lnImage.Align:=alFixedLeftTop;
lnOk.Font.Name:='SystemVIO:16'; lnOk.Caption:=pdeLoadNLS('pdmLogonOK', '[OK]');
lnOk.AutoSize:=True;
lnOk.OnClick:=lnOKOnClick;

lnReboot := TLabel.Create(LogOnForm);
lnReboot.Parent:=LogOnForm;
lnReboot.Left:=160; lnReboot.Top:=80;
lnImage.Align:=alFixedLeftTop;
lnReboot.Caption:=pdeLoadNLS('pdmLogonReboot', '[Перезагрузка]');
lnReboot.Font.Name:='SystemVIO:16';
lnReboot.AutoSize:=True;
lnReboot.OnClick:=lnRebootOnClick;

LoggedOn:=True;
If fileexists(extractfilepath(application.exename)+'PDEConf\pswd.cfg') then
  Begin
  Assignfile(afile, extractfilepath(application.exename)+'PDEConf\pswd.cfg');
  Reset(afile);
  Readln(afile, user);
  Readln(afile, pwd);
  CloseFile(afile);
  LogOnForm.ActiveControl:=lnUserName;
  LoggedOn:=False;
  logOnForm.ShowModal;
  logOnForm.BringToFront;
  End;
if not(LoggedOn) then
  Application.Terminate;

//
if FileExists(ExtractFilePath(Application.Exename)+'\Utils\pdelogo.exe') then
  ShellExecute(ExtractFilePath(Application.Exename)+'\Utils\pdelogo.exe', ExtractFilePath(Application.Exename),
    pdeLoadNLS('OS2_IS_UP_AND_RUNNING', 'Ваша OS/2 система загружена и готова к работе') , 0, false);
//
caption := pdeLoadNLS('pdeDesktop', 'Рабочий стол');
mRefresh.caption := pdeLoadNLS('RefreshButton', 'Обновить');
mAlignIcons.caption := pdeLoadNLS('pdmAlignIcons', 'Выровнять значки');
mGroupIcons.caption := pdeLoadNLS('pdmGroupIcons', 'Упорядочить значки');
mSetup.caption := pdeLoadNLS('pdmSetup', 'Свойства');
//mProperties.caption := pdeLoadNLS('pdmConfigFile', 'Файл конфигурации');
mReloadSettings.caption := pdeLoadNLS('pdmReloadCfg', 'Обновить настройки');
mScreenSaver.caption := pdeLoadNLS('pdmScreenSaver', 'Хранитель екрана');
mShootSystem.caption := pdeLoadNLS('pdmShutdown', 'Закрыть систему');
mNew.caption := pdeLoadNLS('menuCreateNew', 'Создать новый');
mNewObject.caption := pdeLoadNLS('pdmObject', 'Обьект');
mCmd.caption := pdeLoadNLS('pdmCommandWindow', 'Командная строка');
mOS2window.caption := pdeLoadNLS('pdmOS2win', 'OS/2-окно');
mOS2fullscreen.caption := pdeLoadNLS('pdmOS2full', 'OS/2-сессия');
mDOSwindow.caption := pdeLoadNLS('pdmDOSwin', 'DOS-окно');
mDOSfullscreen.caption := pdeLoadNLS('pdmDOSfull', 'DOS-сессия');
mWINwindow.caption := pdeLoadNLS('pdmWINwin', 'Win-окно');
mWINfullscreen.caption := pdeLoadNLS('pdmWINfull', 'Win-сессия');
mAbout.caption := pdeLoadNLS('menuAbout', 'Информация о продукте');

End;

Procedure TMainForm.MainFormOnClick (Sender: TObject);
var
  i: integer;
Begin
if diCount>0 then
  for i:=1 to diCount do
    begin
    if (di[i].di.selected) then di[i].di.selected:=false;
    di[i].di.Refresh;
    di[i].dc.Refresh;
    end;
End;

Procedure TMainForm.mPropertiesOnClick (Sender: TObject);
Begin
//открытие файла конфигурации Рабочего Стола
//  ShellExecute('e.exe', '', extractfilepath(application.exename)+'pdeConf\pdm.cfg', 0, false);
End;

Procedure TMainForm.MenuItem9OnClick (Sender: TObject);
Begin
//запуск программы настройки ПDE
//ShellExecute(extractfilepath(application.exename)+'pdeConf.exe', extractfilepath(application.exename), '', 0, false);
  if pdmCfgShow = 0 then
    begin
    //configuratrion changed, need reload it
    mReloadSettingsOnClick(Sender);
    end;
End;

Procedure TMainForm.MenuItem10OnClick (Sender: TObject);
Begin
if (screensaver<>'') then
  begin
  //idletime:=0;
  //Timer1.Stop;
  if (screensaver[2] = ':') then  //full path
    ShellExecute(screensaver, extractfilepath(screensaver), '', 1, false)
  else
    ShellExecute(screensaver, extractfilepath(application.exename), '', 1, false);
  //Timer1.Start;
  end;
End;

Procedure TMainForm.mShootSystemOnClick (Sender: TObject);
var
  can: Boolean;
  pico: Pointer;
Begin
//закрытие системмы
//WinShowWindow(popupmenu1.handle, False);
if pdeLoadCfgInt('general.cfg', 'askforshutdown') = 1 then
  begin
  pico := MainForm.Icon;
  if pdeMessageBox(chr(13)+chr(10)+pdeLoadNLS('dlgShutdownText', 'Завершить работу?'),
        pdeLoadNLS('dlgShutdownCaption', 'Завершение работы'), pico) = 0 then
    begin
    MainFormOnCloseQuery(Sender, can);
    ShutDownForm.Show;
    dosshutdown(0);
    end;
  end
  else
  begin
  MainFormOnCloseQuery(Sender, can);
  ShutDownForm.Show;
  dosshutdown(0);
  end;
{if (rc=0) then
  //MessageBox('Буферы сброшены на винт, файловые системмы блокированы.'
  //           +chr(13)+chr(10)+'Компьютер готов к выключению или перезагрузке.'
  //           +chr(13)+chr(10)+'Доброе утро!', mtInformation, [])
  //MessageBox('Компьютер готов к выключению или перезагрузке.', mtInformation, [mbOK])
  ShutDownForm.Show
else
  MessageBox('Не могу закрыть системму?!'+chr(13)+chr(10)+'Юзер, что происходит?', mtInformation, [mbOK]);
}
End;

Procedure TMainForm.MainFormOnDestroy (Sender: TObject);
Begin
//освобождаем картинку из фона десктопа
formpicture.free;
End;

Procedure TMainForm.MainFormOnPaint (Sender: TObject; Const rec: TRect);
var
  __i, __j: Integer;
  //for gradient
  DRed,DGreen,DBlue,DR,DG,DB:Extended;
  StartLoop,EndLoop:LONGINT;
  rect:TRect;
Begin
//если есть обои, то рисуем их на десктопе
if wallpaper_present then
  begin
  if (wallpaperstyle = 'center') then
      begin
      MainForm.canvas.FillRect(MainForm.ClientRect, MainForm.Color);
      MainForm.canvas.draw((Width -  formpicture.width) div 2
        ,(Height -  formpicture.height) div 2, formpicture.graphic)
      end
    else if (wallpaperstyle = 'tile') then
      begin
      __j := 0;
      repeat
        __i := 0;
        repeat
        MainForm.canvas.draw( __i, __j, formpicture.graphic);
        __i := __i + formpicture.width;
        until __i > Width;
      __j := __j + formpicture.height;
      until __j > Height;
      end
    else if (wallpaperstyle = 'lefttop') then
      begin
      MainForm.canvas.FillRect(MainForm.ClientRect, MainForm.Color);
      MainForm.canvas.draw(0, Height -  formpicture.height, formpicture.graphic)
      end
    else if (wallpaperstyle = 'righttop') then
      begin
      MainForm.canvas.FillRect(MainForm.ClientRect, MainForm.Color);
      MainForm.canvas.draw(Width -  formpicture.width, Height -  formpicture.height, formpicture.graphic)
      end
    else if (wallpaperstyle = 'leftbottom') then
      begin
      MainForm.canvas.FillRect(MainForm.ClientRect, MainForm.Color);
      MainForm.canvas.draw(0 ,0, formpicture.graphic)
      end
    else if (wallpaperstyle = 'rightbottom') then
      begin
      MainForm.canvas.FillRect(MainForm.ClientRect, MainForm.Color);
      MainForm.canvas.draw(Width -  formpicture.width, 0, formpicture.graphic)
      end
    else //stretch
      MainForm.canvas.stretchdraw(0, 0, Width, Height, formpicture.graphic);
  end
else if (wallpaperstyle = 'vgradient') then
  begin //вместо обоев - вертикальный градиент
  DRed:=TRGB(Mainform.color).Red;
  DGreen:=TRGB(Mainform.color).Green;
  DBlue:=TRGB(Mainform.color).Blue;
  DR:=TRGB(secondcolor).Red-DRed;
  DG:=TRGB(secondcolor).Green-DGreen;
  DB:=TRGB(secondcolor).Blue-DBlue;
  DR:=DR / Height;
  DG:=DG / Height;
  DB:=DB / Height;
  StartLoop:=Height;
  EndLoop:=-1;
  WHILE StartLoop<>EndLoop DO
    BEGIN
    rect.Left:=0;
    rect.Right:=Width;
    rect.Bottom:=StartLoop;
    rect.Top:=rect.Bottom+1;

    Canvas.FillRect(rect,ValuesToRGB(Round(DRed),Round(DGreen),Round(DBlue)));

    DRed:=DRed+DR;
    DGreen:=DGreen+DG;
    DBlue:=DBlue+DB;
    dec(StartLoop);
    END;
  end
else
  MainForm.canvas.FillRect(MainForm.canvas.ClipRect, MainForm.Color);
{
Canvas.draw(new_item.x, new_item.y, new_item.di);
Canvas.TextOut(new_item.x + (new_item.di.width - Canvas.TextWidth(new_item.dc)) div 2
  , new_item.y - Canvas.TextHeight(new_item.dc) - 5, new_item.dc);
rect.Left:=new_item.x;
rect.Right:=new_item.x + new_item.di.width;
rect.Bottom:=new_item.y;
rect.Top:=new_item.y + new_item.di.height;
if new_item.selected then
  Canvas.DrawFocusRect(rect);}
End;

Procedure TMainForm.MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongInt);
Begin
  SendToBack;
End;

Procedure TDImage.MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongInt);
Begin
  //SendToBack;
End;

Procedure TDImage.Redraw(Const rec:TRect);
var
  //i, j: integer;
  //l, t, w, h: integer;
  //trcolor: TColor;
  rec1, rec2: TRect;

  //ps_mem, ps_bmp: HPS;
  //dc_mem: HDC;
  //size: SIZEL;
  //Rect, srcR: RectL;
  //aptl: array[0..1] of TRect;
  //aptl: array[0..2] of PointL;

  __i, __j: Integer;
  DRed,DGreen,DBlue,DR,DG,DB:Extended;
  StartLoop,EndLoop:LONGINT;
  rect:TRect;
Begin

rec2.Left:=0; rec2.right:=width;
rec2.Top:=height; rec2.bottom:=0;
rec1.Left:=left; rec1.right:=left+width;
rec1.Top:=screen.height-top; rec1.bottom:=rec1.Top-height;
if pict<>nil then
    begin
    {formbitmap := TBitmap.Create;
    formbitmap.height := screen.height;
    formbitmap.width := screen.width;
    formbitmap.Canvas.StretchDraw(0, 0, formbitmap.width, formbitmap.height, formpicture.graphic);
    formbitmap.Canvas.CopyRect(rec2, canvas, rec1)
    formbitmap.Free;}
    {dc_mem := DevOpenDC(AppHandle, od_memory, '*', 0, nil, 0);
    size.cx := screen.width;
    size.cy := screen.height;
    ps_mem := GpiCreatePS(AppHandle, dc_mem, size, gpia_Assoc or pu_Pels);
    Rect.xLeft := 0;
    Rect.xRight := TForm(Parent).Width-1;
    Rect.yBottom := 0;
    Rect.yTop := TForm(Parent).Height-1;
    WinFillRect(ps_mem, Rect, TForm(Parent).Color);
    srcR.xLeft := 0;
    srcR.xRight := pict.Width - 1;
    srcR.yBottom := 0;
    srcR.yTop := pict.Height - 1;
    }
      {WinDrawBitmap(ps_mem, pict.bitmap.handle, srcR, Rect, 0, 0, DBM_STRETCH);
      //aptl[0] := rec2;
      //aptl[1] := rec1;
      aptl[0].x := 0;
      aptl[0].y := 0;
      aptl[1].x := width-1;
      aptl[1].y := height-1;
      aptl[2].x := left;
      aptl[2].y := screen.height-top-height;

      GpiBitBlt(canvas.handle, ps_mem, 3, aptl[0], ROP_SRCCOPY, BBO_IGNORE);
     ps_mem <> 0 Then GpiDestroyPS(ps_mem);
    If dc_mem <> 0 Then DevCloseDC(dc_mem);}

    //pict.bitmap.Canvas.CopyRect(rec2, canvas, rec1)

    //we have wallpaper image
    Canvas.FillRect(canvas.cliprect, TForm(Parent).Color);
    if (wallpaperstyle = 'center') then
      begin
      Canvas.draw(-Left + (TForm(Parent).Width -  pict.width) div 2
        ,Top + Height - pict.height - (TForm(Parent).Height -  pict.height) div 2, pict.graphic)
      end
    else if (wallpaperstyle = 'tile') then
      begin
      __j := 0;
      repeat
        __i := 0;
        repeat
        //if __j<>0 then
          //canvas.draw( __i - Left, __j +
          //  Top + Height - TForm(Parent).Height + pict.height, pict.graphic)
          //else
          canvas.draw( __i - Left, __j - Bottom, pict.graphic);
        __i := __i + pict.width;
        until __i > TForm(Parent).Width;
      __j := __j + pict.height;
      until __j > TForm(Parent).Height;
      end
    else if (wallpaperstyle = 'lefttop') then
      begin
      canvas.draw(-Left ,Top + Height - TForm(Parent).Height + pict.height, pict.graphic)
      end
    else if (wallpaperstyle = 'righttop') then
      begin
      canvas.draw(TForm(Parent).Width - pict.width - Left
        ,Top + Height - TForm(Parent).Height + pict.height , pict.graphic)
      end
    else if (wallpaperstyle = 'leftbottom') then
      begin
      canvas.draw(-Left, -Bottom, pict.graphic)
      end
    else if (wallpaperstyle = 'rightbottom') then
      begin
      canvas.draw(TForm(Parent).Width - pict.width -Left, -Bottom, pict.graphic)
      end
    else //stretch
      canvas.stretchdraw(-Left, -Bottom, TForm(Parent).Width, TForm(Parent).Height, pict.graphic);

    end
  else if (wallpaperstyle = 'vgradient') then
    begin
    //Canvas.FillRect(canvas.cliprect, TForm(Parent).Color);

    DRed:=TRGB(Mainform.color).Red;
    DGreen:=TRGB(Mainform.color).Green;
    DBlue:=TRGB(Mainform.color).Blue;
    DR:=TRGB(secondcolor).Red-DRed;
    DG:=TRGB(secondcolor).Green-DGreen;
    DB:=TRGB(secondcolor).Blue-DBlue;
    DR:=DR / Mainform.Height;
    DG:=DG / Mainform.Height;
    DB:=DB / Mainform.Height;
    StartLoop:=Height;
    EndLoop:=-1;
    DRed:=DRed+DR*Top;
    DGreen:=DGreen+DG*Top;
    DBlue:=DBlue+DB*Top;

    WHILE StartLoop<>EndLoop DO
      BEGIN
      rect.Left:=0;
      rect.Right:=Width;
      rect.Bottom:=StartLoop;
      rect.Top:=rect.Bottom+1;

      Canvas.FillRect(rect,ValuesToRGB(Round(DRed),Round(DGreen),Round(DBlue)));

      DRed:=DRed+DR;
      DGreen:=DGreen+DG;
      DBlue:=DBlue+DB;
      dec(StartLoop);
      //inc(EndLoop);
      END;

    end
  else
    Canvas.FillRect(canvas.cliprect, TForm(Parent).Color);

if icon<>nil then
    icon.draw(Canvas, clientrect)
else if bitmap<>nil then
    bitmap.draw(Canvas, clientrect);

{l:=Left;
t:=Bottom;//Top;
w:=Width;
h:=Height;
trcolor:=canvas.pixels[0, 0];
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      begin
      if (canvas.pixels[j, i]=trcolor) then //bingo!!!
        //if not(selected) then
          if pict.bitmap<>nil then
          Canvas.Pixels[j, i]:=pict.bitmap.Canvas.Pixels[j+l, i+t]//TForm(Parent).Canvas.Pixels[j+l, t+i]
          //Canvas.Pixels[j, i]:=graphic.canvas.pixels[j, i];
            //pict.bitmap.Canvas.Pixels[j+l, i+t]
        else
          Canvas.Pixels[j, i]:=TForm(Parent).Color;
      end;
}
if (selected) then
  Begin
  rec1:=ClientRect;
  InflateRect(rec1, -1, -1);
  Canvas.DrawFocusRect(Rec1);
  End;
//inherited redraw(rec);
End;

Procedure TMainForm.mRefreshOnClick (Sender: TObject);
var
  i: integer;
Begin
if diCount>0 then
  for i:=1 to diCount do
  begin
    di[i].di.Refresh;
    di[i].dc.Refresh;
  End;
End;

Procedure TMainForm.diOnDblClick (Sender: TObject);
var
  n: integer;
Begin
n:=TDImage(Sender).num;
 if (di[n].dtype='FOLDER') then
   Begin
   if (di[n].dname[2] = ':') then  //full path
     ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', extractfilepath(application.exename), di[n].dname, 0, false)
   else
     ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', extractfilepath(application.exename), extractfilepath(application.exename)+di[n].dname, 0, false);
   End
 else if (di[n].dtype='APP') then
   Begin
   if (di[n].dname[2] = ':') then  //full path
     ShellExecute(di[n].dname, di[n].dpath, di[n].dparam, di[n].ses_type, true)
   else
     ShellExecute(extractfilepath(application.exename)+di[n].dname, extractfilepath(application.exename)+di[n].dpath, di[n].dparam, di[n].ses_type, true);

   end
 else if (di[n].dtype='SHORTCUT') then
   ;
End;

Procedure TMainForm.imgOnClick (Sender: TObject);
//var
//  i: integer;
Begin

End;

Procedure TMainForm.diOnClick (Sender: TObject);
var
  i: integer;
Begin
//di[TDImage(Sender).num].dc.color:=clBlue;
//MainForm.SendToBack;
if diCount>0 then
  for i:=1 to diCount do
  begin
    if di[i].di.selected then di[i].di.selected:=false;
    di[i].di.refresh;
    di[i].dc.refresh;
  end;
di[TDImage(Sender).num].di.selected:=true;
di[TDImage(Sender).num].di.refresh;
End;

Procedure TMainForm.imgOnDragDrop (Sender: TObject; Source: TObject; X: LongInt; Y: LongInt);
var
  n: integer;
  SharedMem:PDragDropInfo;
  Temp:^String;
  fsrc: cstring;
  src: string;
  sr2: TSearchRec;
  afile: TextFile;
  basepath: String;
Begin
  if (Source is TDImage) then begin
  n:=TDImage(Source).num;
  TDImage(Source).Left:=x-15;
  TDImage(Source).Top:=screen.height-y-15;
  di[n].dc.left:=di[n].di.left+(di[n].di.Width-di[n].dc.Width) div 2;
  di[n].dc.top:=di[n].di.top+di[n].di.height+5;
  di[n].di.invalidate;
  di[n].dc.invalidate;
  end
  else if ((Source Is TExternalDragDropObject)And
        (TExternalDragDropObject(Source).SourceType=drtString)And
        (TExternalDragDropObject(Source).SourceString=DragSourceId)) then
  begin //FileHalf try to drop shortcut on us, gotcha!!!
      If not AccessNamedSharedMem(TExternalDragDropObject(Source).SourceFileName,
                                   SharedMem) Then exit;  //some error
      Temp:=@SharedMem^.Items;
      fsrc:=Temp^;
      src:=fsrc;  //имя файла или папки

      basepath := extractfilepath(application.exename) + '\PDEConf\';

  inc(diCount);
  di[diCount].di:=TDImage.Create(self);
  di[diCount].di.parent:=MainForm;
  di[diCount].di.width:=pdeLoadCfgInt('pdm.cfg','iconsize');
  di[diCount].di.height:=di[diCount].di.width;
  di[diCount].di.num:=diCount;
  if wallpaper_present then
    di[diCount].di.pict:=formpicture
  else
    di[diCount].di.pict:=nil;
  di[diCount].di.OnClick:=diOnClick;
  di[diCount].di.OnDblClick:=diOnDblClick;
  di[diCount].di.DragMode:=dmAutomatic;
  di[diCount].dc:=TLabel.Create(self);
  di[diCount].dc.parent:=MainForm;
  di[diCount].dc.PenColor:=clWhite;
  di[diCount].di.left := X;
  di[diCount].di.top := Screen.Height - Y;
  di[diCount].dc.AutoSize:=True;
  di[diCount].dc.left:=di[diCount].di.left+(di[diCount].di.Width
    -di[diCount].dc.Width) div 2;
  di[diCount].dc.top:=di[diCount].di.top+di[diCount].di.height+5;
  di[diCount].dparam := '';  //параметры запуска (необязательно)
  di[diCount].ses_type := 0;

      AssignFile(afile, basepath + 'desktop.progs');
      Reset(afile);
      Seek(afile, filesize(afile));
      Writeln(afile);

      if (FindFirst(src+'\*.*', faAnyFile, sr2)=0) then
        begin  //directory
        FindClose(sr2);
        Writeln(afile, 'FOLDER');
        Writeln(afile, ExtractFileName(src));
        Writeln(afile, 'bitmaps\pdm\Folder.ico');
        Writeln(afile, IntToStr(X));
        Writeln(afile, IntToStr(Screen.Height - Y));

        di[diCount].dtype := 'FOLDER';
        di[diCount].dc.caption := ExtractFileName(src);

        if src[length(src)]<>'\' then
          src := src + '\';
        Writeln(afile, src);
        Writeln(afile, src);

        di[diCount].dimage := 'bitmaps\pdm\Folder.ico';
        di[diCount].di.picture.loadfromfile(extractfilepath(application.exename)
          +di[diCount].dimage);
        di[diCount].dname := src;
        di[diCount].dpath := src;
        end
      else
        begin  //application
        FindClose(sr2);
        Writeln(afile, 'APP');
        Writeln(afile, ExtractFileName(src));
        Writeln(afile, 'bitmaps\pdm\Exec.ico');
        Writeln(afile, IntToStr(X));
        Writeln(afile, IntToStr(Screen.Height - Y));
        Writeln(afile, src);
        Writeln(afile, ExtractFilePath(src));

        di[diCount].dtype := 'APP';
        di[diCount].dc.caption := ExtractFileName(src);
        di[diCount].dimage := 'bitmaps\pdm\Exec.ico';
        di[diCount].di.picture.loadfromfile(extractfilepath(application.exename)
          +di[diCount].dimage);
        di[diCount].dname := src;
        di[diCount].dpath := ExtractFilePath(src);
        end;
      Writeln(afile);
      Write(afile, '0');
      CloseFile(afile);

      //each process must free the shared memory !!
      FreeNamedSharedMem(TExternalDragDropObject(Source).SourceFileName);
  end;

End;

Procedure TMainForm.imgOnDragOver (Sender: TObject; Source: TObject; X: LongInt; Y: LongInt; State: TDragState; Var Accept: Boolean);
Begin
  Accept:=(Source is TDImage)
             or ((Source Is TExternalDragDropObject)And
             (TExternalDragDropObject(Source).SourceType=drtString)And
             (TExternalDragDropObject(Source).SourceString=DragSourceId));
End;

Procedure TMainForm.Timer1OnTimer (Sender: TObject);
var
  //i: integer;
  //flags: longword;
  //rc: boolean;
  hwndtop: hwnd;
  enum: henum;
  //res: USHORT;
  //rL: RectL;
  swp1: SWP;
Begin
//сначала отправляем себя на задний план
//,затем - минимизированные окна
MainForm.SendToBack;
//WinSetWindowPos(MainForm.Frame.Handle, HWND_BOTTOM, 0, 0, 0, 0,
//  SWP_SHOW Or SWP_ZORDER);

enum:=WinBeginEnumWindows(HWND_DESKTOP);
hwndTop:=WinGetNextWindow(enum);
while (hwndTop<>0) do
  begin
  //res:=WinQueryWindowUShort(hwndtop, QWS_XMINIMIZE);
    //WinQueryWindowRect(hwndTop, rL);
  WinQueryWindowPos(hwndTop, swp1);
  //if (res<>-1) then
    //if ((rL.xRight-rL.xLeft)<=40)and((rL.yTop-rL.yBottom)<=40) then
  if (swp1.Fl and SWP_MINIMIZE)<>0 then
    WinShowWindow(hwndTop, false);
  hwndTop:=WinGetNextWindow(enum);
  end;
WinEndEnumWindows(enum);

{idletime:=idletime+Timer1.Interval;
if not(idletime<savertime) and (screensaver<>'') then
  begin
  idletime:=0;
  Timer1.Stop;
  ShellExecute(screensaver, '', '', false, true);
  Timer1.Start;
  end;}
End;

Procedure TMainForm.MainFormOnShow (Sender: TObject);
var
  afile: TextFile;
  fcapt: string;
  //fcolor: longint;
  flt: integer;
  rez: integer;
  sr: TSearchRec;
  ftype, fname, fpath, fparams: String;
Begin
//установки формы
MainForm.BorderStyle:=bsStealth; //без заголовка и не видимый в списке окон
NewForm.BorderStyle:=bsStealthDlg;
ShutDownForm.BorderStyle:=bsStealth;
Align:=alClient;
MainForm.SendToBack;
//formpicture.Width:=MainForm.Width;
//formpicture.Height:=MainForm.Height;
//formpicture.Align:=alClient;

savertime:=300000;
formpicture:=TPicture.Create(MainForm); //рисунок фона
Timer1.Start;  //запуск таймера

//desktop color
mainform.color := pdeLoadCfgColor('pdm.cfg', 'desktopcolor');
secondcolor := pdeLoadCfgColor('pdm.cfg', 'secondcolor');
//desktop image
wallpaper := pdeLoadCfgStr('pdm.cfg', 'wallpaper');
wallpaperstyle := 'stretch';
wallpaperstyle := pdeLoadCfgStr('pdm.cfg', 'wallpaperstyle');
if (wallpaperstyle <> 'vgradient') then
  begin
  if fileexists(wallpaper) or fileexists(extractfilepath(application.exename)+wallpaper) then
    begin
    try
      if (wallpaper[2] = ':') then
        formpicture.bitmap.loadfromfile(wallpaper)
      else
        formpicture.bitmap.loadfromfile(extractfilepath(application.exename)+wallpaper);

      //MainForm.canvas.stretchdraw(0, 0, MainForm.Width, MainForm.Height, formpicture.graphic);
      wallpaper_present:=true;
      except
      formpicture.free;
      wallpaper_present:=false;
      end;
    end
  else
    formpicture.free;
  end;

//screensaver
screensaver := pdeLoadCfgStr('pdm.cfg', 'screensaver');
//time for screensaver
savertime := pdeLoadCfgInt('pdm.cfg', 'savertime');

//load desktop items from file
assignfile(afile, extractfilepath(application.exename)+'PDEConf\desktop.progs');
reset(afile);
readln(afile);
readln(afile);

while not(eof(afile)) do
  Begin
  inc(diCount);
  di[diCount].di:=TDImage.Create(self);
  di[diCount].di.parent:=MainForm;
  di[diCount].di.width:=pdeLoadCfgInt('pdm.cfg','iconsize');
  di[diCount].di.height:=di[diCount].di.width;
  di[diCount].di.num:=diCount;
  if wallpaper_present then
    di[diCount].di.pict:=formpicture
  else
    di[diCount].di.pict:=nil;
  di[diCount].di.OnClick:=diOnClick;
  di[diCount].di.OnDblClick:=diOnDblClick;
  di[diCount].di.DragMode:=dmAutomatic;
  di[diCount].dc:=TLabel.Create(self);
  di[diCount].dc.parent:=MainForm;
  di[diCount].dc.PenColor:=clWhite;//not(MainForm.Color);

  readln(afile, di[diCount].dtype);
  readln(afile, fcapt);
  di[diCount].dc.caption:=fcapt;
  readln(afile, di[diCount].dimage);
  try
    if (di[diCount].dimage[2] = ':') then //full path
      di[diCount].di.icon.loadfromfile(di[diCount].dimage)
    else
      di[diCount].di.icon.loadfromfile(extractfilepath(application.exename)+di[diCount].dimage);
  except
    di[diCount].di.bitmap:=imgNone.Picture.bitmap;
    end;
  readln(afile, flt);
  di[diCount].di.left:=flt;
  readln(afile, flt);
  di[diCount].di.top:=flt;

  di[diCount].dc.AutoSize:=True;
  di[diCount].dc.left:=di[diCount].di.left+(di[diCount].di.Width-di[diCount].dc.Width) div 2;
  di[diCount].dc.top:=di[diCount].di.top+di[diCount].di.height+5;

  readln(afile, di[diCount].dname);
  readln(afile, di[diCount].dpath);
  readln(afile, di[diCount].dparam);
  di[diCount].ses_type:=0;
  readln(afile, di[diCount].ses_type); //тип сессии (необязателен)
  End;
closefile(afile);
{
new_item.di := TIcon.Create;
new_item.di.width := 32;
new_item.di.height := 32;
new_item.di.loadfromfile('c:\xata\pde\bitmaps\empty.ico');
new_item.dc := 'New Item';
new_item.x := 200;
new_item.y := 200;
}
//загрузка программ из папки "root\При старте"
rez:=FindFirst(extractfilepath(application.exename)+pdeLoadCfgStr('general.cfg', 'userstartup')
  +'\*.*', faAnyFile{faReadOnly Or faHidden Or faSysFile Or faArchive}, sr);
if rez=0 then
  while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.name='..') then continue;
    assignfile(afile, extractfilepath(application.exename)+pdeLoadCfgStr('general.cfg', 'userstartup')+'\'+sr.name);
    reset(afile);
    readln(afile, ftype);
    if ftype='[SHORTCUT]' then begin
    readln(afile);
    readln(afile, ftype);
    readln(afile, fname);
    readln(afile, fpath);
    readln(afile, fparams);

    if ftype='APP' then
      ShellExecute(fname, fpath, fparams, 0, true)
    else if ftype='FOLDER' then
      ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', extractfilepath(application.exename), fname, 0, true)
    else if ftype='PDE' then
      ShellExecute(extractfilepath(application.exename)+fname, extractfilepath(application.exename), fparams, 0, true);

      end; // [SHORTCUT]
    closefile(afile);

    end;
FindClose(sr);

End;

function TMainForm.ShellExecute(fname, fdir, fparam: string; ses_type: Word; shortcut: boolean): Boolean;
var
  sd: StartData;
  idSession: ULong;
  apid: PID;
  fname2, fparam2: pchar;
  rc, rc2: APIRET;
begin
if not(shortcut) and (fparam <> '') then
  fparam:='"'+fparam+'"';  //<-защита от пробеллов в пути к файлу
new(fname2);
new(fparam2);
StrPCopy(fname2, fname);
StrPCopy(fparam2, fparam);

//fparam2:=StrCat(fname2, fparam2);

with sd do
  begin
      Length   := sizeof(StartData);
      Related  := {ssf_Related_Child;//}ssf_Related_Independent; // start an independent session
      FgBg     := ssf_Fgbg_Fore;           // start session in foreground
      TraceOpt := ssf_TraceOpt_None;       // No trace
      PgmTitle := fname2;
      PgmName := fname2;
      PgmInputs :=fparam2;
      TermQ := nil;                        // No termination queue
      Environment := nil;                  // No environment string
      InheritOpt := ssf_InhertOpt_Parent;

      if (ses_type=1) then //тип сессии программы SSF_TYPE_DEFAULT (0), SSF_TYPE_FULLSCREEN (1), SSF_TYPE_WINDOWABLEVIO (2), SSF_TYPE_PM (3)
        SessionType := SSF_TYPE_FULLSCREEN //, SSF_TYPE_VDM (4), SSF_TYPE_WINDOWEDVDM (7)
      else if (ses_type=2) then
        SessionType := SSF_TYPE_WINDOWABLEVIO
      else if (ses_type=3) then
        SessionType := SSF_TYPE_PM
      else if (ses_type=4) then
        SessionType := SSF_TYPE_VDM
      else if (ses_type=7) then
        SessionType := SSF_TYPE_WINDOWEDVDM
      else SessionType := ssf_Type_Default;

      IconFile := nil;                     // No icon association
      PgmHandle := 0;
      PgmControl := ssf_Control_Visible;
      InitXPos  := 0;     // Initial window coordinates
      InitYPos  := 0;
      InitXSize := 200;    // Initial window size
      InitYSize := 140;
      Reserved := 0;
      ObjectBuffer  := nil;
      ObjectBuffLen := 0;
  end;

if length(fdir)>3 then
  Delete(fdir, length(fdir), 1); //delete "\"
rc:=DosSetCurrentDir(fdir);

MainForm.BringToFront;
//WinSetWindowPos(MainForm.Frame.Handle,HWND_TOP,0,0,0,0,
//  SWP_SHOW Or SWP_ZORDER);

rc2:=DosStartSession(sd, idSession, apid);

freemem(fname2, sizeof(fname2));
freemem(fparam2, sizeof(fparam2));

//MessageBox('FName:'+fname+' FDir:'+fdir+' FParam:'+fparam+' rc:'+IntToStr(rc)+' rc2:'+IntToStr(rc2), mtInformation, [mbOK]);
Result := True;
end;

Procedure TLogOnForm.LogOnFormOnShow (Sender: TObject);
Begin

End;

Procedure TMainForm.lnRebootOnClick (Sender: TObject);
Begin
  ShellExecute('shutdown.exe', '', '', 0, true);
End;

Procedure TMainForm.lnOKOnClick (Sender: TObject);
Begin
if (user = lnUserName.Text) and (pwd = lnPassWord.Text) then
  Begin
  LogOnForm.Close;
  LoggedOn:=True;
  End
else
  Begin
  lnUserName.Text:='';
  lnPassWord.Text:='';
  LogOnForm.ActiveControl:=lnUserName;
  End;

End;

Initialization
  RegisterClasses ([TMainForm, TImage, TPopupMenu, TTimer, TMenuItem, TMaskEdit
   , TEdit]);
End.
