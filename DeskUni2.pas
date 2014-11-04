//-----------------------------------------
//П-панель (DeskHalf), ??.08.03
Unit DeskUni2;

Interface

Uses
  Classes, Forms, Graphics, Buttons, XplorBtn, ExtCtrls, StdCtrls, sysutils
  , BSEDos, pdedlgs, pdeNLS;

Type
  TMMenu = Class (TForm)
    bHelp: TExplorerButton;
    bShutDown: TExplorerButton;
    bReboot: TExplorerButton;
    bRun: TExplorerButton;
    Bevel2: TBevel;
    bFind: TExplorerButton;
    bDocs: TExplorerButton;
    bFavor: TExplorerButton;
    bProgs: TExplorerButton;
    bDisks: TExplorerButton;
    bRefresh: TImage;
    pmProgs: TPopupMenu;
    pmFavor: TPopupMenu;
    pmDocs: TPopupMenu;
    Procedure bShutDownOnClick (Sender: TObject);
    Procedure bRebootOnClick (Sender: TObject);
    Procedure bRunOnClick (Sender: TObject);
    Procedure bHelpOnClick (Sender: TObject);
    Procedure bDocsOnClick (Sender: TObject);
    Procedure bFavorOnClick (Sender: TObject);
    Procedure MainMenuOnTranslateShortCut (Sender: TObject; KeyCode: TKeyCode;
      Var ReceiveR: TForm);
    Procedure MainMenuOnKeyPress (Sender: TObject; Var key: Char);
    Procedure bProgsOnClick (Sender: TObject);
    Procedure bFindOnClick (Sender: TObject);
    Procedure bDisksOnClick (Sender: TObject);
    Procedure MainMenuOnDeactivate (Sender: TObject);
    Procedure bProgOnClick (Sender: TObject);
    Procedure MainMenuOnCreate (Sender: TObject);
    Procedure MainMenuOnShow (Sender: TObject);

    Procedure miProgsOnClick (Sender: TObject);
    Procedure miFavorOnClick (Sender: TObject);
    Procedure miDocsOnClick (Sender: TObject);
    Procedure bRefreshOnDblClick (Sender: TObject);
    Private
      {Insert private declarations here}
    Public
    function LoadPFD(var pfdDir: string): integer;
    function LoadProgs: Integer;
    function LoadFavor: Integer;
    function LoadDocs: Integer;
      {Insert public declarations here}
  End;

Var
  MMenu: TMMenu;
  miProgs: array[1..100] of TMenuItem;
  miProgs2: array[1..100] of TMenuItem;
  miProgs3: array[1..100] of TMenuItem;

  _i, i, j, k: Integer;

Implementation

Uses
  Unit2, RunUnit;

Procedure TMMenu.bShutDownOnClick (Sender: TObject);
var
  pico: Pointer;
Begin
  //shutdown os/2 system
  //DosShutdown(0);
  if pdeLoadCfgInt('general.cfg', 'askforshutdown') = 0 then
    MainForm.ShellExecute('shutdown.exe', '', '')
    else
      begin
      pico := MainForm.Icon;
      if pdeMessageBox(chr(13)+chr(10)+pdeLoadNLS('dlgShutdownText', 'Завершить работу?'),
        pdeLoadNLS('dlgShutdownCaption', 'Завершение работы'), pico) = 0 then
        MainForm.ShellExecute('shutdown.exe', '', '');
      end;
  {ASM
  mov ax,5301h
    sub bx,bx
    int 15h
    jc @@finish
    mov ax,530Eh
    sub bx,bx
    mov cx,102h
    int 15h
    jc @@finish
    mov ax,5307h
    mov bx,1
    mov cx,3
    int 15h
@@finish:
    int 20h
  END;}
End;

Procedure TMMenu.bRebootOnClick (Sender: TObject);
var
  pico: Pointer;
Begin
  //reboot os/2 system
  //DosShutdown(0);
    if pdeLoadCfgInt('general.cfg', 'askforshutdown') = 0 then
    MainForm.ShellExecute('shutdown.exe', '', '')
    else
      begin
      pico := MainForm.Icon;
      if pdeMessageBox(chr(13)+chr(10)+pdeLoadNLS('dlgRebootText', 'Перезагрузить системму?'),
        pdeLoadNLS('dlgRebootCaption', 'Перезагрузка'), pico) = 0 then
        MainForm.ShellExecute('shutdown.exe', '', '');
      end;
End;

Procedure TMMenu.bRunOnClick (Sender: TObject);
Begin
  RunForm.Show;
End;

Procedure TMMenu.bHelpOnClick (Sender: TObject);
Begin
  if FileExists(extractfilepath(application.exename)+'pde_help_ru.inf') then
    MainForm.ShellExecute('view.exe', '', extractfilepath(application.exename)+'pde_help_ru.inf')
  else if FileExists(extractfilepath(application.exename)+'pde_help_en.inf') then
    MainForm.ShellExecute('view.exe', '', extractfilepath(application.exename)+'pde_help_en.inf')
  else if FileExists(extractfilepath(application.exename)+'readme_ru.txt') then
    MainForm.ShellExecute('e.exe', '', extractfilepath(application.exename)+'readme_ru.txt')
  else if FileExists(extractfilepath(application.exename)+'readme_en.txt') then
    MainForm.ShellExecute('e.exe', '', extractfilepath(application.exename)+'readme_en.txt')
  else MainForm.mAboutOnClick( Sender );
End;

Procedure TMMenu.bDocsOnClick (Sender: TObject);
Begin
  pmDocs.Popup(MMenu.Width+MMenu.Left, MMenu.Top-bFavor.Top);
End;

Procedure TMMenu.bFavorOnClick (Sender: TObject);
Begin
  pmFavor.Popup(MMenu.Width+MMenu.Left, bFavor.Bottom{MMenu.Top-bProgs.Top});
End;

Procedure TMMenu.MainMenuOnTranslateShortCut (Sender: TObject;
  KeyCode: TKeyCode; Var ReceiveR: TForm);
Begin
if (keycode=kbEsc) then
  MMenu.Hide;
End;

Procedure TMMenu.MainMenuOnKeyPress (Sender: TObject; Var key: Char);
Begin

End;

Procedure TMMenu.bProgsOnClick (Sender: TObject);
Begin
  pmProgs.Popup(MMenu.Width+MMenu.Left, bProgs.Bottom{MMenu.Top});
End;

Procedure TMMenu.bFindOnClick (Sender: TObject);
Begin
MainForm.ShellExecute(findUtil,'', '');
End;

Procedure TMMenu.bDisksOnClick (Sender: TObject);
Begin
  MainForm.ShellExecute(extractfilepath(application.exename)+'\FileHalf.exe', extractfilepath(application.exename),
      extractfilepath(application.exename)+pdeLoadCfgStr('general.cfg', 'userdrives')+'\');
End;

Procedure TMMenu.MainMenuOnDeactivate (Sender: TObject);
Begin
Hide;
End;

Procedure TMMenu.bProgOnClick (Sender: TObject);
var
 fpath, fname: string;
Begin
//five programs
fname:=TExplorerButton(Sender).Hint;
fpath:=extractfilepath(fname);
MMenu.Hide;
MainForm.ShellExecute(fname, fpath, '');
End;

Procedure TMMenu.bRefreshOnDblClick (Sender: TObject);
Begin
//refresh configuration
if allprogsCount>0 then
  for _i:=1 to allprogsCount do
    allprogs[_i].pBtn.Free;
MainForm.LoadSettings;
if DynamicSize then
  begin
  MainForm.Width:={MainForm.indPanel1.Width+2+}MainForm.indPanel2.Width+allprogsCount*40+78;
  MainForm.Left:=(Screen.Width-MainForm.Width) div 2;
  end;

{if i>0 then
for _i:=1 to i do
  miProgs[_i].Free;
if j>0 then
for _i:=1 to j do
  miProgs2[_i].Free;
if k>0 then
for _i:=1 to k do
  miProgs3[_i].Free;

i:=0;
j:=0;
k:=0;

LoadProgs;//load programs submenu
LoadFavor;//load favorites bookmarks
LoadDocs;//load documents}
End;

Procedure TMMenu.MainMenuOnCreate (Sender: TObject);
Begin
i:=0;
j:=0;
k:=0;

LoadProgs;//load programs submenu
LoadFavor;//load favorites bookmarks
LoadDocs;//load documents
End;

Procedure TMMenu.MainMenuOnShow (Sender: TObject);
Begin
  Left:=MainForm.Left;//16;
  Bottom:=MainForm.Height+MainForm.Bottom;
  if Top < 0 then Top := MainForm.Height;
End;

function TMMenu.LoadProgs: Integer;
var
  pfd: string;
begin
pfd := pdeLoadCfgStr('general.cfg', 'userprograms');
LoadPFD(pfd);
end;

function TMMenu.LoadFavor: Integer;
var
  pfd: string;
begin
pfd := pdeLoadCfgStr('general.cfg', 'userbookmarks');
LoadPFD(pfd);
end;

function TMMenu.LoadDocs: Integer;
var
  pfd: string;
begin
pfd := pdeLoadCfgStr('general.cfg', 'userdocs');
LoadPFD(pfd);
end;

function TMMenu.LoadPFD(var pfdDir: string): Integer;
var
  rez, rez2, rez3: integer;
  attr: byte;
  sr, sr2, sr3: TSearchRec;
  tbmp: TPicture;
begin
//tbmp:=TPicture.Create(self);
//tbmp.LoadFromFile(extractfilepath(application.exename)+'Bitmaps\FileTypes\unknown.bmp');
rez:=FindFirst(extractfilepath(application.exename)+pfdDir+'\*.*', faAnyFile, sr);
  if rez<>0 then exit;
while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.name<>'..') then
      begin
      inc(i);
      rez2:=0;
      miProgs[i]:=TMenuItem.Create(Self);
      miProgs[i].Caption:=sr.Name;

          if (pfdDir = pdeLoadCfgStr('general.cfg', 'userprograms')) then
            miProgs[i].OnClick:=miProgsOnClick
          else if (pfdDir = pdeLoadCfgStr('general.cfg', 'userbookmarks')) then
            miProgs[i].OnClick:=miFavorOnClick
          else if (pfdDir = pdeLoadCfgStr('general.cfg', 'userdocs')) then
            miProgs[i].OnClick:=miDocsOnClick;

      if (pfdDir = pdeLoadCfgStr('general.cfg', 'userprograms')) then
        pmProgs.Items.Add(miProgs[i])
      else if (pfdDir = pdeLoadCfgStr('general.cfg', 'userbookmarks')) then
        pmFavor.Items.Add(miProgs[i])
      else pmDocs.Items.Add(miProgs[i]);

//      miProgs[i].Glyph.LoadFromFile(extractfilepath(application.exename)+'Bitmaps\FileTypes\unknown.bmp');//:=tbmp.Graphic;

      if (sr.attr and faDirectory)<>0 then
        begin
        miProgs[i].SubMenu:=True;
        rez2:=FindFirst(extractfilepath(application.exename)+pfdDir+'\'+sr.name+'\*.*', faAnyFile, sr2);
        while rez2=0 do
          begin
          rez2:=FindNext(sr2);
          if rez2<>0 then break;
          if (sr2.name<>'..') then
          begin
          inc(j);
          rez3:=0;
          miProgs2[j]:=TMenuItem.Create(Self);
          miProgs2[j].Caption:=sr2.Name;

          if pfdDir = pdeLoadCfgStr('general.cfg', 'userprograms') then
            miProgs2[j].OnClick:=miProgsOnClick
          else if pfdDir = pdeLoadCfgStr('general.cfg', 'userbookmarks') then
            miProgs2[j].OnClick:=miFavorOnClick
          else if pfdDir = pdeLoadCfgStr('general.cfg', 'userdocs') then
            miProgs2[j].OnClick:=miDocsOnClick;

          miProgs[i].Add(miProgs2[j]);
          if (sr2.attr and faDirectory)<>0 then
            begin
            miProgs2[j].SubMenu:=True;
            rez3:=FindFirst(extractfilepath(application.exename)+pfdDir+'\'+sr.name+'\'+sr2.name+'\*.*', faAnyFile, sr3);
            while rez3=0 do
              begin
              rez3:=FindNext(sr3);
              if rez3<>0 then break;
              if (sr3.name<>'..') then
                begin
                inc(k);
                miProgs3[k]:=TMenuItem.Create(Self);
                miProgs3[k].Caption:=sr3.Name;

                      if pfdDir = pdeLoadCfgStr('general.cfg', 'userprograms') then
                  miProgs3[k].OnClick:=miProgsOnClick
                else if pfdDir = pdeLoadCfgStr('general.cfg', 'userbookmarks') then
                  miProgs3[k].OnClick:=miFavorOnClick
                else if pfdDir = pdeLoadCfgStr('general.cfg', 'userdocs') then
                  miProgs3[k].OnClick:=miDocsOnClick;

                miProgs2[j].Add(miProgs3[k]);
                end;
              end;
            FindClose(sr3);
            end;
          end;
          end;
          FindClose(sr2);
        end;
      end;
    end;
  FindClose(sr);
//tbmp.free;
end;

Procedure TMMenu.miProgsOnClick (Sender: TObject);
var
  bpath: string;
  afile: TextFile;
  ftype, fname, fpath, fparams: string;
begin
bpath:=TMenuItem(Sender).Caption;
if (TMenuItem(Sender).Parent.ClassName='TMenuItem') then
  bpath:=TMenuItem(Sender).Parent.Caption+'\'+bpath;
if (TMenuItem(Sender).Parent.Parent.ClassName='TMenuItem') then
  bpath:=TMenuItem(Sender).Parent.Parent.Caption+'\'+bpath;
bpath:=extractfilepath(application.exename)+pdeLoadCfgStr('general.cfg', 'userprograms')+'\'+bpath;
assignfile(afile, bpath);
reset(afile);
readln(afile, ftype);
if ftype='[SHORTCUT]' then
  begin
  readln(afile);
  readln(afile, ftype);
  readln(afile, fname);
  readln(afile, fpath);
  readln(afile, fparams);

  if ftype='APP' then
    MainForm.shellexecute(fname, fpath, fparams)
  else if ftype='FOLDER' then
    MainForm.shellexecute(extractfilepath(application.exename)+'FileHalf.exe',extractfilepath(application.exename), fname);
  end;
closefile(afile);
end;

Procedure TMMenu.miFavorOnClick (Sender: TObject);
var
  bpath: string;
  afile: TextFile;
  ftype, fname, fpath, fparams: string;
begin
bpath:=TMenuItem(Sender).Caption;
if (TMenuItem(Sender).Parent.ClassName='TMenuItem') then
  bpath:=TMenuItem(Sender).Parent.Caption+'\'+bpath;
if (TMenuItem(Sender).Parent.Parent.ClassName='TMenuItem') then
  bpath:=TMenuItem(Sender).Parent.Parent.Caption+'\'+bpath;
bpath:=extractfilepath(application.exename)+pdeLoadCfgStr('general.cfg', 'userbookmarks')+'\'+bpath;
assignfile(afile, bpath);
reset(afile);
readln(afile);
readln(afile, ftype);
readln(afile, fname);
readln(afile, fpath);
readln(afile, fparams);

if ftype='APP' then
  MainForm.shellexecute(fname, fpath, fparams)
else if ftype='FOLDER' then
  MainForm.shellexecute(extractfilepath(application.exename)+'FileHalf.exe',extractfilepath(application.exename), fname);

closefile(afile);
end;

Procedure TMMenu.miDocsOnClick (Sender: TObject);
begin

end;

Initialization
  RegisterClasses ([TMMenu, TExplorerButton, TBevel, TImage, TPopupMenu]);
End.
