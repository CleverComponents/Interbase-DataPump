object ibpSQLEditor: TibpSQLEditor
  Left = 352
  Top = 208
  Width = 598
  Height = 466
  Caption = 'SQL Editor '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 386
    Width = 582
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      582
      41)
    object btnSave: TButton
      Left = 416
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = '&Save'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 582
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 156
      Top = 0
      Height = 386
      Beveled = True
    end
    object Panel3: TPanel
      Left = 159
      Top = 0
      Width = 423
      Height = 386
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Splitter1: TSplitter
        Left = 0
        Top = 185
        Width = 423
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        Beveled = True
      end
      object Panel5: TPanel
        Left = 0
        Top = 188
        Width = 423
        Height = 198
        Align = alBottom
        Anchors = [akBottom]
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          423
          198)
        object DBGrid: TDBGrid
          Left = 0
          Top = 44
          Width = 431
          Height = 153
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = DS
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
        object btnExecute: TButton
          Left = 347
          Top = 8
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Execute'
          TabOrder = 0
          OnClick = btnExecuteClick
        end
        object btnParams: TButton
          Left = 347
          Top = 8
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Get Params'
          TabOrder = 1
          OnClick = btnParamsClick
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 423
        Height = 185
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          423
          185)
        object lName: TLabel
          Left = 11
          Top = 10
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object eName: TEdit
          Left = 50
          Top = 8
          Width = 161
          Height = 21
          TabOrder = 0
          Text = 'eName'
        end
        object memSQL: TMemo
          Left = 0
          Top = 38
          Width = 431
          Height = 158
          Anchors = [akLeft, akTop, akRight, akBottom]
          HideSelection = False
          ScrollBars = ssBoth
          TabOrder = 1
          WordWrap = False
        end
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 156
      Height = 386
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object DS: TDataSource
    AutoEdit = False
    Left = 384
    Top = 104
  end
  object qryBDE: TQuery
    Left = 316
    Top = 48
  end
  object qryIB: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    Left = 316
    Top = 96
  end
  object popMenu: TPopupMenu
    OnPopup = popMenuPopup
    Left = 88
    Top = 32
    object AddTableName1: TMenuItem
      Caption = 'Add Table Name'
      OnClick = AddTableName1Click
    end
    object AddFieldName1: TMenuItem
      Caption = 'Add Field Name'
      OnClick = AddTableName1Click
    end
    object AddAllFields1: TMenuItem
      Caption = 'Add All Field Names'
      OnClick = AddAllFields1Click
    end
  end
  object qryADO: TADOQuery
    AutoCalcFields = False
    LockType = ltReadOnly
    Parameters = <>
    Left = 319
    Top = 144
  end
end
