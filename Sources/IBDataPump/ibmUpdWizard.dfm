object ibpUpdWizard: TibpUpdWizard
  Left = 385
  Top = 222
  Width = 663
  Height = 480
  Caption = 'Custom SQL Wizard'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 647
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      647
      41)
    object btnSave: TButton
      Left = 481
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = '&Save'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 569
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
    Width = 647
    Height = 400
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 198
      Top = 0
      Height = 400
      Beveled = True
    end
    object Panel3: TPanel
      Left = 201
      Top = 0
      Width = 446
      Height = 400
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Splitter1: TSplitter
        Left = 0
        Top = 278
        Width = 446
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        Beveled = True
      end
      object Panel5: TPanel
        Left = 0
        Top = 281
        Width = 446
        Height = 119
        Align = alBottom
        Anchors = [akBottom]
        BevelOuter = bvNone
        TabOrder = 1
        object memSQL: TMemo
          Left = 0
          Top = 21
          Width = 446
          Height = 98
          Align = alClient
          HideSelection = False
          ScrollBars = ssBoth
          TabOrder = 1
          WordWrap = False
        end
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 446
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            446
            21)
          object cbSQL: TCheckBox
            Left = 4
            Top = 2
            Width = 260
            Height = 17
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Overwrite Generated SQL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            TabOrder = 0
            OnClick = cbSQLClick
          end
          object btnTest: TButton
            Left = 373
            Top = 1
            Width = 75
            Height = 19
            Anchors = [akTop, akRight]
            Caption = 'Test'
            TabOrder = 1
            OnClick = btnTestClick
          end
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 446
        Height = 278
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 446
          Height = 93
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            446
            93)
          object lInsertNameFormat: TLabel
            Left = 6
            Top = 47
            Width = 92
            Height = 13
            Caption = 'Insert Name Format'
          end
          object lUpdateNameFormat: TLabel
            Left = 6
            Top = 20
            Width = 101
            Height = 13
            Caption = 'Update Name Format'
          end
          object lDeleteNameFormat: TLabel
            Left = 6
            Top = 74
            Width = 97
            Height = 13
            Caption = 'Delete Name Format'
          end
          object Bevel2: TBevel
            Left = 0
            Top = 7
            Width = 454
            Height = 2
            Anchors = [akLeft, akTop, akRight]
            Shape = bsBottomLine
          end
          object Label1: TLabel
            Left = 0
            Top = 0
            Width = 75
            Height = 13
            Caption = 'Default Settings'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
          end
          object lDefSQLStat: TLabel
            Left = 259
            Top = 47
            Width = 72
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'SQL Statement'
          end
          object lDefWhere: TLabel
            Left = 259
            Top = 74
            Width = 68
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'WHERE fields'
          end
          object eInsertNameFormat: TEdit
            Left = 112
            Top = 43
            Width = 133
            Height = 21
            Hint = 'INS_%s_SQL'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = 'INS_%s_SQL'
            OnChange = eUpdateNameFormatChange
          end
          object eUpdateNameFormat: TEdit
            Left = 112
            Top = 16
            Width = 250
            Height = 21
            Hint = 'UPD_%s_SQL'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            Text = 'UPD_%s_SQL'
            OnChange = eUpdateNameFormatChange
          end
          object eDeleteNameFormat: TEdit
            Left = 112
            Top = 70
            Width = 133
            Height = 21
            Hint = 'DEL_%s_SQL'
            Anchors = [akLeft, akTop, akRight]
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            Text = 'DEL_%s_SQL'
            OnChange = eUpdateNameFormatChange
          end
          object btnDefaults: TButton
            Left = 373
            Top = 13
            Width = 75
            Height = 25
            Anchors = [akTop, akRight]
            Caption = 'Set Default'
            TabOrder = 3
            OnClick = btnDefaultsClick
          end
          object cbDefSQL: TComboBox
            Left = 340
            Top = 43
            Width = 110
            Height = 21
            Style = csDropDownList
            Anchors = [akTop, akRight]
            ItemHeight = 13
            TabOrder = 4
            OnChange = cbDefSQLChange
            Items.Strings = (
              'Update'
              'Insert'
              'Delete')
          end
          object cbDefWhere: TComboBox
            Left = 340
            Top = 70
            Width = 110
            Height = 21
            Style = csDropDownList
            Anchors = [akTop, akRight]
            ItemHeight = 13
            TabOrder = 5
            Items.Strings = (
              'Key Fields'
              'All Fields'
              'Not Null Fields'
              'Custom Fields')
          end
        end
        object Panel9: TPanel
          Left = 0
          Top = 93
          Width = 446
          Height = 185
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Panel10: TPanel
            Left = 0
            Top = 0
            Width = 446
            Height = 93
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              446
              93)
            object Bevel1: TBevel
              Left = 0
              Top = 7
              Width = 454
              Height = 2
              Anchors = [akLeft, akTop, akRight]
              Shape = bsBottomLine
            end
            object Label2: TLabel
              Left = 0
              Top = 0
              Width = 113
              Height = 13
              Caption = 'Selected Table Settings'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsUnderline]
              ParentFont = False
            end
            object lSQLStatement: TLabel
              Left = 6
              Top = 46
              Width = 72
              Height = 13
              Caption = 'SQL Statement'
            end
            object lWhere: TLabel
              Left = 6
              Top = 72
              Width = 68
              Height = 13
              Caption = 'WHERE fields'
            end
            object cbSQLStatement: TComboBox
              Left = 112
              Top = 42
              Width = 250
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              ItemHeight = 13
              TabOrder = 2
              OnChange = cbSQLStatementChange
              Items.Strings = (
                'Update'
                'Insert'
                'Delete')
            end
            object eName: TEdit
              Left = 112
              Top = 16
              Width = 250
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              ParentShowHint = False
              ShowHint = False
              TabOrder = 1
            end
            object cbName: TCheckBox
              Left = 4
              Top = 19
              Width = 106
              Height = 17
              Caption = 'Overwrite Name'
              TabOrder = 0
              OnClick = cbNameClick
            end
            object cbWhere: TComboBox
              Left = 112
              Top = 68
              Width = 250
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              ItemHeight = 13
              TabOrder = 3
              OnChange = cbWhereChange
              Items.Strings = (
                'Key Fields'
                'All Fields'
                'Not Null Fields'
                'Custom Fields')
            end
          end
          object Panel11: TPanel
            Left = 0
            Top = 93
            Width = 446
            Height = 92
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Splitter3: TSplitter
              Left = 235
              Top = 0
              Height = 92
              Align = alRight
              Beveled = True
            end
            object pWhere: TPanel
              Left = 0
              Top = 0
              Width = 235
              Height = 92
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object Panel15: TPanel
                Left = 0
                Top = 0
                Width = 235
                Height = 21
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  235
                  21)
                object cbOverWhere: TCheckBox
                  Left = 4
                  Top = 2
                  Width = 232
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  Caption = 'Overwrite Where Fields'
                  TabOrder = 0
                  OnClick = cbOverWhereClick
                end
              end
            end
            object pValueSet: TPanel
              Left = 238
              Top = 0
              Width = 208
              Height = 92
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
              object Panel14: TPanel
                Left = 0
                Top = 0
                Width = 208
                Height = 21
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  208
                  21)
                object cbOverValueSet: TCheckBox
                  Left = 4
                  Top = 2
                  Width = 202
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  Caption = 'Overwrite Value(Set ) Fields'
                  TabOrder = 0
                  OnClick = cbOverValueSetClick
                end
              end
            end
          end
        end
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 198
      Height = 400
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
end
