unit Data_ini;
interface
uses classes;

type prog = record
  caption:string;
  exec:string;
  autocontrol:boolean;
  autorun :boolean;
  timer :boolean;
  time:string;
 end;

var
//настройки..................................
 sys_param :record
  rightscontrol,
  autoRun,
  timerRun
  :boolean;
//  countProg:integer;
 end;
//программы..................................
 progs:array [0..10] of prog;

procedure ini_save(filename:string);
procedure ini_load(filename:string);

implementation

uses iniFiles, SysUtils;

var
 ini:TiniFile;

procedure ini_save(filename:string);
var
 i:integer;
begin
// filepath :=ExtractFileDir(ParamStr(0))+filename;
 ini:=TiniFile.Create(filename);
 Ini.WriteBool(   'sys_param','rightscontrol',sys_param.rightscontrol);
 Ini.WriteBool(   'sys_param','autorun',sys_param.autorun);
 Ini.WriteBool(   'sys_param','timerrun',sys_param.timerRun);
 for i:=0 to 10 do
 begin
  if progs[i].caption='' then break;
  Ini.WriteString('prog_'+IntToStr(i),'caption',progs[i].caption);
  Ini.WriteString('prog_'+IntToStr(i),'exec',progs[i].exec);
  Ini.WriteBool(  'prog_'+IntToStr(i),'autocontrol',progs[i].autocontrol);
  Ini.WriteBool(  'prog_'+IntToStr(i),'autorun',progs[i].autorun);
  Ini.WriteBool(  'prog_'+IntToStr(i),'timer',progs[i].timer);
  Ini.WriteString(  'prog_'+IntToStr(i),'time',progs[i].time);
 end;
 ini.Free;
end;

procedure ini_load(filename:string);
var
 i:integer;
begin
 ini:=TiniFile.Create(filename);
 sys_param.rightscontrol:=ini.ReadBool('sys_param','rightscontrol',false);
 sys_param.autorun:=      ini.ReadBool('sys_param','autorun',false);
 sys_param.timerRun:=     ini.ReadBool('sys_param','timerrun',true);
 for i:=0 to 10 do
 begin
  progs[i].caption:=ini.ReadString(   'prog_'+IntToStr(i),'caption','');
  if progs[i].caption='' then break;
  progs[i].exec :=Ini.ReadString(      'prog_'+IntToStr(i),'exec','');
  progs[i].autocontrol :=Ini.ReadBool( 'prog_'+IntToStr(i),'autocontrol',false);
  progs[i].autorun :=Ini.ReadBool(     'prog_'+IntToStr(i),'autorun',false);
  progs[i].timer :=Ini.ReadBool(       'prog_'+IntToStr(i),'timer',false);
  progs[i].time :=Ini.ReadString(      'prog_'+IntToStr(i),'time','08:00');
 end;
 ini.Free;
end;



end.
