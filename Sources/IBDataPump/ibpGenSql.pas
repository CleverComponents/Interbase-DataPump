{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ipbGenSql.pas
}

unit ibpGenSql;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, db, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBTables, ExtCtrls, ShellApi, DbiTypes, ADODB, comctrls, BDE,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
    ibpMain, ibpDM, ibpIncFields, ccSpinEdit, ccButtonEdit;

type

  { TVChk }

  TVChk = record
    Required, HasDefault, HasMin, HasMax: boolean;
    DefValue, MinValue, MaxValue: string;
  end;
  PTVChk = ^ TVChk;

  { TibpGenSqlSettings }

  TibpGenSqlSettings = class(TComponent)
  private
    FProfileVer: integer;
    FScriptName: string;
    FDatabaseName: string;
    FDialect: integer;
    FConvNames: integer;
    FFieldCase: integer;
    FCharSet: integer;
    FCopyInd: boolean;
    FGreateGen: boolean;
    FStrLen: integer;
    FCharName: string;
    FVarcharName: string;
    FIntegerName: string;
    FFloatName: string;
    FBCDName: string;
    FLargeintName: string;
    FSmallintName: string;
    FBooleanInd: integer;
    FBooleanName: string;
    FCurrencyName: string;
    FAutoIncName: string;
    FBlobName: string;
    FDatetimeName: string;
    FDateName: string;
    FTimeName: string;
    FBinaryName: string;
    FShowAllFields: boolean;
    FFields: TStrings;
    FValues: TStrings;
    FDefaults: boolean;
    FRefs: boolean;
    FMemoName: string;
    FGraphName: string;
    FDupInd: integer;
    FLangInfo: boolean;

    procedure SetFields(Value: TStrings);
    procedure SetValues(Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
  published
    property ProfileVer: integer read FProfileVer write FProfileVer;
    property ScriptName: string read FScriptName write FScriptName;
    property DatabaseName: string read FDatabaseName write FDatabaseName;
    property Dialect: integer read FDialect write FDialect;
    property ConvNames: integer read FConvNames write FConvNames;
    property FieldCase: integer read FFieldCase write FFieldCase;
    property CharSet: integer read FCharSet write FCharSet;
    property CopyInd: boolean read FCopyInd write FCopyInd;
    property GreateGen: boolean read FGreateGen write FGreateGen;
    property StrLen: integer read FStrLen write FStrLen;
    property CharName: string read FCharName write FCharName;
    property VarcharName: string read FVarcharName write FVarcharName;
    property IntegerName: string read FIntegerName write FIntegerName;
    property FloatName: string read FFloatName write FFloatName;
    property BCDName: string read FBCDName write FBCDName;
    property LargeintName: string read FLargeintName write FLargeintName;
    property SmallintName: string read FSmallintName write FSmallintName;
    property BooleanInd: integer read FBooleanInd write FBooleanInd;
    property BooleanName: string read FBooleanName write FBooleanName;
    property CurrencyName: string read FCurrencyName write FCurrencyName;
    property AutoIncName: string read FAutoIncName write FAutoIncName;
    property BlobName: string read FBlobName write FBlobName;
    property DatetimeName: string read FDatetimeName write FDatetimeName;
    property DateName: string read FDateName write FDateName;
    property TimeName: string read FTimeName write FTimeName;
    property BinaryName: string read FBinaryName write FBinaryName;
    property ShowAllFields: boolean read FShowAllFields write FShowAllFields;
    property Fields: TStrings read FFields write SetFields;
    property Values: TStrings read FValues write SetValues;
    property Defaults: boolean read FDefaults write FDefaults default False;
    property Refs: boolean read FRefs write FRefs default False;
    property MemoName: string read FMemoName write FMemoName;
    property GraphName: string read FGraphName write FGraphName;
    property DupInd: integer read FDupInd write FDupInd;
    property LangInfo: boolean read FLangInfo write FLangInfo;
  end;

  { TibpGenSql }

  TibpGenSql = class(TForm)
    lSaveTo: TLabel;
    lDialect: TLabel;
    lCase: TLabel;
    cbCase: TComboBox;
    lSpaces: TLabel;
    btnStart: TButton;
    btnCancel: TButton;
    sd: TSaveDialog;
    lOptions: TLabel;
    bvlOptions: TBevel;
    lTStringField: TLabel;
    lTIntegerField: TLabel;
    lTFloatField: TLabel;
    lTBCDField: TLabel;
    lTLargeintField: TLabel;
    lTSmallintField: TLabel;
    lTAutoIncField: TLabel;
    lTCurrencyField: TLabel;
    lTBooleanField: TLabel;
    lTDateTimeField: TLabel;
    lTDateField: TLabel;
    lTTimeField: TLabel;
    lTGraphicField: TLabel;
    cbTAutoIncField: TComboBox;
    cbTCurrencyField: TComboBox;
    cbBool: TComboBox;
    cbTGraphicField: TComboBox;
    cbTDateTimeField: TComboBox;
    cbTDateField: TComboBox;
    cbTTimeField: TComboBox;
    cbTStringFieldL: TComboBox;
    cbTIntegerField: TComboBox;
    cbTFloatField: TComboBox;
    cbTBCDField: TComboBox;
    cbTLargeintField: TComboBox;
    cbTSmallintField: TComboBox;
    lLength: TLabel;
    lThen: TLabel;
    lElse: TLabel;
    cbTStringFieldS: TComboBox;
    lMainOptions: TLabel;
    bvlMainOptions: TBevel;
    cbCharSet: TComboBox;
    lDefCharSet: TLabel;
    cbConvNames: TComboBox;
    lDatabase: TLabel;
    mInfo: TMemo;
    cbTBooleanField: TComboBox;
    lBooleanOption: TLabel;
    cbIndexes: TCheckBox;
    cbGen: TCheckBox;
    btnAutoIncDefine: TButton;
    btnSaveProfile: TButton;
    btnLoadProfile: TButton;
    btnHelp: TButton;
    btnNewProfile: TButton;
    sdProfile: TSaveDialog;
    odProfile: TOpenDialog;
    lTBinaryField: TLabel;
    cbTBinaryField: TComboBox;
    cbDefaults: TCheckBox;
    cbRefs: TCheckBox;
    lTBlobField: TLabel;
    cbTBlobField: TComboBox;
    lTMemoField: TLabel;
    cbTMemoField: TComboBox;
    Label1: TLabel;
    cbDupInd: TComboBox;
    cbLang: TCheckBox;
    procedure btnFileClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure upDialectChange(Sender: TObject);
    procedure btnNewProfileClick(Sender: TObject);
    procedure cbBoolChange(Sender: TObject);
    procedure btnAutoIncDefineClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnLoadProfileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveProfileClick(Sender: TObject);
  private
    FSettings: TibpGenSqlSettings;
    FAutoIncFields: TibpIncFields;
    sBoolDomain: string;
    FMain: TibpMain;

    ErrCnt, ErrRefs, CntWrn: integer;

    // ccCompos
    eDatabase: TccButtonEdit;
    eFile: TccButtonEdit;
    upDialect: TccSpinEdit;
    udLen: TccSpinEdit;

    procedure SetDialect;
    procedure RestDefs(AEmptyOnly: boolean = False);
    function GetIBName(AName: string): string;
    function GetIBType(AVar: TFieldDef; ANotNull: boolean = False; PVChk: PTVChk = nil): string;
    function GetIndexDetails(id: TIndexDef): string;
    procedure FillPrimFields(slist: TStringList; idn: TIndexDefs);
    function GetUnicInd(const AInd, ATable: string; slist, sfields, errs: TStringList): string;
    function GetRintDesc(const TableName: string; Table: TTable; ALines: TStrings; ARefList: TStrings = nil): integer;
  public
     constructor Create(AOwner: TComponent); override;
  end;

  { Common }

  function GetPureSqlName(const AName: string): string;
  procedure DoGenSql(AMain: TibpMain);
  { BDE: Paradox and dBase }
  function HasVChk(Table: TTable; Field: TField; var VChk: TVChk; const ADefTrue: string = 'T'; const ADefFalse: string = 'F'): boolean;
  function GetLanguageInfo(hCur: hDBICur): string;

implementation

const
  IBChars: set of char = ['A'..'Z', 'a'..'z', '0'..'9', '$', '_'];
  sCrDom = 'CREATE DOMAIN';
  DefIndexOption: array[TIndexOption] of string =
    ('ixPrimary', 'ixUnique', 'ixDescending', 'ixCaseInsensitive', 'ixExpression', 'ixNonMaintained');
  CurrProfileVer = 34;

{$R *.DFM}

{ Common }

function GetPureSqlName(const AName: string): string;
var
  i: integer;
begin
  SetLength(result, 0);
  for i := 1 to Length(AName) do
    if AName[i] in IBChars
      then result := result + AName[i];
end;

procedure DoGenSql(AMain: TibpMain);
var
  FGenSql: TibpGenSql;
begin
  FGenSql := TibpGenSql.Create(AMain);
  try
    with FGenSql do
    begin
      RestDefs;
      ShowModal;
    end;
  finally
    FGenSql.Free;
  end;
end;

{ TibpGenSqlSettings }

constructor TibpGenSqlSettings.Create(AOwner: TComponent);
begin
  inherited;
  FFields := TStringList.Create;
  FValues := TStringList.Create;
end;

destructor TibpGenSqlSettings.Destroy;
begin
  FFields.Free;
  FValues.Free;
  inherited;
end;

procedure TibpGenSqlSettings.SetFields(Value: TStrings);
begin
  FFields.Assign(Value);
end;

procedure TibpGenSqlSettings.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
end;

procedure TibpGenSqlSettings.Clear;
begin
  SetLength(FScriptName, 0);
  SetLength(FDatabaseName, 0);
  SetLength(FCharName, 0);
  SetLength(FVarcharName, 0);
  SetLength(FIntegerName, 0);
  SetLength(FFloatName, 0);
  SetLength(FBCDName, 0);
  SetLength(FLargeintName, 0);
  SetLength(FSmallintName, 0);
  SetLength(FBooleanName, 0);
  SetLength(FCurrencyName, 0);
  SetLength(FAutoIncName, 0);
  SetLength(FBlobName, 0);
  SetLength(FDatetimeName, 0);
  SetLength(FDateName, 0);
  SetLength(FTimeName, 0);
  SetLength(FMemoName, 0);
  SetLength(FGraphName, 0);

  FFields.Clear;
  FValues.Clear;
  FGreateGen := False;
  FCopyInd := False;
  FDefaults := False;
  FRefs := False;
  FShowAllFields := False;

  FProfileVer := 0;
  FDupInd := 0;
end;

{ TibpGenSql }

constructor TibpGenSql.Create(AOwner: TComponent);
begin
  inherited;
  FMain := AOwner as TibpMain;

    // create ccCompos (avoid package)
  upDialect:= TccSpinEdit.Create(Self);
  with upDialect do
  begin
    Parent:= Self;  
    Alignment:= taLeftJustify;
  	Left:= 140;
    Top:= 67;
    Width:= 50;
    Height:= 21;
    TabOrder:= 2;
    Increment:= 1;
    Min:= 1;
    Max:= 3;
    Enabled:= True;
    OnChange:= upDialectChange;
  end;
  eFile:= TccButtonEdit.Create(Self);
  with eFile do
  begin
    Parent:= Self;  
    Left:= 140;
    Top:= 14;
    Width:= 487;
    Height:= 21;
    TabOrder:= 0;
    OnButtonClick:= btnFileClick;
  end;
  udLen:= TccSpinEdit.Create(Self);
  with udLen do
  begin
    Parent:= Self;  
    Left:= 71;
    Top:= 231;
    Width:= 48;
    Height:= 21;
    TabOrder:= 13;
    Alignment:= taLeftJustify;
    Increment:= 1;
    Min:= 1;
    Max:= 255;
    Enabled:= True;
  end;
  eDatabase:= TccButtonEdit.Create(Self);
  with eDatabase do
  begin
    Parent:= Self;  
    Left:= 140;
    Top:= 40;
    Width:= 487;
    Height:= 21;
    TabOrder:= 1;
    OnButtonClick:= btnFileClick;
  end;
end;

procedure TibpGenSql.FormCreate(Sender: TObject);
begin
  FAutoIncFields := TibpIncFields.Create(FMain);
  FSettings := TibpGenSqlSettings.Create(nil);
  GetWindStat(Self);
end;

procedure TibpGenSql.FormDestroy(Sender: TObject);
begin
  FAutoIncFields.Free;
  FSettings.Free;
  SetWindStat(Self);
end;

procedure TibpGenSql.btnStartClick(Sender: TObject);
var
  lst, lst2, sql, sext, idxs, ainc, lrefs, lrefnames, llangs: TStringList;
  i, k, j: integer;
  ds, dsQ: TDataset;
  str, sCap, tmp, sLang: string;
  lind, linc, lOpen, lCheckRefDefs, lGetLangInfo: boolean;
  ind: TIndexDefs;
  AIBTable: string;
  ATableName: string;
  AFieldName: string;
  infSrc: string;
  PVChk: PTVChk;
  VChk: TVChk;
begin
  ErrCnt := 0;
  ErrRefs := 0;
  CntWrn := 0;

  DoControlExit;

  with FMain, FMain.DM do
  begin
    if Trim(eFile.Text) = '' then
    begin
      if eFile.CanFocus
        then eFile.SetFocus;
      MessageDlg(Format('%s can not be empty!', [lSaveTo.Caption]), mtError, [mbOK], 0);
      exit;
    end;

    if Trim(eDatabase.Text) = '' then
    begin
      if eDatabase.CanFocus
        then eDatabase.SetFocus;
      MessageDlg(Format('%s can not be empty!', [lDatabase.Caption]), mtError, [mbOK], 0);
      exit;
    end;

    DeleteFile(eFile.Text);

    SetLength(sBoolDomain, 0);

    if Self.cbBool.ItemIndex = 0 then
    begin
      str := StringReplace(UpperCase(cbTBooleanField.Text), '  ', ' ', [rfReplaceAll]);
      i := Pos(sCrDom, str);
      if (i > 0) and (i < Length(str)) then
      begin
        i := i + Length(sCrDom);
        while i < Length(str) do
        begin
          inc(i);
          if str[i] = ' '
            then break;
          sBoolDomain := sBoolDomain + str[i];
        end;
      end;
    end;

    case SrcType of
      pdtBDE:
        begin
          ds := FMain.bdeTable;
          dsQ := FMain.bdeQuery;
          ind := FMain.bdeTable.IndexDefs;
          ds.Close;
          bdeDb.Connected := True;
        end;
      pdtADO:
        begin
          ds := FMain.adoTable;
          dsQ := FMain.adoQuery;
          ind := FMain.adoTable.IndexDefs;
          ds.Close;
          adoDb.Connected := True;
        end;
    else
      raise Exception.Create(ErrSrc);
    end;

    sCap := Self.Caption;
    k := 0;
    try
      lst := TStringList.Create;
      lst2 := TStringList.Create;
      sql := TStringList.Create;
      sext := TStringList.Create;
      idxs := TStringList.Create;
      ainc := TStringList.Create;
      lrefs := TStringList.Create;
      lrefnames := TStringList.Create;
      llangs := TStringList.Create;
      try
        lrefnames.Sorted := True;
        lrefnames.Duplicates := dupIgnore;

        llangs.Sorted := True;
        llangs.Duplicates := dupIgnore;
        try
          sql.Text := mInfo.Lines.Text;

          sql.Insert(0, Format('Generated at %s by %s', [DateTimeToStr(Now), FMain.Caption]));
          sql.Insert(0, '/*');
          sql.Add('*/');

          sql.Add('');
          sql.Add(Format(' /* Select Option - %s */', [FMain.cbSrcSelect.Text]));
          if cbSrcQuoteFields.Checked
            then sql.Add(Format(' /* Option "%s" is ON */', [cbSrcQuoteFields.Caption]));
          if  cbIndexes.Checked
            then sql.Add(Format(' /* Option "%s" is ON */', [cbIndexes.Caption]));
          if  cbGen.Checked
            then sql.Add(Format(' /* Option "%s" is ON */', [cbGen.Caption]));
          if  cbDefaults.Visible and cbDefaults.Checked
            then sql.Add(Format(' /* Option "%s" is ON */', [cbDefaults.Caption]));
          if  cbRefs.Visible and cbRefs.Checked
            then sql.Add(Format(' /* Option "%s" is ON */', [cbRefs.Caption]));
          if  cbLang.Visible and cbLang.Checked
            then sql.Add(Format(' /* Option "%s" is ON */', [cbLang.Caption]));

          sql.Add('');

          lCheckRefDefs := (SrcType = pdtBDE) and
                           ((cbDefaults.Visible and cbDefaults.Checked) or
                            (cbRefs.Visible and cbRefs.Checked));

          lGetLangInfo := (SrcType = pdtBDE) and
                          ((cbLang.Visible and cbLang.Checked));

          if cbCharSet.ItemIndex <> 0
            then str := Format(' DEFAULT CHARACTER SET %s', [cbCharSet.Text])
            else SetLength(str, 0);

          sql.Add('/* For Interbase versions less than 6.0 you might need to delete next line. */');
          sql.Add(Format('SET SQL DIALECT %s;', [upDialect.Text]));
          sql.Add('');
          sql.Add(Format('CREATE DATABASE ''%s'' USER ''SYSDBA'' PASSWORD ''masterkey''%s;', [eDatabase.Text, str]));
          sql.Add('');

          if Self.cbBool.ItemIndex = 0 then
          begin
            sql.Add(cbTBooleanField.Text);
            sql.Add('');
          end;

          case SrcType of
            pdtBDE:
              begin
                Session.GetTableNames(bdeDb.DatabaseName, '', not bdeDb.IsSQLBased, False, lst);
                Session.GetTableNames(bdeDb.DatabaseName, '', False, False, lst2);
              end;
            pdtADO:
              begin
                adoDb.GetTableNames(lst, False) ;
                lst2.Assign(lst);
              end;
          else
            raise Exception.Create(ErrSrc);
          end;

          lst.Sort;
          lst2.Sort;

          for i := 0 to lst.Count-1 do
          begin
            Inc(k);
            AIBTable := GetIBName(lst2[i]);

            sext.Clear;
            ainc.Clear;
            lrefnames.Clear;

            linc := FAutoIncFields.Find(lst[i], '');

            case SrcType of
              pdtBDE:
                begin
                  if bdeDb.IsSQLBased and SrcQuoteFields
                    then ATableName := GetSQLName(lst[i], SrcType, SrcSelect)
                    else ATableName := lst[i];
                  bdeTable.TableName := ATableName;
                end;
              pdtADO:
                begin
                  if SrcQuoteFields
                    then ATableName := GetSQLName(lst[i], SrcType, SrcSelect)
                    else ATableName := lst[i];
                  adoTable.TableName := ATableName;
                end;
            else
              raise Exception.Create(ErrSrc);
            end;

            Self.Caption := Format('%s : %d / %d %s', [sCap, Succ(i), lst.Count, lst[i]]);

            ind.Clear;
            ds.FieldDefs.Clear;
            
            try
              ds.FieldDefs.Update;
            except
              on E: Exception do
              begin
                Inc(ErrCnt);
                sql.Add(Format('/* !!! Error: Unable get fields list for table %s: %s */', [lst[i], E.Message]));
              end;
            end;

            try
              ind.Update; 
              if cbIndexes.Checked
                then FillPrimFields(sext, ind);
            except
              on E: Exception do
              begin
                Inc(ErrCnt);
                sql.Add(Format('/* !!! Error: Unable get indexes for table %s: %s */', [lst[i], E.Message]));
              end;
            end;

            sql.Add(Format('/* Original table name is "%s" */', [lst[i]]));

            lOpen := bdeTable.Active;
            try
              try
                if (lCheckRefDefs or lGetLangInfo) and (not bdeTable.Active)
                  then bdeTable.Open;

                if lGetLangInfo then
                begin
                  sLang := GetLanguageInfo(bdeTable.Handle);
                  sql.Add(Format('/* %s */',[sLang]));
                  llangs.Add(sLang);
                end;

                sql.Add(Format('CREATE TABLE %s (', [AIBTable]));
                
                if lCheckRefDefs and cbRefs.Checked
                  then Inc(ErrRefs, GetRintDesc(AIBTable, bdeTable, lrefs, lrefnames));

                for j := 0 to ds.FieldDefs.Count-1 do
                begin
                  if lCheckRefDefs and
                     cbDefaults.Checked and
                     HasVChk(bdeTable, bdeTable.Fields[j], VChk, FMain.eBoolTrue.Text, FMain.eBoolFalse.Text)
                    then PVChk := @VChk
                    else PVChk := nil;

                  sql.Add(Format('  %s %s /* "%s" */',
                          [GetIBName(ds.FieldDefs[j].Name),
                           GetIBType(ds.FieldDefs[j], (sext.IndexOf(ds.FieldDefs[j].Name) <> -1), PVChk),
                           ds.FieldDefs[j].Name]));

                  if j <> (ds.FieldDefs.Count-1)
                    then sql[sql.Count-1] := sql[sql.Count-1] + ' ,';

                  if cbGen.Checked and
                     ((ds.FieldDefs[j].FieldClass.InheritsFrom(TAutoIncField)) or
                      (linc and FAutoIncFields.Find(lst[i], ds.FieldDefs[j].Name)))
                    then ainc.Add(ds.FieldDefs[j].Name);
                end;
              except
                on E: Exception do
                begin
                  Inc(ErrCnt);
                  sql.Add(Format('/* !!! Error: %s */', [E.Message]));
                end;
              end;
            finally
              if (not lOpen) and bdeTable.Active
                then bdeTable.Close;
            end;
            sql.Add(');');
            sql.Add('');

            lind := False;
            if cbIndexes.Checked then
            begin
              for j := 0 to ind.Count-1 do
              begin
                if Length(Trim(ind[j].Fields)) = 0
                  then Continue;
                  
                if not lind then
                begin
                  sql.Add(Format('    /* Indexes for table "%s" */', [lst[i]]));
                  lind := True;
                end;

                if ixExpression in ind[j].Options then
                begin
                  sql.Add(Format('    /* !  Warning: Found Non-Supported Index %s */', [GetIndexDetails(ind[j])]));
                  Inc(CntWrn);
                  continue;
                end;

                if lrefnames.IndexOf(ind[j].Name) <> -1 then
                begin
                  sql.Add(Format('    /* Found Non-Supported Index %s - This Index Will Be Created By Referential Integrity Constraint */', [GetIndexDetails(ind[j])]));
                  continue;
                end;

                sql.Add(Format('    /* Found Index %s */', [GetIndexDetails(ind[j])]));

                if ixCaseInsensitive in ind[j].Options then
                begin
                  sql.Add(Format('    /* !  Warning: Found Non-Supported Option ixCaseInsensitive For Index %s */', [GetIndexDetails(ind[j])]));
                  Inc(CntWrn);
                end;

                sext.Clear;
                sext.Text := StringReplace(ind[j].Fields, ';', #13#10, [rfReplaceAll]);
                SetLength(tmp, 0);
                while sext.Count > 1 do
                begin
                  tmp := tmp + GetIBName(sext[0]) + ',';
                  sext.Delete(0);
                end;
                if sext.Count > 0
                  then tmp := tmp + GetIBName(sext[0]);

                if ixPrimary in ind[j].Options then
                begin
                  if ind[j].Name = ''
                    then str := GetUnicInd(lst2[i] + '_PRIMARY', lst2[i], idxs, sext, sql)
                    else str := GetUnicInd(ind[j].Name, lst2[i], idxs, sext, sql);
                  str := Format('    ALTER TABLE %s ADD CONSTRAINT %s PRIMARY KEY (%s);',
                                [AIBTable, str, tmp]);
                end
                else
                begin
                  str := '    CREATE ';
                  if ixUnique in ind[j].Options
                    then str := str + 'UNIQUE ';
                  if ixDescending in ind[j].Options
                    then str := str + 'DESCENDING ';
                  if ind[j].Name = ''
                    then str := str + 'INDEX ' + GetUnicInd('PRIMARY'+lst2[i], lst2[i], idxs, sext, sql)
                    else str := str + 'INDEX ' + GetUnicInd(ind[j].Name, lst2[i], idxs, sext, sql);
                  str := str + ' ON ' + AIBTable + ' ' + tmp + ';';
                end;
                sql.Add(str);
              end;
              if lind
                then sql.Add('');
            end;

            if cbGen.Checked and (ainc.Count > 0) then
            begin
              SetLength(str, 0);
              for j := 0 to ainc.Count-1 do
              begin
                if SrcQuoteFields
                  then AFieldName := GetSQLName(ainc[j], SrcType, SrcSelect)
                  else AFieldName := ainc[j];
                str := Format('%s max(%s.%s)',
                              [str, GetSQLName(lst[i], SrcType, SrcSelect), AFieldName]);
                if j <> (ainc.Count-1)
                  then str := str + ' ,';
              end;

              str := Format('SELECT %s FROM %s', [str, GetSQLName(lst[i], SrcType, SrcSelect)]);

              dsQ.Close;

              case SrcType of
                pdtBDE: bdeQuery.SQL.Text := str;
                pdtADO: adoQuery.SQL.Text := str;
              else
                raise Exception.Create(ErrSrc);
              end;

              dsQ.Open;
          
              if not dsQ.IsEmpty then
              begin
                sql.Add('    /* Generators for AutoInc fields for table "' + lst[i] +'" */');
                sql.Add(Format('    /* %s */', [str]));
                sql.Add('');

                for j := 0 to ainc.Count-1 do
                begin
                  try
                    str := GetIBName('GEN_' + lst2[i] + '_' + ainc[j]);
                    sql.Add(Format('    CREATE GENERATOR %s;', [str]));
                    sql.Add(Format('        SET GENERATOR %s TO %d;', [str, dsQ.Fields[j].AsInteger]));
                  except
                    on E: Exception do
                    begin
                      Inc(ErrCnt);
                      sql.Add(Format('/* !!! Error: %s */', [E.Message]));
                    end;
                  end;
                end;

                sql.Add('');
                sql.Add('    SET TERM ^;');
                str := GetIBName('TRIG_' + lst2[i] +  '_BI');
                sql.Add(Format('    CREATE TRIGGER %s FOR %s BEFORE INSERT',
                               [str, AIBTable]));
                sql.Add('    AS BEGIN');
                for j := 0 to ainc.Count-1 do
                begin
                  str := GetIBName('GEN_' + lst2[i] + '_' + ainc[j]);
                  tmp := GetIBName(ainc[j]);
                  sql.Add(Format('      IF(NEW.%s IS NULL) THEN NEW.%s = GEN_ID(%s,1);',
                                 [tmp, tmp, str]));
                end;
                sql.Add('    END ^');
                sql.Add('    SET TERM ;^');
                sql.Add('');
              end;
            end;
          end;
        except
          on E: Exception do
          begin
            Inc(ErrCnt);
            sql.Add(Format('/* !!! Error: %s */', [E.Message]));
          end;
        end;
      finally
        Inc(ErrCnt, ErrRefs);

        if lrefs.Count > 0 then
        begin
          sql.Add('/* Referential Integrity Constraints */');
          sql.Add('');
          sql.AddStrings(lrefs);
          sql.Add('');
        end;

        if llangs.Count > 0 then
        begin
          if llangs.Count > 1 then
          begin
            sql.Add('/* !  Warning: This database has tables with following different languages: ');
            sql.Add('(');
            sql.AddStrings(llangs);
            sql.Add(')');
            sql.Add('To support original functionality you will need to setup proper CHARACTER SET and COLLATION options for all tables with different languages.');
            sql.Add('Please see your server documentation for more information about CHARACTER SET and COLLATION options. */');
            Inc(CntWrn);
          end
          else
          begin
            sql.Add('/* !  Note: This database uses only one language:');
            sql.AddStrings(llangs);
            sql.Add('To support original functionality you probably need to setup proper DEFAULT CHARACTER SET option for CREATE DATABASE statement.');
            sql.Add('Please see your server documentation for more information about DEFAULT CHARACTER SET option and CREATE DATABASE statement */');
          end;
        end;

        if (CntWrn > 0) or (ErrCnt > 0)
          then sql.Add('');

        if CntWrn > 0
          then sql.Add(Format('/* !  Warnings - %d */', [CntWrn]));

        if ErrCnt > 0
          then sql.Add(Format('/* !!! Errors - %d */', [ErrCnt]));

        sql.SaveToFile(eFile.Text);
        lst.Free;
        lst2.Free;
        sql.Free;
        sext.Free;
        idxs.Free;
        ainc.Free;
        lrefs.Free;
        lrefnames.Free;
        llangs.Free;
      end;
    finally
      Self.Caption := sCap;

      lst := TStringList.Create;
      try
        case SrcType of
          pdtBDE:
            begin
              infSrc := FMain.GetBDEAliasInfo(bdeDb, lst);
              bdeDb.Connected := False;
            end;
          pdtADO:
            begin
              infSrc := FMain.GetADOConnectionInfo(adoDb, lst);
              adoDb.Connected := False;
            end;
        else
          raise Exception.Create(ErrSrc);
        end;

{$IFDEF CCNEWS}
        CheckForNews(FMain.FCCNews, infSrc, 'SQL/', k, ErrCnt)
{$ENDIF}        
      finally
        lst.Free;
      end;

      if ErrCnt = 0
        then PumpDlg('All Fine!')
        else PumpDlg('Errors - ' + IntToStr(ErrCnt) + #13 + ibpMain.ErrSelect, mtError);

      if FileExists(eFile.Text) then
      begin
        ShellExecute(Self.Handle,
                     'open',
                     PChar('notepad.exe'),
                     PChar(eFile.Text),
                     nil,
                     SW_SHOWNORMAL);
      end;
    end;
  end;
end;

function TibpGenSql.GetIBName(AName: string): string;
begin
  SetLength(result, 0);
  if cbConvNames.ItemIndex = 0
    then result := GetPureSqlName(AName)
    else result := AName;

  case cbCase.ItemIndex of
    0: result := AnsiUpperCase(result);
    1: result := AnsiLowerCase(result);
  end;

  result := GetSQLName(result, pdtIB, upDialect.Value-1);
end;

function TibpGenSql.GetIBType(AVar: TFieldDef; ANotNull: boolean = False; PVChk: PTVChk = nil): string;
var
  l: boolean;
  strName: string;
begin
  SetLength(result, 0);

  l := False;

  if (AVar.DataType in [ftString, ftFixedChar, ftWideString]) or
     (AVar.FieldClass.InheritsFrom(TStringField)) then
  begin
    l := True;
    if faFixed in AVar.Attributes then
    begin
      result := Format('%s(%d)', ['CHAR', AVar.Size]);
    end
    else
    begin
      if AVar.Size < udLen.Value
        then result := Format('%s(%d)', [cbTStringFieldS.Text, AVar.Size])
        else result := Format('%s(%d)', [cbTStringFieldL.Text, AVar.Size]);
    end;
  end;

  if AVar.FieldClass.InheritsFrom(TIntegerField) then
  begin
    l := True;
    result := cbTIntegerField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TFloatField) then
  begin
    l := True;
    result := cbTFloatField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TBCDField) then
  begin
    l := True;
    result := cbTBCDField.Text;
    if Pos('Precision', result) > 0
      then result := StringReplace(result, 'Precision', Format('%d', [AVar.Precision]), [rfReplaceAll]);
    if Pos('Decimals', result) > 0
      then result := StringReplace(result, 'Decimals', Format('%d', [AVar.Size]), [rfReplaceAll]);
  end;
  if AVar.FieldClass.InheritsFrom(TLargeintField) then
  begin
    l := True;
    result := cbTLargeintField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TSmallintField) then
  begin
    l := True;
    result := cbTSmallintField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TAutoIncField) then
  begin
    l := True;
    result := cbTAutoIncField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TCurrencyField) then
  begin
    l := True;
    result := cbTCurrencyField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TBooleanField) then
  begin
    l := True;
    if cbBool.ItemIndex = 0
      then result := sBoolDomain
      else result := cbTBooleanField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TDateTimeField) then
  begin
    l := True;
    result := cbTDateTimeField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TDateField) then
  begin
    l := True;
    result := cbTDateField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TTimeField) then
  begin
    l := True;
    result := cbTTimeField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TBlobField) then
  begin
    l := True;
    if AVar.FieldClass.InheritsFrom(TGraphicField)
      then result := cbTGraphicField.Text
      else
        if AVar.FieldClass.InheritsFrom(TMemoField)
          then result := cbTMemoField.Text
          else result := cbTBlobField.Text;
  end;
  if AVar.FieldClass.InheritsFrom(TBinaryField) then
  begin
    l := True;
    result := cbTBinaryField.Text;
  end;

  if not l then
  begin
    result := Format('/* !!! Error: Can not resolve class %s for field %s */', [AVar.ClassName, AVar.Name]);
    exit;
  end;

  if PVChk = nil then
  begin
    if AVar.Required or ANotNull
      then result := Format('%s NOT NULL', [result]);
  end
  else
  begin
    if PVChk.HasDefault
      then result := Format('%s DEFAULT %s', [result ,PVChk.DefValue]);

    if PVChk.Required or ANotNull
      then result := Format('%s NOT NULL', [result]);

    if PVChk.HasMin or PVChk.HasMax then
    begin
      strName := GetIBName(AVar.Name);
      if PVChk.HasMin and PVChk.HasMax
        then result := Format('%s CHECK (%s >= %s AND %s <= %s)', [result ,strName, PVChk.MinValue, strName, PVChk.MaxValue]);
      if PVChk.HasMin and (not PVChk.HasMax)
        then result := Format('%s CHECK (%s >= %s)', [result ,strName, PVChk.MinValue]);
      if (not PVChk.HasMin) and PVChk.HasMax
        then result := Format('%s CHECK (%s <= %s)', [result , strName, PVChk.MaxValue]);
    end;
  end;
end;

function TibpGenSql.GetIndexDetails(id: TIndexDef): string;
var
  i: TIndexOption;
begin
  SetLength(result, 0);

  for i := low(TIndexOption) to high(TIndexOption) do
    if i in id.Options
      then result := Format('%s%s,', [result, DefIndexOption[i]]);
  Delete(result, Length(result), 1);

  if id.Name = ''
    then result := Format('Primary Index For This Table, Options [%s]', [result])
    else result := Format('"%s", Options [%s]', [id.Name, result]);
end;

procedure TibpGenSql.FillPrimFields(slist: TStringList; idn: TIndexDefs);
var
  i: integer;
begin
  slist.Clear;
  for i := 0 to idn.Count-1 do
  begin
    if ixPrimary in idn[i].Options then
    begin
      slist.Text := StringReplace(idn[i].Fields, ';', #13#10, [rfReplaceAll]);
      break;
    end
  end;
end;

function TibpGenSql.GetUnicInd(const AInd, ATable: string; slist, sfields, errs: TStringList): string;
var
  i: integer;
begin
  i := slist.IndexOf(AInd);
  if i <> -1
    then slist.Objects[i] := Pointer(Integer(slist.Objects[i]) + 1)
    else i := slist.AddObject(AInd, nil);

  if slist.Objects[i] = nil then
  begin
    result := GetIBName(slist[i]);
  end
  else
  begin
    case cbDupInd.ItemIndex of
      0: result := GetIBName(slist[i] + IntToStr(Integer(slist.Objects[i])));
      1: result := GetIBName(ATable + '_' + slist[i]);
      2: result := GetIBName(ATable + '_' + StringReplace(Trim(sfields.Text), #13#10, '_', [rfReplaceAll]));
    end;
    errs.Add(Format('    /* !  Warning: Duplicated Index Name Found - %s , Replaced To %s */', [AInd, result]));
    Inc(CntWrn);
  end;
end;

procedure TibpGenSql.btnFileClick(Sender: TObject);
begin
  if TCustomEdit(Sender) = eFile then
  begin
    sd.Filter := 'SQL script files (*.sql)|*.sql';
    sd.DefaultExt := 'sql';
    sd.FileName := TCustomEdit(Sender).Text;
  end
  else
  begin
    sd.Filter := 'Interbase / Firebird (*.gdb)|*.gdb|Interbase 7.x (*.ib)|*.ib|All Files (*.*)|*.*';
    sd.DefaultExt := 'gdb';
    sd.FileName := TCustomEdit(Sender).Text;
  end;
  if sd.Execute
    then TCustomEdit(Sender).Text := sd.FileName;
end;

procedure TibpGenSql.upDialectChange(Sender: TObject);
begin
  SetDialect;
end;

procedure TibpGenSql.btnNewProfileClick(Sender: TObject);
begin
  RestDefs;
  FAutoIncFields.lvFields.Items.Clear;
end;

procedure TibpGenSql.cbBoolChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = 0 then
  begin
    cbTBooleanField.Items.Clear;
    cbTBooleanField.Items.Add('CREATE DOMAIN T_YESNO AS CHAR(1) DEFAULT ''N'' CHECK((VALUE IS NULL) OR (VALUE IN (''N'',''Y'')));');
    cbTBooleanField.Items.Add('CREATE DOMAIN T_YESNO AS SMALLINT DEFAULT 0 CHECK((VALUE IS NULL) OR (VALUE IN (''0'',''1'')));');
  end
  else
  begin
    cbTBooleanField.Items.Clear;
    cbTBooleanField.Items.Add('CHAR(1)');
    cbTBooleanField.Items.Add('SMALLINT');
    cbTBooleanField.Items.Add('BOOLEAN');
  end;
  cbTBooleanField.ItemIndex := 0;
end;

procedure TibpGenSql.SetDialect;
begin
  cbConvNames.Items.Clear;
  cbConvNames.Items.Add('to classic format (remove all symbols except ''A''..''Z'', ''a''..''z'', ''0''..''9'', ''$'', ''_'')');
  cbTDateField.Items.CommaText := 'DATE';
  if upDialect.Value <> 1 then
  begin
    cbTLargeintField.Items.CommaText := 'NUMERIC(18),INTEGER';
    cbTDateTimeField.Items.CommaText := 'TIMESTAMP';
    cbTTimeField.Items.CommaText := 'TIME';
    cbConvNames.Items.Add('leave it as it is');
  end
  else
  begin
    cbTLargeintField.Items.CommaText := 'INTEGER';
    cbTDateTimeField.Items.CommaText := 'DATE';
    cbTTimeField.Items.CommaText := 'DATE';
  end;
  cbTLargeintField.Text := cbTLargeintField.Items[0];
  cbTDateTimeField.Text := cbTDateTimeField.Items[0];
  cbTDateField.Text := cbTDateField.Items[0];
  cbTTimeField.Text := cbTTimeField.Items[0];
  cbConvNames.ItemIndex := 0;
end;

procedure TibpGenSql.RestDefs(AEmptyOnly: boolean = False);
var
  i: integer;
  tmpCB: TComboBox;
begin
  if not AEmptyOnly then
  begin
    eFile.Text := ExtractFilePath(Application.Exename) + 'convbde.sql';
    eDatabase.Text := ExtractFilePath(Application.Exename) + 'convbde.gdb';
    upDialect.Value := 3;
    udLen.Value := 5;
    cbIndexes.Checked := True;
    cbGen.Checked := True;

    cbDefaults.Visible := FMain.SrcType = pdtBDE;
    cbDefaults.Checked := True;
    cbRefs.Visible := FMain.SrcType = pdtBDE;
    cbRefs.Checked := True;
    cbLang.Visible := FMain.SrcType = pdtBDE;
    cbLang.Checked := True;
  end;

  for i := 0 to Self.ComponentCount-1 do
  begin
    if (Self.Components[i] is TComboBox) then
    begin
      tmpCB := TComboBox(Self.Components[i]);
      if (not AEmptyOnly) or
         (AEmptyOnly and (Length(tmpCB.Text) = 0)) then
      begin
        if tmpCB.Style = csDropDownList
          then tmpCB.ItemIndex := 0
          else tmpCB.Text := tmpCB.Items[0];
        if Assigned(tmpCB.OnChange)
          then tmpCB.OnChange(tmpCB);
      end;
    end;
  end;
end;

procedure TibpGenSql.btnAutoIncDefineClick(Sender: TObject);
begin
  FAutoIncFields.ShowModal;
end;

procedure TibpGenSql.btnHelpClick(Sender: TObject);
begin
  FMain.btnHelpClick(nil);
end;

procedure TibpGenSql.btnLoadProfileClick(Sender: TObject);
var
  fs: TFileStream;
  oldCur: TCursor;
  li: TListItem;
  i: integer;
begin
  if odProfile.Execute then
  begin
    oldCur := Screen.Cursor;
    try
      Screen.Cursor := crHourGlass;
      fs := TFileStream.Create(odProfile.FileName, fmOpenRead);
      try
        FSettings.Clear;
        try
          fs.ReadComponent(FSettings);
        except
          if FSettings.ProfileVer <> CurrProfileVer
            then FMain.PumpDlg(Format('Profile should be version %d or older (v %d found)!', [CurrProfileVer, FSettings.ProfileVer]), mtError)
            else FMain.PumpDlg('Wrong profile format detected!', mtError);
          exit;
        end;
        with FSettings do
        begin
          eFile.Text := ScriptName;
          eDatabase.Text := DatabaseName;
          upDialect.Value := Dialect;
          cbConvNames.ItemIndex := ConvNames;
          cbCase.ItemIndex := FieldCase;
          cbCharSet.ItemIndex := CharSet;
          cbIndexes.Checked := CopyInd;
          cbGen.Checked := GreateGen;
          udLen.Value := StrLen;
          cbTStringFieldS.Text := CharName;
          cbTStringFieldL.Text := VarcharName;
          cbTIntegerField.Text := IntegerName;
          cbTFloatField.Text := FloatName;
          cbTBCDField.Text := BCDName;
          cbTLargeintField.Text := LargeintName;
          cbTSmallintField.Text := SmallintName;
          cbBool.ItemIndex := BooleanInd;
          cbTBooleanField.Text := BooleanName;
          cbTCurrencyField.Text := CurrencyName;
          cbTAutoIncField.Text := AutoIncName;
          cbTBlobField.Text := BlobName;
          cbTDateTimeField.Text := DatetimeName;
          cbTDateField.Text := DateName;
          cbTTimeField.Text := TimeName;
          cbTBinaryField.Text := BinaryName;
          FAutoIncFields.cbInt.Checked := ShowAllFields;
          cbDefaults.Checked := Defaults;
          cbRefs.Checked := Refs;
          cbTMemoField.Text := MemoName;
          cbTGraphicField.Text := GraphName;
          cbDupInd.ItemIndex := DupInd;
          cbLang.Checked := LangInfo;
        end;

        FAutoIncFields.lvFields.Items.Clear;
        for i := 0 to FSettings.Fields.Count-1 do
        begin
          li := FAutoIncFields.lvFields.Items.Add;
          li.Caption := FSettings.Fields[i];
          li.SubItems.Add(FSettings.Values[i]);
        end;
      finally
        fs.Free;
        FSettings.Clear;
      end;
      RestDefs(True);
    finally
      Screen.Cursor := oldCur;
    end;
  end;
end;

procedure TibpGenSql.btnSaveProfileClick(Sender: TObject);
var
  fs: TFileStream;
  oldCur: TCursor;
  i: integer;
begin
  if sdProfile.Execute then
  begin
    oldCur := Screen.Cursor;
    try
      Screen.Cursor := crHourGlass;
      fs := TFileStream.Create(sdProfile.FileName, fmCreate);
      try
        FSettings.Clear;
        with FSettings do
        begin
          ProfileVer := CurrProfileVer;
          ScriptName := eFile.Text;
          DatabaseName := eDatabase.Text;
          Dialect := upDialect.Value;
          ConvNames := cbConvNames.ItemIndex;
          FieldCase := cbCase.ItemIndex;
          CharSet := cbCharSet.ItemIndex;
          CopyInd := cbIndexes.Checked;
          GreateGen := cbGen.Checked;
          StrLen := udLen.Value;
          CharName := cbTStringFieldS.Text;
          VarcharName := cbTStringFieldL.Text;
          IntegerName := cbTIntegerField.Text;
          FloatName := cbTFloatField.Text;
          BCDName := cbTBCDField.Text;
          LargeintName := cbTLargeintField.Text;
          SmallintName := cbTSmallintField.Text;
          BooleanInd := cbBool.ItemIndex;
          BooleanName := cbTBooleanField.Text;
          CurrencyName := cbTCurrencyField.Text;
          AutoIncName := cbTAutoIncField.Text;
          BlobName := cbTBlobField.Text;
          DatetimeName := cbTDateTimeField.Text;
          DateName := cbTDateField.Text;
          TimeName := cbTTimeField.Text;
          BinaryName := cbTBinaryField.Text;
          ShowAllFields := FAutoIncFields.cbInt.Checked;
          Defaults := cbDefaults.Checked;
          Refs := cbRefs.Checked;
          MemoName := cbTMemoField.Text;
          GraphName := cbTGraphicField.Text;
          DupInd := cbDupInd.ItemIndex;
          LangInfo := cbLang.Checked;
        end;

        for i := 0 to FAutoIncFields.lvFields.Items.Count-1 do
        begin
          FSettings.Fields.Add(FAutoIncFields.lvFields.Items[i].Caption);
          FSettings.Values.Add(FAutoIncFields.lvFields.Items[i].SubItems[0]);
        end;

        fs.WriteComponent(FSettings);
      finally
        fs.Free;
        FSettings.Clear;
      end;
    finally
      Screen.Cursor := oldCur;
    end;
  end;  
end;

{
source http://info.borland.com/devsupport/bde/bdeapiex/dbiopenvchklist.html
}

function HasVChk(Table: TTable; Field: TField; var VChk: TVChk; const ADefTrue: string = 'T'; const ADefFalse: string = 'F'): boolean;

  function ValToStr(VCHK: DBIVCHK; FldType: word): string;
  var
    B: Boolean;
    D: Double;
    L: longint;
    I: Int64;
    S: SmallInt;
    MyDate: BDE.DBIDATE;
    MyTime: BDE.Time;
    MyBcd: BDE.FMTBcd;
    Hour, Minute, MSecond: Word;
    MyTS: BDE.TimeStamp;
    W1: word;
    W2: longword;
    Month, Day: word;
    Year: Smallint;
  begin
    case FldType of
      fldZSTRING: Result := Format('''%s''', [PChar(@VCHK)]);
      fldFLOAT:
        begin
          Move(VCHK, D, sizeof(D));
          Result := FloatToStr(D);
        end;
      fldBCD:
        begin
          Move(VCHK, MyBcd, sizeof(MyBcd));
          DbiBcdToFloat(MyBcd, D);
          Result := FloatToStr(D);
        end;
      fldINT64, fldUINT64:
        begin
          Move(VCHK, I, sizeof(I));
          Result := IntToStr(I);
        end;
      fldUINT32:
        begin
          Move(VCHK, W2, sizeof(W2));
          Result := IntToStr(W2);
        end;
      fldINT32:
        begin
          Move(VCHK, L, sizeof(L));
          Result := IntToStr(L);
        end;
      fldINT16:
        begin
          Move(VCHK, S, sizeof(S));
          Result := IntToStr(S);
        end;
      fldUINT16:
        begin
          Move(VCHK, W1, sizeof(W1));
          Result := IntToStr(W1);
        end;
      fldDATE:
        begin
          Move(VCHK, MyDate, sizeof(MyDate));
          if MyDate < 0 then
            Result := '''TODAY'''
          else
          begin
            Check(DbiDateDecode(MyDate, Month, Day, Year));
            Result := Format('''%s''', [FormatDateTime('DD-MMM-YYYY',EncodeDate(Year, Month, Day))]);
          end;
        end;
      fldTIME:
        begin
          Move(VCHK, MyTime, sizeof(MyTime));
          if MyTime < 0 then
            Result := '''NOW'''
          else
          begin
            Check(DbiTimeDecode(MyTime, Hour, Minute, MSecond));
            Result := Format('''%d:%d:%d''', [Hour, Minute, MSecond div 1000])
          end;
        end;
      fldTIMESTAMP:
        begin
          Move(VCHK, MyTS, sizeof(MyTS));
          if MyTS = 0 then
            Result := '''NOW'''
          else
          begin
            Check(DbiTimeStampDecode(MyTS, MyDate, MyTime));
            Check(DbiDateDecode(MyDate, Month, Day, Year));
            Check(DbiTimeDecode(MyTime, Hour, Minute, MSecond));
            Result := Format('%d:%d:%d', [Hour, Minute, MSecond div 1000]);
            Result := Format('''%s %s''', [FormatDateTime('DD-MMM-YYYY',EncodeDate(Year, Month, Day)), result]);
          end;
        end;
      fldBOOL:
        begin
          Move(VCHK, B, sizeof(B));
          if B
            then Result := Format('''%s''', [ADefTrue])
            else Result := Format('''%s''', [ADefTrue]);
        end;
    end;
  end;

var
  Props: CURProps;
  V: VCHKDesc;
  hCur: hDBICur;
  pField: pFLDDesc;
begin
  Result := False;
  Check(DbiGetCursorProps(Table.Handle, Props));
  if Props.iValChecks > 0 then
  begin
    Check(DbiOpenVChkList(Table.DBHandle, PChar(Table.TableName), Props.szTableType, hCur));
    pField := AllocMem(Props.iFields * sizeof(FLDDesc));
    try
      while DbiGetNextRecord(hCur, dbiNOLOCK, @V, nil) = DBIERR_NONE do
      begin
        if V.iFldNum = Field.Index + 1 then
        begin
          Result := true;
          VChk.Required := V.bRequired;
          VChk.HasDefault := V.bHasDefVal;
          VChk.HasMin := V.bHasMinVal;
          VChk.HasMax := V.bHasMaxVal;
          Check(DbiGetFieldDescs(Table.Handle, pField));
          Inc(pField, Field.Index);
          if VChk.HasDefault
            then VChk.DefValue := ValToStr(V.aDefVal, pField^.iFldType);
          if VChk.HasMin
            then VChk.MinValue := ValToStr(V.aMinVal, pField^.iFldType);
          if VChk.HasMax
            then VChk.MaxValue := ValToStr(V.aMaxVal, pField^.iFldType);
          Dec(pField, Field.Index);
        end;
      end;
    finally
      FreeMem(pField);
      Check(DbiCloseCursor(hCur));
    end;
  end;
end;

{
  source http://info.borland.com/devsupport/bde/bdeapiex/dbiopenrintlist.html
}

function TibpGenSql.GetRintDesc(const TableName: string; Table: TTable; ALines: TStrings; ARefList: TStrings = nil): integer;
var
  lOpen: boolean;
  Lines: TStringList;
  hCur: hDBICur;
  RIDesc: RINTDesc;
  rslt: DBIResult;
  B: Byte;
  FrFields, RefFields, strOnDel, strOnUpd: string;
  tmpBDETable: TTable;

  function GetTableName(ATableName: string): string;
  begin
    if not Table.Database.IsSQLBased then
    begin
      ATableName := ExtractFileName(ATableName);
      ATableName := Copy(ATableName, 1, Length(ATableName) - Length(ExtractFileExt((ATableName))));
    end;
    result := GetIBName(ATableName)
  end;

begin
  result := 0;
  tmpBDETable := TTable.Create(nil);
  Lines := TStringList.Create;
  try
    tmpBDETable.DatabaseName := Table.DatabaseName;
    lOpen := Table.Active;
    try
      if not lOpen
        then Table.Open;
      Check(DbiOpenRIntList(Table.DBHandle, PChar(Table.TableName), nil, hCur));
      try
        Check(DbiSetToBegin(hCur));
        rslt := DBIERR_NONE;
        while rslt = DBIERR_NONE do
        begin
          rslt := DbiGetNextRecord(hCur, dbiNOLOCK, @RIDesc, nil);
          if rslt <> DBIERR_EOF then
          begin
            Check(rslt);
            case RIDesc.eType of
              rintMASTER: exit;
              rintDEPENDENT:;
            else
              Inc(result);
              Lines.Add(Format('/* ! Error: Unknown Type For Constraint %s */', [RIDesc.szRintName]));
            end;

            tmpBDETable.TableName := RIDesc.szTblName;
            tmpBDETable.FieldDefs.Update;

            SetLength(strOnUpd, 0);
            case RIDesc.eModOp of
              rintRESTRICT:;
              rintCASCADE: strOnUpd := ' ON UPDATE CASCADE';
            else
              Inc(result);
              Lines.Add(Format('/* ! Error: Unknown Modify Qualifier For Constraint %s */', [RIDesc.szRintName]));
            end;

            case RIDesc.eDelOp of
              rintRESTRICT:;
              rintCASCADE: strOnDel := ' ON DELETE CASCADE';
            else
              Inc(result);
              Lines.Add(Format('/* ! Error: Unknown Delete Qualifier For Constraint %s */', [RIDesc.szRintName]));
            end;

            SetLength(RefFields, 0);
            for B := 0 to RIDesc.iFldCount - 1 do
              RefFields := RefFields + GetIBName(Table.FieldDefs[Pred(RIDesc.aiThisTabFld[B])].Name) + ', ';
            SetLength(RefFields, Length(RefFields) - 2);

            SetLength(FrFields, 0);
            for B := 0 to RIDesc.iFldCount - 1 do
              FrFields := FrFields + GetIBName(tmpBDETable.FieldDefs[Pred(RIDesc.aiOthTabFld[B])].Name) + ', ';
            SetLength(FrFields, Length(FrFields) - 2);

            Lines.Add(Format('    /* Found Referential Integrity Constraint %s For Table %s */', [RIDesc.szRintName, Table.TableName]));
            Lines.Add(Format('    ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s) REFERENCES %s (%s)%s%s;' ,
                             [TableName, GetIBName(RIDesc.szRintName), RefFields, GetTableName(RIDesc.szTblName), FrFields, strOnDel, strOnUpd]));

            if Assigned(ARefList)
              then ARefList.Add(RIDesc.szRintName);
          end;
        end;
      finally
        Check(DbiCloseCursor(hCur));
      end;
    except
      on E: Exception do
      begin
        Lines.Add(Format('/* !!! Error: Table %s - Unable Get Referential Integrity Info - %s */', [Table.TableName, E.Message]));
        Inc(Result);
      end;
    end;
    if not lOpen
      then Table.Close;
  finally
    if Lines.Count > 0 then
    begin
      ALines.AddStrings(Lines);
      ALines.Add('');
    end;
    Lines.Free;
    tmpBDETable.Free;
  end;
end;

{ Return language driver settings info for given Cursor }

function GetLanguageInfo(hCur: hDBICur): string;
var
  LDName: DBIName;
  Locale: TLocale;
  iCodePage: smallint;
begin
  SetLength(result ,0);
  if DbiGetLdObj(hCur, Pointer(Locale)) = DBIERR_NONE then
  begin
   if (Locale <> nil) then
     if (OsLdGetSymbName(Locale, @LDName) = 0)
       then result := Format('Language Driver: %s', [LDName]); // Name

     if (OsLdGetDescName(Locale, @LDName) = 0)
       then result := Format('%s, Desc.: %s', [result, LDName]); // Desc.

     if OsLdGetCodePage(Locale, iCodePage) = 0
       then result := Format('%s, Code Page: %d', [result, iCodePage]);  // CodePage
  end;
end;

end.

