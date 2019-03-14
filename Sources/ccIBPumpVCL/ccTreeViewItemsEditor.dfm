object ccTreeViewItemsEditor: TccTreeViewItemsEditor
  Left = 270
  Top = 185
  Width = 628
  Height = 213
  Caption = 'TreeView Items Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 157
    Width = 620
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel4: TPanel
      Left = 375
      Top = 0
      Width = 245
      Height = 29
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bOk: TButton
        Left = 5
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Ok'
        ModalResult = 1
        TabOrder = 0
      end
      object bCancel: TButton
        Left = 85
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object bApply: TButton
        Left = 169
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 2
        OnClick = bApplyClick
      end
    end
  end
  object Panel2: TPanel
    Left = 405
    Top = 0
    Width = 215
    Height = 157
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 215
      Height = 157
      Align = alClient
      Caption = 'Item Properties'
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 44
        Width = 58
        Height = 13
        Caption = 'Image Index'
      end
      object Label2: TLabel
        Left = 8
        Top = 118
        Width = 42
        Height = 13
        Caption = 'Info Text'
      end
      object Label3: TLabel
        Left = 8
        Top = 20
        Width = 21
        Height = 13
        Caption = 'Text'
      end
      object Label4: TLabel
        Left = 8
        Top = 69
        Width = 71
        Height = 13
        Caption = 'Selected Index'
      end
      object Label5: TLabel
        Left = 8
        Top = 93
        Width = 54
        Height = 13
        Caption = 'State Index'
      end
      object cbBold: TCheckBox
        Left = 7
        Top = 136
        Width = 91
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Bold'
        TabOrder = 0
        OnClick = cbBoldExit
        OnExit = cbBoldExit
      end
      object eText: TEdit
        Left = 85
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 1
        OnChange = eTextExit
        OnExit = eTextExit
      end
      object eInfoText: TEdit
        Left = 85
        Top = 114
        Width = 121
        Height = 21
        TabOrder = 2
        OnChange = eInfoTextExit
        OnExit = eInfoTextExit
      end
      object eImageInd: TccSpinEdit
        Left = 85
        Top = 41
        Width = 94
        Height = 21
        TabOrder = 3
        OnChange = eImageIndExit
        OnExit = eImageIndExit
        Alignment = taLeftJustify
        Increment = 1
        Max = 9999999
        Enabled = True
      end
      object eSelInd: TccSpinEdit
        Left = 85
        Top = 65
        Width = 94
        Height = 21
        TabOrder = 4
        OnChange = eSelIndExit
        OnExit = eSelIndExit
        Alignment = taLeftJustify
        Increment = 1
        Max = 9999999
        Enabled = True
      end
      object eStateInd: TccSpinEdit
        Left = 85
        Top = 90
        Width = 94
        Height = 21
        TabOrder = 5
        OnChange = eStateIndExit
        OnExit = eStateIndExit
        Alignment = taLeftJustify
        Increment = 1
        Max = 9999999
        Enabled = True
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 157
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel3'
    TabOrder = 2
    object tree: TccTreeView
      Left = 0
      Top = 0
      Width = 316
      Height = 157
      ReadOnly = True
      RightClickSelect = True
      HideSelection = False
      Indent = 19
      OnChange = treeChange
      Align = alClient
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 316
      Top = 0
      Width = 89
      Height = 157
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object bNew: TButton
        Left = 8
        Top = 6
        Width = 75
        Height = 25
        Caption = 'New Item'
        TabOrder = 0
        OnClick = bNewClick
      end
      object bSub: TButton
        Left = 8
        Top = 37
        Width = 75
        Height = 25
        Caption = 'New SebItem'
        TabOrder = 1
        OnClick = bSubClick
      end
      object bDel: TButton
        Left = 8
        Top = 69
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = bDelClick
      end
      object bLoad: TButton
        Left = 8
        Top = 102
        Width = 75
        Height = 25
        Caption = 'Load'
        TabOrder = 3
        Visible = False
        OnClick = bLoadClick
      end
      object bSave: TButton
        Left = 9
        Top = 132
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 4
        Visible = False
        OnClick = bSaveClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 42
    Top = 38
  end
  object SaveDialog: TSaveDialog
    Left = 42
    Top = 86
  end
end
