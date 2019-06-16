object WorkWeek: TWorkWeek
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083
  ClientHeight = 709
  ClientWidth = 1008
  Color = clBtnFace
  Constraints.MaxHeight = 1920
  Constraints.MaxWidth = 2560
  Constraints.MinHeight = 768
  Constraints.MinWidth = 1024
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = miMainMenuWeek
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnKeyDown = EscapeExit
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    1008
    709)
  PixelsPerInch = 96
  TextHeight = 13
  object btNextPage: TSpeedButton
    Left = 709
    Top = 279
    Width = 64
    Height = 30
    Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btNextPageClick
  end
  object btPrevPage: TSpeedButton
    Left = 631
    Top = 280
    Width = 72
    Height = 30
    Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btPrevPageClick
  end
  object sgSheduler: TStringGrid
    Left = 8
    Top = 62
    Width = 765
    Height = 200
    ParentCustomHint = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    BiDiMode = bdLeftToRight
    ColCount = 32
    Ctl3D = True
    DefaultColWidth = 30
    DefaultRowHeight = 30
    DoubleBuffered = False
    Enabled = False
    FixedCols = 2
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = False
    TabOrder = 0
    OnDblClick = sgShedulerDblClick
    OnKeyDown = EscapeExit
    ColWidths = (
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30)
    RowHeights = (
      30)
  end
  object sgTitle: TStringGrid
    Left = 8
    Top = 0
    Width = 765
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Color = clScrollBar
    ColCount = 8
    Enabled = False
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
    ColWidths = (
      64
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
  object sgClasses: TStringGrid
    Left = 8
    Top = 31
    Width = 765
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Color = clScrollBar
    ColCount = 32
    DefaultRowHeight = 80
    DefaultDrawing = False
    Enabled = False
    FixedCols = 31
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
    TabOrder = 2
    OnDrawCell = sgClassesDrawCell
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      80)
  end
  object pnlGroupNumb: TFlowPanel
    Left = 8
    Top = 280
    Width = 145
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object pnlWeekNumber: TFlowPanel
    Left = 271
    Top = 280
    Width = 114
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object pnlYear: TFlowPanel
    Left = 391
    Top = 280
    Width = 106
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object pnlSemestrWeek: TFlowPanel
    Left = 503
    Top = 280
    Width = 106
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object pnlSemestr: TFlowPanel
    Left = 159
    Top = 280
    Width = 106
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object miMainMenuWeek: TMainMenu
    Left = 808
    Top = 8
    object miMenuSheduler: TMenuItem
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
      object miOpenFile: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = miOpenFileClick
      end
      object Create: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        ShortCut = 16462
        OnClick = CreateClick
      end
      object miSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = miSaveClick
      end
      object miSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
        Enabled = False
        ShortCut = 16449
        OnClick = miSaveAsClick
      end
    end
    object miMenuChange: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Enabled = False
      object miChangeSheduler: TMenuItem
        Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
        OnClick = miChangeShedulerClick
      end
      object miChangeGroup: TMenuItem
        Caption = #1057#1086#1089#1090#1072#1074' '#1075#1088#1091#1087#1087#1099
        OnClick = miChangeGroupClick
      end
    end
  end
  object SaveDialog: TSaveDialog
    Left = 808
    Top = 56
  end
  object OpenDialog: TOpenDialog
    Filter = 'Jurnal|*.jrnl'
    Left = 808
    Top = 104
  end
end
