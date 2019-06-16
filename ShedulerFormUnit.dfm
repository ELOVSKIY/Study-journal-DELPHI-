object ScheduleForm: TScheduleForm
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
  ClientHeight = 761
  ClientWidth = 1008
  Color = clBtnFace
  Constraints.MinHeight = 768
  Constraints.MinWidth = 1024
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenuSheduler
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    1008
    761)
  PixelsPerInch = 96
  TextHeight = 19
  object sgDaysOfWeek: TStringGrid
    Left = 8
    Top = 8
    Width = 968
    Height = 25
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clScrollBar
    ColCount = 7
    Enabled = False
    FixedCols = 6
    RowCount = 1
    FixedRows = 0
    GradientStartColor = clYellow
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ScrollBars = ssNone
    TabOrder = 0
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      24)
  end
  object sgWeeksOfMonth: TStringGrid
    Left = 8
    Top = 32
    Width = 65
    Height = 700
    Anchors = [akLeft, akTop, akBottom]
    Color = clScrollBar
    ColCount = 1
    Enabled = False
    FixedCols = 0
    RowCount = 4
    FixedRows = 3
    GradientStartColor = clYellow
    ScrollBars = ssNone
    TabOrder = 1
    ColWidths = (
      64)
    RowHeights = (
      24
      24
      24
      24)
  end
  object sgSubjects: TStringGrid
    Left = 72
    Top = 32
    Width = 904
    Height = 700
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 6
    FixedColor = clBlack
    FixedCols = 0
    RowCount = 20
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssNone
    TabOrder = 2
    OnKeyDown = sgSubjectsKeyDown
    OnKeyPress = sgSubjectsKeyPress
    ColWidths = (
      64
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
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object MainMenuSheduler: TMainMenu
    Left = 840
    Top = 40
    object SaveSheduler: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ShortCut = 16467
      OnClick = SaveShedulerClick
    end
    object ClearSheduler: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ShortCut = 16451
      OnClick = ClearShedulerClick
    end
  end
end
