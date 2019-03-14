object ibpUpdDefs: TibpUpdDefs
  Left = 485
  Top = 272
  Width = 450
  Height = 288
  Caption = 'Update Defenitions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 215
    Width = 434
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      434
      34)
    object btnStart: TButton
      Left = 284
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Start'
      Default = True
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnClose: TButton
      Left = 364
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object memRep: TMemo
    Left = 0
    Top = 0
    Width = 434
    Height = 215
    Align = alClient
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
    WordWrap = False
  end
end
