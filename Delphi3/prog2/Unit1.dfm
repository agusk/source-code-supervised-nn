object Form1: TForm1
  Left = 213
  Top = 83
  Width = 804
  Height = 656
  Caption = 'Simulasi Back Propagation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 152
    Width = 169
    Height = 273
    Caption = 'Input Layer'
    TabOrder = 0
    object Xinput: TStringGrid
      Left = 8
      Top = 32
      Width = 153
      Height = 233
      ColCount = 2
      RowCount = 18
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      Visible = False
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
        24)
    end
  end
  object GroupBox2: TGroupBox
    Left = 179
    Top = 152
    Width = 369
    Height = 473
    Caption = 'Hidden Layer'
    TabOrder = 1
    object Label1: TLabel
      Left = 260
      Top = 16
      Width = 98
      Height = 13
      Caption = 'Bobot Input - Hidden'
      Visible = False
    end
    object Label2: TLabel
      Left = 253
      Top = 241
      Width = 106
      Height = 13
      Caption = 'Bobot Hidden - Output'
      Visible = False
    end
    object VijHidden: TStringGrid
      Left = 8
      Top = 32
      Width = 353
      Height = 201
      ColCount = 2
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
      Visible = False
    end
    object WjkHidden: TStringGrid
      Left = 8
      Top = 258
      Width = 353
      Height = 201
      ColCount = 2
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 1
      Visible = False
      RowHeights = (
        24
        24)
    end
  end
  object GroupBox3: TGroupBox
    Left = 557
    Top = 152
    Width = 234
    Height = 473
    Caption = 'Output Layer'
    TabOrder = 2
    object YOutput: TStringGrid
      Left = 8
      Top = 32
      Width = 217
      Height = 425
      ColCount = 3
      RowCount = 18
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
      Visible = False
    end
  end
  object GroupBox4: TGroupBox
    Left = 4
    Top = 2
    Width = 421
    Height = 143
    Caption = 'Properties'
    TabOrder = 3
    object Label3: TLabel
      Left = 8
      Top = 19
      Width = 49
      Height = 13
      Caption = 'Momenum'
    end
    object Label4: TLabel
      Left = 8
      Top = 41
      Width = 62
      Height = 13
      Caption = 'Learning rate'
    end
    object Label5: TLabel
      Left = 10
      Top = 66
      Width = 38
      Height = 13
      Caption = 'Looping'
    end
    object Label6: TLabel
      Left = 209
      Top = 17
      Width = 79
      Height = 13
      Caption = 'Jumlah unit input'
    end
    object Label7: TLabel
      Left = 210
      Top = 41
      Width = 88
      Height = 13
      Caption = 'Jumlah unit hidden'
    end
    object Label8: TLabel
      Left = 210
      Top = 65
      Width = 86
      Height = 13
      Caption = 'Jumlah unit output'
    end
    object Label9: TLabel
      Left = 11
      Top = 89
      Width = 44
      Height = 13
      Caption = 'Error max'
    end
    object Label12: TLabel
      Left = 8
      Top = 120
      Width = 77
      Height = 13
      Caption = 'Transfer Fuction'
    end
    object sMomentum: TEdit
      Left = 83
      Top = 15
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '0.2'
    end
    object sLearningRate: TEdit
      Left = 84
      Top = 38
      Width = 118
      Height = 21
      TabOrder = 1
      Text = '0.1'
    end
    object sLooping: TEdit
      Left = 84
      Top = 62
      Width = 119
      Height = 21
      TabOrder = 2
      Text = '1000'
    end
    object sUnitInput: TEdit
      Left = 307
      Top = 15
      Width = 97
      Height = 21
      TabOrder = 4
      Text = '10'
    end
    object sUnitHidden: TEdit
      Left = 307
      Top = 41
      Width = 97
      Height = 21
      TabOrder = 5
      Text = '40'
    end
    object sUnitOutput: TEdit
      Left = 307
      Top = 66
      Width = 97
      Height = 21
      TabOrder = 6
      Text = '3'
    end
    object sErrorMax: TEdit
      Left = 83
      Top = 86
      Width = 120
      Height = 21
      TabOrder = 3
      Text = '0.001'
    end
    object Button2: TButton
      Left = 249
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Set'
      TabOrder = 8
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 328
      Top = 104
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 9
      OnClick = Button4Click
    end
    object stf: TComboBox
      Left = 91
      Top = 112
      Width = 114
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
      Items.Strings = (
        'Binary Sigmoid'
        'Bipolar Sigmoid')
    end
  end
  object GroupBox5: TGroupBox
    Left = 429
    Top = 5
    Width = 364
    Height = 140
    Caption = 'Eksekusi'
    TabOrder = 4
    object Gauge1: TGauge
      Left = 11
      Top = 18
      Width = 342
      Height = 25
      ForeColor = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Progress = 0
    end
    object Label10: TLabel
      Left = 128
      Top = 64
      Width = 99
      Height = 13
      Caption = 'Error rata-rata system'
    end
    object Label11: TLabel
      Left = 128
      Top = 88
      Width = 56
      Height = 13
      Caption = 'Looping ke-'
    end
    object rErrorSystem: TLabel
      Left = 239
      Top = 64
      Width = 59
      Height = 13
      Caption = 'rErrorSystem'
      Visible = False
    end
    object rLooping: TLabel
      Left = 240
      Top = 89
      Width = 41
      Height = 13
      Caption = 'rLooping'
      Visible = False
    end
    object Button1: TButton
      Left = 14
      Top = 46
      Width = 75
      Height = 25
      Caption = 'Run'
      Enabled = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 14
      Top = 77
      Width = 75
      Height = 25
      Caption = 'Exit'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button5: TButton
      Left = 128
      Top = 110
      Width = 121
      Height = 25
      Caption = 'Grafik Sistem'
      Enabled = False
      TabOrder = 2
      OnClick = Button5Click
    end
  end
  object GroupBox6: TGroupBox
    Left = 5
    Top = 432
    Width = 169
    Height = 193
    Caption = 'Target'
    TabOrder = 5
    object Target: TStringGrid
      Left = 8
      Top = 24
      Width = 153
      Height = 157
      ColCount = 2
      RowCount = 10
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      Visible = False
    end
  end
end
