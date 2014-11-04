Unit DesktopItem;

Interface

Uses
  Classes, Forms, ExtCtrls;

{Declare new class}
Type
  TDesktopItem=Class(TImage)
  Protected
    Procedure SetupComponent; Override;
  Public
    Procedure Redraw(Const rec:TRect);override;
    Destructor Destroy; Override;
    caption: String;
    ftype: String; //folder, app, document
    fname: String;
    fdir: String;
    fparams: String;
    selected: boolean;
  End;

{Define components to export}
{You may define a page of the component palette and a component bitmap file}
//Exports
//  TDesktopItem,'User','';

Implementation

Procedure TDesktopItem.Redraw(Const rec:TRect);
var
  i, j: integer;
  l, t, w, h: integer;
  trcolor: TColor;
Begin
//inherited Redraw(rec);
canvas.draw(0, 0, graphic);
l:=Left;
t:=Top;
w:=Width;
h:=Height;
trcolor:=canvas.pixels[0, 0];
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      begin
      if (canvas.pixels[j, i]=trcolor) then //bingo!!!
        if not(selected) then
          canvas.pixels[j, i]:=TImage(parent).canvas.pixels[j+l, i+t]
        else
          canvas.pixels[j, i]:=clBlue;
      end;
if not(selected) then
  TImage(Parent).Canvas.Brush.Color:=TImage(Parent).Parent.Color
else
  TImage(Parent).Canvas.Brush.Color:=clBlue;
TImage(Parent).Canvas.textout(l-(canvas.textwidth(caption)-w) div 2, screen.height-t-h-20, caption);

End;

Procedure TDesktopItem.SetupComponent;
Begin
  Inherited SetupComponent;
width:=32;
height:=32;
End;

Destructor TDesktopItem.Destroy;
Begin
  Inherited Destroy;
End;

Initialization
  {Register classes}
  RegisterClasses([TDesktopItem]);
End.

