unit View.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles,
  cxTL, cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters,
  cxInplaceContainer, Vcl.ComCtrls, Winapi.ShlObj, cxShellCommon, cxContainer,
  cxEdit, cxTreeView, cxShellTreeView, Vcl.Menus, cxButtons, cxTextEdit,
  Winapi.ShellAPI;

type
  TfrmMenu = class(TForm)
    pTopo: TPanel;
    pRodape: TPanel;
    tUsuario: TLabel;
    tEmpresa: TLabel;
    tRotina: TLabel;
    cxEdtCodRotina: TcxTextEdit;
    cxBtnAbrir: TcxButton;
    TreeView1: TTreeView;
    vUsuario: TLabel;
    vEmpresa: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure cxBtnAbrirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses ULogin, View.Login;
{ TfrmMenu }

procedure TfrmMenu.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

procedure TfrmMenu.cxBtnAbrirClick(Sender: TObject);
begin
  if cxEdtCodRotina.Text = '' then
  begin
    MessageDlg('Informe uma rotina.', mtError, [mbRetry], 0);
    abort;
  end
  else if cxEdtCodRotina.Text = '3919' then
  begin
    try
      WinExec(PAnsiChar
        ('cmd.exe /c xcopy "\\dc2\Winthor (Benevides)\AFLP9\AFLP3919.exe" "C:\WinThor\PROD\AFLP9"'),
        SW_HIDE);
    finally
      ShellExecute(handle, 'open', 'C:\WinThor\PROD\AFLP9\AFLP3919.EXE',
        pChar(IntToStr(frmLogin.vMatricula)), '', SW_NORMAL);
    end;
  end;
end;

procedure TfrmMenu.FormActivate(Sender: TObject);
begin
  try
    vUsuario.Caption := frmLogin.vUsuario;
    vEmpresa.Caption := frmLogin.vEmpresa;
  except
  end;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMenu.Release;
  Application.Terminate;
end;

procedure TfrmMenu.TreeView1DblClick(Sender: TObject);
begin
  cxEdtCodRotina.Text := '3919';
end;

end.
