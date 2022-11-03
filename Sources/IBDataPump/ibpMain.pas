{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ibpMain.pas
}

unit ibpMain;

interface

{$INCLUDE ccGetVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Mask, IBQuery, Db, IBCustomDataSet, IBUpdateSQL,
  Menus, IBDatabase, IBSQL, ImgList, IBHeader, IBDatabaseInfo, ShellApi,
  Dbtables, IBExtract, WinInet, ADODB, Buttons, registry, ActiveX,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
    ibpDM, ibpHelp, ccTreeView, ccSpinEdit, ccButtonEdit{$IFDEF CCNEWS}, clDownLoader{$ENDIF};

type

  { Callback for .dll version }

  TIBDataPumpCallBack = procedure(ARepLine: PChar); stdcall;

  { Tree icons list}

  pmpIcon = (
              picTableNoLinks, picTableLinks, picTableLoop, picSourceFields,
              picSourceField, picDestFields, picDestField, picRelationFields,
              picRelationField, picRefConsts, picRefConst, picRefConstOpt,
              picRefConstForFields, picRefConstForField, picRefConstRefFields,
              picRefConstRefField
             );

{
  picTableNoLinks      - 0
  picTableLinks        - 1
  picTableLoop         - 2
  picSourceFields      - 3
  picSourceField       - 4
  picDestFields        - 5
  picDestField         - 6
  picRelationFields    - 7
  picRelationField     - 8
  picRefConsts         - 9
  picRefConst          - 10
  picRefConstOpt       - 11
  picRefConstForFields - 12
  picRefConstForField  - 13
  picRefConstRefFields - 14
  picRefConstRefField  - 15
}

  { TibPumpStatItem }

  TibPumpStatItem = class(TCollectionItem)
  private
    FName: string;
    FRowsAffected: integer;
    FProcessed: integer;
    FDeleted: integer;
    FErrors: integer;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Name: string read FName write FName;
    property RowsAffected: integer read FRowsAffected write FRowsAffected;
    property Processed: integer read FProcessed write FProcessed;
    property Deleted: integer read FDeleted write FDeleted;
    property Errors: integer read FErrors write FErrors;
  end;

  { TibPumpStatCollection }

  TibPumpStatCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TibPumpStatItem;
    procedure SetItem(Index: Integer; Value: TibPumpStatItem);
  public
    function Add: TibPumpStatItem;
    function GetByName(const AName: string): TibPumpStatItem;
    function FindByName(const AName: string): TibPumpStatItem;

    property Items[Index: Integer]: TibPumpStatItem read GetItem write SetItem; default;
  end;

  { TibpPumpSettings }

  TPumpDatabaseType = (pdtIB, pdtBDE, pdtADO);

  TibpPumpSettings = class(TComponent)
  private
    AVersion: string;
    ASourceClass: string;
    ADestClass: string;

    AsName: string;
    AsUser: string;
    AsPass: string;
    AsRole: string;
    AsChar: integer;
    AsDialect: integer;
    AdName: string;
    AdUser: string;
    AdPass: string;
    AdRole: string;
    AdChar: integer;
    AdDialect: integer;

    ADisableTriggers: boolean;
    AEmptyTables: boolean;
    AUpdateGenerators: boolean;
    AExclusiveAccess: boolean;
    ADeactivateIndexes: boolean;

    AStopOnErrors: boolean;
    AStopAfterErrors: integer;
    ACommitData: boolean;
    ACommitAfterTable: boolean;
    ACommitEvery: integer;
    ACommitStep: boolean;

    AAlias: string;
    ASourceType: TPumpDatabaseType;
    AConvBool: boolean;
    ABoolTrue: string;
    ABoolFalse: string;
    AChCase: boolean;
    ASpace: boolean;
    ASrcSelect: integer;
    ASrcQuoteFields: boolean;
    ATruncString: boolean;
    ARemSpace: boolean;
    ARemSpaceOpt: integer;
    AOffLoop: boolean;
    AConnectionString: string;
    ASaveReportTo: string;
  public
    procedure Clear;
  published
    property Version: string read AVersion write AVersion;
    property SourceClass: string read ASourceClass write ASourceClass;
    property DestClass: string read ADestClass write ADestClass;
    property sName: string read AsName write AsName;
    property sUser: string read AsUser write AsUser;
    property sPass: string read AsPass write AsPass;
    property sRole: string read AsRole write AsRole;
    property sChar: integer read AsChar write AsChar;
    property sDialect: integer read AsDialect write AsDialect;
    property dName: string read AdName write AdName;
    property dUser: string read AdUser write AdUser;
    property dPass: string read AdPass write AdPass;
    property dRole: string read AdRole write AdRole;
    property dChar: integer read AdChar write AdChar;
    property dDialect: integer read AdDialect write AdDialect;

    property DisableTriggers: boolean read ADisableTriggers write ADisableTriggers;
    property EmptyTables: boolean read AEmptyTables write AEmptyTables;
    property UpdateGenerators: boolean read AUpdateGenerators write AUpdateGenerators;
    property ExclusiveAccess: boolean read AExclusiveAccess write AExclusiveAccess;
    property DeactivateIndexes: boolean read ADeactivateIndexes write ADeactivateIndexes;

    property StopOnErrors: boolean read AStopOnErrors write AStopOnErrors;
    property StopAfterErrors: integer read AStopAfterErrors write AStopAfterErrors;
    property CommitData: boolean read ACommitData write ACommitData;
    property CommitAfterTable: boolean read ACommitAfterTable write ACommitAfterTable;
    property CommitEvery: integer read ACommitEvery write ACommitEvery;

    property Alias: string read AAlias write AAlias;
    property SourceType: TPumpDatabaseType read ASourceType write ASourceType;
    property ConvBool: boolean read AConvBool write AConvBool;
    property BoolTrue: string read ABoolTrue write ABoolTrue;
    property BoolFalse: string read ABoolFalse write ABoolFalse;
    property ChCase: boolean read AChCase write AChCase;
    property Space: boolean read ASpace write ASpace;
    property SrcSelect: integer read ASrcSelect write ASrcSelect;
    property SrcQuoteFields: boolean read ASrcQuoteFields write ASrcQuoteFields;
    property TruncString: boolean read ATruncString write ATruncString;
    property RemSpace: boolean read ARemSpace write ARemSpace;
    property RemSpaceOpt: integer read ARemSpaceOpt write ARemSpaceOpt;
    property OffLoop: boolean read AOffLoop write AOffLoop;
    property ConnectionString: string read AConnectionString write AConnectionString;
    property SaveReportTo: string read ASaveReportTo write ASaveReportTo;
  end;

  { TibpMain }

  TibpMain = class(TForm)
    Pages: TPageControl;
    tsDatabases: TTabSheet;
    tsOrder: TTabSheet;
    pBottom: TPanel;
    eSUserName: TEdit;
    eSPassword: TEdit;
    lSourceDatabase: TLabel;
    lSUserName: TLabel;
    lSPassword: TLabel;
    lSDialect: TLabel;
    btnSTest: TButton;
    Bevel1: TBevel;
    eDUserName: TEdit;
    eDPassword: TEdit;
    lDestDatabase: TLabel;
    lDUserName: TLabel;
    lDPassword: TLabel;
    lDDialect: TLabel;
    btnDTest: TButton;
    Bevel2: TBevel;
    llSourceDatabaseProperties: TLabel;
    llDestDatabaseProperties: TLabel;
    cbDisableTriggers: TCheckBox;
    cbEmpty: TCheckBox;
    cbUpdateGenerators: TCheckBox;
    btnClose: TButton;
    pRight: TPanel;
    qryDep: TIBQuery;
    updDep: TIBUpdateSQL;
    pmDest: TPopupMenu;
    ExpandAll1: TMenuItem;
    CollapseAll1: TMenuItem;
    GetCount1: TMenuItem;
    GetNodeChildsCount1: TMenuItem;
    tsPump: TTabSheet;
    Panel1: TPanel;
    btnStartPump: TButton;
    memRep: TMemo;
    qryDest: TIBSQL;
    qrySource: TIBSQL;
    Trans: TIBTransaction;
    ilImages: TImageList;
    btnGetDfn: TButton;
    qryDefsFields: TIBSQL;
    btnBuildRelations: TButton;
    ClearLinkForSelectedTable1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    lSteps: TLabel;
    lStep1: TLabel;
    lStep2: TLabel;
    DeleterRelation1: TMenuItem;
    cbStopErr: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lCommitEvery: TLabel;
    cbCommitEvery: TCheckBox;
    btnSaveProfile: TButton;
    btnLoadProfile: TButton;
    btnNewProfile: TButton;
    op: TOpenDialog;
    sd: TSaveDialog;
    lStep3: TLabel;
    lStep3Desck: TLabel;
    btnAbout: TButton;
    btnHelp: TButton;
    lsRole: TLabel;
    eSRole: TEdit;
    lsCharacterSet: TLabel;
    cbSCharSet: TComboBox;
    Label5: TLabel;
    eDRole: TEdit;
    Label6: TLabel;
    cbDCharSet: TComboBox;
    qryDestFK: TIBSQL;
    DestInfo: TIBDatabaseInfo;
    cbLoop: TCheckBox;
    lLoop: TLabel;
    Label8: TLabel;
    qryDestComp: TIBSQL;
    PageObj: TPageControl;
    tsTables: TTabSheet;
    tsGenerators: TTabSheet;
    pSource: TPanel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    Panel5: TPanel;
    Splitter1: TSplitter;
    N3: TMenuItem;
    SelectAll1: TMenuItem;
    UnselectAll1: TMenuItem;
    Invert1: TMenuItem;
    cbBde: TComboBox;
    cbAlias: TComboBox;
    bdeQuery: TQuery;
    cbBool: TCheckBox;
    lBoolFalse: TLabel;
    lBoolTrue: TLabel;
    eBoolTrue: TEdit;
    eBoolFalse: TEdit;
    cbCase: TCheckBox;
    cbSpace: TCheckBox;
    btnGenSql: TButton;
    cbSrcSelect: TComboBox;
    lSelectOpt: TLabel;
    gdbop: TOpenDialog;
    AddConstant1: TMenuItem;
    EditConstantExpressrion1: TMenuItem;
    bdeTable: TTable;
    pDBDEst: TPanel;
    Label11: TLabel;
    pDBDestT: TPanel;
    Label12: TLabel;
    pDBSource: TPanel;
    Label10: TLabel;
    pDBSourceT: TPanel;
    Label9: TLabel;
    SrcInfo: TIBDatabaseInfo;
    PropPage: TPageControl;
    tsPumpProp: TTabSheet;
    tsBuildPage: TTabSheet;
    tsStringPage: TTabSheet;
    cbTruncString: TCheckBox;
    cbRemSpace: TCheckBox;
    cbRemSpaceOpt: TComboBox;
    qryDefGens: TIBSQL;
    N4: TMenuItem;
    NewSQL1: TMenuItem;
    ViewEditSQL1: TMenuItem;
    DeleteSQL1: TMenuItem;
    qryFields: TIBQuery;
    btnUpdateDef: TButton;
    adoTable: TADOTable;
    adoQuery: TADOQuery;
    cbSrcQuoteFields: TCheckBox;
    btnGet: TBitBtn;
    stNews: TStaticText;
    qryIBDest: TIBQuery;
    N5: TMenuItem;
    CustomSQLWizard1: TMenuItem;
    Label4: TLabel;
    OpenReportDialog: TOpenDialog;
    pStepThreeBottom: TPanel;
    lblBoolTrue: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSTestClick(Sender: TObject);
    procedure btnDTestClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure PagesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure ExpandAll1Click(Sender: TObject);
    procedure CollapseAll1Click(Sender: TObject);
    procedure GetCount1Click(Sender: TObject);
    procedure GetNodeChildsCount1Click(Sender: TObject);
    procedure btnStartPumpClick(Sender: TObject);
    procedure btnGetDfnClick(Sender: TObject);
    procedure btnBuildRelationsClick(Sender: TObject);
    procedure tvDestInfoCustomDraw(Sender: TObject;
      TreeNode: TccTreeNode; AFont: TFont; var AColor, ABkColor: TColor);
    procedure ClearLinkForSelectedTable1Click(Sender: TObject);
    procedure pmDestPopup(Sender: TObject);
    procedure tvDestStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure tvDestDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvDestDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvDestCustomDraw(Sender: TObject; TreeNode: TccTreeNode;
      AFont: TFont; var AColor, ABkColor: TColor);
    procedure tvDestDblClick(Sender: TObject);
    procedure DeleterRelation1Click(Sender: TObject);
    procedure btnSaveProfileClick(Sender: TObject);
    procedure btnLoadProfileClick(Sender: TObject);
    procedure btnNewProfileClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure SetDefSettings;
    procedure tvDestTrDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvDestTrDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvDestTrDblClick(Sender: TObject);
    procedure tvSourceDblClick(Sender: TObject);
    procedure tvSourceTrDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tvSourceCustomDraw(Sender: TObject; TreeNode: TccTreeNode;
      AFont: TFont; var AColor, ABkColor: TColor);
    procedure SelectAll1Click(Sender: TObject);
    procedure cbBdeChange(Sender: TObject);
    procedure btnGenSqlClick(Sender: TObject);
    procedure eSourceDatabaseButtonClick(Sender: TObject);
    procedure AddConstant1Click(Sender: TObject);
    procedure EditConstantExpressrion1Click(Sender: TObject);
    procedure tvDestTrInfoCustomDraw(Sender: TObject;
      TreeNode: TccTreeNode; AFont: TFont; var AColor, ABkColor: TColor);
    procedure tvDestMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NewSQL1Click(Sender: TObject);
    procedure ViewEditSQL1Click(Sender: TObject);
    procedure DeleteSQL1Click(Sender: TObject);
    procedure btnUpdateDefClick(Sender: TObject);
    procedure eADOSourceButtonClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure CustomSQLWizard1Click(Sender: TObject);
    procedure ccSaveReportButtonClick(Sender: TObject);
  private
    FSrcType: TPumpDatabaseType;
    ErrCnt: integer;
    CmtCnt: integer;
    ibpstore: TibpPumpSettings;
    rep: TStringList;
    IsWin95: boolean;
    OldException: TExceptionEvent;
    FDM: TibpDM;
    FStat: TibPumpStatCollection;

    // ccCompos
    upDestDialect: TccSpinEdit;
    upErrCnt: TccSpinEdit;
    upCommit: TccSpinEdit;
    upSrcDialect: TccSpinEdit;
    eADOSource: TccButtonEdit;
    ccSaveReport: TccButtonEdit;

    procedure SetView;
    procedure DelDep(const AName: string);
    procedure FillFK(tn: TccTreeNode);
    procedure EmptyTables;
    procedure AlterTriggers(lOn: boolean);
    function UpdateGenerators: integer;
    function CheckValues: boolean;
    procedure AlterConst(lOn: boolean);
    function GetNameLst(tn: TccTreeNode; AType: TPumpDatabaseType; ASQLDialect: integer): string;

    procedure FillDestDef;
    procedure FillSourceDef;
    procedure FillSourceDefDataset;
    procedure AutoSet;
    procedure CleanSourceTable(tn: TccTreeNode);
    procedure GetUserInfo(Sender: TObject; var AUserName, APassword: string);

    procedure RepStart;
    procedure RepStop;
    procedure RepLine(const str: string);
    procedure RepStr(lst: TStrings);
    procedure ShowStats;
    procedure AppException(Sender: TObject; E: Exception);
    procedure EditConstExpr(ANode: TccTreeNode);
    procedure DoPumpString(const SrcStr: string; const xDest: TIBXSQLVAR; ASize: integer);
    procedure DeleteSrcTableLinks(const ATableName: string);
    procedure AddEditCustomSQL(ATree: TccTreeView; tn: TccTreeNode);
    function GetSrcDialect: integer;
    procedure SetSrcDialect(Value: integer);
    function GetDestDialect: integer;
    procedure SetDestDialect(Value: integer);
    function GetSrcSelect: integer;
    procedure SetSrcSelect(Value: integer);
    function GetSrcQuoteFields: boolean;
    procedure SetSrcQuoteFields(Value: boolean);
{$IFDEF CCNEWS}
    procedure OnCCNews(Sender: TObject; Text: TStrings);
    procedure WaitForSubmission(ADnl: TclDownLoader);
    procedure StopTimer(Sender: TObject);
{$ENDIF}
  public
{$IFDEF CCNEWS}
    FCCNews: TclDownLoader;
{$ENDIF}

    // ccCompos
    tvSource: TccTreeView;
    tvDest: TccTreeView;
    tvSourceTr: TccTreeView;
    tvDestTr: TccTreeView;
    eSourceDatabase: TccButtonEdit;
    eDestDatabase: TccButtonEdit;

    function GetSourceDB: string;
    function GetDestDB: string;
    procedure BuildSQL(const ATable: string; ASrcType: TPumpDatabaseType; ASQLDialect: integer; AFields, AItems: TStrings; IsIns: boolean);
    procedure SetSource;
    procedure SetDest;
    function PumpDlg(const Msg: string; DlgType: TMsgDlgType = mtInformation;
                     Buttons: TMsgDlgButtons = [mbOK]; HelpCtx: Longint = 0): Word;
    procedure RestoreCustomSQLFields(AStr: TStringList; ATree: TccTreeView);
    procedure RestoreCustomSQLParams(AStr: TStringList);
    procedure AddCustomSQLFields(const AName: string; tn: TccTreeNode; ATree: TccTreeView; ds: TDataset);
    procedure AddCustomSQLParams(const AName: string; tn: TccTreeNode);
    function GetBDEAliasInfo(ADB: TDatabase; ALst: TStringList): string;
    function GetADOConnectionInfo(AConnection: TADOConnection; ALst: TStringList): string;
    function GetIBAliasInfo(AIBInfo: TIBDatabaseInfo; ALst: TStringList): string;
    function GetFocusedTree: TccTreeView;
    function OpenDataset(ANode: TccTreeNode; AList: TStringList): TDataset;
    procedure DoCommit;

    property DM: TibpDM read FDM;
    property SrcType: TPumpDatabaseType read FSrcType;
    property SrcDialect: integer read GetSrcDialect write SetSrcDialect;
    property DestDialect: integer read GetDestDialect write SetDestDialect;
    property SrcSelect: integer read GetSrcSelect write SetSrcSelect;
    property SrcQuoteFields: boolean read GetSrcQuoteFields write SetSrcQuoteFields;
  end;

  { Common functions }

  procedure DoControlExit(Wnd: HWND = 0);
  function GetSQLName(const AName: string; ASrcType: TPumpDatabaseType; ASQLDialect: integer): string;
  function GetFieldTypeText(AIBExtract: TIBExtract; AIBSQL: TIBSQL): string;
  function FindTheNode(tn: TccTreeNode; AImageIndex: pmpIcon): TccTreeNode;
  function FindSourceTable(tv: TccTreeView; const AName: string;
                           lCase: boolean = False;
                           lSpace: boolean = False;
                           lBDE: boolean = False): TccTreeNode;
  function FindSourceField(tn: TccTreeNode; const AName: string;
                           lInfo: boolean = False;
                           lCase: boolean = False;
                           lSpace: boolean = False): TccTreeNode;
  procedure MakeTableLink(nd, ns: TccTreeNode; lAutoBuild: boolean; lCase: boolean = False; lSpace: boolean = False);
  procedure UpdateFieldsStatus(tn: TccTreeNode);
  function IsConst(const AStr: string): boolean;
  function GetConst(const AStr: string): string;
  function SetConst(const AStr: string): string;
  procedure UpdateStatus(tn: TccTreeNode);
  procedure SetSelInds(ANode: TccTreeNode);
  procedure AssignTree(ASrc, ADest: TccTreeView; lIsDest: boolean = False);


  function InternetConnected: Boolean;
{$IFDEF CCNEWS}
  function CheckForNews(ADnl: TclDownLoader; const infSrc, infDest: string; recTotal, ErrCnt: integer): boolean;
{$ENDIF}  

  { Command-line and .dll call support }

  function DoIBPumpExec(AProfile, ASourceFile, ADestFile: PChar; ACallBack: TIBDataPumpCallBack): integer;
  procedure DoCommandLine;

  { Save last window position and status}

  procedure GetWindStat(AForm: TCustomForm);
  procedure SetWindStat(AForm: TCustomForm);

var
  IsParamMode: boolean = False;
  ParamRes: integer = 0;
  ParamCallBack: TIBDataPumpCallBack = nil;
  ParamFile: string  = '';

const
  arNull: array[boolean] of string = ('Not Null', '');
  arRequired: array[boolean] of string = ('', 'Required');
  PumpMsgDlgType: array[TMsgDlgType] of string = ('Warning', 'Error', 'Information', 'Confirmation', 'Custom');

  AppVersion = '3.5s4';
  AppTitle = 'Interbase DataPump v ';
  AppHome = 'www.CleverComponents.com';
  AppEmail = 'info@CleverComponents.com';
  AppHelp = 'https://www.clevercomponents.com/products/datapump/dp-tour.asp';
  AppNews = 'https://www.clevercomponents.com/checknews/ibdatapump.txt';
  StorageVersion = '3.5';

  ErrSrc = 'Selected Source not supported!';
  ErrSelect = 'Your "Select Option" and "Quote Filed Names" are probably incorrect.' + #13 + #10  +
              'Please go to "Step 1: Databases" set the proper values and try again.';

implementation

uses ibpUpdDefs, ibpSQLEditor, ibpGenSql, ibmUpdWizard;

{$R *.DFM}

{ Save last window position and status}

  type

  { TWindStatRec }

  TWindStatRec = record
    ALeft: integer;
    ATop: integer;
    AWidth: integer;
    AHeight: integer;
    AMaximized: boolean;
  end;
  PTWindStatRec = ^TWindStatRec;

  var
    AWindStatList: TStringList = nil;

  procedure GetWindStat(AForm: TCustomForm);
  var
    i: integer;
    p: PTWindStatRec;
  begin
    if AWindStatList <> nil then
    begin
      i := AWindStatList.IndexOf(AForm.ClassName);
      if i = -1 then
      begin
        p := New(PTWindStatRec);
        p.ALeft := AForm.Left;
        p.ATop := AForm.Top;
        p.AWidth := AForm.Width;
        p.AHeight := AForm.Height;
        p.AMaximized := AForm.WindowState = wsMaximized;
        AWindStatList.AddObject(AForm.ClassName, TObject(p));
      end
      else
      begin
        p := PTWindStatRec(AWindStatList.Objects[i]);
        if p.AMaximized then
        begin
          AForm.WindowState := wsMaximized;
        end
        else
        begin
          AForm.Left := p.ALeft;
          AForm.Top := p.ATop;
          AForm.Width := p.AWidth;
          AForm.Height := p.AHeight;
        end;
        TForm(AForm).Position := poDesigned;
      end;
    end;
  end;

  procedure SetWindStat(AForm: TCustomForm);
  var
    i: integer;
    p: PTWindStatRec;
  begin
    if AWindStatList <> nil then
    begin
      i := AWindStatList.IndexOf(AForm.ClassName);
      if i = -1 then
      begin
        p := New(PTWindStatRec);
        AWindStatList.AddObject(AForm.ClassName, TObject(p));
      end
      else
      begin
        p := PTWindStatRec(AWindStatList.Objects[i]);
      end;
      p.ALeft := AForm.Left;
      p.ATop := AForm.Top;
      p.AWidth := AForm.Width;
      p.AHeight := AForm.Height;
      p.AMaximized := AForm.WindowState = wsMaximized;
    end;
  end;

{ Command-line and .dll call support }

function DoIBPumpExec(AProfile, ASourceFile, ADestFile: PChar; ACallBack: TIBDataPumpCallBack): integer;
var
  FibpMain: TibpMain;
begin
  result := -1;

  CoInitialize(nil);
  try
    ibpMain.IsParamMode := True;
    ibpMain.ParamRes := 0;
    ibpMain.ParamFile := AProfile;
    ibpMain.ParamCallBack := ACallBack;

    FibpMain := TibpMain.Create(Application);
    try
      try
        FibpMain.Pages.ActivePage := FibpMain.tsDatabases;
        if ibpMain.ParamRes <> 0
          then exit;
        FibpMain.btnLoadProfileClick(nil);
        if ibpMain.ParamRes <> 0
          then exit;
        if Length(ASourceFile) > 0 then
        begin
          case FibpMain.SrcType of
            pdtIB: FibpMain.eSourceDatabase.Text := ASourceFile;
            pdtBDE: FibpMain.cbAlias.Text := ASourceFile;
            pdtADO: FibpMain.eADOSource.Text := ASourceFile;
          else
            raise Exception.Create(ErrSrc);
          end;
        end;
        if Length(ADestFile) > 0
          then FibpMain.eDestDatabase.Text:= ADestFile;
        FibpMain.SetSource;
        if ibpMain.ParamRes <> 0
          then exit;
        FibpMain.SetDest;
        if ibpMain.ParamRes <> 0
          then exit;
        FibpMain.Pages.ActivePage :=
          FibpMain.tsPump;
        if ibpMain.ParamRes <> 0
          then exit;
        FibpMain.btnStartPumpClick(nil);
        result := ibpMain.ParamRes;
      except
        on E: Exception do
        begin
          if Assigned(ParamCallBack)
            then ParamCallBack(PChar('!!!EXCEPTION: ' + E.Message));
        end;
      end;
    finally
      FibpMain.Free;
    end;
  finally
    CoUninitialize;
  end;
end;

var
 lstCommandLine: TStringList = nil;
 strCommandLineFileName: string = '';
 fileCommandLine: TextFile;

procedure AddRepLine(ARepLine: PChar); stdcall;
begin
  if lstCommandLine <> nil
    then lstCommandLine.Add(ARepLine);

  if Length(strCommandLineFileName) > 0 then
  begin
    WriteLn(fileCommandLine, ARepLine);
    Flush(fileCommandLine);
  end;
end;

procedure DoCommandLine;
const
  arrInfo: array[0..9] of string = (
    #13 + 'Usage:' + #13,
    '  IBPump.exe ',
    '  "IBDataPump Profile.ipb" ',
    '  [/s="Source File/Alias/Connection String"] ',
    '  [/d="Destion File/Alias/Connection String"] ',
    '  [/o="Output Results File"]' + #13+#13,
    'Examples:' + #13,
    '  IBPump.exe  "d:\MSSQLtoIB.ibp"' + #13,
    '  IBPump.exe  "e:\ACCESStoIB.ibp"  /s="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=e:\GALLERY.MDB"' + #13,
    '  IBPump.exe  "c:\BDEtoIB.ibp"  /s="BDEDEMO"  /d="c:\BDEDEMO.gdb"  /o="c:\results.txt"' );

  arrHelp: array[0..5] of string = ('/H', '/HELP', '/?', '-H', '-?', '?');

var
  AProfile, ASourceFile, ADestFile: string;
  i: integer;
  str: string;

  procedure ShowHowToUse;
  var
    indI: integer;
    strRes: string;
  begin
    strRes := 'Params:'+#13;
    for indI := 1 to ParamCount
      do strRes := strRes + Format('  Param %d="%s"'+#13, [indI, ParamStr(indI)]);
    for indI := Low(arrInfo) to High(arrInfo)
      do strRes := strRes + arrInfo[indI];
    Beep;
    ShowMessage(strRes);
  end;

begin
  SetLength(AProfile, 0);
  SetLength(ASourceFile, 0);
  SetLength(ADestFile, 0);
  SetLength(strCommandLineFileName, 0);

  str := UpperCase(ParamStr(1));
  for i := Low(arrHelp) to High(arrHelp) do
    if str = arrHelp[i] then
    begin
      ShowHowToUse;
      Exit;
    end;

  AProfile := ParamStr(1);

  for i := 2 to ParamCount do
  begin
    str := UpperCase(Copy(ParamStr(i), 1, 3));
    if str = '/S='
      then ASourceFile := Copy(ParamStr(i), 4, Length(ParamStr(i)))
      else
        if str = '/D='
          then ADestFile := Copy(ParamStr(i), 4, Length(ParamStr(i)))
          else
            if str = '/O='
              then strCommandLineFileName := Copy(ParamStr(i), 4, Length(ParamStr(i)))
              else
              begin
                ShowHowToUse;
                Exit;
              end;
  end;

  lstCommandLine := TStringList.Create;
  try
    if Length(strCommandLineFileName) > 0 then
    begin
      try
        AssignFile(fileCommandLine, strCommandLineFileName);
        Rewrite(fileCommandLine);
      except
        on E: Exception do
        begin
          E.Message := Format('Can not create output file "%s" : %s', [strCommandLineFileName, E.Message]);
          raise;
        end;
      end;
    end;
    try
      i := DoIBPumpExec(PChar(AProfile), PChar(ASourceFile), PChar(ADestFile), AddRepLine);

      if (i <> 0) and
         (Length(strCommandLineFileName) = 0) and
         (lstCommandLine.Count > 0) then
      begin
        { Dump all errors into console window }
        AllocConsole;
        try
          for i := 0 to lstCommandLine.Count-1
            do WriteLn(lstCommandLine[i]);
          WriteLn('Press <ENTER> to close console');
          Beep;
          ReadLn;
        finally
          FreeConsole;
        end;
      end;
    finally
      if Length(strCommandLineFileName) > 0 then
      begin
        CloseFile(fileCommandLine);
        SetLength(strCommandLineFileName, 0);
      end;
    end;
  finally
    lstCommandLine.Free;
    lstCommandLine := nil;
  end;
end;

{ Common }

function CmpStr(const sOne, sTwo: string; lCase: boolean = False; lSpace: boolean = False; lBDE: boolean = False): boolean;
var
  i: integer;
  s1, s2: string;
begin
  if (lCase = False) and
     (lSpace = False) and
     (lBDE = False) then
  begin
    result := sOne = sTwo;
  end
  else
  begin
    s1 := sOne;
    s2 := sTwo;
    if lBDE then
    begin
      // s1 - source table name
      for i := length(s1) downto 1 do
      begin
        if s1[i] = '.' then
        begin
          Delete(s1, i, length(s1) - i + 1);
          break;
        end;
      end;
    end;
    if lSpace then
    begin
      s1 := GetPureSqlName(s1);
      s2 := GetPureSqlName(s2);
    end;
    if lCase then
    begin
      s1 := AnsiUpperCase(s1);
      s2 := AnsiUpperCase(s2);
    end;
    result := s1 = s2;
  end;
end;

function GetTypeTextBde(AVar: TFieldDef): string;
begin
  SetLength(result, 0);
  case AVar.DataType of
      ftUnknown:
      begin
        result := 'Unknown';
      end;
      ftString:
      begin
        result := 'String';
      end;
      ftSmallint:
      begin
        result := 'SmallInt';
      end;
      ftInteger:
      begin
        result := 'Integer';
      end;
      ftWord:
      begin
        result := 'Word';
      end;
      ftBoolean:
      begin
        result := 'Boolean';
      end;
      ftFloat:
      begin
        result := 'Float';
      end;
      ftCurrency:
      begin
        result := 'Currency';
      end;
      ftBCD:
      begin
        result := 'BCD';
      end;
      ftDate:
      begin
        result := 'Date';
      end;
      ftTime:
      begin
        result := 'Time';
      end;
      ftDateTime:
      begin
        result := 'DateTime';
      end;
      ftBytes:
      begin
        result := 'Bytes';
      end;
      ftVarBytes:
      begin
        result := 'VarBytes';
      end;
      ftAutoInc:
      begin
        result := 'AutoInc';
      end;
      ftBlob:
      begin
        result := 'Blob';
      end;
      ftMemo:
      begin
        result := 'Memo';
      end;
      ftGraphic:
      begin
        result := 'Graphic';
      end;
      ftFmtMemo:
      begin
        result := 'FmtMemo';
      end;
      ftParadoxOle:
      begin
        result := 'ParadoxOle';
      end;
      ftDBaseOle:
      begin
        result := 'DBaseOle';
      end;
      ftTypedBinary:
      begin
        result := 'TypedBinary';
      end;
      ftCursor:
      begin
        result := 'OracleCursor';
      end;
      ftFixedChar:
      begin
        result := 'FixedChar';
      end;
      ftWideString:
      begin
        result := 'WideString';
      end;
      ftLargeInt:
      begin
        result := 'LargeInt';
      end;
      ftADT:
      begin
        result := 'ADT';
      end;
      ftArray:
      begin
        result := 'Array';
      end;
      ftReference:
      begin
        result := 'Reference';
      end;
      ftDataSet:
      begin
        result := 'DataSet';
      end;
      ftOraBlob:
      begin
        result := 'Oracle8Blob';
      end;
      ftOraClob:
      begin
        result := 'Oracle8Clob';
      end;
      ftVariant:
      begin
        result := 'Variant';
      end;
      ftInterface:
      begin
        result := 'Interface';
      end;
      ftIDispatch:
      begin
        result := 'IDispatch';
      end;
      ftGuid:
      begin
        result := 'GUID';
      end;
  end;
  result := Format('%s(%d) %s', [result, AVar.Size, arRequired[AVar.Required]]);
end;

function GetSQLName(const AName: string; ASrcType: TPumpDatabaseType; ASQLDialect: integer): string;
begin
  case ASrcType of
    pdtIB:
      case ASQLDialect of
        0:   result := AName;
        1,2: result := Format('"%s"', [AName]);
      else
        raise Exception.Create(ErrSrc);
      end;
    pdtBDE, pdtADO:
      case ASQLDialect of
        0: result := AName;
        1: result := Format('"%s"', [AName]);
        2: result := Format('[%s]', [AName]);
      else
        raise Exception.Create(ErrSrc);
      end;
  end;
end;

{ TibPumpStatItem }

constructor TibPumpStatItem.Create(Collection: TCollection);
begin
  inherited;
  SetLength(FName, 0);
  FRowsAffected := -1;
  FErrors := 0;
  FProcessed := -1;
  FDeleted := -1;
end;

{ TibPumpStatCollection }

function TibPumpStatCollection.GetItem(Index: Integer): TibPumpStatItem;
begin
  Result := TibPumpStatItem(inherited Items[Index]);
end;

procedure TibPumpStatCollection.SetItem(Index: Integer; Value: TibPumpStatItem);
begin
  Items[Index].Assign(Value);
end;

function TibPumpStatCollection.Add: TibPumpStatItem;
begin
  result := TibPumpStatItem(inherited Add);
end;

function TibPumpStatCollection.FindByName(const AName: string): TibPumpStatItem;
var
  i: integer;
begin
  result := nil;
  for i := 0 to Count-1 do
    if Items[i].Name = AName then
    begin
      result := Items[i];
      break;
    end;
end;

function TibPumpStatCollection.GetByName(const AName: string): TibPumpStatItem;
begin
  result := FindByName(AName);
  if result = nil then
  begin
    result := Add;
    result.Name := AName;
  end;
end;

{ TibpPumpSettings }

procedure TibpPumpSettings.Clear;
begin
  SetLength(AVersion, 0);
  SetLength(AsName, 0);
  SetLength(AsUser, 0);
  SetLength(AsPass, 0);
  SetLength(AsRole, 0);
  AsChar := 0;
  AsDialect := 0;
  SetLength(AdName, 0);
  SetLength(AdUser, 0);
  SetLength(AdPass, 0);
  SetLength(AdRole, 0);
  AdChar := 0;
  AdDialect := 0;
  ADisableTriggers := False;
  AEmptyTables := False;
  AUpdateGenerators := False;
  AStopOnErrors := False;
  AStopAfterErrors := 0;
  ACommitData := False;
  ACommitEvery := 0;
  ACommitStep := False;
  SetLength(AAlias, 0);
  ASourceType := pdtIB;
  ConvBool := True;
  BoolTrue := 'T';
  BoolFalse := 'F';
  AChCase := False;
  ASpace := False;
  ATruncString := False;
  ARemSpace := False;
  ARemSpaceOpt := 0;
  AOffLoop := True;
  SetLength(AConnectionString, 0);
  ASrcSelect := 1;
  ASrcQuoteFields := False;
  SetLength(ASaveReportTo, 0);
end;

{ TibpMain }

procedure TibpMain.FormCreate(Sender: TObject);
{$IFDEF CCNEWS}
var
  FReg: TRegistry;
{$ENDIF}  
begin
  Self.Caption := Format('%s%s', [AppTitle, AppVersion]);

  // create ccCompos (avoid package)
  upSrcDialect:= TccSpinEdit.Create(Self);
  with upSrcDialect do
  begin
    Parent:= tsDatabases;
    Left:= 92;
    Top:= 85;
    Width:= 100;
    Height:= 21;
    TabOrder:= 6;
    Alignment:= taLeftJustify;
    Increment:= 1;
    Min:= 1;
    Max:= 3;
    Enabled:= True;
    Value:= 3;
  end;
  eSourceDatabase:= TccButtonEdit.Create(Self);
  with eSourceDatabase do
  begin
    Parent:= tsDatabases;
    Left:= 92;
    Top:= 24;
    Width:= 426;
    Height:= 21;
    Anchors:= [akLeft, akTop, akRight];
    TabOrder:= 2;
    OnButtonClick:= eSourceDatabaseButtonClick;
  end;
  eDestDatabase:= TccButtonEdit.Create(Self);
  with eDestDatabase do
  begin
    Parent:= tsDatabases;  
    Left:= 92;
    Top:= 129;
    Width:= 426;
    Height:= 21;
    Anchors:= [akLeft, akTop, akRight];
    TabOrder:= 16;
    OnButtonClick:= eSourceDatabaseButtonClick;
  end;
  upErrCnt:= TccSpinEdit.Create(Self);
  with upErrCnt do
  begin
    Parent:= tsPumpProp;
    Left:= 94;
    Top:= 105;
    Width:= 81;
    Height:= 21;
    Font.Charset:= DEFAULT_CHARSET;
    Font.Color:= clWindowText;
    Font.Height:= -11;
    Font.Name:= 'MS Sans Serif';
    Font.Style:= [];
    ParentFont:= False;
    TabOrder:= 4;
    Alignment:= taLeftJustify;
    Increment:= 1;
    Max:= 9999999;
    Enabled:= True;
  end;
  upCommit:= TccSpinEdit.Create(Self);
  with upCommit do
  begin
    Parent:= tsPumpProp;
    Left:= 324;
    Top:= 3;
    Width:= 81;
    Height:= 21;
    Font.Charset:= DEFAULT_CHARSET;
    Font.Color:= clWindowText;
    Font.Height:= -11;
    Font.Name:= 'MS Sans Serif';
    Font.Style:= [];
    ParentFont:= False;
    TabOrder:= 6;
    Alignment:= taLeftJustify;
    Increment:= 1;
    Max:= 9999999;
    Enabled:= True;
  end;
  upDestDialect:= TccSpinEdit.Create(Self);
  with upDestDialect do
  begin
    Parent:= tsDatabases;
    Left:= 92;
    Top:= 190;
    Width:= 100;
    Height:= 21;
    TabOrder:= 19;
    Alignment:= taLeftJustify;
    Increment:= 1;
    Min:= 1;
    Max:= 3;
    Value:= 3;
    Enabled:= True;
  end;
  eADOSource:= TccButtonEdit.Create(Self);
  with eADOSource do
  begin
    Parent:= tsDatabases;
    Left:= 91;
    Top:= 24;
    Width:= 426;
    Height:= 21;
    Anchors:= [akLeft, akTop, akRight];
    Color:= clBtnFace;
    ReadOnly:= True;
    TabOrder:= 3;
    OnButtonClick:= eADOSourceButtonClick;
  end;
  tvDest:= TccTreeView.Create(Self);
  with tvDest do
  begin
    Parent:= pSource;
    Align:= alClient;
    ReadOnly:= True;
    RightClickSelect:= True;
    DragMode:= dmAutomatic;
    HideSelection:= False;
    Indent:= 19;
    TabOrder:= 0;
    OnDragDrop:= tvDestDragDrop;
    OnDragOver:= tvDestDragOver;
    OnStartDrag:= tvDestStartDrag;
    OnMouseDown:= tvDestMouseDown;
    OnDblClick:= tvDestDblClick;
    PopupMenu:= pmDest;
    Images:= ilImages;
    ShowCheckBoxes:= True;
    OnCustomDraw:= tvDestCustomDraw;
    OnInfoCustomDraw:= tvDestInfoCustomDraw;
  end;
  tvSource:= TccTreeView.Create(Self);
  with tvSource do
  begin
    Parent:= Panel3;  
    Left:= 0;
    Top:= 15;
    Width:= 236;
    Height:= 344;
    ReadOnly:= True;
    DragMode:= dmAutomatic;
    HideSelection:= False;
    Indent:= 19;
    Align:= alClient;
    TabOrder:= 0;
    OnMouseDown:= tvDestMouseDown;
    OnDblClick:= tvSourceDblClick;
    PopupMenu:= pmDest;
    Images:= ilImages;
    OnCustomDraw:= tvSourceCustomDraw;
  end;
  tvSourceTr:= TccTreeView.Create(Self);
  with tvSourceTr do
  begin
    Parent:= Panel4;  
    Left:= 0;
    Top:= 15;
    Width:= 236;
    Height:= 344;
    ReadOnly:= True;
    DragMode:= dmAutomatic;
    HideSelection:= False;
    Indent:= 19;
    Align:= alClient;
    TabOrder:= 0;
    OnMouseDown:= tvDestMouseDown;
    OnDblClick:= tvSourceTrDblClick;
    PopupMenu:= pmDest;
    OnCustomDraw:= tvSourceCustomDraw;
  end;
  tvDestTr:= TccTreeView.Create(Self);
  with tvDestTr do
  begin
    Parent:= Panel5;  
    Align:= alClient;
    ShowRoot:= False;
    ReadOnly:= True;
    DragMode:= dmAutomatic;
    HideSelection:= False;
    Indent:= 19;
    TabOrder:= 0;
    OnDragDrop:= tvDestTrDragDrop;
    OnDragOver:= tvDestTrDragOver;
    OnMouseDown:= tvDestMouseDown;
    OnDblClick:= tvDestTrDblClick;
    PopupMenu:= pmDest;
    InfoColor:= clNavy;
    ShowCheckBoxes:= True;
    OnInfoCustomDraw:= tvDestTrInfoCustomDraw;
  end;
  ccSaveReport:= TccButtonEdit.Create(Self);
  with ccSaveReport do
  begin
    Parent:= pStepThreeBottom;  
    Left:= 85;
    Top:= 3;
    Width:= 480;
    Height:= 21;
    Anchors:= [akLeft, akRight];
    TabOrder:= 0;
    OnButtonClick:= ccSaveReportButtonClick;
  end;

  FStat := TibPumpStatCollection.Create(TibPumpStatItem);
  FDM := TibpDM.Create(Self);
  FDM.OnGetUserInfo := GetUserInfo;
  ibpstore := TibpPumpSettings.Create(Self);
  Pages.ActivePage := tsDatabases;
  PropPage.ActivePage := tsPumpProp;
  upErrCnt.Min := 1;
  upErrCnt.Max := MaxInt;
  upCommit.Min := 0;
  SetDefSettings;
  rep := TStringList.Create;

  IsWin95 := (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
             (Win32MinorVersion = 0);

{$IFDEF CCNEWS}
  FCCNews := nil;
  FReg := TRegistry.Create;
  try
    FReg.RootKey := HKEY_CURRENT_USER;
    if not FReg.OpenKey('\Software\CleverComponents\IBDataPump\DisableNews', False)
      then FCCNews := TclDownLoader.Create(nil);
  finally
    FReg.CloseKey;
    FReg.Free;
  end;

  if Assigned(FCCNews) then
  begin
    with FCCNews do
    begin
      OnDataTextProceed := OnCCNews;
      TryCount := 1;
      TimeOut := 3000;
      BatchSize := 1024;
      PreviewCharCount := 1024;
      URL := AppNews;
      LocalFile := '';
    end;
  end;
{$ENDIF}

  if IsParamMode then
  begin
    OldException := Application.OnException;
    Application.OnException := AppException;
    Self.Visible := False;
  end
  else
  begin
{$IFDEF CCNEWS}
    if Assigned(FCCNews) and InternetConnected
      then FCCNews.Start;
{$ENDIF}      
  end;
  GetWindStat(Self);
end;

procedure TibpMain.FormDestroy(Sender: TObject);
begin
  FStat.Free;
  FDM.Free;
  rep.Free;
  ibpstore.Free;

{$IFDEF CCNEWS}
  if Assigned(FCCNews) then
  begin
    if FCCNews.IsBusy
      then WaitForSubmission(FCCNews);
    if not FCCNews.IsBusy
      then FCCNews.Free;
  end;
{$ENDIF}

  if IsParamMode
    then Application.OnException := OldException;
  SetWindStat(Self);
end;

procedure TibpMain.SetSource;
begin
  case SrcType of
    pdtIB:
      with FDM.DBSource do
      begin
        Connected := False;
        DatabaseName := eSourceDatabase.Text;
        Params.Clear;
        Params.Add('user_name=' + eSUserName.Text);
        Params.Add('password=' + eSPassword.Text);
        if Length(Trim(eSRole.Text)) > 0
          then Params.Add('sql_role_name=' + Trim(eSRole.Text));
        if cbSCharSet.ItemIndex <> 0
          then Params.Add('lc_ctype=' + cbSCharSet.Items[cbSCharSet.ItemIndex]);
        SQLDialect := Succ(SrcDialect);
      end;
    pdtBDE:
      with FDM.bdeDb do
      begin
        Connected := False;
        AliasName := cbAlias.Text;
      end;
    pdtADO:
      with FDM.adoDb do
      begin
        Connected := False;
        ConnectionString := eADOSource.Text;
      end;
  else
    raise Exception.Create(ErrSrc);
  end;

  pDBSource.Caption := GetSourceDB;
  pDBSourceT.Caption := GetSourceDB;
end;

procedure TibpMain.SetDest;
begin
  with FDM.DBDest do
  begin
    Connected := False;
    DatabaseName := eDestDatabase.Text;
    Params.Clear;
    Params.Add('user_name=' + eDUserName.Text);
    Params.Add('password=' + eDPassword.Text);
    if Length(Trim(eDRole.Text)) > 0
      then Params.Add('sql_role_name=' + Trim(eDRole.Text));
    if cbDCharSet.ItemIndex <> 0
      then Params.Add('lc_ctype=' + cbDCharSet.Items[cbDCharSet.ItemIndex]);
    SQLDialect := Succ(DestDialect);
  end;

  pDBDEst.Caption := GetDestDB;
  pDBDestT.Caption := GetDestDB;
end;

procedure TibpMain.btnSTestClick(Sender: TObject);
begin
  SetSource;
  try
    case SrcType of
      pdtIB: FDM.DBSource.Connected := True;
      pdtBDE: FDM.bdeDb.Connected := True;
      pdtADO: FDM.adoDb.Connected := True;
    else
      raise Exception.Create(ErrSrc);
    end;

    if FDM.DBSource.Connected and (Succ(SrcDialect) <> SrcInfo.DBSQLDialect) then
    begin
      PumpDlg('Actual database dialect is: ' + IntToStr(SrcInfo.DBSQLDialect), mtError);
    end
    else
    begin
      PumpDlg('Passed!');
    end;
  finally
    FDM.DBSource.Connected := False;
    FDM.bdeDb.Connected := False;
    FDM.adoDb.Connected := False;
  end;
end;

procedure TibpMain.btnDTestClick(Sender: TObject);
begin
  SetDest;
  try
    FDM.DBDest.Connected := True;
    if FDM.DBDest.Connected and (Succ(DestDialect) <> DestInfo.DBSQLDialect) then
    begin
      PumpDlg('Actual database dialect is: ' + IntToStr(DestInfo.DBSQLDialect), mtError);
    end
    else
    begin
      PumpDlg('Passed!');
    end;
  finally
    FDM.DBDest.Connected := False;
  end;
end;

procedure TibpMain.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TibpMain.PagesChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if not Visible
    then Exit;

  AllowChange := False;

  if Pages.ActivePage = tsDatabases then
  begin
    SetSource;
    SetDest;
  end;

  AllowChange := True;
end;

procedure TibpMain.ExpandAll1Click(Sender: TObject);
var
  tv: TccTreeView;
begin
  if tvDest.Focused
    then tv := tvDest
    else tv := tvSource;
  with tv do
  begin
    Items.BeginUpdate;
    FullExpand;
    Items.EndUpdate;
  end;
end;

procedure TibpMain.CollapseAll1Click(Sender: TObject);
var
  tv: TccTreeView;
begin
  if tvDest.Focused
    then tv := tvDest
    else tv := tvSource;
  with tv do
  begin
    Items.BeginUpdate;
    FullCollapse;
    Items.EndUpdate;
  end;
end;

procedure TibpMain.GetCount1Click(Sender: TObject);
var
  i: integer;
  nd: TccTreeNode;
begin
  i := 0;
  nd := nil;
  if tvDest.Focused
    then nd := tvDest.Items.GetFirstNode;
  if tvSource.Focused
    then nd := tvSource.Items.GetFirstNode;
  if tvDestTr.Focused
    then nd := tvDestTr.Items.GetFirstNode;
  if tvSourceTr.Focused
    then nd := tvSourceTr.Items.GetFirstNode;
  while nd <> nil do
  begin
    Inc(i);
    nd := nd.GetNextSibling;
  end;
  PumpDlg('Count - '+IntToStr(i));
end;

procedure TibpMain.GetNodeChildsCount1Click(Sender: TObject);
var
  tv: TccTreeView;
begin
  if tvDest.Focused
    then tv := tvDest
    else tv := tvSource;
  with tv do
  begin
    if Selected = nil
      then Exit;
    PumpDlg('Childs Count - ' + IntToStr(Selected.Count));
  end;
end;

procedure TibpMain.btnStartPumpClick(Sender: TObject);
var
  i, j, k, nSel, nPos: integer;
  mem: TMemoryStream;
  nd, nr, tmp, nstmp: TccTreeNode;
  lst, src, dest: TStringList;
  xSource, xDest: TIBXSQLVAR;
  ds: TDataset;
  fld: TField;
  sizes: TList;
  str, infSrc, infDest, sInfo: string;
  vVar: Variant;
  FStatItem: TibPumpStatItem;
begin
  FStat.Clear;
  ErrCnt := 0;
  CmtCnt := 0;
  k := 0;
  nSel := 0;

  RepStart;

  with FDM do
  begin
    lst := TStringList.Create;
    EnableWindow(Self.Handle, False);
    try
      ErrCnt := -1;
      DBDest.Connected := True;

      case SrcType of
        pdtIB:
          begin
            DBSource.Connected := True;
            DBSource.DefaultTransaction.StartTransaction;
            infSrc := GetIBAliasInfo(SrcInfo, lst);
          end;
        pdtBDE:
          begin
            bdeDb.Connected := True;
            infSrc := GetBDEAliasInfo(bdeDb, lst);
          end;
        pdtADO:
          begin
            adoDb.Connected := True;
            infSrc := GetADOConnectionInfo(adoDb, lst);
          end;
      else
        raise Exception.Create(ErrSrc);
      end;
    
      if not CheckValues
        then Exit;

      ErrCnt := 0;

      RepLine('=== Generated by: ' + Self.Caption);
      RepLine('=== Start Pumping: ' + DateTimeToStr(Now));
      RepLine('=== Source Database: ' + GetSourceDB);
      RepStr(lst);

      RepLine('=== Destination Database: ' + GetDestDB);
      infDest := GetIBAliasInfo(DestInfo, lst);
      RepStr(lst);

      src := TStringList.Create;
      dest := TStringList.Create;
      mem := TMemoryStream.Create;
      sizes := TList.Create;
      try
        Trans.StartTransaction;
        try
          AlterConst(False);
          AlterTriggers(False);
          EmptyTables;
          nd := tvDest.Items.GetFirstNode;
          while nd <> nil do
          begin
            if nd.Checked and (nd.InfoText = '') and (Pos(#0, nd.Text) > 0) then
            begin
              FStatItem := FStat.GetByName(nd.TheText);
              if FStatItem.RowsAffected < 0
                then FStatItem.RowsAffected := 0;

              RepLine('=== Destination Execute SQL: ' + nd.TheText);
              Self.Caption := Format('%s%s - Execute SQL %s', [AppTitle, AppVersion, nd.TheText]);
              Inc(nSel, 1);

              nPos := Pos(#0, nd.Text);

              src.Clear;
              dest.Clear;
              nr := FindTheNode(nd, picRelationFields);
              tmp := nr.GetFirstChild;
              while tmp <> nil do
              begin
                src.Add(tmp.InfoText);
                dest.Add(tmp.TheText);
                tmp := nr.GetNextChild(tmp);
              end;

              try
                qryDest.SQL.Text := Copy(nd.Text, Succ(nPos), Length(nd.Text));
                RepLine('Custom SQL: ' + qryDest.SQL.Text);
                qryDest.Prepare;

                for i := 0 to src.Count-1 do
                  if IsConst(src[i])
                    then qryDest.ParamByName(dest[i]).AsString := GetConst(src[i]);

                try
                  qryDest.ExecQuery;
                finally
                  FStatItem.RowsAffected := FStatItem.RowsAffected + qryDest.RowsAffected;
                  qryDest.Close;
                end;

                if cbCommitEvery.Checked and
                  (upCommit.Value > 0)
                  then DoCommit;

              except
                on E: Exception do
                begin
                  inc(ErrCnt);
                  FStatItem.Errors :=  FStatItem.Errors + 1;
                  RepLine(' !  Error ' + IntToStr(ErrCnt) + ':' + E.Message);
                  if cbStopErr.Checked and (ErrCnt >= upErrcnt.Value) then raise;
                end;
              end;
            end;

            if nd.Checked and (nd.InfoText <> '') then
            begin
              FStatItem := FStat.GetByName(nd.TheText);
              if FStatItem.Processed < 0
                then FStatItem.Processed := 0;
              if FStatItem.RowsAffected < 0
                then FStatItem.RowsAffected := 0;

              RepLine('=== Table: ' + nd.TheText);
              RepLine('-- Source');

              sInfo := Format('%s%s - %s %s', [AppTitle, AppVersion, nd.TheText, '%d Total %d Errors %d']);
              Self.Caption := Format(sInfo, [0, k, ErrCnt]);

              src.Clear;
              dest.Clear;
              nr := FindTheNode(nd, picRelationFields);
              tmp := nr.GetFirstChild;
              while tmp <> nil do
              begin
                src.Add(tmp.InfoText);
                dest.Add(tmp.TheText);
                tmp := nr.GetNextChild(tmp);
                inc(nSel);
              end;

              nstmp := FindSourceTable(tvSource, nd.InfoText);

              ds := OpenDataset(nstmp, src);

              RepLine('-- Dest');

              nPos := Pos(#0, nd.Text);

              if nPos = 0 then
              begin
                BuildSQL(nd.TheText, pdtIB, DestDialect, dest, qryDest.SQL, True);
                RepLine('SQL: ' + qryDest.SQL.Text);
              end
              else
              begin
                qryDest.SQL.Text := Copy(nd.Text, Succ(nPos), Length(nd.Text));
                RepLine('Custom SQL: ' + qryDest.SQL.Text);
              end;

              qryDest.Prepare;
              // fight IBExpress bug - save field sizes
              sizes.Clear;
              for i := 0 to qryDest.Params.Count-1
                do sizes.Add(Pointer(qryDest.Params[i].Size));

              if Assigned(ds)
                then ds.Open
                else qrySource.ExecQuery;

              for i := 0 to src.Count-1 do
              begin
                if not IsConst(src[i]) then
                begin
                  if Assigned(ds)
                    then dest.Objects[i] := Pointer(ds.FieldByName(src[i]).Index)
                    else dest.Objects[i] := Pointer(qrySource.Current.ByName(src[i]).Index);
                end
                else
                begin
                  dest.Objects[i] := Pointer(-1);
                end;
              end;

              i := 0;
              while ((Assigned(ds) and (not ds.EOF)) or ((not Assigned(ds)) and (not qrySource.EOF))) do
              begin
                for j := 0 to dest.Count-1 do
                begin
                  if nPos = 0
                    then xDest := qryDest.Params[j]
                    else xDest := qryDest.ParamByName(dest[j]);
                  if Integer(dest.Objects[j]) = -1 then
                  begin
                    // Const Value
                    xDest.AsString := GetConst(src[j]);
                  end
                  else
                  begin
                    // Source Value
                    if Assigned(ds) then
                    begin
                      // BDE Source
                      fld := ds.Fields[Integer(dest.Objects[j])];
                      if fld.IsNull then
                      begin
                        xDest.IsNull := True;
                      end
                      else
                      begin
                        if not (fld is TBlobField) then
                        begin
                          if (xDest.SQLType <> 590{SQL_BOOLEAN}) and
                             (cbBool.Checked and (fld is TBooleanField)) then
                          begin
                            if TBooleanField(fld).Value
                              then xDest.AsString := eBoolTrue.Text
                              else xDest.AsString := eBoolFalse.Text;
                          end
                          else
                          begin
                            if (cbTruncString.Checked or cbRemSpace.Checked) and
                               (fld is TStringField) and
                               ((xDest.SQLType = SQL_TEXT) or (xDest.SQLType = SQL_VARYING))
                              then
                              begin
                                DoPumpString(fld.AsString, xDest, Integer(sizes[j]))
                              end
                              else
                              begin
                                vVar := fld.Value;
                                xDest.Value := vVar;
                                vVar := Null;
                              end;
                          end;
                        end
                        else
                        begin
                          mem.Clear;
                          TBlobField(fld).SaveToStream(mem);
                          mem.Position := 0;
                          if xDest.SQLType <> SQL_BLOB then
                          begin
                            SetLength(str, mem.Size);
                            try
                              mem.Read(str[1], mem.Size);
                              if (cbTruncString.Checked or cbRemSpace.Checked) and
                                 ((xDest.SQLType = SQL_TEXT) or (xDest.SQLType = SQL_VARYING))
                                then DoPumpString(str, xDest, Integer(sizes[j]))
                                else xDest.AsString := str;
                            finally
                              SetLength(str, 0);
                            end;
                          end
                          else
                          begin
                            xDest.LoadFromStream(mem);
                          end;
                          mem.Clear;
                        end;
                      end;
                    end
                    else
                    begin
                      // Interbase source
                      xSource := qrySource.Fields[Integer(dest.Objects[j])];
                      if xSource.IsNull then
                      begin
                        xDest.IsNull := True;
                      end
                      else
                      begin
                        if xSource.SQLType <> SQL_BLOB then
                        begin
                          if (cbTruncString.Checked or cbRemSpace.Checked) and
                             ((xDest.SQLType = SQL_TEXT) or (xDest.SQLType = SQL_VARYING)) and
                             ((xSource.SQLType = SQL_TEXT) or (xSource.SQLType = SQL_VARYING))
                          then
                          begin
                            DoPumpString(xSource.AsString, xDest, Integer(sizes[j]));
                          end
                          else
                          begin
                            if xDest.SQLType <> SQL_BLOB then
                            begin
                              xDest.Assign(xSource);
                            end
                            else
                            begin
                             if (xSource.SQLType = SQL_TEXT) or (xSource.SQLType = SQL_VARYING)
                               then xDest.AsString := xSource.AsString
                               else xDest.Assign(xSource);
                            end;
                          end;
                        end
                        else
                        begin
                          mem.Clear;
                          xSource.SaveToStream(mem);
                          mem.Position := 0;
                          if xDest.SQLType <> SQL_BLOB then
                          begin
                            SetLength(str, mem.Size);
                            try
                              mem.Read(str[1], mem.Size);
                              if (cbTruncString.Checked or cbRemSpace.Checked) and
                                 ((xDest.SQLType = SQL_TEXT) or (xDest.SQLType = SQL_VARYING))
                                then DoPumpString(str, xDest, Integer(sizes[j]))
                                else xDest.AsString := str;
                            finally
                              SetLength(str, 0);
                            end;
                          end
                          else
                          begin
                            xDest.LoadFromStream(mem);
                          end;
                          mem.Clear;
                        end;
                      end;
                    end;
                  end;
                end;
                try
                  try
                    qryDest.ExecQuery;
                    FStatItem.Processed := FStatItem.Processed + 1;
                  finally
                    FStatItem.RowsAffected := FStatItem.RowsAffected + qryDest.RowsAffected;
                    qryDest.Close;
                  end;
                  Inc(i);
                  Inc(k);
                except
                  on E: Exception do
                  begin
                    FStatItem.Errors := FStatItem.Errors + 1;
                    inc(ErrCnt);
                    RepLine(' !  Error ' + IntToStr(ErrCnt) + ':' + E.Message);
                    if cbStopErr.Checked and (ErrCnt >= upErrcnt.Value) then raise;
                  end;
                end;
                qryDest.Close;
                inc(CmtCnt);

                if (k mod 100) = 0
                  then Self.Caption := Format(sInfo, [i, k, ErrCnt]);

                if cbCommitEvery.Checked and
                  (upCommit.Value > 0) and
                  (CmtCnt > upCommit.Value)
                  then DoCommit;

                if Assigned(ds)
                  then ds.Next
                  else qrySource.Next;
              end;

              if cbCommitEvery.Checked and
                (upCommit.Value > 0)
                then DoCommit;

              if Assigned(ds)
                then ds.Close
                else qrySource.Close;

              RepLine('--- Source Records Processed: ' +  IntToStr(i));
              Self.Caption := Format(sInfo, [i, k, ErrCnt]);
              Application.ProcessMessages;
            end;
            nd := nd.GetNextSibling;
          end;

          AlterConst(True);
          AlterTriggers(True);

          Inc(nSel, UpdateGenerators);

          Trans.Commit;

          RepLine(' >  Data Committed.');
          if ErrCnt = 0
            then RepLine('=== All Fine!');
        except
          on E: Exception do
          begin
            ParamRes := -1;
            inc(ErrCnt);
            RepLine('!!! Fatal Error :' + E.Message);
            AlterConst(True);
            AlterTriggers(True);
            Trans.Rollback;
          end;
        end;
      finally
        if nSel = 0 then
        begin
          Inc(ErrCnt);
          RepLine('=== Error: Can not find a single selected table with field relations!');
          RepLine(' !  Warning: Go to "Step 2: Order" page and setup relations first.');
        end;

        ShowStats;

        if ErrCnt > 0 then
        begin
          RepLine('=== Errors: ' + IntToStr(ErrCnt) );
          RepLine(' !  Warnings: ' + ErrSelect);
        end;
        RepLine('=== Total Source Records Processed: ' + IntToStr(k));
        RepLine('=== Finish Pumping:' + DateTimeToStr(Now));

        src.Free;
        dest.Free;
        mem.Free;
        sizes.Free;

{$IFDEF CCNEWS}
        if CheckForNews(FCCNews, infSrc, infDest, k, ErrCnt)
          then RepLine('   ');
{$ENDIF}          
      end;
    finally
      EnableWindow(Self.Handle, True);
      Self.Caption := Format('%s%s', [AppTitle, AppVersion]);
      lst.Free;

      FDM.DBDest.Connected := False;
      FDM.DBSource.Connected := False;
      FDM.bdeDb.Connected := False;
      FDM.adoDb.Connected := False;

      if ErrCnt <> -1 then
      begin
        if ErrCnt = 0 then
        begin
          if not IsParamMode
            then PumpDlg('All Fine!');
        end
        else
        begin
          if ParamRes <> -1
            then ParamRes := ErrCnt;
          if not IsParamMode
            then PumpDlg('Errors - ' + IntToStr(ErrCnt));
        end;
      end;
      RepStop;
      FStat.Clear;
    end;
  end;
end;

procedure TibpMain.BuildSQL(const ATable: string; ASrcType: TPumpDatabaseType; ASQLDialect: integer; AFields, AItems: TStrings; IsIns: boolean);
var
  str: string;
  ins: string;
  i: integer;
begin
  AItems.Clear;

  SetLength(str, 0);
  SetLength(ins, 0);

  for i := 0 to AFields.Count-2 do
  begin
    str := str + GetSQLName(AFields[i], ASrcType, ASQLDialect) + ',';
    ins := ins + ':PAR' + IntToStr(i) + ',';
  end;

  if AFields.Count > 0 then
  begin
    str := str + GetSQLName(AFields[AFields.Count-1], ASrcType, ASQLDialect);
    ins := ins + ':PAR' + IntToStr(AFields.Count-1);
  end;

  if IsIns then
  begin
    AItems.Add('INSERT INTO ' + GetSQLName(ATable, ASrcType, ASQLDialect));
    AItems.Add('(' + str + ')');
    AItems.Add('VALUES (' + ins + ')');
  end
  else
  begin
    AItems.Add('SELECT * ');
    AItems.Add('FROM ' + GetSQLName(ATable, ASrcType, ASQLDialect));
  end;
end;

procedure TibpMain.EmptyTables;
var
  nd: TccTreeNode;
  lst: TStringList;
  i: integer;
  FStatItem: TibPumpStatItem;

begin
  if not cbEmpty.Checked then Exit;
  lst := TStringList.Create;
  try
    RepLine('=== Empty Tables');
    nd := tvDest.Items.GetFirstNode;
    while nd <> nil do
    begin
      if nd.Checked and
         (Pos(#0, nd.Text) = 0)
        then lst.Add(nd.TheText);
      nd := nd.GetNextSibling;
    end;
    for i := lst.Count-1 downto 0 do
    begin
      FStatItem := FStat.GetByName(lst[i]);
      if FStatItem.Deleted < 0
        then FStatItem.Deleted := 0;

      qryDest.Close;
      qryDest.SQL.Text := Format('DELETE FROM %s', [GetSQLName(lst[i], pdtIB, DestDialect)]);
      RepStr(qryDest.SQL);
      try
        try
          qryDest.ExecQuery;

          if cbCommitEvery.Checked and
            (upCommit.Value > 0)
            then DoCommit;
        except
          on E: Exception do
          begin
            FStatItem.Errors :=  FStatItem.Errors + 1;
            inc(ErrCnt);
            RepLine(Format(' !  Error %d : %s', [ErrCnt, E.Message]));
            if cbStopErr.Checked and (ErrCnt >= upErrcnt.Value)
              then raise;
          end;
        end;
      finally
        FStatItem.Deleted := FStatItem.Deleted + qryDest.RowsAffected;
        qryDest.Close;
      end;
    end;
  finally
    lst.Free;
  end;
end;

procedure TibpMain.AlterTriggers(lOn: boolean);
var
  i: integer;
  lst: TStringList;
  tmp: TccTreeNode;
  str: string;
begin
  if not cbDisableTriggers.Checked then Exit;
  RepLine('=== Alter triggers');
  lst := TStringList.Create;
  try
    tmp := tvDest.Items.GetFirstNode;
    while tmp <> nil do
    begin
      if tmp.Checked and ((cbEmpty.Checked) or (tmp.InfoText <> ''))
        then lst.Add(tmp.TheText);
      tmp := tmp.GetNextSibling;
    end;

    if lst.Count = 0
      then Exit;

    SetLength(str, 0);
    for i:= 0 to lst.Count-2
      do str := str + Format('''%s'',', [lst[i]]);
    str := str + Format('''%s''', [lst[lst.Count-1]]);

    qryDest.SQL.Clear;
    qryDest.SQL.Add('SELECT RDB$TRIGGER_NAME');
    qryDest.SQL.Add('FROM RDB$TRIGGERS');
    qryDest.SQL.Add('WHERE RDB$FLAGS = 1 AND NOT (RDB$TRIGGER_NAME LIKE ''CHECK_%'')');
    qryDest.SQL.Add(Format('AND (RDB$RELATION_NAME in (%s))', [str]));
    qryDest.ExecQuery;
    try
      lst.Clear;
      while not qryDest.EOF do
      begin
        lst.Add(GetSQLName(Trim(qryDest.Fields[0].AsString), pdtIB, DestDialect));
        qryDest.Next;
      end;
      for i := 0 to lst.Count-1 do
      begin
        qryDest.Close;
        qryDest.SQL.Clear;
        if lOn
          then qryDest.SQL.Add(Format('ALTER TRIGGER %s ACTIVE', [lst[i]]))
          else qryDest.SQL.Add(Format('ALTER TRIGGER %s INACTIVE', [lst[i]]));
        RepStr(qryDest.SQL);
        qryDest.ExecQuery;
        qryDest.Close;
      end;
      Trans.Commit;
      Trans.StartTransaction;
      RepLine(' >  Data Committed.');
   finally
      qryDest.Close;
    end;
  finally
    lst.Free;
  end;
  Application.ProcessMessages;
end;

function TibpMain.UpdateGenerators: integer;
var
  i, ind: integer;
  tmp, srcnode, fldnode: TccTreeNode;
  AGenName: string;
  src: TStringList;
  nPos: integer;
  ds: TDataset;
  lFound: boolean;
begin
  result := 0;

  if not cbUpdateGenerators.Checked
    then Exit;

  RepLine('=== Update Generators');
  src := TStringList.Create;
  try
    tmp := tvDestTr.Items.GetFirstNode;
    while tmp <> nil do
    begin
      i := 0;
      
      if tmp.Checked and (tmp.InfoText <> '') then
      begin

        if IsConst(tmp.InfoText) then
        begin
          srcnode := nil;
          nPos := 0;
        end
        else
        begin
          srcnode := FindSourceTable(tvSourceTr, tmp.InfoText);
          nPos := Pos(#0, srcnode.Text);
        end;

        try
          Inc(result);
          AGenName := GetSQLName(tmp.TheText, pdtIB, DestDialect);
          qrySource.Close;
          qryDest.Close;
          if IsConst(tmp.InfoText) then
          begin
            qryDest.SQL.Text := Format('SET GENERATOR %s TO %s', [AGenName, GetConst(tmp.InfoText)]);
            RepStr(qryDest.SQL);
            RepLine('');
          end
          else
          begin
            if nPos <> 0 then
            begin
              src.Clear;
              fldnode := srcnode.GetFirstChild;
              while fldnode <> nil do
              begin
                src.Add(fldnode.TheText);
                fldnode := srcnode.GetNextChild(fldnode);
              end;

              ds := OpenDataset(srcnode, src);

              lFound := False;
              if Assigned(ds) then
              begin
                ds.Open;
                try
                  for ind := 0 to ds.Fields.Count-1 do
                  begin
                    if AnsiCompareStr(AnsiUpperCase(ds.Fields[ind].FieldName), AnsiUpperCase(tmp.TheText)) = 0 then
                    begin
                      lFound := True;
                      i := ds.Fields[ind].AsInteger;
                      break;
                    end;
                  end;
                  if (not lFound) and (ds.Fields.Count > 0)
                    then i := ds.Fields[0].AsInteger;
                finally
                  ds.Close;
                end;
              end
              else
              begin
                qrySource.ExecQuery;
                try
                  for ind := 0 to qrySource.Current.Count-1 do
                  begin
                    if AnsiCompareStr(AnsiUpperCase(qrySource.Fields[ind].Name), AnsiUpperCase(tmp.TheText)) = 0 then
                    begin
                      lFound := True;
                      i := qrySource.Fields[ind].AsInteger;
                      break;
                    end;
                  end;
                  if (not lFound) and (qrySource.Current.Count > 0)
                    then i := qrySource.Fields[0].AsInteger;
                finally
                  qrySource.Close;
                end;
              end;
            end
            else
            begin
              qrySource.SQL.Text := Format('SELECT GEN_ID(%s,0) FROM RDB$GENERATORS', [GetSQLName(tmp.InfoText, pdtIB, SrcDialect)]);
              RepStr(qrySource.SQL);
              qrySource.ExecQuery;
              i := qrySource.Fields[0].AsInteger;
              qrySource.Close;
            end;

            qryDest.SQL.Text := Format('SET GENERATOR %s TO %d', [AGenName, i]);
            RepStr(qryDest.SQL);
            RepLine('');
          end;
          qryDest.ExecQuery;
          qryDest.Close;
          inc(CmtCnt);
          if cbCommitEvery.Checked and
            (upCommit.Value > 0) and
            (CmtCnt > upCommit.Value)
            then DoCommit;
        except
          on E: Exception do
          begin
            inc(ErrCnt);
            RepLine(Format(' !  Error %d : %s', [ErrCnt, E.Message]));
            if cbStopErr.Checked and (ErrCnt >= upErrcnt.Value)
              then raise;
          end;
        end;
      end;
      tmp := tmp.GetNextSibling;
    end;
  finally
    src.Free;
    qrySource.Close;
    qryDest.Close;
  end;
end;

procedure TibpMain.btnGetDfnClick(Sender: TObject);
var
  oldCur: TCursor;
begin
  oldCur := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    FillDestDef;
    case SrcType of
      pdtIB: FillSourceDef;
      pdtBDE, pdtADO: FillSourceDefDataset;
    else
      raise Exception.Create(ErrSrc);
    end;
  finally
    Screen.Cursor := oldCur;
  end;
end;

function FixLocate(AQuery: TIBQuery; const AField, AValue: string): boolean;
var
  str: string;
  fld: TField;
begin
  fld := AQuery.FieldByName(AField);

  if (fld is TIBStringField) and
     (fld as TIBStringField).FixedChar then
  begin
    str := AValue + StringOfChar(' ', fld.Size - Length(AValue));
    result := AQuery.Locate(AField, str, []);
  end
  else
  begin
    result := AQuery.Locate(AField, AValue, [])
  end;
end;

procedure TibpMain.DelDep(const AName: string);
begin
  while FixLocate(qryDep, 'SOURCE', AName)
    do qryDep.Delete;
end;

procedure TibpMain.FillDestDef;

type
  TTabCounts = record
    FDetail : Integer;
    FMaster : Integer;
  end;

var
  lst, rd, lcmp: TStringList;
  nd, nrc, tmp: TccTreeNode;
  i, j, k: integer;
  loop, loopinf: TStringList;
  disabledFK : TStringList;
  tabCounts : array of TTabCounts;
  found : Boolean;
  fldDepDetail, fldDepMaster, fldDepFK : TField;

  // recursive, return index of loop start or -1
  function walkTable(i : integer; var unmark : boolean) : integer;
  const
    mark : Pointer = Pointer(1);

  var
    bm : TBookmark;
    n  : Integer;
    fk : String;

  begin
    Result := -1;

    // mark as walked
    loop.Objects[i] := mark;
    if not qryDep.Locate(fldDepDetail.FieldName, loop[i], [])
    then Exit;

    while Result = -1 do
    begin
      // check master table
      n := loop.IndexOf(Trim(fldDepMaster.AsString));
      if n < 0
      then Exit;

      // put fk name
      fk := Trim(fldDepFK.AsString);
      loopinf.Add(fk);

      if Assigned(loop.Objects[n])
      then begin
        if i = n
        then unmark := true;

        Result := n;
        Exit;
      end;

      bm := qryDep.GetBookmark;
      Result := walkTable(n, unmark);

      if Result >= 0
      then begin
        if i = Result                // loop started here
        then unmark := true
        else if unmark               // unmark tables that is not a part of the loop
        then begin
          loop.Objects[i] := nil;
          loopinf.Delete(loopinf.IndexOf(fk));
        end;

        qryDep.FreeBookmark(bm);
        Exit;
      end;

      loopinf.Delete(loopinf.Count - 1);
      qryDep.GotoBookmark(bm);
      qryDep.FreeBookmark(bm);

      if not qryDep.LocateNext(fldDepDetail.FieldName, loop[i], [])
      then Exit;
    end;
  end;

  function findLoops : boolean;
  var
    u : Boolean;
    i : Integer;
  begin
    Result := false;

    // put all tables that makes a loops into 'loop' list
    for i := 0 to lst.Count - 1 do
      if (tabCounts[i].FDetail > 0) and (tabCounts[i].FMaster > 0)
      then loop.Add(lst[i]);

    if loop.Count = 0
    then Exit;

    u := false;
    Result := (walkTable(0, u) >= 0);

    // delete not marked items
    i := 0;
    while i < loop.Count do
      if not Assigned(loop.Objects[i])
      then loop.Delete(i)
      else Inc(i);
  end;

begin
  FDM.DBDest.Connected := True;
  try
    FDM.DBDest.DefaultTransaction.StartTransaction;

    lst := TStringList.Create;
    rd := TStringList.Create;
    lcmp := TStringList.Create;
    loop := TStringList.Create;
    loopinf := TStringList.Create;
    disabledFK := TStringList.Create;

    tvDest.Items.BeginUpdate;
    try
      FDM.DBDest.GetTableNames(lst);
      lst.Sort;
      SetLength(tabCounts, lst.Count);

      // get counts as detail\master for all relations
      qryDep.Open;

      // fields are: detail, fk, master, pk
      fldDepDetail := qryDep.Fields[0];
      fldDepFK     := qryDep.Fields[1];
      fldDepMaster := qryDep.Fields[2];

      qryDep.First;
      while not qryDep.Eof do
      begin
        if cbLoop.Checked and (Trim(fldDepDetail.AsString) = Trim(fldDepMaster.AsString))
        then begin
          disabledFK.Add(Trim(fldDepFK.AsString));
          qryDep.Delete;
        end
        else begin
          i := lst.IndexOf(Trim(fldDepDetail.AsString));
          if i >= 0
          then Inc(tabCounts[i].FDetail);

          i := lst.IndexOf(Trim(fldDepMaster.AsString));
          if i >= 0
          then Inc(tabCounts[i].FMaster);

          qryDep.Next;
        end;
      end;

      // add tables into 'rd' list in the correct order

      // first add tables with no FK relationships
      for i := 0 to lst.Count - 1 do
        if (tabCounts[i].FDetail = 0) and (tabCounts[i].FMaster = 0)
        then rd.Add(lst[i]);

      // then add other tables, independent first
      while True do
      begin
        found := false;
        for i := 0 to lst.Count - 1 do
          if (tabCounts[i].FDetail = 0) and (tabCounts[i].FMaster <> 0)
          then begin
            found := true;
            rd.Add(lst[i]);

            while qryDep.Locate(fldDepMaster.FieldName, lst[i], []) do
            begin
              Dec(tabCounts[i].FMaster);

              j := lst.IndexOf(Trim(fldDepDetail.AsString));
              if j >= 0
              then begin
                Dec(tabCounts[j].FDetail);

                if (tabCounts[j].FDetail = 0) and (tabCounts[j].FMaster = 0)
                then rd.Add(lst[j]);
              end;

              qryDep.Delete;
            end;
          end;

        if rd.Count = lst.Count
        then Break;

        if found
        then Continue;

        // find one loop details
        if not findLoops
        then begin
          PumpDlg('Loop is expected but not foung, bug ?');
          Abort;
        end;

        if not cbLoop.Checked
        then begin
          PumpDlg('Can not continue - Loop found!'#13 +
                  ' Tables in loop: ' +  loop.CommaText + '.'#13 +
                  ' Ref Constraints: ' + loopinf.CommaText + '.'#13#13 +
                  'To resolve loop you need to alter or temporary delete one of this ref constraints. '#13 +
                  'After data pumping finished you can restore it again. '#13 +
                  'Please read help to get more info.');
          Abort;
        end;

        // Disable FK to break a loop and repeat
        disabledFK.Add(loopinf[0]);

        if qryDep.Locate(fldDepFK.FieldName, loopinf[0], [])
        then begin
          i := lst.IndexOf(Trim(fldDepDetail.AsString));
          if (i >= 0)
          then Dec(tabCounts[i].FDetail);

          i := lst.IndexOf(Trim(fldDepMaster.AsString));
          if (i >= 0)
          then Dec(tabCounts[i].FMaster);

          if (tabCounts[i].FDetail = 0) and (tabCounts[i].FMaster = 0)
          then rd.Add(lst[i]);

          qryDep.Delete;
        end;

        loop.Clear;
        loopinf.Clear;
      end;

      disabledFK.Sort;

      tvDest.Items.Clear;
      for i := 0 to rd.Count-1 do
      begin
        nd := tvDest.Items.AddChild(nil, rd[i]);
        nd.ImageIndex := Integer(picTableNoLinks);
        nd.Checked := False;

        tmp := tvDest.Items.AddChild(nd, 'Fields Relations');
        tmp.InfoText := '(0)';
        tmp.ImageIndex := Integer(picRelationFields);

        nrc := tvDest.Items.AddChild(nd, 'Table Fields');
        nrc.ImageIndex := Integer(picDestFields);

        qryDefsFields.Close;
        qryDefsFields.Database := FDM.DBDest;
        qryDefsFields.Transaction := FDM.DBDest.DefaultTransaction;
        qryDefsFields.Params[0].AsString := nd.TheText;
        lcmp.Clear;
        qryDestComp.Close;
        qryDestComp.Params[0].AsString := nd.TheText;
        qryDestComp.ExecQuery;
        try
          while not qryDestComp.EOF do
          begin
            lcmp.Add(qryDestComp.Fields[0].AsString);
            qryDestComp.Next;
          end;
          lcmp.Sort;
        finally
          qryDestComp.Close;
        end;

        k := 0;
        qryDefsFields.ExecQuery;
        try
          while not qryDefsFields.EOF do
          begin
            if lcmp.IndexOf(qryDefsFields.FieldByName('rdb$field_name').AsString) = -1 then
            begin
              tmp := tvDest.Items.AddChild(nrc, qryDefsFields.FieldByName('rdb$field_name').AsTrimString);
              tmp.InfoText := GetFieldTypeText(FDM.ibeDest, qryDefsFields);
              tmp.ImageIndex := Integer(picDestField);
              inc(k);
            end;
            qryDefsFields.Next;
          end;
          nrc.InfoText := '(' + IntToStr(k) + ')'
        finally
          qryDefsFields.Close;
        end;

        tmp := tvDest.Items.AddChild(nd, 'Source Table Fields');
        tmp.ImageIndex := Integer(picSourceFields);
        tmp.InfoText := '(0)';

        qryDep.CancelUpdates;
        qryDep.First;
        if FixLocate(qryDep, 'DEP', rd[i]) then
        begin
          nd.ImageIndex := Integer(picTableLinks);
          nrc := tvDest.Items.AddChild(nd, 'Ref Constraints');
          nrc.ImageIndex := Integer(picRefConsts);
          j := 0;
          while (TrimRight(qryDep.FindField('DEP').AsString) = rd[i]) and
                (not qryDep.EOF) do
          begin
            tmp := tvDest.Items.AddChild(nrc, TrimRight(qryDep.FindField('RDB$CONSTRAINT_NAME').AsString));
            tmp.InfoText := TrimRight(qryDep.FindField('SOURCE').AsString);
            tmp.ImageIndex := Integer(picRefConst);

            if disabledFK.IndexOf(Trim(qryDep.FindField('RDB$CONSTRAINT_NAME').AsString)) >= 0
            then begin
              nd.ImageIndex := Integer(picTableLoop);
              tmp.Tag := 1;    // mark FK node as disabled

              nrc.Expanded := True;
              nd.Expanded  := True;
            end;

            inc(j);
            FillFK(tmp);
            qryDep.Next;
          end;
          nrc.InfoText := '(' + IntToStr(j) + ')';
        end;
      end;
      SetSelInds(tvDest.Items.GetFirstNode);

      tvDestTr.Items.BeginUpdate;
      try
        tvDestTr.Items.Clear;
        qryDefGens.Close;
        qryDefGens.Database := FDM.DBDest;
        qryDefGens.Transaction := FDM.DBDest.DefaultTransaction;
        qryDefGens.ExecQuery;
        try
          while not qryDefGens.EOF do
          begin
            tmp := tvDestTr.Items.Add(nil, qryDefGens.Fields[0].AsTrimString);
            tmp.ImageIndex := 0;
            tmp.SelectedIndex := tmp.ImageIndex;
            tmp.Checked := False;
            qryDefGens.Next;
          end;
        finally
          qryDefGens.Close;
        end;
      finally
        tvDestTr.Items.EndUpdate;
      end;
    finally
      rd.Free;
      lst.Free;
      lcmp.Free;
      loop.Free;
      loopinf.Free;
      disabledFK.Free;
      tvDest.Items.EndUpdate;
      qryDep.Close;
      SetLength(tabCounts, 0);
    end;
  finally
    FDM.DBDest.Connected := False;
  end;
end;

procedure TibpMain.FillSourceDef;
var
  lst: TStringList;
  nd, tmp: TccTreeNode;
  i: integer;
begin
  FDM.DBSource.Connected := True;
  try
    FDM.DBSource.DefaultTransaction.StartTransaction;
    lst := TStringList.Create;
    tvSource.Items.BeginUpdate;
    try
      FDM.DBSource.GetTableNames(lst);
      lst.Sort;
      tvSource.Items.Clear;
      for i := 0 to lst.Count-1 do
      begin
        nd := tvSource.Items.AddChild(nil, lst[i]);
        nd.ImageIndex := Integer(picTableNoLinks);
        nd.Data := Pointer(0);

        qryDefsFields.Close;
        qryDefsFields.Database := FDM.DBSource;
        qryDefsFields.Transaction := FDM.DBSource.DefaultTransaction;
        qryDefsFields.Params[0].AsString := nd.TheText;
        qryDefsFields.ExecQuery;
        try
          while not qryDefsFields.EOF do
          begin
            tmp := tvSource.Items.AddChild(nd, qryDefsFields.FieldByName('rdb$field_name').AsTrimString);
            tmp.InfoText := GetFieldTypeText(FDM.ibeSource, qryDefsFields);
            tmp.ImageIndex := Integer(picSourceField);
            qryDefsFields.Next;
          end;
          nd.InfoText := '(' + IntToStr(qryDefsFields.RecordCount) + ')'
        finally
          qryDefsFields.Close;
        end;
      end;
      SetSelInds(tvSource.Items.GetFirstNode);

      tvSourceTr.Items.BeginUpdate;
      try
        tvSourceTr.Items.Clear;
        qryDefGens.Close;
        qryDefGens.Database := FDM.DBSource;
        qryDefGens.Transaction := FDM.DBSource.DefaultTransaction;
        qryDefGens.ExecQuery;
        try
          while not qryDefGens.EOF do
          begin
            tmp := tvSourceTr.Items.Add(nil, qryDefGens.Fields[0].AsTrimString);
            tmp.ImageIndex := 0;
            tmp.SelectedIndex := tmp.ImageIndex;
            tmp.Checked := False;
            tmp.Data := Pointer(0);
            qryDefGens.Next;
          end;
        finally
          qryDefGens.Close;
        end;
      finally
        tvSourceTr.Items.EndUpdate;
      end;
    finally
      tvSource.Items.EndUpdate;
      lst.Free;
    end;
  finally
    FDM.DBSource.Connected := False;
  end;
end;

procedure TibpMain.FillSourceDefDataset;
var
  lst: TStringList;
  nd, ndc: TccTreeNode;
  i, j: integer;
  ds: TDataset;
  ATableName: string;
  lErr: boolean;
begin
  lErr := False;

  case SrcType of
    pdtBDE:
      begin
        FDM.bdeDb.Connected := True;
        ds := bdeTable;
      end;
    pdtADO:
      begin
        FDM.adoDb.Connected := True;
        ds := adoTable;
      end;
  else
    raise Exception.Create(ErrSrc);
  end;

  try
    lst := TStringList.Create;

    tvSource.Items.BeginUpdate;
    try
      case SrcType of
        pdtBDE: Session.GetTableNames(FDM.bdeDb.DatabaseName, '', not FDM.bdeDb.IsSQLBased, False, lst);
        pdtADO: FDM.adoDb.GetTableNames(lst, False);
      else
        raise Exception.Create(ErrSrc);
      end;

      lst.Sort;

      tvSource.Items.Clear;
      for i := 0 to lst.Count-1 do
      begin
        nd := tvSource.Items.AddChild(nil, lst[i]);
        nd.ImageIndex := Integer(picTableNoLinks);
        nd.Data := nil;

        case SrcType of
          pdtBDE:
            begin
              if FDM.bdeDb.IsSQLBased and SrcQuoteFields
                then ATableName := GetSQLName(lst[i], SrcType, SrcSelect)
                else ATableName := lst[i];
              TTable(ds).TableName := ATableName;
            end;
          pdtADO:
            begin
              if SrcQuoteFields
                then ATableName := GetSQLName(lst[i], SrcType, SrcSelect)
                else ATableName := lst[i];
              TADOTable(ds).TableName := ATableName;
            end;
        else
          raise Exception.Create(ErrSrc);
        end;

        ds.Close;
        try
          ds.FieldDefs.Update;
          for j := 0 to ds.FieldDefs.Count-1 do
          begin
            ndc := tvSource.Items.AddChild(nd, ds.FieldDefs[j].Name);
            ndc.InfoText := GetTypeTextBde(ds.FieldDefs[j]);
            ndc.ImageIndex := Integer(picSourceField);
          end;
          nd.InfoText := Format('(%d)', [ds.FieldDefs.Count]);
        except
          lErr := True;
          nd.InfoText := 'error occurs';
          ds.FieldDefs.Clear;
        end;
      end;
      SetSelInds(tvSource.Items.GetFirstNode);

      tvSourceTr.Items.BeginUpdate;
      try
        tvSourceTr.Items.Clear;
      finally
        tvSourceTr.Items.EndUpdate;
      end;
    finally
      lst.Free;
      tvSource.Items.EndUpdate;
    end;
  finally
    FDM.bdeDb.Connected := False;
    FDM.adoDb.Connected := False;
  end;

  if lErr
    then PumpDlg(ErrSelect, mtWarning);
end;

procedure TibpMain.AutoSet;
var
  ns, nd: TccTreeNode;
  lBDE: boolean;
begin
  lBDE := (SrcType = pdtBDE) and (not FDM.bdeDb.IsSQLBased);
  tvDest.Items.BeginUpdate;
  try
    nd := tvDest.Items.GetFirstNode;
    while nd <> nil do
    begin
      ns := FindSourceTable(tvSource, nd.TheText, cbCase.Checked, cbSpace.Checked, lBDE);
      CleanSourceTable(nd);
      if ns <> nil then
      begin
        MakeTableLink(nd, ns, True, cbCase.Checked, cbSpace.Checked);
      end;
      nd := nd.GetNextSibling;
    end;
    SetSelInds(tvDest.Items.GetFirstNode);
  finally
    tvDest.Items.EndUpdate;
  end;

  tvDestTr.Items.BeginUpdate;
  try
    nd := tvDestTr.Items.GetFirstNode;
    while nd <> nil do
    begin
      ns := FindSourceTable(tvSourceTr, nd.TheText, cbCase.Checked, cbSpace.Checked);
      nd.InfoText := '';
      nd.Checked := False;
      if ns <> nil then
      begin
        nd.InfoText := ns.TheText;
        ns.Data := Pointer(Integer(ns.Data)+1);
        ns.TreeView.RedrawNode(ns);
        nd.Checked := True;
      end;
      nd := nd.GetNextSibling;
    end;
  finally
    tvDestTr.Items.EndUpdate;
  end;
end;

procedure TibpMain.CleanSourceTable(tn: TccTreeNode);
var
  tmp: TccTreeNode;
begin
  if (tn = nil)then exit;
  tvDest.Items.BeginUpdate;
  try
    tmp := FindSourceTable(tvSource, tn.InfoText);
    if tmp <> nil then
    begin
      tmp.Data := Pointer(Integer(tmp.Data)-1);
      tmp.TreeView.RedrawNode(tmp);
    end;
    tn.InfoText := '';
    tn.Checked := False;
    tn.Data := nil;
    tmp := FindTheNode(tn, picRelationFields);
    if tmp <> nil then
    begin
      tmp.DeleteChildren;
      tmp.InfoText := '(0)';
    end;
    tmp := FindTheNode(tn, picSourceFields);
    if tmp <> nil then
    begin
      tmp.DeleteChildren;
      tmp.InfoText := '(0)';
    end;
    UpdateFieldsStatus(tn);
  finally
    tvDest.Items.EndUpdate;
  end;
end;

procedure TibpMain.btnBuildRelationsClick(Sender: TObject);
var
  oldCur: TCursor;
begin
  oldCur := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    AutoSet;
  finally
    Screen.Cursor := oldCur;
  end;
end;

procedure TibpMain.tvDestInfoCustomDraw(Sender: TObject;
  TreeNode: TccTreeNode; AFont: TFont; var AColor, ABkColor: TColor);
begin
  if (TreeNode.Data = nil) and
     (TreeNode.SelectedIndex in [Integer(picTableNoLinks),
                                 Integer(picTableLinks),
                                 Integer(picTableLoop)])
    then AColor := clRed
    else
      if (TreeNode.SelectedIndex in [Integer(picTableNoLinks),
                                     Integer(picTableLinks),
                                     Integer(picTableLoop),
                                     Integer(picRelationField)])
        then AColor := clNavy;
  if (TreeNode.SelectedIndex = Integer(picRelationField)) and IsConst(TreeNode.InfoText)
    then AColor := clGreen;
end;

procedure TibpMain.ClearLinkForSelectedTable1Click(Sender: TObject);
begin
  CleanSourceTable(tvDest.Selected);
end;

procedure TibpMain.pmDestPopup(Sender: TObject);
var
  tmpTree: TccTreeView;
begin
  ClearLinkForSelectedTable1.Visible := (tvDest.Focused) and
                                        (tvDest.Selected <> nil) and
                                        (tvDest.Selected.ImageIndex <= Integer(picTableLoop));
  DeleterRelation1.Visible := ( (tvDestTr.Focused) and
                                (tvDestTr.Selected <> nil) and
                                (tvDestTr.Selected.InfoText <> '')
                               ) or
                              ( (tvDest.Focused) and
                                (tvDest.Selected <> nil) and
                                (tvDest.Selected.ImageIndex = Integer(picRelationField))
                               );
  ExpandAll1.Visible := (tvDest.Focused) or (tvSource.Focused);
  CollapseAll1.Visible := ExpandAll1.Visible;
  GetNodeChildsCount1.Visible := ExpandAll1.Visible;
  if ExpandAll1.Visible
    then GetCount1.Caption := 'Get Tables Count'
    else GetCount1.Caption := 'Get Generators Count';

  SelectAll1.Visible := (tvDest.Focused) or (tvDestTr.Focused);
  UnselectAll1.Visible := (tvDest.Focused) or (tvDestTr.Focused);
  Invert1.Visible := (tvDest.Focused) or (tvDestTr.Focused);
  AddConstant1.Visible := (
                           (tvDest.Focused) and
                           (tvDest.Selected <> nil) and
                           (
                            (tvDest.Selected.ImageIndex = Integer(picDestField)) or
                            ((tvDest.Selected.ImageIndex = Integer(picRelationField)) and
                             (not IsConst(tvDest.Selected.InfoText)))
                           )
                          ) or
                          ((tvDestTr.Focused) and (tvDestTr.Selected <> nil) and (not IsConst(tvDestTr.Selected.InfoText)));

  EditConstantExpressrion1.Visible := ( (tvDestTr.Focused) and
                                        (tvDestTr.Selected <> nil) and
                                        IsConst(tvDestTr.Selected.InfoText)
                                       ) or
                                      ( (tvDest.Focused) and
                                        (tvDest.Selected <> nil) and
                                        (tvDest.Selected.ImageIndex = Integer(picRelationField)) and
                                        IsConst(tvDest.Selected.InfoText)
                                       );

  tmpTree := GetFocusedTree;

  NewSQL1.Visible := tmpTree <> nil;
  ViewEditSQL1.Visible := (tmpTree <> nil) and
                          (tmpTree.Selected <> nil) and
                          (tmpTree.Selected.ImageIndex = Integer(picTableNoLinks)) and
                          (Pos(#0, tmpTree.Selected.Text) > 0);
  DeleteSQL1.Visible := ViewEditSQL1.Visible;
  CustomSQLWizard1.Visible := tvDest.Focused;
end;

procedure TibpMain.tvDestStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if not ( (tvDest.Selected <> nil) and
           ( (tvDest.Selected.ImageIndex = Integer(picSourceField)) or
             ((tvDest.Selected.Level = 0) and (Pos(#0, tvDest.Selected.Text) > 0)) ) )
    then CancelDrag;
end;

procedure TibpMain.tvDestDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  tmp: TccTreeNode;
begin
  Accept := False;
  tmp := tvDest.GetNodeAt(X,Y);
  if tmp <> nil then
  begin
    if Source = tvDest then
    begin
      if tvDest.Selected <> nil
        then Accept := ( (tmp.Level = 0) and (tvDest.Selected.Level = 0) ) or
                       ( (tvDest.Selected.ImageIndex = Integer(picSourceField)) and
                         (tmp.ImageIndex = Integer(picDestField)) and
                         (tvDest.Selected.Parent.Parent = tmp.Parent.Parent) );
    end;
    if Source = tvSource then
    begin
      if tvSource.Selected <> nil
        then  Accept := ( (tvSource.Selected.Level = 0) and (tmp.Level = 0) ) or
                        ( (tmp.ImageIndex = Integer(picDestField)) and
                          (tvSource.Selected.ImageIndex = Integer(picSourceField)) and
                          (tmp.Parent.Parent.InfoText = tvSource.Selected.Parent.TheText) );
    end;
  end;
end;

procedure TibpMain.tvDestDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  nd, sel, tmp, tmp2: TccTreeNode;
  lChecked: boolean;
begin
  tmp2 := nil;
  if Source = tvDest then
  begin
    sel := tvDest.GetNodeAt(X,Y);
    if (sel = nil) or (tvDest.Selected = nil) or (sel = tvDest.Selected) then exit;
    if tvDest.Selected.Level = 0 then
    begin
      lChecked := sel.Checked;
      tvDest.Selected.MoveTo(sel, naInsert);
      tvDest.Selected.Checked := lChecked;
    end
    else
    begin
      nd := FindTheNode(sel.Parent.Parent, picRelationFields);
      tmp := FindSourceField(nd, sel.TheText);
      if tmp <> nil then
      begin
        if PumpDlg('You already have link to this field! Overwrite it with new value?',
                   mtConfirmation,
                   [mbYes, mbNo], 0) = mrNo
          then Exit;
        tmp2 := sel.Parent.Parent;
        tmp2 := FindTheNode(tmp2, picSourceFields);
        if tmp2 <> nil then tmp2 := FindSourceField(tmp2, tmp.InfoText);
      end
      else
      begin
        tmp := tvDest.Items.AddChild(nd, sel.TheText);
      end;
      tmp.InfoText := tvDest.Selected.TheText;
      tmp.ImageIndex := Integer(picRelationField);
      tmp.SelectedIndex := tmp.ImageIndex;
      tmp.StateIndex := -1;
      UpdateStatus(nd.Parent);
      UpdateFieldsStatus(nd.Parent);
      nd.TreeView.RedrawNode(nd.Parent);
      nd.TreeView.RedrawNode(sel);
      nd.TreeView.RedrawNode(tvDest.Selected);
    end;
  end;
  if Source = tvSource then
  begin
    sel := tvDest.GetNodeAt(X,Y);
    if (sel = nil) or (tvSource.Selected = nil) then exit;
    if tvSource.Selected.Level = 0 then
    begin
      if sel.InfoText <> '' then
      begin
        if PumpDlg('You already have link to this table! Overwrite it with new value?',
                   mtConfirmation,
                   [mbYes, mbNo], 0) = mrNo
          then Exit;
      end;
      MakeTableLink(sel, tvSource.Selected, True, cbCase.Checked, cbSpace.Checked);
    end
    else
    begin
      nd := FindTheNode(sel.Parent.Parent, picRelationFields);
      tmp := FindSourceField(nd, sel.TheText);
      if tmp <> nil then
      begin
        if PumpDlg('You already have link to this field! Overwrite it with new value?',
                   mtConfirmation,
                   [mbYes, mbNo], 0) = mrNo
          then Exit;
        tmp2 := sel.Parent.Parent;
        tmp2 := FindTheNode(tmp2, picSourceFields);
        if tmp2 <> nil then tmp2 := FindSourceField(tmp2, tmp.InfoText);
      end
      else
      begin
        tmp := tvDest.Items.AddChild(nd, sel.TheText);
      end;
      tmp.InfoText := tvSource.Selected.TheText;
      tmp.ImageIndex := Integer(picRelationField);
      tmp.SelectedIndex := tmp.ImageIndex;
      tmp.StateIndex := -1;
      UpdateStatus(nd.Parent);
      UpdateFieldsStatus(nd.Parent);
      nd.TreeView.RedrawNode(nd.Parent);
      nd.TreeView.RedrawNode(sel);
      nd := FindTheNode(sel.Parent.Parent, picSourceFields);
      tmp := FindSourceField(nd, tvSource.Selected.TheText);
      if tmp <> nil then nd.TreeView.RedrawNode(tmp);
    end;
  end;
  if tmp2 <> nil then tmp2.TreeView.RedrawNode(tmp2);
end;

procedure TibpMain.tvDestCustomDraw(Sender: TObject; TreeNode: TccTreeNode;
  AFont: TFont; var AColor, ABkColor: TColor);
begin
  if (TreeNode.SelectedIndex in [Integer(picDestField), Integer(picSourceField)]) and
     (TreeNode.Data <> nil)
    then AFont.Style := [fsUnderline];

  // To be disabled FK
  if (TreeNode.SelectedIndex = Integer(picRefConst)) and
     (TreeNode.Tag = 1) then
  begin
    AFont.Style := AFont.Style + [fsUnderline];
  end;

  if Pos(#0, TreeNode.Text) > 0 then
  begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TibpMain.tvDestDblClick(Sender: TObject);
var
  tmp: TccTreeNode;
begin
  if (tvDest.Selected <> nil) and
     (tvDest.Selected.ImageIndex in [Integer(picDestField), Integer(picSourceField)]) and
     (tvDest.Selected.Data <> nil) then
  begin
    tmp := tvDest.Selected.Parent.Parent;
    tmp := FindTheNode(tmp, picRelationFields);
    if tmp = nil then exit;
    tmp := FindSourceField(tmp,
                           tvDest.Selected.TheText,
                           (tvDest.Selected.ImageIndex = Integer(picSourceField)));
    if tmp = nil then exit;
    tmp.MakeVisible;
    tmp.TreeView.Selected := tmp;
    exit;
  end;

  if (tvDest.Selected <> nil) and
     (tvDest.Selected.ImageIndex = Integer(picRelationField)) then
  begin
    if GetAsyncKeyState(VK_CONTROL) < 0 then
    begin
      if IsConst(tvDest.Selected.InfoText) then
      begin
        EditConstExpr(tvDest.Selected);
        exit;
      end
      else
      begin
        tmp := tvDest.Selected.Parent.Parent;
        tmp := FindTheNode(tmp, picSourceFields);
        if tmp = nil then exit;
        tmp := FindSourceField(tmp, tvDest.Selected.InfoText);
      end;  
    end
    else
    begin
      tmp := tvDest.Selected.Parent.Parent;
      tmp := FindTheNode(tmp, picDestFields);
      if tmp = nil then exit;
      tmp := FindSourceField(tmp, tvDest.Selected.TheText);
    end;
    if tmp = nil then exit;
    tmp.MakeVisible;
    tmp.TreeView.Selected := tmp;
    exit;
  end;

  if (tvDest.Selected <> nil) and
     (tvDest.Selected.ImageIndex <= Integer(picTableLoop)) and
     (tvDest.Selected.InfoText <> '') then
  begin
    tmp := tvSource.Items.GetFirstNode;
    while tmp <> nil do
    begin
      if tmp.TheText = tvDest.Selected.InfoText then
      begin
        tvSource.Selected := tmp;
        tmp.MakeVisible;
        exit;
      end;
      tmp := tmp.GetNextSibling;
    end;
    exit;
  end;
end;
                                                                            
procedure TibpMain.DeleterRelation1Click(Sender: TObject);
var
  tmp: TccTreeNode;
begin
  if tvDest.Focused then
  begin
    if (tvDest.Selected = nil) or
       (tvDest.Selected.SelectedIndex <> Integer(picRelationField)) then exit;
    tvDest.Items.BeginUpdate;
    try
      tmp := tvDest.Selected.Parent.Parent;
      tvDest.Selected.Delete;
      UpdateStatus(tmp);
      UpdateFieldsStatus(tmp);
    finally
      tvDest.Items.EndUpdate;
    end;
  end;  
  if tvDestTr.Focused then
  begin
    if (tvDestTr.Selected = nil) then Exit;
    tmp := FindSourceTable(tvSourceTr, tvDestTr.Selected.InfoText);
    if tmp <> nil then
    begin
      tmp.Data := Pointer(Integer(tmp.Data)-1);
      tmp.TreeView.RedrawNode(tmp);
    end;
    tvDestTr.Selected.InfoText := '';
    tvDestTr.Selected.Checked := False;
  end;
end;

procedure TibpMain.btnSaveProfileClick(Sender: TObject);
var
  fs: TFileStream;
  oldCur: TCursor;
begin
  oldCur := Screen.Cursor;
  try
    if not sd.Execute then exit;
    Screen.Cursor := crHourGlass;
    fs := TFileStream.Create(sd.FileName, fmCreate);
    try
      ibpstore.Clear;
      with ibpstore do
      begin
        Version := StorageVersion;
        sName := eSourceDatabase.Text;
        sUser := eSUserName.Text;
        sPass := eSPassword.Text;
        sRole := eSRole.Text;
        sChar := cbSCharSet.ItemIndex;
        sDialect := SrcDialect;
        dName := eDestDatabase.Text;
        dUser := eDUserName.Text;
        dPass := eDPassword.Text;
        dRole := eDRole.Text;
        dChar := cbDCharSet.ItemIndex;
        dDialect := DestDialect;
        DisableTriggers := cbDisableTriggers.Checked;
        EmptyTables := cbEmpty.Checked;
        UpdateGenerators := cbUpdateGenerators.Checked;
        StopOnErrors := cbStopErr.Checked;
        StopAfterErrors := upErrCnt.Value;
        CommitData := cbCommitEvery.Checked;
        CommitEvery := upCommit.Value;
        SourceType := TPumpDatabaseType(cbBde.ItemIndex);
        Alias := cbAlias.Text;
        ConvBool := cbBool.Checked;
        BoolTrue := eBoolTrue.Text;
        BoolFalse := eBoolFalse.Text;
        SrcSelect := Self.SrcSelect;
        SrcQuoteFields := Self.SrcQuoteFields;
        ChCase := cbCase.Checked;
        Space := cbSpace.Checked;
        TruncString := cbTruncString.Checked;
        RemSpace := cbRemSpace.Checked;
        RemSpaceOpt := cbRemSpaceOpt.ItemIndex;
        OffLoop := cbLoop.Checked;
        ConnectionString := eADOSource.Text;
        SaveReportTo := ccSaveReport.Text; 
      end;
      fs.WriteComponent(ibpstore);
      fs.WriteComponent(tvDest);
      fs.WriteComponent(tvSource);
      fs.WriteComponent(tvDestTr);
      fs.WriteComponent(tvSourceTr);
    finally
      fs.Free;
    end;
  finally
    Screen.Cursor := oldCur;
  end;
end;

procedure TibpMain.btnLoadProfileClick(Sender: TObject);
var
  fs: TFileStream;
  oldCur: TCursor;
begin
  oldCur := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    if IsParamMode then
    begin
      fs := TFileStream.Create(ParamFile, fmOpenRead);
    end
    else
    begin
      if not op.Execute then exit;
      fs := TFileStream.Create(op.FileName, fmOpenRead);
    end;
    try
      ibpstore.Clear;
      try
        fs.ReadComponent(ibpstore);
      except
        if (Length(ibpstore.Version) > 0) and
          (ibpstore.Version <> StorageVersion)
          then PumpDlg(Format('Profile should be version %s or older (v %s found)!', [StorageVersion, ibpstore.Version]), mtError)
          else PumpDlg('Wrong profile format detected!', mtError);
        exit;
      end;
      with ibpstore do
      begin
        eSourceDatabase.Text := sName;
        eSUserName.Text := sUser;
        eSPassword.Text := sPass;
        eSRole.Text := sRole;
        cbSCharSet.ItemIndex := sChar;
        SrcDialect := sDialect;
        eDestDatabase.Text := dName;
        eDUserName.Text := dUser;
        eDPassword.Text := dPass;
        eDRole.Text := dRole;
        cbDCharSet.ItemIndex := dChar;
        DestDialect := dDialect;
        cbDisableTriggers.Checked := DisableTriggers;
        cbEmpty.Checked := EmptyTables;
        cbUpdateGenerators.Checked := UpdateGenerators;
        cbStopErr.Checked := StopOnErrors;
        upErrCnt.Value := StopAfterErrors;
        cbCommitEvery.Checked := CommitData;
        upCommit.Value := CommitEvery;
        cbBde.ItemIndex := Integer(SourceType);
        cbBdeChange(nil);
        cbAlias.Text := ibpstore.Alias;
        cbBool.Checked := ConvBool;
        eBoolTrue.Text := BoolTrue;
        eBoolFalse.Text := BoolFalse;
        cbCase.Checked := ChCase;
        cbSpace.Checked := Space;
        Self.SrcSelect := SrcSelect;
        Self.SrcQuoteFields := SrcQuoteFields;
        cbTruncString.Checked := TruncString;
        cbRemSpace.Checked := RemSpace;
        cbRemSpaceOpt.ItemIndex := RemSpaceOpt;
        cbLoop.Checked := OffLoop;
        eADOSource.Text := ConnectionString;
        ccSaveReport.Text := SaveReportTo;
      end;

      try
        tvDest.Items.BeginUpdate;
        try
          tvDest.Items.Clear;
          fs.ReadComponent(tvDest);
        finally
          tvDest.Items.EndUpdate;
          SetSelInds(tvDest.Items.GetFirstNode);
        end;

        tvSource.Items.BeginUpdate;
        try
          tvSource.Items.Clear;
          fs.ReadComponent(tvSource);
        finally
          tvSource.Items.EndUpdate;
        end;

        tvDestTr.Items.BeginUpdate;
        try
          tvDestTr.Items.Clear;
          tvDestTr.Images := ilImages;
          fs.ReadComponent(tvDestTr);
          tvDestTr.Images := nil;
        finally
          tvDestTr.Items.EndUpdate;
        end;

        tvSourceTr.Items.BeginUpdate;
        try
          tvSourceTr.Items.Clear;
          tvSourceTr.Images := ilImages;
          fs.ReadComponent(tvSourceTr);
          tvSourceTr.Images := nil;
          tvSourceTr.ShowRoot := True;
        finally
          tvSourceTr.Items.EndUpdate;
        end;
      finally
        SetSource;
        SetDest;
      end;
    finally
      fs.Free;
    end;
  finally
    Screen.Cursor := oldCur;
  end;
end;

procedure TibpMain.btnNewProfileClick(Sender: TObject);
begin
  RepStart;
  tvDest.Items.BeginUpdate;
  try
    tvDest.Items.Clear;
  finally
    tvDest.Items.EndUpdate;
  end;
  tvSource.Items.BeginUpdate;
  try
    tvSource.Items.Clear;
  finally
    tvSource.Items.EndUpdate;
  end;
  tvDestTr.Items.BeginUpdate;
  try
    tvDestTr.Items.Clear;
  finally
    tvDestTr.Items.EndUpdate;
  end;
  tvSourceTr.Items.BeginUpdate;
  try
    tvSourceTr.Items.Clear;
  finally
    tvSourceTr.Items.EndUpdate;
  end;
  SetDefSettings;
  Pages.ActivePage := tsDatabases;
  PropPage.ActivePage := tsPumpProp;
  if eSourceDatabase.CanFocus then eSourceDatabase.SetFocus;
  if cbAlias.CanFocus then cbAlias.SetFocus;
end;

procedure TibpMain.btnHelpClick(Sender: TObject);
begin
  ShellExecute( 0, PChar('open'), PChar(AppHelp), nil, nil, SW_RESTORE);
end;

procedure TibpMain.btnAboutClick(Sender: TObject);
var
  FHelp: TibpHelp;
begin
  FHelp := TibpHelp.Create(Self);
  try
    FHelp.Logo.Refresh;
    FHelp.ShowModal;
  finally
    FHelp.Free;
  end;
end;

procedure TibpMain.SetDefSettings;
begin
  cbBde.ItemIndex := 0;
  cbBdeChange(nil);
  eSourceDatabase.Text := '';
  eSUserName.Text := 'SYSDBA';
  eSPassword.Text := 'masterkey';
  eSRole.Text := '';
  cbSCharSet.ItemIndex := 0;
  SrcDialect := 0;
  eDestDatabase.Text := '';
  eDUserName.Text := 'SYSDBA';
  eDPassword.Text := 'masterkey';
  eDRole.Text := '';
  cbDCharSet.ItemIndex := 0;
  DestDialect := 2;
  cbDisableTriggers.Checked := True;
  cbEmpty.Checked := False;
  cbUpdateGenerators.Checked := True;
  cbStopErr.Checked := False;
  upErrCnt.Value := 1;
  cbCommitEvery.Checked := True;
  upCommit.Value := 1000;
  cbLoop.Checked := True;
  cbBool.Checked := True;
  eBoolFalse.Text := 'N';
  eBoolTrue.Text := 'Y';
  cbCase.Checked := True;
  cbSpace.Checked := True;
  SrcSelect := 0;
  SrcQuoteFields := False;
  cbTruncString.Checked := False;
  cbRemSpace.Checked := False;
  cbRemSpaceOpt.ItemIndex := 0;
  eADOSource.Text := '';
  ccSaveReport.Text := '';

  PageObj.ActivePage := tsTables;
end;

procedure TibpMain.FillFK(tn: TccTreeNode);
var
  td, tmp: TccTreeNode;
  find, pind: string;
  drul, urul: string;
  i: integer;
begin
  try
    if not qryDest.Transaction.Active
      then qryDest.Transaction.StartTransaction;
    qryDest.Close;
    qryDest.SQL.Clear;
    qryDest.SQL.Add('SELECT cf.RDB$INDEX_NAME, cp.RDB$INDEX_NAME,');
    qryDest.SQL.Add('       r.RDB$UPDATE_RULE, r.RDB$DELETE_RULE');
    qryDest.SQL.Add('FROM RDB$RELATION_CONSTRAINTS cf,');
    qryDest.SQL.Add('     RDB$REF_CONSTRAINTS r,');
    qryDest.SQL.Add('     RDB$RELATION_CONSTRAINTS cp');
    qryDest.SQL.Add('WHERE cf.RDB$CONSTRAINT_NAME  = :PAR and');
    qryDest.SQL.Add('r.RDB$CONSTRAINT_NAME = cf.RDB$CONSTRAINT_NAME and');
    qryDest.SQL.Add('cp.RDB$CONSTRAINT_NAME = r.RDB$CONST_NAME_UQ');
    qryDest.Params[0].AsString := tn.TheText;
    qryDest.ExecQuery;
    find := qryDest.Fields[0].AsTrimString;
    pind := qryDest.Fields[1].AsTrimString;
    urul := qryDest.Fields[2].AsTrimString;
    drul := qryDest.Fields[3].AsTrimString;

    if drul = 'RESTRICT'
      then drul := ''
      else drul := ' ON DELETE ' + drul;

    if urul = 'RESTRICT'
      then urul := ''
      else urul := ' ON UPDATE ' + urul;

    tmp := tvDest.Items.AddChild(tn, 'Constraint Options');
    tmp.InfoText := urul + drul;
    tmp.ImageIndex := Integer(picRefConstOpt);

    td := tvDest.Items.AddChild(tn, 'Foreign Fields');
    td.ImageIndex := Integer(picRefConstForFields);

    qryDest.Close;
    qryDest.SQL.Clear;
    qryDest.SQL.Add('SELECT RDB$FIELD_NAME');
    qryDest.SQL.Add('FROM RDB$INDEX_SEGMENTS');
    qryDest.SQL.Add('WHERE RDB$INDEX_NAME=:PAR');
    qryDest.SQL.Add('ORDER BY RDB$FIELD_POSITION');
    qryDest.Params[0].AsString := find;
    qryDest.ExecQuery;
    i := 0;
    while not qryDest.EOF do
    begin
      tmp := tvDest.Items.AddChild(td, qryDest.Fields[0].AsTrimString);
      tmp.ImageIndex := Integer(picRefConstForField);
      inc(i);
      qryDest.Next;
    end;
    td.InfoText := '(' + IntToStr(i) + ')';

    td := tvDest.Items.AddChild(tn, 'References Fields');
    td.ImageIndex := Integer(picRefConstRefFields);

    qryDest.Close;
    qryDest.Params[0].AsString := pind;
    qryDest.ExecQuery;
    i := 0;
    while not qryDest.EOF do
    begin
      tmp := tvDest.Items.AddChild(td, qryDest.Fields[0].AsTrimString);
      tmp.ImageIndex := Integer(picRefConstRefField);
      inc(i);
      qryDest.Next;
    end;
    td.InfoText := Format('(%d)', [i]);
  finally
    qryDest.Close;
  end;
end;

function TibpMain.CheckValues: boolean;
var
  mes: TStringList;
begin
  result := False;
  mes := TStringList.Create;
  try
    if cbLoop.Checked and (DestInfo.UserNames.Count > 1) then
    begin
      mes.Add('Can not Proceed:');
      mes.Add('"Switch Off all Ref. Constraints which have loop" option');
      mes.Add('require exclusive access to database,');
      mes.Add('but following users still connected:');
      mes.AddStrings(DestInfo.UserNames);
      PumpDlg(mes.Text);
      exit;
    end;
    if (not IsParamMode) and (DestInfo.ForcedWrites = 1) then
    begin
      mes.Add('Destination database is in ForcedWrites mode.');
      mes.Add('This make whole pump process three time slower!');
      mes.Add('Continue?');
      if PumpDlg(mes.Text, mtConfirmation, [mbYes, mbNo], 0) <> mrYes
        then exit;
    end;

    if FDM.DBSource.Connected and (Succ(SrcDialect) <> SrcInfo.DBSQLDialect) then
      if PumpDlg(Format(' !  Warning: Actual Source database dialect is: %s. Continue?', [SrcInfo.DBSQLDialect]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes
        then exit;

    if FDM.DBDest.Connected and (Succ(DestDialect) <> DestInfo.DBSQLDialect) then
      if PumpDlg(Format(' !  Warning: Actual Dest database dialect is: %s. Continue?', [DestInfo.DBSQLDialect]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes
        then exit;

    result := True;
  finally
    mes.Free;
  end;
end;

function TibpMain.GetNameLst(tn: TccTreeNode; AType: TPumpDatabaseType; ASQLDialect: integer): string;
var
  tmp: TccTreeNode;
  lst: TStringList;
  i: integer;
begin
  lst := TStringList.Create;
  try
    tmp := tn.GetFirstChild;
    while tmp <> nil do
    begin
      lst.Add(GetSQLName(tmp.TheText, AType ,ASQLDialect));
      tmp := tn.GetNextChild(tmp);
    end;
    SetLength(result, 0);
    for i := 0 to lst.Count-2
      do result := result + lst[i] + ',';
    if lst.Count > 0
      then result := result + lst[lst.Count-1];
  finally
    lst.Free;
  end;
end;

procedure TibpMain.AlterConst(lOn: boolean);
var
  nd, rn, cons, fk, rk, opt: TccTreeNode;
  ASQLCons, ASQLFields, ASQLFieldsRel, ASQLTable, AMaster: string;
begin
  if not cbLoop.Checked then Exit;
  if lOn
    then RepLine('=== Switch On all Ref. Constraints with loop')
    else RepLine('=== Switch Off all Ref. Constraints with loop');
  nd := tvDest.Items.GetFirstNode;
  while nd <> nil do
  begin
    if nd.Checked and (nd.ImageIndex = Integer(picTableLoop)) then
    begin
      rn := FindTheNode(nd, picRefConsts);
      cons := rn.GetFirstChild;
      while cons <> nil do
      begin
        if cons.Tag = 1 then // disabled FK found
        begin
          ASQLTable := GetSQLName(nd.TheText, pdtIB, DestDialect);
          AMaster   := GetSQLName(cons.InfoText, pdtIB, DestDialect);
          ASQLCons  := GetSQLName(cons.TheText, pdtIB, DestDialect);
          qryDest.Close;
          qryDest.SQL.Clear;
          if lOn then
          begin
            opt := FindTheNode(cons, picRefConstOpt);
            fk := FindTheNode(cons, picRefConstForFields);
            rk := FindTheNode(cons, picRefConstRefFields);
            ASQLFields := GetNameLst(fk, pdtIB, DestDialect);
            ASQLFieldsRel := GetNameLst(rk, pdtIB, DestDialect);
            qryDest.SQL.Add(Format('ALTER TABLE %s', [ASQLTable]));
            qryDest.SQL.Add(Format(' ADD CONSTRAINT %s', [ASQLCons]));
            qryDest.SQL.Add(Format('  FOREIGN KEY (%s)', [ASQLFields]));
            qryDest.SQL.Add(Format('  REFERENCES %s (%s) %s', [AMaster, ASQLFieldsRel, opt.InfoText]));
          end
          else
          begin
            qryDest.SQL.Add(Format('ALTER TABLE %s DROP CONSTRAINT %s', [ASQLTable, ASQLCons]));
          end;
          RepStr(qryDest.SQL);
          try
            qryDest.Prepare;
            qryDest.ExecQuery;
          finally
            qryDest.Close;
          end;
        end;
        cons := rn.GetNextChild(cons);
      end;
    end;
    nd := nd.GetNextSibling;
  end;
end;

procedure TibpMain.tvDestTrDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  if Source = tvSourceTr then
  begin
    if (tvSourceTr.Selected <> nil) and (tvSourceTr.Selected.Level = 0)
      then Accept := tvDestTr.GetNodeAt(X,Y) <> nil;
  end;
end;

procedure TibpMain.tvDestTrDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  sel, tmp: TccTreeNode;
begin
  tmp := nil;
  if Source = tvSourceTr then
  begin
    sel := tvDestTr.GetNodeAt(X,Y);
    if (sel = nil) or (tvSourceTr.Selected = nil) then exit;
    if sel.InfoText <> '' then
    begin
      if PumpDlg('You already have link to this trigger! Overwrite it with new value?',
                 mtConfirmation,
                 [mbYes, mbNo], 0) = mrNo
        then Exit;
      tmp := FindSourceTable(tvSourceTr, sel.InfoText);
      if tmp <> nil then tmp.Data := Pointer(Integer(tmp.Data)-1);
    end;
    sel.InfoText := tvSourceTr.Selected.TheText;
    sel.Checked := True;
    tvSourceTr.Selected.Data := Pointer(Integer(tvSourceTr.Selected.Data)+1);
    tvSourceTr.RedrawNode(tvSourceTr.Selected);
    if tmp <> nil
      then tmp.TreeView.RedrawNode(tmp);
  end;
end;
  
procedure TibpMain.tvDestTrDblClick(Sender: TObject);
var
  tmp: TccTreeNode;
begin
  if (tvDestTr.Selected <> nil) and
     (tvDestTr.Selected.InfoText <> '') then
  begin
    if IsConst(tvDestTr.Selected.InfoText) then
    begin
      EditConstExpr(tvDestTr.Selected);
    end
    else
    begin
      tmp := tvSourceTr.Items.GetFirstNode;
      while tmp <> nil do
      begin
        if tmp.TheText = tvDestTr.Selected.InfoText then
        begin
          tvSourceTr.Selected := tmp;
          tmp.MakeVisible;
          exit;
        end;
        tmp := tmp.GetNextSibling;
      end;
    end;
  end;
end;

procedure TibpMain.tvSourceDblClick(Sender: TObject);
var
  tmp: TccTreeNode;
begin
  if (tvSource.Selected <> nil) then
  begin
    tmp := tvDest.Items.GetFirstNode;
    while tmp <> nil do
    begin
      if tmp.InfoText = tvSource.Selected.TheText then
      begin
        tvDest.Selected := tmp;
        tmp.MakeVisible;
        exit;
      end;
      tmp := tmp.GetNextSibling;
    end;
    exit;
  end;
end;

procedure TibpMain.tvSourceTrDblClick(Sender: TObject);
var
  tmp: TccTreeNode;
begin
  if (tvSourceTr.Selected <> nil) then
  begin
    tmp := tvDestTr.Items.GetFirstNode;
    while tmp <> nil do
    begin
      if tmp.InfoText = tvSourceTr.Selected.TheText then
      begin
        tvDestTr.Selected := tmp;
        tmp.MakeVisible;
        exit;
      end;
      tmp := tmp.GetNextSibling;
    end;
    exit;
  end;
end;

procedure TibpMain.tvSourceCustomDraw(Sender: TObject;
  TreeNode: TccTreeNode; AFont: TFont; var AColor, ABkColor: TColor);
begin
  if (TreeNode.Level = 0) and (Integer(TreeNode.Data) > 0)
    then AColor := clNavy;
  if Pos(#0, TreeNode.Text) > 0 then
  begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TibpMain.SelectAll1Click(Sender: TObject);
var
  nd: TccTreeNode;
begin
  nd := nil;
  if tvDest.Focused then nd := tvDest.Items.GetFirstNode;
  if tvDestTr.Focused then nd := tvDestTr.Items.GetFirstNode;
  while nd <> nil do
  begin
    case TMenuItem(Sender).Tag of
      0: nd.Checked := True;
      1: nd.Checked := False;
      2: nd.Checked := not nd.Checked;
    end;
    nd := nd.GetNextSibling;
  end;
end;

procedure TibpMain.cbBdeChange(Sender: TObject);
begin
  SetView;
end;

procedure TibpMain.SetView;
var
  str: string;
  i: integer;
begin
  FSrcType := TPumpDatabaseType(cbBde.ItemIndex);

  try
    eSourceDatabase.Visible := SrcType = pdtIB;
    cbAlias.Visible := SrcType = pdtBDE;
    eADOSource.Visible := SrcType = pdtADO;

    upSrcDialect.Visible := SrcType = pdtIB;
    eSRole.Visible := SrcType = pdtIB;
    cbSCharSet.Visible := SrcType = pdtIB;
    lSDialect.Visible := SrcType = pdtIB;
    lsRole.Visible := SrcType = pdtIB;
    lsCharacterSet.Visible := SrcType = pdtIB;

    lBoolFalse.Visible := SrcType <> pdtIB;
    lBoolTrue.Visible := SrcType <> pdtIB;
    cbBool.Visible := SrcType <> pdtIB;
    eBoolFalse.Visible := SrcType <> pdtIB;
    eBoolTrue.Visible := SrcType <> pdtIB;
    btnGenSql.Visible := SrcType <> pdtIB;
    cbSrcSelect.Visible := SrcType <> pdtIB;
    cbSrcQuoteFields.Visible := SrcType <> pdtIB;
    lSelectOpt.Visible := SrcType <> pdtIB;

    if SrcType = pdtBDE then
    begin
      str := cbAlias.Text;
      cbAlias.Items.Clear;
      Session.GetAliasNames(cbAlias.Items);
      i := cbAlias.Items.IndexOf(str);
      if i > -1
        then cbAlias.ItemIndex := i;
    end;
  finally
  end;
end;

procedure TibpMain.btnGenSqlClick(Sender: TObject);
begin
  if SrcType = pdtIB then
  begin
    PumpDlg('This option is not available for Interbase sources. ' +
            'It was designed to generate SQL script for creation of Interbase database based on BDE or ADO source.',
            mtInformation,
            [mbOk], 0);
  end
  else
  begin
    SetSource;
    DoGenSql(Self);
  end;
end;

procedure TibpMain.RepStart;
begin
  if IsParamMode
    then exit;

  memRep.Lines.Clear;
  rep.Clear;

  if IsWin95 then
  begin
    memRep.Lines.Add('Windows 95 detected!');
    memRep.Lines.Add('Output will be processed to file.');
    memRep.Lines.Add('Running...');
  end;
end;

procedure TibpMain.RepStop;
var
  str: string;
begin
  if Length(Trim(ccSaveReport.Text)) > 0 then
  begin
    try
      if IsWin95
        then rep.SaveToFile(ccSaveReport.Text)
        else memRep.Lines.SaveToFile(ccSaveReport.Text);
      RepLine(Format('Report Saved To %s' ,[ccSaveReport.Text]))
    except
      on E: Exception do
      begin
        RepLine(Format('Can not save report to %s, error: ' ,[ccSaveReport.Text, E.Message]))
      end;
    end;
  end;

  if IsParamMode
    then exit;

  if IsWin95 then
  begin
    memRep.Lines.Add('Done.');
    str := Format('%s\rep.txt', [ExtractFileDir(Application.ExeName)]);
    memRep.Lines.Add(Format('Writing report to %s...', [str]));
    rep.SaveToFile(str);
    rep.Clear;
    ShellExecute(Self.Handle,
                 'open',
                 PChar('notepad.exe'),
                 PChar(str),
                 nil,
                 SW_SHOWNORMAL);
  end;
end;

procedure TibpMain.RepLine(const str: string);
begin
  if IsParamMode then
  begin
    if Assigned(ParamCallBack)
      then ParamCallBack(PChar(str));
    exit;
  end;

  if IsWin95
    then rep.Add(str)
    else memRep.Lines.Add(str);
end;

procedure TibpMain.RepStr(lst: TStrings);
var
  i: integer;
begin
  if IsParamMode then
  begin
    for i := 0 to lst.Count-1
      do RepLine(lst[i]);
    exit;
  end;

  if IsWin95
    then rep.AddStrings(lst)
    else memRep.Lines.AddStrings(lst);
end;

function TibpMain.PumpDlg(const Msg: string;
                        DlgType: TMsgDlgType = mtInformation;
                        Buttons: TMsgDlgButtons = [mbOK]; HelpCtx: Longint = 0): Word;
begin
  result := mrNo;
  if IsParamMode then
  begin
    ParamRes := -1;
    RepLine(Format('!!!MESSAGE DIALOG: %s! %s', [PumpMsgDlgType[DlgType],Msg]));
  end
  else
  begin
    result := MessageDlg(Msg, DlgType, Buttons, HelpCtx);
  end;
end;

procedure TibpMain.AppException(Sender: TObject; E: Exception);
begin
  if IsParamMode then
  begin
    ParamRes := -1;
    RepLine(Format('!!!EXCEPTION: %s', [E.Message]));
  end
  else
  begin
    Application.ShowException(E);
  end;
end;

procedure TibpMain.eSourceDatabaseButtonClick(Sender: TObject);
begin
  gdbop.FileName := TCustomEdit(Sender).Text;
  if gdbop.Execute
    then TCustomEdit(Sender).Text := gdbop.FileName;
end;

procedure TibpMain.eADOSourceButtonClick(Sender: TObject);
begin
  eADOSource.Text := PromptDataSource(Self.Handle, eADOSource.Text);
  FDM.adoDb.ConnectionString := eADOSource.Text;
end;

procedure TibpMain.AddConstant1Click(Sender: TObject);
var
  res: string;
  nd, sel, tmp, tmp2: TccTreeNode;
begin
  tmp2 := nil;
  res := InputBox('Add Constant Expression', 'Expression', '');
  // Dest Field
  if (tvDest.Focused) and (tvDest.Selected <> nil) and (tvDest.Selected.ImageIndex = Integer(picDestField)) then
  begin
    sel := tvDest.Selected;
    nd := FindTheNode(sel.Parent.Parent, picRelationFields);
    tmp := FindSourceField(nd, sel.TheText);
    if tmp <> nil then
    begin
      if PumpDlg('You already have link to this field! Overwrite it with new value?',
                 mtConfirmation,
                 [mbYes, mbNo], 0) = mrNo
        then Exit;
      tmp2 := sel.Parent.Parent;
      tmp2 := FindTheNode(tmp2, picSourceFields);
      if tmp2 <> nil
        then tmp2 := FindSourceField(tmp2, sel.TheText);
    end
    else
    begin
      tmp := tvDest.Items.AddChild(nd, sel.TheText);
    end;
    tmp.InfoText := SetConst(res);
    tmp.ImageIndex := Integer(picRelationField);
    tmp.SelectedIndex := tmp.ImageIndex;
    tmp.StateIndex := -1;
    UpdateStatus(nd.Parent);
    UpdateFieldsStatus(nd.Parent);
    nd.TreeView.RedrawNode(nd.Parent);
    nd.TreeView.RedrawNode(sel);
    nd.TreeView.RedrawNode(tvDest.Selected);
    if tmp2 <> nil
      then tmp2.TreeView.RedrawNode(tmp2);
  end;
  // Relation Field
  if (tvDest.Focused) and (tvDest.Selected <> nil) and (tvDest.Selected.ImageIndex = Integer(picRelationField)) then
  begin
    sel := tvDest.Selected;
    if PumpDlg('You already have link to this field! Overwrite it with new value?',
               mtConfirmation,
               [mbYes, mbNo], 0) = mrNo
      then Exit;
    tmp2 := sel.Parent.Parent;
    tmp2 := FindTheNode(tmp2, picSourceFields);
    if tmp2 <> nil
      then tmp2 := FindSourceField(tmp2, sel.InfoText);
    sel.InfoText := SetConst(res);
    UpdateStatus(sel.Parent.Parent);
    UpdateFieldsStatus(sel.Parent.Parent);
    sel.TreeView.RedrawNode(sel.Parent.Parent);
    sel.TreeView.RedrawNode(sel);
    if tmp2 <> nil
      then tmp2.TreeView.RedrawNode(tmp2);
  end;
  // Dest Trigger
  if (tvDestTr.Focused) and (tvDestTr.Selected <> nil) then
  begin
    sel := tvDestTr.Selected;
    if sel.InfoText <> '' then
    begin
      if PumpDlg('You already have link to this trigger! Overwrite it with new value?',
                 mtConfirmation,
                 [mbYes, mbNo], 0) = mrNo
        then Exit;
      tmp2 := FindSourceTable(tvSourceTr, sel.InfoText);
      if tmp2 <> nil then tmp2.Data := Pointer(Integer(tmp2.Data)-1);
    end;
    sel.InfoText := SetConst(res);
    sel.Checked := True;
    if tmp2 <> nil then tmp2.TreeView.RedrawNode(tmp2);
  end;
end;

procedure TibpMain.EditConstantExpressrion1Click(Sender: TObject);
begin
  if (tvDestTr.Focused) and (tvDestTr.Selected <> nil) and IsConst(tvDestTr.Selected.InfoText)
    then EditConstExpr(tvDestTr.Selected);
  if (tvDest.Focused) and
     (tvDest.Selected <> nil) and
     (tvDest.Selected.ImageIndex = Integer(picRelationField)) and
     IsConst(tvDest.Selected.InfoText)
    then EditConstExpr(tvDest.Selected);
end;

procedure TibpMain.EditConstExpr(ANode: TccTreeNode);
var
  res: string;
begin
  res := InputBox('Edit Constant Expression', 'Expression', GetConst(ANode.InfoText));
  if res <> GetConst(ANode.InfoText)
    then ANode.InfoText := SetConst(res);
end;

procedure TibpMain.tvDestTrInfoCustomDraw(Sender: TObject;
  TreeNode: TccTreeNode; AFont: TFont; var AColor, ABkColor: TColor);
begin
  if IsConst(TreeNode.InfoText)
    then AColor := clGreen;
end;

procedure TibpMain.tvDestMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ANode: TccTreeNode;
begin
  if Button = mbRight then
  begin
    ANode := TccTreeView(Sender).GetNodeAt(X,Y);
    if ANode <> nil
      then ANode.Selected := True;
  end;
end;

function TibpMain.GetSourceDB: string;
begin
  case SrcType of
    pdtIB: result := eSourceDatabase.Text;
    pdtBDE: result := cbAlias.Text;
    pdtADO: result := eADOSource.Text;
  else
    raise Exception.Create(ErrSrc);
  end;
end;

function TibpMain.GetDestDB: string;
begin
 result := eDestDatabase.Text;
end;

procedure TibpMain.DoPumpString(const SrcStr: string; const xDest: TIBXSQLVAR; ASize: integer);
var
  str: string;
begin
  str := SrcStr;
  if cbTruncString.Checked and
     (Length(str) > ASize) then
  begin
    str := Copy(str, 1, ASize);
  end;

  if cbRemSpace.Checked then
  begin
    case cbRemSpaceOpt.ItemIndex of
      0: str := TrimRight(str);
      1: str := TrimLeft(str);
      2: str := Trim(str);
    end;
  end;

  xDest.AsString := str;
end;

procedure TibpMain.DeleteSrcTableLinks(const ATableName: string);
var
  nd: TccTreeNode;
begin
  nd := tvDest.Items.GetFirstNode;
  while nd <> nil do
  begin
    if nd.InfoText = ATableName
      then CleanSourceTable(nd);
    nd := nd.GetNextSibling;
  end;
end;

procedure TibpMain.AddCustomSQLFields(const AName: string; tn: TccTreeNode; ATree: TccTreeView; ds: TDataset);
var
  i, j, k: integer;
  fld: TccTreeNode;
  DestTbl, TblChecked, DestLst, SrcLst: TStringList;
  nd, ndr, ndf, ndc, tmp: TccTreeNode;
  ns, nsc: TccTreeNode;
begin
  if ATree = tvSource
    then tvDest.Items.BeginUpdate;

  if ATree = tvSourceTr
    then tvDestTr.Items.BeginUpdate;

  try
    nd := nil;

    DestLst := TStringList.Create;
    SrcLst := TStringList.Create;
    DestTbl := TStringList.Create;
    TblChecked := TStringList.Create;

    if ATree = tvSource
      then tvSource.Items.BeginUpdate;
    if ATree = tvSourceTr
      then tvSourceTr.Items.BeginUpdate;

    try

      if Assigned(tn) then
      begin

        if ATree = tvSource
          then nd := tvDest.Items.GetFirstNode;
        if ATree = tvSourceTr
          then nd := tvDestTr.Items.GetFirstNode;

        while nd <> nil do
        begin
          if nd.InfoText = tn.TheText then
          begin
            TblChecked.AddObject(nd.TheText, Pointer(nd.Checked));
            DestTbl.AddObject(nd.TheText, nil);

            if ATree = tvSourceTr then
            begin
              nd.InfoText := '';
              nd.Checked := False;
              nd.TreeView.RedrawNode(nd);
            end;

            if ATree = tvSource then
            begin
              ndc := FindTheNode(nd, picRelationFields);
              if ndc <> nil then
              begin
                ndc := ndc.GetFirstChild;
                while ndc <> nil do
                begin
                  DestTbl.Objects[DestTbl.Count-1] := Pointer(Integer(DestTbl.Objects[DestTbl.Count-1]) + 1);  
                  DestLst.Add(ndc.TheText);
                  SrcLst.Add(ndc.InfoText);
                  ndc := ndc.GetNextSibling;
                end;
              end;
            end;
          end;
          nd := nd.GetNextSibling;
        end;
        if ATree = tvSource
          then DeleteSrcTableLinks(tn.TheText)
      end
      else
      begin
        tn := ATree.Items.AddChild(nil, '');
      end;

      tn.ImageIndex := Integer(picTableNoLinks);
      tn.Data := Pointer(0);

      i := 0;
      tn.DeleteChildren;
      tn.Text := AName;
      tn.InfoText := Format('<%d>',[i]);
      try
        ds.FieldDefs.Update;
        for j := 0 to ds.FieldDefs.Count-1 do
        begin
          fld := ATree.Items.AddChild(tn, ds.FieldDefs[j].Name);
          fld.InfoText := GetTypeTextBde(ds.FieldDefs[j]);
          fld.ImageIndex := Integer(picSourceField);
          fld.SelectedIndex := fld.ImageIndex;
          Inc(i);
        end;
        tn.InfoText := Format('<%d>',[i]);
      except
        tn.InfoText := 'error occurs';
      end;

      for k := 0 to DestTbl.Count-1 do
      begin
        if ATree = tvSource
          then nd := tvDest.Items.GetFirstNode;
        if ATree = tvSourceTr
          then nd := tvDestTr.Items.GetFirstNode;

        while nd <> nil do
        begin
          if nd.TheText = DestTbl[k]
            then break;
          nd := nd.GetNextSibling;
        end;
        
        nd.Checked := Boolean(TblChecked.Objects[k]);

        if ATree = tvSource then
        begin
          ns := tn;
          ndr := FindTheNode(nd, picRelationFields);
          ndf := FindTheNode(nd, picDestFields);
          if (ndr <> nil) or (ndf <> nil) then
          begin
            MakeTableLink(nd, ns, False);
            for j := 0 to Pred(Integer(DestTbl.Objects[k])) do
            begin
              if IsConst(SrcLst[j]) then
              begin
                tmp := tvDest.Items.AddChild(ndr, DestLst[j]);
                tmp.InfoText := SrcLst[j];
                tmp.ImageIndex := Integer(picRelationField);
                tmp.SelectedIndex := tmp.ImageIndex;
                tmp.StateIndex := -1;
                UpdateStatus(ndr.Parent);
                UpdateFieldsStatus(ndr.Parent);
              end
              else
              begin
                ndc := FindSourceField(ndf, DestLst[j]);
                if ndc <> nil then
                begin
                  nsc := FindSourceField(ns, SrcLst[j]);
                  if nsc <> nil then
                  begin
                    ndc.MakeVisible;
                    nsc.MakeVisible;
                    tvDest.Selected := nsc;
                    tvDestDragDrop(tvDest, tvSource, ndc.DisplayRect(True).Left, ndc.DisplayRect(True).Top);
                  end;
                end;
              end;
            end;
          end;

          for j := 0 to Pred(Integer(DestTbl.Objects[k])) do
          begin
            DestLst.Delete(0);
            SrcLst.Delete(0);
          end;
        end;

        if ATree = tvSourceTr then
        begin
          tn.Data := Pointer(Integer(tn.Data)+1);
          nd.InfoText := tn.TheText;
          tn.TreeView.RedrawNode(tn);
        end;
      end;
    finally
      if ATree = tvSource
        then tvSource.Items.EndUpdate;
      if ATree = tvSourceTr
        then tvSourceTr.Items.EndUpdate;

      DestLst.Free;
      SrcLst.Free;
      DestTbl.Free;
      TblChecked.Free;
    end;
  finally
    if ATree = tvSource
      then tvDest.Items.EndUpdate;
    if ATree = tvSourceTr
      then tvDestTr.Items.EndUpdate;
  end;
end;

procedure TibpMain.AddCustomSQLParams(const AName: string; tn: TccTreeNode);
var
  i, j: integer;
  fld: TccTreeNode;
  DestLst, SrcLst, FldLst: TStringList;
  nd, ndr, ndf, ndc, tmp: TccTreeNode;
  ns, nsc: TccTreeNode;
  lChecked: boolean;
begin
  lChecked := False;
  ns := nil;
  nd := nil;

  tvDest.Items.BeginUpdate;
  try
    DestLst := TStringList.Create;
    SrcLst := TStringList.Create;
    tvSource.Items.BeginUpdate;
    try
      if Assigned(tn) then
      begin
        lChecked := tn.Checked;
        if Length(tn.InfoText) > 0 then
        begin
          tmp := tvSource.Items.GetFirstNode;
          while tmp <> nil do
          begin
            if tmp.TheText = tn.InfoText then
            begin
              ns := tmp;
              break;
            end;
            tmp := tmp.GetNextSibling;
          end;
        end;
        ndc := FindTheNode(tn, picRelationFields);
        if ndc <> nil then
        begin
          ndc := ndc.GetFirstChild;
          while ndc <> nil do
          begin
            DestLst.Add(ndc.TheText);
            SrcLst.Add(ndc.InfoText);
            ndc := ndc.GetNextSibling;
          end;
        end;
        CleanSourceTable(tn);
        nd := tn;
      end
      else
      begin
       nd := tvDest.Items.AddChild(nil, '');
      end;

      nd.DeleteChildren;
      nd.Text := AName;
      nd.Checked := lChecked;
      nd.ImageIndex := Integer(picTableNoLinks);

      ndr := tvDest.Items.AddChild(nd, 'Relations');
      ndr.InfoText := '(0)';
      ndr.ImageIndex := Integer(picRelationFields);

      ndf := tvDest.Items.AddChild(nd, 'Params');
      ndf.ImageIndex := Integer(picDestFields);

      tmp := tvDest.Items.AddChild(nd, 'Source Table Fields');
      tmp.ImageIndex := Integer(picSourceFields);
      tmp.InfoText := '(0)';

      qryIBDest.SQL.Text := Copy(AName, Succ(Pos(#0, AName)), Length(AName));
      i := 0;
      ndf.InfoText := Format('[%d]',[i]);
      try
        qryIBDest.Prepare;
        qryIBDest.GenerateParamNames := True;
        FldLst := TStringList.Create;
        try
          FldLst.Duplicates := dupIgnore;
          for j := 0 to qryIBDest.Params.Count-1 do
            if FldLst.IndexOf(qryIBDest.Params[j].Name) = -1
              then FldLst.Add(qryIBDest.Params[j].Name);
          for j := 0 to FldLst.Count-1 do
          begin
            fld := tvDest.Items.AddChild(ndf, FldLst[j]);
            fld.ImageIndex := Integer(picDestField);
            Inc(i);
          end;
        finally
          FldLst.Free;
        end;
        ndf.InfoText := Format('[%d]',[i]);
      except
        ndf.InfoText := 'error occurs';
      end;

      if (nd <> nil) and ((ns <> nil) or (SrcLst.Count > 0)) then
      begin
        if ns <> nil
          then MakeTableLink(nd, ns, False);
        for j := 0 to DestLst.Count-1 do
        begin
          if IsConst(SrcLst[j]) then
          begin
            tmp := tvDest.Items.AddChild(ndr, DestLst[j]);
            tmp.InfoText := SrcLst[j];
            tmp.ImageIndex := Integer(picRelationField);
            tmp.StateIndex := -1;
            UpdateStatus(ndr.Parent);
            UpdateFieldsStatus(ndr.Parent);
          end
          else
          begin
            if ns <> nil then
            begin
              ndc := FindSourceField(ndf, DestLst[j]);
              if ndc <> nil then
              begin
                nsc := FindSourceField(ns, SrcLst[j]);
                if nsc <> nil then
                begin
                  ndc.MakeVisible;
                  nsc.MakeVisible;
                  tvDest.Selected := nsc;
                  tvDestDragDrop(tvDest, tvSource, ndc.DisplayRect(True).Left, ndc.DisplayRect(True).Top);
                end;
              end;
            end;
          end;
        end;
      end;
    finally
      if Assigned(nd)
        then SetSelInds(nd);
      tvSource.Items.EndUpdate;
      DestLst.Free;
      SrcLst.Free;
    end;
  finally
    tvDest.Items.EndUpdate;
  end;
end;

procedure TibpMain.AddEditCustomSQL(ATree: TccTreeView; tn: TccTreeNode);
var
  AConnection: TCustomConnection;
  ds: TDataset;
  i: integer;
  s: string;
begin
  if Assigned(tn)
    then s := tn.Text
    else SetLength(s, 0);

  if (ATree = tvSource) or (ATree = tvSourceTr) then
  begin
    case SrcType of
      pdtIB: AConnection := FDM.DBSource;
      pdtBDE: AConnection := FDM.bdeDb;
      pdtADO: AConnection := FDM.adoDb;
    else
      raise Exception.Create(ErrSrc);
    end;
  end
  else
  begin
    AConnection := FDM.DBDest;
  end;

  try
    if DoSQLEditor(Self, AConnection, s, ATree) then
    begin
      i := Pos(#0, s);
      if (ATree = tvSource) or (ATree = tvSourceTr) then
      begin
        case SrcType of
          pdtIB:
            begin
              ds := qryFields;
              qryFields.SQL.Text := Copy(s, Succ(i), Length(s));
            end;
          pdtBDE:
            begin
              ds := bdeQuery;
              bdeQuery.SQL.Text := Copy(s, Succ(i), Length(s));
            end;
          pdtADO:
            begin
              ds := adoQuery;
              adoQuery.SQL.Text := Copy(s, Succ(i), Length(s));
            end;
        else
          raise Exception.Create(ErrSrc);
        end;
        AddCustomSQLFields(s, tn, ATree, ds);
      end
      else
      begin
        AddCustomSQLParams(s, tn);
      end;
    end;
  finally
    AConnection.Close;
  end;
end;

procedure DoControlExit(Wnd: HWND = 0);
begin
  try
    if Wnd = 0 then Wnd := GetFocus;
    if Wnd <> 0 then
    begin
      SendMessage(Wnd, CM_EXIT, 0, 0);
      SendMessage(Wnd, CM_ENTER, 0, 0);
    end;
  except
  end;
end;

procedure TibpMain.NewSQL1Click(Sender: TObject);
var
  tmpTree: TccTreeView;
begin
  tmpTree := GetFocusedTree;

  if tmpTree <> nil
    then AddEditCustomSQL(tmpTree, nil);
end;

procedure TibpMain.ViewEditSQL1Click(Sender: TObject);
var
  tmpTree: TccTreeView;
begin
  tmpTree := GetFocusedTree;

  if (tmpTree <> nil) and (tmpTree.Selected <> nil)
    then AddEditCustomSQL(tmpTree, tmpTree.Selected);
end;

procedure TibpMain.DeleteSQL1Click(Sender: TObject);
var
  tmpTree: TccTreeView;
  nd: TccTreeNode;
begin
  tmpTree := GetFocusedTree;

  if tmpTree = tvSourceTr then
  begin
    tvSourceTr.Items.BeginUpdate;
    tvDestTr.Items.BeginUpdate;
    try
      nd := tvDestTr.Items.GetFirstNode;
      while nd <> nil do
      begin
        if nd.InfoText = tmpTree.Selected.TheText then
        begin
          nd.InfoText := '';
          nd.Checked := False;
          nd.TreeView.RedrawNode(nd);
        end;
        nd := nd.GetNextSibling;
      end;
      tmpTree.Selected.Free;
    finally
      tvDestTr.Items.EndUpdate;
      tvSourceTr.Items.EndUpdate;
    end;
  end;

  if tmpTree = tvSource then
  begin
    tvSource.Items.BeginUpdate;
    try
      DeleteSrcTableLinks(tvSource.Selected.TheText);
      tvSource.Items.Delete(tvSource.Selected);
    finally
      tvSource.Items.EndUpdate;
    end;
  end;

  if tmpTree = tvDest then
  begin
    tvDest.Items.BeginUpdate;
    try
      CleanSourceTable(tvDest.Selected);
      tvDest.Items.Delete(tvDest.Selected);
    finally
      tvDest.Items.EndUpdate;
    end;
  end;
end;

function TibpMain.GetIBAliasInfo(AIBInfo: TIBDatabaseInfo; ALst: TStringList): string;
begin
  ALst.Clear;
  with AIBInfo do
  begin
    ALst.Add(Format('SQLDialect: %d', [DBSQLDialect]));
    ALst.AddStrings(Database.Params);
    ALst.Add(DBSiteName);
    ALst.Add(Version);
    result := Format('IB/%s', [Version]);
  end;
end;

function TibpMain.GetBDEAliasInfo(ADB: TDatabase; ALst: TStringList): string;
var
  AList: TStringList;
  ADriverName: string;
begin
  SetLength(result, 0);
  ALst.Clear;
  AList := TStringList.Create;
  try
    try
      with ADB.Session do
      begin
        ADriverName := GetAliasDriverName(ADB.DatabaseName);
        ALst.Add(ADriverName);
        GetAliasParams(ADB.AliasName, AList);
        ALst.AddStrings(AList);
      end;
    except
      on E: Exception
        do ALst.Add('!  Warning: Can not get connection information!');
    end;
    ALst.Add(Format('Select Option - %s', [cbSrcSelect.Text]));
    if cbSrcQuoteFields.Checked
      then ALst.Add(Format('Option "%s" is ON', [cbSrcQuoteFields.Caption]));
  finally
    AList.Free;
  end;
  
  try
    result := Format('BDE/%s', [ADriverName]);
  except
    result := 'BDE/Unable To Get Driver Name';
  end;
end;

function TibpMain.GetADOConnectionInfo(AConnection: TADOConnection; ALst: TStringList): string;
begin
  SetLength(result, 0);
  ALst.Clear;
  with AConnection do
  begin
    try
      ALst.Add(Format('ConnectionString: %s', [ConnectionString]));
      ALst.Add(Format('Provider: %s', [Provider]));
      ALst.Add(Format('Version: %s', [Version]));
      result := Format('ADO/%s;ver.%s', [Provider, Version]);
    except
      on E: Exception
        do ALst.Add('!  Warning: Can not get connection information!');
    end;
    ALst.Add(Format('Select Option - %s', [cbSrcSelect.Text]));
    if cbSrcQuoteFields.Checked
      then ALst.Add(Format('Option "%s" is ON', [cbSrcQuoteFields.Caption]));
  end;
end;

function GetFieldTypeText(AIBExtract: TIBExtract; AIBSQL: TIBSQL): string;
var
  Prec: integer;
begin
  if AIBSQL.FieldIndex['rdb$field_precision'] < 0
    then Prec := 0
    else Prec := AIBSQL.FieldByName('rdb$field_precision').AsInteger;

  result := AIBExtract.GetFieldType(AIBSQL.FieldByName('rdb$field_type').AsInteger,
                                    AIBSQL.FieldByName('rdb$field_sub_type').AsInteger,
                                    AIBSQL.FieldByName('rdb$field_scale').AsInteger,
                                    AIBSQL.FieldByName('rdb$field_length').AsInteger,
                                    Prec,
                                    0);
  result := result + ' ' + arNull[AIBSQL.FieldByName('rdb$null_flag').AsInteger <> 1];
end;

function InternetConnected: Boolean;
const
  INTERNET_CONNECTION_MODEM = 1;
  INTERNET_CONNECTION_LAN = 2;
  INTERNET_CONNECTION_PROXY = 4;
var
  dwConnectionTypes : DWORD;
begin
  try
    dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
    Result := InternetGetConnectedState(@dwConnectionTypes, 0);
  except
    Result := False;
  end;
end;

{$IFDEF CCNEWS}
function CheckForNews(ADnl: TclDownLoader; const infSrc, infDest: string; recTotal, ErrCnt: integer): boolean;
var
  s: string;
  AHour, AMin, ASec, AMSec: Word;
begin
  result := Assigned(ADnl) and
            InternetConnected and
            (not ADnl.IsBusy);

  if result then
  begin
    DecodeTime(Now, AHour, AMin, ASec, AMSec);
    s := Format('%d_%d_%d_%d', [AHour, AMin, ASec, Integer(IsParamMode)]);

    ADnl.URL := Format('%s?"%s/%s/%d/%d/%s/%s"', [AppNews, infSrc, infDest, recTotal, ErrCnt, s, AppVersion]);
    ADnl.LocalFile := '';
    ADnl.Start;
  end;
end;
{$ENDIF}

function FindTheNode(tn: TccTreeNode; AImageIndex: pmpIcon): TccTreeNode;
var
  nd: TccTreeNode;
begin
  result := nil;
  nd := tn.GetFirstChild;
  while nd <> nil do
  begin
    if nd.ImageIndex = Integer(AImageIndex) then
    begin
      result := nd;
      exit;
    end;
    nd := tn.GetNextChild(nd);
  end;
end;

function FindSourceTable(tv: TccTreeView; const AName: string;
                         lCase: boolean = False;
                         lSpace: boolean = False;
                         lBDE: boolean = False): TccTreeNode;
var
  nd: TccTreeNode;
begin
  result := nil;
  nd := tv.Items.GetFirstNode;
  while nd <> nil do
  begin
    if CmpStr(nd.TheText, AName, lCase, lSpace, lBDE) then
    begin
      result := nd;
      exit;
    end;
    nd := nd.GetNextSibling;
  end;
end;

function FindSourceField(tn: TccTreeNode; const AName: string;
                         lInfo: boolean = False;
                         lCase: boolean = False;
                         lSpace: boolean = False): TccTreeNode;
var
  nd: TccTreeNode;
begin
  result := nil;
  nd := tn.GetFirstChild;
  while nd <> nil do
  begin
    if not lInfo then
    begin
      if CmpStr(nd.TheText,AName,lCase,lSpace) then
      begin
        result := nd;
        exit;
      end;
    end
    else
    begin
      if CmpStr(nd.InfoText,AName,lCase,lSpace) then
      begin
        result := nd;
        exit;
      end;
    end;
    nd := tn.GetNextChild(nd);
  end;
end;

procedure MakeTableLink(nd, ns: TccTreeNode; lAutoBuild: boolean; lCase: boolean = False; lSpace: boolean = False);
var
  nstmp, ndtmp, ndr, tmp, ndf, nds: TccTreeNode;
  i: integer;
  ADest, ASrc: TccTreeView;
begin
  if (nd = nil) or (ns = nil)
    then exit;
  ADest := TccTreeView(nd.TreeView);
  ASrc := TccTreeView(ns.TreeView);
  ADest.Items.BeginUpdate;
  try
    if Length(Trim(nd.InfoText)) > 0 then
    begin
      nstmp := FindSourceTable(ASrc, nd.InfoText);
      if nstmp <> nil then
      begin
        nstmp.Data := Pointer(Integer(nstmp.Data)-1);
        nstmp.TreeView.RedrawNode(nstmp);
      end;
    end;
    ns.Data := Pointer(Integer(ns.Data) + 1);
    ns.TreeView.RedrawNode(ns);
    nd.InfoText := ns.TheText;
    ndf := FindTheNode(nd, picDestFields);
    ndr := FindTheNode(nd, picRelationFields);
    ndr.DeleteChildren;
    ndtmp := ndf.GetFirstChild;
    i := 0;
    while lAutoBuild and (ndtmp <> nil) do
    begin
      nstmp := FindSourceField(ns, ndtmp.TheText, False, lCase, lSpace);
      if nstmp <> nil then
      begin
        tmp := ADest.Items.AddChild(ndr, ndtmp.TheText);
        tmp.InfoText := nstmp.TheText;
        tmp.ImageIndex := Integer(picRelationField);
        tmp.SelectedIndex := tmp.ImageIndex;
        tmp.StateIndex := -1;
        inc(i);
      end;
      ndtmp := ndf.GetNextChild(ndtmp);
    end;
    ndr.InfoText := '(' + IntToStr(i) + ')';
    nds := FindTheNode(nd, picSourceFields);
    nds.DeleteChildren;
    nds.InfoText := ns.InfoText;
    nstmp := ns.GetFirstChild;
    i := 0;
    while nstmp <> nil do
    begin
      tmp := ADest.Items.AddChild(nds, nstmp.TheText);
      tmp.InfoText := nstmp.InfoText;
      tmp.ImageIndex := Integer(picSourceField);
      tmp.SelectedIndex := tmp.ImageIndex;
      tmp.StateIndex := -1;
      nstmp := ns.GetNextChild(nstmp);
      inc(i);
    end;
    nds.InfoText := Format('(%d)', [i]);
    if (i > 0) and (Copy(ndr.InfoText, 2, Length(ndr.InfoText)-2) = Copy(ndf.InfoText, 2, Length(ndf.InfoText)-2))
      then nd.Data := Pointer(1)
      else nd.Data := nil;
    if lAutoBuild
      then nd.Checked := nd.Data <> nil;
    UpdateFieldsStatus(nd);
  finally
    ADest.Items.EndUpdate;
  end;
end;

procedure UpdateFieldsStatus(tn: TccTreeNode);
var
  nr, nd, tmp: TccTreeNode;
begin
  nr := FindTheNode(tn, picRelationFields);
  nd := FindTheNode(tn, picDestFields);
  if (nr = nil) or (nd = nil)
    then exit;
  tmp := nd.GetFirstChild;
  while tmp <> nil do
  begin
    if FindSourceField(nr, tmp.TheText) <> nil
      then tmp.Data := Pointer(1)
      else tmp.Data := nil;
    tmp := nd.GetNextChild(tmp);
  end;
  nd := FindTheNode(tn, picSourceFields);
  if (nr = nil) or (nd = nil)
    then exit;
  tmp := nd.GetFirstChild;
  while tmp <> nil do
  begin
    if FindSourceField(nr, tmp.TheText, True) <> nil
      then tmp.Data := Pointer(1)
      else tmp.Data := nil;
    tmp := nd.GetNextChild(tmp);
  end;
end;

function IsConst(const AStr: string): boolean;
begin
  result := Copy(AStr, 1, 7) = 'CONST "';
end;

function GetConst(const AStr: string): string;
begin
  result := Copy(AStr, 8, Length(AStr)-8);
end;

function SetConst(const AStr: string): string;
begin
  result := 'CONST "' + AStr + '"';
end;

procedure UpdateStatus(tn: TccTreeNode);
var
  nd, tmp: TccTreeNode;
  i: integer;
begin
  nd := FindTheNode(tn, picRelationFields);
  if nd = nil then Exit;
  tmp := nd.GetFirstChild;
  i := 0;
  while tmp <> nil do
  begin
    inc(i);
    tmp := nd.GetNextChild(tmp);
  end;
  nd.InfoText := '(' + IntToStr(i) + ')';
  tmp := FindTheNode(tn, picDestFields);
  if tmp = nil then exit;
  if (i > 0) and (Copy(tmp.InfoText, 2, Length(tmp.InfoText)-2) = Copy(nd.InfoText, 2, Length(nd.InfoText)-2))
    then tn.Data := Pointer(1)
    else tn.Data := nil;
end;

procedure TibpMain.btnUpdateDefClick(Sender: TObject);
begin
  DoUpdDefs(Self);
end;

procedure TibpMain.RestoreCustomSQLFields(AStr: TStringList; ATree: TccTreeView);
var
  s: string;
  AConnection: TCustomConnection;
  ds: TDataset;
  i, j: integer;
begin
  case SrcType of
    pdtIB:
      begin
        AConnection := FDM.DBSource;
        ds := qryFields;
      end;
    pdtBDE:
      begin
        AConnection := FDM.bdeDb;
        ds := bdeQuery;
      end;
    pdtADO:
      begin
        AConnection := FDM.adoDb;
        ds := adoQuery;
      end;
  else
    raise Exception.Create(ErrSrc);
  end;

  AConnection.Open;
  try
    for i := 0 to AStr.Count-1 do
    begin
      s := AStr[i];
      j := Pos(#0, s);

      case SrcType of
        pdtIB: qryFields.SQL.Text := Copy(s, Succ(j), Length(s));
        pdtBDE: bdeQuery.SQL.Text := Copy(s, Succ(j), Length(s));
        pdtADO: adoQuery.SQL.Text := Copy(s, Succ(j), Length(s));
      else
        raise Exception.Create(ErrSrc);
      end;

      AddCustomSQLFields(s, nil, ATree, ds);
    end;
  finally
    AConnection.Close;
  end;
end;

procedure TibpMain.RestoreCustomSQLParams(AStr: TStringList);
var
  i: integer;
begin
  FDM.DBDest.Open;
  try
    for i := 0 to AStr.Count-1
      do AddCustomSQLParams(AStr[i], nil);
  finally
    FDM.DBDest.Close;
  end;
end;

{$IFDEF CCNEWS}
procedure TibpMain.OnCCNews(Sender: TObject; Text: TStrings);
begin
  try
    if Text.Count > 1 then
    begin
      if Text[0] > AppVersion then
      begin
        btnGet.Caption := Format(btnGet.Caption, [Text[0]]);
        btnGet.Hint := Text[1];
        btnGet.Visible := True;
      end;
    end;
    if Text.Count > 2 then
    begin
      stNews.Caption := Text[2];
      stNews.Hint := Text[3];
      stNews.AutoSize := True;
      stNews.Left := Pages.Width - stNews.Width - 2;
      stNews.Visible := True;
    end;
  except
  end;
end;
{$ENDIF}

procedure TibpMain.btnGetClick(Sender: TObject);
begin
  ShellExecute( 0, PChar('open'), PChar(TCOntrol(Sender).Hint), nil, nil, SW_RESTORE);
end;

function TibpMain.GetSrcDialect: integer;
begin
  result := upSrcDialect.Value - 1;
end;

procedure TibpMain.SetSrcDialect(Value: integer);
begin
  upSrcDialect.Value := Succ(Value);
end;

function TibpMain.GetDestDialect: integer;
begin
  result := upDestDialect.Value - 1;
end;

procedure TibpMain.SetDestDialect(Value: integer);
begin
  upDestDialect.Value := Succ(Value);
end;

function TibpMain.GetSrcSelect: integer;
begin
  result := cbSrcSelect.ItemIndex;
end;

procedure TibpMain.SetSrcSelect(Value: integer);
begin
  cbSrcSelect.ItemIndex := Value;
end;

function TibpMain.GetSrcQuoteFields: boolean;
begin
  result := cbSrcQuoteFields.Checked;
end;

procedure TibpMain.SetSrcQuoteFields(Value: boolean);
begin
  cbSrcQuoteFields.Checked := Value;
end;

procedure TibpMain.GetUserInfo(Sender: TObject; var AUserName, APassword: string);
begin
  AUserName := eSUserName.Text;
  APassword := eSPassword.Text;
end;

{$IFDEF CCNEWS}
procedure TibpMain.WaitForSubmission(ADnl: TclDownLoader);
var
 ATimer: TTimer;
begin
  if Assigned(ADnl) and ADnl.IsBusy then
  begin
    ATimer := TTimer.Create(nil);
    try
      ATimer.Enabled := False;
      ATimer.Interval := ADnl.TimeOut;
      ATimer.OnTimer := StopTimer;
      ATimer.Enabled := True;
      while ADnl.IsBusy and ATimer.Enabled
        do Application.ProcessMessages;
    finally
      ATimer.Free;
    end;
  end;
end;

procedure TibpMain.StopTimer(Sender: TObject);
begin
  if Sender is TTimer
    then (Sender as TTimer).Enabled := False;
end;
{$ENDIF}

function TibpMain.GetFocusedTree: TccTreeView;
begin
  if tvSource.Focused
    then result := tvSource
    else
      if tvDest.Focused
      then result := tvDest
      else
        if tvSourceTr.Focused
          then result := tvSourceTr
          else result := nil;
end;

procedure SetSelInds(ANode: TccTreeNode);
begin
  while ANode <> nil do
  begin
    if ANode.Level > 0 then ANode.StateIndex := -1;
    ANode.SelectedIndex := ANode.ImageIndex;
    ANode := ANode.GetNext;
  end;
end;

procedure AssignTree(ASrc, ADest: TccTreeView; lIsDest: boolean = False);
var
  nd, ndf, ndc, tmp: TccTreeNode;
begin
  ADest.Items.Assign(ASrc.Items);
  ADest.Images := ASrc.Images;

  // correct tree
  if lIsDest then
  begin
    ADest.Items.BeginUpdate;
    try
      nd := ADest.Items.GetFirstNode;
      while nd <> nil do
      begin
        ndf := FindTheNode(nd, picDestFields);
        nd.InfoText := ndf.InfoText;
        ndc := ndf.GetFirstChild;
        while ndc <> nil do
        begin
          tmp := ADest.Items.AddChild(nd, ndf.TheText);
          tmp.Assign(ndc);
          ndc := ndf.GetNextChild(ndc);
        end;
        ndf := FindTheNode(nd, picDestFields);
        if ndf <> nil then ndf.Free;
        ndf := FindTheNode(nd, picSourceFields);
        if ndf <> nil then ndf.Free;
        ndf := FindTheNode(nd, picRelationFields);
        if ndf <> nil then ndf.Free;
        ndf := FindTheNode(nd, picRefConsts);
        if ndf <> nil then ndf.Free;
        nd := nd.GetNextSibling;
      end;
      SetSelInds(ADest.Items.GetFirstNode);
    finally
      ADest.Items.EndUpdate;
    end;
  end;
end;

procedure TibpMain.ShowStats;
var
  i: integer;
  str: string;
begin
  if FStat.Count > 0 then
  begin
    RepLine('');
    RepLine('=== Statistical Info ===');
    RepLine('');
    for i := 0 to FStat.Count-1 do
    begin
      RepLine(Format('  %s:', [FStat[i].Name]));
      if FStat[i].Errors > 0
        then RepLine(Format('    !  Errors - %d', [FStat[i].Errors]));
      if FStat[i].Deleted > -1
        then RepLine(Format('    Destination Records Deleted - %d', [FStat[i].Deleted]));
      if FStat[i].Processed > -1
        then RepLine(Format('    Source Records Processed - %d', [FStat[i].Processed]));
      if FStat[i].RowsAffected > -1
        then RepLine(Format('    Destination Records Affected - %d', [FStat[i].RowsAffected]));
      RepLine(str);
    end;
    RepLine('');
  end;
end;

procedure TibpMain.CustomSQLWizard1Click(Sender: TObject);
begin
  DoUpdWizard(Self, tvDest);
end;

function TibpMain.OpenDataset(ANode: TccTreeNode; AList: TStringList): TDataset;
var
  nPos: integer;
begin
  result := nil;

  nPos := Pos(#0, ANode.Text);

  case SrcType of
    pdtIB:
      begin
        if nPos = 0 then
        begin
          BuildSQL(ANode.TheText, SrcType, SrcDialect, AList, qrySource.SQL, False);
          RepLine('SQL: ' + qrySource.SQL.Text);
        end
        else
        begin
          qrySource.SQL.Text := Copy(ANode.Text, Succ(nPos), Length(ANode.Text));
          RepLine('Custom SQL: ' + qrySource.SQL.Text);
        end;
      end;
    pdtBDE:
      begin
        if nPos = 0 then
        begin
          if FDM.bdeDb.IsSQLBased then
          begin
            result := bdeQuery;
            BuildSQL(ANode.TheText, SrcType, SrcSelect, AList, bdeQuery.SQL, False);
            RepLine('SQL: ' + bdeQuery.SQL.Text);
          end
          else
          begin
            result := bdeTable;
            bdeTable.TableName := ANode.TheText;
            RepLine('Flat Table: ' + bdeTable.TableName);
          end;
        end
        else
        begin
          result := bdeQuery;
          bdeQuery.SQL.Text := Copy(ANode.Text, Succ(nPos), Length(ANode.Text));
          RepLine('Custom SQL: ' + bdeQuery.SQL.Text);
        end;
      end;
    pdtADO:
      begin
        result := adoQuery;
        if nPos = 0 then
        begin
          BuildSQL(ANode.TheText, SrcType, SrcSelect, AList, adoQuery.SQL, False);
          RepLine('SQL: ' + adoQuery.SQL.Text);
        end
        else
        begin
          adoQuery.SQL.Text := Copy(ANode.Text, Succ(nPos), Length(ANode.Text));
          RepLine('Custom SQL: ' + adoQuery.SQL.Text);
        end;
      end;
  else
    raise Exception.Create(ErrSrc);
  end;
end;

procedure TibpMain.DoCommit;
begin
  CmtCnt := 0;
  Trans.Commit;
  Trans.StartTransaction;
  RepLine(' >  Data Committed.');
  Application.ProcessMessages;
end;

procedure TibpMain.ccSaveReportButtonClick(Sender: TObject);
begin
  OpenReportDialog.FileName := TCustomEdit(Sender).Text;
  if OpenReportDialog.Execute
    then TCustomEdit(Sender).Text := OpenReportDialog.FileName;
end;

initialization
  Application.Title := Format('%s%s', [AppTitle, AppVersion]);

  AWindStatList := TStringList.Create;
  AWindStatList.Duplicates := dupIgnore;

finalization
  if AWindStatList <> nil then
  begin
    while AWindStatList.Count > 0 do
    begin
      Dispose(PTWindStatRec(AWindStatList.Objects[Pred(AWindStatList.Count)]));
      AWindStatList.Delete(Pred(AWindStatList.Count));
    end;
    AWindStatList.Free;
    AWindStatList := nil;
  end;

end.
