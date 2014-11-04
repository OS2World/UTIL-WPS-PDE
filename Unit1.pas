(*////////////////////////////////////////////////////
//    �DE -  �����窠 ���짮��⥫� OS/2 Warp
//    Copyleft stVova, [�DE-Team], 2003
//    http://os2progg.by.ru/pde
/////////////////////////////////////////////////////*)
//----------------------------------------------------
//����-�������� FileHalf, �᭮���� �����
//��᫥���� ����䨪���: 11/09/03
//----------------------------------------------------
//��ᬮ��� 䠩� TODO � Buglist, � �� ������ ��᫨ ������
//� ��諨�. � ��� 䠩��� ����᫥��, �� ��諮 � �㯨�, � ��
//���������� �㤠 ������ :-)
//�த�-�� ��.                                 stVova
//----------------------------------------------------

Unit Unit1;

Interface

Uses
  Classes, Forms, Graphics, StdCtrls, ListView, SysUtils, Buttons, PMWin, BSEDos,
  ExtCtrls, XplorBtn, os2def, dialogs, strings, FileCtrl, DirOutLn, DialogUnit1,
  PropUnit, PMStdDlg, BmpList, Hints, pdeDlgs, CustomFileControls
  , PdeNLS, Dos{, pdeStart}, ComCtrls, BseErr;

//Name of the shared memory object
Const
    SharedMemName='DragDrop_ItemsInfo';

//Drag source identification
Const
    DragSourceId='File or Folder to Copy';

Type
  TMainForm = Class (TForm)
    vFiles: TListView;
    mGotoHome: TMenuItem;
    mOpenWith: TMenuItem;
    mShowPreview: TMenuItem;
    mZoomPlus: TMenuItem;
    mZoomMinus: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem14: TMenuItem;
    LoadListProgress: TProgressBar;
    mGotoDisks: TMenuItem;
    MenuItem11: TMenuItem;
    mShowHidden: TMenuItem;
    MenuItem12: TMenuItem;
    mNewWindow: TMenuItem;
    MenuItem10: TMenuItem;
    Dirs: TCustomDirectoryListBox;
    Drives: TCustomDriveComboBox;
    InfoLabel: TLabel;
    mPresent: TMenuItem;
    mIcons: TMenuItem;
    mTile: TMenuItem;
    mSmallIcons: TMenuItem;
    edPath: TEdit;
    LStat1: TLabel;
    mArchive: TMenuItem;
    mFilter: TMenuItem;
    MenuItem7: TMenuItem;
    mViewFile: TMenuItem;
    mBookmarks: TMenuItem;
    mAddBookmark: TMenuItem;
    bGo: TExplorerButton;
    Image2: TImage;
    mHTM2: TMenuItem;
    mHTM: TMenuItem;
    MenuItem6: TMenuItem;
    mFavor: TMenuItem;
    mAddFavor: TMenuItem;
    mPrevDrive: TMenuItem;
    MenuItem4: TMenuItem;
    mConfigPDE: TMenuItem;
    mNextDrive: TMenuItem;
    mEditAssoc: TMenuItem;
    MenuItem2: TMenuItem;
    bNewWindow: TExplorerButton;
    bRefresh: TExplorerButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    mRefresh: TMenuItem;
    MenuItem1: TMenuItem;
    bRename: TExplorerButton;
    bFind: TExplorerButton;
    bNew: TExplorerButton;
    mStatus: TMenuItem;
    mInfoPanel: TMenuItem;
    MenuItem15: TMenuItem;
    mAbout: TMenuItem;
    mShowHelp: TMenuItem;
    mQuickRun: TMenuItem;
    mButtons: TMenuItem;
    Image1: TImage;
    iBitmaps: TImageList;
    ToolBar1: TToolbar;
    LStat: TLabel;
    menuFile: TPopupMenu;
    mOpen: TMenuItem;
    mFind: TMenuItem;
    MenuItem3: TMenuItem;
    mSend: TMenuItem;
    MenuItem5: TMenuItem;
    mCopy: TMenuItem;
    mMove: TMenuItem;
    mDel: TMenuItem;
    MenuItem9: TMenuItem;
    mRename: TMenuItem;
    mShortcut: TMenuItem;
    mProperies: TMenuItem;
    MenuItem19: TMenuItem;
    mDiskA: TMenuItem;
    mDeskTop: TMenuItem;
    mFolder: TMenuItem;
    mText: TMenuItem;
    mOpen2: TMenuItem;
    MenuItem8: TMenuItem;
    mFind2: TMenuItem;
    MenuItem13: TMenuItem;
    mCopy2: TMenuItem;
    mMove2: TMenuItem;
    mDel2: TMenuItem;
    MenuItem21: TMenuItem;
    mShortcut2: TMenuItem;
    mRename2: TMenuItem;
    MenuItem24: TMenuItem;
    mCreateNew2: TMenuItem;
    mFolder2: TMenuItem;
    mText2: TMenuItem;
    mDiskA2: TMenuItem;
    mDeskTop2: TMenuItem;
    bProperties: TExplorerButton;
    mProperties2: TMenuItem;
    mSend2: TMenuItem;
    mCreateNew: TMenuItem;
    ToolBar2: TToolbar;
    MainMenu1: TMainMenu;
    InfoPanel: TPanel;
    mView: TMenuItem;
    mGoto: TMenuItem;
    mHelp: TMenuItem;
    bBack: TExplorerButton;
    bForward: TExplorerButton;
    mGoBack: TMenuItem;
    mGoForv: TMenuItem;
    bMove: TExplorerButton;
    bCopy: TExplorerButton;
    bDelete: TExplorerButton;
    mGoUp: TMenuItem;
    mEdit: TMenuItem;
    mFile: TMenuItem;
    bUp: TExplorerButton;
    Procedure mGotoHomeOnClick (Sender: TObject);
    Procedure mZoomMinusOnClick (Sender: TObject);
    Procedure mZoomPlusOnClick (Sender: TObject);
    Procedure mShowPreviewOnClick (Sender: TObject);
    Procedure mShowHiddenOnClick (Sender: TObject);
    Procedure DirsOnClick (Sender: TObject);
    Procedure mShowHelpOnClick (Sender: TObject);
    Procedure MainFormOnCloseQuery (Sender: TObject; Var CanClose: Boolean);
    Procedure MainFormOnSetupShow (Sender: TObject);
    Procedure mTileOnClick (Sender: TObject);
    Procedure mIconsOnClick (Sender: TObject);
    Procedure mDeskTop2OnClick (Sender: TObject);
    Procedure DirsOnItemFocus (Sender: TObject; Index: LongInt);
    Procedure vFilesOnMouseUp (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X: LongInt; Y: LongInt);
    Procedure vFilesOnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X: LongInt; Y: LongInt);
    Procedure mArchiveOnClick (Sender: TObject);
    Procedure mFilterOnClick (Sender: TObject);
    Procedure mShortcut2OnClick (Sender: TObject);
    Procedure mHTMOnClick (Sender: TObject);
    Procedure mText2OnClick (Sender: TObject);
    Procedure MainFormOnTranslateShortCut (Sender: TObject; KeyCode: TKeyCode; Var ReceiveR: TForm);
    Procedure vFilesOnStartDrag (Sender: TObject; Var DragData: TDragDropData);
    Procedure vFilesOnEndDrag (Sender: TObject; target: TObject; X: LongInt; Y: LongInt);
    Procedure vFilesOnDragOver (Sender: TObject; Source: TObject; X: LongInt; Y: LongInt; State: TDragState; Var Accept: Boolean);
    Procedure vFilesOnDragDrop (Sender: TObject; Source: TObject; X: LongInt; Y: LongInt);
    Procedure vFilesOnCanDrag (Sender: TObject; X: LongInt; Y: LongInt; Var Accept: Boolean);
    Procedure mAddFavorOnClick (Sender: TObject);
    Procedure mGotoDisksOnClick (Sender: TObject);
    Procedure mDiskA2OnClick (Sender: TObject);
    Procedure mConfigPDEOnClick (Sender: TObject);
    Procedure mPrevDriveOnClick (Sender: TObject);
    Procedure mNextDriveOnClick (Sender: TObject);
    Procedure bBackOnClick (Sender: TObject);
    Procedure bForwardOnClick (Sender: TObject);
    Procedure Timer1OnTimer (Sender: TObject);
    Procedure mEditAssocOnClick (Sender: TObject);
    Procedure bNewWindowOnClick (Sender: TObject);
    Procedure mAboutOnClick (Sender: TObject);
    Procedure mSmallIconsOnClick (Sender: TObject);
    Procedure mInfoPanelOnClick (Sender: TObject);
    Procedure mStatusOnClick (Sender: TObject);
    Procedure mButtonsOnClick (Sender: TObject);
    Procedure mOpenAsTextOnClick (Sender: TObject);
    Procedure bPropertiesOnClick (Sender: TObject);
    Procedure bRefreshOnClick (Sender: TObject);
    Procedure bNewOnClick (Sender: TObject);
    Procedure bFindOnClick (Sender: TObject);
    Procedure bRenameOnClick (Sender: TObject);
    Procedure bDeleteOnClick (Sender: TObject);
    Procedure bMoveOnClick (Sender: TObject);
    Procedure bCopyOnClick (Sender: TObject);
    Procedure DirsOnItemSelect (Sender: TObject; Index: LongInt);
    Procedure DrivesOnChange (Sender: TObject);
    Procedure MainFormOnDestroy (Sender: TObject);
    Procedure mOpenOnClick (Sender: TObject);
    Procedure vFilesOnItemSelect (Sender: TObject; Index: LongInt);
    Procedure bUpOnClick (Sender: TObject);
    Procedure MainFormOnResize (Sender: TObject);
    Procedure MainFormOnCreate (Sender: TObject);
    Procedure bGoOnClick (Sender: TObject);
    Procedure Form1OnShow (Sender: TObject);

    Procedure QuickMenuClick(Sender: TObject);
    Procedure BookMarkClick(Sender: TObject);
    Procedure OpenWithMenuClick(Sender: TObject);
  Private
    {Insert private declarations here}
    Procedure FormShowHint(Var HintStr:String;Var CanShow:Boolean;Var HintInfo:THintInfo);
  Public
    {Insert public declarations here}
    function LoadList: integer;
    function ShowStatus: integer;
    function ShellExecute(fname, fdir, fparam: string; shortcut: boolean): Boolean;
    function GoInto: integer;
    function ResolveAssociation(fname: string): integer;
    function FileHalfCfg: Integer;
    function CalcTreeSize(tpath: String): LongInt;
    function FStat: Integer;

    function ObjMove(source, dest: cstring): integer;
    function ObjDel(source: string): integer;
    function ObjRename(source, dest: string): integer;
    function CorectCaption(corstr: String): String;
    function DeCC(corstr: String): String;

    Procedure CancelFileOp(Sender: TObject);
    Procedure CancelNewFolder(Sender: TObject);
    Procedure CreateNewFolder(Sender: TObject);
    Procedure CreateShortcut(Sender: TObject);
    Procedure CancelCreateShortcut(Sender: TObject);
  End;

  TCMDForm = Class (TForm)
    Procedure cmdFormOnShow (Sender: TObject);

  end;

  {TNewForm = Class (TForm)
    Procedure NewFormOnShow (Sender: TObject);

  end;}

  TLinkForm = Class (TForm)
    Procedure LinkFormOnShow (Sender: TObject);

  end;

  TAssociations=record
    flt: string;
    pgm: string;
    bmp: string;
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

  TCMDThread = class(TThread)
  private
    FSource: CString;
    FDest:   CString;
    FOperation: CString;
  protected
    procedure Execute; override;
  public
    constructor Create(Source, Dest, Operation: String);
  End;

Var
  MainForm: TMainForm;
  findUtil, txtUtil, archiveUtil, loc_dll: String;
  tmp, _tmp: {array[1..16] of} TBitmap;
  tmp2: TPicture;
  prevDir, nextDir: String;
  sr : TSearchRec;
  path, filter: string; //⥪�騩 ����
  i: integer;
  assoc: array[1..100] of TAssociations;
  assocCount: Integer;
  count: integer;
  Year, Month, Day: Word;
  Days: array[1..7] of String; //= ('����ᥭ�', '�������쭨�', '��୨�', '�।�', '��⢥�', '��⭨�', '�㡮�');
  quickmitem: array[1..24] of TMenuItem;
  bookitem: array[1..24] of TMenuItem;
  openwithitem: TMenuItem;
  bookmarkCount: Integer;
  iconsize: Integer;
  hptr: HPointer;

  //elements of copy-move-delete form
  cmdForm: TCMDForm;
  cmdBtn: TButton;
  cmdLabel: TLabel;
  cmdImage: TImage;
  cmdBevel: TBevel;
  //elements of new folder form
  {NewForm: TNewForm;
  newBtnOk, newBtnCancel: TButton;
  newEdit: TEdit;
  newLabel: TLabel;
  newImage: TImage;
  newBevel: TBevel;}
  //elements of new shortcut form
  linkForm: TLInkForm;
  lnkImage: TImage;
  lnkLabel1, lnkLabel2, lnkLabel3, lnkLabel4, lnkLabel5, lnkLabel6: TLabel;
  lnkEdit1, lnkEdit2, lnkEdit3, lnkEdit4, lnkEdit5: TEdit;
  lnkBevel: TBevel;
  lnkBtnOk, lnkBtnCancel: TButton;

{IMPORTS

  function CopyDialog (src: String): String; cdecl;
           'PDLGS' index 1;

  End;}

Function DiskFreeKb(Drive: Byte): LongInt;
Function DiskSizeKb(Drive: Byte): LongInt;

Implementation

Function DiskFreeKb(Drive: Byte): LongInt;
Var
  Buffer: FSALLOCATE;
Begin

  If DosQueryFSInfo(Drive, FSIL_ALLOC, Buffer, SizeOf(Buffer)) = NO_ERROR Then
    With Buffer Do Result := Round((cUnitAvail / 1024) * cSectorUnit * cbSector)
  Else Result := -1;

End;

Function DiskSizeKb(Drive: Byte): LongInt;
Var
  Buffer: FSALLOCATE;
Begin
  If DosQueryFSInfo(Drive, FSIL_ALLOC, Buffer, SizeOf(Buffer)) = NO_ERROR Then
    With Buffer Do Result := Round((cUnit / 1024) * cSectorUnit * cbSector)
  Else Result := -1;
End;

//------------------------------------------

Procedure TMainForm.mZoomMinusOnClick (Sender: TObject);
var
  acnrInfo:CNRINFO;
  Flags:LongWord;
Begin
  //zoom minus
vFiles.BitmapSize.CX := vFiles.BitmapSize.CX - iconsize div 2;
vFiles.BitmapSize.CY := vFiles.BitmapSize.CY - iconsize div 2;

  FillChar(acnrInfo,SizeOf(CNRINFO),0);
  Flags:=CMA_FLWINDOWATTR;
  With acnrInfo Do
     Begin
          cb:=SizeOf(CNRINFO);
          flWindowAttr:=CV_ICON;
          slBitmapOrIcon.CX:=vFiles.BitmapSize.CX;
          slBitmapOrIcon.CY:=vFiles.BitmapSize.CY;
          Flags:=Flags Or CMA_SLBITMAPORICON;
          flWindowAttr:=flWindowAttr Or CA_DRAWBITMAP;
     End;
     WinSendMsg(vFiles.Handle,CM_SETCNRINFO,LongWord(@acnrInfo),Flags);

vFiles.Refresh;
LoadList;
End;

Procedure TMainForm.mZoomPlusOnClick (Sender: TObject);
var
  acnrInfo:CNRINFO;
  Flags:LongWord;
Begin
  //zoom plus
vFiles.BitmapSize.CX := vFiles.BitmapSize.CX + iconsize div 2;
vFiles.BitmapSize.CY := vFiles.BitmapSize.CY + iconsize div 2;

  FillChar(acnrInfo,SizeOf(CNRINFO),0);
  Flags:=CMA_FLWINDOWATTR;
  With acnrInfo Do
     Begin
          cb:=SizeOf(CNRINFO);
          flWindowAttr:=CV_ICON;
          slBitmapOrIcon.CX:=vFiles.BitmapSize.CX;
          slBitmapOrIcon.CY:=vFiles.BitmapSize.CY;
          Flags:=Flags Or CMA_SLBITMAPORICON;
          flWindowAttr:=flWindowAttr Or CA_DRAWBITMAP;
     End;
     WinSendMsg(vFiles.Handle,CM_SETCNRINFO,LongWord(@acnrInfo),Flags);

vFiles.Refresh;
LoadList;
End;

Procedure TMainForm.mShowPreviewOnClick (Sender: TObject);
Begin
  //togle show preview for BMP
  mShowPreview.Checked := not(mShowPreview.Checked);
  LoadList;
End;

Procedure TMainForm.mShowHiddenOnClick (Sender: TObject);
Begin
  //togle show hidden files
  mShowHidden.Checked := not(mShowHidden.Checked);
  LoadList;
End;

Procedure TMainForm.DirsOnClick (Sender: TObject);
Begin

End;

Procedure TMainForm.mShowHelpOnClick (Sender: TObject);
Begin
//Help? Help!!!!!
{if txtUtil<>'' then
  Begin
  if (txtUtil[2] = ':') then //full path
    ShellExecute(txtUtil, ExtractFilePath(Application.ExeName)
      , ExtractFilePath(Application.ExeName)+'\Help.txt', false)
  else
    ShellExecute(extractfilepath(application.exename)+txtUtil
      , ExtractFilePath(Application.ExeName)
      , ExtractFilePath(Application.ExeName)+'\Help.txt', false);
  End;}
  if FileExists(extractfilepath(application.exename)+'pde_help_ru.inf') then
    MainForm.ShellExecute('view.exe', '', extractfilepath(application.exename)+'pde_help_ru.inf', false)
  else if FileExists(extractfilepath(application.exename)+'pde_help_en.inf') then
    MainForm.ShellExecute('view.exe', '', extractfilepath(application.exename)+'pde_help_en.inf', false)
  else if FileExists(extractfilepath(application.exename)+'readme_ru.txt') then
    MainForm.ShellExecute('e.exe', '', extractfilepath(application.exename)+'readme_ru.txt', false)
  else if FileExists(extractfilepath(application.exename)+'readme_en.txt') then
    MainForm.ShellExecute('e.exe', '', extractfilepath(application.exename)+'readme_en.txt', false)
  else mAboutOnClick( Sender );
End;

Procedure TMainForm.MainFormOnCloseQuery (Sender: TObject;
  Var CanClose: Boolean);
var
  cfgData: TStringList;
  tmpstr: String;
Begin
//����襬 � 䠩� ���䨣��樨 ��������� ���譥�� ����

cfgData:= TStringList.Create;
cfgData.Add('//Configuration file of FileHalf (PDE desktop, 2003)');
cfgData.Add('//file list back color');
cfgData.Add('FilelistColor='+IntToStr(vFiles.Color));
cfgData.Add('//file list icon size');
cfgData.Add('FilelistIconSize='+ pdeLoadCfgStr('filehalf.cfg', 'FilelistIconSize'));
cfgData.Add('//button toolbar color');
cfgData.Add('ToolbarColor='+ IntToStr(Toolbar2.Color));
cfgData.Add('//toolbars buttons size');
cfgData.Add('ToolbarSize='+ pdeLoadCfgStr('filehalf.cfg', 'ToolbarSize'));
cfgData.Add('//Show InfoPanel 1/0');
tmpstr := '0';
if mInfopanel.Checked then tmpstr := '1';
cfgData.Add('ShowInfoPanel='+ tmpstr);
cfgData.Add('//Show Status 1/0');
tmpstr := '0';
if mStatus.Checked then tmpstr := '1';
cfgData.Add('ShowStatus='+ tmpstr);
cfgData.Add('//Show Buttons 1/0');
tmpstr := '0';
if mButtons.Checked then tmpstr := '1';
cfgData.Add('ShowButtons='+ tmpstr);
cfgData.Add('//Type of View 0-pictograms, 1-tiles, 2-small icons');
tmpstr := '0';
if mTile.Checked then tmpstr := '1'
else if mSmallIcons.Checked then tmpstr := '2';
cfgData.Add('ViewType='+ tmpstr);
cfgData.Add('//pictures on buttons, base path is \\Bitmaps\FileHalf\');
cfgData.Add('//button Backward');
cfgData.Add('fhBackward1='+ pdeLoadCfgStr('filehalf.cfg', 'fhBackward1'));
cfgData.Add('fhBackward2='+ pdeLoadCfgStr('filehalf.cfg', 'fhBackward2'));
cfgData.Add('//button Forward');
cfgData.Add('fhForward1='+ pdeLoadCfgStr('filehalf.cfg', 'fhForward1'));
cfgData.Add('fhForward2='+ pdeLoadCfgStr('filehalf.cfg', 'fhForward2'));
cfgData.Add('//button UpDir');
cfgData.Add('fhGoup1='+ pdeLoadCfgStr('filehalf.cfg', 'fhGoup1'));
cfgData.Add('fhGoup2='+ pdeLoadCfgStr('filehalf.cfg', 'fhGoup2'));
cfgData.Add('//button Refresh');
cfgData.Add('ghRefresh1='+ pdeLoadCfgStr('filehalf.cfg', 'ghRefresh1'));
cfgData.Add('ghRefresh2='+ pdeLoadCfgStr('filehalf.cfg', 'ghRefresh2'));
cfgData.Add('//button Copy');
cfgData.Add('fhCopy1='+ pdeLoadCfgStr('filehalf.cfg', 'fhCopy1'));
cfgData.Add('fhCopy2='+ pdeLoadCfgStr('filehalf.cfg', 'fhCopy2'));
cfgData.Add('//button Move');
cfgData.Add('fhMove1='+ pdeLoadCfgStr('filehalf.cfg', 'fhMove1'));
cfgData.Add('fhMove2='+ pdeLoadCfgStr('filehalf.cfg', 'fhMove2'));
cfgData.Add('//button Delete');
cfgData.Add('fhDelete1='+ pdeLoadCfgStr('filehalf.cfg', 'fhDelete1'));
cfgData.Add('fhDelete2='+ pdeLoadCfgStr('filehalf.cfg', 'fhDelete2'));
cfgData.Add('//button Rename');
cfgData.Add('fhRename1='+ pdeLoadCfgStr('filehalf.cfg', 'fhRename1'));
cfgData.Add('fhRename2='+ pdeLoadCfgStr('filehalf.cfg', 'fhRename2'));
cfgData.Add('//button Find');
cfgData.Add('fhFind1='+ pdeLoadCfgStr('filehalf.cfg', 'fhFind1'));
cfgData.Add('fhFind2='+ pdeLoadCfgStr('filehalf.cfg', 'fhFind2'));
cfgData.Add('//button New folder');
cfgData.Add('fhNew1='+ pdeLoadCfgStr('filehalf.cfg', 'fhNew1'));
cfgData.Add('fhNew2='+ pdeLoadCfgStr('filehalf.cfg', 'fhNew2'));
cfgData.Add('//button Properties');
cfgData.Add('fhIdentity1='+ pdeLoadCfgStr('filehalf.cfg', 'fhIdentity1'));
cfgData.Add('fhIdentity2='+ pdeLoadCfgStr('filehalf.cfg', 'fhIdentity2'));
cfgData.Add('//button NewWindow');
cfgData.Add('fhNewWin1='+ pdeLoadCfgStr('filehalf.cfg', 'fhNewWin1'));
cfgData.Add('fhNewWin2='+ pdeLoadCfgStr('filehalf.cfg', 'fhNewWin2'));
cfgData.Add('//additional utilities');
cfgData.Add('//Search');
cfgData.Add('FindUtil='+ pdeLoadCfgStr('filehalf.cfg', 'FindUtil'));
cfgData.Add('//text editor');
cfgData.Add('TextUtil='+ pdeLoadCfgStr('filehalf.cfg', 'TextUtil'));
cfgData.Add('//archiver');
cfgData.Add('Archiver='+ pdeLoadCfgStr('filehalf.cfg', 'Archiver'));

pdeSaveCfgFile('filehalf.cfg', cfgData);
cfgData.Free;

CanClose := True;
End;

Procedure TMainForm.MainFormOnSetupShow (Sender: TObject);
Begin

End;

function TMainForm.DeCC(corstr: String): String;
Begin
  corstr:=Trim(corstr);  //delete all non-need spaces
  if corstr[19]=chr(13) then Delete(corstr, 19, 1);
  if corstr[19]=chr(10) then Delete(corstr, 19, 1);
  if corstr[37]=chr(13) then Delete(corstr, 37, 1);
  if corstr[37]=chr(10) then Delete(corstr, 37, 1);
result:=corstr;
End;

function TMainForm.CorectCaption(corstr: String): String;
var
  exceed: String;
Begin
exceed:='';
//���ࠢ�� ������� ������
if mTile.Checked then
  Begin

  While length(corstr)<17 do
    begin
    corstr:=corstr+' ';
    corstr:=' '+corstr;
    end;

  If length(corstr)<18 then
    corstr:=corstr+' ';

  If length(corstr)>18 then
    begin
    While length(corstr)>18 do
      begin
      exceed:=corstr[length(corstr)]+exceed;
      delete(corstr, length(corstr), 1);
      end;
    corstr:=corstr+chr(13)+chr(10)+exceed;
    exceed:='';
    end;

    If length(corstr)>38 then
    begin
    While length(corstr)>38 do
      begin
      exceed:=corstr[length(corstr)]+exceed;
      delete(corstr, length(corstr), 1);
      end;
    corstr:=corstr+chr(13)+chr(10)+exceed;
    end;

  End;
result:=corstr;
End;

//-----------------------------------------
//����� ��⮪� ��� 䠩����� ����権
Constructor TCMDThread.Create(Source, Dest, Operation: String);
Begin
  FSource:=Source;
  FDest:=Dest;
  FOperation:=Operation;

  inherited Create(False);
End;

Procedure TCMDThread.Execute;
var
  rc: apiret;
  option: ULong;
Begin
//�ᯮ������ ��⮪�
option := 0;
if (FOperation='copy') then
  begin
  if pdeLoadCfgInt('general.cfg', 'overwritefiles') = 1 then
    option := DCPY_Existing;
  rc:=DosCopy(FSource, FDest, option);
  if rc<>0 then
    pdeMessageBox(pdeLoadNLS('dlgErrorCode', '��� �訡��:') + ' ' + IntToStr(rc),
      pdeLoadNLS('dlgCopyError' ,'�� ����஢���� �ந��諨 �訡��'), MainForm.bCopy.Glyph);
  end
else if (FOperation='move') then
  begin
  MainForm.ObjMove(FSource, FDest);
  end;
MainForm.LoadList;
End;
//-----------------------------------------

Procedure TMainForm.mDeskTop2OnClick (Sender: TObject);
Begin
//ᮧ����� ��쥪� �� ����祬 �⮫�

End;

Procedure TMainForm.FormShowHint(Var HintStr:String;Var CanShow:Boolean;Var HintInfo:THintInfo);
var
  hintWnd: THintWindow;
Begin

End;

Procedure TMainForm.DirsOnItemFocus (Sender: TObject; Index: LongInt);
Begin

End;

function TMainForm.FStat: Integer;
var
  rez: integer;
  fsize: LongInt;
Begin
if vFiles.ItemCount>0 then
  begin
    fsize:=LongInt(vFiles.Items[vFiles.ItemIndex].Data);

    if (fsize<4096) then
        LStat1.Caption:=IntToStr(fsize)+' '+pdeLoadNLS('statusBytes', '����')
      else if (fsize>4096) and (fsize<2097152) then
        LStat1.Caption:=IntToStr(fsize div 1204)+' '+pdeLoadNLS('statusKBytes', '��')
      else
        LStat1.Caption:=IntToStr(fsize div 1048576)+' '+pdeLoadNLS('statusMBytes', '��');
  end;
End;

Procedure TMainForm.vFilesOnMouseUp (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: LongInt; Y: LongInt);
{var
  rect: TRect;
  _i, _j: Integer;}
Begin
{rect:=vFiles.Items[vFiles.ItemIndex].ItemRect;
for _i:=rect.left to rect.right do
  for _j:=rect.top to rect.bottom do
    if (vFiles.Canvas.Pixels[_i, _j]=vFiles.Color) then
      vFiles.Canvas.Pixels[_i, _j]:=clBlue;
}
End;

Procedure TMainForm.vFilesOnMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: LongInt; Y: LongInt);
Begin
if vFiles.NodeFromPoint(Point(x, y))<>nil then
  begin
  vFiles.ItemIndex:=TListViewNode(vFiles.NodeFromPoint(Point(x, y))).Index;
  FStat;
  end;
End;

Procedure TMainForm.mArchiveOnClick (Sender: TObject);
var
  a_index: Integer;
Begin
////add file to archive <- in future :-)
if archiveUtil<>'' then
  if vFiles.ItemCount>0 then begin
    dlgCMD.Caption:=pdeLoadNLS('dlgAddingToArchive', '���������� � ��娢')+' '+archiveUtil;
    dlgCMD.Label2.Caption:=pdeLoadNLS('dlgAddingToArchiveName', '��� ��娢�:');
    dlgCMD.Label1.Caption:=pdeLoadNLS('dlgAddingToArchiveParams', '��ࠬ��� ��娢���:');
    //dlgCMD.edSource.ReadOnly:=False;
    dlgCMD.edSource.Text:=DeCC(vFiles.Items[vFiles.ItemIndex].Text);
    dlgCMD.edDest.Text:='';//'';
    dlgCMD.ActiveControl:=dlgCMD.edSource;
    dlgCMD.OKButton.Default:=True;
    if dlgCMD.ShowModal=cmOK then
      ShellExecute(archiveUtil, '', dlgCMD.edDest.Text+' '+path+
      dlgCMD.edSource.Text+' '+path+DeCC(vFiles.Items[vFiles.ItemIndex].Text), true);

    a_index:=vFiles.ItemIndex;
    LoadList;
    vFiles.ItemIndex:=a_index;
    WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
    dlgCMD.Label2.Caption:=pdeLoadNLS('dlgSourceName', '��室��� ���:');
    dlgCMD.Label1.Caption:=pdeLoadNLS('dlgDestName', '����� ���:');
  end;
End;

Procedure TMainForm.mFilterOnClick (Sender: TObject);
var
  ext: string;
Begin
ext:='';
mFilter.Checked:=not(mFilter.Checked);
filter:='*.*';
if vFiles.ItemCount>0 then begin
  ext:=lowercase(extractfileext(vFiles.Items[vFiles.ItemIndex].Text));
  if ext<>'' then
    if mFilter.Checked then
      filter:='*'+ext
  end;
LoadList;
ShowStatus;
End;

Procedure TMainForm.mShortcut2OnClick (Sender: TObject);
var
  lfile: String;
Begin
//�����뢠�� ������ ᮧ����� ��몠
if vFiles.ItemCount>0 then begin
  lfile:=DeCC(vFiles.Items[vFiles.ItemIndex].Text);
  delete(lfile, pos('.',lfile), length(lfile)-pos('.',lfile)+1);
  lnkEdit1.Text:=path+lfile;
  lnkEdit2.Text:='';
  lnkEdit3.Text:=lfile; //vFiles.Items[vFiles.ItemIndex].Text;
  lnkEdit4.Text:=path;
  lnkEdit5.Text:='';
  end;
linkForm.ActiveControl:=lnkEdit1;
lnkBtnOK.Default:=True;
linkForm.Show;
linkForm.BringToFront;
End;

Procedure TMainForm.mHTMOnClick (Sender: TObject);
var
  afile: TextFile;
  ci: Integer;
Begin
ci:=0;
//ᮧ����� ���⮣� .htm 䠩�� (���-��࠭���)
while (FileExists(path+'html'+IntToStr(ci)+'.htm')) do
  inc(ci);

assignfile(afile, path+'html'+IntToStr(ci)+'.htm');
rewrite(afile);
writeln(afile, '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">');
writeln(afile, '<HTML>');
writeln(afile, '<HEAD>');
writeln(afile, '<TITLE>No name WWW</TITLE>');
writeln(afile, '<BODY>');
writeln(afile, 'Here will be your text');
writeln(afile, '<p>Text. Text. Text.');
writeln(afile, '</BODY>');
writeln(afile, '</HEAD>');
writeln(afile, '</HTML>');
closefile(afile);

LoadList;
End;

Procedure TMainForm.mText2OnClick (Sender: TObject);
var
  afile: TextFile;
  ci: integer;
Begin
ci:=0;
//ᮧ����� ���⮣� .txt 䠩��
while (FileExists(path+'text'+IntToStr(ci)+'.txt')) do
  inc(ci);

assignfile(afile, path+'text'+IntToStr(ci)+'.txt');
rewrite(afile);
closefile(afile);
LoadList;
End;

Procedure TMainForm.MainFormOnTranslateShortCut (Sender: TObject; KeyCode: TKeyCode; Var ReceiveR: TForm);
Begin
if (keycode=kbEnter) and (ActiveControl=edPath) then
  begin
  path:=edPath.Text;
  LoadList;
  ShowStatus;
  end
else {if (keycode=kbCLeft)or(keycode=kbCRight)or(keycode=kbCUp)or(keycode=kbCDown)or
  (keycode=kbEnd)or(keycode=kbHome) then}
  if (ActiveControl = vFiles) then
  begin
  FStat;
  end;

End;

//-----------------------------------------
//����஢���� ���।�⢮� drag'n'drop

Procedure TMainForm.vFilesOnStartDrag (Sender: TObject; Var DragData: TDragDropData);
Var
    MemLen:LongWord;
    SharedMem:PDragDropInfo;
    Temp:^String;
    ptrInfo: PointerInfo;
    tmpbmp: TPointer;

Begin
{tmpbmp:=TPointer.Create;
tmpbmp.width:=vFiles.Items[vFiles.ItemIndex].Bitmap.width;
tmpbmp.height:=vFiles.Items[vFiles.ItemIndex].Bitmap.height;
tmpbmp.LoadFromBitmap(vFiles.Items[vFiles.ItemIndex].Bitmap);
tmpbmp.CreateMask(clWhite);
tmpbmp.CreateNew(tmpbmp.width, tmpbmp.height, 280);

with ptrInfo do
  begin
  fPointer:=ord(True);
  xHotSpot:=14;
  yHotSpot:=14;
  hbmPointer:=tmpbmp.MaskHandle;
  hbmColor:=tmpbmp.ColorHandle;
  hbmMiniPointer:=0;
  hbmMiniColor:=0;
  end;
hptr:=WinCreatePointerIndirect(HWND_DESKTOP, ptrInfo);

//hptr:=WinCreatePointer(HWND_DESKTOP, tmpbmp.ColorHandle, true, 15, 15);
//crs:=Screen.AddCursor(hptr);

{Screen.Cursors[1]:=hptr;
vFiles.DragCursor:=1;
tmpbmp.free;}
   //Look how much memory we need
   MemLen:=Sizeof(TDragDropInfo)-sizeof(TDragDropItem);
   inc(MemLen,length(path+DeCC(vFiles.Items[vFiles.ItemIndex].Text))+1);

   //allocate the memory. We need shared memory because we want to give
   //the information to another process
   //free the shared memory
   GetNamedSharedMem(SharedMemName,SharedMem,MemLen);

   SharedMem^.Count:=0;
   Temp:=@SharedMem^.Items;  //start of variable information
   Inc(SharedMem^.Count);
   Temp^:=path+DeCC(vFiles.Items[vFiles.ItemIndex].Text);

   //Fill up the DragData structure
   DragData.SourceWindow := Handle;
   DragData.SourceType := drtString;
   DragData.SourceString:=DragSourceId;
   DragData.RenderType := drmSibyl;
   DragData.ContainerName := '';
   DragData.SourceFileName := SharedMemName;
   DragData.TargetFileName := '';
   DragData.SupportedOps := [doCopyable];//, doMoveable];
   DragData.DragOperation := doDefault;//doCopy;
End;

Procedure TMainForm.vFilesOnEndDrag (Sender: TObject; target: TObject;
  X: LongInt; Y: LongInt);
Var t:LongInt;
Begin
    //Look if the items were dropped successfully...
    If Target Is TExternalDragDropObject Then
    Begin
       //��� ���, �᫨ 䠩� ��७�ᨫ��
       //remove the items dragged
    End;

    //each process must free the shared memory !!
    FreeNamedSharedMem(SharedMemName);
End;

Procedure TMainForm.vFilesOnDragOver (Sender: TObject; Source: TObject;
  X: LongInt; Y: LongInt; State: TDragState; Var Accept: Boolean);
Begin
Accept:=((Source Is TExternalDragDropObject)And
             (TExternalDragDropObject(Source).SourceWindow<>vFiles.Handle)And
             (TExternalDragDropObject(Source).SourceType=drtString)And
             (TExternalDragDropObject(Source).SourceString=DragSourceId));

End;

Procedure TMainForm.vFilesOnDragDrop (Sender: TObject; Source: TObject;
  X: LongInt; Y: LongInt);
Var SharedMem:PDragDropInfo;
    sh:Longint;
    Temp:^String;
    fsrc, fdest: cstring;
    src, dest: string;
    rc: apiret;
    cmdTr: TCMDThread;
    shortcutfile: TextFile;
    shsr: TSearchRec;
Begin
rc:=0;
//Look if the target is valid for us...
    If ((Source Is TExternalDragDropObject)And
        (TExternalDragDropObject(Source).SourceWindow<>vFiles.Handle)And
        (TExternalDragDropObject(Source).SourceType=drtString)And
        (TExternalDragDropObject(Source).SourceString=DragSourceId)) Then
    Begin  //accepted
       If not AccessNamedSharedMem(TExternalDragDropObject(Source).SourceFileName,
                                   SharedMem) Then exit;  //some error

       Temp:=@SharedMem^.Items;
       //��� ��� �� ����஢����-��६�饭��
       fsrc:=Temp^;
       fdest:=path+extractfilename(Temp^);
       src:=fsrc;
       dest:=fdest;
       //MessageBox(src+' '+dest, mtInformation, [mbOk]);
       sh:=WinGetKeyState(HWND_DESKTOP, VK_SHIFT);
       if ((sh and $8000) <> 0) and
          ((WinGetKeyState(HWND_DESKTOP, VK_CTRL) and $8000) <> 0) then
         begin //Shift + Ctrl <- create shortcut
         if (FindFirst(src + '\*.*', faAnyFile, shsr)=0) then  //����� 䠩�� �� ����� ���� ��㣨� 䠩��� :-)
           begin  //directory
           FindClose(shsr);
           AssignFile(shortcutfile, path+'['+ExtractFileName(dest)+']');
           Rewrite(shortcutfile);
           Writeln(shortcutfile, '[SHORTCUT]');
           Writeln(shortcutfile, '//link: type, object-name, path, parameters');
           Writeln(shortcutfile, 'FOLDER');
           Writeln(shortcutfile, src+'\');
           Writeln(shortcutfile, src+'\');
           Writeln(shortcutfile, '');
           end
           else
           begin
           FindClose(shsr);
           delete(dest,  pos('.', dest), length(dest) - pos('.', dest) + 1);
           AssignFile(shortcutfile, dest);
           Rewrite(shortcutfile);
           Writeln(shortcutfile, '[SHORTCUT]');
           Writeln(shortcutfile, '//link: type, object-name, path, parameters');
           Writeln(shortcutfile, 'APP');
           Writeln(shortcutfile, src);
           Writeln(shortcutfile, ExtractFilePath(src));
           Writeln(shortcutfile, '');
           end;
         CloseFile(shortcutfile);
         end
       else if (sh and $8000)<> 0 then //Shift
         begin //��६�饭��
         cmdImage.Bitmap.LoadFromBitmap(bMove.Glyph);
         cmdLabel.Caption:=pdeLoadNLS('dlgMoving', '��६�饭��')+' '+src+' '+
           IntToStr(CalcTreeSize(src) div 1024)+pdeLoadNLS('statusKBytes', '��')+
           ' '+pdeLoadNLS('statusIn', '�')+' '+dest+' . . .';
         cmdForm.Show;
         cmdForm.BringToFront;
         cmdForm.Refresh;
         cmdTr:=TCMDThread.Create(src, dest, 'move');
         end
       else
         begin //����஢����
         cmdImage.Bitmap.LoadFromBitmap(bCopy.Glyph);
         cmdLabel.Caption:=pdeLoadNLS('dlgCopying', '����஢����')+' '+src+' '+
           IntToStr(CalcTreeSize(src) div 1024)+pdeLoadNLS('statusKBytes', '��')+
           ' '+pdeLoadNLS('statusIn', '�')+' '+dest+' . . .';
         cmdForm.Show;
         cmdForm.BringToFront;
         cmdForm.Refresh;

         cmdTr:=TCMDThread.Create(fsrc, fdest, 'copy');
         end;
       cmdForm.Hide;
       MainForm.Activate;
       //LoadList;

       //each process must free the shared memory !!
       FreeNamedSharedMem(TExternalDragDropObject(Source).SourceFileName);
    End;
End;

Procedure TMainForm.vFilesOnCanDrag (Sender: TObject; X: LongInt; Y: LongInt;
  Var Accept: Boolean);
Begin
//���� �� �ࠣ���?
Accept:=(vFiles.ItemCount>0);

End;
//-----------------------------------------

Procedure TMainForm.mAddFavorOnClick (Sender: TObject);
var
  afile: textfile;
  fname, basepath: string;
Begin
//���������� ��������
fname:=path;
if length(fname)>3 then
  begin
  delete(fname, length(fname), 1);
  while pos('\', fname)<>0 do
    delete(fname, 1, 1);
  end;

  basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

  assignfile(afile, basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+'\['+fname+']');
  rewrite(afile);
  writeln(afile, '[SHORTCUT]');
  writeln(afile, '//link: type, object-name, path, parameters');
  writeln(afile, 'FOLDER');
  writeln(afile, path);
  writeln(afile, path);
  writeln(afile);
  closefile(afile);

inc(bookmarkCount);
bookitem[bookmarkCount]:=TMenuItem.Create(self);
bookitem[bookmarkCount].Caption:='['+fname+']';
bookitem[bookmarkCount].hint:=path;
bookitem[bookmarkCount].onclick:=BookMarkClick;
mBookmarks.add(bookitem[bookmarkCount]);

End;

//--go to the HOME directory
Procedure TMainForm.mGotoHomeOnClick (Sender: TObject);
var
  basepath: string;
Begin
basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

path := basepath + pdeLoadCfgStr('general.cfg', 'userhome') + '\';
edPath.Text := Path;
LoadList;
ShowStatus;
End;
//-----------------------------------------

//go to the DRIVES directory
Procedure TMainForm.mGotoDisksOnClick (Sender: TObject);
var
  basepath: string;
Begin
basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

path:=basepath+pdeLoadCfgStr('general.cfg', 'userdrives')+'\';
edPath.Text:=Path;
LoadList;
ShowStatus;
End;
//-----------------------------------------

Procedure TMainForm.mDiskA2OnClick (Sender: TObject);
var
  fsrc, fdest: CString;
  needBytes, isBytes: LongInt;
Begin
//����஢���� �� ��� �:
if vFiles.ItemCount>0 then begin
  needBytes:=CalcTreeSize(dlgCMD.edSource.Text);
  isBytes:=DiskFree(ord(LowerCase(dlgCMD.edDest.Text)[1])-96);
  if (needBytes<isBytes) then
  begin
    cmdImage.Bitmap.LoadFromBitmap(bCopy.Glyph);
    cmdLabel.Caption:=pdeLoadNLS('dlgCopying', '����஢����')+' '+vFiles.Items[vFiles.ItemIndex].Text+' '+
           IntToStr(needBytes div 1024)+pdeLoadNLS('statusKBytes', '��')+
           ' '+pdeLoadNLS('statusIn', '�')+' A:\'+vFiles.Items[vFiles.ItemIndex].Text;
    cmdForm.Show;
    cmdForm.BringToFront;
    fsrc:=path+vFiles.Items[vFiles.ItemIndex].Text;
    fdest:='A:\'+vFiles.Items[vFiles.ItemIndex].Text;
    cmdForm.Refresh;
    DosCopy(fsrc, fdest, DCPY_Existing);
    cmdForm.Hide;
    LoadList;
    end
  else
    pdeMessageBox(pdeLoadNLS('dlgErrorDiskSpace', '�������筮 ���� �� 楫���� ��᪥.')
      +chr(10)+chr(13)+IntToStr(isBytes div 1024)+' '+pdeLoadNLS('dlgErrorVS', '��⨢')+' '+
      +IntToStr(needBytes div 1024)+' '+pdeLoadNLS('statusKBytes', '��'),
      pdeLoadNLS('dlgError', '�訡��'), bCopy.Glyph);
  end;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
End;

Procedure TMainForm.mConfigPDEOnClick (Sender: TObject);
Begin
//����� �ணࠬ�� ����ன�� �DE
  ShellExecute(extractfilepath(application.exename)+'pdeConf.exe', extractfilepath(application.exename), '', false);
//���� ����ன�� FileHalf

End;

Procedure TMainForm.mPrevDriveOnClick (Sender: TObject);
var
  ch: char;
  exPath: string;
Begin
// �।��騩 ���
ch:=Drives.Drive;
dec(ch);
exPath:=ch+':\';
if FileExists(exPath) then
  Drives.Drive:=ch;
End;

Procedure TMainForm.mNextDriveOnClick (Sender: TObject);
var
  ch: char;
  exPath: string;
Begin
//᫥���騩 ���
ch:=Drives.Drive;
inc(ch);
exPath:=ch+':\';
if FileExists(exPath) then
  Drives.Drive:=ch;
End;

Procedure TMainForm.bBackOnClick (Sender: TObject);
Begin
// ������ "�����"
  if prevDir<>'' then
  begin
  nextDir:=path;
  path:=prevDir;
  prevDir:='';
  edPath.Text:=Path;
  LoadList;
  ShowStatus;
  end;
End;

Procedure TMainForm.bForwardOnClick (Sender: TObject);
Begin
// ������ "�����"
if nextDir<>'' then
  begin
  prevDir:=path;
  path:=nextDir;
  nextDir:='';
  edPath.Text:=Path;
  LoadList;
  ShowStatus;
  end;
End;

Procedure TMainForm.Timer1OnTimer (Sender: TObject);
Begin
//���������� �६��� � ��䮏�����
{DecodeDate(Date, Year, Month, Day);}
//InfoMemo.BeginUpdate;
//InfoMemo.Lines.Clear;
//InfoMemo.Lines.Add(IntToStr(day)+'/'+IntToStr(month)+'/'+IntToStr(year));
//InfoMemo.Lines.Add(Days[DayOfWeek(Date)]);
//InfoMemo.Lines.Add(TimeToStr(Time));
//InfoMemo.EndUpdate;
FStat;
{Infolabel.Caption:=IntToStr(day)+'/'+IntToStr(month)+'/'+IntToStr(year)+
  chr(13)+chr(10)+Days[DayOfWeek(Date)]+chr(13)+chr(10)+TimeToStr(Time);}
End;

Procedure TMainForm.mEditAssocOnClick (Sender: TObject);
Begin
  //।����஢���� ���樠権 䠩��� :-)
if txtUtil<>'' then
  Begin
  if (txtUtil[2] = ':') then //full path
    ShellExecute(txtUtil, extractfilepath(txtUtil), extractfilepath(application.exename)+'PDEConf\Associations.cfg', false)
  else
    ShellExecute(extractfilepath(application.exename)+txtUtil, extractfilepath(application.exename), extractfilepath(application.exename)+'PDEConf\Associations.cfg', false);
  End;
End;

Procedure TMainForm.bNewWindowOnClick (Sender: TObject);
//var
//  hObj: HObject;
Begin
//����� ���� FileHalfa
  ShellExecute(application.exename, extractfilepath(application.exename), path, false);
End;

Procedure TMainForm.mAboutOnClick (Sender: TObject);
var
  about, authors, thanks: TStringList;
  cptn, text, licensefile: String;
  logo: Pointer;
Begin
//���ଠ�� � �த��
  about := TStringList.Create;
  about.Add(pdeLoadNLS('pdeName',' ������ Desktop Environment')+' v.0.06');
  about.Add('');
  about.Add(pdeLoadNLS('pdeDescription1', '����᪠� �����窠 ���짮��⥫� ���'));
  about.Add(pdeLoadNLS('pdeDescription2', '����樮���� ��⥬ OS/2 Warp � eCS'));
  about.Add('');
  about.Add(pdeLoadNLS('pdeDescription3', '������� �������� ���㔠��.'));
  about.Add(pdeLoadNLS('pdeDescription4', '�ணࠬ�� ��� �ࠢ����� 䠩����'));
  about.Add(pdeLoadNLS('pdeDescription5', '� �������.'));
//pdeLoadNLS('', '')
  authors := TStringList.Create;
  authors.Add(pdeLoadNLS('pdeAuthors1.1', '��ࣥ�� ��������, stVova'));
  authors.Add('');
  authors.Add(pdeLoadNLS('pdeAuthors1.2', 'p��p����稪'));
  authors.Add(pdeLoadNLS('pdeAuthors1.3', '�ணࠬ��஢����, ������'));
  authors.Add(pdeLoadNLS('pdeAuthors1.4', 'stVova@ukrpost.com.ua'));
  thanks := TStringList.Create;
  thanks.Add(pdeLoadNLS('pdeThanks1.1', '��ࣥ�� ��ࣥ�, SERG'));
  thanks.Add('');
  thanks.Add(pdeLoadNLS('pdeThanks1.2', '���'));
  thanks.Add(pdeLoadNLS('pdeThanks1.3', '��⨪� � ����'));
  thanks.Add(pdeLoadNLS('pdeThanks1.4', 'e-Mail ���������'));
  thanks.Add('');
  thanks.Add('KDE Team for graphics and icons');
  thanks.Add('www.kde.org');
  thanks.Add('');
  thanks.Add('GNOME Team for graphics and icons');
  thanks.Add('www.gnome.org');
  cptn := pdeLoadNLS('dlgAboutProgram', '���ଠ�� � �த��');
  text := pdeLoadNLS('pdeFileHalf', '���㔠��');
  licensefile := 'c:\pde\copying';
  logo := MainForm.Icon;
  pdeAboutDialog(about, authors, thanks, cptn, text, licensefile, logo);
End;

//-----------------------------------------
//��� �।�⠢����� 䠩���
Procedure TMainForm.mTileOnClick (Sender: TObject);
var
  acnrInfo:CNRINFO;
  Flags:LongWord;
Begin
//஢�� ��� 䠩���
if mTile.Checked then exit;

mSmallIcons.Checked:=False;
mIcons.Checked:=False;
mTile.Checked:=True;

vFiles.BitmapSize.CX:=iconsize;
vFiles.BitmapSize.CY:=iconsize;
vFiles.Font:=Screen.GetFontFromPointSize('Courier',8);

  FillChar(acnrInfo,SizeOf(CNRINFO),0);
  Flags:=CMA_FLWINDOWATTR;
  With acnrInfo Do
     Begin
          cb:=SizeOf(CNRINFO);
          flWindowAttr:=CV_ICON;
          slBitmapOrIcon.CX:=vFiles.BitmapSize.CX;
          slBitmapOrIcon.CY:=vFiles.BitmapSize.CY;
          Flags:=Flags Or CMA_SLBITMAPORICON;
          flWindowAttr:=flWindowAttr Or CA_DRAWBITMAP;
     End;
     WinSendMsg(vFiles.Handle,CM_SETCNRINFO,LongWord(@acnrInfo),Flags);

vFiles.Refresh;
LoadList;
End;

Procedure TMainForm.mIconsOnClick (Sender: TObject);
var
  acnrInfo:CNRINFO;
  Flags:LongWord;
Begin
//��ଠ��� ���窨 䠩���
if mIcons.Checked then exit;

mSmallIcons.Checked:=False;
mTile.Checked:=False;
mIcons.Checked:=True;

vFiles.BitmapSize.CX:=iconsize;
vFiles.BitmapSize.CY:=iconsize;
vFiles.Font:=Screen.GetFontFromPointSize('WarpSans',9);

  FillChar(acnrInfo,SizeOf(CNRINFO),0);
  Flags:=CMA_FLWINDOWATTR;
  With acnrInfo Do
     Begin
          cb:=SizeOf(CNRINFO);
          flWindowAttr:=CV_ICON;
          slBitmapOrIcon.CX:=vFiles.BitmapSize.CX;
          slBitmapOrIcon.CY:=vFiles.BitmapSize.CY;
          Flags:=Flags Or CMA_SLBITMAPORICON;
          flWindowAttr:=flWindowAttr Or CA_DRAWBITMAP;
     End;
     WinSendMsg(vFiles.Handle,CM_SETCNRINFO,LongWord(@acnrInfo),Flags);

vFiles.Refresh;
LoadList;
End;

Procedure TMainForm.mSmallIconsOnClick (Sender: TObject);
var
  acnrInfo:CNRINFO;
  Flags:LongWord;
Begin
// �����쪨� ���窨 䠩���
if mSmallIcons.Checked then exit;

mTile.Checked:=False;
mIcons.Checked:=False;
mSmallIcons.Checked:=True;

vFiles.BitmapSize.CX:=iconsize div 2;
vFiles.BitmapSize.CY:=iconsize div 2;
vFiles.Font:=Screen.GetFontFromPointSize('WarpSans',9);

  FillChar(acnrInfo,SizeOf(CNRINFO),0);
  Flags:=CMA_FLWINDOWATTR;
  With acnrInfo Do
     Begin
          cb:=SizeOf(CNRINFO);
          flWindowAttr:=CV_ICON;
          slBitmapOrIcon.CX:=vFiles.BitmapSize.CX;
          slBitmapOrIcon.CY:=vFiles.BitmapSize.CY;
          Flags:=Flags Or CMA_SLBITMAPORICON;
          flWindowAttr:=flWindowAttr Or CA_DRAWBITMAP;
     End;
     WinSendMsg(vFiles.Handle,CM_SETCNRINFO,LongWord(@acnrInfo),Flags);

vFiles.Refresh;
LoadList;
End;
//-----------------------------------------


Procedure TMainForm.mInfoPanelOnClick (Sender: TObject);
Begin
mInfoPanel.Checked:=not(mInfoPanel.Checked);
if mInfoPanel.Checked then
  begin
  InfoPanel.Width:=200;
  vFiles.Width:=MainForm.ClientWidth-InfoPanel.Width;
  end
  else
  begin
  InfoPanel.Width:=0;
  vFiles.Width:=MainForm.ClientWidth-InfoPanel.Width;
  end;
End;

Procedure TMainForm.mStatusOnClick (Sender: TObject);
Begin
mStatus.Checked:=not(mStatus.Checked);
if mStatus.Checked then
  ToolBar1.Size:=24
  else
  ToolBar1.Size:=0;
End;

Procedure TMainForm.mButtonsOnClick (Sender: TObject);
Begin
mButtons.Checked:=not(mButtons.Checked);
if mButtons.Checked then
  ToolBar2.Size:=bBack.Height+4
  else
  ToolBar2.Size:=0;
End;

Procedure TMainForm.mOpenAsTextOnClick (Sender: TObject);
Begin
//open as text
if txtUtil<>'' then
  Begin
  if (txtUtil[2] = ':') then //full path
    ShellExecute(txtUtil, path, path+DeCC(vFiles.Items[vFiles.ItemIndex].Text), false)
  else
    ShellExecute(extractfilepath(application.exename)+txtUtil, path, path+DeCC(vFiles.Items[vFiles.ItemIndex].Text), false);

  End;
End;

Procedure TMainForm.bPropertiesOnClick (Sender: TObject);
var
  fname: string;
  rez: integer;
  Year, Month, Day: Word;
Begin
//show object properties
if vFiles.ItemCount>0 then begin
PropForm.chSystem.Checked:=false;
PropForm.chHidden.Checked:=false;
PropForm.chReadOnly.Checked:=false;
PropForm.chArchiv.Checked:=false;

fname:=path+DeCC(vFiles.Items[vFiles.ItemIndex].Text);

PropForm.Img.Bitmap.LoadFromBitmap(vFiles.Items[vFiles.ItemIndex].Bitmap);
PropForm.LName.Caption:=DeCC(vFiles.Items[vFiles.ItemIndex].Text);
PropForm.LDir.Caption:=extractfilepath(fname);

  if (FindFirst(fname+'\*.*', faAnyFile, sr)=0) then  //����� 䠩�� �� ����� ���� ��㣨� 䠩��� :-)
    begin  //directory
    FindClose(sr);
    PropForm.LSize.Caption:=pdeLoadNLS('dlgPropertiesSize', '������:')+' '+
      IntToStr(CalcTreeSize(fname) div 1024)+' '+pdeLoadNLS('statusKBytes', '��'); //function that find directory tree size
    rez:=FindFirst(fname, faAnyFile, sr);
    if rez=0 then
      begin
      //PropForm.LSize.Caption:='������: '+IntToStr(sr.size);
      if (sr.attr and faSysFile)<>0 then
        PropForm.chSystem.Checked:=True;
      if (sr.attr and faHidden)<>0 then
        PropForm.chHidden.Checked:=True;
      if (sr.attr and faReadOnly)<>0 then
        PropForm.chReadOnly.Checked:=True;
      if (sr.attr and faArchive)<>0 then
        PropForm.chArchiv.Checked:=True;
      end;
    PropForm.LType.Caption:=pdeLoadNLS('dlgPropertiesType', '���:')+' '+pdeLoadNLS('popupmenuFolder', '�����');
    PropForm.LProg.Caption:=pdeLoadNLS('dlgPropertiesProgram', '�ணࠬ��:')+' FileHalf.exe';
    end
  else
    begin //file
    FindClose(sr);
    rez:=FindFirst(fname, faAnyFile, sr);
    if rez=0 then
      begin
      PropForm.LSize.Caption:=pdeLoadNLS('dlgPropertiesSize', '������:')+' '+
        IntToStr(sr.size)+' '+pdeLoadNLS('statusBytes', '����');
      //if (sr.attr and faSysFile)<>0 then
      //  PropForm.chSystem.Checked:=True;
      PropForm.chSystem.Checked := ((sr.attr and faSysFile)<>0);
      //if (sr.attr and faHidden)<>0 then
      //  PropForm.chHidden.Checked:=True;
      PropForm.chHidden.Checked := ((sr.attr and faHidden)<>0);
      //if (sr.attr and faReadOnly)<>0 then
      //  PropForm.chReadOnly.Checked:=True;
      PropForm.chReadOnly.Checked := ((sr.attr and faReadOnly)<>0);
      //if (sr.attr and faArchive)<>0 then
      //  PropForm.chArchiv.Checked:=True;
      PropForm.chArchiv.Checked := ((sr.attr and faArchive)<>0);
      PropForm.LType.Caption:=pdeLoadNLS('dlgPropertiesType', '���:')+' *'+extractfileext(fname);
      PropForm.LProg.Caption:=pdeLoadNLS('dlgPropertiesProgram', '�ணࠬ��:')+' '+
        pdeLoadNLS('dlgPropertiesProgramUnknown', '����।�����');
      if assocCount>0 then
      for i:=1 to assocCount do
        if ANSIUpperCase(extractfileext(fname))=ANSIUpperCase(assoc[i].flt) then
        begin
        PropForm.LProg.Caption:=pdeLoadNLS('dlgPropertiesProgram', '�ணࠬ��:')+assoc[i].pgm;
        break;
        end;
      end
      else
      begin
      PropForm.LSize.Caption:='';

      end;
    FindClose(sr);
    end;

PropForm.LCreateDate.Caption:=pdeLoadNLS('dlgPropertiesCreated', '������:')+' ';
DecodeDate(FileDateToDateTime(FileAge(fname)), Year, Month, Day);
PropForm.LChDate.Caption:=pdeLoadNLS('dlgPropertiesChanged', '������:')+' '+
  IntToStr(Day)+'/'+IntToStr(Month)+'/'+IntToStr(Year);

PropForm.BtnCancel.Default:=True;
PropForm.Show;
PropForm.BringToFront;
end;
End;

Procedure TMainForm.bRefreshOnClick (Sender: TObject);
Begin
//refresh
LoadList;
End;

Procedure TMainForm.bNewOnClick (Sender: TObject);
var
//  fdir: string;
//  rc: APIRET;
    newname: String;
Begin
{newEdit.Text:='';
newForm.ActiveControl:=newEdit;
newBtnOk.Default:=True;
newForm.Show;
newForm.BringToFront;}
  newname := pdePromptDialog(pdeLoadNLS('pdeDlgCreateFolder', '������ ��� ����� �����')
    , pdeLoadNLS('pdeDlgHint5', '������� �����'));
  if newname <> '' then
    begin
    if DosCreateDir(Path + newname, nil) <> 0 then
      pdeMessageBox(pdeLoadNLS('dlgErrorOnFolderCreate', 'H� 㤠���� ᮧ���� �����.')
      +chr(13)+chr(10)+newname, pdeLoadNLS('dlgError', '�訡��'), bNew.Glyph);
    end;
  LoadList;
End;

Procedure TMainForm.bFindOnClick (Sender: TObject);
Begin
if findUtil<>'' then
  ShellExecute(findUtil, path, '', true);
End;

Procedure TMainForm.bRenameOnClick (Sender: TObject);
var
  a_index: Integer;
Begin
//move
if vFiles.ItemCount>0 then begin
dlgCMD.Caption:=pdeLoadNLS('dlgRenaming', '��२���������');
//dlgCMD.Height:=180;
dlgCMD.edSource.Text:=DeCC(vFiles.Items[vFiles.ItemIndex].Text);
dlgCMD.edDest.Text:=dlgCMD.edSource.Text;//'';
dlgCMD.ActiveControl:=dlgCMD.edDest;
dlgCMD.OKButton.Default:=True;
if dlgCMD.ShowModal=cmOK then
  begin
  ObjRename(path+dlgCMD.edSource.Text, path+dlgCMD.edDest.Text);
  //ObjRename(dlgCMD.edSource.Text, dlgCMD.edDest.Text);
  end;
a_index:=vFiles.ItemIndex;
LoadList;
vFiles.ItemIndex:=a_index;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
end;
End;

Procedure TMainForm.bDeleteOnClick (Sender: TObject);
var
  fname: string;
  a_index: integer;
  rez: Integer;
Begin
//delete
if vFiles.ItemCount>0 then begin
fname:=path+DeCC(vFiles.Items[vFiles.ItemIndex].Text);
rez := 0;
if (pdeLoadCfgInt('general.cfg', 'askfordelete') = 1) then
  begin
  if (pdeMessageBox(chr(13)+chr(10)+pdeLoadNLS('dlgDelete', '�������:')+' '+fname+'?',
    pdeLoadNLS('dlgAffirmate', '���⢥न�')+' '+
    pdeLoadNLS('dlgDeleting', '��������'), bDelete.Glyph) = 0) then
    rez := 1;
  end
  else
    rez := 1;
if (rez = 1) then
  begin
  cmdImage.Bitmap.LoadFromBitmap(bDelete.Glyph);
  cmdLabel.Caption:=pdeLoadNLS('dlgDeleting', '��������')+' '+fname+' '+
    IntToStr(CalcTreeSize(fname) div 1024)+pdeLoadNLS('statusKBytes', '��')+' . . .';
  cmdForm.Show;
  cmdForm.BringToFront;
  cmdForm.Refresh;
  ObjDel(fname);
  cmdForm.Hide;
  a_index:=vFiles.ItemIndex-1;
  LoadList;
  if (vFiles.ItemCount>0) and (a_index>0) then
    vFiles.ItemIndex:=a_index;
  end;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
end;
End;

Procedure TMainForm.bMoveOnClick (Sender: TObject);
var
  src, dest: String;
  needBytes, isBytes: LongInt;
  a_index: integer;
  cmdTr: TCMDThread;
Begin
//move
if vFiles.ItemCount>0 then begin
src := path+DeCC(vFiles.Items[vFiles.ItemIndex].Text);
dest := pdeCopyDialog(ExtractFileName(src), pdeLoadNLS('dlgMoving', '��६�饭��'));
if dest<>'' then
  begin
  //needBytes:=CalcTreeSize(src);
  //isBytes:=DiskFree(ord(LowerCase(dest)[1])-96);
  needBytes := CalcTreeSize(src) div 1024;
  isBytes   := DiskFreeKb(ord(LowerCase(dest)[1])-96);
  if (needBytes<isBytes) then
    begin
    cmdImage.Bitmap.LoadFromBitmap(bCopy.Glyph);
    cmdLabel.Caption:=pdeLoadNLS('dlgMoving', '��६�饭��')+' '+DeCC(vFiles.Items[vFiles.ItemIndex].Text)+
      +' '+IntToStr(needBytes div 1024)+pdeLoadNLS('statusKBytes','Kb')+
      ' '+pdeLoadNLS('statusIn', '�')+' '+ExtractFileName(dest);
    cmdForm.Show;
    cmdForm.BringToFront;
    cmdForm.Refresh;
    cmdTr:=TCMDThread.Create(src, dest, 'move');
    cmdForm.Hide;
    a_index:=vFiles.ItemIndex-1;
    LoadList;
    if (vFiles.ItemCount>0) and (a_index>0) then
      vFiles.ItemIndex:=a_index;
    end
  else
  pdeMessageBox(pdeLoadNLS('dlgErrorDiskSpace', '�������筮 ���� �� 楫���� ��᪥.')
    +chr(10)+chr(13)+IntToStr(isBytes div 1024)+pdeLoadNLS('statusKBytes', 'Kb')
    +' '+pdeLoadNLS('dlgErrorVS', '��⨢')+' '
    +IntToStr(needBytes div 1024)+pdeLoadNLS('statusKBytes', 'Kb'), pdeLoadNLS('dlgError', '�訡��')
    , bCopy.Glyph);
  end;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
end;
End;

Procedure TMainForm.bCopyOnClick (Sender: TObject);
var
  src, dest: String;
  needBytes, isBytes: LongInt;
  rc: apiret;
  cmdTr: TCMDThread;
Begin
//copy
rc:=0;
if vFiles.ItemCount>0 then begin
src := path+DeCC(vFiles.Items[vFiles.ItemIndex].Text);
dest := pdeCopyDialog(ExtractFileName(src), pdeLoadNLS('dlgCopying', '����஢����'));
if dest<>'' then
  begin
  //needBytes:=CalcTreeSize(src);
  //isBytes:=DiskFree(ord(LowerCase(dest)[1])-96);
  needBytes := CalcTreeSize(src) div 1024;
  isBytes   := DiskFreeKb(ord(LowerCase(dest)[1])-96);
  if (needBytes<isBytes) then
    begin
    cmdImage.Bitmap.LoadFromBitmap(bCopy.Glyph);
    cmdLabel.Caption:=pdeLoadNLS('dlgCopying', '����஢����')+' '+DeCC(vFiles.Items[vFiles.ItemIndex].Text)+
      ' ('+IntToStr(needBytes div 1024)+pdeLoadNLS('statusKBytes', 'Kb')+' ) '
      +pdeLoadNLS('statusIn', '�')+ExtractFileName(dest);
    cmdForm.Show;
    cmdForm.BringToFront;
    cmdForm.Refresh;

    cmdTr:=TCMDThread.Create(src, dest, 'copy');
    cmdForm.Hide;
    LoadList;
    end
  else
  pdeMessageBox(pdeLoadNLS('dlgErrorDiskSpace', '�������筮 ���� �� 楫���� ��᪥.')
    +chr(10)+chr(13)+IntToStr(isBytes div 1024)+pdeLoadNLS('statusKBytes', 'Kb')
    +' '+pdeLoadNLS('dlgErrorVS', '��⨢')+' '+IntToStr(needBytes div 1024)
    +pdeLoadNLS('statusKBytes', 'Kb'), pdeLoadNLS('dlgError', '�訡��')
    , bCopy.Glyph);
  end;

WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
end;
End;

Procedure TMainForm.DirsOnItemSelect (Sender: TObject; Index: LongInt);
Begin
path:=Dirs.Directory;
if (Path[length(Path)]<>'\') then
  path:=Path+'\';

MainForm.Caption:=path;
ShowStatus;
LoadList;
End;

Procedure TMainForm.DrivesOnChange (Sender: TObject);
Begin
path:=Drives.Drive+':\';
Dirs.Drive:=Drives.Drive;
MainForm.Caption:=path;
//ShowStatus;
LoadList;
End;

function TMainForm.GoInto: integer;
var
  fname: string;
Begin
  prevDir:=path;
  fname:=path+DeCC(vFiles.Items[vFiles.ItemIndex].Text);
  if (FindFirst(fname+'\*.*', faAnyFile, sr)=0) then  //����� 䠩�� �� ����� ���� ��㣨� 䠩��� :-)
    begin  //directory
    FindClose(sr);
    path:=fname;
    Dirs.Directory:=path;
    if (Path[length(Path)]<>'\') then
      path:=Path+'\';
    edPath.Text:=Path;
    LoadList;
    end
  else
    begin
    FindClose(sr);

    if (pos('.EXE', ansiuppercase(fname))<>0)or(pos('.COM', ansiuppercase(fname))<>0)
       or(pos('.CMD', ansiuppercase(fname))<>0)or(pos('.BAT', ansiuppercase(fname))<>0) then
      ShellExecute(fname, ExtractFilePath(fname), '', false)
      //StartApp(fname, ExtractFilePath(fname), '', false)
    else
      ResolveAssociation(fname);
      //MessageBox('error: '+fname, mtInformation, [mbOK]);
    end;
End;

Procedure TMainForm.MainFormOnDestroy (Sender: TObject);
Begin
  tmp{[1]}.Free;
  {tmp[2].Free;
  tmp[3].Free;
  tmp[4].Free;
  tmp[5].Free;}
End;

function TMainForm.ShowStatus: integer;
begin
//InfoMemo.Text:='';
DecodeDate(Date, Year, Month, Day);
Infolabel.Caption:=IntToStr(day)+'/'+IntToStr(month)+'/'+IntToStr(year)+chr(13)+chr(10)+
                   Days[DayOfWeek(Date)]+chr(13)+chr(10)+TimeToStr(Time);
//InfoMemo.Lines.Add(IntToStr(day)+'/'+IntToStr(month)+'/'+IntToStr(year));
//InfoMemo.Lines.Add(Days[DayOfWeek(Date)]);
//InfoMemo.Lines.Add(TimeToStr(Time));

{for i:=0 to vFiles.ItemCount-1 do
  if vFiles.Selected[i] then
  begin
  InfoMemo.Lines.Add(ANSIUpperCase(vFiles.Items[i].Text));
  end;
}
end;

Procedure TMainForm.mOpenOnClick (Sender: TObject);
Begin
//menu Open
//vFilesOnMouseDblClick (Sender, mbLeft, [],  0, 0);
GoInto;
End;

Procedure TMainForm.vFilesOnItemSelect (Sender: TObject; Index: LongInt);
Begin
ShowStatus;
GoInto;
//vFilesOnMouseDblClick (Sender, mbLeft, [],  0, 0);
//InfoMemo.Lines.Add('');
//InfoMemo.Lines.Add(IntToStr(count)+' ��.');
End;

Procedure TMainForm.bUpOnClick (Sender: TObject);
Begin
  if length(path)>3 then
  begin
  nextDir:=path;
  delete(path, length(path), 1);
  while path[length(path)]<>'\' do
    delete(path, length(path), 1);
  path:=path;
  edPath.Text:=Path;
  LoadList;
  end;
ShowStatus;
End;

Procedure TMainForm.MainFormOnResize (Sender: TObject);
Begin
if MainForm.Height>Screen.Height-40 then
  begin
  MainForm.Height:=Screen.Height-40;
  MainForm.Top:=0;
  end;
if MainForm.ClientWidth>450 then
  begin
  if mInfoPanel.Checked then
    InfoPanel.Width:=200;
  vFiles.Width:=MainForm.ClientWidth-InfoPanel.Width
  end
else
  begin
  InfoPanel.Width:=0;
  vFiles.Width:=MainForm.ClientWidth;
  end;
Dirs.Height:=InfoPanel.Height-100;
End;

Procedure TMainForm.MainFormOnCreate (Sender: TObject);
var
  afile: TextFile;
  itext, ihint, ftype, fbmp, fprg: string;
  tsr: TSearchRec;
  rez: Integer;
  basepath: String;
Begin
//Application.OnShowHint:=FormShowHint;
Days[1]:=pdeLoadNLS('daySundayLong', '����ᥭ�');
Days[2]:=pdeLoadNLS('dayMondayLong', '�������쭨�');
Days[3]:=pdeLoadNLS('dayTuesdayLong', '��୨�');
Days[4]:=pdeLoadNLS('dayWednesdayLong', '�।�');
Days[5]:=pdeLoadNLS('dayThursdayLong', '��⢥�');
Days[6]:=pdeLoadNLS('dayFridayLong', '��⭨�');
Days[7]:=pdeLoadNLS('daySaturdayLong', '�㡮�');

//����㧪� ��樠権
if FileExists(extractfilepath(application.exename)+'\PDEConf\Associations.cfg') then
begin
assignfile(afile, extractfilepath(application.exename)+'\PDEConf\Associations.cfg');
reset(afile);
readln(afile); //header
readln(afile); //header
assocCount:=0;
while not(eof(afile)) do
  begin
  inc(assocCount);
  readln(afile, assoc[assocCount].flt);
  readln(afile, assoc[assocCount].pgm);
  readln(afile, assoc[assocCount].bmp);
  readln(afile);
  end;
closefile(afile);
end;

//����㧪� ᯨ᪠ "����ண� ����᪠"
mQuickRun.submenu:=true;
if FileExists(extractfilepath(application.exename)+'\PDEConf\quickrun.cfg') then begin
assignfile(afile, extractfilepath(application.exename)+'\PDEConf\quickrun.cfg');
reset(afile);
i:=0;
while not(eof(afile)) do
  begin
  inc(i);
  quickmitem[i]:=TMenuItem.Create(self);
  readln(afile, itext);
  readln(afile, ihint);
  quickmitem[i].Caption:=itext;
  quickmitem[i].hint:=ihint;
  quickmitem[i].onclick:=QuickMenuClick;
  mQuickRun.add(quickmitem[i]);
  end;
closefile(afile);
end;

//����㧪� ������� "������ �"
mOpenWith.submenu:=true;
if FileExists(extractfilepath(application.exename)+'\PDEConf\openwith.cfg') then
begin
  assignfile(afile, extractfilepath(application.exename)+'\PDEConf\openwith.cfg');
  reset(afile);
//i:=0;
  while not(eof(afile)) do
    begin
    //inc(i);
    openwithitem := TMenuItem.Create(self);
    readln(afile, itext);
    readln(afile, ihint);
    openwithitem.Caption:=itext;
    openwithitem.hint:=ihint;
    openwithitem.onclick := OpenWithMenuClick;
    mOpenWith.add(openwithitem);
    end;
  closefile(afile);
end;

//����㧪� ��������
bookmarkCount:=0;
mBookmarks.Submenu:=true;

basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

rez:=FindFirst(basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+'\*.*', faAnyFile, tsr);
if rez<>0 then exit;
  while rez=0 do
    begin
    rez:=FindNext(tsr);
    if rez<>0 then break;
    if (tsr.attr and faDirectory)=0 then //file
      begin
      assignfile(afile, basepath+pdeLoadCfgStr('general.cfg', 'userbookmarks')+'\'+tsr.name);
      reset(afile);
      readln(afile); readln(afile); readln(afile);
      readln(afile, itext);

      inc(bookmarkCount);
      bookitem[bookmarkCount]:=TMenuItem.Create(self);
      bookitem[bookmarkCount].Caption:=tsr.name;
      bookitem[bookmarkCount].hint:=itext;
      bookitem[bookmarkCount].onclick:=BookMarkClick;
      mBookmarks.add(bookitem[bookmarkCount]);

      closefile(afile);
      end;
    end;
FindClose(tsr);
//���㭪� ��� ������
FileHalfCfg;

//������⥪�
//DosLoadModule('pDlgs.dll', sizeof('pDlgs.dll'), 'pDlgs.dll', hpDlgs);

End;

Procedure TMainForm.bGoOnClick (Sender: TObject);
Begin
  path:=edPath.Text;
  LoadList;
  ShowStatus;
End;

Procedure TMainForm.Form1OnShow (Sender: TObject);
var
  tbmp: TPicture;
Begin
filter:='*.*';
Dirs.Directory:=path;
ShowStatus;
tbmp:=TPicture.Create(Self);
if assocCount>0 then
  for i:=1 to assocCount do
    begin
    if FileExists(extractfilepath(application.exename)+'Bitmaps\FileTypes\'+assoc[i].bmp) then
      tbmp.LoadFromFile(extractfilepath(application.exename)+'Bitmaps\FileTypes\'+assoc[i].bmp);
    iBitmaps.Add(tbmp.bitmap, tbmp.bitmap);
    end;

tbmp.free;
tmp:=TBitmap.Create;

if ParamStr(1)<>'' then
  begin
  path:='';
  for i:=1 to paramcount do
    path:=path+ParamStr(i)+' ';
  Delete(path, length(path), 1);
  end
else
  begin
  path:='c:\';
  end;
LoadList;
MainForm.ActiveControl:=vFiles;

//create copy-move-delete form
cmdForm:=TCMDForm.Create(Self); cmdForm.Caption:=pdeLoadNLS('dlgFileOperationsCaption', '������� ����樨');
cmdForm.BorderStyle:=bsStealthDlg;//bsDialog;
cmdForm.ClientWidth:=410; cmdForm.ClientHeight:=140;
cmdForm.Position:=poScreenCenter;
cmdBtn:=TButton.Create(cmdForm); cmdBtn.Parent:=cmdForm;
cmdBtn.Caption:=pdeLoadNLS('dlgHideButton', '�������');
cmdBtn.Default:=True;
cmdBtn.Width:=80; cmdBtn.Height:=30;
cmdBtn.Left:=310; cmdBtn.Top:=105;
cmdBtn.OnClick:=CancelFileOp;
cmdLabel:=TLabel.Create(cmdForm); cmdLabel.Parent:=cmdForm;
cmdLabel.Width:=360; cmdLabel.Height:=20; cmdLabel.Alignment:=taRightJustify;
cmdLabel.Left:=17; cmdLabel.Top:=60; cmdLabel.Font.Name:='WarpSans:9';
cmdImage:=TImage.Create(cmdForm); cmdImage.Parent:=cmdForm;
cmdImage.Width:=32; cmdImage.Height:=32;
cmdImage.Left:=20; cmdImage.Top:=16;
cmdBevel:=TBevel.Create(cmdForm); cmdBevel.Parent:=cmdForm;
cmdBevel.Width:=378; cmdBevel.Height:=2;
cmdBevel.Left:=17; cmdBevel.Top:=98;
//-----------------------------------------
//create new folder form
{newForm:=TNewForm.Create(Self);
newForm.Caption:=pdeLoadNLS('dlgCreateFolderCaption', '�������� �����');
newForm.BorderStyle:=bsStealthDlg;//bsDialog;
newForm.ClientWidth:=400;
newForm.ClientHeight:=140;
newForm.Position:=poScreenCenter; newForm.Font.Name:='WarpSans:9';

newBtnOk:=TButton.Create(newForm); newBtnOk.Parent:=newForm;
newBtnOk.Caption:=pdeLoadNLS('dlgOkButton', '�K');
newBtnOk.Default:=True;
newBtnOk.Width:=80; newBtnOk.Height:=30; newBtnOk.Left:=230; newBtnOk.Top:=105;
newBtnOk.OnClick:=CreateNewFolder;
newBtnCancel:=TButton.Create(newForm); newBtnCancel.Parent:=newForm;
newBtnCancel.Caption:=pdeLoadNLS('dlgCancelButton', '�⬥��');
newBtnCancel.Width:=80; newBtnCancel.Height:=30; newBtnCancel.Left:=315; newBtnCancel.Top:=105;
newBtnCancel.OnClick:=CancelNewFolder;

newLabel:=TLabel.Create(newForm); newLabel.Parent:=newForm;
newLabel.Caption:=pdeLoadNLS('NewFolderButton', '����� �����');
newLabel.Width:=320;
newLabel.Height:=20;
newLabel.Left:=70;
newLabel.Top:=30;
newEdit:=TEdit.Create(newForm); newEdit.Parent:=newForm;
newEdit.Width:=320;
newEdit.Height:=20;
newEdit.Left:=70;
newEdit.Top:=60;

newImage:=TImage.Create(newForm); newImage.Parent:=newForm;
newImage.Bitmap.LoadFromBitmap(bNew.Glyph);
newImage.Width:=32;
newImage.Height:=32;
newImage.Left:=20;
newImage.Top:=16;
newBevel:=TBevel.Create(newForm); newBevel.Parent:=newForm;
newBevel.Width:=378;
newBevel.Height:=2;
newBevel.Left:=17;
newBevel.Top:=98;}
//-----------------------------------------
//create new Shortcut form
linkForm:=TLinkForm.Create(Self);
linkForm.Caption:=pdeLoadNLS('dlgCreateShortcut', '�������� ��몠');
linkForm.BorderStyle:=bsStealthDlg;//bsDialog;
linkForm.ClientWidth:=475;
linkForm.ClientHeight:=325-15;
linkForm.Position:=poScreenCenter; linkForm.Font.Name:='WarpSans Bold:9';
lnkImage:=TImage.Create(linkForm); lnkImage.Parent:=linkForm;
lnkImage.Bitmap.LoadFromBitmap(Image2.Picture.Bitmap);
lnkImage.Width:=120; lnkImage.Height:=245;
lnkImage.Left:=1; lnkImage.Top:=3+10;

lnkLabel1:=TLabel.Create(linkForm); lnkLabel1.Parent:=linkForm;
lnkLabel1.Caption:=pdeLoadNLS('dlgShortcutPlace', '��ᯮ������� ��몠'); lnkLabel1.Autosize:=true;
lnkLabel1.Left:=129; lnkLabel1.Top:=8;
lnkLabel2:=TLabel.Create(linkForm); lnkLabel2.Parent:=linkForm;
lnkLabel2.Caption:=pdeLoadNLS('dlgShortcutData', '����� �� ��室��� ��쥪�'); lnkLabel2.Autosize:=true;
lnkLabel2.Left:=129; lnkLabel2.Top:=50;
lnkLabel3:=TLabel.Create(linkForm); lnkLabel3.Parent:=linkForm;
lnkLabel3.Caption:=pdeLoadNLS('dlgShortcutType', '���'); lnkLabel3.Autosize:=true;
lnkLabel3.Left:=129; lnkLabel3.Top:=76;
lnkLabel4:=TLabel.Create(linkForm); lnkLabel4.Parent:=linkForm;
lnkLabel4.Caption:=pdeLoadNLS('dlgShortcutName', '���'); lnkLabel4.Autosize:=true;
lnkLabel4.Left:=129; lnkLabel4.Top:=104;
lnkLabel5:=TLabel.Create(linkForm); lnkLabel5.Parent:=linkForm;
lnkLabel5.Caption:=pdeLoadNLS('dlgShortcutPath', '����'); lnkLabel5.Autosize:=true;
lnkLabel5.Left:=129; lnkLabel5.Top:=135;
lnkLabel6:=TLabel.Create(linkForm); lnkLabel6.Parent:=linkForm;
lnkLabel6.Caption:=pdeLoadNLS('dlgShortcutParams', '��ࠬ����'); lnkLabel6.Autosize:=true;
lnkLabel6.Left:=129; lnkLabel6.Top:=165;

lnkEdit1:=TEdit.Create(linkForm); lnkEdit1.Parent:=linkForm;
lnkEdit1.Width:=329; lnkEdit1.Left:=129; lnkEdit1.Top:=25+5;
lnkEdit2:=TEdit.Create(linkForm); lnkEdit2.Parent:=linkForm;
lnkEdit2.Width:=294; lnkEdit2.Left:=164; lnkEdit2.Top:=72+5;
lnkEdit3:=TEdit.Create(linkForm); lnkEdit3.Parent:=linkForm;
lnkEdit3.Width:=294; lnkEdit3.Left:=164; lnkEdit3.Top:=100+5;
lnkEdit4:=TEdit.Create(linkForm); lnkEdit4.Parent:=linkForm;
lnkEdit4.Width:=294; lnkEdit4.Left:=164; lnkEdit4.Top:=130+5;
lnkEdit5:=TEdit.Create(linkForm); lnkEdit5.Parent:=linkForm;
lnkEdit5.Width:=254; lnkEdit5.Left:=204; lnkEdit5.Top:=160+5;

lnkBevel:=TBevel.Create(linkForm); lnkBevel.Parent:=linkForm;
lnkBevel.Width:=462; lnkBevel.Height:=4;
lnkBevel.Left:=2; lnkBevel.Top:=252+10;

lnkBtnOk:=TButton.Create(linkForm); lnkBtnOk.Parent:=linkForm;
lnkBtnOk.Caption:=pdeLoadNLS('dlgCreateButton', 'C������');
lnkBtnOk.Default:=True;
lnkBtnOk.Height := 26;
lnkBtnOk.Left:=290; lnkBtnOk.Top:=265+10;
lnkBtnOk.OnClick:=CreateShortcut;
lnkBtnCancel:=TButton.Create(linkForm); lnkBtnCancel.Parent:=linkForm;
lnkBtnCancel.Caption:=pdeLoadNLS('dlgCancelButton', 'O⬥��');
lnkBtnCancel.Height := 26;
lnkBtnCancel.Left:=380; lnkBtnCancel.Top:=265+10;
lnkBtnCancel.OnClick:=CancelCreateShortcut;
//-----------------------------------------

End;

//--loading folders and files to the ListView--
function TMainForm.LoadList: integer;
var
  rez: integer;
  attr: byte;
  afile: TextFile;
  ftype: string;
  dfree: LongInt;
  basepath: String;
  //lists for sort
  dirList, fileList: TStringList;
  sortCount: Integer;
Begin
rez:=0;
count:=0;
MainForm.Caption:=path;

basepath := getenv('PDE_HOME');
  if basepath = '' then
    basepath := 'c:\pde';

if (ansiuppercase(MainForm.Caption)=ansiuppercase(basepath+pdeLoadCfgStr('general.cfg', 'userdrives')+'\')) then
  MainForm.Caption:='/';
if (Path<>'') then
  begin
  LoadListProgress.Position := 0;
  LoadListProgress.Visible := True;
  vFiles.BeginUpdate;
  vFiles.Clear;
  LoadListProgress.Position := 20;
  //vFiles.EndUpdate;
  attr:=faReadOnly Or faSysFile Or faDirectory Or faArchive;
  if mShowHidden.Checked then attr := attr Or faHidden;
  rez:=FindFirst(Path+'*.*'{filter}, attr{faAnyFile}, sr);
  if rez<>0 then begin vFiles.EndUpdate; LoadListProgress.Visible:=False; exit; end;
  iBitmaps.GetBitmap(0, tmp); //folder

  dirList := TStringList.Create;

  //vFiles.Sorted:=True;
  while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.attr and faDirectory)<>0 then
      if sr.name<>'..' then
      begin
      inc(count);
      dirList.Add(sr.name);
      //vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp{[1]})
      end;
    end;
  //vFiles.Sorted:=False;
  FindClose(sr);

  dirList.Sort;
  if dirList.Count > 0 then
  for sortCount := 0 to dirList.Count - 1 do
    vFiles.Add(CorectCaption(dirList.Strings[sortCount]), Pointer(0), tmp);

  dirList.Free;

  LoadListProgress.Position := 50;

  rez:=FindFirst(Path+filter, attr{faAnyFile}, sr);
  if rez<>0 then begin vFiles.EndUpdate; LoadListProgress.Visible:=False; exit; end;

  //��� �⮣� ���� ������ ���� ������� ��⠫���
  //⮫쪮 �� FAT32, FAT16 ��᪠�
  if sr.name<>'.' then
    begin
    inc(count);
    if (sr.attr and faDirectory)<>0 then
      vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp{[1]})
    else
      begin
      if (mShowPreview.Checked) and (UpperCase(ExtractFileExt(sr.name)) = '.BMP') then
                begin
                try
                  tmp.LoadFromFile(path + sr.name);
                  except
                  tmp.free;
                  tmp:= TBitmap.Create;
                  iBitmaps.GetBitmap(4, tmp);
                  end;
                vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp);
                end
      else
        begin
        if assocCount>0 then
          for i:=1 to assocCount do
            if (pos(assoc[i].flt, lowercase(sr.name))=(length(sr.name)-length(assoc[i].flt)+1)) then
              begin
              iBitmaps.GetBitmap(i-1, tmp);
              vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp);
              break;
              end;
        end;
      i:=0;
      end;
    end;
  //-----------------------------------------

  while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.attr and faDirectory)=0 then
    begin
      inc(count);

      if (mShowPreview.Checked) and (UpperCase(ExtractFileExt(sr.name)) = '.BMP') then
                begin
                try
                  //tmp.width := vFiles.bitmapsize.cx;
                  //tmp.height := vFiles.bitmapsize.cx;

                  tmp := TBitmap.Create;
                  tmp.LoadFromFile(path + sr.name);
                  //tmp.canvas.fillrect(tmp.canvas.cliprect, vFiles.Color);
                  //if (_tmp.width > _tmp.height) then
                  //  tmp.canvas.stretchdraw( 0, 0, vFiles.bitmapsize.cx, _tmp.height*vFiles.bitmapsize.cx div _tmp.width, _tmp)
                  //  else
                  //  tmp.canvas.stretchdraw( 0, 0, _tmp.width*vFiles.bitmapsize.cx div _tmp.height,  vFiles.bitmapsize.cy, _tmp);
                  except
                  tmp.free;
                  tmp:= TBitmap.Create;
                  iBitmaps.GetBitmap(4, tmp);
                  end;
                //_tmp.free;
                vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp);
                i := 0;
                end
        {else if (mShowPreview.Checked) and (UpperCase(ExtractFileExt(sr.name)) = '.ICO') then
                begin
                MessageBox('aaa', mtInformation, [mbOK]);
                try
                  tmp2 := TPicture.Create(Self);
                  tmp2.Icon.LoadFromFile(path + sr.name);
                  except
                  tmp2.free;
                  iBitmaps.GetBitmap(4, tmp);
                  end;
                if tmp2 <> nil then
                  vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp2.Bitmap)
                  else
                  vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp);
                tmp2.free;
                end}
        else
        begin
        if assocCount>0 then
          for i:=1 to assocCount do
            if (pos(assoc[i].flt, lowercase(sr.name))=(length(sr.name)-length(assoc[i].flt)+1)) then
              begin
              iBitmaps.GetBitmap(i-1, tmp);
              vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp);
              i:=0;
              break;
              end;
        end;
     if (i<>0) and (pos('.', sr.name)=0) then begin
     i:=1;
//     FileMode:=0;
     assignfile(afile, path+sr.name);
     reset(afile);
     readln(afile, ftype);
     if ftype='[SHORTCUT]' then
       begin
       i:=0;
       readln(afile);
       readln(afile, ftype);
       if (ftype='APP')or(ftype='PDE') then
         begin
         iBitmaps.GetBitmap(5, tmp);
         vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp)
         end
       else if ftype='FOLDER' then
         begin
         iBitmaps.GetBitmap(0, tmp);
         vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp)
         end
       else if ftype='HDD' then
         begin
         iBitmaps.GetBitmap(1, tmp);
         vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp)
         end
       else if ftype='FDD' then
         begin
         iBitmaps.GetBitmap(2, tmp);
         vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp)
         end
       else if ftype='CD-ROM' then
         begin
         iBitmaps.GetBitmap(3, tmp);
         vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp)
         end;
       end;
     closefile(afile);
//     FileMode:=2;
                  end;

    if i<>0 then //unknown file type
        begin
        iBitmaps.GetBitmap(4, tmp);
        vFiles.Add(CorectCaption(sr.name), Pointer(sr.size), tmp)
        end;

    end;
    end;
  FindClose(sr);
  LoadListProgress.Position := 80;

  //dfree:=DiskFree(ord(LowerCase(path)[1])-96);
  dfree := DiskFreeKb(ord(LowerCase(path)[1])-96);
  if dfree < 1024{1048576} then
    {LStat.Caption:='| '+IntToStr(count)+pdeLoadNLS('statusObjects', '��.')+' | '
      +pdeLoadNLS('statusAvaible', '����㯭�')+' '+FloatToStrF(dfree/1024, ffFixed, 2, 2)+
      pdeLoadNLS('statusKBytes', '��')+' '+pdeLoadNLS('statusOf', '��')+' '+
      FloatToStrF(DiskSize(ord(LowerCase(path)[1])-96)/1048576, ffFixed, 2, 2)+pdeLoadNLS('statusMBytes', '��')}
    LStat.Caption:='| '+IntToStr(count)+pdeLoadNLS('statusObjects', '��.')+' | '
      +pdeLoadNLS('statusAvaible', '����㯭�')+' '+IntToStr(dfree)+
      pdeLoadNLS('statusKBytes', '��')+' '+pdeLoadNLS('statusOf', '��')+' '+
      FloatToStrF(DiskSizeKb(ord(LowerCase(path)[1])-96)/1024, ffFixed, 2, 2)+pdeLoadNLS('statusMBytes', '��')
  else
    {LStat.Caption:='| '+IntToStr(count)+pdeLoadNLS('statusObjects', '��.')+' | '
      +pdeLoadNLS('statusAvaible', '����㯭�')+' '+FloatToStrF(dfree/1048576, ffFixed, 2, 2)+
      pdeLoadNLS('statusMBytes', '��')+' '+pdeLoadNLS('statusOf', '��')+' '+
      FloatToStrF(DiskSize(ord(LowerCase(path)[1])-96)/1048576, ffFixed, 2, 2)+pdeLoadNLS('statusMBytes', '��');}
    LStat.Caption:='| '+IntToStr(count)+pdeLoadNLS('statusObjects', '��.')+' | '
      +pdeLoadNLS('statusAvaible', '����㯭�')+' '+FloatToStrF(dfree/1024, ffFixed, 2, 2)+
      pdeLoadNLS('statusMBytes', '��')+' '+pdeLoadNLS('statusOf', '��')+' '+
      FloatToStrF(DiskSizeKb(ord(LowerCase(path)[1])-96)/1024, ffFixed, 2, 2)+pdeLoadNLS('statusMBytes', '��');

  edPath.Text:=path;
  LoadListProgress.Position := 100;
  vFiles.EndUpdate;
  LoadListProgress.Visible := False;
  end;
//MainForm.SetFocus(vFiles);
End;

function TMainForm.ShellExecute(fname, fdir, fparam: string; shortcut: boolean): Boolean;
var
  sd: StartData;
  idSession: ULong;
  apid: PID;
  fname2, fparam2: pchar;
  rc, rc2: APIRET;
begin
if not(shortcut) and (fparam <> '') then
  fparam:='"'+fparam+'"';  //<-���� �� �஡����� � ��� � 䠩��
new(fname2);
new(fparam2);
StrPCopy(fname2, fname);
StrPCopy(fparam2, fparam);

//fparam2:=StrCat(fname2, fparam2);

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

if rc2 <> 0 then //ERROR!!!
  pdeMessageBox(pdeLoadNLS('dlgRunErrorProgram', '�ணࠬ��:')+' '+fname+chr(13)+
    chr(10)+pdeLoadNLS('dlgErrorCode', '��� �訡��:')+' '+IntToStr(rc2)
  , pdeLoadNLS('dlgRunErrorCaption', '�訡�� ����᪠'), bNewWindow.Glyph);
end;

function TMainForm.ResolveAssociation(fname: string): integer;
var
  afile: textfile;
  ftype, aname, apath, aparams: string;
Begin
//��।��塞 �� ���७�� 䠩��, ����� �ணࠬ�� �������
if assocCount>0 then
  for i:=1 to assocCount do
    begin
    if (pos(assoc[i].flt, LowerCase(fname))<>0) then
      begin
      shellexecute(assoc[i].pgm, ExtractFilePath(assoc[i].pgm), fname, false);
      exit;
      end;
    end;

//is this shortcut?
     assignfile(afile, fname);
     reset(afile);
     readln(afile, ftype);
     if ftype='[SHORTCUT]' then
       begin
       i:=0;
       readln(afile);
       readln(afile, ftype);
       if ftype='APP' then
         begin
         readln(afile, aname);
         readln(afile, apath);
         readln(afile, aparams);
         ShellExecute(aname, apath, aparams, true);
         end
       else if ftype='FOLDER' then
         begin
         readln(afile, aname);
         //ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', '', aname);
         path:=aname;
         Dirs.Directory:=path;
         edPath.Text:=Path;
         LoadList;
         end
       else if ftype='HDD' then
         begin
         readln(afile, aname);
         //ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', '', aname);
         path:=aname;
         Dirs.Directory:=path;
         edPath.Text:=Path;
         LoadList;
         end
       else if ftype='FDD' then
         begin
         readln(afile, aname);
         //ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', '', aname);
         path:=aname;
         Dirs.Directory:=path;
         edPath.Text:=Path;
         LoadList;
         end
       else if ftype='CD-ROM' then
         begin
         readln(afile, aname);
         //ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', '', aname);
         path:=aname;
         Dirs.Directory:=path;
         edPath.Text:=Path;
         LoadList;
         end;
       end;
     closefile(afile);
End;

Procedure TMainForm.QuickMenuClick(Sender: TObject);
begin
  ShellExecute(TMenuItem(Sender).Hint, ExtractFilePath(TMenuItem(Sender).Hint), '', false);
end;

Procedure TMainForm.OpenWithMenuClick(Sender: TObject);
begin
if (vFiles.ItemCount > 0) then
  ShellExecute(TMenuItem(Sender).Hint, ExtractFilePath(TMenuItem(Sender).Hint)
    , path+DeCC(vFiles.Items[vFiles.ItemIndex].Text), false);
end;

Procedure TMainForm.BookMarkClick(Sender: TObject);
begin
//ShellExecute(extractfilepath(application.exename)+'FileHalf.exe', '',TMenuItem(Sender).Hint, false);
path:=TMenuItem(Sender).Hint;
edPath.Text:=Path;
LoadList;
ShowStatus;
end;

function TMainForm.FileHalfCfg: Integer;
var
  fbase, fbtn, fbmp, fupbmp: String;
  tbmp: TPicture;
  keym: String;
  keyc: TKeyCode;
  col: Integer;
Begin
fbase := ExtractFilePath(application.exename)+'\Bitmaps\FileHalf\';
//���뢠�� 䠩� FileHalf.cfg
tbmp:=TPicture.Create(Self);
vFiles.Color:=pdeLoadCfgColor('filehalf.cfg', 'FileListColor');
iconsize:=32;
iconsize:=pdeLoadCfgInt('filehalf.cfg', 'FilelistIconSize');
vFiles.BitmapSize.CX:=iconsize;
vFiles.BitmapSize.CY:=iconsize;
Toolbar2.Color:=pdeLoadCfgColor('filehalf.cfg', 'ToolbarColor');

col := pdeLoadCfgInt('filehalf.cfg', 'ToolbarSize') + 4;

bBack.Width:=col; bBack.Height:=col;
bBack.Left := 2; bBack.Top := 2;
bBack.Align := alFixedLeftTop;
bForward.Width:=col; bForward.Height:=col;
bForward.Left := col+4; bForward.Top := 2;
bForward.Align := alFixedLeftTop;
bUp.Width:=col; bUp.Height:=col;
bUp.Left := 2*col+6; bUp.Top := 2;
bUp.Align := alFixedLeftTop;
bRefresh.Width:=col; bRefresh.Height:=col;
bRefresh.Left := 3*col+8; bRefresh.Top := 2;
bRefresh.Align := alFixedLeftTop;
bCopy.Width:=col; bCopy.Height:=col;
bCopy.Left := 4*col+16; bCopy.Top := 2;
bCopy.Align := alFixedLeftTop;
bMove.Width:=col; bMove.Height:=col;
bMove.Left := 5*col+18; bMove.Top := 2;
bMove.Align := alFixedLeftTop;
bDelete.Width:=col; bDelete.Height:=col;
bDelete.Left := 6*col+20; bDelete.Top := 2;
bDelete.Align := alFixedLeftTop;
bRename.Width:=col; bRename.Height:=col;
bRename.Left := 7*col+22; bRename.Top := 2;
bRename.Align := alFixedLeftTop;
bFind.Width:=col; bFind.Height:=col;
bFind.Left := 8*col+30; bFind.Top := 2;
bFind.Align := alFixedLeftTop;
bNew.Width:=col; bNew.Height:=col;
bNew.Left := 9*col+32; bNew.Top := 2;
bNew.Align := alFixedLeftTop;
bProperties.Width:=col; bProperties.Height:=col;
bProperties.Left := 10*col+34; bProperties.Top := 2;
bProperties.Align := alFixedLeftTop;
bNewWindow.Width:=col; bNewWindow.Height:=col;
bNewWindow.Left := 11*col+36; bNewWindow.Top := 2;
bNewWindow.Align := alFixedLeftTop;
Bevel1.Height := col;
Bevel1.Left := 4*col+10; Bevel1.Top := 2;
Bevel1.Align := alFixedLeftTop;
Bevel2.Height := col;
Bevel2.Left := 8*col+24; Bevel2.Top := 2;
Bevel2.Align := alFixedLeftTop;
ToolBar2.Height:=bBack.Height+4;

col := pdeLoadCfgColor('filehalf.cfg', 'ShowInfoPanel'); //show InfoPanel
if col=0 then mInfoPanelOnClick(mainform);
col := pdeLoadCfgColor('filehalf.cfg', 'ShowStatus'); //show StatusBar
if col=0 then mStatusOnClick(mainform);
col := pdeLoadCfgColor('filehalf.cfg', 'ShowButtons'); //show Buttons
if col=0 then mButtonsOnClick(mainform);
col := pdeLoadCfgColor('filehalf.cfg', 'ViewType'); //type of view
if col=1 then mTileOnClick(mainform)
  else if col=2 then mSmallIconsOnClick(mainform);

//backward
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhBackward1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhBackward2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bBack.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bBack.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bBack.Hint:=pdeLoadNLS('BackwardButton', '�����');
//forward
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhForward1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhForward2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bForward.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bForward.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bForward.Hint:=pdeLoadNLS('ForwardButton', '���।');
//updir
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhGoup1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhGoup2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bUp.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bUp.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bUp.Hint:=pdeLoadNLS('UpDirButton', '�� �஢��� �����');
//refresh
fbmp := pdeLoadCfgStr('filehalf.cfg', 'ghRefresh1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'ghRefresh2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bRefresh.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bRefresh.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bRefresh.Hint:=pdeLoadNLS('RefreshButton', '��������');
//copy
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhCopy1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhCopy2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bCopy.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bCopy.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bCopy.Hint:=pdeLoadNLS('CopyButton', '����஢���...');
//move
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhMove1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhMove2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bMove.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bMove.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bMove.Hint:=pdeLoadNLS('MoveButton', '��६�����...');
//delete
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhDelete1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhDelete2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bDelete.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bDelete.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bDelete.Hint:=pdeLoadNLS('DeleteButton', '�������...');
//rename
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhRename1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhRename2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bRename.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bRename.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bRename.Hint:=pdeLoadNLS('RenameButton', '��२��������...');
//find
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhFind1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhFind2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bFind.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bFind.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bFind.Hint:=pdeLoadNLS('FindButton', '����');
//new folder
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhNew1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhNew2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bNew.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bNew.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bNew.Hint:=pdeLoadNLS('NewFolderButton', '����� �����');
//properties
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhIdentity1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhIdentity2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bProperties.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bProperties.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bProperties.Hint:=pdeLoadNLS('PropertiesButton', '�����⢠');
//newwindow
fbmp := pdeLoadCfgStr('filehalf.cfg', 'fhNewWin1');
fupbmp := pdeLoadCfgStr('filehalf.cfg', 'fhNewWin2');
if fileexists(fbase+fbmp) then
  tbmp.LoadFromFile(fbase+fbmp);
  bNewWindow.Glyph.LoadFromBitmap(tbmp.Bitmap);
if fileexists(fbase+fupbmp) then
  tbmp.LoadFromFile(fbase+fupbmp);
  bNewWindow.GlyphUp.LoadFromBitmap(tbmp.Bitmap);
bNewWindow.Hint:=pdeLoadNLS('NewWindowButton', '����� ����');

findUtil:=pdeLoadCfgStr('filehalf.cfg', 'FindUtil');  // find utility
txtUtil:=pdeLoadCfgStr('filehalf.cfg', 'TextUtil');  //text editor
archiveUtil:=pdeLoadCfgStr('filehalf.cfg', 'Archiver');  //archiving program

tbmp.free;

//--FileHalf menu--
mFile.Caption := pdeLoadNLS('menuFile', '����');
mNewWindow.Caption := pdeLoadNLS('menunewwindow', '����� ����\tCtrl+N');
mOpen2.Caption := pdeLoadNLS('menuOpen', '�����\tEnter');
mFind2.Caption := pdeLoadNLS('menuFind', '����\tCtrl+F');
mSend2.Caption := pdeLoadNLS('menuSend', '��p�����');
mDiskA2.Caption := pdeLoadNLS('menuDiskA', '��� A:');
mDesktop2.Caption := pdeLoadNLS('menuDeskTop', 'P���稩 �⮫');
mCopy2.Caption := pdeLoadNLS('menuCopy', '����p�����...\tCtrl+C');
mmove2.Caption := pdeLoadNLS('menuMove', '��p�������...\tCtrl+X');
mDel2.Caption := pdeLoadNLS('menuDelete', '�������...\tF8');
mShortcut2.Caption := pdeLoadNLS('menuShortcut', '������� �p��');
mRename2.Caption := pdeLoadNLS('menuRename', '��२��������\tF2');
mCreateNew2.Caption := pdeLoadNLS('menuCreateNew', '������� ����');
mFolder2.Caption := pdeLoadNLS('menuFolder', '�����\tF7');
mText2.Caption := pdeLoadNLS('menuText', 'Text.txt');
mHTM.Caption := pdeLoadNLS('menuHTM', 'Www.htm');
mProperties2.Caption := pdeLoadNLS('menuProperties', '�����⢠\tCtrl+S');
mEdit.Caption := pdeLoadNLS('menuEdit', '�ࠢ��');
mAddbookmark.Caption := pdeLoadNLS('menuAddBookmark', '�������� ��������\tCtrl+B');
mFilter.Caption := pdeLoadNLS('menuFilter', '������ �� �뤥�������');
mViewFile.Caption := pdeLoadNLS('menuViewFile', '��ᬮ�� 䠩��\tF3');
mArchive.Caption := pdeLoadNLS('menuArchive', '�������� � ��娢');
mEditAssoc.Caption := pdeLoadNLS('menuEditAssoc', '�ࠢ��� ���樠樨');
mConfigPDE.Caption := pdeLoadNLS('menuConfigPDE', '����ன�� �DE');
mView.Caption := pdeLoadNLS('menuView', '���');
mRefresh.Caption := pdeLoadNLS('menuRefresh', '��������\F5');
mButtons.Caption := pdeLoadNLS('menuButtons', '������');
mStatus.Caption := pdeLoadNLS('menuStatus', '��ப� �����');
mInfopanel.Caption := pdeLoadNLS('menuInfoPanel', '���-������');
mShowHidden.Caption := pdeLoadNLS('menuShowHidden', '������ 䠩��');
mShowPreview.Caption := pdeLoadNLS('menuShowPreview', '�।��ᬮ��');
mZoomPlus.Caption := pdeLoadNLS('menuZoomPlus', '����⠡ +');
mZoomMinus.Caption := pdeLoadNLS('menuZoomMinus', '����⠡ -');
mPresent.Caption := pdeLoadNLS('menuPresent', '�।�⠢�����');
mIcons.Caption := pdeLoadNLS('menuIcons', '���⮣ࠬ��');
mTile.Caption := pdeLoadNLS('menuTile', '������ ���⪠');
mSmallIcons.Caption := pdeLoadNLS('menuSmallIcons', '�����쪨� ���窨');
mGoto.Caption := pdeLoadNLS('menuGoto', '���室');
mGoup.Caption := pdeLoadNLS('menuGoUp', '�����\tBkSp');
mGoback.Caption := pdeLoadNLS('menuGoBack', '<- �����\tShift+Left');
mGoforv.Caption := pdeLoadNLS('menuGoForv', '����� ->\tShift+Right');
mNextdrive.Caption := pdeLoadNLS('menuNextDrive', '������騩 ���\tCtrl+Right');
mPrevdrive.Caption := pdeLoadNLS('menuPrevDrive', '�।��騩 ���\tCtrl+Left');
mGotoDisks.Caption := pdeLoadNLS('menuGotoDrives', '��᪨');
mGotoHome.Caption := pdeLoadNLS('menuGotoHome', '������� �����');
mHelp.Caption := pdeLoadNLS('menuHelp', '��ࠢ��');
mShowhelp.Caption := pdeLoadNLS('menuShowHelp', '�맮� �ࠢ��');
mAbout.Caption := pdeLoadNLS('menuAbout', '���ଠ�� � �த��');
mQuickRun.Caption := pdeLoadNLS('menuQuickRun', '������ �����');
mBookmarks.Caption := pdeLoadNLS('menuBookmarks', '��������');
//--FileHalf popupmenu--
mOpen.Caption := pdeLoadNLS('popupmenuOpen', '������');
//mOpenAsText.Caption := pdeLoadNLS('popupmenuOpenAsText', '������ ��� ⥪��');
mOpenWith.Caption := pdeLoadNLS('popupmenuOpenWith', '������ c');
mFind.Caption := pdeLoadNLS('popupmenuFind', '����...');
mSend.Caption := pdeLoadNLS('popupmenuSend', '��ࠢ���');
mDiskA.Caption := pdeLoadNLS('popupmenuDiskA', '��� A:');
mDesktop.Caption := pdeLoadNLS('popupmenuDeskTop', '����稩 �⮫');
mCopy.Caption := pdeLoadNLS('popupmenuCopy', '����஢���...');
mMove.Caption := pdeLoadNLS('popupmenuMove', '��६�����...');
mDel.Caption := pdeLoadNLS('popupmenuDelete', '�������...');
mShortcut.Caption := pdeLoadNLS('popupmenuShortcut', '������� ���');
mRename.Caption := pdeLoadNLS('popupmenuRename', '��२��������');
mCreateNew.Caption := pdeLoadNLS('popupmenuCreateNew', '������� ����');
mFolder.Caption := pdeLoadNLS('popupmenuFolder', '�����');
mText.Caption := pdeLoadNLS('popupmenuText', 'T����.txt');
mHTM2.Caption := pdeLoadNLS('popupmenuHTM2', 'W��-��࠭��.htm');
mProperies.Caption := pdeLoadNLS('popupmenuProperies', '�����⢠');

End;

//file handling routines
function TMainForm.ObjMove(source, dest: cstring): integer;
var
  rc: apiret;
  fsrc, fdest: CString;
  option: ULong;
Begin
option := 0;
if pdeLoadCfgInt('general.cfg', 'overwritefiles') = 1 then
    option := DCPY_Existing;
fsrc:=source;
fdest:=dest;
rc:=DosCopy(fsrc, fdest, option);
if rc<>0 then
  begin
  pdeMessageBox(pdeLoadNLS('dlgErrorDeleteCanceled', '�������� �⬥����.')
  , pdeLoadNLS('dlgErrorOnCopy', '�訡�� �� ����஢����'), bCopy.Glyph);
  exit;
  end;
//if not(cmdForm.Visible) then //<-If "Cancel" button was pressed
//  exit;

  cmdLabel.Caption:=pdeLoadNLS('dlgDeleting', '��������')+' '+source+' . . .';
  cmdForm.Show;
  cmdForm.BringToFront;
  cmdForm.Refresh;
  ObjDel(source);
  cmdForm.Hide;
End;

function TMainForm.ObjDel(source: string): integer;
var
  rc: boolean;
  rez: integer;
  rc2, rc3: APIRET;
  sr2: TSearchRec;
  cdir: string;
  curdir: cstring;
Begin
if (FindFirst(source+'\*.*', faAnyFile, sr2)=0) then  //����� 䠩�� �� ����� ���� ��㣨� 䠩��� :-)
  begin  //directory
  rez:=0;
  while rez=0 do
    begin
    rez:=FindNext(sr2);
    if rez<>0 then break;
    if (sr2.name<>'..')and(sr2.name<>'.') then
      begin
      //if not(newForm.Visible) then
      //  exit;
      curdir:=source[1]+source[2]+source[3];
      DosSetCurrentDir(curdir);
      ObjDel(source+'\'+sr2.name);
      end;
    end;
  FindClose(sr2);
  FileSetAttr(source, 0);
  cdir:=source[1]+source[2]+source[3];
  curdir:=cdir;
  rc3:=DosSetCurrentDir(curdir);
  rc2:=DosDeleteDir(source);
  if rc2<>0 then
    pdeMessageBox(pdeLoadNLS('dlgErrorCode', '��� �訡��:')+' '+IntToStr(rc2)+
      chr(13)+chr(10)+source,
      pdeLoadNLS('dlgErrorOnFolderDelete', '�訡�� �� 㤠����� �����'), bDelete.Glyph);

  end
else
  begin  //file
  FindClose(sr2);
  FileSetAttr(source, 0);
  DosSleep(0);
  rc:=DeleteFile(source);
  if rc=false then
    pdeMessageBox(source, pdeLoadNLS('dlgErrorOnFileDelete', '�訡�� �� 㤠����� 䠩��'), bDelete.Glyph);
  end;

End;

function TMainForm.ObjRename(source, dest: string): integer;
var
  rc: APIRET;
  s, d: cstring;
Begin
//��२���������
s:=source;
d:=dest;
rc:=DosMove(s, d); //move files and subdirectories (in same drive)
Result := 0;
if rc<>0 then
  Begin
  Result := 1;
  pdeMessageBox(''+chr(13)+chr(10)+
    pdeLoadNLS('dlgErrorFileAllreadyExists', '�������� 䠩� � ������� ������ 㦥 �������.')
    +chr(13)+chr(10)+pdeLoadNLS('dlgErrorCode', '��� �訡��:')+' '+IntToStr(rc),
    pdeLoadNLS('dlgErrorOnRename', '�訡�� ��६�饭��'), bMove.Glyph);
  End;
End;

//-----------------------------------------
function TMainForm.CalcTreeSize(tpath: String): LongInt;
var
  rez: integer;
  sr2: TSearchRec;
  size: LongInt;
Begin
//������ ࠧ��� ��ॢ� ��⠫����
Cursor := crHourGlass;
try
size:=0;
if (FindFirst(tpath+'\*.*', faAnyFile, sr2)=0) then  //����� 䠩�� �� ����� ���� ��㣨� 䠩��� :-)
  begin  //directory
  rez:=0;
  while rez=0 do
    begin
    rez:=FindNext(sr2);
    if rez<>0 then break;
    if (sr2.name<>'..')and(sr2.name<>'.') then
      size:=size+calctreesize(tpath+'\'+sr2.name);

    end;
  FindClose(sr2);
  end
else
  begin  //file
  FindClose(sr2);
  FindFirst(tpath, faAnyFile, sr2);
    size:=size+sr2.size;
  FindClose(sr2);
  end;
CalcTreeSize:=size;
  finally
  Cursor := crDefault;
  end;
End;

//-----------------------------------------
//copy-move-delete form functions
procedure TMainForm.CancelFileOp(Sender: TObject);
Begin
//饫箪 �� ������ "�⬥����"
cmdForm.Hide;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
End;

procedure TMainForm.CancelNewFolder(Sender: TObject);
Begin
//饫箪 �� ������ "�⬥����"
{newForm.Hide;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);}
End;

procedure TMainForm.CreateNewFolder(Sender: TObject);
{var
  fdir: string;
  rc: APIRET;}
Begin
{//饫箪 �� ������ "�K"
if newEdit.Text<>'' then begin
fdir:=path;
//  if length(fdir)>3 then
//    Delete(fdir, length(fdir), 1); //delete "\"
//  DosSetCurrentDir(fdir);
//  rc:=DosCreateDir(newEdit.Text, nil);
  rc:=DosCreateDir(fdir+newEdit.Text, nil);
  if rc<>0 then
  pdeMessageBox(pdeLoadNLS('dlgErrorOnFolderCreate', 'H� 㤠���� ᮧ���� �����.')
   ,pdeLoadNLS('dlgError', '�訡��'), bNew.Glyph);
    LoadList;
    end;
newForm.Hide;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);}
End;

Procedure TMainForm.CreateShortcut(Sender: TObject);
var
  lfile: TextFile;
Begin
//ᮧ���� ���箪
LinkForm.Hide;
MainForm.Activate;
if lnkEdit1.Text<>'' then
  begin
  assignfile(lfile, lnkEdit1.Text);
  rewrite(lfile);
  writeln(lfile, '[SHORTCUT]');
  writeln(lfile, '//link: type, object-name, path, parameters');
  writeln(lfile, lnkEdit2.Text);
  writeln(lfile, lnkEdit3.Text);
  writeln(lfile, lnkEdit4.Text);
  writeln(lfile, lnkEdit5.Text);
  closefile(lfile);
  end;
End;

Procedure TMainForm.CancelCreateShortcut(Sender: TObject);
Begin
//饫箪 �� ������ "�⬥����"
linkForm.Hide;
WinSetActiveWindow(HWND_DESKTOP, MainForm.Handle);
End;

//other forms
Procedure TCMDForm.cmdFormOnShow (Sender: TObject);
Begin

End;

{Procedure TNewForm.NewFormOnShow (Sender: TObject);
Begin

End;}

Procedure TLinkForm.LinkFormOnShow (Sender: TObject);
Begin

End;
//-----------------------------------------

//-----------------------------------------
//localization

//-----------------------------------------

Initialization
  RegisterClasses ([TMainForm, TListView, TImageList, TEdit,
    TMenuItem, TButton, TToolbar, TLabel, TMainMenu, TPanel, TExplorerButton
   , TImage, TPopupMenu, TBevel,
    TCustomDirectoryListBox, TCustomDriveComboBox, TProgressBar]);
End.
