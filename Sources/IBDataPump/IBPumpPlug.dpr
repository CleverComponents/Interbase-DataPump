{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: IBPumpPlug.dpr
}

library IBPumpPlug;

{$INCLUDE ccGetVer.inc}

uses
  SysUtils,
  Classes,
  IBEIntf,
  Forms,
  Windows,
  ActiveX,
    // Fixed Borland ADODB module
    ADODB in 'ADODB.pas',
    ibpDM in 'ibpDM.pas' {FibpDM: TDataModule},
    ibpHelp in 'ibpHelp.pas' {FibpHelp},
    ibpGenSql in 'ibpGenSql.pas' {FibpGenSql},
    ibpIncFields in 'ibpIncFields.pas' {FibpIncDields},
    ibpSQLEditor in 'ibpSQLEditor.pas' {FibpSQLEditor},
    ibpUpdDefs in 'ibpUpdDefs.pas' {FibpUpdDefs},
    ibpMain in 'ibpMain.pas' {FibpMain};

{$R *.RES}

procedure plugin_execute(Intf: TIBEInterface); stdcall;
var
  FibpMain: TibpMain;
  OldHandle: THandle;
  i, DBCount: integer;
begin
  CoInitialize(nil);
  try
    ibpMain.IsParamMode := False;
    OldHandle := Application.Handle;
    Application.Handle := TApplication(Intf.MainApplication).Handle;
    FibpMain := TibpMain.Create(TApplication(Intf.MainApplication));

    FibpHelp := TibpHelp.Create(TApplication(Intf.MainApplication));
    FibpHelp.Show;
    FibpHelp.Update;
    Windows.Sleep(2000);
    FibpHelp.Free;

    try
      DBCount := Intf.DatabasesCount;
      for i := 0 to pred(DBCount) do
        if Intf.DatabaseActive(i) then
        begin
          FibpMain.eDestDatabase.Text:= string(Intf.DatabaseName(i));
          break;
        end;
      FibpMain.ShowModal;
    finally
      FibpMain.Free;
    end;
    Application.Handle := OldHandle;
  finally
    CoUninitialize;
  end;
end;

procedure get_plugin_info(PluginInfo: pointer); stdcall;
begin
  with PIBEPluginInfo(PluginInfo)^ do begin
    PluginName := ibpMain.AppTitle;
    Description :=
      'Interbase DataPump allow you to pump data from any ADO/BDE/ODBC sources (dBase, ' +
      'Paradox, Access, MSSQL, Sybase, Oracle, DB2 etc) into Interbase/Firebird databases easy, fast and ' +
      'painless.' + #13 +
      'This programm will also help you to migrate from Interbase 5.xx and older Interbase '+
      'databases to the new Interbase 6.xx/Firebird format.' + #13 +
      'You can also use it to pump data between Interbase/Firebird databases.';
    MenuCaption := ibpMain.AppTitle + ' ...';
  end;
end;

procedure IBPumpShow; stdcall;
var
  FibpMain: TibpMain;
begin
  CoInitialize(nil);
  try
    ibpMain.IsParamMode := False;
    FibpMain := TibpMain.Create(Application);

    FibpHelp := TibpHelp.Create(Application);
    FibpHelp.Show;
    FibpHelp.Update;
    Windows.Sleep(2000);
    FibpHelp.Free;

    try
      FibpMain.ShowModal;
    finally
      FibpMain.Free;
    end;
  finally
    CoUninitialize;
  end;
end;

function IBPumpRun(AProfile, ASourceFile, ADestFile: string; AParamRep: TStrings): integer; stdcall;
begin
  raise Exception.Create('IBPumpPlug: Function IBPumpRun is not supported anymore. Use IBPumpExec instead.');
end;

function IBPumpExec(AProfile, ASourceFile, ADestFile: PChar; ACallBack: TIBDataPumpCallBack): integer; stdcall;
begin
  result := ibpMain.DoIBPumpExec(AProfile, ASourceFile, ADestFile, ACallBack);
end;

exports
  plugin_execute,
  get_plugin_info,
  IBPumpRun,
  IBPumpExec,
  IBPumpShow;

end.
