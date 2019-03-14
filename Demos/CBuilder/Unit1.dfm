object Form1: TForm1
  Left = 208
  Top = 152
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object RunSilent: TButton
    Left = 606
    Top = 424
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Run Silent'
    TabOrder = 0
    OnClick = RunSilentClick
  end
  object Memo1: TMemo
    Left = 2
    Top = 2
    Width = 683
    Height = 415
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object ShowIBPump: TButton
    Left = 502
    Top = 424
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Show IBPump'
    TabOrder = 2
    OnClick = ShowIBPumpClick
  end
end
