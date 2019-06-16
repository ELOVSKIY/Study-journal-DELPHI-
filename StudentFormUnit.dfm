object StudentForm: TStudentForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1057#1090#1091#1076#1077#1085#1090
  ClientHeight = 325
  ClientWidth = 274
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 280
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbMiddleName: TLabel
    Left = 18
    Top = 123
    Width = 49
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086
  end
  object lbName: TLabel
    Left = 18
    Top = 78
    Width = 19
    Height = 13
    Caption = #1048#1084#1103
  end
  object lbSurname: TLabel
    Left = 18
    Top = 24
    Width = 44
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103
  end
  object btConfirm: TButton
    Left = 145
    Top = 200
    Width = 121
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
    TabOrder = 4
    OnClick = btConfirmClick
    OnKeyDown = onDownEscape
  end
  object edMiddleName: TEdit
    Left = 18
    Top = 142
    Width = 239
    Height = 21
    TabOrder = 2
    OnKeyDown = onDownEscape
    OnKeyPress = onEditKeyPress
  end
  object edName: TEdit
    Left = 18
    Top = 96
    Width = 239
    Height = 21
    TabOrder = 1
    OnKeyDown = onDownEscape
    OnKeyPress = onEditKeyPress
  end
  object edSurname: TEdit
    Left = 18
    Top = 43
    Width = 239
    Height = 21
    TabOrder = 0
    OnKeyDown = onDownEscape
    OnKeyPress = onEditKeyPress
  end
  object cbLeader: TCheckBox
    Left = 18
    Top = 177
    Width = 121
    Height = 17
    Caption = #1057#1090#1072#1088#1086#1089#1090#1072
    TabOrder = 3
    OnKeyPress = cbLeaderKeyPress
  end
end
