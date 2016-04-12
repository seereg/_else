unit UnitFrame1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, RXSwitch, ExtCtrls, Mask, ToolEdit, ComCtrls ;

type
  TFrameProg = class(TFrame)
    GroupBoxProg: TGroupBox;
    Image1: TImage;
    RxAutorun: TRxSwitch;
    RxRestart: TRxSwitch;
    PanelPic: TPanel;
    RxTimer: TRxSwitch;
    EditPath: TEdit;
    DateTimePickerRun: TDateTimePicker;
    procedure Image1DblClick(Sender: TObject);
    procedure RxTimerOn(Sender: TObject);
    procedure RxTimerOff(Sender: TObject);
    procedure GroupBoxProgDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(filepath: string; AOwner: TComponent);
    procedure getIcon(filepath: string);
  end;

type
 TMyThread=class(TThread)
 private  //в приделах unit
  FileName:string;
  Sender: TFrameProg;
  result:integer;
 published//доступна везде
  constructor Create(pSender: TFrameProg;pFileName:string);
  procedure Execute; override;
  procedure DoWork;
 protected//только потомкам
 private
end;

 type ThIconArray = array[0..0] of hIcon;
 type PhIconArray = ^ThIconArray;
             function ExtractIconExA(lpszFile: PAnsiChar;
                                     nIconIndex: Integer;
                                     phiconLarge : PhIconArray;
                                     phiconSmall: PhIconArray;
                                     nIcons: UINT): UINT; stdcall;
               external 'shell32.dll' name 'ExtractIconExA';

             function ExtractIconExW(lpszFile: PWideChar;
                                     nIconIndex: Integer;
                                     phiconLarge: PhIconArray;
                                     phiconSmall: PhIconArray;
                                     nIcons: UINT): UINT; stdcall;
               external 'shell32.dll' name 'ExtractIconExW';

             function ExtractIconEx(lpszFile: PAnsiChar;
                                    nIconIndex: Integer;
                                    phiconLarge : PhIconArray;
                                    phiconSmall: PhIconArray;
                                    nIcons: UINT): UINT; stdcall;
               external 'shell32.dll' name 'ExtractIconExA';



implementation

uses UnitProcSys, Unit1;

{$R *.dfm}
{ TMyThread }///////////////////////////////////////////////////

constructor TMyThread.Create(pSender: TFrameProg;pFileName: string);
begin
 inherited Create(false);
 FileName:=pFileName;
 Sender:=pSender;
end;

procedure TMyThread.DoWork;
begin
  if  Sender.RxRestart.StateOn then Sender.Image1DblClick(Sender)
//  else ShowMessage('Процесс завершён!');
end;

procedure TMyThread.Execute;
begin
  inherited;
  result:=WinExecAndWait32(FileName,SW_SHOWNORMAL);
  Synchronize(DoWork);
end;
///////////////////////////////////////////////////////

{ TFrameProg }

constructor TFrameProg.Create(filepath: string; AOwner: TComponent);
begin
  inherited Create(AOwner);
  GroupBoxProg.Caption:=filepath;
  EditPath.Text:=filepath;
  geticon(filepath);

end;

procedure TFrameProg.getIcon(filepath: string);
var
 NumIcons : integer;
 pTheLargeIcons : phIconArray;
 pTheSmallIcons : phIconArray;
 i : integer;
 TheIcon : TIcon;
 TheBitmap : TBitmap;
begin
 NumIcons := ExtractIconEx(PAnsiChar(filepath),-1,nil,nil,0);
 if NumIcons > 0 then begin
  GetMem(pTheSmallIcons, NumIcons * sizeof(hIcon));
  FillChar(pTheSmallIcons^, NumIcons * sizeof(hIcon), #0);
  GetMem(pTheLargeIcons, NumIcons * sizeof(hIcon));
  FillChar(pTheLargeIcons^, NumIcons * sizeof(hIcon), #0);
  ExtractIconEx(PAnsiChar(filepath),0,pTheLargeIcons,pTheSmallIcons,numIcons);
  for i := 0 to (NumIcons - 1) do begin
   TheIcon := TIcon. Create;
   TheBitmap := TBitmap.Create;
//   TheIcon.Handle := pTheSmallIcons^[i];
   TheIcon.Handle := pTheLargeIcons^[i];
   TheBitmap.Width := TheIcon.Width;
   TheBitmap.Height := TheIcon.Height;
   TheBitmap.Canvas.Draw(0, 0, TheIcon);
   TheIcon.Free;
   Image1.Picture.Bitmap:=TheBitmap;
   TheBitmap.Free;
  end;
  FreeMem(pTheLargeIcons, NumIcons * sizeof(hIcon));
  FreeMem(pTheSmallIcons, NumIcons * sizeof(hIcon));
 end;
end;

procedure TFrameProg.Image1DblClick(Sender: TObject);
  var thWinExecAndWait32:TMyThread;
begin
//  if Form1.wshow then Form1.silent; //не назначаются гаряцчие клавиши
  thWinExecAndWait32:=TMyThread.Create(self,EditPath.Text);
end;

procedure TFrameProg.RxTimerOn(Sender: TObject);
begin
  DateTimePickerRun.Enabled:=true;
end;

procedure TFrameProg.RxTimerOff(Sender: TObject);
begin
  DateTimePickerRun.Enabled:=False;
end;

procedure TFrameProg.GroupBoxProgDblClick(Sender: TObject);
begin
 GroupBoxProg.Caption:=inputbox('Редактирование названия','Заголовок блока задачи:',GroupBoxProg.Caption);
end;

end.
