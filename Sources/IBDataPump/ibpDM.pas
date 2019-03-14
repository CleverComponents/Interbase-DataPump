{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ibpDM.pas
}

unit ibpDM;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  IBDatabase, IBQuery, IBSQL, Db, DBTables, IBDatabaseInfo, IBExtract, ADODB;

type

  { TibpDM }

  TOnGetUserInfo = procedure (Sender: TObject; var AUserName, APassword: string) of object;

  TibpDM = class(TDataModule)
    DBSource: TIBDatabase;
    DBDest: TIBDatabase;
    trSource: TIBTransaction;
    trDest: TIBTransaction;
    bdeDb: TDatabase;
    ibeDest: TIBExtract;
    ibeSource: TIBExtract;
    adoDb: TADOConnection;
    procedure bdeDbLogin(Database: TDatabase; LoginParams: TStrings);
    procedure adoDbWillConnect(Connection: TADOConnection;
      var ConnectionString, UserID, Password: WideString;
      var ConnectOptions: TConnectOption; var EventStatus: TEventStatus);
    procedure OnGetParadoxPassBDE(Sender: TObject; var Continue: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FOnGetUserInfo: TOnGetUserInfo;
    FOldPasswordEvent: TPasswordEvent;
  public
    property OnGetUserInfo: TOnGetUserInfo read FOnGetUserInfo write FOnGetUserInfo;

    function GetIBQuery(ADatabase: TIBDatabase; ASQL: string): TIBQuery;
  end;

implementation

{$R *.DFM}

{ TibpDM }

procedure TibpDM.bdeDbLogin(Database: TDatabase; LoginParams: TStrings);
var
  AUserName, APassword: string;
begin
  SetLength(AUserName, 0);
  SetLength(APassword, 0);

  if Assigned(FOnGetUserInfo)
    then FOnGetUserInfo(Self, AUserName, APassword);

  LoginParams.Values['USERNAME'] := AUserName;
  LoginParams.Values['USER NAME'] := AUserName;
  LoginParams.Values['PASSWORD'] := APassword;
end;

procedure TibpDM.adoDbWillConnect(Connection: TADOConnection;
  var ConnectionString, UserID, Password: WideString;
  var ConnectOptions: TConnectOption; var EventStatus: TEventStatus);
var
  AUserName, APassword: string;
begin
  SetLength(AUserName, 0);
  SetLength(APassword, 0);

  if Assigned(FOnGetUserInfo)
    then FOnGetUserInfo(Self, AUserName, APassword);

  UserID := AUserName;
  Password := APassword;
end;

procedure TibpDM.OnGetParadoxPassBDE(Sender: TObject; var Continue: Boolean);
var
  AUserName, APassword: string;
begin
  SetLength(AUserName, 0);
  SetLength(APassword, 0);

  if Assigned(FOnGetUserInfo)
    then FOnGetUserInfo(Self, AUserName, APassword);

  Session.RemoveAllPasswords;
  if Length(APassword) > 0
   then Session.AddPassword(APassword);

  Continue := True; 
end;

procedure TibpDM.DataModuleCreate(Sender: TObject);
begin
  FOldPasswordEvent := Session.OnPassword;
  Session.OnPassword := OnGetParadoxPassBDE;
end;

procedure TibpDM.DataModuleDestroy(Sender: TObject);
begin
  Session.OnPassword := FOldPasswordEvent;
end;

function TibpDM.GetIBQuery(ADatabase: TIBDatabase; ASQL: string): TIBQuery;
begin
  Result := TIBQuery.Create(Self);
  Result.Database := ADatabase;
  Result.Transaction := ADatabase.DefaultTransaction;
  Result.SQL.Text := ASQL
end;

end.
