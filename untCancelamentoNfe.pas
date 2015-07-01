unit untCancelamentoNfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  TfrmCancelamentoNfe = class(TForm)
    GroupBox2: TGroupBox;
    DBGridPedido: TDBGrid;
    dstConsultaPedido: TDataSource;
    editProtocolo: TEdit;
    editJustificativa: TEdit;
    Panel7: TPanel;
    Panel1: TPanel;
    btnFechar: TBitBtn;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure DBGridPedidoColEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    chavenfe :String;
  end;

var
  frmCancelamentoNfe: TfrmCancelamentoNfe;

implementation

uses untDM, DBClient;

{$R *.dfm}

procedure TfrmCancelamentoNfe.FormShow(Sender: TObject);
begin

       DM.AtualizaConfigAcBr;

       DM.cdsConsultaPedido.Close;
       DM.cdsConsultaPedido.CommandText := '';
       DM.cdsConsultaPedido.CommandText := '  select a.nomecliente,                 ' +
                                           '  a.data_inc,                           ' +
                                           '  a.chavenfe,                           ' +
                                           '  a.controlepedido,                     ' +
                                           '  a.totalnota,                          ' +
                                           '  a.status,                             ' +
                                           '  b.nome,                               ' +
                                           '  b.cnpj,                               ' +
                                           '  b.inscrestadual,                      ' +
                                           '  b.endereco,                           ' +
                                           '  b.numero,                             ' +
                                           '  b.complemento,                        ' +
                                           '  b.bairro,                             ' +
                                           '  b.codigoibge,                         ' +
                                           '  b.cidade,                             ' +
                                           '  b.estado,                             ' +
                                           '  b.cep,                                ' +
                                           '  b.telefone,                           ' +
                                           '  a.enderecoentrega,                    ' +
                                           '  a.numeroentrega,                      ' +
                                           '  a.complementoentrega,                 ' +
                                           '  a.bairroentrega,                      ' +
                                           '  a.codigoibgeentrega,                  ' +
                                           '  a.cidadeentrega,                      ' +
                                           '  a.estadoentrega                       ' +
                                           '  from tb_c_vendas a, TB_CLIENTE_FORNECEDOR b   '+
                                           '  where a.controlecliente = b.controlecliente   '+
                                           '  and a.chavenfe > ' + QuotedStr('0')            ;
       DM.cdsConsultaPedido.Open;
end;

procedure TfrmCancelamentoNfe.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCancelamentoNfe.DBGridPedidoColEnter(Sender: TObject);
begin
  chavenfe :=  DM.cdsConsultaPedido.FieldByName('chavenfe').AsString;

end;

procedure TfrmCancelamentoNfe.btnCancelarClick(Sender: TObject);
begin

     if chavenfe = '' then
      begin
        ShowMessage('É necessário selecionar uma Nfe!');
        Abort;
      end;

      if (editProtocolo.Text = '') or (editJustificativa.Text = '') then
       begin
         ShowMessage('É necessário informar o protocolo e Justificativa');
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

      //  Dm.ACBrNFe1.WebServices.Cancelamento.NFeChave      := chavenfe;
      //  Dm.ACBrNFe1.WebServices.Cancelamento.Protocolo     := editProtocolo.Text;
     //   Dm.ACBrNFe1.WebServices.Cancelamento.Justificativa := editJustificativa.Text;
     //   Dm.ACBrNFe1.WebServices.Cancelamento.Executar;
      except
        ShowMessage('Erro ao cancelar NFe. Verifique!');
      end;

end;

end.
