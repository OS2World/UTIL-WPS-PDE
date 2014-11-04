//-----------------------------------------
//������ �����⨥ ��⥬��
Unit pdmUnit2;

Interface

Uses
  Classes, Forms, Graphics, StdCtrls, ExtCtrls, pdeNLS;

Type
  TShutdownForm = Class (TForm)
    Memo1: TMemo;
    Image1: TImage;
    Bevel1: TBevel;
    Procedure ShutdownFormOnCreate (Sender: TObject);
  Private
    {Insert private declarations here}
  Public
    {Insert public declarations here}
  End;

Var
  ShutdownForm: TShutdownForm;

Implementation

Procedure TShutdownForm.ShutdownFormOnCreate (Sender: TObject);
Begin
  caption := pdeLoadNLS('dlgShutdownCaption', '�����襭�� ࠡ���');
  memo1.lines.add(pdeLoadNLS('pdmGoodBye1', '����樮���� ��⥬�� OS/2 �����蠥�'));
  memo1.lines.add('');
  memo1.lines.add(pdeLoadNLS('pdmGoodBye2', '᢮� ࠡ���. ���⭮�� ��� �����.'));
End;

Initialization
  RegisterClasses ([TShutdownForm, TMemo, TImage, TBevel]);
End.
