object Form1: TForm1
  Left = 464
  Top = 169
  Width = 682
  Height = 759
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'StanD'
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Palatino Linotype'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 22
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 666
    Height = 26
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
  end
  object ScrollBoxProg: TScrollBox
    Left = 0
    Top = 26
    Width = 666
    Height = 695
    Align = alClient
    TabOrder = 1
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items.CaptionOptions = coAll
        Items = <
          item
            Action = ActionStend
            ImageIndex = 1
          end>
      end
      item
        Items.CaptionOptions = coNone
        Items.SmallIcons = False
        Items = <
          item
            Action = ActionStend
            ImageIndex = 1
          end>
      end
      item
        Items = <
          item
            Items = <
              item
                Action = ActionStend
                ImageIndex = 1
              end
              item
                Action = ActionTimerRun
              end
              item
                Action = ActionAutoStand
              end
              item
                Action = ActionAdminControl
              end>
            Caption = #1056#1077#1078#1080#1084' '#1082#1080#1086#1089#1082#1072
          end
          item
            Items = <
              item
                Action = ActionAddProg
              end
              item
                Action = ActionDelProg
              end>
            Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1099
          end
          item
            Items = <
              item
                Action = ActionSave
              end
              item
                Action = ActionLoad
              end
              item
                Action = ActionSaveAs
              end
              item
                Action = ActionLoadAs
              end>
            Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
          end
          item
            Items = <
              item
                Action = ActionHotKeyOn
                Caption = '&ActionHotKeyOn'
              end
              item
                Action = ActionHotKeyOut
                Caption = 'A&ctionHotKeyOut'
              end
              item
                Action = ActionDesktopOn
                Caption = 'Ac&tionDesktopOn'
              end
              item
                Action = ActionDesktopOut
                Caption = 'Act&ionDesktopOut'
              end
              item
                Action = ActionTaskmgrOn
                Caption = 'Acti&onTaskmgrOn'
              end
              item
                Action = ActionTaskmgrOut
                Caption = 'Actio&nTaskmgrOut'
              end>
            Caption = #1060#1091#1085#1082#1094#1080#1080
          end
          item
            Action = ActionClose
          end
          item
            Action = ActionSave
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 8
    Top = 32
    StyleName = 'XP Style'
    object ActionStend: TAction
      Category = #1056#1077#1078#1080#1084' '#1082#1080#1086#1089#1082#1072
      Caption = #1040#1082#1090#1080#1074#1077#1085
      ImageIndex = 1
      OnExecute = ActionStendExecute
    end
    object ActionTimerRun: TAction
      Category = #1056#1077#1078#1080#1084' '#1082#1080#1086#1089#1082#1072
      Caption = #1047#1072#1087#1091#1089#1082' '#1087#1086' '#1090#1072#1081#1084#1077#1088#1091
      OnExecute = ActionTimerRunExecute
    end
    object ActionAutoStand: TAction
      Category = #1056#1077#1078#1080#1084' '#1082#1080#1086#1089#1082#1072
      Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
      OnExecute = ActionAutoStandExecute
    end
    object ActionAddProg: TAction
      Category = #1055#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = ActionAddProgExecute
    end
    object ActionDelProg: TAction
      Category = #1055#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = #1059#1076#1072#1083#1080#1090#1100
    end
    object ActionSave: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnExecute = ActionSaveExecute
    end
    object ActionLoad: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      OnExecute = ActionLoadExecute
    end
    object ActionLoadAs: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      OnExecute = ActionLoadAsExecute
    end
    object ActionSaveAs: TAction
      Category = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      OnExecute = ActionSaveAsExecute
    end
    object ActionAdminControl: TAction
      Category = #1056#1077#1078#1080#1084' '#1082#1080#1086#1089#1082#1072
      Caption = #1050#1086#1085#1090#1088#1086#1083#1100' '#1087#1088#1072#1074
      OnExecute = ActionAdminControlExecute
    end
    object ActionHotKeyOn: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionHotKeyOn'
      OnExecute = ActionHotKeyOnExecute
    end
    object ActionHotKeyOut: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionHotKeyOut'
      OnExecute = ActionHotKeyOutExecute
    end
    object ActionDesktopOn: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionDesktopOn'
      OnExecute = ActionDesktopOnExecute
    end
    object ActionDesktopOut: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionDesktopOut'
      OnExecute = ActionDesktopOutExecute
    end
    object ActionTaskmgrOn: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionTaskmgrOn'
      OnExecute = ActionTaskmgrOnExecute
    end
    object ActionTaskmgrOut: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionTaskmgrOut'
      OnExecute = ActionTaskmgrOutExecute
    end
    object ActionDelClose: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionDelClose'
      OnExecute = ActionDelCloseExecute
    end
    object ActionClose: TAction
      Category = #1056#1077#1078#1080#1084' '#1082#1080#1086#1089#1082#1072
      Caption = #1042#1099#1093#1086#1076
      OnExecute = ActionCloseExecute
    end
    object ActionAutoRun: TAction
      Category = #1055#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = 'ActionAutoRun'
      OnExecute = ActionAutoRunExecute
    end
    object ActionAdmTest: TAction
      Category = #1060#1091#1085#1082#1094#1080#1080
      Caption = 'ActionAdmTest'
      OnExecute = ActionAdmTestExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      #1048#1089#1087#1086#1083#1085#1103#1077#1084#1099#1077' '#1092#1072#1081#1083#1099'|*.exe|bat '#1092#1072#1081#1083#1099'|*.bat|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*|ini-'#1092#1072#1081#1083#1099'|' +
      '*.ini'
    Left = 40
    Top = 32
  end
  object SaveDialog1: TSaveDialog
    Left = 72
    Top = 34
  end
  object TimerRun: TTimer
    Interval = 60000
    OnTimer = TimerRunTimer
    Left = 104
    Top = 34
  end
end
