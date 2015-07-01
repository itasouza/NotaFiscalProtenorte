unit untImpressaoDanfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,pcnConversao;

type
  TfrmImpressaoDanfe = class(TForm)
    Panel7: TPanel;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnEnviar: TBitBtn;
    GroupBox1: TGroupBox;
    sbBuscarArquivo: TSpeedButton;
    EdtArquivo: TEdit;
    OpenDialog1: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure sbBuscarArquivoClick(Sender: TObject);
    procedure EdtArquivoExit(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImpressaoDanfe: TfrmImpressaoDanfe;

implementation

uses untDM;

{$R *.dfm}

procedure TfrmImpressaoDanfe.FormShow(Sender: TObject);
begin
   Dm.AtualizaConfigAcBr;
   EdtArquivo.SetFocus;

end;

procedure TfrmImpressaoDanfe.sbBuscarArquivoClick(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdtArquivo.Text := OpenDialog1.FileName;
end;

procedure TfrmImpressaoDanfe.EdtArquivoExit(Sender: TObject);
begin
  if EdtArquivo.Text = '' then
     sbBuscarArquivoClick(Sender);

end;

procedure TfrmImpressaoDanfe.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImpressaoDanfe.btnEnviarClick(Sender: TObject);
begin
  if EdtArquivo.Text = '' then
  begin
    ShowMessage('É necessário selecionar o arquivo XML!');
    Abort;
  end;

   //verifica o certificado
   if DM.sTipoCertificado = '3' then
    begin
      if DM.ACBrNFe1.Configuracoes.Certificados.NumeroSerie = '' then
         DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
    end;
    
    Dm.ACBrNFe1.NotasFiscais.Clear;
    Dm.ACBrNFe1.NotasFiscais.LoadFromFile(EdtArquivo.Text);
  if Dm.ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
  begin
    Dm.ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := Dm.ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
    Dm.ACBrNFe1.WebServices.ConsultaDPEC.Executar;
    //
    Dm.ACBrNFe1.DANFE.ProtocoloNFe := Dm.ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC + ''+
                                      DateTimeToStr(Dm.ACBrNFe1.WebServices.ConsultaDPEC.dhRegDPEC);
  end;
  Dm.ACBrNFe1.NotasFiscais.Imprimir;

end;



end.
