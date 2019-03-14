unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type

  TIBDataPumpCallBack = procedure(ARepLine: PChar); stdcall;

  TForm1 = class(TForm)
    RunSilent: TButton;
    Memo1: TMemo;
    ShowIBPump: TButton;
    procedure RunSilentClick(Sender: TObject);
    procedure ShowIBPumpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function IBPumpExec(AProfile, ASourceFile, ADestFile: PChar; ACallBack: TIBDataPumpCallBack): integer;
  stdcall; external 'IBPumpPlug.dll ';

procedure IBPumpShow;
  stdcall; external 'IBPumpPlug.dll ';

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure ShowProgress(ARepLine: PChar); stdcall;
begin
  Form1.Memo1.Lines.Add(ARepLine);
end;

procedure TForm1.RunSilentClick(Sender: TObject);
var
  AProfile, ASourceFile, ADestFile:string;
  Res: integer;
begin
  Memo1.Lines.Clear;
  AProfile := 'E:\Progs\IBDataPump\DbDemos1.ibp';
//  ASourceFile := 'd:\ibdata\bs.gdb';
//  ADestFile := 'd:\ibdata\bstest.gdb';
  ASourceFile := '';
  ADestFile := '';
  Res := IBPumpExec(PChar(AProfile), PChar(ASourceFile), PChar(ADestFile), ShowProgress);
  if Res = 0 then ShowMessage('All Fine.');
  if Res = -1 then ShowMessage('Error!');
  if Res > 0 then ShowMessage('Errors during pumping - ' + IntToStr(Res));
end;

procedure TForm1.ShowIBPumpClick(Sender: TObject);
begin
  IBPumpShow;
end;

end.
