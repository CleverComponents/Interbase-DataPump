{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: IBPump.dpr
}

program IBPump;

{$INCLUDE ccGetVer.inc}

uses
  Forms,
  Windows,
  adodb in 'adodb.pas',
  ibpDM in 'ibpDM.pas' {FibpDM: TDataModule},
  ibpHelp in 'ibpHelp.pas' {FibpHelp},
  ibpGenSql in 'ibpGenSql.pas' {FibpGenSql},
  ibpIncFields in 'ibpIncFields.pas' {FibpIncDields},
  ibpSQLEditor in 'ibpSQLEditor.pas' {FibpSQLEditor},
  ibpUpdDefs in 'ibpUpdDefs.pas' {FibpUpdDefs},
  ibpMain in 'ibpMain.pas' {FibpMain},
  ibmUpdWizard in 'ibmUpdWizard.pas' {ibpUpdWizard};

{$R *.RES}

var
  FibpMain: TibpMain;

begin
  if ParamCount > 0 then
  begin
    ibpMain.DoCommandLine;
  end
  else
  begin
    Application.Initialize;

    Application.CreateForm(TibpMain, FibpMain);
    Application.CreateForm(TibpHelp, FibpHelp);

    FibpHelp.Show;
    FibpHelp.Update;

    Windows.Sleep(2000);
    
    FibpHelp.Free;
    Application.Run;
  end;  
end.
