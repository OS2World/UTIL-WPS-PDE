(*////////////////////////////////////////////////////
//    ПDE -  оболочка пользователя OS/2 Warp
//    Copyright stVova, [ПDE-Team], 2003
//    http://os2progg.by.ru/pde
//    TPDEListBox - cool multicolumn listbox for
//    displaying folder contents.
/////////////////////////////////////////////////////*)
Unit pdeListbox;

Interface

Uses
//  Classes, Forms;
  OS2Def, Classes, Forms, Graphics, PMWin, Dialogs, Messages, BSEDos,
  SysUtils, StdCtrls;

{Declare new class}
Type

    TPDEListBox = Class; //forward TShellListBox declaration

    TShellListAdd = class(TThread)
      Box: TPDEListBox;
      protected
        Procedure Execute; override;
      public
    End;

    TShellItem = class(TControl)
      public
      //Caption: String;
      IsDirectory: Boolean;
      Selected: Boolean;
      Procedure Redraw(Const rec:TRect);Override;
    End;

    TPDEListbox=Class(TScrollingWinControl)
      Private
        FItems: array[1..1000] of TShellItem;
        FItemCount: Integer;
        FItemWidth: Integer;
        FItemHeight: Integer;
        FPath: String;
        FMask: String;
        FBorderStyle:TBorderStyle;
        FDirBitmap: TBitmap;
        FFileBitmap: TBitmap;
        FSelectedLabel: TLabel;
        FSelectedName: TEdit;
        FSelectedPath: TEdit;
        LastChar: TKeyCode;
        Procedure SetBorderStyle(NewValue:TBorderStyle);
        Procedure WMChar(Var Msg:TWMChar); Message WM_CHAR;
        Procedure SetDirBitmap(Value: TBitmap);
        Procedure SetFileBitmap(Value: TBitmap);
        Procedure SetSelectedLabel(Value: TLabel);
        Procedure SetSelectedName(Value: TEdit);
        Procedure SetSelectedPath(Value: TEdit);
      Protected
        Procedure SetupComponent; Override;
        Procedure Resize;Override;
        //Procedure MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongINt);Override;
        Procedure MouseDblClick(Button:TMouseButton;ShiftState:TShiftState;X,Y:LonGInT);override;
      Public
        Destructor Destroy; Override;
        SelectedItem: TShellItem;
        FileAttributes: Integer; //faAnyFile, faDirectory, etc
        Procedure Redraw(Const rec:TRect);Override;
        Procedure AddItem(caption: String; isdirectory: Boolean);
        Procedure Clear;
        Procedure LoadFromPath;
        Procedure SetItemWidth(Value: Integer);
        Procedure SetItemHeight(Value: Integer);
        Procedure SetPath(Value: String);
        Procedure SetMask(Value: String);
        //Procedure ItemMouseDown(Sender: TObject; Button: TMouseButton;
        //  Shift: TShiftState; X: LongInt; Y: LongInt);
        Procedure ItemClick (Sender: TObject);
        //Procedure ItemDblClick (Sender: TObject);
      Published
        Property Mask: String read FMask write SetMask;
        Property DirBitmap: TBitmap read FDirBitmap write SetDirBitmap;
        Property FileBitmap: TBitmap read FFileBitmap write SetFileBitmap;
        Property SelectedLabel: TLabel read FSelectedLabel write SetSelectedLabel;
        Property SelectedName: TEdit read FSelectedName write SetSelectedName;
        Property SelectedPath: TEdit read FSelectedPath write SetSelectedPath;
        Property ItemWidth: Integer read FitemWidth write SetItemWidth;
        Property ItemHeight: Integer read FitemHeight write SetItemHeight;
        Property ItemCount: Integer read FItemCount;
        Property Path: String read FPath write SetPath;
        Property Align;
        Property Cursor;
        Property Tag;
        Property AutoScroll;
        Property BorderStyle:TBorderStyle read FBorderStyle write SetBorderStyle;
        Property DragCursor;
        Property DragMode;
        Property Enabled;
        Property Color;
        Property Font;
        Property HorzScrollBar; stored False;
        Property VertScrollBar; stored False;
        Property ParentColor;
        Property ParentFont;
        Property ParentShowHint;
        Property PopupMenu;
        Property ShowHint;
        Property TabOrder;
        Property TabStop;
        Property Visible;
        Property ZOrder;
        Property OnClick;
        Property OnCanDrag;
        Property OnKeyPress;
        Property OnDblClick;
        Property OnDragDrop;
        Property OnDragOver;
        Property OnEndDrag;
        Property OnEnter;
        Property OnExit;
        Property OnMouseDown;
        Property OnMouseMove;
        Property OnMouseUp;
        Property OnResize;
        Property OnPaint;
        Property OnScan;
        Property OnShow;
  End;

{Define components to export}
{You may define a page of the component palette and a component bitmap file}
Exports
  TPDEListbox,'User','';

Implementation

//Item routines============================
Procedure TShellItem.Redraw(Const rec:TRect);
var
  rect: TRect;
  tempclr1, tempclr2: TColor;
  w, h: Integer;
Begin
try
Canvas.Brush.Color := clWhite;
  inherited Redraw(rec);
tempclr1 := Canvas.Brush.Color;
tempclr2 := Canvas.Pen.Color;
if Selected then
  Begin
  Canvas.Brush.Color := clBlue;
  Canvas.Pen.Color := clWhite;
  End;

if IsDirectory then
  begin
  if TPDEListBox(Parent).DirBitmap <> nil then
    Canvas.Draw(1, 1, TPDEListBox(Parent).DirBitmap)
  end
else
  begin
  if TPDEListBox(Parent).FileBitmap <> nil then
    Canvas.Draw(1, 1, TPDEListBox(Parent).FileBitmap);
  end;

w := TPDEListBox(Parent).ItemWidth;
h := TPDEListBox(Parent).ItemHeight;

Canvas.TextOut(h, (h - Canvas.TextHeight(Caption)) div 2, Caption);
//Canvas.TextOut(1, 1, Caption);

if Canvas.TextWidth(Caption) > Width then
  Canvas.TextOut(Width-Canvas.TextWidth('...') , 1, '...');

Canvas.Brush.Color := tempclr1;
Canvas.Pen.Color := tempclr2;
  except

  end;
End;
//=========================================

Procedure TShellListAdd.Execute;
var
  maskedpath: String;
  sr: TSearchRec;
  rez: integer;
Begin
//add items to TPDEListBox
{Box.Cursor := crHourGlass;
Box.AutoScroll := False;
  if Box.path[length(Box.path)] = '\' then
    maskedpath := Box.path+'*.*'
    else
    maskedpath := Box.path+'\*.*';

rez:=FindFirst(maskedpath , faAnyFile, sr);
while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.attr and faDirectory)<>0 then
      if sr.name<>'..' then
        Box.AddItem(sr.name, true);
    end;
FindClose(sr);

rez:=FindFirst(maskedpath , faAnyFile, sr);
if sr.name<>'.' then
    begin
    if (sr.attr and faDirectory)<>0 then
      Box.AddItem(sr.name, true)
      else
      Box.AddItem(sr.name, false);
    end;
while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.attr and faDirectory)=0 then
      if sr.name<>'..' then
        Box.AddItem(sr.name, false);
    end;
FindClose(sr);
Box.AutoScroll:=True;
Box.Cursor := crDefault;}
End;

Procedure TPDEListBox.SetBorderStyle(NewValue:TBorderStyle);
Begin
     If NewValue=FBorderStyle Then exit;
     FBorderStyle:=NewValue;
     Invalidate;
End;

{$HINTS OFF}
//Listbox redraw ==========================
Procedure TPDEListBox.Redraw(Const rec:TRect);
Var
  rc:TRect;
  i: Integer;
  tempclr1, tempclr2: TColor;
Begin
     rc:=ClientRect;
     If HorzScrollBar<>Nil Then
       If HorzScrollBar.Visible Then inc(rc.Bottom,HorzScrollBar.Height);
     If VertScrollBar<>Nil Then
       If VertScrollBar.Visible Then dec(rc.Right,VertScrollBar.Width);
     If BorderStyle=bsSingle Then
     Begin
          Canvas.ShadowedBorder(rc,clDkGray,clWhite);
          InflateRect(rc,-1,-1);
     End;

     Inherited Redraw(rc);

     tempclr1 := Canvas.Brush.Color;
     tempclr2 := Canvas.Pen.Color;
     if SelectedItem = nil then
       begin
       Canvas.Brush.Color := clBlue;
       Canvas.Pen.Color := clWhite;
       end;

     Canvas.TextOut(itemheight, Height - ItemHeight, '..  ');

     Canvas.Brush.Color := tempclr1;
     Canvas.Pen.Color := tempclr2;

End;
{$HINTS ON}


Procedure TPDEListBox.SetupComponent;
Begin
     Inherited SetupComponent;
     Name:='ShellListBox';
     AutoScroll:=True;
     Color:=clEntryField;
     FBorderStyle:=bsSingle;
     Width:=300;
     Height:=300;
     ScrollBars:=ssHorizontal;
     FItemCount := 0;
     FItemHeight := 20;
     FItemWidth := 160;
     FileAttributes := faAnyFile; //faDirectory
     FMask := '*.*';
     LastChar := kbNull;
     FSelectedLabel:=nil;
     FSelectedName:=nil;
     FSelectedPath:=nil;
     Include(ComponentState, csAcceptsControls);
     //FSelf := Self;
End;

//add items================================
Procedure TPDEListBox.AddItem(caption: String; isdirectory: Boolean);
var
  rows, row, col: Integer;
Begin
try

  inc(FItemCount);
  FItems[FItemCount] := TShellItem.Create(Self);
  FItems[FItemCount].Parent := Self;
  FItems[FItemCount].Caption := Caption;
  //FItems[FItemCount].Canvas.Brush.Color := clEntryField;
  FItems[FItemCount].Width := ItemWidth;
  FItems[FItemCount].Height := ItemHeight;
  FItems[FItemCount].IsDirectory := IsDirectory;
  rows := Height div ItemHeight - 1;
  col := FItemCount div rows;
  row := FItemCount - Rows*col;
  FItems[FItemCount].Top := 2 + row*ItemHeight;
  FItems[FItemCount].Left := 2 + col*ItemWidth;
  FItems[FItemCount].Visible := True;
  //FItems[FItemCount].OnMouseDown := ItemMouseDown;
  FItems[FItemCount].OnClick := ItemClick;
  //FItems[FItemCount].OnDblClick := ItemDblClick;
  Invalidate;
  except

  end;
End;
//=========================================

Procedure TPDEListBox.SetItemHeight(Value: Integer);
Begin
if Value <> FItemHeight then
  Begin
  FItemHeight := Value;
  Invalidate;
  End;
End;

Procedure TPDEListBox.SetItemWidth(Value: Integer);
Begin
if Value <> FItemWidth then
  Begin
  FItemWidth := Value;
  Invalidate;
  End;
End;

Procedure TPDEListBox.Resize;
var
  i: Integer;
  rows, row, col: Integer;
Begin
  Inherited Resize;
if (Height < ItemHeight*4) then Height := ItemHeight*4;

rows := Height div ItemHeight - 1;

if FItemCount > 0 then
  for i := 1 to FItemCount do
    Begin
    col := i div rows;
    row := i - Rows*col;
    FItems[i].Top := 2 + row*ItemHeight;
    FItems[i].Left := 2 + col*ItemWidth;
    FItems[i].Invalidate;
    End;

End;

//=========================================
Procedure TPDEListBox.WMChar(Var Msg:TWMChar);
Var
  scan:TKeyCode;
  virtkey:Word;
  i: Integer;
  SelIndex, rows: Integer;
  temp : string;
Begin

  //  scan := Msg.ScanCode;
  virtkey := Msg.VirtualKeyCode;
  scan := virtkey Or kb_VK;

if FItemCount = 0 then
  begin
    Msg.Handled := True;
    exit;
  End;

  SelIndex := 0;
  rows := Height div ItemHeight - 1;

  if (scan = LastChar) and {(}(LastChar = kbCR){ or (LastChar = kbBkSp))} then
    begin //по второну разу
    LastChar := kbNull;
    Msg.Handled := True;
    exit;
    end;

  LastChar := scan;

  if SelectedItem <> nil then
    SelectedItem.Focus
    else
    Focus;

  {if (scan = kbBkSp) then
    Begin
    temp := path;

        if (length(temp) = 3) then begin Msg.Handled := True; exit; end;

        if temp[length(temp)]='\' then Delete(temp, length(temp), 1);

        while temp[length(temp)]<>'\' do
          Delete(temp, length(temp), 1);

        Path := temp;

    Msg.Handled := True;
    exit;
    End;}

  if (scan = kbCR) then
    Begin
    //click on item
    if SelectedItem = nil then
      begin //.. to up dir
        temp := path;

        if (length(temp) = 3) then begin Msg.Handled := True; exit; end;

        if temp[length(temp)]='\' then Delete(temp, length(temp), 1);

        while temp[length(temp)]<>'\' do
          Delete(temp, length(temp), 1);

        Path := temp;
      end
      else
      begin //to selected
        if SelectedItem.IsDirectory then
        begin
        if (Path[length(Path)])='\' then
          Path:=Path+SelectedItem.Caption+'\'
          else
          Path:=Path+'\'+SelectedItem.Caption+'\';
        end;
      end;
    Msg.Handled := True;
    exit;
    End;

{  if (scan = kbTab) then
    FocusTabControl(True);}

  for i := 1 to FItemCount do
    if FItems[i].Selected then
    Begin
      SelIndex := i;
      FItems[i].Selected := False;
      //FItems[i].Invalidate;
    End;

  if (scan = kbCUp) then
    dec(SelIndex)
  else if (scan = kbCDown) then
    inc(SelIndex)
  else if (scan = kbCLeft) then
    SelIndex := SelIndex - rows
  else if (scan = kbCRight) then
    SelIndex := SelIndex + rows
  else if (scan = kbHome) then
    SelIndex := 0
  else if (scan = kbEnd) then
    SelIndex := fitemcount
  ;

  //if SelIndex < 1 then SelIndex := 1;
  if SelIndex > FItemCount then SelIndex := FItemCount;

  if SelIndex > 0 then
    begin
    FItems[SelIndex].Selected := True;
    SelectedItem := FItems[SelIndex];
    ScrollInView(FItems[SelIndex]);
    if (FSelectedlabel <> nil) then
      FSelectedlabel.Caption := concatfilename(path, FItems[SelIndex].caption);
    if FSelectedName <> nil then
      FSelectedName.Text := FItems[SelIndex].caption;
    {FItems[SelIndex].Invalidate;}
    end
    else
      SelectedItem := nil;

  invalidate;

  Msg.Handled := True;
End;
//====WM_CHAR==============================

Procedure TPDEListBox.Clear;
var
  i: Integer;
Begin
try
Cursor := crHourGlass;
//WinEnableWindowUpdate(Handle, False);
  if (FItemCount > 0) then
    for i := FItemCount  downto 1 do
      begin
      FItems[i].Free;
      end;
  FItemCount := 0;
//WinEnableWindowUpdate(Handle, True);
Cursor := crDefault;
LoadFromPath;

  except

  end;
End;

//=========================================
Procedure TPDEListBox.LoadFromPath;
var
  AddThread: TShellListAdd;
  maskedpath: String;
  sr: TSearchRec;
  rez: integer;
Begin
//  AddThread := TShellListAdd.Create(True);
//  AddThread.Box := Self;
//  AddThread.FreeOnTerminate := True;
//  AddThread.Resume;

//add items to TPDEListBox
{if not  TPDEListBox(parent).visible then
  exit;}

Cursor := crHourGlass;
AutoScroll := False;
  if path[length(path)] = '\' then
    maskedpath := path+'*.*'
    else
    maskedpath := path+'*.*';

rez:=FindFirst(maskedpath , FileAttributes, sr);
while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.attr and faDirectory)<>0 then
      if sr.name<>'..' then
        AddItem(sr.name, true);
    end;
FindClose(sr);

rez:=FindFirst(maskedpath , FileAttributes, sr);
if sr.name<>'.' then
    begin
    if (sr.attr and faDirectory)<>0 then
      AddItem(sr.name, true)
      else
        begin
        if (Mask = '*.*') then
          AddItem(sr.name, false)
          //'*.txt;*.htm'
          else if (pos(lowercase(extractfileext(sr.name)), Mask) <> 0) then
          AddItem(sr.name, false);
        end;
    end;
while rez=0 do
    begin
    rez:=FindNext(sr);
    if rez<>0 then break;
    if (sr.attr and faDirectory)=0 then
      if sr.name<>'..' then
        begin
        //check if file in Mask (ie 'file.txt' = '*.txt')
        if (Mask = '*.*') then
          AddItem(sr.name, false)
          //'*.txt;*.htm'
          else if (pos(lowercase(extractfileext(sr.name)), Mask) <> 0) then
          AddItem(sr.name, false);
        end;
    end;
FindClose(sr);
AutoScroll:=True;
SelectedItem := nil;
Cursor := crDefault;
End;

Procedure TPDEListBox.SetPath(Value: String);
var
  sr: TsearchRec;
  temp: String;
Begin
temp:=value;
if temp[length(temp)]='\' then
  temp:=temp+'*.*'
  else
  temp:=temp+'\*.*';
if FindFirst(temp , faAnyFile, sr)<>0 then
  begin
  FindClose(sr);
  exit;
  end;

if Value <> FPath then
  Begin
  FPath := Value;
  if FSelectedPath <> nil then FSelectedPath.Text := fpath;
  SelectedItem := nil;
  Clear;
  //LoadFromPath;
  //Invalidate;
  End;
End;

{Procedure TPDEListBox.ItemDblClick (Sender: TObject);
Begin

try
if TShellItem(Sender).IsDirectory then
  begin
  if (FPath[length(FPath)] = '\') then
    FPath:=FPath+TShellItem(Sender).Caption+'\'
    else
    FPath:=FPath+'\'+TShellItem(Sender).Caption+'\';
  Clear;
  //LoadFromPath;
  //Invalidate;
  End;
  except

  end;
End;}

Procedure TPDEListBox.ItemClick (Sender: TObject);
//Procedure TPDEListBox.ItemMouseDown(Sender: TObject;
//  Button: TMouseButton; Shift: TShiftState; X: LongInt; Y: LongInt);
var
  i: Integer;
Begin
try

if FItemCount > 0 then
  for i := 1 to FItemCount do
    if FItems[i].Selected then
    Begin
      FItems[i].Selected := False;
      FItems[i].Invalidate;
    End;
  TShellItem(Sender).Selected := True;
  SelectedItem := TShellItem(Sender);

if (FSelectedlabel <> nil) then FSelectedlabel.Caption := concatfilename(path, TShellItem(Sender).caption);
if FSelectedName <> nil then
      FSelectedName.Text := TShellItem(Sender).caption;

if not TShellItem(Sender).Focused then
  begin
    TShellItem(Sender).Focus;
  end;

TShellItem(Sender).Invalidate;
  except

  end;
End;

Procedure TPDEListBox.MouseDblClick(Button:TMouseButton;ShiftState:TShiftState;X,Y:LonGInT);
//Procedure TPDEListBox.MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongINt);
var
  temp: String;
Begin
try

//inherited MouseDown(Button, ShiftState, X, Y);
inherited MouseDblClick(Button, ShiftState, X, Y);

if (X < ItemWidth) and (Y > Height - ItemHeight) then
  Begin
  temp := path;
  if (length(temp) <= 3) then exit;
  if temp[length(temp)]='\' then Delete(temp, length(temp), 1);
  while temp[length(temp)]<>'\' do
    Delete(temp, length(temp), 1);
  Path := temp;
  End
  else
  begin
  if selecteditem <> nil then
    if selecteditem.IsDirectory then
    begin
    if (FPath[length(FPath)] = '\') then
      FPath:=FPath+selecteditem.Caption+'\'
      else
      FPath:=FPath+'\'+selecteditem.Caption+'\';
    if FSelectedPath <> nil then FSelectedPath.Text := fpath;
    Clear;
    End;
  end;

  except

  end;
End;

Procedure TPDEListBox.SetDirBitmap(Value: TBitmap);
Begin
if Value <> nil then
  FDirBitmap := Value;
End;

Procedure TPDEListBox.SetFileBitmap(Value: TBitmap);
Begin
if Value <> nil then
  FFileBitmap := Value;
End;

Procedure TPDEListBox.SetSelectedLabel(Value: TLabel);
Begin
if Value <> nil then
  FSelectedlabel := Value;
End;

Procedure TPDEListbox.SetSelectedName(Value: TEdit);
Begin
if Value <> nil then
  FSelectedName := Value;
End;

Procedure TPDEListbox.SetSelectedPath(Value: TEdit);
Begin
if Value <> nil then
  FSelectedPath := Value;
End;

Destructor TPDEListbox.Destroy;
Begin
  Inherited Destroy;
End;

Procedure TPDEListbox.SetMask(Value: String);
Begin
if FMask <> Value then
  begin
  FMask := Value;
  Clear;
  //LoadFromPath;
  //Invalidate;
  end;
End;

Initialization
  {Register classes}
  RegisterClasses([TPDEListbox]);
End.

