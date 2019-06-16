object Autorization: TAutorization
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  ClientHeight = 291
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edGroupNumb: TEdit
    Left = 30
    Top = 45
    Width = 180
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyDown = edGroupNumbKeyDown
    OnKeyPress = edGroupNumbKeyPress
  end
  object btAccess: TButton
    Left = 130
    Top = 72
    Width = 80
    Height = 25
    Caption = #1042#1086#1081#1090#1080
    TabOrder = 1
    OnClick = btAccessClick
  end
end
