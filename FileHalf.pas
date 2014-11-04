Program FileHalf;

Uses
  Forms, Graphics, Unit1, DialogUnit1, PropUnit;

{$r FileHalf.scu}

Begin
  Application.Create;
  Application.CreateForm (TMainForm, MainForm);
  Application.Run;
  Application.Destroy;
End.
