unit FramePassport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, typinfo, FileUtil, Forms, Controls, ComCtrls, ActnList,
  StdCtrls, attabs, FramePassportObjects, FramePassportProperties,
  unit_types_and_const, unit_m_data, unitDemoFrame1, typePaspProp, KGrids;

type

  { TFramePassport }

  TFramePassport = class(TFrame)
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    ActionList1: TActionList;
    PageControlPassport: TPageControl;
    TabSheet2: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
  private
    { private declarations }
    propEdit:Boolean;
    procedure setEdit(AValue: Boolean);
  public
    { public declarations }
    TabIndex:integer;
    PasspID:integer;
    UserID :integer;
    property Edit    :Boolean read propEdit  write setEdit; 
    constructor Create(TheOwner: TComponent;TabOwner:TATTabs;pPasspID,pUserID:integer); //override;
  end;

implementation

{$R *.lfm}

{ TFramePassport }
var
  FPassportProperties:TFramePassportProperties;

procedure TFramePassport.Action1Execute(Sender: TObject);
begin
  Caption:=Caption;
end;

procedure TFramePassport.Action2Execute(Sender: TObject);
begin
  Caption:=Caption;
end;

procedure TFramePassport.setEdit(AValue: Boolean);
var i:integer;
    p: PPropInfo;
begin
  if propEdit=AValue then Exit;
  propEdit:=AValue;
  log('test');
                  //ljkl
  for i := 0 to ComponentCount-1 do
  begin
    //p := GetPropInfo(Components[i].ClassType, 'ReadOnly');
    //if Assigned(p) then
    //
    //TCustomEdit(Components[i]).reaColor := clRed;
    if (Components[i] is TEdit) then
    (Components[i] as TEdit).ReadOnly := propEdit;
  end;
end;

constructor TFramePassport.Create(TheOwner: TComponent; TabOwner: TATTabs;
  pPasspID,pUserID: integer);
var
  i:integer;
  TabSheet:TTabSheet;
  pass:TPassProp;
  FDemoFrame1:TDemoFrame1;
begin
  inherited Create(TheOwner);
  self.Parent:=TWinControl(TheOwner);
  pass:= TPassProp.Create(pPasspID,pUserID,DataM.ZConnection1);
  pPasspID:=strtoint(pass.pass_id);
  self.Name:='FramePassportID'+inttostr(pPasspID);
  self.PasspID:=pPasspID;
  self.UserID :=pUserID;
  { TODO : Заглушка - переделать тиб из БД }
  //TabOwner.AddTab(-1,'Тип-'+pass.pass_type+': '+pass.pass_name+' (ред.)');
  case StrToInt(pass.pass_type) of
  1:TabOwner.AddTab(-1,'Участок '+': '+pass.pass_name+' (ред.)');   
  2:TabOwner.AddTab(-1,'Узел '+': '+pass.pass_name+' (ред.)');   
  3:TabOwner.AddTab(-1,'Эпюр '+': '+pass.pass_name+' (ред.)');   
  end;
  TabOwner.TabIndex:=TabOwner.TabCount-1;
  freeandnil(pass); //  pass.Destroy;
   for i:=(PageControlPassport.PageCount-1) downto 0
    do PageControlPassport.Pages[i].Destroy;
   self.TabIndex:= TabOwner.TabIndex;
   TabSheet:=PageControlPassport.AddTabSheet;
   TabSheet.Caption:='Свойства';
   FPassportProperties:=TFramePassportProperties.Create(TabSheet);
   FPassportProperties.pass_id:=PasspID;
   FPassportProperties.user_id:=UserID;
   FPassportProperties.Parent:=TabSheet;
   
   TabSheet:=PageControlPassport.AddTabSheet;
   TabSheet.Caption:='Продольный профиль';
   FDemoFrame1:=  TDemoFrame1.Create(TabSheet,PasspID,UserID);
   TabSheet:=PageControlPassport.AddTabSheet;
   TabSheet.Caption:='Специальные объекты';
   
   FPassportProperties.PageControlPassport:=PageControlPassport;
   FPassportProperties.getDate;
end;

end.

