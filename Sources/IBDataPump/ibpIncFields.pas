{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ibpIncFields.pas
}

unit ibpIncFields;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  Db, DBTables, DBGrids, Grids, StdCtrls, DbiTypes , ComCtrls, ExtCtrls, ImgList, 
    ibpMain, ibpDM;

type

  { TibpIncFields }

  TibpIncFields = class(TForm)
    imgFields: TImageList;
    Panel1: TPanel;
    bvlBottom: TBevel;
    btnAdd: TButton;
    btnDelete: TButton;
    btnClearAll: TButton;
    btnOk: TButton;
    Panel2: TPanel;
    lTable: TLabel;
    lField: TLabel;
    lvFields: TListView;
    cbInt: TCheckBox;
    cbTables: TComboBox;
    cbFields: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbIntClick(Sender: TObject);
    procedure cbTablesChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cbFieldsChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvFieldsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    FMain: TibpMain;
    FFieldsCash: TStringList;

    procedure ClearFieldsCash;
    procedure GetFields(const ATableName: string; AList: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    function Find(const ATable, AField: string): boolean;
  end;

implementation

{$R *.DFM}

{ TibpIncFields }

constructor TibpIncFields.Create(AOwner: TComponent);
begin
  inherited;
  FMain := AOwner as TibpMain;
end;

procedure TibpIncFields.FormCreate(Sender: TObject);
begin
  FFieldsCash := TStringList.Create;
  GetWindStat(Self);
end;

procedure TibpIncFields.FormDestroy(Sender: TObject);
begin
  ClearFieldsCash;
  FFieldsCash.Free;
  SetWindStat(Self);
end;

procedure TibpIncFields.ClearFieldsCash;
var
  i: integer;
begin
  for i := 0 to FFieldsCash.Count-1
    do TStringList(FFieldsCash.Objects[i]).Free;
  FFieldsCash.Clear;
end;

procedure TibpIncFields.FormShow(Sender: TObject);
var
  lst: TStringList;
begin
  ClearFieldsCash;
  lst := TStringList.Create;
  try
    try
      case FMain.SrcType of
        pdtBDE: Session.GetTableNames(FMain.DM.bdeDb.DatabaseName, '', not FMain.DM.bdeDb.IsSQLBased, False, lst);
        pdtADO: FMain.DM.adoDb.GetTableNames(lst, False);
      else
        raise Exception.Create(ErrSrc);
      end;
      cbTables.Items.Assign(lst);
    except
      on E: Exception do
      begin
        ShowMessage(Format('Can not get list of tables for Source DB: Error - %s', [E.Message]));
      end;
    end;
  finally
    lst.Free;
  end;

  lvFieldsSelectItem(lvFields, lvFields.Selected, True);
end;

procedure TibpIncFields.GetFields(const ATableName: string; AList: TStrings);
var
  i, j: integer;
  lst: TStringList;
  ds: TDataset;
  FTableName: string;
begin
  AList.Clear;
  if Length(Trim(ATableName)) > 0 then
  begin
    i := FFieldsCash.IndexOf(ATableName);
    if i = -1 then
    begin
      lst := TStringList.Create;
      try
        case FMain.SrcType of
          pdtBDE:
            begin
              if FMain.DM.bdeDb.IsSQLBased and FMain.SrcQuoteFields
                then FTableName := GetSQLName(ATableName, FMain.SrcType, FMain.SrcSelect)
                else FTableName := ATableName;
              FMain.bdeTable.TableName := FTableName;
              ds := FMain.bdeTable;
            end;
          pdtADO:
            begin
              if FMain.SrcQuoteFields
                then FTableName := GetSQLName(ATableName, FMain.SrcType, FMain.SrcSelect)
                else FTableName := ATableName;
              FMain.adoTable.TableName := FTableName;
              ds := FMain.adoTable;
            end;
        else
          raise Exception.Create(ErrSrc);
        end;

        with ds do
        begin
          Close;
          FieldDefs.Update;
          for j := 0 to FieldDefs.Count-1 do
          begin
            if (not cbInt.Checked) or
               (FieldDefs[j].FieldClass.InheritsFrom(TIntegerField))
              then lst.Add(FieldDefs[j].Name);
          end;
          FFieldsCash.AddObject(ATableName, lst);
        end;
      except
        lst.Free;
        lst := nil;
      end;
    end
    else
    begin
      lst := TStringList(FFieldsCash.Objects[i]);
    end;
    if lst <> nil
      then AList.Assign(lst);
  end;
end;

procedure TibpIncFields.cbIntClick(Sender: TObject);
begin
  ClearFieldsCash;
  lvFields.Selected := nil;
end;

procedure TibpIncFields.btnClearAllClick(Sender: TObject);
begin
  lvFields.Items.Clear;
end;

procedure TibpIncFields.btnAddClick(Sender: TObject);
var
  li: TListItem;
begin
  li := lvFields.Items.Add;
  li.SubItems.Add('');
  lvFields.Selected := li;
  lvFields.Selected.MakeVisible(False);
end;

procedure TibpIncFields.btnDeleteClick(Sender: TObject);
begin
  if lvFields.Selected <> nil then
  begin
    lvFields.Selected.Delete;
    if lvFields.Items.Count > 0 then
    begin
      lvFields.Selected :=lvFields.Items[0];
      lvFields.Selected.MakeVisible(False);
    end;
  end;
end;

procedure TibpIncFields.cbTablesChange(Sender: TObject);
var
 oldVal: string;
begin
  if Self.Visible then
  begin
    oldVal := cbFields.Text;
    GetFields(TComboBox(Sender).Text, cbFields.Items);
    cbFields.ItemIndex := cbFields.Items.IndexOf(oldVal);
    if lvFields.Selected <> nil then
    begin
      lvFields.Selected.Caption := TComboBox(Sender).Text;
      lvFields.Selected.SubItems[0] := '';
    end;
  end;
end;

procedure TibpIncFields.cbFieldsChange(Sender: TObject);
begin
  if Self.Visible and (lvFields.Selected <> nil)
    then lvFields.Selected.SubItems[0] := TComboBox(Sender).Text;
end;

procedure TibpIncFields.lvFieldsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Self.Visible then
  begin
    if Selected and (Item <> nil) then
    begin
      cbTables.Enabled := True;
      cbFields.Enabled := True;

      cbTables.ItemIndex := cbTables.Items.IndexOf(Item.Caption);
      if cbTables.ItemIndex = -1
        then cbFields.Items.Clear
        else GetFields(cbTables.Text, cbFields.Items);
      cbFields.ItemIndex := cbFields.Items.IndexOf(Item.SubItems[0]);
    end
    else
    begin
      cbTables.Enabled := False;
      cbFields.Enabled := False;

      cbTables.ItemIndex := -1;
      cbFields.ItemIndex := -1;
    end;
  end;
end;

function TibpIncFields.Find(const ATable, AField: string): boolean;
var
  i: integer;
begin
  result := False;
  for i := 0 to lvFields.Items.Count-1 do
  begin
    result := ((lvFields.Items[i].Caption = ATable) and (Length(AField) = 0)) or
              ((lvFields.Items[i].Caption = ATable) and (lvFields.Items[i].SubItems[0] = AField));
    if result
      then Break;
  end;
end;

end.
