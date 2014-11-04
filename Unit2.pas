//-----------------------------------------
//П-панель (DeskHalf), ??.08.03
//Правила внесения изменений смотри в Unit1.pas
//(FileHalf)                         stVova
Unit Unit2;

Interface

Uses
  Classes, Forms, Graphics, Buttons, PMWin, XplorBtn, ExtCtrls, seven,
  StdCtrls, SysUtils, DeskUni2, PMWP, BSEDos, PMWin, os2def, strings,
  Clocks, Dialogs, ComCtrls, Hints, RunUnit, pdeNLS, pdedlgs;

//Name of the shared memory object
Const
    SharedMemName='DragDrop_ItemsInfo';

//Drag source identification
Const
    DragSourceId='File or Folder to Copy';

Type
  TMainForm = Class (TForm)
    bPi: TExplorerButton;
    bRoll: TExplorerButton;
    bCalc: TExplorerButton;
    pmApps: TPopupMenu;
    mMoveLeft: TMenuItem;
    mMoveRight: TMenuItem;
    MenuItem6: TMenuItem;
    mDelete: TMenuItem;
    bLeft: TExplorerButton;
    bRight: TExplorerButton;
    Bevel1: TBevel;
    mAbout: TMenuItem;
    MenuItem3: TMenuItem;
    imgNone: TImage;
    BalloonHint1: TBalloonHint;
    mReload: TMenuItem;
    MenuItem1: TMenuItem;
    cpuProgress: TLabel;
    secProgress: TProgressBar;
    lDate: TLabel;
    Clock: TLabel;
    indPanel2: TPanel;
    pmGo: TPopupMenu;
    mSettings: TMenuItem;
    MenuItem2: TMenuItem;
    mClose: TMenuItem;
    Timer1: TTimer;
    Procedure mMoveLeftOnClick (Sender: TObject);
    Procedure mMoveRightOnClick (Sender: TObject);
    Procedure mDeleteOnClick (Sender: TObject);
    Procedure mAboutOnClick (Sender: TObject);
    Procedure mReloadOnClick (Sender: TObject);
    Procedure MainFormOnDragDrop (Sender: TObject; Source: TObject; X: LongInt;
      Y: LongInt);
    Procedure MainFormOnDragOver (Sender: TObject; Source: TObject; X: LongInt;
      Y: LongInt; State: TDragState; Var Accept: Boolean);
    Procedure mSettingsOnClick (Sender: TObject);
    Procedure MainFormOnDestroy (Sender: TObject);
    Procedure MainFormOnResize (Sender: TObject);
    Procedure Timer1OnTimer (Sender: TObject);
    Procedure mCloseOnClick (Sender: TObject);
    Procedure MainFormOnTranslateShortCut (Sender: TObject; KeyCode: TKeyCode;
      Var ReceiveR: TForm);
    Procedure MainFormOnShow (Sender: TObject);
    Procedure bRightOnClick (Sender: TObject);
    Procedure bLeftOnClick (Sender: TObject);
    Procedure bPiOnClick (Sender: TObject);
    Procedure Form1OnCreate (Sender: TObject);

    Procedure allProgspBtnClick(Sender: TObject);
    Procedure pAppsMouseUp (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X: LongInt; Y: LongInt);
    Procedure xbOnPaint (Sender: TObject; Const rec: TRect);
    Procedure xbOnMouseMove (Sender: TObject; Shift: TShiftState; X: LongInt;
      Y: LongInt);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    function LoadSettings: integer;
    function ShellExecute(fname, fdir, fparam: string): Boolean;
    function SwapLeft: Integer;
    function SwapRight: Integer;
    function SaveProgs: Integer;
  End;

  TPrRec = record
    ptag: Integer;
    ptype: string;
    pbmp: string;
    pname: string;
    ppath: string;
    pparam: string;
    pBtn: TExplorerButton;
  end;

  TDragDropItem=Record
                        Len:Byte;         //length of string
                        Data:Array[0..0] Of Char;
                  End;

    PDragDropInfo=^TDragDropInfo;
    TDragDropInfo=Record
                        Count:LongWord;   //Count of elements
                        Items:Array[0..0] Of TDragDropItem;
                  End;

  TMyShape = class(TShape)
    public
      property Canvas;
  End;

Var
  MainForm: TMainForm;
  DynamicSize, OnTop: Boolean;
  findUtil: String;
  allprogs: array[1..80] of TPrRec;
  allprogsCount, i2: LongInt;
  sr: TSearchRec;
  Days: array[1..7] of String; // = ('Вск.', 'Пон.', 'Втр.', 'Срд.', 'Чтв.', 'Птн.', 'Суб.');

  popI2: Integer;

Implementation

function TMainForm.SaveProgs: Integer;
var
  cfgdata: TStringList;
begin
  cfgdata := TStringList.Create;
  cfgdata.Add('//Programs on Panel (near the P-button): [type, name, path, parameters]');
  if (allprogscount > 0) then
    for i2 := 1  to allprogscount do
      begin
      cfgdata.Add(allprogs[i2].ptype);
      cfgdata.Add(allprogs[i2].pbmp);
      cfgdata.Add(allprogs[i2].pname);
      cfgdata.Add(allprogs[i2].ppath);
      cfgdata.Add(allprogs[i2].pparam);
      end;
  pdeSaveCfgFile('ppanel.progs', cfgdata);
End;

//--applications buttons menu routines------
function TMainForm.SwapLeft: Integer;
var
  ptag: Integer;
  ptype: string;
  pbmp: string;
  pname: string;
  ppath: string;
  pparam: string;
begin

  if (i2 > 1) then
  begin
  ptag :=   allprogs[i2-1].ptag;
  ptype :=  allprogs[i2-1].ptype;
  pbmp :=   allprogs[i2-1].pbmp;
  pname :=  allprogs[i2-1].pname;
  ppath :=  allprogs[i2-1].ppath;
  pparam := allprogs[i2-1].pparam;

  allprogs[i2-1].ptag   := allprogs[i2].ptag;
  allprogs[i2-1].ptype  := allprogs[i2].ptype;
  allprogs[i2-1].pbmp   := allprogs[i2].pbmp;
  allprogs[i2-1].pname  := allprogs[i2].pname;
  allprogs[i2-1].ppath  := allprogs[i2].ppath;
  allprogs[i2-1].pparam := allprogs[i2].pparam;
  allprogs[i2-1].pbtn.Hint := allprogs[i2].pbtn.Hint;
  allprogs[i2-1].pbtn.Glyph := allprogs[i2].pbtn.Glyph;

  allprogs[i2].ptag   := ptag;
  allprogs[i2].ptype  := ptype;
  allprogs[i2].pbmp   := pbmp;
  allprogs[i2].pname  := pname;
  allprogs[i2].ppath  := ppath;
  allprogs[i2].pparam := pparam;
  allprogs[i2].pbtn.Hint := allprogs[i2].pname;
  try
    allprogs[i2].pbtn.Glyph.LoadFromFile(extractfilepath(application.exename)
      +'Bitmaps\Deskhalf\'+allprogs[i2].pbmp);
    except
    allprogs[i2].pbtn.Glyph := imgNone.Picture.bitmap;
    end;
  allprogs[i2-1].pbtn.Invalidate;
  allprogs[i2].pbtn.Invalidate;
  end;
{SwapLeft}
end;

function TMainForm.SwapRight: Integer;
var
  ptag: Integer;
  ptype: string;
  pbmp: string;
  pname: string;
  ppath: string;
  pparam: string;
begin

  if (i2 < allprogscount) then
  begin

  ptag :=   allprogs[i2+1].ptag;
  ptype :=  allprogs[i2+1].ptype;
  pbmp :=   allprogs[i2+1].pbmp;
  pname :=  allprogs[i2+1].pname;
  ppath :=  allprogs[i2+1].ppath;
  pparam := allprogs[i2+1].pparam;

  allprogs[i2+1].ptag   := allprogs[i2].ptag;
  allprogs[i2+1].ptype  := allprogs[i2].ptype;
  allprogs[i2+1].pbmp   := allprogs[i2].pbmp;
  allprogs[i2+1].pname  := allprogs[i2].pname;
  allprogs[i2+1].ppath  := allprogs[i2].ppath;
  allprogs[i2+1].pparam := allprogs[i2].pparam;
  allprogs[i2+1].pbtn.Hint := allprogs[i2].pbtn.Hint;
  allprogs[i2+1].pbtn.Glyph := allprogs[i2].pbtn.Glyph;

  allprogs[i2].ptag   := ptag;
  allprogs[i2].ptype  := ptype;
  allprogs[i2].pbmp   := pbmp;
  allprogs[i2].pname  := pname;
  allprogs[i2].ppath  := ppath;
  allprogs[i2].pparam := pparam;
  allprogs[i2].pbtn.Hint := allprogs[i2].pname;
  try
    allprogs[i2].pbtn.Glyph.LoadFromFile(extractfilepath(application.exename)
      +'Bitmaps\Deskhalf\'+allprogs[i2].pbmp);
    except
    allprogs[i2].pbtn.Glyph := imgNone.Picture.bitmap;
    end;
  allprogs[i2+1].pbtn.Invalidate;
  allprogs[i2].pbtn.Invalidate;
  end;

{SwapRight}
end;

Procedure TMainForm.pAppsMouseUp (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X: LongInt; Y: LongInt);
var p: TPoint;
Begin
if Button = mbRight then
  begin
    for PopI2 := 1 to allprogsCount do
      if (allprogs[PopI2].pbtn.Hint=TExplorerButton(Sender).Hint) then  //нашлась сендерша
        break;
    p := TExplorerButton(Sender).ClientToScreen(Point(X, Y));
    pmApps.Popup(p.X, p.Y);
  end;
End;

//--applications buttons popupmenu----------
Procedure TMainForm.mMoveLeftOnClick (Sender: TObject);
Begin
i2 := PopI2;
SwapLeft;
SaveProgs;
End;

Procedure TMainForm.mMoveRightOnClick (Sender: TObject);
Begin
i2 := PopI2;
SwapRight;
SaveProgs;
End;

Procedure TMainForm.mDeleteOnClick (Sender: TObject);
Begin
i2 := PopI2;
  while i2 < allprogsCount do
    begin
    SwapRight;
    inc(i2);
    end;
allprogs[i2].pbtn.Free;
dec(allprogsCount);
SaveProgs;
End;
//-----------------------------------------

Procedure TMainForm.xbOnMouseMove (Sender: TObject; Shift: TShiftState;
  X: LongInt; Y: LongInt);
Begin
{  xbOnPaint(Sender, clientrect);
  if TExplorerButton(Sender).Down then //down
    Canvas.ShadowedBorder(TExplorerButton(Sender).ClientRect,cl3DDkShadow,clBtnHighlight)
    else
    Canvas.ShadowedBorder(TExplorerButton(Sender).ClientRect,clBtnHighlight,cl3DDkShadow);
}
End;

Procedure TMainForm.xbOnPaint (Sender: TObject; Const rec: TRect);
{var
  i2: Integer;
  fname: String;
  hico: HPointer;
  ps: HPS;}
Begin
//перерисовка програмних кнопок

{if allprogsCount>0 then
  for i2:=1 to allprogsCount do
    if (allprogs[i2].pbtn.Hint=TExplorerButton(Sender).Hint) then  //нашлась сендерша
      break;

if (allprogs[i2].pname[2] = ':') then //full path
  fname := allprogs[i2].pname
  else //path from \..\pde\
  fname := extractfilepath(application.exename)+allprogs[i2].pname;

hico := WinLoadFileIcon(fname, False);
ps := WinGetPS(allprogs[i2].pbtn.handle);
allprogs[i2].pbtn.canvas.fillrect(allprogs[i2].pbtn.clientrect, bPi.Color);
WinDrawPointer( ps, 2, 2, hico, 0);
WinReleasePS(ps);
WinFreeFileIcon(hico);
}
End;

Procedure TMainForm.mAboutOnClick (Sender: TObject);
var
  about, authors, thanks: TStringList;
  cptn, text, licensefile: String;
  logo: Pointer;
Begin
//Информация о продукте
  about := TStringList.Create;
  about.Add(pdeLoadNLS('pdeName',' Полумух Desktop Environment')+' v.0.06');
  about.Add('');
  about.Add(pdeLoadNLS('pdeDescription1', 'Графическая оболочка пользователя для'));
  about.Add(pdeLoadNLS('pdeDescription2', 'операционных систем OS/2 Warp и eCS'));
  about.Add('');
  about.Add(pdeLoadNLS('pdeDescription6', 'П-панель. Содержит меню и кнопки'));
  about.Add(pdeLoadNLS('pdeDescription7', 'для доступа к приложениям и папкам.'));
//pdeLoadNLS('', '')
  authors := TStringList.Create;
  authors.Add(pdeLoadNLS('pdeAuthors1.1', 'Сергеев Владимир, stVova'));
  authors.Add('');
  authors.Add(pdeLoadNLS('pdeAuthors1.2', 'разработчик'));
  authors.Add(pdeLoadNLS('pdeAuthors1.3', 'программирование, дизайн'));
  authors.Add(pdeLoadNLS('pdeAuthors1.4', 'stVova@ukrpost.com.ua'));
  thanks := TStringList.Create;
  thanks.Add(pdeLoadNLS('pdeThanks1.1', 'Сергеев Сергей, SERG'));
  thanks.Add('');
  thanks.Add(pdeLoadNLS('pdeThanks1.2', 'брат'));
  thanks.Add(pdeLoadNLS('pdeThanks1.3', 'критика и идеи'));
  thanks.Add(pdeLoadNLS('pdeThanks1.4', 'e-Mail отсутствует'));
  thanks.Add('----');
  thanks.Add('KDE Team for graphics and icons');
  thanks.Add('www.kde.org');
  thanks.Add('----');
  thanks.Add('GNOME Team for graphics and icons');
  thanks.Add('www.gnome.org');

  cptn := pdeLoadNLS('dlgAboutProgram', 'Информация о продукте');
  text := pdeLoadNLS('pdeDeskHalf', 'П-панель');
  licensefile := 'c:\pde\copying';
  logo := MainForm.Icon;
  pdeAboutDialog(about, authors, thanks, cptn, text, licensefile, logo);
End;

Procedure TMainForm.mReloadOnClick (Sender: TObject);
Begin
//  DeskUni2.MMenu.bRefreshOnDblClick(Sender);
  if allprogsCount>0 then
  for _i:=1 to allprogsCount do
    allprogs[_i].pBtn.Free;

MainForm.Height:=4 + pdeLoadCfgInt('deskhalf.cfg', 'size');
MainForm.Top := Screen.Height-MainForm.Height-pdeLoadCfgInt('deskhalf.cfg', 'bottom');
bPi.Width := MainForm.Height - 4;
bPi.Height := bPi.Width;
{bRoll.Width := bPi.Width;
bRoll.Height := bPi.Width;
bCalc.Width := bPi.Width;
bCalc.Height := bPi.Width;
bRoll.Visible := (pdeLoadCfgStr('deskhalf.cfg', 'InPanel1') = 'yes');
bCalc.Visible := (pdeLoadCfgStr('deskhalf.cfg', 'InPanel1') = 'yes');}
//indPanel1.Height := bPi.Width;
indPanel2.Height := bPi.Width;

MainForm.LoadSettings;

if DynamicSize then
  begin
  MainForm.Width := indPanel2.Width+(allprogsCount+1)*(2+bPi.Width)+40;
//  if pdeLoadCfgStr('deskhalf.cfg', 'IndPanel1') = 'yes' then
//    MainForm.Width := MainForm.Width + 10 + 2 * bPi.Width;
  MainForm.Left:=(Screen.Width-MainForm.Width) div 2;
  end
  else
  begin
  MainForm.Width := screen.width;
  MainForm.Left := 0;
  end;;
End;

//добавление програмных кнопок на Панель drag'n'dropом
Procedure TMainForm.MainFormOnDragDrop (Sender: TObject; Source: TObject;
  X: LongInt; Y: LongInt);
Var SharedMem:PDragDropInfo;
    sh:Longint;
    Temp:^String;
    fsrc: cstring;
    src, tmpstr: string;
    rc: apiret;
    tbmp: TBitmap;
    sr2: TSearchRec;
    afile: TextFile;
    basepath: String;

    ps: HPS;
    hico : HPointer;
    //tmpshape: TMyShape;
    __i, __j: Integer;
    cx_icon, cy_icon: Byte;
    bmpfile: TextFile;
    r, g, b: Byte;
    rgb: TColor;
    bmpsavepath, bmpname: String;

Begin
rc:=0;
//Look if the target is valid for us...
    If ((Source Is TExternalDragDropObject)And
        (TExternalDragDropObject(Source).SourceType=drtString)And
        (TExternalDragDropObject(Source).SourceString=DragSourceId)) Then
    Begin  //accepted
      If not AccessNamedSharedMem(TExternalDragDropObject(Source).SourceFileName,
                                   SharedMem) Then exit;  //some error
      Temp:=@SharedMem^.Items;
            fsrc:=Temp^;
      src:=fsrc;  //имя файла или папки
      if (FindFirst(src+'\*.*', faAnyFile, sr2)=0) then
        begin  //directory
        FindClose(sr2);
        basepath := extractfilepath(application.exename) + '\PDEConf\';

        AssignFile(afile, basepath + 'ppanel.progs');
        Reset(afile);
        Seek(afile, filesize(afile));
        //Writeln(afile);
        Writeln(afile, 'FOLDER');
        Writeln(afile, 'defProgs\bFolder.bmp');
        if src[length(src)]<>'\' then
          src := src + '\';
        Writeln(afile, src);
        Writeln(afile, src);
        Writeln(afile);

        CloseFile(afile);
        end
      else
        begin  //application
        FindClose(sr2);
        bmpSavePath := extractfilepath(application.exename)+'\Bitmaps\DeskHalf\defProgs\';
        bmpName := ChangeFileExt(extractfilename(src), '.bmp');
        while fileexists(bmpSavePath+bmpName) do
          bmpName := 'b'+bmpName;

        {tmpShape := TMyShape.Create(Self);
        tmpShape.Parent := Self;
        tmpShape.Height := 32;
        tmpShape.Width := 32;
        tmpShape.Left := 0;
        tmpShape.Top := 0;
        //tmpShape.Pen.Style := psClear;
        //tmpShape.Brush.Color := MainForm.Color;
        tmpShape.ZOrder := zoTop;
        tmpShape.Visible := True;
        //tmpShape.Refresh;}

        hico := WinLoadFileIcon(src, False);
        ps := WinGetPS(bPi{tmpShape}.Handle);
        bPi.canvas.fillrect(bPi.clientrect, bPi.color);
        WinDrawPointer( ps, 0, 0, hico, 0);

  cx_icon := WinQuerySysValue(HWND_DESKTOP, SV_CXICON);
  cy_icon := WinQuerySysValue(HWND_DESKTOP, SV_CYICON);
  AssignFile(bmpfile, bmpsavepath + bmpname);
  Rewrite(bmpfile);
  Write(bmpfile, chr($42), chr($4D), chr($1A), chr($00), chr($00), chr($00), chr($10), chr($00), chr($10), chr($00), chr($1A));
  Write(bmpfile, chr($00), chr($00), chr($00), chr($0C), chr($00), chr($00), chr($00), chr(cx_icon), chr($00), chr(cy_icon), chr($00));
  Write(bmpfile, chr($01), chr($00), chr($18), chr($00));
  for __i := 0 to (cy_icon-1){31} do
    for __j := 0 to (cx_icon-1){31} do
      begin
      //rgb := tmpShape.canvas.pixels[ __j, __i ];
      rgb := bPi.canvas.pixels[ __j, __i ];
      RGBToValues(rgb, R, G, B);
      Write(bmpfile, chr(b), chr(g), chr(r));
      //Write(bmpfile, rgb);
      end;
  CloseFile(bmpfile);

        WinReleasePS(ps);
        WinFreeFileIcon(hico);
        //tmpShape.Free;

        basepath := extractfilepath(application.exename) + '\PDEConf\';

        AssignFile(afile, basepath + 'ppanel.progs');
        Reset(afile);
        Seek(afile, filesize(afile));
        //Writeln(afile);
        Writeln(afile, 'APP');
        Writeln(afile, 'defProgs\' + bmpname);
        Writeln(afile, src);
        Writeln(afile, extractfilepath(src));
        Writeln(afile);

        CloseFile(afile);

        end;

      //each process must free the shared memory !!
      FreeNamedSharedMem(TExternalDragDropObject(Source).SourceFileName);

      //update P-panel
      mReloadOnClick(Sender);
    End;
End;

Procedure TMainForm.MainFormOnDragOver (Sender: TObject; Source: TObject;
  X: LongInt; Y: LongInt; State: TDragState; Var Accept: Boolean);
Begin
Accept:=((Source Is TExternalDragDropObject)And
             (TExternalDragDropObject(Source).SourceType=drtString)And
             (TExternalDragDropObject(Source).SourceString=DragSourceId));

End;
//конец дрыг'эн'дропа :-)

Procedure TMainForm.mSettingsOnClick (Sender: TObject);
Begin
  ShellExecute(extractfilepath(application.exename)+'PDEConf.exe', '', '');
End;

Procedure TMainForm.MainFormOnDestroy (Sender: TObject);
Begin

End;

Procedure TMainForm.MainFormOnResize (Sender: TObject);
Begin
//Clock.Right:=16;
//Clock.Bottom:=1;
End;

Procedure TMainForm.Timer1OnTimer (Sender: TObject);
var
  Year, Month, Day: Word;
  h, m, s, ms: Word;
  sh, sm: string;
  memload: Word;
  totmem, freemem, swapdrive: ULong;
Begin
DecodeTime(Time, h, m, s, ms);
sh:=IntToStr(h);
if h<10 then sh:='0'+sh;
sm:=IntToStr(m);
if m<10 then sm:='0'+sm;
Clock.Caption:=sh+':'+sm;
DecodeDate(Date, Year, Month, Day);
if Day < 10 then
  lDate.Caption:=Days[DayOfWeek(Date)]+'  '+IntToStr(Day)
else
  lDate.Caption:=Days[DayOfWeek(Date)]+' '+IntToStr(Day);
lDate.Hint:=DateToStr(Date);

secProgress.Position:=s;
//DosQuerySySInfo(QSV_TOTPHYSMEM, QSV_TOTPHYSMEM, totmem, SizeOf(totmem));
//DosQuerySySInfo(QSV_TOTAVAILMEM, QSV_TOTAVAILMEM, freemem, SizeOf(freemem));
//MainForm.Caption:=IntToStr(freemem)+' '+IntToStr(totmem);
//memload:=100-(100*freemem div totmem);

//DosQuerySySInfo(QSV_BOOT_DRIVE, QSV_BOOT_DRIVE, swapdrive, SizeOf(swapdrive));
//ramProgress.Caption := IntToStr((freemem - DiskFree(swapdrive)) div 1024)+'Kb';

//ramProgress.Position:=memload;

if MainForm.zOrder<>zoTop then
  MainForm.BringToFront;

End;

Procedure TMainForm.mCloseOnClick (Sender: TObject);
Begin
application.terminate;
End;

Procedure TMainForm.MainFormOnTranslateShortCut (Sender: TObject;
  KeyCode: TKeyCode; Var ReceiveR: TForm);
begin
if keycode=kbesc then
  MMenu.Hide;

End;

Procedure TMainForm.MainFormOnShow (Sender: TObject);
var
  afile: TextFile;
  ftype, fname, fpath, fparams: String;
Begin
BorderStyle:=bsStealth;
RunUnit.RunForm.BorderStyle:=bsStealthDlg;
DeskUni2.MMenu.BorderStyle:=bsStealth;
LoadSettings;
if DynamicSize then
  begin
  MainForm.Width := indPanel2.Width+(allprogsCount+1)*(2+bPi.Width)+40;
//  if pdeLoadCfgStr('deskhalf.cfg', 'IndPanel1') = 'yes' then
//    MainForm.Width := MainForm.Width + 10 + 2 * bPi.Width;
  MainForm.Left:=(Screen.Width-MainForm.Width) div 2;
  end;
//If OnTop then MainForm.
Timer1.Start;

End;

Procedure TMainForm.bRightOnClick (Sender: TObject);
Begin
if MainForm.Left<0 then
  MainForm.Left:=(Screen.Width-MainForm.Width) div 2
else
  MainForm.Left:=Screen.Width-16;
End;

Procedure TMainForm.bLeftOnClick (Sender: TObject);
Begin
if MainForm.Left<(Screen.Width div 2) then
  MainForm.Left:=-MainForm.Width+16
else
  MainForm.Left:=(Screen.Width-MainForm.Width) div 2;
End;

Procedure TMainForm.bPiOnClick (Sender: TObject);
Begin
if MMenu.Visible then
  MMenu.Hide
  else
  MMenu.Show;
End;

Procedure TMainForm.Form1OnCreate (Sender: TObject);
var
 tbmp: TPicture;
Begin
MainForm.Height:=4 + pdeLoadCfgInt('deskhalf.cfg', 'size');
MainForm.Width:=Screen.Width;
MainForm.Left:=0;
MainForm.Top:=Screen.Height-MainForm.Height;
bPi.Width := MainForm.Height - 4;
bPi.Height := bPi.Width;
{bRoll.Width := bPi.Width;
bRoll.Height := bPi.Width;
bCalc.Width := bPi.Width;
bCalc.Height := bPi.Width;}
//indPanel1.Height := bPi.Width;
indPanel2.Height := bPi.Width;
//bPi.Top:=2;
//bPi.Left:=16;

{caption := pdeLoadNLS('ppCaption', 'П-панель');
Days[1] := pdeLoadNLS('daySundayShort', 'Вск.');
Days[2] := pdeLoadNLS('dayMondayShort', 'Пон.');
Days[3] := pdeLoadNLS('dayTuesdayShort', 'Втр.');
Days[4] := pdeLoadNLS('dayWednesdayShort', 'Срд.');
Days[5] := pdeLoadNLS('dayThursdayShort', 'Чтв.');
Days[6] := pdeLoadNLS('dayFridayShort', 'Птн.');
Days[7] := pdeLoadNLS('daySaturdayShort', 'Суб.');
mSettings.caption := pdeLoadNLS('ppmSettings', '(%)  Настройка');
mReload.caption := pdeLoadNLS('ppmReload', '(@)  Обновить');
mClose.caption := pdeLoadNLS('ppmClose', '(><)  Закрыть\tAlt+F4');
mAbout.caption := pdeLoadNLS('menuAbout', '(][)  Информация о продукте');
mMoveLeft.caption := pdeLoadNLS('ppmMoveLeft', '(<-)  Переместить');
mMoveRight.caption := pdeLoadNLS('ppmMoveRight', '(->)  Переместить');
mDelete.caption := pdeLoadNLS('ppmDelete', '(><)  Удалить');}

End;

function TMainForm.LoadSettings: integer;
var
  afile: TextFile;
  tbmp: TPicture;
  fbase, fbmp, fstr: String;
  fcolor: longint;
  cpath: cstring;
Begin
caption := pdeLoadNLS('ppCaption', 'П-панель');
Days[1] := pdeLoadNLS('daySundayShort', 'Вск.');
Days[2] := pdeLoadNLS('dayMondayShort', 'Пон.');
Days[3] := pdeLoadNLS('dayTuesdayShort', 'Втр.');
Days[4] := pdeLoadNLS('dayWednesdayShort', 'Срд.');
Days[5] := pdeLoadNLS('dayThursdayShort', 'Чтв.');
Days[6] := pdeLoadNLS('dayFridayShort', 'Птн.');
Days[7] := pdeLoadNLS('daySaturdayShort', 'Суб.');
mSettings.caption := pdeLoadNLS('ppmSettings', '(%)  Настройка');
mReload.caption := pdeLoadNLS('ppmReload', '(@)  Обновить');
mClose.caption := pdeLoadNLS('ppmClose', '(><)  Закрыть\tAlt+F4');
mAbout.caption := pdeLoadNLS('menuAbout', '(][)  Информация о продукте');
mMoveLeft.caption := pdeLoadNLS('ppmMoveLeft', '(<-)  Переместить');
mMoveRight.caption := pdeLoadNLS('ppmMoveRight', '(->)  Переместить');
mDelete.caption := pdeLoadNLS('ppmDelete', '(><)  Удалить');

fbase:=extractfilepath(application.exename)+'Bitmaps\Deskhalf\';
tbmp:=TPicture.Create(self);
allprogsCount := 0;
//color of pi-panel
MainForm.Color:=pdeLoadCfgColor('deskhalf.cfg', 'color1');
//color of p-menu
MMenu.Color:=pdeLoadCfgColor('deskhalf.cfg', 'color2');
//color of clock
Clock.Color:=pdeLoadCfgColor('deskhalf.cfg', 'color3');
//зазор
MainForm.Top:=Screen.Height-MainForm.Height-pdeLoadCfgInt('deskhalf.cfg', 'bottom');
//DynamicSize
DynamicSize := (pdeLoadCfgStr('deskhalf.cfg', 'DynamicSize') = 'yes' );
OnTop := (pdeLoadCfgStr('deskhalf.cfg', 'OnTop') = 'yes' ); //be OnTop
//IndicatorPanel1
//if (pdeLoadCfgStr('deskhalf.cfg', 'IndPanel1')='no') then indPanel1.Width:=0;
//IndicatorPanel2
if (pdeLoadCfgStr('deskhalf.cfg', 'IndPanel2')='no') then indPanel2.Width:=0;
//pi-button
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'pButton1');
tbmp.loadfromfile(fbase+fbmp); bPi.Glyph:=tbmp.Bitmap;
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'pButton2');
tbmp.loadfromfile(fbase+fbmp); bPi.GlyphDown:=tbmp.Bitmap;
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'pButton3');
tbmp.loadfromfile(fbase+fbmp); bPi.GlyphUp:=tbmp.Bitmap;
bPi.Hint := pdeLoadNLS('ppHint1', 'Нажмите кнопку для доступа к меню');
//drives
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bDrives');
tbmp.loadfromfile(fbase+fbmp); MMenu.bDisks.Glyph:=tbmp.Bitmap;
MMenu.bDisks.Caption:=pdeLoadNLS('ppDrives', 'Диски');
//programs
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bProgs');
tbmp.loadfromfile(fbase+fbmp); MMenu.bProgs.Glyph:=tbmp.Bitmap;
MMenu.bProgs.Caption:=pdeLoadNLS('ppProgs', 'Программы >');
//favorites
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bFavor');
tbmp.loadfromfile(fbase+fbmp); MMenu.bFavor.Glyph:=tbmp.Bitmap;
MMenu.bFavor.Caption:=pdeLoadNLS('ppBookmarks', 'Закладки    >');
//documents
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bDocs');
tbmp.loadfromfile(fbase+fbmp); MMenu.bDocs.Glyph:=tbmp.Bitmap;
MMenu.bDocs.Caption:=pdeLoadNLS('ppDocs', 'Документы  >');
//find
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bSearch');
findUtil := pdeLoadCfgStr('deskhalf.cfg', 'Finder');
tbmp.loadfromfile(fbase+fbmp); MMenu.bFind.Glyph:=tbmp.Bitmap;
MMenu.bFind.Caption:=pdeLoadNLS('ppFind', 'Найти');
//help
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bHelp');
tbmp.loadfromfile(fbase+fbmp); MMenu.bHelp.Glyph:=tbmp.Bitmap;
MMenu.bHelp.Caption:=pdeLoadNLS('ppHelp', 'Справка');
//run
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bRun');
tbmp.loadfromfile(fbase+fbmp);
MMenu.bRun.Glyph:=tbmp.Bitmap;
MMenu.bRun.Hint := pdeLoadNLS('ppHint2', 'Запустить программу');
//reboot
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bReset');
tbmp.loadfromfile(fbase+fbmp);
MMenu.bReboot.Glyph:=tbmp.Bitmap;
MMenu.bReboot.Hint := pdeLoadNLS('ppHint3', 'Перезагрузка');
//shutdown
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bShutdown');
tbmp.loadfromfile(fbase+fbmp);
MMenu.bShutDown.Glyph:=tbmp.Bitmap;
MMenu.bShutDown.Hint := pdeLoadNLS('ppHint4', 'Выключить компьютер');
//refresh :-)
fbmp := pdeLoadCfgStr('deskhalf.cfg', 'bSmile');
tbmp.loadfromfile(fbase+fbmp);
MMenu.bRefresh.Picture.LoadFromFile(fbase+fbmp);

assignfile(afile, extractfilepath(application.exename)+'PDEConf\ppanel.progs');
reset(afile);
readln(afile);
//quick run programs on the toolbar
i2:=0;
While not(eof(afile)) do
  begin
  inc(i2);
  readln(afile, allprogs[i2].ptype);
  {if allprogs[i2].ptype = 'APP' then
    readln(afile)
    else}
    readln(afile, allprogs[i2].pbmp);

  allprogs[i2].ptag := i2;
  readln(afile, allprogs[i2].pname);
  readln(afile, allprogs[i2].ppath);
  readln(afile, allprogs[i2].pparam);
  inc(allprogsCount);
  allprogs[i2].pBtn:=TExplorerButton.Create(self);
  allprogs[i2].pBtn.Parent:=self;
  allprogs[i2].pBtn.OnClick:=allProgspBtnClick;
  //allprogs[i2].pBtn.PopupMenu := pmApps;
  allprogs[i2].pBtn.OnMouseUp := pAppsMouseUp;
  allprogs[i2].pBtn.Width := pdeLoadCfgInt('deskhalf.cfg', 'size');
  allprogs[i2].pBtn.Height := allprogs[i2].pBtn.Width;

  //if allprogs[i2].ptype = 'FOLDER' then
  try
    tbmp.LoadFromFile(fbase+allprogs[i2].pbmp);
    except
    tbmp.bitmap:=imgNone.Picture.bitmap;
    end;

  allprogs[i2].pBtn.Glyph:=tbmp.Bitmap;
  allprogs[i2].pBtn.Hint:=allprogs[i2].pname;
  allprogs[i2].pBtn.Left:=18+i2*(2 + allprogs[i2].pBtn.Width);
  allprogs[i2].pBtn.Top:=2;
  {if allprogs[i2].ptype = 'APP' then
    begin
    allprogs[i2].pBtn.OnPaint := xbOnPaint;
    allprogs[i2].pBtn.OnMouseMove := xbOnMouseMove;
    end;}
  end;

closefile(afile);
tbmp.free;

End;

//-----------------------------------------
//запуск программ
function TMainForm.ShellExecute(fname, fdir, fparam: string): Boolean;
var
  sd: StartData;
  idSession: ULong;
  apid: PID;
  fname2, fparam2, fdir2: pchar;
  rc, rc2: APIRET;
begin
new(fname2);
new(fparam2);
new(fdir2);
StrPCopy(fname2, fname);
StrPCopy(fparam2, fparam);
StrPCopy(fdir2, fdir);
with sd do
  begin
      Length   := sizeof(StartData);
      Related  := ssf_Related_Independent; // start an independent session
      FgBg     := ssf_Fgbg_Fore;           // start session in foreground
      TraceOpt := ssf_TraceOpt_None;       // No trace
      PgmTitle := fname2;
      PgmName := fname2;
      PgmInputs :=fparam2;
      TermQ := nil;                        // No termination queue
      Environment := nil;                  // No environment string
      InheritOpt := ssf_InhertOpt_Parent;
      SessionType := ssf_Type_Default;
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
rc2:=DosStartSession(sd, idSession, apid);

freemem(fname2, sizeof(fname2));
freemem(fparam2, sizeof(fparam2));
freemem(fdir2, sizeof(fdir2));

if rc2 <> 0 then //ERROR!!!
  pdeMessageBox(pdeLoadNLS('dlgRunErrorProgram', 'Программа:')+' '+fname+chr(13)+
    chr(10)+pdeLoadNLS('dlgErrorCode', 'Код ошибки:')+' '+IntToStr(rc2)
  , pdeLoadNLS('dlgRunErrorCaption', 'Ошибка запуска'), imgNone.Bitmap);

result:=true;
end;
//--ShellExecute----------------------------

Procedure TMainForm.allProgspBtnClick(Sender: TObject);
var
  pde_base_path: String;
Begin
//нажатие на кнопки быстрого доступа
pde_base_path := extractfilepath(application.exename);
if allprogsCount>0 then
  for i2:=1 to allprogsCount do
    if (allprogs[i2].pbtn.Hint=TExplorerButton(Sender).Hint) then  //нашлась сендерша
      break;
//MessageBox(IntToStr(i2)+' '+IntToStr(i), mtInformation, [mbOK]);
if allprogs[i2].ptype='APP' then
    Begin
    if (allprogs[i2].pname[2] = ':') then //full path
      ShellExecute(allprogs[i2].pname, allprogs[i2].ppath, allprogs[i2].pparam)
      else //path from \..\pde\
      ShellExecute(pde_base_path+allprogs[i2].pname, pde_base_path+allprogs[i2].ppath, allprogs[i2].pparam);
    End
  else if allprogs[i2].ptype='FOLDER' then
    Begin
    if (allprogs[i2].pname[2] = ':') then //full path
      ShellExecute(pde_base_path+'FileHalf.exe', pde_base_path, allprogs[i2].ppath)
      else
      ShellExecute(pde_base_path+'FileHalf.exe', pde_base_path, pde_base_path+allprogs[i2].ppath);
    End
  else ;
End;

Initialization
  RegisterClasses ([TMainForm, TExplorerButton, TLabel, TPopupMenu, TMenuItem
   , TTimer, TPanel, TProgressBar, TBalloonHint, TImage, TShape, TBevel]);
End.
