Program DeskHalf;

Uses
  Forms, Graphics, Unit2, DeskUni2, RunUnit;

{$r DeskHalf.scu}

Begin
  Application.Create;
  Application.CreateForm (TMainForm, MainForm);
  Application.Run;
  Application.Destroy;
End.
