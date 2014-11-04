(*////////////////////////////////////////////////////
//    ПDE -  оболочка пользователя OS/2 Warp
//    Copyleft stVova, [ПDE-Team], 2003
//    http://os2progg.by.ru/pde
//    Модуль крутых диалогов, используемых программами
//    ПDE desktop.
/////////////////////////////////////////////////////*)
(*////////////////////////////////////////////////////
//    PDE -  graphical user shell for OS/2 Warp
//    Copyleft stVova, [PDE-Team], 2003
//    http://os2progg.by.ru/pde
//    Cool dialogs module. It used by all programs of
//    PDE desktop.
/////////////////////////////////////////////////////*)

{TODO:
  pdeOpenFileDialog
- ентер при создании папки заставляет PDEListBox перейти ".."
- медленно удаляются\добавляются обьекты в PDEListBox
- ентер в edPath - передаётся к PDEListBox и переходит к ".."
- определение буквы cd-rom
- enter, esc не действуют на bOK и bCancel как модально
}

Unit Pdedlgs;

Interface

Uses
  Classes, Forms, Graphics, Buttons, ExtCtrls, StdCtrls
  , CustomFileControls, Dialogs, PDEListbox, XplorBtn
  , SysUtils, Dos, FileCtrl, DirectoryEdit, BseDos, TabCtrls, pdeNLS
  , ColorWheel;

Type

  TCopyDlg = class(TForm)
    Label1: TLabel;
    DirLab: TLabel;
    SrcName: TEdit;
    DestName: TEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Drive: TCustomDriveComboBox;
    Dir: TCustomDirectoryListBox;
    bCopy: TButton;
    bCancel: TButton;

    Tabs: TTabSet;
    GroupBox2: TGroupBox;
    DirLab2: TLabel;
    ListBox1: TListBox;
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    Constructor Create(AOwner:TComponent); Override;
    Destructor Destroy; Override;
    Procedure TabChange (Sender: TObject; NewTab: LongInt;
      Var AllowChange: Boolean);
    Procedure ListBoxOnItemSelect (Sender: TObject; Index: LongInt);
  End;

  TMsgDlg = class(TForm)
    Label1: TLabel;
    bOk: TButton;
    bCancel: TButton;
    pImg: TImage;
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    Constructor Create(AOwner:TComponent); Override;
  End;

  {крутой файловый диалог с исп. TPDEListBox}
  TPDEOpenDialog = class(TForm)
    pList: TPDEListbox;
    bOK: Tbutton;
    bCancel: Tbutton;
    Label1: TLabel;
    Label2: TLabel;
    edName: TEdit;
    edPath: TDirectoryEdit;
    cbMask: TCombobox; //фильтр
    drBox: TDriveComboBox; //выбор диска
    tBar: TToolbar;
    pPanel: TPanel;
    xbUp: TExplorerButton;
    xbRefresh: TExplorerButton;
    xbNew: TExplorerButton;
    xbBookmarks: TExplorerButton; //вызывает меню закладок
    xbAddBookmark: TExplorerButton;
    bmMenu: TPopupmenu; //а вот и меню закладок
    bookItem: TMenuItem;
    xbHome: TExplorerButton;
    xbDocs: TExplorerButton;
    xbCdrom: TExplorerButton;
    xbFloppy: TExplorerButton;
    bmpDir: TBitmap;
    bmpFile: Tbitmap;
    wasBkSp: Boolean;
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    Constructor Create(AOwner:TComponent); Override;
    procedure drBoxChange (Sender: TObject);
    procedure cbMaskItemSelect(Sender: TObject; Index: LongInt);
    procedure xbUpClick (Sender: TObject);
    procedure xbRefreshClick (Sender: TObject);
    procedure xbNewClick (Sender: TObject);
    procedure xbBookmarksClick (Sender: TObject);
    procedure xbAddBookmarkClick (Sender: TObject);
    procedure BookmarkClick (Sender: TObject);
    procedure xbHomeClick (Sender: TObject);
    procedure xbDocsClick (Sender: TObject);
    procedure xbCdromClick (Sender: TObject);
    procedure xbFloppyClick (Sender: TObject);
    Procedure drEditChangeDir (NewDir: String);
    Procedure pdeOpenDialogTranslateShortcut(Sender: TObject; KeyCode: TKeyCode;
  Var ReceiveR: TForm);
  End;

  TPromptDlg = class(TForm)
    Label1: TLabel;
    bOk: TButton;
    bCancel: TButton;
    edresult: TEdit;
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    Constructor Create(AOwner:TComponent); Override;
  End;

  TAboutDlg = class(TForm)
    imgLogo: TImage;
    lName : TLabel;
    bClose: TButton;
    tsTabs: TTabSet;
    pPanel: TPanel;
    mInfo : TMemo;

    about: TStringList;
    authors: TStringList;
    thanks: TStringList;
    licensefile: String;
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    Constructor Create(AOwner:TComponent); Override;
    Procedure TabsChange(Sender: TObject; NewTab: LongInt;
      Var AllowChange: Boolean);
  End;

  {cool color choose dialog}
  TPDEColorDlg = class(TForm)
    ColorWheel: TColorWheel;
    ValueBar: TValueBar;
    Shape: TShape;
    lRed: TLabel;
    lGreen: TLabel;
    lBlue: TLabel;
    edRed: TEdit;
    edGreen: TEdit;
    edBlue: TEdit;
    Bevel: TBevel;
    bOK: TButton;
    bCancel: TButton;
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
    Constructor Create(AOwner:TComponent); Override;
    procedure ColorChange(Sender: TObject);
    procedure EditChange (Sender: TObject);
  End;

function pdeCopyDialog(src, text: String): String;
function pdeMessageBox(text, cptn: String; bmp: Tbitmap): Integer;
function pdePromptDialog(text, cptn: String): String;
function pdeOpenFileDialog(cptn, directory, mask: String): String;
function pdeAboutDialog(about, authors, thanks: TStringList; cptn, text,
  licensefile: String; logo: TIcon): Integer;
function pdeColorDialog(var Color: TColor): Boolean;

function LoadBookmarks(Box: TListBox): Integer;

Implementation

Constructor TCopyDlg.Create(AOwner:TComponent);
Begin
Inherited Create(AOwner);
BorderStyle := bsDialog;
ClientWidth := 290; ClientHeight := 405;
Position := poScreenCenter; BorderIcons :=[];
Font.Name := 'WarpSans:9'; Caption := 'Копирование';

Label1 := TLabel.Create(Self);
Label1.Parent := Self;
Label1.Caption := pdeLoadNLS('dlgSourceName', 'Исходное имя:');
Label1.AutoSize := True;
Label1.Left := 10; Label1.Top := 3;
Label1.Align := alFixedLeftTop;

Label2 := TLabel.Create(Self);
Label2.Parent := Self;
Label2.Caption := pdeLoadNLS('dlgDestName', 'Новое имя:');
Label2.AutoSize := True;
Label2.Left := 10; Label2.Top := 43;
Label2.Align := alFixedLeftTop;

SrcName := TEdit.Create(Self);
SrcName.Parent := Self;
SrcName.Width := 270;
SrcName.Text := '';
SrcName.Left := 10; SrcName.Top := 19;
SrcName.Align := alFixedLeftTop;
SrcName.readOnly := True;

DestName := TEdit.Create(Self);
DestName.Parent := Self;
DestName.Width := 270;
DestName.Left := 10; DestName.Top := 59;
DestName.Text := '';
DestName.Align := alFixedLeftTop;

GroupBox1 := TGroupBox.Create(Self);
GroupBox1.Parent := Self;
GroupBox1.Caption := pdeLoadNLS('dlgChooseDest', 'Выберите место назначения');
GroupBox1.Width := 270;
GroupBox1.Height := 262;
GroupBox1.Left := 10;
GroupBox1.top := 79;
GroupBox1.Align := alFixedLeftTop;
GroupBox1.ZOrder := zoBottom;

Drive := TCustomDriveComboBox.Create(Self);
Drive.Parent := GroupBox1;
Drive.Width := 262;
Drive.Left := 4;
Drive.Top := 18;
Drive.Align := alFixedLeftTop;

Dir := TCustomDirectoryListBox.Create(Self);
Dir.Parent := GroupBox1;
Drive.DirList := Dir;
Dir.Width := 262;
Dir.Height := 195;
Dir.Left := 4;
Dir.Top := 42;
Dir.Align := alFixedLeftTop;

DirLab := TLabel.Create(Self);
DirLab.Parent := Self;
DirLab.Caption := '';
DirLab.AutoSize := True;
DirLab.Left := 14;
DirLab.Top := 320;
DirLab.Align := alFixedLeftTop;
Dir.DirLabel := DirLab;

bCopy := TButton.Create(Self);
bCopy.Parent := Self;
bCopy.Width := 100;
bCopy.Left := 95;
bCopy.Top := 364;
bCopy.Caption := pdeLoadNLS('dlgCopyButton', 'Копировать');
bCopy.Command := cmOK;
bCopy.ModalResult := cmOK;
bCopy.Default := True;
bCopy.Align := alFixedLeftTop;
//Copy.OnClick := CopyBtnClick;

bCancel := TButton.Create(Self);
bCancel.Parent := Self;
bCancel.Left := 200;
bCancel.Top := 364;
bCancel.Caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
bCancel.Command := cmCancel;
bCancel.ModalResult := cmCancel;
bCancel.Align := alFixedLeftTop;
bCancel.Cancel := True;
//Cancel.OnClick := CancelBtnClick;

Tabs := TTabSet.Create(Self);
Tabs.Parent := Self;
Tabs.DitherBackground := False;
Tabs.Height := 20;
Tabs.Width := 266;
Tabs.Left := 10;
Tabs.Top := 341;
Tabs.Align := alFixedLeftTop;
Tabs.Tabs.Add(pdeLoadNLS('menuGotoDrives', 'Диски'));
Tabs.Tabs.Add(pdeLoadNLS('menuBookmarks', 'Закладки'));
Tabs.TabIndex := 0;
Tabs.OnChange := TabChange;

GroupBox2 := TGroupBox.Create(Self);
GroupBox2.Parent := Self;
GroupBox2.Caption := pdeLoadNLS('dlgChooseDest', 'Выберите место назначения');
GroupBox2.Width := 270;
GroupBox2.Height := 262;
GroupBox2.Left := 10;
GroupBox2.Top := 79;
GroupBox2.Align := alFixedLeftTop;
GroupBox2.ZOrder := zoTop;
GroupBox2.Visible := False;

DirLab2 := TLabel.Create(Self);
DirLab2.Parent := GroupBox2;
DirLab2.Caption := '';
DirLab2.AutoSize := True;
DirLab2.Left := 4;
DirLab2.Top := 241;
DirLab2.Align := alFixedLeftTop;

ListBox1 := TListBox.Create(Self);
ListBox1.Parent := GroupBox2;
ListBox1.Width := 262;
ListBox1.Height := 219;
ListBox1.Left := 4;
ListBox1.Top := 18;
ListBox1.Align := alFixedLeftTop;
ListBox1.OnItemSelect := ListBoxOnItemSelect;

LoadBookmarks(ListBox1);

End;

Destructor TCopyDlg.Destroy;
Begin
{Label1.Free;
SrcName.Free;
DestName.Free;
Label2.Free;
GroupBox1.Free;
Drive.Free;
Dir.Free;
bCopy.Free;
bCancel.Free;}

Inherited Destroy;
End;

Procedure TCopyDlg.ListBoxOnItemSelect (Sender: TObject; Index: LongInt);
Begin
  DirLab2.Caption := ListBox1.Items[Index];
End;

Procedure TCopyDlg.TabChange (Sender: TObject; NewTab: LongInt;
  Var AllowChange: Boolean);
Begin
  if NewTab = 0 then
    begin
    GroupBox2.Visible := False;
    end
  else
    begin
    GroupBox2.Visible := True;
    end;
  AllowChange := True;
End;

//-----------------------------------------

Constructor TMsgDlg.Create(AOwner:TComponent);
Begin
Inherited Create(AOwner);
BorderStyle := bsDialog;
Width := 352;
Height := 125;
Position := poScreenCenter;
BorderIcons :=[];
Font.Name := 'WarpSans:9';
Caption := 'Внимание!';

Label1 := TLabel.Create(Self);
Label1.Parent := Self;
Label1.Caption := '';
Label1.AutoSize := False;
Label1.WordWrap := True;
Label1.Left := 60;
Label1.Top := 4;
Label1.Align := alFixedLeftTop;
Label1.Width := 280;
Label1.Height := 75;

bOk := TButton.Create(Self);
bOk.Parent := Self;
bOk.Left := 175;
bOk.Top := 62;
bOk.Caption := pdeLoadNLS('dlgOkButton', 'OK');
bOk.Command := cmOK;
bOk.ModalResult := cmOK;
bOk.Default := True;
bOk.Align := alFixedLeftTop;

bCancel := TButton.Create(Self);
bCancel.Parent := Self;
bCancel.Left := 260;
bCancel.Top := 62;
bCancel.Caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
bCancel.Command := cmCancel;
bCancel.ModalResult := cmCancel;
bCancel.Align := alFixedLeftTop;
bCancel.Cancel := True;

pImg := TImage.Create(Self);
pImg.Parent := Self;
pImg.Autosize := True;
pImg.Width := 32;
pImg.Height := 32;
pImg.Left := 4;
pImg.Top := 12;
pImg.Align := alFixedLeftTop;

End;

//-----------------------------------------

Constructor TPromptDlg.Create(AOwner:TComponent);
Begin
Inherited Create(AOwner);
BorderStyle := bsDialog;
Width := 300;
Height := 125;
Position := poScreenCenter;
BorderIcons :=[];
Font.Name := 'WarpSans:9';
Caption := 'Диалог';

Label1 := TLabel.Create(Self);
Label1.Parent := Self;
Label1.Caption := '';
Label1.AutoSize := False;
Label1.WordWrap := True;
Label1.Left := 8;
Label1.Top := 8;
Label1.Align := alFixedLeftTop;
Label1.Width := 275;
Label1.Height := 20;

edResult:= TEdit.Create(Self);
edResult.parent := Self;
edResult.width := 275;
edResult.left := 8;
edResult.top := 35;
edResult.align := alfixedlefttop;

bOk := TButton.Create(Self);
bOk.Parent := Self;
bOk.Height := 24;
bOk.Left := 120;
bOk.Top := 65;
bOk.Caption := pdeLoadNLS('dlgOkButton', 'OK');
bOk.Command := cmOK;
bOk.ModalResult := cmOK;
bOk.Default := True;
bOk.Align := alFixedLeftTop;

bCancel := TButton.Create(Self);
bCancel.Parent := Self;
bCancel.Height := 24;
bCancel.Left := 205;
bCancel.Top := 65;
bCancel.Caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
bCancel.Command := cmCancel;
bCancel.ModalResult := cmCancel;
bCancel.Align := alFixedLeftTop;
bCancel.Cancel := True;

End;

//-----------------------------------------

function pdeCopyDialog(src, text: String): String;
var
  cpDlg: TCopyDlg;
Begin
cpDlg := TCopyDlg.Create(Application.MainForm);
cpDlg.Caption := text;//'Копировать';
cpDlg.SrcName.Text := src;
cpDlg.DestName.Text := src;
cpDlg.bCopy.Caption := text;
Result := '';
if cpDlg.ShowModal = cmOK then
  begin
  if cpDlg.Tabs.TabIndex = 0 then
    Result := cpDlg.DirLab.Caption+'\'+cpDlg.DestName.Text
    else
    Result := cpDlg.DirLab2.Caption+cpDlg.DestName.Text;
  end;
if cpDlg<>nil then
  cpDlg.Free;
End;

function pdeMessageBox(text, cptn: String; bmp: Tbitmap): Integer;
var
  msgDlg: TMsgDlg;
Begin
msgDlg := TMsgDlg.Create(Application.MainForm);;
msgDlg.Caption := cptn;
msgDlg.Label1.Caption := text;
if bmp <> nil then
  msgDlg.pImg.Bitmap := bmp;
Result := 1;
if msgDlg.ShowModal = cmOk then
  Result := 0;

if msgDlg<>nil then
  msgDlg.Free;
End;

//-----------------------------------------

//PDE FILE OPEN/SAVE DIALOG
Constructor TPDEOpenDialog.Create(AOwner:TComponent);
var
  basepath: String;
  pclr: TColor;
  afile: TextFile;
  tsr: TSearchRec;
  itext: String;
  rez: Integer;
  //fnt: TFont;
Begin
pclr := clNavy;

Inherited Create(AOwner);
  BorderStyle := bsDialog;
  Width := 500;
  Height := 400;
  Position := poScreenCenter;
  BorderIcons :=[biSystemMenu, biMinimize];
  Font.Name := 'WarpSans:9';
  Caption := 'Файловый диаалог';
  OnTranslateShortcut := pdeOpenDialogTranslateShortcut;

  tBar:= TToolbar.Create(Self);
  tBar.parent := Self;
  tBar.Alignment := tbTop;
  tBar.bevelstyle := tbNone;
  tBar.size := 32;
  tBar.visible := true;
  pPanel:= TPanel.Create(Self);
  pPanel.parent := Self;
  pPanel.color := pclr;
  pPanel.Align := alleft;
  pPanel.bevelouter := bvLowered;
  pPanel.width := 100;
  pPanel.visible := true;
  pList:= TPDEListbox.Create(Self);
  pList.parent := Self;
  pList.width := 385;
  pList.height := 275;
  pList.left := 105;
  pList.top := 0;
  pList.color := clwhite;

  //fnt := screen.createcompatiblefont(font);
  //fnt.attributes := [fabold];

  bOK:= Tbutton.Create(Self);
  bOK.parent := Self;
  bOK.width := 80;
  bOK.height := 24;
  bOK.left := 410;
  bOK.top := 282;
  bOK.align := alfixedlefttop;
//  bOK.font := fnt;
  bOK.modalresult := cmOk;
  bOK.caption := pdeLoadNLS('dlgOkButton', 'OK');
  bOK.command := cmOk;
  bOK.default := true;

  bCancel:= Tbutton.Create(Self);
  bCancel.parent := Self;
  bCancel.width := 80;
  bCancel.height := 24;
  bCancel.left := 410;
  bCancel.top := 307;
  bCancel.align := alfixedlefttop;
//  bCancel.font := fnt;
  bCancel.modalresult := cmCancel;
  bCancel.caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
  bCancel.command := cmCancel;
  bCancel.Cancel := True;

  Label1:= TLabel.Create(Self);
  Label1.parent := Self;
  Label1.left := 105;
  Label1.top := 290;
  Label1.align := alfixedlefttop;
  Label1.caption := pdeLoadNLS('pdeDlgChoose', 'Выбор:');
//  Label1.font := fnt;
  Label1.autosize := true;
  Label1.visible := true;

  Label2:= TLabel.Create(Self);
  Label2.parent := Self;
  Label2.left := 105;
  Label2.top := 315;
  Label2.align := alfixedlefttop;
  Label2.caption := pdeLoadNLS('pdeDlgFilter', 'Фильтр:');
//  Label2.font := fnt;
  Label2.autosize := true;
  Label2.visible := true;

  edName:= TEdit.Create(Self);
  edName.parent := Self;
  edName.width := 220;
  edName.left := 170;
  edName.top := 285;
  edName.align := alfixedlefttop;
  edName.showhint := true;
  edName.Hint := pdeLoadNLS('pdeDlgHint1', 'Имя выбранного обьекта');
  edName.visible := true;

  edPath:= TDirectoryEdit.Create(Self);
  edPath.parent := tBar;
  edPath.width := 235;
  edPath.left := 255;
  edPath.top := 8;
  edPath.align := alfixedlefttop;
  edPath.showhint := true;
  edPath.Hint := pdeLoadNLS('pdeDlgHint2', 'Путь к файлу');
  edPath.OnChangeDirectory := drEditChangeDir;
  edPath.visible := true;

  drBox:= TDriveComboBox.Create(Self);
  drBox.parent := tBar;
  drBox.width := 100;
  drBox.top := 8;
  drBox.left := 154;//105;
  drBox.align := alfixedlefttop;
  drBox.onchange := drBoxChange;
  drBox.visible := true;

  cbMask:= TCombobox.Create(Self);
  cbMask.parent := Self;
  cbMask.width := 220;
  cbMask.top := 310;
  cbMask.left := 170;
  //cbMask.style := csDropDownList;
  cbMask.align := alfixedlefttop;
  cbMask.onitemselect := cbMaskItemselect;
  cbMask.visible := true;

  xbUp:= TExplorerButton.Create(Self);
  xbUp.parent := tBar;
  xbUp.width := 28;
  xbUp.height :=28;
  xbUp.left := 2;
  xbUp.top := 2;
  xbUp.ShowHint := True;
  xbUp.Hint := pdeLoadNLS('pdeDlgHint3', 'Перейти на уровень вверх');
  xbUp.align := alfixedlefttop;
  xbUp.onclick := xbUpClick;

  xbRefresh:= TExplorerButton.Create(Self);
  xbRefresh.parent := tBar;
  xbRefresh.width := 28;
  xbRefresh.height :=28;
  xbRefresh.left := 32;
  xbRefresh.top := 2;
  xbRefresh.ShowHint := True;
  xbRefresh.Hint := pdeLoadNLS('pdeDlgHint4', 'Обновить');
  xbRefresh.align := alfixedlefttop;
  xbRefresh.onclick := xbRefreshClick;

  xbNew:= TExplorerButton.Create(Self);
  xbNew.parent := tBar;
  xbNew.width := 28;
  xbNew.height :=28;
  xbNew.left := 62;
  xbNew.top := 2;
  xbNew.ShowHint := True;
  xbNew.Hint := pdeLoadNLS('pdeDlgHint5', 'Создать папку');
  xbNew.align := alfixedlefttop;
  xbNew.onclick := xbNewClick;

  bmMenu:= TPopupMenu.Create(Self);
  bmMenu.Alignment := paLeft;

  xbBookmarks:= TExplorerButton.Create(Self);
  xbBookmarks.parent := tBar;
  xbBookmarks.width := 28;
  xbBookmarks.height :=28;
  xbBookmarks.left := 92;
  xbBookmarks.top := 2;
  xbBookmarks.ShowHint := True;
  xbBookmarks.Hint := pdeLoadNLS('pdeDlgHint6', 'Закладки');
  xbBookmarks.align := alfixedlefttop;
  xbBookmarks.onclick := xbBookmarksClick;

  xbAddBookmark:= TExplorerButton.Create(Self);
  xbAddBookmark.parent := tBar;
  xbAddBookmark.width := 28;
  xbAddBookmark.height :=28;
  xbAddBookmark.left := 122;
  xbAddBookmark.top := 2;
  xbAddBookmark.ShowHint := True;
  xbAddBookmark.Hint := pdeLoadNLS('pdeDlgHint7', 'Добавить закладку');
  xbAddBookmark.align := alfixedlefttop;
  xbAddBookmark.onclick := xbAddBookmarkClick;

  xbHome:= TExplorerButton.Create(Self);
  xbHome.parent := pPanel;
  xbHome.width := 80;
  xbHome.height :=60;
  xbHome.left := 10;
  xbHome.top := 20;
  xbHome.PenColor := clWhite;
  xbHome.caption := pdeLoadNLS('pdeDlgHomeFolder', 'Домашняя папка');
  xbHome.color := pclr;
  xbHome.layout := blGlyphTop;
  xbHome.align := alfixedlefttop;
  xbHome.onclick := xbHomeClick;

  xbDocs:= TExplorerButton.Create(Self);
  xbDocs.parent := pPanel;
  xbDocs.width := 80;
  xbDocs.height :=60;
  xbDocs.left := 10;
  xbDocs.top := 90;
  xbDocs.PenColor := clWhite;
  xbDocs.caption := pdeLoadNLS('pdeDlgDocsFolder', 'Документы');
  xbDocs.color := pclr;
  xbDocs.layout := blGlyphTop;
  xbDocs.align := alfixedlefttop;
  xbDocs.onclick := xbDocsClick;

  xbCdrom:= TExplorerButton.Create(Self);
  xbCdrom.parent := pPanel;
  xbCdrom.width := 80;
  xbCdrom.height :=60;
  xbCdrom.left := 10;
  xbCdrom.top := 160;
  xbCdrom.PenColor := clWhite;
  xbCdrom.caption := pdeLoadNLS('pdeDlgCDROM', 'CD-ROM');
  xbCdrom.color := pclr;
  xbCdrom.layout := blGlyphTop;
  xbCdrom.align := alfixedlefttop;
  xbCdrom.onclick := xbCdromClick;

  xbFloppy:= TExplorerButton.Create(Self);
  xbFloppy.parent := pPanel;
  xbFloppy.width := 80;
  xbFloppy.height :=60;
  xbFloppy.left := 10;
  xbFloppy.top := 230;
  xbFloppy.PenColor := clWhite;
  xbFloppy.caption := pdeLoadNLS('pdeDlgFloppy', 'Флоппи');
  xbFloppy.color := pclr;
  xbFloppy.layout := blGlyphTop;
  xbFloppy.align := alfixedlefttop;
  xbFloppy.onclick := xbFloppyClick;

  bmpDir:= TBitmap.Create;
  bmpFile:= TBitmap.Create;

  //-----------
  pList.selectedname := edName;
  pList.selectedpath := edPath;
  pList.dirbitmap := bmpDir;
  pList.filebitmap := bmpFile;

  basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

//-----загрузка Закладок-------------------
rez:=FindFirst(basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+'\*.*',
  faAnyFile, tsr);
  while rez=0 do
    begin
    rez:=FindNext(tsr);
    if rez<>0 then break;
    if (tsr.attr and faDirectory)=0 then //file
      begin
      assignfile(afile, basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+
        '\'+tsr.name);
      reset(afile);
      readln(afile); readln(afile); readln(afile);
      readln(afile, itext);

      bookitem:=TMenuItem.Create(self);
      bookitem.Caption:=tsr.name;
      bookitem.hint:=itext;
      bookitem.onclick:=BookMarkClick;
      bmMenu.Items.add(bookitem);

      closefile(afile);
      end;
    end;
FindClose(tsr);
//-----------------------------------------

  basepath := basepath + '\bitmaps\dialogs\';

  xbUp.glyph.loadfromfile(basepath + 'up.bmp');
  xbRefresh.glyph.loadfromfile(basepath + 'refresh.bmp');
  xbNew.glyph.loadfromfile(basepath + 'new.bmp');
  xbBookmarks.glyph.loadfromfile(basepath + 'bookmark.bmp');
  xbAddBookmark.glyph.loadfromfile(basepath + 'addbookmark.bmp');
  xbHome.glyph.loadfromfile(basepath + 'home.bmp');
  xbDocs.glyph.loadfromfile(basepath + 'docs.bmp');
  xbCdrom.glyph.loadfromfile(basepath + 'cdrom.bmp');
  xbFloppy.glyph.loadfromfile(basepath + 'floppy.bmp');
  bmpDir.LoadFromFile(basepath + 'folder.bmp');
  bmpFile.LoadFromFile(basepath + 'file.bmp');

  {pList.visible := true;
  xbUp.visible := true;
  xbRefresh.visible := true;
  xbNew.visible := true;
  xbHome.visible := true;
  xbDocs.visible := true;
  xbCdrom.visible := true;
  xbFloppy.visible := true;}

End;

Procedure TPDEOpenDialog.drBoxChange (Sender: TObject);
Begin
  pList.path:= drBox.Drive + ':\';
End;

procedure TPDEOpenDialog.cbMaskItemSelect(Sender: TObject; Index: LongInt);
var
  s: String;
Begin
  s := cbMask.Items[index];
  delete(s, 1, pos('(', s));
  delete(s, length(s), 1);
  pList.mask := s;
End;

procedure TPDEOpenDialog.xbUpClick (Sender: TObject);
var
  temp: String;
Begin
  temp := pList.path;
  if (length(temp) <= 3) then exit;
  if temp[length(temp)]='\' then Delete(temp, length(temp), 1);
  while temp[length(temp)]<>'\' do
    Delete(temp, length(temp), 1);

  pList.Path := temp;
End;

procedure TPDEOpenDialog.xbRefreshClick (Sender: TObject);
Begin
  pList.Clear;
  //pList.LoadFromPath;
End;

procedure TPDEOpenDialog.xbNewClick (Sender: TObject);
var
  newname: String;
Begin
  newname := pdePromptDialog(pdeLoadNLS('pdeDlgCreateFolder', 'Введите имя новой папки')
    , pdeLoadNLS('pdeDlgHint5', 'Создать папку'));
  if newname <> '' then
    begin
    if DosCreateDir(pList.Path + newname, nil) <> 0 then
      pdeMessageBox(pdeLoadNLS('dlgErrorOnFolderCreate', 'Hе удается создать папку.')
        , pdeLoadNLS('dlgError', 'Ошибка'), xbHome.Glyph);
    pList.Clear;
    end;
End;

procedure TPDEOpenDialog.xbBookmarksClick (Sender: TObject);
var
  p: TPoint;
Begin
  //p := ClientToScreen(Point(xbBookmarks.Left, xbBookmarks.Top));
  //bmMenu.Popup(p.x, p.y);
  bmMenu.Popup(TForm(Self).Left + xbBookmarks.Left + 4,
    Screen.Height - TForm(Self).Top - xbBookmarks.Height - bmMenu.Height - 20);
End;

procedure TPDEOpenDialog.xbAddBookmarkClick (Sender: TObject);
var
  basepath, fname: String;
  afile: TextFile;
Begin
//Добавление закладки
  basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

fname:=pList.path;
if length(fname)>3 then
  begin
  delete(fname, length(fname), 1);
  while pos('\', fname)<>0 do
    delete(fname, 1, 1);
  end;
  assignfile(afile, basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+'\['+fname+']');
  rewrite(afile);
  writeln(afile, '[SHORTCUT]');
  writeln(afile, '//link: type, object-name, path, parameters');
  writeln(afile, 'FOLDER');
  writeln(afile, pList.path);
  writeln(afile, pList.path);
  writeln(afile);
  closefile(afile);

  bookitem:=TMenuItem.Create(self);
  bookitem.Caption:='['+fname+']';
  bookitem.hint:=pList.path;
  bookitem.onclick:=BookMarkClick;
  bmMenu.Items.add(bookitem);
End;

procedure TPDEOpenDialog.BookmarkClick (Sender: TObject);
Begin
  //щелчок по пункту bookmark-меню
  pList.Path := TMenuItem(Sender).Hint;
End;

procedure TPDEOpenDialog.xbHomeClick (Sender: TObject);
var
  basepath: String;
Begin
  basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';
//  drBox.Drive := basepath[1];
  pList.Path := basepath +pdeLoadCfgStr('general.cfg', 'userhome')+ '\';
End;

procedure TPDEOpenDialog.xbDocsClick (Sender: TObject);
var
  basepath: String;
Begin
  basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';
  pList.Path := basepath +pdeLoadCfgStr('general.cfg', 'userdocs')+'\';
//  drBox.Drive := basepath[1];
End;

procedure TPDEOpenDialog.xbCdromClick (Sender: TObject);
Begin
  pList.path := 'e:\';
  drBox.Drive := 'e';
End;

procedure TPDEOpenDialog.xbFloppyClick (Sender: TObject);
Begin
  pList.path := 'a:\';
  drBox.Drive := 'a';
End;

Procedure TPDEOpenDialog.drEditChangeDir (NewDir: String);
Begin
  pList.path := NewDir;
End;

Procedure TPDEOpenDialog.pdeOpenDialogTranslateShortcut(Sender: TObject;
  KeyCode: TKeyCode; Var ReceiveR: TForm);
var
  temp: String;
Begin
if (KeyCode = kbBkSp) and (ActiveControl <> edName) then
  begin
  if wasBkSp then begin wasBkSp:=false; exit; end;
  wasBkSp := true;
  if length(pList.path) > 3 then
    begin
    temp := pList.path;
    if temp[length(temp)] = '\' then delete(temp, length(temp), 1);
    while temp[length(temp)] <> '\' do
      delete(temp, length(temp), 1);

    pList.path := temp;
    end;
  end
  else if (KeyCode = kbF5) then
    pList.Clear
  else if (KeyCode = kbF7) then
    xbNewClick (Sender);

End;

//-----------------------------------------

function pdeOpenFileDialog(cptn, directory, mask: String): String;
var
  pdeDlg: TPDEOpenDialog;
  s, s2: String;
begin
//example: mask = 'All (*.*)|Exe (*.exe;*.com;*.cmd;*.bat)|'
  s2 := mask;
  pdeDlg := TPDEOpenDialog.Create(Application.MainForm);
  pdeDlg.Caption := cptn; //'Открытие файла';

  while s2 <> '' do
    begin
    s := copy(s2, 1, pos('|', s2) - 1);
    pdeDlg.cbMask.Items.Add(s);
    delete(s2, 1, pos('|', s2));
    end;

  pdeDlg.cbMask.Text := pdeDlg.cbMask.Items[0];

  s := pdeDlg.cbMask.Items[0];
  delete(s, 1, pos('(', s));
  delete(s, length(s), 1);

  pdeDlg.pList.Mask := s;
  pdeDlg.pList.Path := directory;

  Result := '';

  if pdeDlg.ShowModal = cmOK then
    Result := concatfilename(pdeDlg.edPath.Text, pdeDlg.edName.Text);

  if pdeDlg<>nil then
    pdeDlg.Free;
end;

//-----------------------------------------

function pdePromptDialog(text, cptn: String): String;
var
  pDlg: TPromptDlg;
begin
  pDlg := TPromptDlg.Create(Application.MainForm);
  pDlg.Caption := cptn;
  pDlg.Label1.Caption := text;
  pDlg.ActiveControl := pDlg.edResult;

  Result := '';

  if pDlg.ShowModal = cmOK then
    Result := pDlg.edResult.Text;

  if pDlg<>nil then
    pDlg.Free;
end;

//-----------------------------------------

Constructor TAboutDlg.Create(AOwner:TComponent);
var
  fnt: TFont;
Begin
  Inherited Create(AOwner);
  BorderStyle := bsDialog;
  Width := 450;
  Height := 350;
  Position := poScreenCenter;
  BorderIcons :=[biSystemMenu, biMinimize];
  Font.Name := 'WarpSans:9'; Caption := pdeLoadNLS('dlgAboutProgram', 'О программе');

  imgLogo:= TImage.Create(Self); imgLogo.Parent := Self;
  imgLogo.width := 32; imgLogo.height := 32;
  imgLogo.left := 8; imgLogo.top := 8;
  imgLogo.align := alFixedLeftTop;

  lName:= TLabel.Create(Self); lName.Parent := Self;
  lName.width := 378; lName.height := 28;
  lName.left := 50; lName.top := 14;
  lName.align := alFixedLeftTop;
  fnt := screen.GetFontFromPointSize('Helv', 12);
  lName.Font := fnt;

  bClose:= TButton.Create(Self); bClose.Parent := Self;
  bClose.Height := 26;
  bClose.Width := 100;
  bClose.Left := 334; bClose.Top := 290;
  bClose.Caption := pdeLoadNLS('dlgCloseButton', 'Закрыть');
  bClose.align := alFixedLeftTop;
  bClose.Command := cmClose; bClose.ModalResult := cmClose;
  bClose.Default := True;

  tsTabs:= TTabSet.Create(Self);
  tsTabs.Parent := Self;
  tsTabs.DitherBackGround := False;
  //tsTabs.PenColor := clBlue;
  tsTabs.tabs.add(pdeLoadNLS('dlgAboutProgram', 'О программе'));
  tsTabs.tabs.add(pdeLoadNLS('dlgAboutAuthors', 'Авторы'));
  tsTabs.tabs.add(pdeLoadNLS('dlgAboutThanks', 'Благодарности'));
  tsTabs.tabs.add(pdeLoadNLS('dlgAboutLicense', 'Лицензия'));
  tsTabs.width := 430;
  tsTabs.alignment := taTop;
  tsTabs.left := 4; tsTabs.top := 40;
  tsTabs.align := alFixedLeftTop;
  tsTabs.UnselectedColor := clDlgWindow;
  tsTabs.SelectedColor := clWindow;
  tsTabs.OnChange := TabsChange;

  pPanel:= TPanel.Create(Self);
  pPanel.Parent := Self;
  pPanel.width := 430; pPanel.height := 220;
  pPanel.left := 4; pPanel.top := 65;
  pPanel.align := alFixedLeftTop;

  mInfo := TMemo.Create(Self);
  mInfo.Parent :=pPanel;
  mInfo.width := 422; mInfo.height := 212;
  mInfo.left := 4; mInfo.top := 4;
  mInfo.readonly := true;
  mInfo.Color := clDlgWindow;
  mInfo.BorderStyle := bsNone;
  mInfo.align := alFixedLeftTop;

End;

Procedure TAboutDlg.TabsChange(Sender: TObject; NewTab: LongInt;
      Var AllowChange: Boolean);
Begin
mInfo.Lines.Clear;
  case newtab of
  0:
    begin
    mInfo.BorderStyle := bsNone;
    if about <> nil then
      mInfo.Lines := about;
    end;
  1:
    begin
    mInfo.BorderStyle := bsSingle;
    if authors <> nil then
      mInfo.Lines := authors;
    end;
  2:
    begin
    mInfo.BorderStyle := bsSingle;
    if thanks <> nil then
      mInfo.Lines := thanks;
    end;
  3:
    begin
    mInfo.BorderStyle := bsSingle;
    if licensefile <> '' then
      begin
      mInfo.BeginUpdate;
      mInfo.Lines.LoadFromFile(licensefile);
      mInfo.EndUpdate;
      end;
    end;
  end;
End;

//-----------------------------------------

function pdeAboutDialog(about, authors, thanks: TStringList;
  cptn, text, licensefile: String; logo: TIcon): Integer;
var
  pDlg: TAboutDlg;
begin
  pDlg:= TAboutDlg.Create(Application.MainForm);
  pDlg.Caption := cptn;
  pDlg.lName.Caption := text;
  if logo <> nil then
    pDlg.imgLogo.Icon := logo;
  pDlg.licensefile := licensefile;
  pDlg.about := about;
  pDlg.authors := authors;
  pDlg.thanks := thanks;
  pDlg.mInfo.Lines := about;

  Result := 0;

  if pDlg.ShowModal = cmClose then
    Result := 0;

  if pDlg<>nil then
    pDlg.Free;
end;

//-----------------------------------------

Constructor TPDEColorDlg.Create(AOwner:TComponent);
Begin
Inherited Create(AOwner);
BorderStyle := bsDialog;
BorderIcons := [biSystemMenu, biMinimize];
Font.Name := 'WarpSans:9';
Caption := pdeLoadNLS('dlgChooseColor', 'Выберите цвет:');
Width := 370;
Height := 272;
Position := poScreenCenter;

ColorWheel:= TColorWheel.Create(Self);
ColorWheel.Parent := Self;
ColorWheel.Width := 160;
ColorWheel.Height := 160;
ColorWheel.Left := 16;
ColorWheel.Top := 16;

ValueBar:= TValueBar.Create(Self);
ValueBar.Parent := Self;
ValueBar.Width := 50;
ValueBar.Height := 160;
ValueBar.Left := 180;
ValueBar.Top := 16;
ColorWheel.ValueBar := ValueBar;
ValueBar.OnChange := ColorChange;

Shape:= TShape.Create(Self);
Shape.Parent := Self;
Shape.Width := 90;
Shape.Height := 60;
Shape.Left := 250;
Shape.Top := 16;

lRed:= TLabel.Create(Self);
lRed.Parent := Self;
lRed.Caption := 'R:';
lRed.Width := 30;
lRed.Left := 250;
lRed.Top := 95;

lGreen:= TLabel.Create(Self);
lGreen.Parent := Self;
lGreen.Caption := 'G:';
lGreen.Width := 30;
lGreen.Left := 250;
lGreen.Top := 125;

lBlue:= TLabel.Create(Self);
lBlue.Parent := Self;
lBlue.Caption := 'B:';
lBlue.Width := 30;
lBlue.Left := 250;
lBlue.Top := 155;

edRed:= TEdit.Create(Self);
edRed.Parent := Self;
edRed.NumbersOnly := True;
edRed.Width := 60;
edRed.Left := 280;
edRed.Top := 90;
edRed.OnChange := EditChange;

edGreen:= TEdit.Create(Self);
edGreen.Parent := Self;
edGreen.NumbersOnly := True;
edGreen.Width := 60;
edGreen.Left := 280;
edGreen.Top := 120;
edGreen.OnChange := EditChange;

edBlue:= TEdit.Create(Self);
edBlue.Parent := Self;
edBlue.NumbersOnly := True;
edBlue.Width := 60;
edBlue.Left := 280;
edBlue.Top := 150;
edBlue.OnChange := EditChange;

Bevel:= TBevel.Create(Self);
Bevel.Parent := Self;
Bevel.Shape := bsTopLine;
Bevel.Width := 325;
Bevel.Height := 8;
Bevel.Left := 16;
Bevel.Top := 190;

bOK:= TButton.Create(Self); bOK.Parent := Self;
bOK.Caption := pdeLoadNLS('dlgOkButton', 'OK');
bOK.Height := 28; bOK.Left := 170;
bOK.Top := 205;
bOK.Default := True;
bOK.Align := alFixedLeftTop;
bOK.Command := cmOK; bOK.ModalResult := cmOK;

bCancel:= TButton.Create(Self); bCancel.Parent := Self;
bCancel.Caption := pdeLoadNLS('dlgCancelButton', 'Отмена');
bCancel.Height := 28; bCancel.Left := 260;
bCancel.Top := 205;
bCancel.Align := alFixedLeftTop;
bCancel.Command := cmCancel; bCancel.ModalResult := cmCancel;

End;

//-----------------------------------------

Procedure TPDEColorDlg.ColorChange (Sender: TObject);
Var
  Red,Green,Blue: Byte;
Begin
  Shape.Brush.Color := ValueBar.SelectedColor;
  Shape.Invalidate;
  RGBToValues(ValueBar.SelectedColor, Red,Green,Blue);
  edRed.Text := IntToStr(Red);
  edGreen.Text := IntToStr(Green);
  edBlue.Text := IntToStr(Blue);
End;

//-----------------------------------------

Procedure TPDEColorDlg.EditChange (Sender: TObject);
Var
  Red,Green,Blue: Byte;
Begin
  {Red := StrToInt(edRed.Text);
  Green := StrToInt(edGreen.Text);
  Blue := StrToInt(edBlue.Text);
  ColorWheel.SetSelectedColor(ValuesToRGB(Red,Green,Blue));
  Shape.Brush.Color := ValueBar.SelectedColor;
  Shape.Invalidate;}
End;

//-----------------------------------------

function pdeColorDialog(var Color: TColor): Boolean;
var
  pDlg: TPDEColorDlg;
begin
  pDlg:= TPDEColorDlg.Create(Application.MainForm);

  Result := False;

  if pDlg.ShowModal = cmOK then
    begin
    Color := pDlg.ValueBar.SelectedColor;
    Result := True;
    end;

  if pDlg<>nil then
    pDlg.Free;
end;

//------------------------------------------

function LoadBookmarks(Box: TListBox): Integer;
var
  basepath: String;
  pclr: TColor;
  afile: TextFile;
  tsr: TSearchRec;
  itext: String;
  rez: Integer;
begin
//-----загрузка Закладок-------------------
basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

rez:=FindFirst(basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+'\*.*',
  faAnyFile, tsr);
  while rez=0 do
    begin
    rez:=FindNext(tsr);
    if rez<>0 then break;
    if (tsr.attr and faDirectory)=0 then //file
      begin
      assignfile(afile, basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+
        '\'+tsr.name);
      reset(afile);
      readln(afile); readln(afile); readln(afile);
      readln(afile, itext);
      Box.Items.Add(itext);
      closefile(afile);
      end;
    end;
FindClose(tsr);
//-----------------------------------------
end;

//------------------------------------------

End.
