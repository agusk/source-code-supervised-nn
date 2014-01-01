object Form1: TForm1
  Left = 228
  Top = 175
  Caption = 'MATRIKS'
  ClientHeight = 465
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 224
    Top = 8
    Width = 220
    Height = 13
    Caption = 'OPERASI MATRIK DALAM PEMROGRAMAN'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 353
    Height = 217
    Caption = 'Matrik A'
    TabOrder = 0
    object Label2: TLabel
      Left = 18
      Top = 32
      Width = 23
      Height = 13
      Caption = 'Baris'
    end
    object Label3: TLabel
      Left = 13
      Top = 58
      Width = 29
      Height = 13
      Caption = 'Kolom'
    end
    object Baris_A: TEdit
      Left = 48
      Top = 28
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object Kolom_A: TEdit
      Left = 48
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object MatrikA: TStringGrid
      Left = 16
      Top = 80
      Width = 320
      Height = 120
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 2
      Visible = False
    end
    object Button2: TButton
      Left = 216
      Top = 40
      Width = 97
      Height = 25
      Caption = 'Masukan Nilai'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 256
    Width = 353
    Height = 209
    Caption = 'Matrik B'
    TabOrder = 1
    object Label4: TLabel
      Left = 16
      Top = 29
      Width = 23
      Height = 13
      Caption = 'Baris'
    end
    object Label5: TLabel
      Left = 10
      Top = 53
      Width = 29
      Height = 13
      Caption = 'Kolom'
    end
    object Baris_B: TEdit
      Left = 53
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object Kolom_B: TEdit
      Left = 53
      Top = 49
      Width = 122
      Height = 21
      TabOrder = 1
    end
    object MatrikB: TStringGrid
      Left = 16
      Top = 72
      Width = 320
      Height = 120
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 2
      Visible = False
    end
    object Button3: TButton
      Left = 216
      Top = 32
      Width = 105
      Height = 25
      Caption = 'Masukan Nilai'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object Operasi: TRadioGroup
    Left = 368
    Top = 32
    Width = 217
    Height = 105
    Caption = 'Operasi'
    ItemIndex = 0
    Items.Strings = (
      'Penjumlahan     A +B'
      'Pengurangan    A-B'
      'Perkalian          A*B')
    TabOrder = 2
  end
  object GroupBox3: TGroupBox
    Left = 368
    Top = 152
    Width = 305
    Height = 249
    Caption = 'Hasil Operasi'
    TabOrder = 3
    object Label6: TLabel
      Left = 24
      Top = 24
      Width = 23
      Height = 13
      Caption = 'Baris'
    end
    object Label7: TLabel
      Left = 24
      Top = 40
      Width = 29
      Height = 13
      Caption = 'Kolom'
    end
    object Baris_C: TLabel
      Left = 80
      Top = 24
      Width = 36
      Height = 13
      Caption = 'Baris_C'
    end
    object Kolom_C: TLabel
      Left = 80
      Top = 41
      Width = 42
      Height = 13
      Caption = 'Kolom_C'
    end
    object MatrikC: TStringGrid
      Left = 8
      Top = 64
      Width = 281
      Height = 169
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 584
    Top = 432
    Width = 75
    Height = 25
    Caption = 'Keluar'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button4: TButton
    Left = 592
    Top = 96
    Width = 81
    Height = 41
    Caption = 'Eksekusi'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 592
    Top = 40
    Width = 81
    Height = 41
    Caption = 'New'
    TabOrder = 6
    OnClick = Button5Click
  end
end
