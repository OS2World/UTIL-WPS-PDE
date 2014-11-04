(*////////////////////////////////////////////////////
//    PDE -  graphical user shell for OS/2 Warp
//    Copyleft stVova, [PDE-Team], 2003
//    http://os2progg.by.ru/pde
//    functions for start another programs
/////////////////////////////////////////////////////*)

unit pdeStart;

interface

Uses
  Classes, Forms, Dos, SysUtils, PMSHL, PMWIN;

function StartApp(fname, fdir, fparam: String; shortcut: boolean): Boolean;

implementation

//-----------------------------------------
function StartApp(fname, fdir, fparam: String; shortcut: boolean): Boolean;
var
  pDetails:PROGDETAILS;
  res: HAPP;
  fname2, fdir2, fparam2: PChar;
begin
if not(shortcut) then
  fparam:='"'+fparam+'"';  //<-защита от пробеллов в пути к файлу

new(fname2);
new(fparam2);
new(fdir2);
StrPCopy(fname2, fname);
StrPCopy(fparam2, fparam);
StrPCopy(fdir2, fdir);

with pDetails do
  begin
  Length:=sizeof(pDetails);
  progt.progc:=PROG_DEFAULT;
  progt.fbVisible:=SHE_VISIBLE;
  pszTitle:=fname2;
  pszExecutable:=fname2;
  pszParameters:=fparam2;
  pszStartupDir:=fdir2;
  pszIcon:=nil;
  pszEnvironment:='WORKPLACE\0\0';
  swpInitial.fl:=SWP_ACTIVATE;
  swpInitial.cx:=0;
  swpInitial.cy:=0;
  swpInitial.x:=0;
  swpInitial.y:=0;
  swpInitial.hwndInsertBehind:=HWND_TOP;
  swpInitial.hwnd:=Application.MainForm.Handle;
  swpInitial.ulReserved1:=0;
  swpInitial.ulReserved2:=0;
  end;

  res := WinStartApp(Application.MainForm.Handle, pDetails, nil, nil, SAF_INSTALLEDCMDLINE);

freemem(fname2, sizeof(fname2));
freemem(fparam2, sizeof(fparam2));
freemem(fdir2, sizeof(fdir2));

  Result := False;
  if (res <> 0) then Result := True;
end;
//-----------------------------------------

end.