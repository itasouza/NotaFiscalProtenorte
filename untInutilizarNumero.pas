unit untInutilizarNumero;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmInutilizarNumero = class(TForm)
    Panel7: TPanel;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnEnviar: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EdtModelo: TEdit;
    EdtSerie: TEdit;
    EdtAno: TEdit;
    EdtInicio: TEdit;
    EdtFinal: TEdit;
    MemoJustifica: TMemo;
    EdtCNPJ: TEdit;
    GroupBox2: TGroupBox;
    MemoRetorno: TMemo;
    lbNomeEmpresa: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInutilizarNumero: TfrmInutilizarNumero;

implementation

uses untDM;

{$R *.dfm}

procedure TfrmInutilizarNumero.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInutilizarNumero.FormShow(Sender: TObject);
begin
    DM.AtualizaConfigAcBr;
    EdtCNPJ.Text           := DM.sCNPJ;
    lbNomeEmpresa.Caption  := DM.sRazao;

end;

procedure TfrmInutilizarNumero.btnEnviarClick(Sender: TObject);
begin
  // verificações
  if (EdtCNPJ.Text = '') or (EdtModelo.Text = '') or (EdtSerie.Text = '') or
     (EdtAno.Text = '') or (EdtInicio.Text = '') or (EdtFinal.Text = '') or
     (MemoJustifica.Text = '') then
  begin
    ShowMessage('Todos os campos do formulário devem ser preenchidos!');
    Abort;
  end;

   //verifica o certificado
   if DM.sTipoCertificado = '3' then
    begin
      if DM.ACBrNFe1.Configuracoes.Certificados.NumeroSerie = '' then
         DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
    end;
    
  //
      Dm.ACBrNFe1.WebServices.Inutiliza(EdtCNPJ.Text,
                                       MemoJustifica.Text,
                                       StrToInt(EdtAno.Text),
                                       StrToInt(EdtModelo.Text),
                                       StrToInt(EdtSerie.Text),
                                       StrToInt(EdtInicio.Text),
                                       StrToInt(EdtFinal.Text));
  // captura retorno
  MemoRetorno.Lines.Text := UTF8Encode(Dm.ACBrNFe1.WebServices.Inutilizacao.RetWS);



end;

end.
