unit untStatusServico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, Buttons, ExtCtrls, pcnConversao;

type
  TfrmStatusServico = class(TForm)
    Panel7: TPanel;
    RetornoWS: TMemo;
    Dados: TMemo;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnVerificar: TBitBtn;
    WebBrowser1: TWebBrowser;
    procedure btnVerificarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatusServico: TfrmStatusServico;

implementation

uses untOpcoes, untDM;

{$R *.dfm}

procedure TfrmStatusServico.btnVerificarClick(Sender: TObject);
begin


   //verifica o certificado
   if DM.sTipoCertificado = '3' then
    begin
      if DM.ACBrNFe1.Configuracoes.Certificados.NumeroSerie = '' then
         DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
    end;


  DM.ACBrNFe1.WebServices.StatusServico.Executar;
  RetornoWS.Lines.Clear;
  RetornoWS.Lines.Text := UTF8Encode(DM.ACBrNFe1.WebServices.StatusServico.RetWS);
  //
  RetornoWS.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+'retornoexe.xml');
  WebBrowser1.Navigate(ExtractFilePath(Application.ExeName)+'retornoexe.xml');
  //
  Dados.Lines.Clear;
  Dados.Lines.Add('Tipo Ambiente: '+ TpAmbToStr(DM.ACBrNFe1.WebServices.StatusServico.tpAmb));
  Dados.Lines.Add('Versão Aplicativo: '+DM.ACBrNFe1.WebServices.StatusServico.verAplic);
  Dados.Lines.Add('Status: '+IntToStr(DM.ACBrNFe1.WebServices.StatusServico.cStat));
  Dados.Lines.Add('Motivo: '+DM.ACBrNFe1.WebServices.StatusServico.xMotivo);
  Dados.Lines.Add('UF'+IntToStr(DM.ACBrNFe1.WebServices.StatusServico.cUF));
  Dados.Lines.Add('Data Hora Recebimento: '+DateTimeToStr(DM.ACBrNFe1.WebServices.StatusServico.dhRecbto));
  Dados.Lines.Add('Data Hora Reterno: '+DateTimeToStr(DM.ACBrNFe1.WebServices.StatusServico.dhRetorno));
  Dados.Lines.Add('Observação: '+DM.ACBrNFe1.WebServices.StatusServico.xObs);


end;


procedure TfrmStatusServico.FormShow(Sender: TObject);
begin
  DM.AtualizaConfigAcBr;
end;

procedure TfrmStatusServico.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
