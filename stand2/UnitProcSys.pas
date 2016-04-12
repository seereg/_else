unit UnitProcSys;


interface

uses classes,windows;

 procedure getProcess(var s:TStringList);
 procedure getWin(var s:TStringList;handle: hwnd);
 function colProcess(procName:string):integer;
 function notcloseWin(winCap:PAnsiChar):integer;
 function closeWin(winCap:PAnsiChar):integer;
 function WinExecAndWait32(FileName:String; Visibility : integer):integer;
 function WinRunAs(FileName:String):integer;

implementation

uses tlhelp32,messages,SysUtils,ShellApi;

 procedure getProcess(var s:TStringList);
var
  hSnapShot: THandle;
  ProcInfo: TProcessEntry32;
begin
  hSnapShot := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if (hSnapShot <> THandle(-1)) then
  begin
    ProcInfo.dwSize := SizeOf(ProcInfo);
    if (Process32First(hSnapshot, ProcInfo)) then
    begin
      s.Add(ProcInfo.szExeFile);
      while (Process32Next(hSnapShot, ProcInfo)) do
        s.Add(ProcInfo.szExeFile);
    end;
    CloseHandle(hSnapShot);
  end;
end;

 procedure getWin(var s:TStringList;handle: hwnd);
var
 wnd: hwnd;
 buff:{PAnsiChar;//} array [0..127] of char;
begin
  wnd := GetWindow(handle, gw_hwndfirst);
  while wnd <> 0 do
  begin // Не показываем:
   if {(wnd <> Handle) // Собственное окно
   and }IsWindowVisible(wnd) // Невидимые окна
   {and (GetWindow(wnd, gw_owner) = 0) }// Дочерние окна
   and (GetWindowText(wnd, buff, SizeOf(buff)) <> 0) then
   begin
    GetWindowText(wnd, buff, SizeOf(buff));
    s.Add(buff);
   end;
   wnd := GetWindow(wnd, gw_hwndnext);
  end;
end;

 function colProcess(procName:string):integer;
var
  hSnapShot: THandle;
  ProcInfo: TProcessEntry32;
begin
  result:=0;
  hSnapShot := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if (hSnapShot <> THandle(-1)) then
  begin
    ProcInfo.dwSize := SizeOf(ProcInfo);
    if (Process32First(hSnapshot, ProcInfo)) then
    begin
      if ProcInfo.szExeFile=procName then inc(result);
      while (Process32Next(hSnapShot, ProcInfo)) do
        if ProcInfo.szExeFile=procName then inc(result);
    end;
    CloseHandle(hSnapShot);
  end;
end;

 function notcloseWin(winCap:PAnsiChar):integer;
var
 hwndHandle : THANDLE;
 hMenuHandle : HMENU;
begin
 result:=0;
 hwndHandle := FindWindow(nil,winCap);
 if (hwndHandle <> 0) then begin
  result:=1;
  hMenuHandle := GetSystemMenu(hwndHandle, FALSE);
  if (hMenuHandle <> 0) then
   begin
    DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
    DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
   end;
 end;
end;

 function closeWin(winCap:PAnsiChar):integer;
begin
 PostMessage(FindWindow(Nil,winCap), WM_QUIT, 0, 0);
 result:=0;
end;

function WinExecAndWait32(FileName:String; Visibility : integer):integer;
var
 zAppName:array[0..512] of char;
 zCurDir:array[0..255] of char;
 WorkDir:String;
 StartupInfo:TStartupInfo;
 ProcessInfo:TProcessInformation;
begin
 StrPCopy(zAppName,FileName);
 GetDir(0,WorkDir);
 StrPCopy(zCurDir,WorkDir);
 FillChar(StartupInfo,Sizeof(StartupInfo),#0);
 StartupInfo.cb := Sizeof(StartupInfo);
 StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
 StartupInfo.wShowWindow := Visibility;
 if not CreateProcess(nil,
  zAppName,                      { указатель командной строки }
  nil,                           { процесс отрибутов безопасности }
  nil,                           { ????????? ?? ????? ????????? ???????????? }
  false,                         { ???? ????????????? ??????????? }
  CREATE_NEW_CONSOLE or          { ???? ???????? }
  NORMAL_PRIORITY_CLASS,
  nil,                           { ????????? ?? ????? ????? ???????? }
  nil,                           { ????????? ?? ??? ??????? ?????????? }
  StartupInfo,                   { ????????? ?? STARTUPINFO }
  ProcessInfo)
 then
  Result := -1 { ????????? ?? PROCESS_INF }
 else
  begin
  WaitforSingleObject(ProcessInfo.hProcess,INFINITE);
  GetExitCodeProcess(ProcessInfo.hProcess,cardinal(Result));
 end;
end;

 function WinRunAs(FileName:String):integer;
var
 ProcessInfo: TShellExecuteInfo;
begin
 ZeroMemory(@ProcessInfo, SizeOf(ProcessInfo));
 ProcessInfo.cbSize := SizeOf(TShellExecuteInfo);
// ProcessInfo.Wnd := Handle;
 ProcessInfo.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
 ProcessInfo.lpVerb := PChar('runas');
 ProcessInfo.lpFile := PChar(FileName);
 ProcessInfo.nShow := SW_HIDE;
 ProcessInfo.lpParameters:= '';
  result:=0;
 if not ShellExecuteEx(@ProcessInfo) then
  result:=-1
 else
  begin
  WaitforSingleObject(ProcessInfo.hProcess,INFINITE);
  GetExitCodeProcess(ProcessInfo.hProcess,cardinal(Result));
 end;
// GetExitCodeProcess(SEI.hProcess, lpExitCode);
// result:=lpExitCode;
end;

end.
