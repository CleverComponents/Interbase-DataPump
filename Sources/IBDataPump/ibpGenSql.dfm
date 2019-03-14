object ibpGenSql: TibpGenSql
  Left = 393
  Top = 174
  BorderStyle = bsDialog
  Caption = 'Generate SQL Script'
  ClientHeight = 453
  ClientWidth = 632
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
  DesignSize = (
    632
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 123
    Width = 116
    Height = 13
    Caption = 'Duplicated Index Names'
    WordWrap = True
  end
  object lTGraphicField: TLabel
    Left = 242
    Top = 403
    Width = 59
    Height = 13
    Caption = 'GraphicField'
  end
  object lTTimeField: TLabel
    Left = 242
    Top = 378
    Width = 45
    Height = 13
    Caption = 'TimeField'
  end
  object lSaveTo: TLabel
    Left = 8
    Top = 17
    Width = 81
    Height = 13
    Caption = 'Save script to file'
  end
  object lDialect: TLabel
    Left = 8
    Top = 70
    Width = 33
    Height = 13
    Caption = 'Dialect'
  end
  object lCase: TLabel
    Left = 8
    Top = 150
    Width = 120
    Height = 13
    Caption = 'Case of field/table names'
  end
  object lSpaces: TLabel
    Left = 8
    Top = 176
    Width = 121
    Height = 13
    Caption = 'Convert field/table names'
    WordWrap = True
  end
  object lOptions: TLabel
    Left = 4
    Top = 197
    Width = 291
    Height = 13
    Caption = 'Convert Field Options (from given field class to SQL data type)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object bvlOptions: TBevel
    Left = 297
    Top = 204
    Width = 328
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object lTStringField: TLabel
    Left = 8
    Top = 219
    Width = 49
    Height = 13
    Caption = 'StringField'
  end
  object lTIntegerField: TLabel
    Left = 8
    Top = 272
    Width = 55
    Height = 13
    Caption = 'IntegerField'
  end
  object lTFloatField: TLabel
    Left = 8
    Top = 299
    Width = 45
    Height = 13
    Caption = 'FloatField'
  end
  object lTBCDField: TLabel
    Left = 8
    Top = 325
    Width = 44
    Height = 13
    Caption = 'BCDField'
  end
  object lTLargeintField: TLabel
    Left = 8
    Top = 351
    Width = 60
    Height = 13
    Caption = 'LargeintField'
  end
  object lTSmallintField: TLabel
    Left = 8
    Top = 378
    Width = 58
    Height = 13
    Caption = 'SmallintField'
  end
  object lTAutoIncField: TLabel
    Left = 242
    Top = 298
    Width = 59
    Height = 13
    Caption = 'AutoIncField'
  end
  object lTCurrencyField: TLabel
    Left = 242
    Top = 272
    Width = 64
    Height = 13
    Caption = 'CurrencyField'
  end
  object lTBooleanField: TLabel
    Left = 242
    Top = 221
    Width = 61
    Height = 13
    Caption = 'BooleanField'
  end
  object lTDateTimeField: TLabel
    Left = 242
    Top = 325
    Width = 68
    Height = 13
    Caption = 'DateTimeField'
  end
  object lTDateField: TLabel
    Left = 242
    Top = 352
    Width = 45
    Height = 13
    Caption = 'DateField'
  end
  object lLength: TLabel
    Left = 23
    Top = 235
    Width = 46
    Height = 13
    Caption = 'if length <'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lThen: TLabel
    Left = 119
    Top = 221
    Width = 21
    Height = 13
    Caption = 'then'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lElse: TLabel
    Left = 121
    Top = 247
    Width = 19
    Height = 13
    Caption = 'else'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lMainOptions: TLabel
    Left = 4
    Top = 0
    Width = 62
    Height = 13
    Caption = 'Main Options'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object bvlMainOptions: TBevel
    Left = 68
    Top = 7
    Width = 558
    Height = 9
    Shape = bsTopLine
  end
  object lDefCharSet: TLabel
    Left = 8
    Top = 97
    Width = 81
    Height = 13
    Caption = 'Default Char. Set'
  end
  object lDatabase: TLabel
    Left = 8
    Top = 44
    Width = 91
    Height = 13
    Caption = 'Database file name'
  end
  object lBooleanOption: TLabel
    Left = 430
    Top = 221
    Width = 60
    Height = 13
    Caption = 'select option'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lTBinaryField: TLabel
    Left = 8
    Top = 404
    Width = 51
    Height = 13
    Caption = 'BinaryField'
  end
  object lTBlobField: TLabel
    Left = 450
    Top = 298
    Width = 43
    Height = 13
    Caption = 'BlobField'
  end
  object lTMemoField: TLabel
    Left = 450
    Top = 272
    Width = 51
    Height = 13
    Caption = 'MemoField'
  end
  object cbDupInd: TComboBox
    Left = 140
    Top = 119
    Width = 200
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    Items.Strings = (
      'add number INDEX3'
      'add table name TABLE_INDEX'
      'table+index fields TABLE_ID_NAME')
  end
  object cbTGraphicField: TComboBox
    Left = 315
    Top = 399
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 26
    Text = 'BLOB'
    Items.Strings = (
      'BLOB')
  end
  object cbTTimeField: TComboBox
    Left = 315
    Top = 373
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 25
    Text = 'TIME'
    Items.Strings = (
      'TIME'
      'DATE')
  end
  object cbCase: TComboBox
    Left = 140
    Top = 146
    Width = 200
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'convert to upper case '
      'convert to lower case'
      'leave it as it is')
  end
  object btnStart: TButton
    Left = 472
    Top = 425
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Start!'
    TabOrder = 30
    OnClick = btnStartClick
  end
  object btnCancel: TButton
    Left = 553
    Top = 425
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 32
  end
  object cbTAutoIncField: TComboBox
    Left = 315
    Top = 295
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 21
    Text = 'INTEGER'
    Items.Strings = (
      'INTEGER')
  end
  object cbTCurrencyField: TComboBox
    Left = 315
    Top = 269
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 20
    Text = 'NUMERIC(15,2)'
    Items.Strings = (
      'NUMERIC(15,4)'
      'NUMERIC(15,2)')
  end
  object cbBool: TComboBox
    Left = 496
    Top = 217
    Width = 131
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 18
    OnChange = cbBoolChange
    Items.Strings = (
      'Create Domain'
      'Use Plain Datatype')
  end
  object cbTDateTimeField: TComboBox
    Left = 315
    Top = 321
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 22
    Text = 'TIMESTAMP'
    Items.Strings = (
      'TIMESTAMP'
      'DATE')
  end
  object cbTDateField: TComboBox
    Left = 315
    Top = 347
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 23
    Text = 'DATE'
    Items.Strings = (
      'DATE')
  end
  object cbTStringFieldL: TComboBox
    Left = 143
    Top = 243
    Width = 83
    Height = 21
    ItemHeight = 13
    TabOrder = 11
    Text = 'VARCHAR'
    Items.Strings = (
      'VARCHAR'
      'CHAR')
  end
  object cbTIntegerField: TComboBox
    Left = 77
    Top = 269
    Width = 150
    Height = 21
    ItemHeight = 13
    TabOrder = 12
    Text = 'INTEGER'
    Items.Strings = (
      'INTEGER')
  end
  object cbTFloatField: TComboBox
    Left = 77
    Top = 295
    Width = 150
    Height = 21
    ItemHeight = 13
    TabOrder = 13
    Text = 'FLOAT'
    Items.Strings = (
      'FLOAT'
      'NUMERIC(15,2)')
  end
  object cbTBCDField: TComboBox
    Left = 77
    Top = 321
    Width = 150
    Height = 21
    ItemHeight = 13
    TabOrder = 14
    Text = 'NUMERIC(15,2)'
    Items.Strings = (
      'NUMERIC(15,Decimals)'
      'NUMERIC(15,2)'
      'NUMERIC(Precision,Decimals)')
  end
  object cbTLargeintField: TComboBox
    Left = 77
    Top = 347
    Width = 150
    Height = 21
    ItemHeight = 13
    TabOrder = 15
    Text = 'NUMERIC(18)'
    Items.Strings = (
      'NUMERIC(18)'
      'INTEGER')
  end
  object cbTSmallintField: TComboBox
    Left = 77
    Top = 373
    Width = 150
    Height = 21
    ItemHeight = 13
    TabOrder = 16
    Text = 'SMALLINT'
    Items.Strings = (
      'SMALLINT')
  end
  object cbTStringFieldS: TComboBox
    Left = 143
    Top = 217
    Width = 83
    Height = 21
    ItemHeight = 13
    TabOrder = 10
    Text = 'CHAR'
    Items.Strings = (
      'CHAR'
      'VARCHAR')
  end
  object cbCharSet: TComboBox
    Left = 140
    Top = 93
    Width = 200
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
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
  object cbConvNames: TComboBox
    Left = 140
    Top = 172
    Width = 300
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      
        'to classic format (remove all symbols except '#39'A'#39'..'#39'Z'#39', '#39'a'#39'..'#39'z'#39',' +
        ' '#39'0'#39'..'#39'9'#39', '#39'$'#39', '#39'_'#39')'
      'leave it as it is')
  end
  object mInfo: TMemo
    Left = 478
    Top = 344
    Width = 115
    Height = 65
    TabStop = False
    Lines.Strings = (
      
        'Please visit IB DataPump home/support page at http://www.cleverc' +
        'omponents.com'
      ''
      'To execute this script:'
      
        '1. Run IBConsole (or simular Interbase/Firebird tool which can e' +
        'xecute srcipts)'
      '2. Go to menu Tools->Interactive SQL '
      
        '3. Now in Interactive SQL window menu Query->Load Script select ' +
        'script created by IB DataPump'
      '4. Once script loaded go to menu Query->Execute.')
    TabOrder = 24
    Visible = False
    WantReturns = False
    WordWrap = False
  end
  object cbTBooleanField: TComboBox
    Tag = 1
    Left = 314
    Top = 244
    Width = 313
    Height = 21
    ItemHeight = 13
    TabOrder = 19
  end
  object cbIndexes: TCheckBox
    Left = 355
    Top = 97
    Width = 270
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Copy Indexes and Primary Constraints'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object cbGen: TCheckBox
    Left = 355
    Top = 70
    Width = 206
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Create Generators For AutoInc Fields'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object btnAutoIncDefine: TButton
    Left = 570
    Top = 64
    Width = 56
    Height = 25
    Caption = 'Define...'
    TabOrder = 5
    OnClick = btnAutoIncDefineClick
  end
  object btnSaveProfile: TButton
    Left = 4
    Top = 425
    Width = 75
    Height = 25
    Caption = 'Save Profile...'
    TabOrder = 34
    OnClick = btnSaveProfileClick
  end
  object btnLoadProfile: TButton
    Left = 86
    Top = 425
    Width = 75
    Height = 25
    Caption = 'Load Profile...'
    TabOrder = 29
    OnClick = btnLoadProfileClick
  end
  object btnHelp: TButton
    Left = 355
    Top = 425
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
    TabOrder = 31
    OnClick = btnHelpClick
  end
  object btnNewProfile: TButton
    Left = 170
    Top = 425
    Width = 75
    Height = 25
    Caption = 'New Profile'
    TabOrder = 33
    OnClick = btnNewProfileClick
  end
  object cbTBinaryField: TComboBox
    Left = 77
    Top = 399
    Width = 150
    Height = 21
    ItemHeight = 13
    TabOrder = 17
    Text = 'BLOB'
    Items.Strings = (
      'BLOB'
      'INTEGER')
  end
  object cbDefaults: TCheckBox
    Left = 355
    Top = 123
    Width = 270
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Copy Defaults and Validity Checks (Paradox, dBase)'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cbRefs: TCheckBox
    Left = 355
    Top = 150
    Width = 270
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Copy Referential Integrity (Paradox, dBase only)'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object cbTBlobField: TComboBox
    Left = 508
    Top = 295
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 28
    Text = 'BLOB'
    Items.Strings = (
      'BLOB')
  end
  object cbTMemoField: TComboBox
    Left = 508
    Top = 269
    Width = 120
    Height = 21
    ItemHeight = 13
    TabOrder = 27
    Text = 'BLOB SUB_TYPE 1'
    Items.Strings = (
      'BLOB SUB_TYPE 1')
  end
  object cbLang: TCheckBox
    Left = 454
    Top = 175
    Width = 171
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Get Language Information'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object sd: TSaveDialog
    DefaultExt = 'sql'
    Filter = 'SQL script files (*.sql)|*.sql'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 552
    Top = 318
  end
  object sdProfile: TSaveDialog
    DefaultExt = 'ssp'
    Filter = 'SQL Script Profile (*.ssp)|*.ssp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Profile'
    Left = 504
    Top = 320
  end
  object odProfile: TOpenDialog
    DefaultExt = 'ssp'
    Filter = 'SQL Script Profile (*.ssp)|*.ssp'
    Title = 'Load Profile'
    Left = 452
    Top = 320
  end
end
