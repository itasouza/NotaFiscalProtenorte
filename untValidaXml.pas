unit untValidaXml;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmValidaXml = class(TForm)
    Panel7: TPanel;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnVerificar: TBitBtn;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    editArquivo: TEdit;
    btnBuscarXml: TSpeedButton;
    procedure btnBuscarXmlClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnVerificarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editArquivoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmValidaXml: TfrmValidaXml;

implementation

uses untDM;

{$R *.dfm}

procedure TfrmValidaXml.btnBuscarXmlClick(Sender: TObject);
begin
  OpenDialog1.Execute;
  editArquivo.Text := OpenDialog1.FileName;
end;

procedure TfrmValidaXml.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmValidaXml.btnVerificarClick(Sender: TObject);
begin
    if editArquivo.Text = '' then
     begin
       ShowMessage('É necessário selecionar o arquivo!');
       Abort;
     end;

     //executa a validação do arquivo
     try
     //verifica o certificado
      if DM.sTipoCertificado = '3' then
       begin
        if DM.ACBrNFe1.Configuracoes.Certificados.NumeroSerie = '' then
           DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
       end;

       DM.ACBrNFe1.NotasFiscais.Clear;
       DM.ACBrNFe1.NotasFiscais.LoadFromFile(editArquivo.Text);
       DM.ACBrNFe1.NotasFiscais.Valida;
     finally
       ShowMessage('Arquivo validado com sucesso');
     end;
end;

procedure TfrmValidaXml.FormShow(Sender: TObject);
begin
   DM.AtualizaConfigAcBr;
   editArquivo.SetFocus;
end;

procedure TfrmValidaXml.editArquivoExit(Sender: TObject);
begin
 if editArquivo.Text = '' then
   btnBuscarXmlClick(Sender);
end;

end.
