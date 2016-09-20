object Form1: TForm1
  Left = 770
  Top = 593
  Width = 418
  Height = 274
  Caption = 'Form1'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clLime
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mmBox: TMemo
    Left = 8
    Top = 40
    Width = 385
    Height = 153
    Color = clBlack
    Lines.Strings = (
      'mmBox1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object txtInput: TEdit
    Left = 8
    Top = 200
    Width = 297
    Height = 21
    Color = clBlack
    TabOrder = 1
    Text = 'txtInput'
  end
  object btnSend: TButton
    Left = 312
    Top = 200
    Width = 81
    Height = 25
    Caption = 'Send'
    Default = True
    TabOrder = 2
    OnClick = btnSendClick
  end
  object ePort: TEdit
    Left = 144
    Top = 8
    Width = 121
    Height = 21
    Color = clBlack
    TabOrder = 3
    Text = 'Port'
  end
  object btnDCon: TButton
    Left = 280
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 4
    OnClick = btnDConClick
  end
  object btnCon: TButton
    Left = 48
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Connect'
    TabOrder = 5
    OnClick = btnConClick
  end
  object ssSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ssSocketClientConnect
    OnClientDisconnect = ssSocketClientDisconnect
    OnClientRead = ssSocketClientRead
    Left = 8
    Top = 8
  end
end
