program Stand;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UnitFrame1 in 'UnitFrame1.pas' {Frame1: TFrame},
  UnitProcSys in 'UnitProcSys.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
