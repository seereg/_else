unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ActnMan, ActnCtrls, ActnMenus, XPStyleActnCtrls,
  ActnList, ExtCtrls, ImgList, Buttons, Menus, StdCtrls, RXSwitch
  ,UnitProcSys,ShellAPI;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    ActionStend: TAction;
    ActionAutoStand: TAction;
    ActionAddProg: TAction;
    ActionDelProg: TAction;
    ActionSave: TAction;
    ActionLoadAs: TAction;
    ActionSaveAs: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ScrollBoxProg: TScrollBox;
    ActionAdminControl: TAction;
    ActionHotKeyOn: TAction;
    ActionHotKeyOut: TAction;
    ActionDesktopOn: TAction;
    ActionDesktopOut: TAction;
    ActionTaskmgrOn: TAction;
    ActionTaskmgrOut: TAction;
    ActionDelClose: TAction;
    ActionClose: TAction;
    ActionLoad: TAction;
    ActionAutoRun: TAction;
    ActionAdmTest: TAction;
    TimerRun: TTimer;
    ActionTimerRun: TAction;
    procedure silent;
    procedure ActionStendExecute(Sender: TObject);
    procedure ActionAutoStandExecute(Sender: TObject);
    procedure ActionAddProgExecute(Sender: TObject);
    procedure ActionAdminControlExecute(Sender: TObject);
    procedure ActionHotKeyOnExecute(Sender: TObject);
    procedure ActionHotKeyOutExecute(Sender: TObject);
    procedure ActionDesktopOnExecute(Sender: TObject);
    procedure ActionDesktopOutExecute(Sender: TObject);
    procedure ActionTaskmgrOnExecute(Sender: TObject);
    procedure ActionTaskmgrOutExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionDelCloseExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionSaveAsExecute(Sender: TObject);
    procedure ActionLoadAsExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure ActionLoadExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActionAutoRunExecute(Sender: TObject);
    procedure LoadPar(filename:string);
    procedure SavePar(filename:string);
    procedure ActionAdmTestExecute(Sender: TObject);
    Procedure MyExcept(Sender:TObject; E:Exception);
    procedure TimerRunTimer(Sender: TObject);
    procedure ActionTimerRunExecute(Sender: TObject);
    procedure log(massage:string);
  private
    { Private declarations }
    id1,id2: Integer;
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
    procedure AddFrame(filepath: string; AOwner: TComponent);
    function ActionAdminExec:boolean;
  public
    { Public declarations }
    wshow:boolean;
  end;

//function IsUserAnAdmin(): BOOL; external shell32;   //проверка прав

var
  Form1: TForm1;

implementation

uses UnitFrame1, Data_ini;

{$R *.dfm}
var
 frameProg: array [0..10] of TFrameProg;
 nF:integer;

Procedure TForm1.MyExcept(Sender:TObject; E:Exception);
var
  filelog:string;
  myFile:TextFile;
  st:string;
begin
 filelog :=ExtractFileDir(ParamStr(0))+ '\log.txt';
 AssignFile(myFile, filelog);
 if FileExists(filelog)
  then  Append(myFile)
  else ReWrite(myFile);
 DateTimeToString(st,'YYYY-MM-DD  hh:mm:ss',now);
 WriteLn(myFile, st+' - '+E.Message);
 CloseFile(myFile);
end;

procedure TForm1.log(massage:string);
var  E:Exception;
begin
 E:= Exception.Create(massage);
 MyExcept(self,E);
 E.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Application.OnException := MyExcept;
 nF:=0;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
 wshow:=true;//контроль видимости окна программы
 if FileExists(ExtractFilePath(ParamStr(0))+'default.cfg') then ActionLoadExecute(Sender);// loadConfigIni;
 if  ActionAutoStand.Checked then ActionStendExecute(Sender);
 ActionAutoRunExecute(Sender)// startConfig;
end;

procedure TForm1.ActionCloseExecute(Sender: TObject);
begin
 if ActionStend.Checked then ActionStendExecute(Sender);
 Close;
end;

procedure TForm1.silent;
begin
 if wshow then
  begin
   Application.ShowMainForm := False;
   ShowWindow(Handle,SW_HIDE); // окно
   ShowWindow(Application.Handle,SW_HIDE); //  TaskBar
  end
 else
  begin
   if not(ActionAdminExec) then exit;
   Application.ShowMainForm := True;
   ShowWindow(Handle,SW_SHOWNORMAL); // окно
   ShowWindow(Application.Handle,SW_SHOWNORMAL); //  TaskBar
  end;
  wshow:=not(wshow);
end;

procedure TForm1.ActionStendExecute(Sender: TObject);
begin
 notcloseWin(PAnsiChar('StanD'));
 ActionStend.Checked:=not(ActionStend.Checked);
 if   ActionStend.Checked
 then begin
  silent;
  ActionDesktopOnExecute(Sender);
  ActionHotKeyOnExecute(sender);
  ActionTaskmgrOnExecute(sender);
 end
 else begin
  ActionDesktopOutExecute(Sender);
  ActionHotKeyOutExecute(sender);
  ActionTaskmgrOutExecute(sender);
 end
end;

procedure TForm1.ActionAutoStandExecute(Sender: TObject);
begin
 ActionAutoStand.Checked:=not(ActionAutoStand.Checked);
 if   ActionAutoStand.Checked
 then begin
//
 end
 else begin
//
 end
end;

procedure TForm1.ActionAddProgExecute(Sender: TObject);
begin
 if OpenDialog1.Execute then
 begin
  AddFrame(OpenDialog1.FileName,ScrollBoxProg);
 end;
end;

procedure TForm1.AddFrame(filepath: string; AOwner: TComponent);
begin
  frameProg[nF]:=TFrameProg.Create(filepath,AOwner);
//  frameProg[nF]:=TFrameProg.Create(AOwner);
  frameProg[nF].Name:='frameProg'+inttostr(nF);
  frameProg[nF].Parent:=AOwner as TWinControl;
  frameProg[nF].Align:=alTop;
  nF:=nF+1;
end;

procedure TForm1.WMHotKey(var Msg: TWMHotKey);
begin
// if Msg.HotKey = id1 then  //    ShowMessage('Alt + F4 pressed !');
 if (Msg.HotKey = id2) {or (Msg.HotKey = id1)} then  //    ShowMessage('Alt + F1 pressed !');
 begin
  silent;
 end;
end;

procedure TForm1.ActionAdminControlExecute(Sender: TObject);
begin
 ActionAdminControl.Checked:=not(ActionAdminControl.Checked);
end;

function TForm1.ActionAdminExec: boolean;
var i:integer;
begin
 if ActionAdminControl.Checked then
 begin
  i:=WinRunAs('Authentication');
//  i:=WinRunAs('Stand adm');
  if i=0 then result:=true
         else result:=false;
//  result:= IsUserAnAdmin; //проверка прав
 end
 else  result:=true;   
end;

procedure TForm1.ActionHotKeyOnExecute(Sender: TObject);
begin
// id1 := GlobalAddAtom('Hotkey1');                  //hotkey
// RegisterHotKey(Handle, id1, MOD_ALT, VK_F4);      //hotkey
 id2 := GlobalAddAtom('Hotkey2');                  //hotkey
 RegisterHotKey(Handle, id2, MOD_ALT, VK_F1);      //hotkey
end;

procedure TForm1.ActionHotKeyOutExecute(Sender: TObject);
begin
 UnRegisterHotKey(Handle, id1);                    //hotkey
 GlobalDeleteAtom(id1);                            //hotkey
end;

procedure TForm1.ActionDesktopOnExecute(Sender: TObject);
begin
 closeWin(PAnsiChar('Program Manager'));           //убрать РС
end;

procedure TForm1.ActionDesktopOutExecute(Sender: TObject);
begin
 ShellExecute(0,'open','explorer',nil,nil,SW_SHOWNORMAL);  //показать РС
end;

procedure TForm1.ActionTaskmgrOnExecute(Sender: TObject);
var
  TDWH:THandle;
begin
   TDWH:=FindWindow(nil,'Диспетчер задач Windows');                    //taskmgr
  if TDWH=0 then ShellExecute(0,'open','taskmgr.exe',nil,nil,SW_HIDE)  //taskmgr
            else ShowWindow(TDWH,SW_HIDE);                             //taskmgr
end;

procedure TForm1.ActionTaskmgrOutExecute(Sender: TObject);
var
  TDWH:THandle;
begin
 TDWH:=FindWindow(nil, 'Диспетчер задач Windows'); //taskmgr
 ShowWindow(TDWH,SW_SHOWNORMAL);                   //taskmgr
 PostMessage(TDWH, WM_QUIT, 0, 0);                 //taskmgr
end;
//////////////////////////////////////////////
procedure TForm1.ActionDelCloseExecute(Sender: TObject);
begin
//выбор окна
 notcloseWin(PAnsiChar('StanD'));
end;
///////////////////////////////////////////
procedure TForm1.LoadPar(filename: string);
var
 i:integer;
begin
 ini_load(filename);
 ActionAdminControl.Checked:=sys_param.rightscontrol;
 ActionAutoStand.Checked:=sys_param.autorun;
 ActionTimerRun.Checked:=sys_param.timerRun;
 for i:=0 to 10 do
 try frameProg[i].Free; except end;//отчистить список приложений
 for i:=0 to 10 do begin
  if progs[i].exec='' then break;
  nF:=i;
  AddFrame(progs[i].exec,ScrollBoxProg);
  frameProg[i].EditPath.Text:=progs[i].exec;
  frameProg[i].GroupBoxProg.Caption:=progs[i].caption;
  frameProg[i].RxRestart.StateOn:=progs[i].autocontrol;
  frameProg[i].RxAutorun.StateOn:=progs[i].autorun;
  frameProg[i].RxTimer.StateOn:=progs[i].timer;
  frameProg[i].DateTimePickerRun.Time:=StrToDateTime(progs[i].time);
 end;
end;
//////////////////////////////////////////////////////
procedure TForm1.SavePar(filename: string);
var
 i:integer;
 st:string;
begin
 sys_param.rightscontrol:=ActionAdminControl.Checked;
 sys_param.autorun      :=ActionAutoStand.Checked;
 sys_param.timerRun     :=ActionTimerRun.Checked;
 for i:=0 to nF-1 do begin
  try frameProg[i]:=frameProg[i]
   except Continue end;
  progs[i].caption:=frameProg[i].GroupBoxProg.Caption;
  progs[i].exec:=frameProg[i].EditPath.Text;
  progs[i].autocontrol:=frameProg[i].RxRestart.StateOn;
  progs[i].autorun:=frameProg[i].RxAutorun.StateOn;
  progs[i].timer:=frameProg[i].RxTimer.StateOn;
  DateTimeToString(progs[i].time,'HH:mm',frameProg[i].DateTimePickerRun.Time);
 end;
 ini_save(filename);
end;

procedure TForm1.ActionSaveAsExecute(Sender: TObject);
begin
 if SaveDialog1.Execute then SavePar(SaveDialog1.FileName);
end;

procedure TForm1.ActionLoadAsExecute(Sender: TObject);
begin
 if OpenDialog1.Execute then LoadPar(OpenDialog1.FileName);
end;

procedure TForm1.ActionSaveExecute(Sender: TObject);
begin
 SavePar(ExtractFilePath(ParamStr(0))+'default.cfg');
end;

procedure TForm1.ActionLoadExecute(Sender: TObject);
begin
 LoadPar(ExtractFilePath(ParamStr(0))+'default.cfg');
end;

procedure TForm1.ActionAutoRunExecute(Sender: TObject);
var
 i:integer;
begin
 for i:=0 to nF-1 do begin
  if frameProg[i].RxAutorun.StateOn then
   begin
    frameProg[i].Image1DblClick(sender);
    log('running autorun '+frameProg[i].GroupBoxProg.Caption);
   end;
 end;
end;
procedure TForm1.ActionAdmTestExecute(Sender: TObject);
begin
//
end;

procedure TForm1.TimerRunTimer(Sender: TObject);
var
 nTime,rTime:string;
 i:integer;
begin
 DateTimeToString(nTime,'hh:mm',now);
 for  i:=0 to nF-1 do
 begin
  if frameProg[i].RxTimer.StateOn then
  begin
   DateTimeToString(rTime,'hh:mm',frameProg[i].DateTimePickerRun.DateTime);
   if rTime=nTime then
    begin
     TMyThread.Create(frameProg[i],frameProg[i].EditPath.Text);
     log('running at '+rTime+' '+frameProg[i].GroupBoxProg.Caption);
    end;
  end;
 end;
end;

procedure TForm1.ActionTimerRunExecute(Sender: TObject);
begin
 if TimerRun.Enabled then
 begin
  TimerRun.Enabled:=false;
  ActionTimerRun.Checked:=false;
 end
 else
 begin
  TimerRun.Enabled:=true;
  ActionTimerRun.Checked:=true;
 end;

end;

end.
