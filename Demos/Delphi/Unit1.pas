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
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    ABusy: boolean;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  ABusy := False;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not ABusy;
end;

procedure TForm1.RunSilentClick(Sender: TObject);
var
  AProfile, ASourceFile, ADestFile:string;
  Res: integer;
begin
  if not ABusy then
  begin
    ABusy := True;
    try
      Memo1.Lines.Clear;
      { IB DataPump profile }
      AProfile := 'E:\Progs\IBDataPump\MSSQL_Northwind.ibp';
      { path/connection string to source database if different from profile }
//      ASourceFile := 'd:\ibdata\bs.gdb';
      { path to dest database if different from profile }
//      ADestFile := 'd:\ibdata\bstest.gdb';
      ASourceFile := '';
      ADestFile := '';
      Res := IBPumpExec(PChar(AProfile), PChar(ASourceFile), PChar(ADestFile), ShowProgress);
      if Res = 0 then ShowMessage('All Fine.');
      if Res = -1 then ShowMessage('Error!');
      if Res > 0 then ShowMessage('Errors during pumping - ' + IntToStr(Res));
    finally
      ABusy := False;
    end;
  end;  
end;

procedure TForm1.ShowIBPumpClick(Sender: TObject);
begin
  if not ABusy then
  begin
    ABusy := True;
    try
      IBPumpShow;
    finally
      ABusy := False;
    end;
 end;
end;

end.
