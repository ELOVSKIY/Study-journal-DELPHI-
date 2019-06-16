object GroupForm: TGroupForm
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = #1057#1086#1089#1090#1072#1074' '#1075#1088#1091#1087#1087#1099
  ClientHeight = 441
  ClientWidth = 658
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnGroup
  OldCreateOrder = False
  Position = poDesktopCenter
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    658
    441)
  PixelsPerInch = 96
  TextHeight = 13
  object sgGroup: TStringGrid
    Left = 24
    Top = 39
    Width = 611
    Height = 362
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyDown = onEscapeDown
    ColWidths = (
      64
      64
      64
      64
      64)
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object sgTitle: TStringGrid
    Left = 24
    Top = 8
    Width = 611
    Height = 25
    Color = clScrollBar
    ColCount = 2
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    GradientStartColor = clYellow
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 1
    OnKeyDown = onEscapeDown
    ColWidths = (
      64
      64)
    RowHeights = (
      24)
  end
  object mnGroup: TMainMenu
    Left = 8
    Top = 416
    object AddStudent: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = AddStudentClick
    end
    object DeleteStudent: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = DeleteStudentClick
    end
    object ChangeStudent: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = ChangeStudentClick
    end
  end
end
