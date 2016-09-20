unit Server1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp;

type
  TForm1 = class(TForm)
    ssSocket: TServerSocket;
    mmBox: TMemo;
    txtInput: TEdit;
    btnSend: TButton;
    ePort: TEdit;
    btnDCon: TButton;
    btnCon: TButton;
    procedure ssSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure btnSendClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ssSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ssSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure btnConClick(Sender: TObject);
    procedure btnDConClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure BroadCast(src: String; msg: String);
    procedure BiggerList();
    procedure Reset();
    function CheckUserList(targetIP: String): String;
    function UserExists(targetIP: String): Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  userList: Array of Array of String;
  userListLen: integer;

implementation

{$R *.DFM}

// Sets the default settings during form creation
procedure TForm1.FormCreate(Sender: TObject);
begin
    mmBox.Clear;
    Reset;
end;

// Turn the server ON, using the provided Port #
procedure TForm1.btnConClick(Sender: TObject);
begin
    ssSocket.Port:=StrToInt(ePort.Text);
    ssSocket.Active:=true;
    btnCon.Enabled:=false;
    btnDCon.Enabled:=true;
    btnSend.Enabled:=true;
    mmBox.Lines.Add('==== Server Online on Port: '+ePort.Text+' ====');
end;

// Sends the input text to all connected clients
procedure TForm1.btnSendClick(Sender: TObject);
begin
    BroadCast('Server', txtInput.Text);
    txtInput.Clear;    
end;

// Reacts to client connection, sends the proper notifications
procedure TForm1.ssSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
    whoJoin:String;
begin
    whoJoin := Socket.RemoteAddress;
    mmBox.Lines.Add(whoJoin+' Connected');
    Socket.SendText('Connection Successful');
    if ssSocket.Socket.ActiveConnections>1 then
        BroadCast(whoJoin, 'joined');
end;

// React to any message from any client.
// Check if it's a command and reacts accordingly
// If not it just broadcasts the message 
procedure TForm1.ssSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
    len, cmd:integer;
    temp, src, msg: String;
begin
    src := Socket.RemoteAddress;
    msg := Trim(Socket.ReceiveText);
    len := Length(msg);
    if len >= 7 then
    begin
        // Gets the first 3 chars of the message
        temp := Copy(msg, 1, 3);
        if temp = 'cmd' then
        begin
            // Extracts the command id)
            temp := Copy(msg, 1, 7);
            Delete(temp, 1, 3);
            cmd := StrToInt(temp);
            mmBox.Lines.Add(CheckUserList(src)+' USED cmd'+IntToStr(cmd));
            case cmd of
                9172: // CHANGE NAME
                begin
                    Delete(msg, 1, 7);
                    BroadCast(src,' is now knowed as '+msg);
                    if UserExists(src) = -1 then
                    begin
                        BiggerList;
                        userList[userListLen,0] := src;
                        userList[userListLen,1] := msg;
                    end
                    else
                        userList[UserExists(src),1] := msg;
                end;
                0000: BroadCast(src, 'Hello, World!');
                0001: BroadCast(src, 'I Rulez');
                0101: Socket.SendText('Your IP is '+src); // IP
                9999: Socket.SendText('0101->IP; 9172->ChangeName; 9999->Help'); //HELP
            else
            begin
                mmBox.Lines.Add('Receiving ...');
                BroadCast(CheckUserList(src),msg);
            end
            end;
        end
        else
        begin
            mmBox.Lines.Add('Receiving ...');
            BroadCast(CheckUserList(src),msg);
        end;
    end
    else
    begin
        mmBox.Lines.Add('Receiving ...');
        BroadCast(CheckUserList(src),msg);
    end;
end;

// Sends the proper notification on client dcon
procedure TForm1.ssSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var 
    whoLeft:String;
    msg:String;
begin
    whoLeft := Socket.RemoteAddress;
    msg := 'Disconnected';
    if ssSocket.Socket.ActiveConnections>0 then
        BroadCast(whoLeft, msg);
end;

// Shuts down the server
procedure TForm1.btnDConClick(Sender: TObject);
begin
    ssSocket.Active:=false;
    btnCon.Enabled:=true;
    btnDCon.Enabled:=false;
    btnSend.Enabled:=false;
    mmBox.Lines.Add('==== Server Off-Line ====');
end;

// Deactivates the socket on form close
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    ssSocket.Active := false;
end;

//*********** Personal Functions and Procedure ***************/

// Sends a message to all connected clients
procedure TForm1.BroadCast(src: String; msg: String);
var i:integer;
begin
    src := CheckUserList(src);
    mmBox.Lines.Add(src+': '+msg);
    for i:=0 to ssSocket.Socket.ActiveConnections-1 do
        ssSocket.Socket.Connections[i].SendText(CheckUserList(src)+':'+msg);
end;

// Returns the name associated with an IP
function TForm1.CheckUserList(targetIP : String) : String;
var
    i:integer;
begin
    if userListLen>0 then
        for i:=0 to userListLen do
            if userList[i,0] = targetIP then
                targetIP := userList[i,1];
    Result := targetIP;
end;

// Returns the index of the user
function TForm1.UserExists(targetIP:String):Integer;
var
    i:integer;
    id:integer;
begin
    id:=-1;
    if userListLen>0 then
        for i:=0 to userListLen do
            if userList[i,0] = targetIP then
                id := i;
    Result := id;
end;

// Dynamically increase the size of the user list
procedure TForm1.BiggerList();
begin
    userListLen:= userListLen + 1;
    SetLength(userList, userListLen+1);
    SetLength(userList[userListLen], 2);    
end;

// Default value/appearance of the form
procedure TForm1.Reset();
begin
    with Form1 do begin
    txtInput.Clear;
    btnCon.Enabled:=true;
    btnDCon.Enabled:=false;
    btnSend.Enabled:=false;
    userListLen:=0;
    SetLength(userList, 1);
    SetLength(userList[0], 2);
    userList[userListLen,0] := 'Server';
    userList[userListLen,1] := 'Admin';
    end;
end;

end.
