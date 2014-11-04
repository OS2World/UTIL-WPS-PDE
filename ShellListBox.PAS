Unit ShellListBox;

Interface

Uses
  OS2Def, Classes, Forms, Graphics, PMWin, Dialogs, Messages, BSEDos,
  SysUtils;

{Declare new class}
Type

    TShellListBox = Class; //forward TShellListBox declaration

    TShellListAdd = class(TThread)
      Box: TShellListBox;
      protected
        Procedure Execute; override;
      public
    End;

    TShellItem = class(TControl)
      private
        Procedure WMPaint(Var Msg:TMessage); Message WM_PAINT;
      public
      Caption: String;
      IsDirectory: Boolean;
      Selected: Boolean;
      Procedure Redraw(Const rec:TRect);Override;
    End;

    TShellListBox=Class(TScrollingWinControl)
      Private
        //FSelf: TComponent;
        FItems: array[1..1000] of TShellItem;
        FItemCount: Integer;
        FItemWidth: Integer;
        FItemHeight: Integer;
        FPath: String;
        FBorderStyle:TBorderStyle;
        FDirBitmap: TBitmap;
        FFileBitmap: TBitmap;
        Procedure SetBorderStyle(NewValue:TBorderStyle);
        Procedure WMChar(Var Msg:TWMChar); Message WM_CHAR;
        Procedure SetDirBitmap(Value: TBitmap);
        Procedure SetFileBitmap(Value: TBitmap);
      Protected
        Procedure SetupComponent;Override;
        Procedure Resize;Override;
        Procedure MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongINt);Override;
      Public
        SelectedItem: TShellItem;
        Destructor Destroy;Override;
        Procedure Redraw(Const rec:TRect);Override;
        Procedure AddItem(caption: String; isdirectory: Boolean);
        Procedure Clear;
        Procedure LoadFromPath;
        Procedure SetItemWidth(Value: Integer);
        Procedure SetItemHeight(Value: Integer);
        Procedure SetPath(Value: String);
        Procedure ItemMouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X: LongInt; Y: LongInt);
        Procedure ItemDblClick (Sender: TObject);
      Published
        Property DirBitmap: TBitmap read FDirBitmap write SetDirBitmap;
        Property FileBitmap: TBitmap read FFileBitmap write SetFileBitmap;
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
  TShellListBox,'Pde','';

Implementation

//Item routines============================
Procedure TShellItem.WMPaint(Var Msg:TMessage);
Var  rec:TRect;
     relpt:TPoint;
     Control:TControl;
     DNS:TDesignerNotifyStruct;
     FHPS:HPS;
Begin
  DefaultHandler(Msg);       {Do Default Action}
  rec := ClientRect;
  Redraw(rec);
  Msg.Handled := True;
  Msg.Result := 0;
End;

Procedure TShellItem.Redraw(Const rec:TRect);
var
  rect: TRect;
  tempclr1, tempclr2: TColor;
  w, h: Integer;
Begin
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
  if TShellListBox(Parent).DirBitmap <> nil then
    Canvas.Draw(1, 1, TShellListBox(Parent).DirBitmap)
  end
else
  begin
  if TShellListBox(Parent).FileBitmap <> nil then
    Canvas.Draw(1, 1, TShellListBox(Parent).FileBitmap);
  end;

w := TShellListBox(Parent).ItemWidth;
h := TShellListBox(Parent).ItemHeight;

Canvas.TextOut(h, (h - Canvas.TextHeight(Caption)) div 2, Caption);
//Canvas.TextOut(1, 1, Caption);

if Canvas.TextWidth(Caption) > Width then
  Canvas.TextOut(Width-Canvas.TextWidth('...') , 1, '...');

Canvas.Brush.Color := tempclr1;
Canvas.Pen.Color := tempclr2;
End;
//=========================================

Procedure TShellListAdd.Execute;
var
  maskedpath: String;
  sr: TSearchRec;
  rez: integer;
Begin
//add items to TShellListBox
Box.Cursor := crHourGlass;
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
Box.Cursor := crDefault;
End;

Procedure TShellListBox.SetBorderStyle(NewValue:TBorderStyle);
Begin
     If NewValue=FBorderStyle Then exit;
     FBorderStyle:=NewValue;
     Invalidate;
End;

{$HINTS OFF}
//Listbox redraw ==========================
Procedure TShellListBox.Redraw(Const rec:TRect);
Var
  rc:TRect;
  i: Integer;
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

     Canvas.TextOut(4, Height - ItemHeight, '..');

     {if FItemCount > 0 then
       for i := 1 to FItemCount do
         FItems[i].Redraw(FItems[i].ClientRect);
     }
End;
{$HINTS ON}


Procedure TShellListBox.SetupComponent;
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
     FItemWidth := 100;
     Include(ComponentState, csAcceptsControls);
     //FSelf := Self;
End;

Destructor TShellListBox.Destroy;
Begin
  Inherited Destroy;
End;

Procedure TShellListBox.AddItem(caption: String; isdirectory: Boolean);
var
  rows, row, col: Integer;
Begin
  inc(FItemCount);
  FItems[FItemCount] := TShellItem.Create(Self);
  FItems[FItemCount].Parent := Self;
  FItems[FItemCount].Caption := Caption;
  FItems[FItemCount].Canvas.Brush.Color := clEntryField;
  FItems[FItemCount].Width := ItemWidth;
  FItems[FItemCount].Height := ItemHeight;
  FItems[FItemCount].IsDirectory := IsDirectory;
  rows := Height div ItemHeight - 1;
  col := FItemCount div rows;
  row := FItemCount - Rows*col;
  FItems[FItemCount].Top := 2 + row*ItemHeight;
  FItems[FItemCount].Left := 2 + col*ItemWidth;
  FItems[FItemCount].Visible := True;
  FItems[FItemCount].OnMouseDown := ItemMouseDown;
  FItems[FItemCount].OnDblClick := ItemDblClick;
  Invalidate;
End;

Procedure TShellListBox.SetItemHeight(Value: Integer);
Begin
if Value <> FItemHeight then
  Begin
  FItemHeight := Value;
  Invalidate;
  End;
End;

Procedure TShellListBox.SetItemWidth(Value: Integer);
Begin
if Value <> FItemWidth then
  Begin
  FItemWidth := Value;
  Invalidate;
  End;
End;

Procedure TShellListBox.Resize;
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

{if (col*ItemWidth > Width) then
  If HorzScrollBar<>Nil Then
    HorzScrollBar.Max := col*ItemWidth - Width;}
End;

Procedure TShellListBox.ItemMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X: LongInt; Y: LongInt);
var
  i: Integer;
Begin
if FItemCount > 0 then
  for i := 1 to FItemCount do
    if FItems[i].Selected then
    Begin
      FItems[i].Selected := False;
      FItems[i].Invalidate;
    End;
  TShellItem(Sender).Selected := True;
  SelectedItem := TShellItem(Sender);
TShellItem(Sender).Invalidate;
End;

Procedure TShellListBox.WMChar(Var Msg:TWMChar);
Var
  scan:TKeyCode;
  virtkey:Word;
  i: Integer;
  SelIndex, rows: Integer;
Begin

if FItemCount = 0 then
  begin
  Msg.Handled := True;
  exit;
  End;

  SelIndex := 1;
  rows := Height div ItemHeight - 1;

  for i := 1 to FItemCount do
    if FItems[i].Selected then
    Begin
      SelIndex := i;
      FItems[i].Selected := False;
      FItems[i].Invalidate;
    End;

//  scan := Msg.ScanCode;
  virtkey := Msg.VirtualKeyCode;
  scan := virtkey Or kb_VK;

  if (scan = kbCUp) then
    dec(SelIndex)
  else if (scan = kbCDown) then
    inc(SelIndex)
  else if (scan = kbCLeft) then
    SelIndex := SelIndex - rows
  else if (scan = kbCRight) then
    SelIndex := SelIndex + rows;

  if SelIndex < 1 then SelIndex := 1;
  if SelIndex > FItemCount then SelIndex := FItemCount;

  FItems[SelIndex].Selected := True;
  SelectedItem := FItems[SelIndex];
  FItems[SelIndex].Invalidate;

  Msg.Handled := True;
End;

Procedure TShellListBox.Clear;
var
  i: Integer;
Begin
//WinEnableWindowUpdate(Handle, False);
  if (FItemCount > 0) then
    for i := 1 to FItemCount do
      FItems[i].Free;
  FItemCount := 0;
//WinEnableWindowUpdate(Handle, True);
End;

Procedure TShellListBox.LoadFromPath;
var
  AddThread: TShellListAdd;
Begin
  AddThread := TShellListAdd.Create(True);
  AddThread.Box := Self;
  AddThread.FreeOnTerminate := True;
  AddThread.Resume;
End;

Procedure TShellListBox.SetPath(Value: String);
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
  Clear;
  LoadFromPath;
  Invalidate;
  End;
End;

Procedure TShellListBox.ItemDblClick (Sender: TObject);
Begin
if TShellItem(Sender).IsDirectory then
  begin
  if (Path[length(Path)])='\' then
    Path:=Path+TShellItem(Sender).Caption+'\'
    else
    Path:=Path+'\'+TShellItem(Sender).Caption+'\';
  Clear;
  LoadFromPath;
  Invalidate;
  End;
End;

Procedure TShellListBox.MouseDown(Button:TMouseButton;ShiftState:TShiftState;X,Y:LongINt);
var
  temp: String;
Begin
inherited MouseDown(Button, ShiftState, X, Y);
if (X < ItemWidth) and (Y > Height - ItemHeight) then
  Begin
  temp := path;
  if (length(temp) = 3) then exit;
  if temp[length(temp)]='\' then Delete(temp, length(temp), 1);
  while temp[length(temp)]<>'\' do
    Delete(temp, length(temp), 1);
  Path := temp;
  End;
End;

Procedure TShellListBox.SetDirBitmap(Value: TBitmap);
Begin
if Value <> nil then
  FDirBitmap := Value;
End;

Procedure TShellListBox.SetFileBitmap(Value: TBitmap);
Begin
if Value <> nil then
  FFileBitmap := Value;
End;

Initialization
  {Register classes}
  RegisterClasses([TShellListBox, TShellItem, TShellListAdd]);
End.

