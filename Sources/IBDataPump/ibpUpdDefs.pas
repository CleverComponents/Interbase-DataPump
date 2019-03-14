{
  Copyright (c) 2000-2005 CleverComponents.com
  Product: Interbase DataPump
  Author: Alexandre Poloziouk
  Unit: ibpUpdDefs.pas
}

unit ibpUpdDefs;

interface

{$INCLUDE ccGetVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
    ibpMain, ccTreeView;

type

  { TRelCollectionItem }

  TRelCollectionItem = class(TCollectionItem)
  private
    FChk: boolean;
    FDest: string;
    FSrc: string;
    FDestLst: TStringList;
    FSrcLst: TStringList;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Chk: boolean read FChk write FChk;
    property Dest: string read FDest write FDest;
    property Src: string read FSrc write FSrc;
    property DestLst: TStringList read FDestLst write FDestLst;
    property SrcLst: TStringList read FSrcLst write FSrcLst;
  end;

  { TibpUpdDefs }

  TibpUpdDefs = class(TForm)
    memRep: TMemo;
    btnStart: TButton;
    btnClose: TButton;
    Panel1: TPanel;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCol: TCollection;
    FGen: TCollection;
    FCustomSQL: TStringList;
    FCustomTrSQL: TStringList;
    FCustomParams: TStringList;
    FMain: TibpMain;

    procedure SaveRelations(ACol: TCollection; tvDest: TccTreeView);
    procedure RestoreRelations(ACol: TCollection; tvDest, tvSrc: TccTreeView; ADropProc: TDragDropEvent);
    procedure SaveCustomSQL(tv: TccTreeView; ACustomSQL: TStringList);
  public
     constructor Create(AOwner: TComponent); override;
  end;

  { Common }

  procedure DoUpdDefs(AMain: TibpMain);

implementation

{$R *.DFM}

{ Common }

procedure DoUpdDefs(AMain: TibpMain);
var
  FUpdDefs: TibpUpdDefs;
begin
  FUpdDefs := TibpUpdDefs.Create(AMain);
  try
    FUpdDefs.ShowModal;
  finally
    FUpdDefs.Free;
  end;
end;

{ TRelCollectionItem }

constructor TRelCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FChk := False;
  SetLength(FDest, 0);
  SetLength(FSrc, 0);
  FDestLst := TStringList.Create;
  FSrcLst := TStringList.Create;
end;

destructor TRelCollectionItem.Destroy;
begin
  FDestLst.Free;
  FSrcLst.Free;
  inherited;
end;

{ TibpUpdDefs }

constructor TibpUpdDefs.Create(AOwner: TComponent);
begin
  inherited;
  FMain := AOwner as TibpMain;
end;

procedure TibpUpdDefs.FormCreate(Sender: TObject);
begin
  FCol := TCollection.Create(TRelCollectionItem);
  FGen := TCollection.Create(TRelCollectionItem);
  FCustomSQL := TStringList.Create;
  FCustomTrSQL := TStringList.Create;
  FCustomParams := TStringList.Create;
  GetWindStat(Self);
end;

procedure TibpUpdDefs.FormDestroy(Sender: TObject);
begin
  FCol.Free;
  FGen.Free;
  FCustomSQL.Free;
  FCustomTrSQL.Free;
  FCustomParams.Free;
  SetWindStat(Self);
end;

procedure TibpUpdDefs.btnStartClick(Sender: TObject);
begin
  memRep.Lines.Clear;
  memRep.Lines.Add('=== Start: ' + DateTimeToStr(now));

  SaveRelations(FCol, FMain.tvDest);
  SaveRelations(FGen, FMain.tvDestTr);

  SaveCustomSQL(FMain.tvSource, FCustomSQL);
  SaveCustomSQL(FMain.tvSourceTr, FCustomTrSQL);
  SaveCustomSQL(FMain.tvDest, FCustomParams);

  FMain.btnGetDfn.Click;

  FMain.RestoreCustomSQLFields(FCustomSQL, FMain.tvSource);
  FMain.RestoreCustomSQLFields(FCustomTrSQL, FMain.tvSourceTr);
  FMain.RestoreCustomSQLParams(FCustomParams);

  RestoreRelations(FCol, FMain.tvDest, FMain.tvSource, FMain.tvDestDragDrop);
  RestoreRelations(FGen, FMain.tvDestTr, FMain.tvSourceTr, FMain.tvDestTrDragDrop);
  
  memRep.Lines.Add('=== Finish: ' + DateTimeToStr(now));
end;

procedure TibpUpdDefs.SaveRelations(ACol: TCollection; tvDest: TccTreeView);
var
  nd, ndc: TccTreeNode;
  Item: TRelCollectionItem;
begin
  ACol.Clear;
  nd := tvDest.Items.GetFirstNode;
  while nd <> nil do
  begin
    Item := TRelCollectionItem(ACol.Add);
    Item.Chk := nd.Checked;
    Item.Dest := nd.TheText;
    Item.Src := nd.InfoText;
    ndc := FindTheNode(nd, picRelationFields);
    if ndc <> nil then
    begin
      ndc := ndc.GetFirstChild;
      while ndc <> nil do
      begin
        Item.DestLst.Add(ndc.TheText);
        Item.SrcLst.Add(ndc.InfoText);
        ndc := ndc.GetNextSibling;
      end;
    end;
    nd := nd.GetNextSibling;
  end;
end;

procedure TibpUpdDefs.RestoreRelations(ACol: TCollection; tvDest, tvSrc: TccTreeView; ADropProc: TDragDropEvent);
var
  i, j: integer;
  nd, ndr, ndf, ndc, tmp: TccTreeNode;
  ns, nsc: TccTreeNode;
  Item: TRelCollectionItem;
  lTbl: boolean;
begin
  tvDest.Items.BeginUpdate;
  tvSrc.Items.BeginUpdate;
  try
    for i := 0 to ACol.Count-1 do
    begin
      Item := TRelCollectionItem(ACol.Items[i]);
      lTbl := False;
      nd := tvDest.Items.GetFirstNode;
      while nd <> nil do
      begin
        if nd.TheText = Item.Dest then
        begin
          lTbl := True;
          nd.Checked := Item.Chk;
          if IsConst(Item.Src) then
          begin
            nd.InfoText := Item.Src;
          end
          else
          begin
            if Length(Trim(Item.Src)) > 0 then
            begin
              ns := FindSourceTable(tvSrc, Item.Src);
              if ns <> nil then
              begin
                ndr := FindTheNode(nd, picRelationFields);
                ndf := FindTheNode(nd, picDestFields);
                if (ndr <> nil) or (ndf <> nil) then
                begin
                  MakeTableLink(nd, ns, False);
                  for j := 0 to Item.DestLst.Count-1 do
                  begin
                    if IsConst(Item.SrcLst[j]) then
                    begin
                      tmp := tvDest.Items.AddChild(ndr, Item.DestLst[j]);
                      tmp.InfoText := Item.SrcLst[j];
                      tmp.ImageIndex := Integer(picRelationField);
                      tmp.SelectedIndex := tmp.ImageIndex;
                      tmp.StateIndex := -1;
                      UpdateStatus(ndr.Parent);
                      UpdateFieldsStatus(ndr.Parent);
                    end
                    else
                    begin
                      ndc := FindSourceField(ndf, Item.DestLst[j]);
                      if ndc <> nil then
                      begin
                        nsc := FindSourceField(ns, Item.SrcLst[j]);
                        if nsc <> nil then
                        begin
                          ndc.MakeVisible;
                          nsc.MakeVisible;
                          tvSrc.Selected := nsc;
                          ADropProc(tvDest, tvSrc, ndc.DisplayRect(True).Left, ndc.DisplayRect(True).Top);
                        end
                        else
                        begin
                          memRep.Lines.Add(Format('Can not find SourceField: %s from SourceTable %s for DestField: %s from DestTable: %s',
                                                  [Item.SrcLst[j], Item.Src, Item.DestLst[j], Item.Dest]));
                        end;
                      end
                      else
                      begin
                        memRep.Lines.Add(Format('Can not find DestField: %s for DestTable: %s', [Item.DestLst[j], Item.Dest]));
                      end;
                    end;
                  end;
                end
                else
                begin
                  nd.InfoText := ns.TheText;
                  ns.Data := Pointer(Integer(ns.Data) + 1);
                end;
              end
              else
              begin
                memRep.Lines.Add(Format('Can not find Source: %s for Destination: %s', [Item.Src, Item.Dest]));
              end;
            end;
          end;
          break;
        end;
        nd := nd.GetNextSibling;
      end;
      if not lTbl
        then memRep.Lines.Add(Format('Can not find Destination: %s', [Item.Dest]));
    end;
    tvDest.FullCollapse;
    tvSrc.FullCollapse;
  finally
    tvDest.Items.EndUpdate;
    tvSrc.Items.EndUpdate;
  end;
end;

procedure TibpUpdDefs.SaveCustomSQL(tv: TccTreeView; ACustomSQL: TStringList);
var
  nd: TccTreeNode;
begin
  ACustomSQL.Clear;
  nd := tv.Items.GetFirstNode;
  while nd <> nil do
  begin
    if Pos(#0, nd.Text) > 0
      then ACustomSQL.Add(nd.Text);
    nd := nd.GetNextSibling;
  end;
end;

end.
