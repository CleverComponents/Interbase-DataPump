unit IBEIntf;

interface

uses Windows;

type

  { Plugin information }
  PIBEPluginInfo = ^TIBEPluginInfo;
  TIBEPluginInfo = record
    PluginName  : PChar;
    Description : PChar;
    MenuCaption : PChar;
  end;

  { Error Information }
  PIBEErrorInfo = ^TIBEErrorInfo;
  TIBEErrorInfo = record
    ErrorType : integer;
    SQLCode : integer;
    Message : PChar;
  end;

  { IB Expert objects lists }
  TIBEITablesList = Pointer;
  TIBEITableFields = Pointer;
  TIBEIConstraintsList = Pointer;
  TIBEIQuery = Pointer;
  TIBEITransaction = Pointer;

  { Information about table }
  TIBEITableInfo = record
    TableName : PChar;
    Description : PChar;
  end;

  { Information about field of table }
  TIBEIFieldInfo = record
    FieldName       : PChar;
    FieldDomain     : PChar;
    FieldPos        : WORD;
    FieldType       : WORD;
    FieldSubType    : integer; // for Blob fields
    FieldSegmentLen : WORD;    // for Blob fields;
    FieldLen        : WORD;
    FieldScale      : integer; // <= 0
    CharacterLen    : integer;
    Dimensions      : PChar;   // В виде [a,b,c]
    NotNull         : boolean;
    DefaultSource   : PChar;
    ComputedSource  : PChar;
    CollationId     : integer;
    CharSetId       : integer;
    Collation       : PChar;
    CharSet         : PChar;
    FieldTypeAsString : PChar;
  end;

  TIBEIConstraintInfo = record
    ConstraintName : PChar;
    ConstraintType : integer;
    TableName : PChar;
    OnField : PChar;
    ForeignTable : PChar;
    ForeignField : PChar;
    UpdateRule : integer;
    DeleteRule : integer;
    CheckSource : PChar;
  end;

  { Database functions }
  TDatabasesCount = function : integer;
  TDatabaseAlias = function(DBIndex : integer) : PChar;
  TDatabaseName = function(DBIndex : integer) : PChar;
  TDatabaseActive = function(DBIndex : integer) : boolean;
  TOpenDatabase = function(DBIndex : integer) : integer;
  TCloseDatabase = function(DBIndex : integer) : integer;
  TDatabaseFormatIdentifier = function(DBIndex : integer; Identifier : PChar) : PChar;

  { Table and fields functions }
  TGetTables = function(DBIndex : integer; IncludeSystem, IncludeDescriptions : boolean; var TablesCount : integer) : TIBEITablesList;
  TFetchTableInfo = function(Tables : TIBEITablesList; Index : Integer; var Info : TIBEITableInfo) : integer;
  TFreeTables = procedure(Tables : TIBEITablesList);
  TFieldsOfTable = function(DBIndex : integer; TableName : PChar; var FieldsCount : integer) : TIBEITableFields;
  TFieldInfo = function(Fields : TIBEITableFields; Index : integer; var Info : TIBEIFieldInfo) : integer;
  TFreeTableFields = procedure(Fields : TIBEITableFields);

  { Constraints functions }
  TGetConstraints = function(DBIndex : integer; TableName : PChar; ConstraintType : integer; var ConstraintsCount : integer) : TIBEIConstraintsList;
  TFetchConstraintInfo = function(Constraints : TIBEIConstraintsList; Index : integer; var Info : TIBEIConstraintInfo) : integer;
  TFreeConstraints = procedure(Constraints : TIBEIConstraintsList);


  { Transaction functions }
  TCreateTransaction = function(DBIndex : integer; const Params : PChar) : TIBEITransaction;
  TStartTransaction = procedure(Transaction : TIBEITransaction);
  TCommitTransaction = procedure(Transaction : TIBEITransaction);
  TRollbackTransaction = procedure(Transaction : TIBEITransaction);
  TFreeTransaction = procedure(Transaction : TIBEITransaction);

  { Query functions }
  TCreateQuery = function(DBIndex : integer; Transaction : TIBEITransaction) : TIBEIQuery;
  TSetQuerySQL = procedure(Query : TIBEIQuery; SQL : PChar);
  TPrepareQuery = function (Query : TIBEIQuery) : integer;
  TExecQuery = function (Query : TIBEIQuery) : integer;
  TParamCheck = procedure(Query : TIBEIQuery; ParamCheck : boolean);
  TSetParam = procedure(Query : TIBEIQuery; ParamIndex : integer; ParamValue : Variant);
  TSetTypedParam = procedure(Query : TIBEIQuery; ParamIndex, ParamType : integer; ParamValue : Variant);
  TGetFieldByName = function(Query : TIBEIQuery; const FieldName : PChar) : variant;
  TGetFieldByIndex = function(Query : TIBEIQuery; FieldIndex : integer) : variant;
  TQueryEof = function(Query : TIBEIQuery) : boolean;
  TQueryNext = procedure(Query : TIBEIQuery);
  TQueryFirst = procedure(Query : TIBEIQuery);
  TQueryLast = procedure(Query : TIBEIQuery);
  TQueryPrior = procedure(Query : TIBEIQuery);
  TFreeQuery = procedure(Query : TIBEIQuery);


  { Plugin interface }
  TIBEInterface = record
    MainApplication: pointer;
    LastError : TIBEErrorInfo;

    DatabasesCount : TDatabasesCount;
    DatabaseAlias : TDatabaseAlias;
    DatabaseName : TDatabaseName;
    DatabaseActive : TDatabaseActive;
    DatabaseFormatIdentifier : TDatabaseFormatIdentifier;

    OpenDatabase : TOpenDatabase;
    CloseDatabase : TCloseDatabase;

    GetTables : TGetTables;
    FetchTableInfo : TFetchTableInfo;
    FreeTables : TFreeTables;

    FieldsOfTable : TFieldsOfTable;
    FieldInfo : TFieldInfo;
    FreeTableFields : TFreeTableFields;

    GetConstraints : TGetConstraints;
    FetchConstraintInfo : TFetchConstraintInfo;
    FreeConstraints : TFreeConstraints;

    CreateTransaction : TCreateTransaction;
    StartTransaction : TStartTransaction;
    CommitTransaction : TCommitTransaction;
    RollbackTransaction : TRollbackTransaction;
    FreeTransaction : TFreeTransaction;

    CreateQuery : TCreateQuery;
    SetQuerySQL : TSetQuerySQL;
    PrepareQuery : TPrepareQuery;
    ExecQuery : TExecQuery;
    ParamCheck : TParamCheck;
    SetParam : TSetParam;
    SetTypedParam: TSetTypedParam;
    GetFieldByName : TGetFieldByName;
    GetFieldByIndex : TGetFieldByIndex;
    QueryEof : TQueryEof;
    QueryNext : TQueryNext;
    QueryFirst : TQueryFirst;
    QueryLast : TQueryLast;
    QueryPrior : TQueryPrior;
    FreeQuery : TFreeQuery;
  end;

  TGetPluginInfoProc = procedure(PluginInfo: PIBEPluginInfo); stdcall;
  TPluginExecuteProc = procedure(Intf : TIBEInterface); stdcall;

implementation

end.
