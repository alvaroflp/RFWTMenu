program AFLPMOB;

uses
  Vcl.Forms,
  View.Login in 'View\View.Login.pas' {frmLogin},
  View.Menu in 'View\View.Menu.pas' {frmMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
