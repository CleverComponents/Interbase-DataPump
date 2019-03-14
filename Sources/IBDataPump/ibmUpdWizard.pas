{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ibmUpdWizard.pas
}

unit ibmUpdWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Mask, IBQuery, Db, IBCustomDataSet, IBUpdateSQL,
  Menus, IBDatabase, IBSQL, ImgList, IBHeader, IBDatabaseInfo, ShellApi,
  Dbtables, IBExtract, ADODB, Buttons, ActiveX, IBTable,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
    ibpMain, ibpDM, ibpHelp, ccTreeView, ccSpinEdit, ccButtonEdit;

type

  { TUpdWizardCollectionItem }

  TUpdWizardCollectionItem = class(TCollectionItem)
  private
    FTableName: string;
    FOverName: boolean;
    FName: string;
    FSQLStatement: integer;
    FWhereOption: integer;
    FOverValueSet: boolean;
    FOverWhere: boolean;
    FValueSetFields: TStringList;
    FWhereFields: TStringList;
    FKeyFields: TStringList;
    FNotNullFields: TStringList;
    FOverSQL: boolean;
    FSQL: TStringList;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property TableName: string read FTableName write FTableName;
    property OverName: boolean read FOverName write FOverName;
    property Name: string read FName write FName;
    property SQLStatement: integer read FSQLStatement write FSQLStatement;
    property WhereOption: integer read FWhereOption write FWhereOption;
    property OverValueSet: boolean read FOverValueSet write FOverValueSet;
    property OverWhere: boolean read FOverWhere write FOverWhere;
    property ValueSetFields: TStringList read FValueSetFields write FValueSetFields;
    property WhereFields: TStringList read FWhereFields write FWhereFields;
    property KeyFields: TStringList read FKeyFields write FKeyFields;
    property NotNullFields: TStringList read FNotNullFields write FNotNullFields;
    property OverSQL: boolean read FOverSQL write FOverSQL;
    property SQL: TStringList read FSQL write FSQL;
  end;

  { TUpdWizardCollection }

  TUpdWizardCollection = class(TCollection)
  protected
    function GetItem(Index: Integer): TUpdWizardCollectionItem;
    procedure SetItem(Index: Integer; Value: TUpdWizardCollectionItem);
  public
    function Add: TUpdWizardCollectionItem;
    function FindByName(const AName: string): TUpdWizardCollectionItem;

    property Items[Index: Integer]: TUpdWizardCollectionItem read GetItem write SetItem;
  end;

  { TibpUpdWizard }

  TibpUpdWizard = class(TForm)
    Panel1: TPanel;
    btnSave: TButton;
    btnCancel: TButton;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel4: TPanel;
    memSQL: TMemo;
    Panel8: TPanel;
    lInsertNameFormat: TLabel;
    lUpdateNameFormat: TLabel;
    lDeleteNameFormat: TLabel;
    eInsertNameFormat: TEdit;
    eUpdateNameFormat: TEdit;
    eDeleteNameFormat: TEdit;
    btnDefaults: TButton;
    Label1: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    pWhere: TPanel;
    pValueSet: TPanel;
    Splitter3: TSplitter;
    Label2: TLabel;
    cbSQLStatement: TComboBox;
    lSQLStatement: TLabel;
    Panel14: TPanel;
    cbOverValueSet: TCheckBox;
    Panel15: TPanel;
    cbOverWhere: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    eName: TEdit;
    cbName: TCheckBox;
    Panel7: TPanel;
    cbSQL: TCheckBox;
    cbWhere: TComboBox;
    lWhere: TLabel;
    btnTest: TButton;
    lDefSQLStat: TLabel;
    lDefWhere: TLabel;
    cbDefSQL: TComboBox;
    cbDefWhere: TComboBox;
    procedure btnDefaultsClick(Sender: TObject);
    procedure tvChange(Sender: TObject; Node: TccTreeNode);
    procedure tvChanging(Sender: TObject; Node: TccTreeNode;
      var AllowChange: Boolean);
    procedure cbNameClick(Sender: TObject);
    procedure cbSQLStatementChange(Sender: TObject);
    procedure cbOverValueSetClick(Sender: TObject);
    procedure cbOverWhereClick(Sender: TObject);
    procedure eUpdateNameFormatChange(Sender: TObject);
    procedure cbSQLClick(Sender: TObject);
    procedure tvWhereKeyPress(Sender: TObject; var Key: Char);
    procedure cbWhereChange(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbDefSQLChange(Sender: TObject);
    procedure tvCustomDraw(Sender: TObject; TreeNode: TccTreeNode;
      AFont: TFont; var AColor, ABkColor: TColor);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    IsInSetup: boolean;
    FMain: TibpMain;
    FSets: TUpdWizardCollection;
    FNotNullFields: TStringList;
    FKeyFields: TStringList;
    FTablesList: TStringList;

    // ccCompos
    tvWhere: TccTreeView;
    tvValueSet: TccTreeView;
    tv: TccTreeView;

    procedure Init;
    function BuildName(const AStr: string): string;
    procedure FillInKeyNotNullFields(const ATableName: string; AKey, ANotNull: TStrings);
    function CheckName(const ANewName, AOldName: string): boolean;
  public
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
  end;

  function DoUpdWizard(AMain: TibpMain; ATV: TccTreeView): boolean;
  procedure ApplyChecked(ATree: TccTreeView; AList: TStrings; lSelectAll: boolean = False);
  function SaveChecked(ATree: TccTreeView): string;
  function BuldSQL(ASQLDialect, ASQLStatement: integer; ATable, AValueSetFields, AWhereFirlds: string): string;

implementation

{$R *.DFM}

function DoUpdWizard(AMain: TibpMain; ATV: TccTreeView): boolean;
var
  FibpUpdWizard: TibpUpdWizard;
begin
  FibpUpdWizard := TibpUpdWizard.Create(Application);
  try
    with FibpUpdWizard do
    begin
      try AMain.DM.DBDest.Open except end;
      try
        if not AMain.DM.DBDest.Connected
          then Caption := Format('%s - Not Connected!', [Caption])
          else Caption := Format('%s %s', [Caption, AMain.DM.DBDest.DatabaseName]);
        FMain := AMain;
        AssignTree(ATV, tv, ATV = FMain.tvDest);
        Init;
        result := ShowModal = mrOk;
      finally
        AMain.DM.DBDest.Close;
      end;
    end;
  finally
    FibpUpdWizard.Free;
  end;
end;

procedure ApplyChecked(ATree: TccTreeView; AList: TStrings; lSelectAll: boolean = False);
var
  ANode: TccTreeNode;
begin
  ANode := ATree.Items.GetFirstNode;
  while ANode <> nil do
  begin
    ANode.Checked := lSelectAll or (AList.IndexOf(ANode.TheText) <> -1);
    ANode := ANode.GetNext;
  end;
end;

function SaveChecked(ATree: TccTreeView): string;
var
  AList: TStringList;
  ANode: TccTreeNode;
begin
  AList := TStringList.Create;
  try
    ANode := ATree.Items.GetFirstNode;
    while ANode <> nil do
    begin
      if ANode.Checked
        then AList.Add(ANode.TheText);
      ANode := ANode.GetNext;
    end;
    result := AList.Text;
  finally
    AList.Free;
  end;
end;

function BuldSQL(ASQLDialect, ASQLStatement: integer; ATable, AValueSetFields, AWhereFirlds: string): string;
var
  str, strFields, strPars, strWheres: string;
  lstValueSetFields, lstWhereFields: TStringList;

  function RunList(AStringList: TStringList; AFormatStr, AFormatStrLast : string): string;
  var
    tmpInd: integer;
    tmpStr: string;
  begin
    SetLength(result, 0);
    for tmpInd := 0 to AStringList.Count-2 do
    begin
      tmpStr := GetSQLName(AStringList[tmpInd], pdtIB, ASQLDialect);
      result := result + Format(AFormatStr, [tmpStr, tmpStr]);
    end;

    if AStringList.Count > 0 then
    begin
      tmpStr := GetSQLName(AStringList[AStringList.Count-1], pdtIB, ASQLDialect);
      result := result + Format(AFormatStrLast, [tmpStr, tmpStr]);
    end;
  end;

begin
  SetLength(result, 0);
  SetLength(strFields, 0);
  SetLength(strPars, 0);
  SetLength(strWheres, 0);

  lstValueSetFields := TStringList.Create;
  lstWhereFields := TStringList.Create;
  try
    lstValueSetFields.Text := AValueSetFields;
    lstWhereFields.Text := AWhereFirlds;
    case ASQLStatement of
      //update
      0:
        begin
          strFields := RunList(lstValueSetFields, ' %s=:%s,', ' %s=:%s');
          strWheres := RunList(lstWhereFields, ' %s=:%s and', ' %s=:%s');

          str := GetSQLName(ATable, pdtIB, ASQLDialect);
          result := Format('UPDATE %s '+#13#10+'SET %s '+#13#10+'WHERE %s', [str, strFields, strWheres]);
        end;
      // insert
      1:
        begin
          strFields := RunList(lstValueSetFields, ' %s,', ' %s');
          strWheres := RunList(lstWhereFields, ' :%s,', ' :%s');

          str := GetSQLName(ATable, pdtIB, ASQLDialect);
          result := Format('INSERT INTO %s '+#13#10+'(%s) '+#13#10+'VALUES(%s)', [str, strFields, strWheres]);
        end;
      // delete
      2:
        begin
          strWheres := RunList(lstWhereFields, ' %s=:%s and', ' %s=:%s');

          str := GetSQLName(ATable, pdtIB, ASQLDialect);
          result := Format('DELETE FROM %s '+#13#10+'WHERE %s', [str, strWheres]);
        end;
    end;
  finally
    lstValueSetFields.Free;
    lstWhereFields.Free;
  end;
end;

{ TUpdWizardCollectionItem }

constructor TUpdWizardCollectionItem.Create(Collection: TCollection);
begin
  inherited  Create(Collection);
  SetLength(FTableName, 0);
  FOverName := False;
  SetLength(FName, 0);
  FSQLStatement := 0;
  FOverValueSet := False;
  FOverWhere := False;
  FValueSetFields := TStringList.Create;
  FWhereFields := TStringList.Create;
  FKeyFields := TStringList.Create;
  FNotNullFields := TStringList.Create;
  FOverSQL := False;
  FSQL := TStringList.Create;
end;

destructor TUpdWizardCollectionItem.Destroy;
begin
  SetLength(FTableName, 0);
  FOverName := False;
  SetLength(FName, 0);
  FSQLStatement := 0;
  FOverValueSet := False;
  FOverWhere := False;
  FValueSetFields := TStringList.Create;
  FWhereFields := TStringList.Create;
  FSQL := TStringList.Create;
  inherited;
end;

{ TUpdWizardCollection }

function TUpdWizardCollection.GetItem(Index: Integer): TUpdWizardCollectionItem;
begin
  result := TUpdWizardCollectionItem(inherited Items[Index]);
end;

procedure TUpdWizardCollection.SetItem(Index: Integer; Value: TUpdWizardCollectionItem);
begin
  Items[Index].Assign(Value);
end;

function TUpdWizardCollection.Add: TUpdWizardCollectionItem;
begin
  result := TUpdWizardCollectionItem(inherited Add);
end;

function TUpdWizardCollection.FindByName(const AName: string): TUpdWizardCollectionItem;
var
  i: integer;
begin
  result := nil;
  for i := 0 to Count-1 do
    if Items[i].TableName = AName then
    begin
      result := Items[i];
      break;
    end;
end;

{ TibpUpdWizard }

constructor TibpUpdWizard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // create ccCompos (avoid package)
  tvWhere:= TccTreeView.Create(Self);
  with tvWhere do
  begin
    Parent:= pWhere;
    Align:= alClient;
    ShowLines:= False;
    ReadOnly:= True;
    HideSelection:= False;
    Indent:= 19;
    TabOrder:= 1;
    OnClick:= cbSQLStatementChange;
    OnKeyPress:= tvWhereKeyPress;
    ShowCheckBoxes:= True;
  end;
  tvValueSet:= TccTreeView.Create(Self);
  with tvValueSet do
  begin
    Parent:= pValueSet;
    Align:= alClient;
    ShowLines:= False;
    ReadOnly:= True;
    HideSelection:= False;
    Indent:= 19;
    TabOrder:= 1;
    OnClick:= cbSQLStatementChange;
    OnKeyPress:= tvWhereKeyPress;
    ShowCheckBoxes:= True;
  end;
  tv:= TccTreeView.Create(Self);
  with tv do
  begin
    Parent:= Panel4;
    Align:= alClient;
    ShowLines:= False;
    ShowCheckBoxes:= True;
    ReadOnly:= True;
    HideSelection:= False;
    Indent:= 19;
    TabOrder:= 0;
    OnChanging:= tvChanging;
    OnChange:= tvChange;
    OnCustomDraw:= tvCustomDraw;
  end;

  FSets := TUpdWizardCollection.Create(TUpdWizardCollectionItem);
  FNotNullFields := TStringList.Create;
  FKeyFields := TStringList.Create;
  FTablesList := TStringList.Create;
  FTablesList.Sorted := True;
  FTablesList.Duplicates := dupIgnore;
end;

destructor TibpUpdWizard.Destroy;
begin
  FNotNullFields.Free;
  FKeyFields.Free;
  FSets.Free;
  FTablesList.Free;
  inherited Destroy;
end;

procedure TibpUpdWizard.Init;
var
  nd: TccTreeNode;
begin
  IsInSetup := False;
  tv.Selected := nil;
  btnDefaults.Click;

  tvChange(tv, nil);

  tvValueSet.Images := tv.Images;
  tvWhere.Images := tv.Images;

  FTablesList.Clear;
  nd := tv.Items.GetFirstNode;
  while nd <> nil do
  begin
    FTablesList.Add(nd.TheText);
    nd := nd.GetNextSibling;
  end;

  cbDefWhere.ItemIndex := 1;
  cbDefSQL.ItemIndex := 1;

  cbDefSQLChange(nil);
end;

procedure TibpUpdWizard.btnDefaultsClick(Sender: TObject);
begin
  eUpdateNameFormat.Text := eUpdateNameFormat.Hint;
  eInsertNameFormat.Text := eInsertNameFormat.Hint;
  eDeleteNameFormat.Text := eDeleteNameFormat.Hint;
end;

procedure TibpUpdWizard.tvChange(Sender: TObject; Node: TccTreeNode);
var
  uItem: TUpdWizardCollectionItem;
  nd, tmp: TccTreeNode;
begin
  IsInSetup := True;
  try
    if (Node <> nil) and
       (Node.ImageIndex > Integer(picTableLoop))
      then Node := Node.Parent;

    if Node <> nil
      then uItem := FSets.FindByName(Node.TheText)
      else uItem := nil;

    tvValueSet.Items.BeginUpdate;
    tvWhere.Items.BeginUpdate;
    memSQL.Lines.BeginUpdate;
    try
      tvValueSet.Items.Clear;
      tvWhere.Items.Clear;
      memSQL.Lines.Clear;
      if Node <> nil then
      begin
        nd := Node.GetFirstChild;
        while nd <> nil do
        begin
          tmp := tvValueSet.Items.Add(nil, nd.TheText);
          tmp.Assign(nd);
          tmp.Checked := True;
          nd  := Node.GetNextChild(nd);
        end;
        tvWhere.Items.Assign(tvValueSet.Items)
      end;

      if (uItem = nil) or (Node = nil) or (not Node.Checked) then
      begin
        cbName.Checked := False;
        cbOverValueSet.Checked := False;
        cbSQLStatement.ItemIndex := cbDefSQL.ItemIndex;
        cbWhere.ItemIndex := cbDefWhere.ItemIndex;
        cbOverWhere.Checked := cbWhere.ItemIndex = Pred(cbWhere.Items.Count);
        cbSQL.Checked := False;
        if Node <> nil
          then FillInKeyNotNullFields(Node.TheText, FKeyFields, FNotNullFields);
      end
      else
      begin
        cbOverValueSet.Checked := uItem.OverValueSet;
        cbOverWhere.Checked := uItem.OverWhere;
        cbSQLStatement.ItemIndex := uItem.SQLStatement;
        cbWhere.ItemIndex := uItem.WhereOption;
        FKeyFields.Assign(uItem.KeyFields);
        FNotNullFields.Assign(uItem.NotNullFields);

        cbName.Checked := uItem.OverName;
        if cbName.Checked
          then eName.Text := uItem.Name
          else eName.Text := BuildName(Node.TheText);

        if cbOverValueSet.Checked
          then ApplyChecked(tvValueSet, uItem.ValueSetFields);

        if cbOverWhere.Checked
          then ApplyChecked(tvWhere, uItem.WhereFields);

        cbSQL.Checked := uItem.OverSQL;
        if cbSQL.Checked
          then memSQL.Lines.Text := uItem.SQL.Text
          else memSQL.Lines.Text := BuldSQL(FMain.DestDialect, cbSQLStatement.ItemIndex, uItem.TableName, SaveChecked(tvValueSet), SaveChecked(tvWhere));
      end;
    finally
      tvValueSet.Items.EndUpdate;
      tvWhere.Items.EndUpdate;
      memSQL.Lines.EndUpdate;
    end;
  finally
    IsInSetup := False;
  end;
  cbNameClick(cbName);
  cbOverValueSetClick(cbOverValueSet);
  cbOverWhereClick(cbOverWhere);
  cbSQLClick(cbSQL);
end;

procedure TibpUpdWizard.tvChanging(Sender: TObject; Node: TccTreeNode;
  var AllowChange: Boolean);
var
  uItem: TUpdWizardCollectionItem;
  ANode: TccTreeNode;
begin
  IsInSetup := True;
  try
    ANode := tv.Selected;
    if ANode <> nil then
    begin
      if ANode.ImageIndex > Integer(picTableLoop)
        then ANode := ANode.Parent;

      uItem := FSets.FindByName(ANode.TheText);

      if uItem = nil
        then uItem := FSets.Add;

      if ANode.Checked and (not CheckName(eName.Text, uItem.Name)) then
      begin
        if eName.CanFocus
          then eName.SetFocus;
        if Length(Trim(eName.Text)) = 0
          then ShowMessage('Name can not be empty!')
          else ShowMessage(Format('Name %s is duplicated - please correct.', [eName.Text]));
        AllowChange := False;
        exit;
      end;

      uItem.KeyFields.Assign(FKeyFields);
      uItem.NotNullFields.Assign(FNotNullFields);
      uItem.TableName := ANode.TheText;
      uItem.SQLStatement := cbSQLStatement.ItemIndex;
      uItem.WhereOption := cbWhere.ItemIndex;
      uItem.OverValueSet := cbOverValueSet.Checked;
      uItem.OverWhere := cbOverWhere.Checked;
      uItem.OverName := cbName.Checked and (Length(Trim(eName.Text)) > 0);
      uItem.Name := eName.Text;

      uItem.OverSQL := cbSQL.Checked;
      uItem.SQL.Text := memSQL.Lines.Text;

      uItem.ValueSetFields.Clear;
      uItem.WhereFields.Clear;

      if cbOverValueSet.Checked
        then uItem.ValueSetFields.Text := SaveChecked(tvValueSet);

      if cbOverWhere.Checked
        then uItem.WhereFields.Text := SaveChecked(tvWhere);
    end;
  finally
    IsInSetup := False;
  end;
end;

function TibpUpdWizard.BuildName(const AStr: string): string;
var
  aEdit: TEdit;
begin
  case cbSQLStatement.ItemIndex of
    0: aEdit := eUpdateNameFormat;
    1: aEdit := eInsertNameFormat;
    2: aEdit := eDeleteNameFormat;
  else
    aEdit := eUpdateNameFormat;
  end;
  result := Format(aEdit.Text, [AStr]);
  if Length(Trim(result)) = 0
    then result := Format(aEdit.Hint, [AStr]);
end;

procedure TibpUpdWizard.FillInKeyNotNullFields(const ATableName: string; AKey, ANotNull: TStrings);
var
  i: integer;
  ibTable: TIBTable;
begin
  AKey.Clear;
  ANotNull.Clear;
  ibTable := TIBTable.Create(nil);
  try
    ibTable.Database := FMain.DM.DBDest;
    ibTable.Transaction := ibTable.Database.DefaultTransaction;
    try
      ibTable.TableName := ATableName;

      ibTable.FieldDefs.Update;
      for i := 0 to ibTable.FieldDefs.Count-1 do
        if faRequired in ibTable.FieldDefs[i].Attributes
          then ANotNull.Add(ibTable.FieldDefs[i].Name);

      ibTable.IndexDefs.Update;
      for i := 0 to ibTable.IndexDefs.Count-1 do
      begin
        if ixPrimary in ibTable.IndexDefs[i].Options then
        begin
          AKey.Text := StringReplace(ibTable.IndexDefs[i].Fields, ';', #13#10, [rfReplaceAll]);
          break;
        end
      end;
    except
    end;
  finally
    ibTable.Free;
  end;
end;

function TibpUpdWizard.CheckName(const ANewName, AOldName: string): boolean;
var
  i, j: integer;
begin
  result := False;

  if Length(Trim(ANewName)) = 0
    then exit;

  if ANewName <> AOldName then
  begin
    i := FTablesList.IndexOf(AOldName);
    if (i <> -1) and (FTablesList.Objects[i] = nil)
      then exit;

    j := FTablesList.IndexOf(ANewName);
    if j <> -1
      then exit;

    FTablesList.Sorted := False;
    try
      if i <> -1
        then FTablesList[i] := ANewName
        else FTablesList.AddObject(ANewName, Pointer(1));
    finally
      FTablesList.Sorted := True;
    end;
  end;
  result := True;
end;

procedure TibpUpdWizard.cbNameClick(Sender: TObject);
begin
  eName.Enabled := TCheckBox(Sender).Checked;
end;

procedure TibpUpdWizard.cbOverValueSetClick(Sender: TObject);
begin
  tvValueSet.Enabled := TCheckBox(Sender).Checked;
  cbSQLStatementChange(nil);
end;

procedure TibpUpdWizard.cbOverWhereClick(Sender: TObject);
begin
  tvWhere.Enabled := cbOverWhere.Checked;

  if (not IsInSetup) then
  begin
    if cbOverWhere.Checked and
       (cbWhere.ItemIndex <> Pred(cbWhere.Items.Count))
      then cbWhere.ItemIndex := Pred(cbWhere.Items.Count);

    if (not cbOverWhere.Checked) and
       (cbWhere.ItemIndex = Pred(cbWhere.Items.Count))
      then cbWhere.ItemIndex := 0;
  end;

  cbSQLStatementChange(nil);
end;

procedure TibpUpdWizard.cbSQLClick(Sender: TObject);
begin
  memSQL.ReadOnly := not TCheckBox(Sender).Checked;
  if memSQL.ReadOnly
    then memSQL.Color := clBtnFace
    else memSQL.Color := clWindow;

  if (not IsInSetup)
    then cbSQLStatementChange(nil);
end;

procedure TibpUpdWizard.eUpdateNameFormatChange(Sender: TObject);
var
  tmp: TccTreeNode;
begin
  if (not IsInSetup) then
  begin
    tmp := tv.Selected;
    if (tmp <> nil) and (tmp.ImageIndex > Integer(picTableLoop))
        then tmp := tmp.Parent;

    if (tmp <> nil) and (not cbName.Checked)
      then eName.Text := BuildName(tmp.TheText);
  end;
end;

procedure TibpUpdWizard.cbSQLStatementChange(Sender: TObject);
var
  tmp: TccTreeNode;
begin
  if (not IsInSetup) then
  begin
    tmp := tv.Selected;
    if (tmp <> nil) and (tmp.ImageIndex > Integer(picTableLoop))
        then tmp := tmp.Parent;

    if (tmp <> nil) and (not cbName.Checked)
      then eName.Text := BuildName(tmp.TheText);

    case cbSQLStatement.ItemIndex of
      0:  // update
        begin
          cbOverValueSet.Caption := 'Overwrite SET Clause Fields';
          cbOverWhere.Caption := 'Overwrite WHERE Clause Fields';
          pValueSet.Visible := True;
          pWhere.Visible := True;
          if not cbOverValueSet.Checked
            then ApplyChecked(tvValueSet, nil, True);
        end;
      1: // insert
        begin
          cbOverValueSet.Caption := 'Overwrite FIELDS Clause Fields';
          cbOverWhere.Caption := 'Overwrite VALUES Clause Fields';
          pValueSet.Visible := True;
          pWhere.Visible := True;
          cbWhere.ItemIndex := 1;
          if not cbOverWhere.Checked
            then ApplyChecked(tvWhere, nil, True);
          if not cbOverValueSet.Checked
            then ApplyChecked(tvValueSet, nil, True);
        end;
      2: // delete
        begin
          cbOverWhere.Caption := 'Overwrite WHERE Clause Fields';
          pValueSet.Visible := False;
          pWhere.Visible := True;
        end;
    end;
    Splitter3.Visible := pValueSet.Visible;

    cbWhere.Enabled := (cbSQLStatement.ItemIndex in [0,2]);
    if cbWhere.Enabled then
    begin
      case cbWhere.ItemIndex of
        0: // Key Fields
          begin
            ApplyChecked(tvWhere, FKeyFields);
          end;
        1: // All Fields
          begin
            ApplyChecked(tvWhere, nil, True);
          end;
        2: // Not Null Fields
          begin
            ApplyChecked(tvWhere, FNotNullFields);
          end;
        3: // Custom Fields
          begin
          end;
       end;
    end;   

    if (tmp <> nil) and (not cbSQL.Checked)
      then memSQL.Lines.Text := BuldSQL(FMain.DestDialect, cbSQLStatement.ItemIndex, tmp.TheText, SaveChecked(tvValueSet), SaveChecked(tvWhere));
  end;
end;

procedure TibpUpdWizard.tvWhereKeyPress(Sender: TObject; var Key: Char);
begin
  cbSQLStatementChange(nil);
end;

procedure TibpUpdWizard.cbWhereChange(Sender: TObject);
begin
  if (not IsInSetup) and cbWhere.Enabled then
  begin
    cbOverWhere.Checked := cbWhere.ItemIndex = Pred(cbWhere.Items.Count);
    cbSQLStatementChange(nil);
  end;
end;

procedure TibpUpdWizard.btnTestClick(Sender: TObject);
var
  ibQuery: TIBQuery;
begin
  ibQuery := TIBQuery.Create(nil);
  try
    ibQuery.Database := FMain.DM.DBDest;
    ibQuery.Transaction := ibQuery.Database.DefaultTransaction;
    ibQuery.SQL.Assign(memSQL.Lines);
    ibQuery.Prepare;
    try
      ibQuery.GenerateParamNames := True;
      ShowMessage(Format('Passed!' + #13 + 'Found %d Params.', [ibQuery.Params.Count]));
    except
      on E: Exception do
      begin
        ShowMessage(Format('Failed!' + #13 + '%s', [E.Message]));
      end;
    end;
  finally
    ibQuery.Free;
  end;
end;

procedure TibpUpdWizard.btnSaveClick(Sender: TObject);
var
  nd: TccTreeNode;
  uItem: TUpdWizardCollectionItem;

  procedure SelNode(ANode: TccTreeNode);
  begin
    if ANode <> nil then
    begin
      tv.Selected := ANode;
      ANode.MakeVisible;
    end;
  end;

begin
  nd := tv.Items.GetFirstNode;
  while nd <> nil do
  begin
    if nd.Checked then
    begin
       SelNode(nd);
       tv.Selected := nil;
       if tv.Selected <> nil
         then exit;
    end;
    nd := nd.GetNextSibling;
  end;

  nd := tv.Items.GetFirstNode;
  while nd <> nil do
  begin
    if nd.Checked then
    begin
      uItem := FSets.FindByName(nd.TheText);
      FMain.AddCustomSQLParams(uItem.Name + #0 + uItem.SQL.Text, nil);
    end;
    nd := nd.GetNextSibling;
  end;

  ModalResult := mrOk;
end;

procedure TibpUpdWizard.cbDefSQLChange(Sender: TObject);
begin
  cbDefWhere.Enabled := (cbDefSQL.ItemIndex in [0,2]);

  if not cbDefWhere.Enabled
    then cbWhere.ItemIndex := 1;
end;

procedure TibpUpdWizard.tvCustomDraw(Sender: TObject;
  TreeNode: TccTreeNode; AFont: TFont; var AColor, ABkColor: TColor);
begin
  if Pos(#0, TreeNode.Text) > 0 then
  begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TibpUpdWizard.FormCreate(Sender: TObject);
begin
  GetWindStat(Self);
end;

procedure TibpUpdWizard.FormDestroy(Sender: TObject);
begin
  SetWindStat(Self);
end;

end.
