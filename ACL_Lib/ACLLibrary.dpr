program ACLLibrary;

uses
  Forms,
  ACLLibraryTestFormUnit in 'ACLLibraryTestFormUnit.pas' {ACLLibraryTestForm},
  RunProgramUnit in 'RunProgramUnit.pas',
  ACLFileUtility in 'ACLFileUtility.pas',
  ACLFindFunctions in 'ACLFindFunctions.pas',
  ACLProfile in 'ACLProfile.pas',
  ACLStringUtility in 'ACLStringUtility.pas',
  ACLUtility in 'ACLUtility.pas',
  PCharList in 'PCharList.pas',
  ACLPCharUtility in 'ACLPCharUtility.pas',
  ACLConstants in 'ACLConstants.pas',
  ACLString in 'ACLString.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TACLLibraryTestForm, ACLLibraryTestForm);
  Application.Run;
end.
