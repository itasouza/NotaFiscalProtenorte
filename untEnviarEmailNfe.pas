unit untEnviarEmailNfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmEnviarEmailNfe = class(TForm)
    Panel7: TPanel;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnEnviar: TBitBtn;
    GroupBox1: TGroupBox;
    sbBuscarArquivo: TSpeedButton;
    EdtArquivo: TEdit;
    lbEndereco: TLabel;
    OpenDialog1: TOpenDialog;
    lbEmailCliente: TLabel;
    editDestino: TEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure sbBuscarArquivoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnviarEmailNfe: TfrmEnviarEmailNfe;

implementation

uses untDM;

{$R *.dfm}

procedure TfrmEnviarEmailNfe.FormShow(Sender: TObject);
begin
  DM.AtualizaConfigAcBr;
  lbEndereco.Caption := 'Email do Emissor:' + dm.sUsuarioSMTP;
  lbEmailCliente.Caption := 'Email do Destinatário :' + sEmailClienteEnvioNfe;
end;

procedure TfrmEnviarEmailNfe.sbBuscarArquivoClick(Sender: TObject);
begin
   OpenDialog1.Execute;
   EdtArquivo.Text := OpenDialog1.FileName;
end;

procedure TfrmEnviarEmailNfe.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEnviarEmailNfe.btnEnviarClick(Sender: TObject);
  var
    Endereco,Mensagem : TStrings;
    Emitente :String;
begin
 if EdtArquivo.Text = '' then
  begin
    ShowMessage('É necessário selecionar o arquivo XML');
    Abort;
  end;
  //
  Emitente := 'protenorte@protenorte.com.br';

  Mensagem := TStrings.Create;
  Mensagem.Add('NFe'); 
  Endereco := TStrings.Create;
  Endereco.Add(sEmailClienteEnvioNfe);


   //verifica o certificado
   if DM.sTipoCertificado = '3' then
    begin
      if DM.ACBrNFe1.Configuracoes.Certificados.NumeroSerie = '' then
         DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
    end;
    
  DM.ACBrNFe1.NotasFiscais.Clear;
  DM.ACBrNFe1.NotasFiscais.LoadFromFile(EdtArquivo.Text);

  
  //enviar email
  Dm.ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(Dm.sHostSMTP,
                                                Dm.sPortaSMTP,
                                                Dm.sUsuarioSMTP,
                                                Dm.sSenhaSMTP,
                                                Emitente,
                                                editDestino.Text, //DM.sEmailClienteEnvioNfe,
                                                'NFe',
                                                Mensagem,
                                                true,
                                                true,
                                                Endereco,
                                                nil,
                                                false,
                                                true,
                                                'Nome do remetente');


  FreeAndNil(Endereco);
  FreeAndNil(Mensagem);
  
end;

end.
