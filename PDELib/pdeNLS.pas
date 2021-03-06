(*////////////////////////////////////////////////////
//    PDE -  graphical user shell for OS/2 Warp
//    Copyleft stVova, [PDE-Team], 2003
//    http://os2progg.by.ru/pde
//    NLS (multi language support) for PDE
//    and PDE *.CFG files routines.
/////////////////////////////////////////////////////*)

unit pdeNLS;

interface

Uses
  Classes, Forms, SysUtils, Dos, SysUtils;

//load key values from .cfg files of PDE
function pdeLoadCfgStr(cfgfile, key: String): String;
function pdeLoadCfgInt(cfgfile, key: String): Integer;
function pdeLoadCfgColor(cfgfile, key: String): TColor;
//load NLS string from PDE .nls files
function pdeLoadNLS(keystr, defaultValue: String): String;
//rewrite hole .cfg with new data from StringList
function pdeSaveCfgFile(cfgfile: String; cfgdata: TStringList): Integer;

implementation

//-----------------------------------------

function pdeLoadCfgStr(cfgfile, key: String): String;
var
  homepath: String;
  afile: TextFile;
  tmpkey, tmpstr: String;
begin
  //PDE home directory from config.sys
  homepath := getenv('PDE_HOME');
  if homepath = '' then
    homepath := 'c:\pde';

  Result := '';

  try
  AssignFile(afile, homepath + '\PDEConf\' + cfgfile);
  Reset(afile);
  While not(eof(afile)) do
    begin
    //load config string
    Readln(afile, tmpstr);
    if tmpstr[1] = '/' then continue;
    tmpkey := copy (tmpstr, 1, pos('=', tmpstr)-1);
    delete(tmpstr, 1, pos('=', tmpstr));
    if lowercase(tmpkey) = lowercase(key) then
      begin
      Result := tmpstr;
      CloseFile(afile);
      exit;
      end;
    end;

  except
    CloseFile(afile);
  end;

end;

//-----------------------------------------

function pdeLoadCfgInt(cfgfile, key: String): Integer;
var
  homepath: String;
  afile: TextFile;
  tmpkey, tmpstr: String;
begin
  //PDE home directory from config.sys
  homepath := getenv('PDE_HOME');
  if homepath = '' then
    homepath := 'c:\pde';

  Result := 0;

  try
  AssignFile(afile, homepath + '\PDEConf\' + cfgfile);
  Reset(afile);
  While not(eof(afile)) do
    begin
    //load config Integer value
    Readln(afile, tmpstr);
    if tmpstr[1] = '/' then continue;
    tmpkey := copy (tmpstr, 1, pos('=', tmpstr)-1);
    delete(tmpstr, 1, pos('=', tmpstr));
    if lowercase(tmpkey) = lowercase(key) then
      begin
      try
        Result := StrToInt(tmpstr);
        except
        Result := 0;
        end;
      CloseFile(afile);
      exit;
      end;
    end;

  except
    CloseFile(afile);
  end;

end;

//-----------------------------------------

function pdeLoadCfgColor(cfgfile, key: String): TColor;
var
  homepath: String;
  afile: TextFile;
  tmpkey, tmpstr: String;
begin
  //PDE home directory from config.sys
  homepath := getenv('PDE_HOME');
  if homepath = '' then
    homepath := 'c:\pde';

  Result := $000000;

  try
  AssignFile(afile, homepath + '\PDEConf\' + cfgfile);
  Reset(afile);
  While not(eof(afile)) do
    begin
    Readln(afile, tmpstr);
    if tmpstr[1] = '/' then continue;
    tmpkey := copy (tmpstr, 1, pos('=', tmpstr)-1);
    delete(tmpstr, 1, pos('=', tmpstr));
    if lowercase(tmpkey) = lowercase(key) then
      begin
      try
        Result := TColor(StrToInt(tmpstr));
        except
        Result := $000000;
        end;
      CloseFile(afile);
      exit;
      end;
    end;

  except
    CloseFile(afile);
  end;

end;

//-----------------------------------------

function pdeLoadNLS(keystr, defaultValue: String): String;
var
  homepath: String;
  nlsfile: TextFile;
  lang: String;
  tmpkey, tmpstr: String;
begin

  //PDE home directory from config.sys
  homepath := getenv('PDE_HOME');
  if homepath = '' then
    homepath := 'c:\pde';

  //current PDE language from general.cfg
  lang := pdeLoadCfgStr('general.cfg', 'language');
  if lang = '' then
    lang := 'en_en';

  Result := defaultValue;

  try
  AssignFile(nlsfile, homepath + '\Languages\'+lang + '.nls');
  Reset(nlsfile);
  While not(eof(nlsfile)) do
    begin
    Readln(nlsfile, tmpstr);
    if tmpstr[1] = '/' then continue;
    tmpkey := copy (tmpstr, 1, pos('=', tmpstr)-1);
    delete(tmpstr, 1, pos('=', tmpstr));
    if lowercase(tmpkey) = lowercase(keystr) then
      begin
      Result := tmpstr;
      CloseFile(nlsfile);
      exit;
      end;
    end;
  except
    //close language file
    CloseFile(nlsfile);
  end;

end;

//-----------------------------------------

function pdeSaveCfgFile(cfgfile: String; cfgdata: TStringList): Integer;
var
  homepath: String;
  afile: TextFile;
  //tmpstr: String;
  counter: Integer;
begin

  if (cfgData <> nil) then
    begin
    //PDE home directory from config.sys
    homepath := getenv('PDE_HOME');
    if homepath = '' then
      homepath := 'c:\pde';

    Result := 0;
    counter := 0;

    try
    AssignFile(afile, homepath + '\PDEConf\' + cfgfile);
    Rewrite(afile);
    while counter < cfgData.Count do
      begin
      Writeln(afile, cfgData.Strings[counter]);
      inc(counter);
      end;
    except
      CloseFile(afile);
      exit;
      end;
    CloseFile(afile);
    end;

end;

//-----------------------------------------

end.