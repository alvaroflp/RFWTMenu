unit View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxButtons, cxTextEdit, Data.DB, MemDS, DBAccess, Ora, OraSmart, OraCall,
  dxGDIPlusClasses;

type
  TfrmLogin = class(TForm)
    cxEdtUsuario: TcxTextEdit;
    cxEdtSenha: TcxTextEdit;
    cxBtnEntrar: TcxButton;
    cxBtnSair: TcxButton;
    tUsuario: TLabel;
    tSenha: TLabel;
    StatusBar1: TStatusBar;
    OS1: TOraSession;
    qryLogin: TSmartQuery;
    tMenuRotina: TLabel;
    tVersao: TLabel;
    tDataHora: TLabel;
    procedure cxBtnSairClick(Sender: TObject);
    procedure cxBtnEntrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxEdtSenhaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public
    vMatricula: Integer;
    vUsuario: String;
    vEmpresa: String;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UMenu, View.Menu;

procedure TfrmLogin.cxBtnEntrarClick(Sender: TObject);
begin
  if ((cxEdtUsuario.Text = '') or (cxEdtSenha.Text = '')) then
  begin
    MessageDlg('Informe todos os campos.', mtInformation, [mbOk], 0);
  end
  else
  begin
    qryLogin.Close;
    qryLogin.ParamByName('pUSUARIO').Value := cxEdtUsuario.Text;
    qryLogin.ParamByName('pSENHA').Value := cxEdtSenha.Text;
    qryLogin.Open();
    if qryLogin.RecordCount = 0 then
    begin
      MessageDlg('Dados incorretos.' + #13 + 'Verifique Usu�rio/Senha',
        mtInformation, [mbOk], 0);
    end
    else
    begin
      try
        vMatricula := qryLogin.FieldByName('MATRICULA').Value;
        vUsuario := qryLogin.FieldByName('USUARIOBD').Value;
        vEmpresa := qryLogin.FieldByName('EMPRESA').Value;
        frmLogin.Visible := False;
        Application.CreateForm(TfrmMenu, frmMenu);
        frmMenu.ShowModal;
      finally
        FreeAndNil(frmMenu);
      end;
    end;
  end;
end;

procedure TfrmLogin.cxBtnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.cxEdtSenhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = VK_RETURN) then
  begin
    cxBtnEntrarClick(Sender);
  end;
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
 tDataHora.Caption := DateToStr(Date) + ' - ' + TimeToStr(Time);
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmLogin.Release;
  Application.Terminate;
end;

end.
