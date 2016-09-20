object Form1: TForm1
  Left = 773
  Top = 57
  Width = 409
  Height = 338
  Caption = 'Doom Chat Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object lblHost: TLabel
    Left = 8
    Top = 8
    Width = 41
    Height = 13
    Caption = 'Host  IP;'
  end
  object lblPort: TLabel
    Left = 184
    Top = 8
    Width = 25
    Height = 13
    Caption = 'Port: '
  end
  object lblFSize: TLabel
    Left = 40
    Top = 80
    Width = 29
    Height = 16
    Caption = 'SIZE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object mmBox: TMemo
    Left = 8
    Top = 104
    Width = 369
    Height = 153
    Color = clWhite
    Lines.Strings = (
      'mmBox')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object txtInput: TEdit
    Left = 8
    Top = 264
    Width = 289
    Height = 21
    Color = clWhite
    TabOrder = 1
    Text = 'txtInput'
  end
  object btnSend: TButton
    Left = 304
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Send'
    Default = True
    TabOrder = 2
    OnClick = btnSendClick
  end
  object eHost: TEdit
    Left = 56
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object ePort: TEdit
    Left = 216
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object btnConnect: TButton
    Left = 8
    Top = 40
    Width = 97
    Height = 25
    Caption = 'Connect'
    TabOrder = 5
    OnClick = btnConnectClick
  end
  object btnDisCon: TButton
    Left = 280
    Top = 40
    Width = 99
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 6
    OnClick = btnDisConClick
  end
  object eName: TEdit
    Left = 128
    Top = 32
    Width = 129
    Height = 21
    TabOrder = 7
    Text = 'UserName (optional)'
  end
  object btnReg: TButton
    Left = 152
    Top = 56
    Width = 81
    Height = 25
    Caption = 'Register'
    TabOrder = 8
    OnClick = btnRegClick
  end
  object btnReduce: TButton
    Left = 8
    Top = 80
    Width = 25
    Height = 17
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btnReduceClick
  end
  object btnBigger: TButton
    Left = 80
    Top = 80
    Width = 25
    Height = 17
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = btnBiggerClick
  end
  object btnDark: TButton
    Left = 280
    Top = 72
    Width = 99
    Height = 25
    Caption = 'Dark Mode'
    TabOrder = 11
    OnClick = btnDarkClick
  end
  object csSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnRead = csSocketRead
    Left = 344
  end
end
