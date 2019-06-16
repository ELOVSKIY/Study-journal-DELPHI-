object SchedulerForm: TSchedulerForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' '#1075#1088#1091#1087#1087#1077
  ClientHeight = 150
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edGroupNumb: TEdit
    Left = 24
    Top = 24
    Width = 193
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnKeyDown = onEscapeExit
    OnKeyPress = edGroupNumbKeyPress
  end
  object btConfirm: TButton
    Left = 104
    Top = 104
    Width = 113
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    TabOrder = 3
    OnClick = btConfirmClick
    OnKeyDown = onEscapeExit
  end
  object edYear: TEdit
    Left = 24
    Top = 64
    Width = 65
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    OnKeyDown = onEscapeExit
    OnKeyPress = edYearKeyPress
  end
  object cbSemestr: TComboBox
    Left = 104
    Top = 64
    Width = 113
    Height = 21
    TabOrder = 2
    Text = #1057#1077#1084#1077#1089#1090#1088
    OnKeyDown = onEscapeExit
  end
end
