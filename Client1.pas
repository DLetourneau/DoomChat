unit Client1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ScktComp, StdCtrls;

type
  TForm1 = class(TForm)
    mmBox: TMemo;
    txtInput: TEdit;
    btnSend: TButton;
    csSocket: TClientSocket;
    lblHost: TLabel;
    eHost: TEdit;
    lblPort: TLabel;
    ePort: TEdit;
    btnConnect: TButton;
    btnDisCon: TButton;
    eName: TEdit;
    btnReg: TButton;
    btnReduce: TButton;
    btnBigger: TButton;
    lblFSize: TLabel;
    btnDark: TButton;
    procedure FormCreate(Sender: TObject);
    procedure csSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnSendClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisConClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnReduceClick(Sender: TObject);
    procedure btnBiggerClick(Sender: TObject);
    procedure btnDarkClick(Sender: TObject);
  private
    { Private declarations }
    procedure ChangeMode(mode:Boolean);
  public
    { Public declarations }
    
  end;

var
  Form1: TForm1;
  dark:Boolean;

implementation

{$R *.DFM}

//********* Control linked procedure *************//

// Loads the default settings
procedure TForm1.FormCreate(Sender: TObject);
begin
    btnDisCon.Enabled := false;
    btnConnect.Enabled := true;
    eName.Enabled:=true;
    ePort.Enabled:=true;
    eHost.Enabled:=true;
    mmBox.Clear;
    dark:=false;
end;

// Connect to the selected server
procedure TForm1.btnConnectClick(Sender: TObject);
begin
    csSocket.Host := eHost.Text;
    csSocket.Port := StrToInt(ePort.Text);
    csSocket.Active := true;
    btnConnect.Enabled := false;
    btnDisCon.Enabled := true;
    eHost.Enabled := false;
    ePort.Enabled := false;
end;

// Display the message sent by the server
// Notify with a color change
procedure TForm1.csSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
    mmBox.Lines.Add(Socket.ReceiveText);
    mmBox.Color := clNavy;
    mmBox.Font.Color := clYellow;
end;

// Send the content of the input box to the server
procedure TForm1.btnSendClick(Sender: TObject);
begin
    if csSocket.Active then
    begin
        mmBox.Lines.Add('Sending ...');
        csSocket.Socket.SendText(txtInput.Text);
        txtInput.Clear;
    end;
end;

// Disconnect from current socket
procedure TForm1.btnDisConClick(Sender: TObject);
begin
    if csSocket.Active then
    begin
        csSocket.Active := false;
        btnDisCon.Enabled := false;
        btnConnect.Enabled := true;
        eHost.Enabled := true;
        eHost.Clear;
        ePort.Enabled := true;
        ePort.Clear;
        eName.Enabled := true;
        eName.Clear;
    end;
end;

// Closes socket after form closing
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    csSocket.Active := false;
end;  

// Change Name function call
procedure TForm1.btnRegClick(Sender: TObject);
begin
    csSocket.Socket.SendText('cmd9172'+Trim(eName.Text));
    btnReg.Enabled:=false;
    eName.Enabled:=false;
end;

// Reset display after message reception
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    if dark then
    begin
        mmBox.Color:=clBlack;
        mmBox.Font.Color:=clLime;
    end
    else
    begin
        mmBox.Color:=clWhite;
        mmBox.Font.Color:=clBlack;
    end;    
end;

//**** UX Modification ****//

// Reduce font size
procedure TForm1.btnReduceClick(Sender: TObject);
var curSize:integer;
begin
    curSize := mmBox.Font.Size;
    if curSize>5 then
        mmBox.Font.Size := curSize-1;
end;

// Increase font size
procedure TForm1.btnBiggerClick(Sender: TObject);
var curSize:integer;
begin
    curSize := mmBox.Font.Size;
    if curSize<20 then
        mmBox.Font.Size := curSize+1;
end;

// Switch between dark and standard mode
procedure TForm1.btnDarkClick(Sender: TObject);
begin
    ChangeMode(dark);
end;

//******** Handmade procedure and functions ***************//

procedure TForm1.ChangeMode(mode:Boolean);
begin
    if mode then
    begin
        dark:=false;
        Form1.Color:=clBtnFace;
        Form1.Font.Color:=clBlack;
        mmBox.Color := clWhite;
        mmBox.Font.Color := clBlack;
        txtInput.Color:=clWhite;
        txtInput.Font.Color:=clBlack;
        eHost.Color:=clWhite;
        eHost.Font.Color:=clBlack;
        ePort.Color:=clWhite;
        ePort.Font.Color:=clBlack;
        eName.Color:=clWhite;
        eName.Font.Color:=clBlack;
    end
    else
    begin
        dark:=true;
        Form1.Color:=clGray;
        Form1.Font.Color:=clLime;
        mmBox.Color:=clBlack;
        mmBox.Font.Color:=clLime;
        txtInput.Color:=clBlack;
        txtInput.Font.Color:=clLime;
        eHost.Color:=clBlack;
        eHost.Font.Color:=clLime;
        ePort.Color:=clBlack;
        ePort.Font.Color:=clLime;
        eName.Color:=clBlack;
        eName.Font.Color:=clLime;
    end;
end;

end.
