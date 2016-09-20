program ClientDemo;

uses
  Forms,
  Client1 in 'Client1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
