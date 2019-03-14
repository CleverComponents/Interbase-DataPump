object ibpDM: TibpDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 285
  Top = 161
  Height = 479
  Width = 741
  object DBSource: TIBDatabase
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = trSource
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    AllowStreamedConnected = False
    Left = 44
    Top = 8
  end
  object DBDest: TIBDatabase
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = trDest
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    AllowStreamedConnected = False
    Left = 44
    Top = 64
  end
  object trSource: TIBTransaction
    Active = False
    DefaultDatabase = DBSource
    AutoStopAction = saNone
    Left = 116
    Top = 8
  end
  object trDest: TIBTransaction
    Active = False
    DefaultDatabase = DBDest
    AutoStopAction = saNone
    Left = 120
    Top = 64
  end
  object bdeDb: TDatabase
    DatabaseName = 'bdeDb'
    ReadOnly = True
    SessionName = 'Default'
    OnLogin = bdeDbLogin
    Left = 40
    Top = 124
  end
  object ibeDest: TIBExtract
    Database = DBDest
    Transaction = trDest
    ShowSystem = False
    Left = 192
    Top = 64
  end
  object ibeSource: TIBExtract
    Database = DBSource
    Transaction = trSource
    ShowSystem = False
    Left = 192
    Top = 8
  end
  object adoDb: TADOConnection
    CursorLocation = clUseServer
    LoginPrompt = False
    Mode = cmRead
    OnWillConnect = adoDbWillConnect
    Left = 40
    Top = 184
  end
end
