unit unit_frame_set_users;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, StdCtrls, Grids,
  KGrids, rxdbgrid;

type
  
  { TFrameSetUsers }

  TFrameSetUsers = class(TFrame)
    Button1: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    RxDBGrid1: TRxDBGrid;
    StringGrid1: TStringGrid;
    procedure KGrid1Click(Sender: TObject);
    procedure Panel7Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

{ TFrameSetUsers }

procedure TFrameSetUsers.KGrid1Click(Sender: TObject);
begin

end;

procedure TFrameSetUsers.Panel7Click(Sender: TObject);
begin

end;

end.

