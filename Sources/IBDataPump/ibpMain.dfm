object ibpMain: TibpMain
  Left = 856
  Top = 174
  Width = 680
  Height = 480
  Caption = 'Interbase DataPump'
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 610
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF000777777777777777777777000000000078AA
    AAAAAAAAAAAAAAAAA7000100000078AFFFF8FFFFFF8FFFFFA7001100000078AF
    FFF7FFFFFF7FFFFFA7019911110078AFFFF7FFFFFF7FFFFFA7199999991078A8
    7777777777777778A1199999999178AFFFF7FFFFFF7FFFFFA7199999999978AF
    FFF7FFFFFF7FFFFFA7019911199978AFFFF7FFFFFF7FFFFFA7001100019978A8
    7777777777777778A7000100001978AFFFF7FFFFFF7FFFFFA7777777001978AF
    FFF7FFFFFF7FFFFFA8777777001978AFFFF7FFFFFF7FFFFFAFFFFF77001978A8
    7777777777777778AFFFFF77001978AFFFF7FFFFFF7FFFFFAFFFFF77019978AF
    FFF7FFFFFF7FFFFFA8888871199978AFFFF8FFFFFF8FFFFFAFFFFF71999978AA
    AAAAAAAAAAAAAAAAAFFFFF71999178A0AAAAAAAAAAAAAA00AFFFFF71991078AA
    AAAAAAAAAAAAAAAAA8888871110078888888FFFFFFFFFFFFFFFFFF7700000777
    7787FFFFF7FFFFFF7FFFFF77000000000787FFFFF7FFFFFF7FFFFF7700000000
    078787777777777777777877000000000787FFFFF7FFFFFF7FFFFF7700000000
    0787FFFFF7FFFFFF7FFFFF77000000000787FFFFF8FFFFFF8FFFFF7700000000
    0787777777777777777777770000000007870777777777777777007700000000
    0787777777777777777777770000000007888888888888888888888700000000
    0777777777777777777777700000800003FF000003BF0000033F000002030000
    000100000000000000000000020000000338000003BC0000000C0000000C0000
    000C0000000C0000000800000000000000000000000000000001000000030000
    000F8000000FF800000FF800000FF800000FF800000FF800000FF800000FF800
    000FF800000FF800000FF800001F280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000010000000
    000000011000AAAAAAAAA0119110AFF7FF7FF1199991AFF7FF7FF8119199A777
    77777A011019AFF7FF7FFA001009AFF7FF7FFA877019AAAAAAAAAAFF7199AAAA
    AA0A0AFF7191AAAAAAAAAA7771100008FF7FF7FF70000007FF7FF7FF70000007
    77777777700000077777707070000007777777777000FFF70000FFE700000041
    0000000000000000000000240000003600000004000000000000000000000001
    0000E0070000E0070000E0070000E0070000E0070000}
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    664
    441)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 404
    Top = 282
    Width = 29
    Height = 13
    Caption = 'errors.'
  end
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 664
    Height = 404
    ActivePage = tsDatabases
    Align = alClient
    TabOrder = 0
    OnChanging = PagesChanging
    object tsDatabases: TTabSheet
      Caption = 'Step 1: Databases'
      DesignSize = (
        656
        376)
      object lSourceDatabase: TLabel
        Left = 10
        Top = 27
        Width = 52
        Height = 13
        Caption = 'Source DB'
      end
      object lSUserName: TLabel
        Left = 10
        Top = 59
        Width = 53
        Height = 13
        Caption = 'User Name'
      end
      object lSPassword: TLabel
        Left = 203
        Top = 57
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object lSDialect: TLabel
        Left = 10
        Top = 89
        Width = 33
        Height = 13
        Caption = 'Dialect'
      end
      object Bevel1: TBevel
        Left = 2
        Top = 114
        Width = 660
        Height = 5
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object lDestDatabase: TLabel
        Left = 10
        Top = 132
        Width = 71
        Height = 13
        Caption = 'Destination DB'
      end
      object lDUserName: TLabel
        Left = 10
        Top = 164
        Width = 53
        Height = 13
        Caption = 'User Name'
      end
      object lDPassword: TLabel
        Left = 203
        Top = 161
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object lDDialect: TLabel
        Left = 10
        Top = 194
        Width = 33
        Height = 13
        Caption = 'Dialect'
      end
      object Bevel2: TBevel
        Left = 244
        Top = 9
        Width = 419
        Height = 5
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object llSourceDatabaseProperties: TLabel
        Left = 2
        Top = 2
        Width = 133
        Height = 13
        Caption = 'Source Database Properties'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object llDestDatabaseProperties: TLabel
        Left = 2
        Top = 107
        Width = 152
        Height = 13
        Caption = 'Destination Database Properties'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object lsRole: TLabel
        Left = 203
        Top = 89
        Width = 43
        Height = 13
        Caption = 'SQLRole'
      end
      object lsCharacterSet: TLabel
        Left = 367
        Top = 89
        Width = 44
        Height = 13
        Caption = 'Char. Set'
      end
      object Label5: TLabel
        Left = 203
        Top = 191
        Width = 43
        Height = 13
        Caption = 'SQLRole'
      end
      object Label6: TLabel
        Left = 367
        Top = 194
        Width = 44
        Height = 13
        Caption = 'Char. Set'
      end
      object lBoolTrue: TLabel
        Left = 138
        Top = 92
        Width = 42
        Height = 13
        Caption = 'TRUE to'
      end
      object lBoolFalse: TLabel
        Left = 226
        Top = 92
        Width = 45
        Height = 13
        Caption = 'FALSE to'
      end
      object lSelectOpt: TLabel
        Left = 315
        Top = 92
        Width = 64
        Height = 13
        Caption = 'Select Option'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblBoolTrue: TLabel
        Left = 143
        Top = 89
        Width = 3
        Height = 13
      end
      object eSRole: TEdit
        Left = 255
        Top = 85
        Width = 100
        Height = 21
        TabOrder = 5
      end
      object PropPage: TPageControl
        Left = 0
        Top = 219
        Width = 664
        Height = 169
        ActivePage = tsPumpProp
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 2
        object tsPumpProp: TTabSheet
          Caption = 'Pump Properties'
          object lLoop: TLabel
            Left = 259
            Top = 62
            Width = 230
            Height = 13
            Caption = 'This mode require exclusive access to database.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 178
            Top = 105
            Width = 35
            Height = 13
            Caption = 'error(s).'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 409
            Top = 6
            Width = 38
            Height = 13
            Caption = 'records.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lCommitEvery: TLabel
            Left = 259
            Top = 26
            Width = 279
            Height = 13
            Caption = 'Unchecked or 0 means to pump all data in one transaction.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object cbLoop: TCheckBox
            Left = 240
            Top = 43
            Width = 281
            Height = 17
            Caption = 'Switch Off all Ref. Constraints which have a loop'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 4
          end
          object cbDisableTriggers: TCheckBox
            Left = 10
            Top = 5
            Width = 97
            Height = 17
            Caption = 'Disable Triggers'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 0
          end
          object cbEmpty: TCheckBox
            Left = 10
            Top = 43
            Width = 211
            Height = 17
            Caption = 'Empty destination tables before pump'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 1
          end
          object cbUpdateGenerators: TCheckBox
            Left = 10
            Top = 75
            Width = 199
            Height = 17
            Caption = 'Update Generators'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 2
          end
          object cbStopErr: TCheckBox
            Left = 10
            Top = 105
            Width = 68
            Height = 17
            Caption = 'Stop after'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object cbCommitEvery: TCheckBox
            Left = 240
            Top = 5
            Width = 81
            Height = 17
            Caption = 'Commit every'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 5
          end
        end
        object tsStringPage: TTabSheet
          Caption = 'String Fields Properties'
          ImageIndex = 2
          object cbTruncString: TCheckBox
            Left = 10
            Top = 5
            Width = 343
            Height = 17
            Caption = 
              'Truncate source string fields if they are bigger than destinatio' +
              'n fields'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object cbRemSpace: TCheckBox
            Left = 10
            Top = 43
            Width = 213
            Height = 17
            Caption = 'Remove spaces from source string fields:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object cbRemSpaceOpt: TComboBox
            Left = 225
            Top = 41
            Width = 100
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 2
            Items.Strings = (
              'Right Only '
              'Left Only'
              'Left and Right')
          end
        end
        object tsBuildPage: TTabSheet
          Caption = 'Build Relations Properties'
          ImageIndex = 1
          object cbCase: TCheckBox
            Left = 10
            Top = 5
            Width = 227
            Height = 17
            Caption = 'Case-insensitive fields/tables comparison'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object cbSpace: TCheckBox
            Left = 10
            Top = 43
            Width = 371
            Height = 17
            Caption = 
              'Remove non-sql symbols (space,/,# etc.) on fields/tables compari' +
              'son'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object cbAlias: TComboBox
        Left = 92
        Top = 24
        Width = 466
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
      end
      object eSUserName: TEdit
        Left = 92
        Top = 55
        Width = 100
        Height = 21
        TabOrder = 3
        Text = 'SYSDBA'
      end
      object eSPassword: TEdit
        Left = 255
        Top = 55
        Width = 100
        Height = 21
        PasswordChar = '*'
        TabOrder = 4
        Text = 'masterkey'
      end
      object btnSTest: TButton
        Left = 563
        Top = 22
        Width = 90
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Test Connection'
        TabOrder = 12
        OnClick = btnSTestClick
      end
      object eDUserName: TEdit
        Left = 92
        Top = 160
        Width = 100
        Height = 21
        TabOrder = 16
        Text = 'SYSDBA'
      end
      object eDPassword: TEdit
        Left = 255
        Top = 160
        Width = 100
        Height = 21
        PasswordChar = '*'
        TabOrder = 18
        Text = 'masterkey'
      end
      object btnDTest: TButton
        Left = 565
        Top = 127
        Width = 90
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Test Connection'
        TabOrder = 14
        OnClick = btnDTestClick
      end
      object cbSCharSet: TComboBox
        Left = 418
        Top = 85
        Width = 100
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 6
        Items.Strings = (
          'None'
          'OCTETS'
          'ASCII'
          'UNICODE_FSS'
          'SJIS_0208'
          'EUCJ_0208'
          'DOS437'
          'DOS850'
          'DOS865'
          'ISO8859_1'
          'DOS852'
          'DOS857'
          'DOS860'
          'DOS861'
          'DOS863'
          'CYRL'
          'WIN1250'
          'WIN1251'
          'WIN1252'
          'WIN1253'
          'WIN1254'
          'NEXT'
          'KSC_5601'
          'BIG_5'
          'GB_2312'
          'DOS737'
          'DOS775'
          'DOS858'
          'DOS862'
          'DOS864'
          'DOS866'
          'DOS869'
          'WIN1255'
          'WIN1256'
          'WIN1257'
          'ISO8859_2'
          'ISO8859_3'
          'ISO8859_4'
          'ISO8859_5'
          'ISO8859_6'
          'ISO8859_7'
          'ISO8859_8'
          'ISO8859_9'
          'ISO8859_13'
          'KOI8-R'
          'KOI8-U')
      end
      object eDRole: TEdit
        Left = 255
        Top = 190
        Width = 100
        Height = 21
        TabOrder = 15
      end
      object cbDCharSet: TComboBox
        Left = 418
        Top = 190
        Width = 100
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 17
        Items.Strings = (
          'None'
          'OCTETS'
          'ASCII'
          'UNICODE_FSS'
          'SJIS_0208'
          'EUCJ_0208'
          'DOS437'
          'DOS850'
          'DOS865'
          'ISO8859_1'
          'DOS852'
          'DOS857'
          'DOS860'
          'DOS861'
          'DOS863'
          'CYRL'
          'WIN1250'
          'WIN1251'
          'WIN1252'
          'WIN1253'
          'WIN1254'
          'NEXT'
          'KSC_5601'
          'BIG_5'
          'GB_2312'
          'DOS737'
          'DOS775'
          'DOS858'
          'DOS862'
          'DOS864'
          'DOS866'
          'DOS869'
          'WIN1255'
          'WIN1256'
          'WIN1257'
          'ISO8859_2'
          'ISO8859_3'
          'ISO8859_4'
          'ISO8859_5'
          'ISO8859_6'
          'ISO8859_7'
          'ISO8859_8'
          'ISO8859_9'
          'ISO8859_13'
          'KOI8-R'
          'KOI8-U')
      end
      object cbBde: TComboBox
        Left = 142
        Top = 0
        Width = 164
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cbBdeChange
        Items.Strings = (
          'Interbase/Firebird Source'
          'BDE Source'
          'ADO Source')
      end
      object cbBool: TCheckBox
        Left = 11
        Top = 90
        Width = 127
        Height = 19
        Caption = 'Convert boolean fields'
        TabOrder = 7
      end
      object eBoolTrue: TEdit
        Left = 187
        Top = 88
        Width = 21
        Height = 21
        TabOrder = 8
        Text = 'eBoolTrue'
      end
      object eBoolFalse: TEdit
        Left = 279
        Top = 88
        Width = 21
        Height = 21
        TabOrder = 9
        Text = 'eBoolTrue'
      end
      object btnGenSql: TButton
        Left = 565
        Top = 53
        Width = 90
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Build SQL Script'
        TabOrder = 13
        OnClick = btnGenSqlClick
      end
      object cbSrcSelect: TComboBox
        Left = 383
        Top = 87
        Width = 162
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 10
        Items.Strings = (
          'select * from table'
          'select * from "A Table"'
          'select * from [A Table]')
      end
      object cbSrcQuoteFields: TCheckBox
        Left = 548
        Top = 90
        Width = 112
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Quote Field Names'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
    end
    object tsOrder: TTabSheet
      Caption = 'Step 2: Order'
      ImageIndex = 1
      object pRight: TPanel
        Left = 527
        Top = 0
        Width = 129
        Height = 376
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          129
          376)
        object lSteps: TLabel
          Left = 0
          Top = 0
          Width = 129
          Height = 13
          Align = alTop
          Caption = ' Steps:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object lStep1: TLabel
          Left = 10
          Top = 25
          Width = 9
          Height = 13
          Caption = '1)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lStep2: TLabel
          Left = 10
          Top = 57
          Width = 9
          Height = 13
          Caption = '2)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lStep3: TLabel
          Left = 10
          Top = 93
          Width = 9
          Height = 13
          Caption = '3)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lStep3Desck: TLabel
          Left = 31
          Top = 93
          Width = 90
          Height = 245
          AutoSize = False
          Caption = 
            'Use drag&&drop (you can drag source tables and and source fields' +
            ' to destination tables and destination fields) and popup menus t' +
            'o set all necessarily relations. You can use same operations for' +
            ' generators too. After that go to page '#39'Pump'#39'.'
          WordWrap = True
        end
        object btnGetDfn: TButton
          Left = 27
          Top = 19
          Width = 96
          Height = 25
          Caption = 'Get Definitions'
          TabOrder = 0
          OnClick = btnGetDfnClick
        end
        object btnBuildRelations: TButton
          Left = 27
          Top = 52
          Width = 96
          Height = 25
          Caption = 'Build Relations'
          TabOrder = 1
          OnClick = btnBuildRelationsClick
        end
        object btnUpdateDef: TButton
          Left = 27
          Top = 355
          Width = 96
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Update Definitions'
          TabOrder = 2
          OnClick = btnUpdateDefClick
        end
      end
      object PageObj: TPageControl
        Left = 0
        Top = 0
        Width = 527
        Height = 376
        ActivePage = tsTables
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Images = ilImages
        ParentFont = False
        TabOrder = 1
        TabPosition = tpBottom
        object tsTables: TTabSheet
          Caption = 'Tables'
          object Splitter2: TSplitter
            Left = 280
            Top = 0
            Height = 349
            Align = alRight
            Beveled = True
          end
          object pSource: TPanel
            Left = 0
            Top = 0
            Width = 280
            Height = 349
            Align = alClient
            BevelOuter = bvNone
            Caption = 'pSource'
            TabOrder = 0
            object pDBDestT: TPanel
              Left = 0
              Top = 0
              Width = 280
              Height = 15
              Align = alTop
              Alignment = taRightJustify
              BevelOuter = bvLowered
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label12: TLabel
                Left = 1
                Top = 1
                Width = 78
                Height = 13
                Align = alLeft
                AutoSize = False
                Caption = 'Destination DB:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsUnderline]
                ParentFont = False
              end
            end
          end
          object Panel3: TPanel
            Left = 283
            Top = 0
            Width = 236
            Height = 349
            Align = alRight
            BevelOuter = bvNone
            Caption = 'pDest'
            TabOrder = 1
            object pDBSourceT: TPanel
              Left = 0
              Top = 0
              Width = 236
              Height = 15
              Align = alTop
              Alignment = taRightJustify
              BevelOuter = bvLowered
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label9: TLabel
                Left = 1
                Top = 1
                Width = 59
                Height = 13
                Align = alLeft
                AutoSize = False
                Caption = 'Source DB:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsUnderline]
                ParentFont = False
              end
            end
          end
        end
        object tsGenerators: TTabSheet
          Caption = 'Generators'
          ImageIndex = 16
          object Splitter1: TSplitter
            Left = 248
            Top = 0
            Height = 359
            Align = alRight
            Beveled = True
          end
          object Panel4: TPanel
            Left = 251
            Top = 0
            Width = 236
            Height = 359
            Align = alRight
            BevelOuter = bvNone
            Caption = 'pDest'
            TabOrder = 0
            object pDBSource: TPanel
              Left = 0
              Top = 0
              Width = 236
              Height = 15
              Align = alTop
              Alignment = taRightJustify
              BevelOuter = bvLowered
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label10: TLabel
                Left = 1
                Top = 1
                Width = 59
                Height = 13
                Align = alLeft
                AutoSize = False
                Caption = 'Source DB:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsUnderline]
                ParentFont = False
              end
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 248
            Height = 359
            Align = alClient
            BevelOuter = bvNone
            Caption = 'pSource'
            TabOrder = 1
            object pDBDEst: TPanel
              Left = 0
              Top = 0
              Width = 248
              Height = 15
              Align = alTop
              Alignment = taRightJustify
              BevelOuter = bvLowered
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label11: TLabel
                Left = 1
                Top = 1
                Width = 78
                Height = 13
                Align = alLeft
                AutoSize = False
                Caption = 'Destination DB:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsUnderline]
                ParentFont = False
              end
            end
          end
        end
      end
    end
    object tsPump: TTabSheet
      Caption = 'Step 3: Pump'
      ImageIndex = 2
      object pStepThreeBottom: TPanel
        Left = 0
        Top = 349
        Width = 656
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        DesignSize = (
          656
          27)
        object Label4: TLabel
          Left = 2
          Top = 8
          Width = 73
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Save report to :'
        end
      end
      object Panel1: TPanel
        Left = 568
        Top = 0
        Width = 88
        Height = 349
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object Label8: TLabel
          Left = 10
          Top = 36
          Width = 63
          Height = 52
          Alignment = taCenter
          Caption = 'Always have a copy of destination database!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object btnStartPump: TButton
          Left = 8
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Start'
          TabOrder = 0
          OnClick = btnStartPumpClick
        end
      end
      object memRep: TMemo
        Left = 0
        Top = 0
        Width = 568
        Height = 349
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
  end
  object pBottom: TPanel
    Left = 0
    Top = 404
    Width = 664
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      664
      37)
    object btnClose: TButton
      Left = 588
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 6
      OnClick = btnCloseClick
    end
    object btnSaveProfile: TButton
      Left = 6
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Save Profile...'
      TabOrder = 0
      OnClick = btnSaveProfileClick
    end
    object btnLoadProfile: TButton
      Left = 88
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Load Profile...'
      TabOrder = 1
      OnClick = btnLoadProfileClick
    end
    object btnNewProfile: TButton
      Left = 170
      Top = 7
      Width = 75
      Height = 25
      Caption = 'New Profile'
      TabOrder = 2
      OnClick = btnNewProfileClick
    end
    object btnAbout: TButton
      Left = 494
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'About...'
      TabOrder = 5
      OnClick = btnAboutClick
    end
    object btnHelp: TButton
      Left = 412
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Help?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnHelpClick
    end
    object btnGet: TBitBtn
      Left = 330
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Get v %s!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = btnGetClick
    end
  end
  object stNews: TStaticText
    Left = 301
    Top = 3
    Width = 72
    Height = 17
    Cursor = crHandPoint
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'CC News here'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    TabOrder = 2
    Visible = False
    OnClick = btnGetClick
  end
  object qryDep: TIBQuery
    Database = ibpDM.DBDest
    Transaction = ibpDM.trDest
    BufferChunks = 1000
    CachedUpdates = True
    SQL.Strings = (
      'select F.RDB$RELATION_NAME AS DEP, '
      '          F.RDB$CONSTRAINT_NAME, '
      '          T.RDB$RELATION_NAME AS SOURCE, '
      '          T.RDB$CONSTRAINT_NAME '
      
        'from RDB$REF_CONSTRAINTS C, RDB$RELATION_CONSTRAINTS F, RDB$RELA' +
        'TION_CONSTRAINTS T '
      'where C.RDB$CONSTRAINT_NAME = F.RDB$CONSTRAINT_NAME and '
      '      T.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ '
      'order by F.RDB$RELATION_NAME, T.RDB$RELATION_NAME ')
    UpdateObject = updDep
    Left = 591
    Top = 273
  end
  object updDep: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  RDB$CONSTRAINT_NAME,'
      '  RDB$CONST_NAME_UQ,'
      '  RDB$MATCH_OPTION,'
      '  RDB$UPDATE_RULE,'
      '  RDB$DELETE_RULE'
      'from RDB$REF_CONSTRAINTS '
      'where'
      '  RDB$CONSTRAINT_NAME = :RDB$CONSTRAINT_NAME')
    ModifySQL.Strings = (
      '/*just an empty string*/')
    DeleteSQL.Strings = (
      '')
    Left = 591
    Top = 321
  end
  object pmDest: TPopupMenu
    OnPopup = pmDestPopup
    Left = 446
    Top = 65528
    object SelectAll1: TMenuItem
      Caption = 'Select All'
      OnClick = SelectAll1Click
    end
    object UnselectAll1: TMenuItem
      Tag = 1
      Caption = 'Unselect All'
      OnClick = SelectAll1Click
    end
    object Invert1: TMenuItem
      Tag = 2
      Caption = 'Invert Selection'
      OnClick = SelectAll1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ExpandAll1: TMenuItem
      Caption = 'Expand All'
      OnClick = ExpandAll1Click
    end
    object CollapseAll1: TMenuItem
      Caption = 'Collapse All'
      OnClick = CollapseAll1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object GetCount1: TMenuItem
      Caption = 'Get Tables Count'
      OnClick = GetCount1Click
    end
    object GetNodeChildsCount1: TMenuItem
      Caption = 'Get Node Childs Count'
      OnClick = GetNodeChildsCount1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ClearLinkForSelectedTable1: TMenuItem
      Caption = 'Clear Relations For Selected Table'
      OnClick = ClearLinkForSelectedTable1Click
    end
    object DeleterRelation1: TMenuItem
      Caption = 'Delete Relation'
      OnClick = DeleterRelation1Click
    end
    object AddConstant1: TMenuItem
      Caption = 'Add Constant Expression'
      OnClick = AddConstant1Click
    end
    object EditConstantExpressrion1: TMenuItem
      Caption = 'Edit Constant Expression'
      OnClick = EditConstantExpressrion1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object NewSQL1: TMenuItem
      Caption = 'New SQL'
      OnClick = NewSQL1Click
    end
    object ViewEditSQL1: TMenuItem
      Caption = 'View / Edit SQL'
      OnClick = ViewEditSQL1Click
    end
    object DeleteSQL1: TMenuItem
      Caption = 'Delete SQL'
      OnClick = DeleteSQL1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object CustomSQLWizard1: TMenuItem
      Caption = 'Custom SQL Wizard'
      OnClick = CustomSQLWizard1Click
    end
  end
  object qryDest: TIBSQL
    Database = ibpDM.DBDest
    ParamCheck = True
    Transaction = Trans
    Left = 547
    Top = 277
  end
  object qrySource: TIBSQL
    Database = ibpDM.DBSource
    ParamCheck = True
    SQL.Strings = (
      '')
    Transaction = ibpDM.trSource
    Left = 547
    Top = 229
  end
  object Trans: TIBTransaction
    Active = False
    DefaultDatabase = ibpDM.DBDest
    AutoStopAction = saNone
    Left = 548
    Top = 324
  end
  object ilImages: TImageList
    Left = 348
    Top = 65528
    Bitmap = {
      494C010111001300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000FF000000FF000000FF000000FF000000FF0000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000FF000000000000000000000000000000FF0000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      80008080800000FF00000000000000FF000000FF000000FF0000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF0000FF
      FF008080800000FF000000000000000000000000000000FF0000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF00000000000000
      00008080800000FF000000FF000000FF00000000000080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000000
      00008080800000FF000000000000000000000000000080808000808000008080
      0000808000008080000080800000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000000
      00008080800000FF000000FF000000FF000000FF000080808000808000000000
      0000000000000000000080800000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF00000000000000
      0000808080008080800080808000808080008080800080808000808000008080
      0000808000000000000080800000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000000
      000000FFFF0000FFFF0080808000000000000000000080808000808000000000
      0000000000000000000080800000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0080808000000000000000000080808000808000008080
      0000808000000000000080800000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808000000000
      0000000000000000000080800000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808000008080
      0000808000008080000080800000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000008000000080000000800000008000000080000000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000080
      8000008080000000000080808000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000080
      8000008080000000000080808000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000080000000800000008000
      0000800000008000000080000000000000000000000080808000000000000000
      0000000000000000000000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      000000000000FF000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000080808000000000000000
      0000000000000000000000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000000000008080800000FFFF0000FFFF0000FFFF000080
      8000008080000080800000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000000000008080800000FFFF0000FFFF0000FFFF000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800080808000808080008080800000FFFF0000800000808080000000
      0000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800080808000808080008080800000FFFF0000800000808080000000
      00000080800000808000000000000000000000000000000000008080800000FF
      FF0000FFFF0000FFFF0000808000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF0000000000000000000000000000000000000000008080800000FF
      FF0000FFFF0000FFFF0000808000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF000000000000000000000000000000000080808000C0C0C00000FF
      FF0000FFFF000080800000808000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000808080008080800080808000808080000000000000FFFF000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000080808000C0C0C00000FF
      FF0000FFFF000080800000808000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000808080008080800080808000808080000000000000FFFF000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000008080800000FFFF0000FF
      FF000080800000FFFF0000808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF00808080000000000000000000000000008080800000FFFF0000FF
      FF000080800000FFFF0000808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF00808080000000000000000000000000008080800000FFFF000080
      000000FFFF000000000000808000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      800080808000000000000000000000000000000000008080800000FFFF000080
      000000FFFF000000000000808000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      800080808000000000000000000000000000000000008080800080808000C0C0
      C00000FFFF00C0C0C00000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080808000C0C0
      C00000FFFF00C0C0C00000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C00000FF
      FF00C0C0C00000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C00000FF
      FF00C0C0C00000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C00000FFFF00C0C0C00000FFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000000000000000000000000000000000000000000080808000C0C0
      C00000FFFF00C0C0C00000FFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000080
      8000008080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000000000000000000008080800000FFFF0000FFFF0000FFFF000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000008080800000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      00008080800080808000808080008080800000FFFF0000800000808080000000
      0000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000000000000000000000000000FF00
      0000000000000000000000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF0000000000000000000000000000000000000000008080800000FF
      FF0000FFFF0000FFFF0000808000000000008080800000000000000000000000
      00000000000000000000000000000000000000000000000000008080800000FF
      FF0000FFFF0000FFFF0000808000000000008080800000000000000000000000
      00000000000000000000000000000000000000000000000000008080800000FF
      FF0000FFFF0000FFFF0000808000000000008080800000000000FF0000000000
      0000FF0000000000000000000000000000000000000080808000000000000000
      0000808080008080800080808000808080000000000000FFFF000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000080808000C0C0C00000FF
      FF0000FFFF000080800000808000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C00000FF
      FF0000FFFF000080800000808000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C00000FF
      FF0000FFFF000080800000808000008080000000000000000000000000000000
      000000000000FF00000000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF00808080000000000000000000000000008080800000FFFF0000FF
      FF000080800000FFFF0000808000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000FFFF0000FF
      FF000080800000FFFF0000808000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000FFFF0000FF
      FF000080800000FFFF000080800000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      800080808000000000000000000000000000000000008080800000FFFF000080
      000000FFFF000000000000808000008080000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000FFFF000080
      000000FFFF000000000000808000008080000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000FFFF000080
      000000FFFF000000000000808000008080000000000000000000FF0000000000
      0000FF0000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080808000C0C0
      C00000FFFF00C0C0C00000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080808000C0C0
      C00000FFFF00C0C0C00000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080808000C0C0
      C00000FFFF00C0C0C00000FFFF00000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C00000FF
      FF00C0C0C00000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C00000FF
      FF00C0C0C00000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C00000FF
      FF00C0C0C00000FFFF0000FFFF0000FFFF00000000000000000000000000FF00
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000000000000000000000000000000000000000000080808000C0C0
      C00000FFFF00C0C0C00000FFFF00808080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C00000FFFF00C0C0C00000FFFF00808080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C00000FFFF00C0C0C00000FFFF00808080000000000000000000FF0000000000
      0000FF0000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000000000008000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000080
      800000808000000000008080800000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF000080
      8000008080000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000080000000000000000000000080808000000000000000
      0000000000000000000000000000808080000000000000FFFF000080800000FF
      FF0000808000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000080808000000000000000
      0000000000000000000000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000000000008000
      0000808080000000000000000000000000000000000080808000000000000000
      00000000000000000000000000008080800000FFFF0000FFFF0000FFFF000080
      800000808000008080000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000080808000000000000000
      00000000000000000000000000008080800000FFFF0000FFFF0000FFFF000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000080000000000000000000000080808000000000000000
      0000000000008080800000000000808080000000000000FFFF000080800000FF
      FF0000808000000000000000000000000000000000000000000000FFFF000000
      0000000000008000000080000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000080808000000000000000
      0000000000008080800000000000808080000000000000FFFF000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000080808000000000000000
      00008080800080808000808080008080800000FFFF0000800000808080000000
      000000808000008080000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000080808000000000000000
      00008080800080808000808080008080800000FFFF0000800000808080000000
      0000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000800000008080
      8000800000008080800080000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF00000000000000000000000000000000000000000000FFFF000000
      0000000000008000000080000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000808080008080800080808000808080000000000000FFFF000000000000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000080808000000000000000
      0000808080008080800080808000808080000000000000FFFF000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF00808080000000000000000000000000000000000000FFFF000000
      0000FF000000FFFF0000FF000000FFFF0000FF000000FFFF0000FF000000FFFF
      00000000000000FFFF0000000000000000000000000080808000000000000000
      000000000000808080000000000080808000808080000000000000FFFF000000
      000000FFFF008080800000000000000000000000000080000000000000008000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      800080808000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080000000000000000000000000000000000080808000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000000000008000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000080808000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      00008000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000080808000800000008080
      8000800000008080800080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000080000000000000000000000000000000000000000000000080000000
      800000008000000080000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      800000000000000080000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FFFF0000000000000000000000000000FF000000FF00
      0000FFFF00000000000000000000000000000000000000008000000080000000
      80000000000000000000FF000000FF000000FFFF000000000000000000000000
      000000000000000080000000000000000000000000000000000000FFFF000000
      0000000000008000000080000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000008000000080000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000FF000000FFFF0000FF000000FFFF0000FF000000FFFF0000FF000000FFFF
      00000000000000FFFF0000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000000000000000000000000000000000FFFF
      0000FF000000FFFF0000FF000000FFFF0000FF000000FFFF0000FF000000FFFF
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000000000FF00
      0000FFFF0000FF000000FFFF0000FF000000FFFF0000FF000000FFFF0000FF00
      0000FFFF00000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FFFF0000FFFF0000FF000000FFFF0000FFFF0000FF000000FFFF0000FF00
      0000FFFF0000000000000000000000000000000000000000000000000000FF00
      0000FFFF0000FFFF0000FF000000FFFF0000FFFF0000FF000000FFFF0000FF00
      0000FFFF000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000F01F000000000000
      F01F000000000000F01F000000000000001F000000000000001F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      018000000000000001800000000000000180000000000000FF80000000000000
      FF80000000000000FFFF000000000000FFFFFFFFFFFFFFFFFF81FF83FF81FF83
      F83D8001F83D8001FB81BE81FB81BE81FBFFA001FBFFA001FBFFAA81FBFFAA81
      E0FFA001E0FFA001C07FAA51C07FAA51807FA0A1807FA0A1807FAA53807FAA53
      807FA007807FA007807FBFF7807FBFF7807FBFF7807FBFF7C0FF8007C0FF8007
      E1FF8007E1FF8007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83FF81FF81FF81
      8001F83DF83DF83DBE81FB81FB81FB81A001FBFFFBFFFBFFAA81FBFFFBFFFBFF
      A001E0FFE0FFE0EFAA51C07FC07FC057A0A1807F807F807BAA53807F807F806F
      A007807F807F8057BFF7807F807F807BBFF7807F807F806F8007C0FFC0FFC0D7
      8007E1FFE1FFE1FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF838001FF83FF81
      800180018001FDBDBE818001BE81E0A5A0018F71A001EDBDAA818971AA81EF81
      A0018F71A001EF81AA518971AA51EFFFA0A18F71A0A1FFFFAA538001AA5381FF
      A0078001A007BDFFBFF78001BFF7A5FFBFF78001BFF7BDFF8007C0FF800781FF
      8007E1FF800781FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE083F83F8001
      C003EEBBFBAF8001DBDBEAABC2838001DA5BEEBBDBAB8F71DBDBE083883B8971
      DA5BE083D83B8F71DBDBFF7FFFFF8971DA5BC003C0038F71DBDBDBDBDBDB8001
      C003DA5BDA5B8001C003DBDBDBDB8001C003C003C0038001C003C003C003C0FF
      FFFFC003C003E1FFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object qryDefsFields: TIBSQL
    Database = ibpDM.DBDest
    ParamCheck = True
    SQL.Strings = (
      'select *'
      'from rdb$relation_fields f'
      
        'left join rdb$fields fs on fs.rdb$field_name = f.rdb$field_sourc' +
        'e'
      'where f.rdb$relation_name = :tablename'
      'order by f.rdb$field_position')
    Transaction = ibpDM.trDest
    Left = 483
    Top = 173
  end
  object op: TOpenDialog
    DefaultExt = 'ibp'
    Filter = 'IB DataPump Profiles (*.ibp)|*.ibp'
    Title = 'Load Profile'
    Left = 524
    Top = 65528
  end
  object sd: TSaveDialog
    DefaultExt = 'ibp'
    Filter = 'IB DataPump Profiles (*.ibp)|*.ibp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Profile'
    Left = 560
    Top = 65528
  end
  object qryDestFK: TIBSQL
    Database = ibpDM.DBDest
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT r.RDB$FIELD_NAME, r.RDB$NULL_FLAG, f.RDB$FIELD_LENGTH, t.' +
        'RDB$TYPE_NAME'
      'FROM  RDB$RELATION_FIELDS r'
      '  LEFT JOIN RDB$FIELDS f on f.RDB$FIELD_NAME=r.RDB$FIELD_SOURCE'
      
        '  LEFT JOIN RDB$TYPES t on t.RDB$TYPE=f.RDB$FIELD_TYPE and RDB$F' +
        'IELD_NAME='#39'RDB$FIELD_TYPE'#39
      'WHERE r.RDB$RELATION_NAME = :TABLENAME'
      'ORDER BY 1')
    Transaction = ibpDM.trDest
    Left = 483
    Top = 279
  end
  object DestInfo: TIBDatabaseInfo
    Database = ibpDM.DBDest
    Left = 600
    Top = 65528
  end
  object qryDestComp: TIBSQL
    Database = ibpDM.DBDest
    ParamCheck = True
    SQL.Strings = (
      'select r.RDB$FIELD_NAME'
      'from RDB$RELATION_FIELDS r'
      
        '     join RDB$FIELDS f on f.RDB$FIELD_NAME=r.RDB$FIELD_SOURCE an' +
        'd f.RDB$COMPUTED_SOURCE is NOT NULL'
      'where r.RDB$RELATION_NAME = :PAR')
    Transaction = ibpDM.trDest
    Left = 401
    Top = 229
  end
  object bdeQuery: TQuery
    AutoCalcFields = False
    DatabaseName = 'bdeDb'
    ParamCheck = False
    UniDirectional = True
    Left = 325
    Top = 366
  end
  object gdbop: TOpenDialog
    DefaultExt = 'gdb'
    Filter = 
      'Interbase / Firebird (*.gdb)|*.gdb|Interbase 7.x (*.ib)|*.ib|All' +
      ' Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofNoValidate, ofEnableSizing]
    Title = 'Open Database'
    Left = 401
    Top = 65529
  end
  object bdeTable: TTable
    AutoCalcFields = False
    DatabaseName = 'bdeDb'
    ReadOnly = True
    Left = 272
    Top = 366
  end
  object SrcInfo: TIBDatabaseInfo
    Database = ibpDM.DBSource
    Left = 600
    Top = 40
  end
  object qryDefGens: TIBSQL
    Database = ibpDM.DBDest
    ParamCheck = True
    SQL.Strings = (
      'select rdb$generator_name'
      'from rdb$generators'
      'where ((rdb$system_flag = 0) or (rdb$system_flag is null))'
      'order by rdb$generator_name')
    Transaction = ibpDM.trDest
    Left = 483
    Top = 229
  end
  object qryFields: TIBQuery
    Database = ibpDM.DBSource
    Transaction = ibpDM.trSource
    AutoCalcFields = False
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select distinct C.RDB$RELATION_NAME AS NAME'
      'from RDB$RELATION_CONSTRAINTS C '
      'where not exists (select * from RDB$RELATION_CONSTRAINTS R '
      
        '                  where R.RDB$CONSTRAINT_TYPE = '#39'FOREIGN KEY'#39' an' +
        'd '
      
        '                        R.RDB$RELATION_NAME = C.RDB$RELATION_NAM' +
        'E) '
      'order by C.RDB$RELATION_NAME')
    Left = 483
    Top = 325
  end
  object adoTable: TADOTable
    AutoCalcFields = False
    Connection = ibpDM.adoDb
    CursorLocation = clUseServer
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Left = 387
    Top = 366
  end
  object adoQuery: TADOQuery
    AutoCalcFields = False
    Connection = ibpDM.adoDb
    CursorLocation = clUseServer
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <>
    Left = 446
    Top = 366
  end
  object qryIBDest: TIBQuery
    Database = ibpDM.DBDest
    Transaction = ibpDM.trDest
    AutoCalcFields = False
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select F.RDB$RELATION_NAME AS DEP, '
      '          F.RDB$CONSTRAINT_NAME, '
      '          T.RDB$RELATION_NAME AS SOURCE, '
      '          T.RDB$CONSTRAINT_NAME '
      
        'from RDB$REF_CONSTRAINTS C, RDB$RELATION_CONSTRAINTS F, RDB$RELA' +
        'TION_CONSTRAINTS T '
      'where C.RDB$CONSTRAINT_NAME = F.RDB$CONSTRAINT_NAME and '
      '      T.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ '
      'order by F.RDB$RELATION_NAME, T.RDB$RELATION_NAME ')
    Left = 199
    Top = 366
  end
  object OpenReportDialog: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'
    Title = 'Save Report To'
    Left = 484
    Top = 65528
  end
end
