unit untEnviarNfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmEnviarNfe = class(TForm)
    Panel7: TPanel;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnEnviar: TBitBtn;
    GroupBox1: TGroupBox;
    btnBuscarXml: TSpeedButton;
    editArquivo: TEdit;
    OpenDialog1: TOpenDialog;
    EdtNumLote: TEdit;
    Label1: TLabel;
    EdtPedido: TEdit;
    Label2: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editArquivoExit(Sender: TObject);
    procedure btnBuscarXmlClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnviarNfe: TfrmEnviarNfe;

implementation

uses untDM;

{$R *.dfm}


function FiltraNumero(fAux:String):string;
var i:Integer;
begin
  Result := '';
  for i:=1 to length(fAux) do
  begin
    if (Copy(fAux,i,1) = '1') or
       (Copy(fAux,i,1) = '2') or
       (Copy(fAux,i,1) = '3') or
       (Copy(fAux,i,1) = '4') or
       (Copy(fAux,i,1) = '5') or
       (Copy(fAux,i,1) = '6') or
       (Copy(fAux,i,1) = '7') or
       (Copy(fAux,i,1) = '8') or
       (Copy(fAux,i,1) = '9') or
       (Copy(fAux,i,1) = '0') then
     begin
       Result := Result + Copy(fAux,i,1);
     end;
  end;
end;

procedure TfrmEnviarNfe.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmEnviarNfe.FormShow(Sender: TObject);
begin
    DM.AtualizaConfigAcBr;
    editArquivo.SetFocus;
end;

procedure TfrmEnviarNfe.editArquivoExit(Sender: TObject);
begin
 if editArquivo.Text = '' then
   btnBuscarXmlClick(Sender);
end;

procedure TfrmEnviarNfe.btnBuscarXmlClick(Sender: TObject);
begin
   OpenDialog1.Execute;
   editArquivo.Text := OpenDialog1.FileName;
end;

procedure TfrmEnviarNfe.btnEnviarClick(Sender: TObject);
  var aChaveNfe, aRecibo, aProcolo : String;
begin
  //
  if editArquivo.Text = '' then
  begin
    ShowMessage('É necessário selecionar o arquivo XML');
    Abort;
  end;
  EdtNumLote.Text := FiltraNumero(EdtNumLote.Text);
  if Trim(EdtNumLote.Text) = '' then
  begin
    ShowMessage('É necessário informar o numero do lote!');
    Abort;
  end;
  //
  try

   //verifica o certificado
   if DM.sTipoCertificado = '3' then
    begin
      if DM.ACBrNFe1.Configuracoes.Certificados.NumeroSerie = '' then
         DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
    end;
    
    Dm.ACBrNFe1.NotasFiscais.Clear;
    Dm.ACBrNFe1.NotasFiscais.LoadFromFile(editArquivo.Text);
    Dm.ACBrNFe1.Enviar(EdtNumLote.Text);
    //
    aChaveNfe := Dm.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;
    aProcolo  := Dm.ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt;
    aRecibo   := Dm.ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec;
    // grava chave NFe
    if aChaveNfe <> '' then
    begin
      Dm.GravaChaveNFEPedido(aChaveNfe,EdtPedido.Text);

    end;
   except
     ShowMessage('Erro ao enviar a NFe.Verifique!!!');
   end;


end;

end.
