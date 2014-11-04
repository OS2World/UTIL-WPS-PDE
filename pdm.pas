Program pdm;

Uses
  Forms, Graphics, pdmUnit1, pdmUnit2, pdmUnit3;

{$r pdm.scu}

Begin
  Application.Create;
  Application.CreateForm (TMainForm, MainForm);
  Application.Run;
  Application.Destroy;
End.




