{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ibpSQLEditor.pas
}

unit ibpSQLEditor;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, DBGrids, Db, DBTables, IBCustomDataSet,
  IBQuery, IBDataBase, Menus, ADODB,
    ibpMain, ccTreeView;

type

  { TibpSQLEditor }

  TibpSQLEditor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnSave: TButton;
    btnCancel: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Splitter1: TSplitter;
    btnExecute: TButton;
    DBGrid: TDBGrid;
    DS: TDataSource;
    Panel6: TPanel;
    lName: TLabel;
    eName: TEdit;
    memSQL: TMemo;
    qryBDE: TQuery;
    qryIB: TIBQuery;
    popMenu: TPopupMenu;
    AddTableName1: TMenuItem;
    AddAllFields1: TMenuItem;
    AddFieldName1: TMenuItem;
    Splitter2: TSplitter;
    qryADO: TADOQuery;
    btnParams: TButton;
    procedure btnExecuteClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure popMenuPopup(Sender: TObject);
    procedure AddTableName1Click(Sender: TObject);
    procedure AddAllFields1Click(Sender: TObject);
    procedure tvDblClick(Sender: TObject);
    procedure tvMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnParamsClick(Sender: TObject);
    procedure tvCustomDraw(Sender: TObject; TreeNode: TccTreeNode;
      AFont: TFont; var AColor, ABkColor: TColor);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FConnection: TCustomConnection;
    FSQL: TStrings;
    FTV: TccTreeView;
    FTable: string;
    FSQLDialect: integer;
    FQuoteFields: integer;
    FConnectionType: TPumpDatabaseType;
    FMain: TibpMain;


    // ccCompos
    tv: TccTreeView;
    tvParams: TccTreeView;

    function Init: boolean;
    function CheckName: boolean;
    procedure DeInit;
    procedure OnSQLChanged(Sender: TObject);
  public
     constructor Create(AOwner: TComponent); override;
  end;

  { Common }

  function DoSQLEditor(AMain: TibpMain; AConnection: TCustomConnection; var ASQL: string; ATV: TccTreeView): boolean;

implementation

{$R *.DFM}

{ Common }

function DoSQLEditor(AMain: TibpMain; AConnection: TCustomConnection; var ASQL: string; ATV: TccTreeView): boolean;
var
  FSQLEditor: TibpSQLEditor;
  i: integer;
begin
  result := False;
  FSQLEditor := TibpSQLEditor.Create(AMain);
  try
    try
      with FSQLEditor do
      begin
        FConnection := AConnection;
        FTV := ATV;
        i := Pos(#0, ASQL);
        FTable := Trim(Copy(ASQL, 1, Pred(i)));
        eName.Text := FTable;
        memSQL.Lines.Text := Copy(ASQL, Succ(i), Length(ASQL));

        if ATV = FMain.tvDest then
        begin
          FConnectionType := pdtIB;
          FSQLDialect := FMain.DestDialect;
          FQuoteFields := FSQLDialect;
        end
        else
        begin
          if (ATV = FMain.tvSource) or (ATV = FMain.tvSourceTr) then
          begin
            if FMain.SrcQuoteFields
              then FQuoteFields := FMain.SrcSelect
              else FQuoteFields := 0;

            FConnectionType := FMain.SrcType;
            case FConnectionType of
              pdtIB:
                begin
                  FSQLDialect := FMain.SrcDialect;
                end;
              pdtBDE, pdtADO:
                begin
                  FSQLDialect := FMain.SrcSelect;
                end;
            else
              raise Exception.Create(ErrSrc);
            end;
          end
          else
          begin
            raise Exception.Create(ErrSrc);
          end;
        end;

        result := Init and (ShowModal = mrOK);
        if result
          then ASQL := Trim(eName.Text) + #0 + memSQL.Lines.Text;
      end;
    finally
      FSQLEditor.DeInit;
    end;
  finally
    FSQLEditor.Free;
  end;
end;

{ TibpSQLEditor }

constructor TibpSQLEditor.Create(AOwner: TComponent);
begin
  inherited;
  FMain := AOwner as TibpMain;

    // create ccCompos (avoid package) 
  tvParams:= TccTreeView.Create(Self);
  with tvParams do
  begin
    Parent:= Panel5;
    Left:= 0;
    Top:= 44;
    Width:= 431;
    Height:= 153;
    ReadOnly:= True;
    HideSelection:= False;
    Indent:= 19;
//    Items.Data:= {
//            0100000000010000000000000000FFFFFFFFFFFFFFFF00000000000000000600
//            000000000000506172616D73};
    TabOrder:= 2;
    TabStop:= False;
    Anchors:= [akLeft, akTop, akRight, akBottom];
  end;
  tv:= TccTreeView.Create(Self);
  with tv do
  begin
    Parent:= Panel4;  
    Left:= 0;
    Top:= 0;
    Width:= 156;
    Height:= 398;
    ReadOnly:= True;
    HideSelection:= False;
    Indent:= 19;
    Align:= alClient;
    TabOrder:= 0;
    OnMouseDown:= tvMouseDown;
    OnDblClick:= tvDblClick;
    PopupMenu:= popMenu;
    OnCustomDraw:= tvCustomDraw;
  end;
end;

function TibpSQLEditor.Init: boolean;
var
  l: boolean;
begin
  result := False;

  btnSave.Enabled := False;

  try FConnection.Open except end;

  if not FConnection.Connected then
  begin
    Caption := Format('%s - Not Connected!', [Caption]);
    if Length(Trim(eName.Text)) = 0 then
    begin
      FMain.PumpDlg('Can not create new SQL because can not connect to database!', mtError, [mbOk], 0);
      exit;
    end;
  end;

  memSQL.OnChange := OnSQLChanged;
  eName.OnChange := OnSQLChanged;

  memSQL.ReadOnly := not FConnection.Connected;
  btnExecute.Enabled := FConnection.Connected;
  eName.Enabled := FConnection.Connected;

  l := False;

  if FConnection is TIBDatabase then
  begin
    qryIB.Database := TIBDatabase(FConnection);
    qryIB.Transaction := TIBDatabase(FConnection).DefaultTransaction;
    DS.Dataset := qryIB;
    FSQL := qryIB.SQL;
    l := True;
  end;

  if FConnection is TDatabase then
  begin
    qryBDE.DatabaseName := TDatabase(FConnection).DatabaseName;
    DS.Dataset := qryBDE;
    FSQL := qryBDE.SQL;
    l := True;
  end;

  if FConnection is TADOConnection then
  begin
    qryADO.Connection := TADOConnection(FConnection);
    DS.Dataset := qryADO;
    FSQL := qryADO.SQL;
    l := True;
  end;

  if not l then
  begin
    FMain.PumpDlg(Format('Connection %s has unsupported class %s!', [FConnection.Name, FConnection.ClassName]), mtError, [mbOk], 0);
    exit;
  end;

  if FTV = FMain.tvDest
    then AssignTree(FTV, tv, True)
    else AssignTree(FMain.tvSource, tv, False);

  if FTV = FMain.tvDest
    then Caption := Caption + FMain.GetDestDB
    else Caption := Caption + FMain.GetSourceDB;

  DBGrid.Visible := (FTV = FMain.tvSource) or (FTV = FMain.tvSourceTr);
  btnExecute.Visible := DBGrid.Visible;

  tvParams.Visible := FTV = FMain.tvDest;
  btnParams.Visible := FTV = FMain.tvDest;

  result := True;
end;

procedure TibpSQLEditor.DeInit;
begin
  memSQL.OnChange := nil;
  eName.OnChange := nil;
  DS.Dataset := nil;
end;

procedure TibpSQLEditor.OnSQLChanged(Sender: TObject);
begin
  btnSave.Enabled := True;
end;

procedure TibpSQLEditor.btnExecuteClick(Sender: TObject);
begin
  DS.DataSet.Close;
  FSQL.Assign(memSQL.Lines);
  DS.DataSet.Open;
end;

procedure TibpSQLEditor.btnParamsClick(Sender: TObject);
var
  tmpQ: TIBQuery;
  i: integer;
  nd: TccTreeNode;
begin
  if DS.DataSet is TIBQuery then
  begin
    tmpQ := DS.DataSet as TIBQuery;
    tmpQ.Close;
    FSQL.Assign(memSQL.Lines);
    try
      tvParams.Items.BeginUpdate;
      try
        nd := tvParams.Items.GetFirstNode;
        nd.DeleteChildren;
        nd.InfoText := '(0)';
        tmpQ.Prepare;
        tmpQ.GenerateParamNames := True;
        for i := 0 to tmpQ.ParamCount-1
          do tvParams.Items.AddChild(nd, tmpQ.Params[i].Name);
        nd.InfoText := Format('(%d)', [tmpQ.ParamCount]);
        nd.Expand(True);
      finally
        tvParams.Items.EndUpdate;
      end;
    finally
      tmpQ.UnPrepare;
    end;
  end
  else
  begin
    raise Exception.Create(Format('Wrong class %s', [DS.ClassName]));
  end;
end;

procedure TibpSQLEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOK then
  begin
    DoControlExit;
    CanClose := False;

    if Length(Trim(eName.Text)) = 0 then
    begin
      if eName.CanFocus
        then eName.SetFocus;
      FMain.PumpDlg('Name can not be empty!', mtError, [mbOk], 0);
      Exit;
    end;

    if Length(Trim(memSQL.Lines.Text)) = 0 then
    begin
      if memSQL.CanFocus
        then memSQL.SetFocus;
      FMain.PumpDlg('SQL can not be empty!', mtError, [mbOk], 0);
      Exit;
    end;

    if not CheckName then
    begin
      FMain.PumpDlg('Name duplicated!', mtError, [mbOk], 0);
      Exit;
    end;

    CanClose := True;
  end;
end;

procedure TibpSQLEditor.popMenuPopup(Sender: TObject);
begin
  AddTableName1.Visible := (tv.Selected <> nil) and (tv.Selected.ImageIndex <= Integer(picTableLoop));
  AddAllFields1.Visible := (tv.Selected <> nil) and (tv.Selected.ImageIndex <= Integer(picTableLoop));
  AddFieldName1.Visible := (tv.Selected <> nil) and (tv.Selected.ImageIndex in [Integer(picSourceField), Integer(picDestField)]);
end;

procedure TibpSQLEditor.AddTableName1Click(Sender: TObject);
var
  s: string;
  i: integer;
begin
  if memSQL.CanFocus then
  begin
    memSQL.SetFocus;
    if tv.Selected.ImageIndex <= Integer(picTableLoop)
      then i := FSQLDialect
      else i := FQuoteFields;
    s := GetSQLName(tv.Selected.Text, FConnectionType, i);
    memSQL.SetSelTextBuf(PChar(Format(' %s ', [s])));
  end;
end;

procedure TibpSQLEditor.AddAllFields1Click(Sender: TObject);
var
  nd: TccTreeNode;
  s: string;
begin
  if memSQL.CanFocus then
  begin
    s := ',';
    memSQL.SetFocus;
    nd := tv.Selected.GetFirstChild;
    while nd <> nil do
    begin
      memSQL.SetSelTextBuf(PChar(Format(' %s ', [GetSQLName(nd.Text, FConnectionType, FQuoteFields)])));
      nd := nd.GetNextSibling;
      if nd <> nil
        then memSQL.SetSelTextBuf(PChar(s));
    end;
  end;
end;

procedure TibpSQLEditor.tvDblClick(Sender: TObject);
begin
  if tv.Selected <> nil then
  begin
    if (tv.Selected.ImageIndex <= Integer(picTableLoop)) and
       (GetAsyncKeyState(VK_CONTROL) < 0) then
    begin
      AddAllFields1Click(Sender);
      exit;
    end;
    if tv.Selected.ImageIndex in [Integer(picTableNoLinks),
                                  Integer(picTableLinks),
                                  Integer(picTableLoop),
                                  Integer(picSourceField),
                                  Integer(picDestField)] then
    begin
      AddTableName1Click(Sender);
      exit;
    end;
  end;
end;

function TibpSQLEditor.CheckName: boolean;
var
  AName: string;
  nd: TccTreeNode;
begin
  result := False;
  AName := UpperCase(Trim(eName.Text));
  if UpperCase(FTable) <> AName then
  begin
    nd := FTV.Items.GetFirstNode;
    while nd <> nil do
    begin
      if UpperCase(nd.TheText) = AName
        then exit;
      nd := nd.GetNextSibling;
    end;
  end;
  result := True;
end;

procedure TibpSQLEditor.tvMouseDown(Sender: TObject; Button: TMouseButton;
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


procedure TibpSQLEditor.tvCustomDraw(Sender: TObject;
  TreeNode: TccTreeNode; AFont: TFont; var AColor, ABkColor: TColor);
begin
  if Pos(#0, TreeNode.Text) > 0 then
  begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TibpSQLEditor.FormCreate(Sender: TObject);
begin
  GetWindStat(Self);
end;

procedure TibpSQLEditor.FormDestroy(Sender: TObject);
begin
  SetWindStat(Self);
end;

end.
