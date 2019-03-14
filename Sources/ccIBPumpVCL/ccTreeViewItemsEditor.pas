{
  Copyright (c) 2000-2002 CleverComponents.com
  Product: CleverComponents Interbase DataPump VCL
  Author: Alexandre Poloziouk, alex@CleverComponents.com
  Unit: ccTreeViewItemsEditor.pas
  Version: 1.0
}

unit ccTreeViewItemsEditor;

{$INCLUDE ccGetVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Mask,  
    ccTreeView, ccSpinEdit;

type
  TccTreeViewItemsEditor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Panel4: TPanel;
    bOk: TButton;
    bCancel: TButton;
    bApply: TButton;
    Label1: TLabel;                                     
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbBold: TCheckBox;
    eText: TEdit;
    eInfoText: TEdit;
    eImageInd: TccSpinEdit;
    eSelInd: TccSpinEdit;
    eStateInd: TccSpinEdit;
    Panel5: TPanel;
    bNew: TButton;
    bSub: TButton;
    bDel: TButton;
    bLoad: TButton;
    bSave: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    tree: TccTreeView;
    procedure treeChange(Sender: TObject; Node: TccTreeNode);
    procedure FormShow(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure bSubClick(Sender: TObject);
    procedure eTextExit(Sender: TObject);
    procedure eImageIndExit(Sender: TObject);
    procedure eSelIndExit(Sender: TObject);
    procedure eStateIndExit(Sender: TObject);
    procedure eInfoTextExit(Sender: TObject);
    procedure cbBoldExit(Sender: TObject);
    procedure bLoadClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure bApplyClick(Sender: TObject);
  private
    lRes: boolean;
    TV: TccTreeView;
  end;

function EditCCTreeView(ATV: TccTreeView): boolean;

implementation

{$R *.DFM}

function EditCCTreeView(ATV: TccTreeView): boolean;
var
  frmTreeView: TccTreeViewItemsEditor;
begin
  frmTreeView := TccTreeViewItemsEditor.Create(nil);
  with frmTreeView do
  begin
    try
      lRes := False;
      TV := ATV;
      tree.Items.Assign(ATV.Items);
      if ShowModal = mrOk then
      begin
        lRes := True;
        TV.Items.Assign(tree.Items);
      end;
    finally
      result := lRes;
      frmTreeView.Free;
    end;
  end;
end;

procedure TccTreeViewItemsEditor.treeChange(Sender: TObject; Node: TccTreeNode);
begin
  eText.Enabled := Node <> nil;
  eInfoText.Enabled := Node <> nil;
  eImageInd.Enabled := Node <> nil;
  eSelInd.Enabled := Node <> nil;
  eStateInd.Enabled := Node <> nil;
  cbBold.Enabled := Node <> nil;

  if Node = nil then
  begin
    eText.Text := '';
    eInfoText.Text := '';
    eImageInd.Text := '0';
    eSelInd.Text := '0';
    eStateInd.Text := '-1';
    cbBold.Checked := False;
  end
  else
  begin
    eText.Text := Node.Text;
    eInfoText.Text := Node.InfoText;
    eImageInd.Text := IntToStr(Node.ImageIndex);
    eSelInd.Text := IntToStr(Node.SelectedIndex);
    eStateInd.Text := IntToStr(Node.StateIndex);
    cbBold.Checked := Node.Bold;
  end;
end;

procedure TccTreeViewItemsEditor.FormShow(Sender: TObject);
begin
  treeChange(nil, nil);
end;

procedure TccTreeViewItemsEditor.bDelClick(Sender: TObject);
begin
  if tree.Selected <> nil
    then tree.Items.Delete(tree.Selected);
end;

procedure TccTreeViewItemsEditor.bNewClick(Sender: TObject);
var
  tn: TccTreeNode;
begin
  tn := tree.Items.Add(tree.Selected,'');
  tree.Selected := tn;
  eText.SetFocus;
end;

procedure TccTreeViewItemsEditor.bSubClick(Sender: TObject);
var
  tn: TccTreeNode;
begin
  if tree.Selected = nil
    then exit;
  tn := tree.Items.AddChild(tree.Selected,'');
  tree.Selected := tn;
  eText.SetFocus;
end;

procedure TccTreeViewItemsEditor.eTextExit(Sender: TObject);
begin
  if tree.Selected <> nil
    then tree.Selected.Text := eText.Text;
end;

procedure TccTreeViewItemsEditor.eImageIndExit(Sender: TObject);
begin
  if tree.Selected <> nil then
  begin
    try
      tree.Selected.ImageIndex := StrToInt(eImageInd.Text);
    except
      tree.Selected.ImageIndex := 0;
    end;
  end;
end;

procedure TccTreeViewItemsEditor.eSelIndExit(Sender: TObject);
begin
  if tree.Selected <> nil then
  begin
    try
      tree.Selected.SelectedIndex := StrToInt(eSelInd.Text);
    except
      tree.Selected.SelectedIndex := 0;
    end;
  end;
end;

procedure TccTreeViewItemsEditor.eStateIndExit(Sender: TObject);
begin
  if tree.Selected <> nil then
  begin
    try
      tree.Selected.StateIndex := StrToInt(eStateInd.Text);
    except
      tree.Selected.StateIndex := -1;
    end;
  end;
end;

procedure TccTreeViewItemsEditor.eInfoTextExit(Sender: TObject);
begin
  if tree.Selected <> nil
    then tree.Selected.InfoText := eInfoText.Text;
end;

procedure TccTreeViewItemsEditor.cbBoldExit(Sender: TObject);
begin
  if tree.Selected <> nil
    then tree.Selected.Bold := cbBold.Checked;
end;

procedure TccTreeViewItemsEditor.bLoadClick(Sender: TObject);
begin
  if OpenDialog.Execute
    then tree.LoadFromFile(OpenDialog.FileName);
end;

procedure TccTreeViewItemsEditor.bSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then tree.SaveToFile(SaveDialog.FileName);
end;

procedure TccTreeViewItemsEditor.bApplyClick(Sender: TObject);
begin
  lRes := True;
  TV.Items.Assign(tree.Items);
end;

end.
