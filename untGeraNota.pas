unit untGeraNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ExtCtrls, Grids, DBGrids, pcnConversao;

type
  TfrmGeraNota = class(TForm)
    Panel7: TPanel;
    dstConsultaPedido: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    editNumeroPedido: TEdit;
    Label1: TLabel;
    btnLocalizar: TBitBtn;
    btnfechar: TBitBtn;
    DBGridPedido: TDBGrid;
    btnGerarFNe: TBitBtn;
    procedure editNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnfecharClick(Sender: TObject);
    procedure anum(Sender: TObject);
    procedure DBGridPedidoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnGerarFNeClick(Sender: TObject);
    procedure DBGridPedidoCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure editQtdVolumeKeyPress(Sender: TObject; var Key: Char);
    procedure editPesoBrutoKeyPress(Sender: TObject; var Key: Char);
    procedure MudarComEnter(var Msg: TMsg; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure editPesoLiquidoKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridPedidoDblClick(Sender: TObject);

  private
    { Private declarations }
    ControlePedido :Integer;
    ControleTransportadora :String;


  public
    { Public declarations }
     function VirgulaPorPonto(str: String): String;
  end;

var
  frmGeraNota: TfrmGeraNota;

implementation

uses untDM, untOpcoes, pcnNFe, DateUtils, untEnviarEmailNfe;

{$R *.dfm}


function TfrmGeraNota.VirgulaPorPonto(str: String): String;
var
  I: Integer;
Begin
  for I := 0 to Length(str) do
   If str[I] = ',' then
    str[I] := '.';

  Result := Str;
end;



function PegaNumeroEstado(UF: String): String;
begin
 If (UF='RO')      Then Result := '11'
  Else If (UF='AC') Then Result := '12'
  Else If (UF='AM') Then Result := '13'
  Else If (UF='RR') Then Result := '14'
  Else If (UF='PA') Then Result := '15'
  Else If (UF='AP') Then Result := '16'
  Else If (UF='TO') Then Result := '17'
  Else If (UF='MA') Then Result := '21'
  Else If (UF='PI') Then Result := '22'
  Else If (UF='CE') Then Result := '23'
  Else If (UF='RN') Then Result := '24'
  Else If (UF='PB') Then Result := '25'
  Else If (UF='PE') Then Result := '26'
  Else If (UF='AL') Then Result := '27'
  Else If (UF='SE') Then Result := '28'
  Else If (UF='BA') Then Result := '29'
  Else If (UF='MG') Then Result := '31'
  Else If (UF='ES') Then Result := '32'
  Else If (UF='RJ') Then Result := '33'
  Else If (UF='SP') Then Result := '35'
  Else If (UF='PR') Then Result := '41'
  Else If (UF='SC') Then Result := '42'
  Else If (UF='RS') Then Result := '43'
  Else If (UF='MS') Then Result := '50'
  Else If (UF='MT') Then Result := '51'
  Else If (UF='GO') Then Result := '52'
  Else If (UF='DF') Then Result := '53'
  Else
    Raise Exception.Create('UF "'+UF+'" não disponível para NF-e');
end;


function LimparCaracteres(texto: string): string;
var
  i: Integer;
  TextoSemCaracteres: string;
begin
  for i := Length(texto) downto 1 do
     if not (texto[i] in [',',':','.','-','/','"','''']) then
        TextoSemCaracteres := texto[i] + TextoSemCaracteres;
  Result := TextoSemCaracteres;
end;


procedure TfrmGeraNota.editNumeroPedidoKeyPress(Sender: TObject;
  var Key: Char);
begin
 if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
   key := #0;
end;

procedure TfrmGeraNota.btnfecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGeraNota.anum(Sender: TObject);
begin
  if editNumeroPedido.Text <> '' then
   begin

       DM.cdsConsultaPedido.Close;
       DM.cdsConsultaPedido.CommandText := '';
       DM.cdsConsultaPedido.CommandText :=

        ' select b.observacao as ObsCliente, b.tipodecliente as TipoCliente, a.*, b.*, a.codigocliente as CodCliente, c.descricao as DescMovimento,c.tipoentadasaida '+
        ' from tb_c_vendas a                                                                              '+
        ' inner join TB_CLIENTE_FORNECEDOR b  on a.controlecliente = b.controlecliente                      '+
        ' inner join TB_TIPO_MOVIMENTO c   on a.controletipomovimento = c.controletipomovimento  '+
        ' where a.tipooperacao =  ''V''                                                          '+
        ' and a.numeronota = ' + QuotedStr(editNumeroPedido.Text);

       DM.cdsConsultaPedido.Open;
       DBGridPedido.SetFocus;
   end;

end;

procedure TfrmGeraNota.DBGridPedidoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if Column.Index = 4 then
    begin
     if DM.cdsConsultaPedido.FieldByName('status').AsString  = 'A' then
      begin
       DBGridPedido.Canvas.FillRect(Rect);
       frmOpcoes.ImageList1.Draw(DBGridPedido.Canvas, Rect.Left + 5, Rect.Top + 1, 3);
      end;
     if DM.cdsConsultaPedido.FieldByName('status').AsString  = 'C' then
      begin
       DBGridPedido.Canvas.FillRect(Rect);
       frmOpcoes.ImageList1.Draw(DBGridPedido.Canvas, Rect.Left + 5, Rect.Top + 1, 2);
      end;

     if DM.cdsConsultaPedido.FieldByName('status').AsString  = 'I' then
      begin
       DBGridPedido.Canvas.FillRect(Rect);
       frmOpcoes.ImageList1.Draw(DBGridPedido.Canvas, Rect.Left + 5, Rect.Top + 1, 1);
      end;

     if DM.cdsConsultaPedido.FieldByName('status').AsString  = '' then
      begin
       DBGridPedido.Canvas.FillRect(Rect);
       frmOpcoes.ImageList1.Draw(DBGridPedido.Canvas, Rect.Left + 5, Rect.Top + 1, 0);
      end;

    end;
end;



procedure TfrmGeraNota.btnGerarFNeClick(Sender: TObject);
 var
    aNumIten : Integer;
    ValorTotalImposto :Double;
    ValorTotalIcms    :Double;
    ValorTotalPis     :Double;
    ValorTotalCofins  :Double;
    recebeCep : String;
    Endereco,Mensagem : TStringList;
    NfeConsRev :String;
    //
    listaArquivo,slItens, slDados :TStringList;
    QtdLinhasTotal,y, K :Integer;
    sLinha :string;
    //

   arquivoOrigem :TextFile;
   arquivoNovo   :TextFile;
   varnovo, varantigo, linha   :String;
   ObservacaoNota :String;


begin

  if ControlePedido = 0 then
   begin
      MessageDlg('É necessário selecionar o pedido', mtWarning, [mbOK],0);
      Abort;
   end;

   //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
     //verificar se tem o cliente e se tem itens para a nota
   if DM.cdsConsultaPedido.RecordCount = 0 then
    begin
      MessageDlg('Não foi encontrado nada para ser gerado', mtWarning, [mbOK],0);
      Abort;
    end;


   //verificar se tem o cliente e se tem itens para a nota
   if DM.cdsConsultaPedido.FieldByName('codigoibge').AsString = ''  then
    begin
      MessageDlg('Não foi encontrado o código do IBGE para o cliente', mtWarning, [mbOK],0);
      Abort;
    end;

   {
   //verifica o certificado
   if DM.sTipoCertificado = '3' then
    begin
      if DM.ACBrNFe1.Configuracoes.Certificados.NumeroSerie = '' then
         DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
    end;
    }


   DM.ACBrNFe1.NotasFiscais.Clear;
   //
   with DM.ACBrNFe1.NotasFiscais.Add.NFe do
    begin
        //dados básicos da nota ************************************************************************************
       // Ide.cNF                 :=  StrToInt(DM.cdsConsultaPedido.FieldByName('controlepedido').AsString);   // número do pedido
        Ide.natOp               := DM.cdsConsultaPedido.FieldByName('DescMovimento').AsString; //natureza de operação //ITAMAR ALTERA



        if DM.cdsConsultaPedido.FieldByName('TipoCliente').AsString = 'C' then
            Ide.indFinal := cfConsumidorFinal
        else
            Ide.indFinal := cfNao;

        if DM.cdsConsultaPedido.FieldByName('controlepagamento').AsString = '1' then
            Ide.indPag             := ipVista //forma de pagamento
        else
           Ide.indPag              := ipPrazo; //forma de pagamento

        Ide.modelo              := 55; //modelo da nota
        Ide.serie               := 1;  //série da nota
        Ide.nNF                 := StrToInt(DM.cdsConsultaPedido.FieldByName('numeronota').AsString); //número do pedido
        Ide.dEmi                := Date;   // data de emissão
        Ide.dSaiEnt             := Date;   // data de saida
        Ide.hSaiEnt             := Time;   // hora de saida ou entrada
        Ide.indPres             := pcOutros;

        if  DM.cdsConsultaPedido.FieldByName('estado').AsString = 'SP' then
             Ide.idDest              := doInterna
        else
             Ide.idDest              := doInterestadual;


        //verifica na tabela de tb_tipo_movimento se é uma nota de entrada ou saida

        if (DM.cdsConsultaPedido.FieldByName('tipoentadasaida').AsString = 'S' ) then
           Ide.tpNF  := tnSaida                                // indica se é uma nota de entrada ou saida
         else
          Ide.tpNF   := tnEntrada;                             // indica se é uma nota de entrada ou saida


       if DM.sAmbiente = 0 then
          Ide.tpAmb  := taProducao                             // verifica se esta em modo de produção ou homologação
       else
          Ide.tpAmb  := taHomologacao;

        Ide.verProc  := '3.10.61';                             // versão do aplicativo
        Ide.cUF      := StrToInt(PegaNumeroEstado(DM.sUF));    // uf do emitente
        Ide.cMunFG   := StrToInt(DM.sCodMun);                  // código do munícipio

        //verifica se é uma nota de fnalizade para normal ou devolução etc

        Ide.finNFe   := fnNormal;                             // situação da finalidade (normal. complementar, ajuste, devolução)


       //emitente vem da tela de configuração ******************************************************************

       if DM.sRegime = 0 then
          Emit.CRT              := crtSimplesNacional //   crt - código de regime tributário
       else
         if DM.sRegime = 1 then
            Emit.CRT            := crtRegimeNormal
       else
         if DM.sRegime = 2 then
            Emit.CRT            := crtSimplesExcessoReceita;

        Emit.CNPJCPF            := DM.sCNPJ;  //cnpj da empresa
        Emit.IE                 := DM.sIE;    // ie da empresa
        Emit.IEST               := '';
        Emit.xNome              := DM.sRazao; // nome do emitente
        Emit.xFant              := DM.sFantasia; // nome fantasia
        Emit.IM                 := ''; // inscrição municipal
        Emit.CNAE               := ''; // adicionar cnae
        Emit.EnderEmit.xLgr     := DM.sEndereco;  // endereço do emitente
        Emit.EnderEmit.nro      := DM.sNum;       // número do endereço
        Emit.EnderEmit.xCpl     := ''; // complemente de endereço
        Emit.EnderEmit.xBairro  := DM.sBairro; // bairro
        Emit.EnderEmit.cMun     := StrToInt(DM.sCodMun); // código do munícipio
        Emit.EnderEmit.xMun     := DM.sCidade; // nome da cidade
        Emit.EnderEmit.UF       := DM.sUF;    // uf
        Emit.EnderEmit.CEP      := StrToInt(LimparCaracteres(DM.sCEP));   //cep do emitente
        Emit.EnderEmit.fone     := DM.sTelefone;  // telefone do emitente
        Emit.EnderEmit.cPais    := 1058; // código do brasil
        Emit.EnderEmit.xPais    := 'BRASIL'; //nome pais

        //destinatário, vem da consulta feita na pesquisa ******************************************************
        Dest.CNPJCPF           := DM.cdsConsultaPedido.FieldByName('cnpj').AsString;  // cnpj do destino
        Dest.IE                := DM.cdsConsultaPedido.FieldByName('inscrestadual').AsString;   // ie do destino
        Dest.ISUF              := '';
        Dest.xNome             := DM.cdsConsultaPedido.FieldByName('nome').AsString + ' -  ' + ' Cód. ' + DM.cdsConsultaPedido.FieldByName('CodCliente').AsString  ;       // nome
        Dest.EnderDest.xLgr    := DM.cdsConsultaPedido.FieldByName('endereco').AsString;         //endereço
        Dest.EnderDest.nro     := DM.cdsConsultaPedido.FieldByName('numero').AsString;      // numero do destino
        Dest.EnderDest.xCpl    := DM.cdsConsultaPedido.FieldByName('complemento').AsString;  // complemento
        Dest.EnderDest.xBairro := DM.cdsConsultaPedido.FieldByName('bairro').AsString;      // bairro
        Dest.EnderDest.cMun    := DM.cdsConsultaPedido.FieldByName('codigoibge').AsInteger;  //codigo do ibge
        Dest.EnderDest.xMun    := DM.cdsConsultaPedido.FieldByName('cidade').AsString;       // cidade
        Dest.EnderDest.UF      := DM.cdsConsultaPedido.FieldByName('estado').AsString;       // uf do destino
        recebeCep              := Trim(LimparCaracteres(DM.cdsConsultaPedido.FieldByName('cep').AsString));
        Dest.EnderDest.CEP     := StrToInt(recebeCep); // cep do destino
        Dest.EnderDest.cPais   := 1058;    // código do pais
        Dest.EnderDest.xPais   := 'BRASIL';     // nome do pais
        Dest.EnderDest.fone    := DM.cdsConsultaPedido.FieldByName('telefone').AsString;  // telefone do destino



        // Entrega *********************************************************************************************
        
//       Entrega.xLgr    := DM.cdsConsultaPedido.FieldByName('enderecoentrega').AsString; // enderreço da entrega
//       Entrega.nro     := DM.cdsConsultaPedido.FieldByName('numeroentrega').AsString;    // número da entrega
//       Entrega.xCpl    := DM.cdsConsultaPedido.FieldByName('complementoentrega').AsString; // complemento do endereço
//       Entrega.xBairro := DM.cdsConsultaPedido.FieldByName('bairroentrega').AsString;      // bairro da entrega
//       Entrega.cMun    := DM.cdsConsultaPedido.FieldByName('codigoibgeentrega').AsInteger;  // código ibge entrega
//       Entrega.xMun    := DM.cdsConsultaPedido.FieldByName('cidadeentrega').AsString;   // cidade de entrega
//       Entrega.UF      := DM.cdsConsultaPedido.FieldByName('estadoentrega').AsString;   // Uf do estado

// Vinicius comentou, pois não temos estes campos na tabela

           //busca os itens da nota  *******************************************************************************
           DM.cdsDetalheVenda.Close;
           DM.cdsDetalheVenda.CommandText := '';

           DM.cdsDetalheVenda.CommandText :=  '  select a.descricaoproduto as NomeProduto, a.*, b.*, c.*,d.*             '+
                  ' from  tb_d_vendas a                                               '+
                  ' inner join TB_PRODUTO b on a.controleproduto = b.controleproduto  '+
                  ' inner join TB_C_VENDAS c  on c.controle = a.controle              '+
                  ' inner join TB_EMPRESA  d on d.controleempresa = c.controleempresa '+
                  ' where  a.controle = ' +  QuotedStr(IntToStr(ControlePedido));


           DM.cdsDetalheVenda.Open;

          if DM.cdsDetalheVenda.RecordCount = 0 then
           begin
              MessageDlg('Não existem itens para esta nota!!', mtWarning, [mbOK],0);
              Abort;
           end;
           //itens da nota   (video aula 9)

        aNumIten := 0;
        ValorTotalImposto := 0;
        DM.cdsDetalheVenda.First;
        while not DM.cdsDetalheVenda.Eof do
        begin
              Inc(aNumIten);
              // detalhes do itens
              with Det.Add do
              begin
                // (H)
                Prod.nItem  := aNumIten;

                Prod.cProd    := DM.cdsDetalheVenda.FieldByName('codigocomercial').AsString;     // controle comercial do produto
                Prod.cEAN     := DM.cdsDetalheVenda.FieldByName('codigobarras').AsString;        // código barras do produto
                Prod.xProd    := DM.cdsDetalheVenda.FieldByName('NomeProduto').AsString;         // descrição do produto
                Prod.NCM      := DM.cdsDetalheVenda.FieldByName('codigoncm').AsString;           // ncm do produto
                Prod.CFOP     := DM.cdsDetalheVenda.FieldByName('cfop').AsString;                // naturaza de operação
                Prod.uCom     := DM.cdsDetalheVenda.FieldByName('descricaounidade').AsString;    // unidade do produto
                Prod.qCom     := DM.cdsDetalheVenda.FieldByName('quantidade').Value;             // quantidade comercial produto enviado  C
                Prod.vUnCom   := DM.cdsDetalheVenda.FieldByName('valorunitarioproduto').AsFloat; // valor unitário do produto
                Prod.vProd    := DM.cdsDetalheVenda.FieldByName('valortotalproduto').AsFloat;    // valor total do produto
                Prod.cEANTrib := '';
                Prod.uTrib    := DM.cdsDetalheVenda.FieldByName('descricaounidade').AsString;    // unidade do produto
                Prod.qTrib    := DM.cdsDetalheVenda.FieldByName('quantidade').Value;             // quantidade tributada produto enviado  C
                Prod.vUnTrib  := DM.cdsDetalheVenda.FieldByName('valorunitarioproduto').AsFloat; // valor unitário do produto
                //Prod.IndTot   := '1';
                Prod.qTrib    := DM.cdsDetalheVenda.FieldByName('quantidade').Value;

               if aNumIten = 1 then
                begin
                  Prod.vFrete   := DM.cdsDetalheVenda.FieldByName('valorfrete').Value;          // Valor do Frete
                  Prod.vDesc    := DM.cdsDetalheVenda.FieldByName('valordesconto').AsFloat;     //(verificar o desconto estar por intem)
                end;

               // Prod.vFrete   := DM.cdsDetalheVenda.FieldByName('valorfrete').Value;
                Prod.vSeg     := 0;
               // Prod.vDesc    := DM.cdsDetalheVenda.FieldByName('valordesconto').AsFloat;  //(verificar o desconto estar por intem)

                //..........................................................................................
                //nova alteração 11/06/2013
                //..........................................................................................

                //consulta o ncm da tabela IBPT
                DM.cdsConsultaIBPT.Close;
                DM.cdsConsultaIBPT.CommandText := '';
                DM.cdsConsultaIBPT.CommandText := 'select * from TB_TABELAIBPT_novo where codigo =' + QuotedStr(Prod.NCM) ;
                DM.cdsConsultaIBPT.Open;

                //valor total do item
                ValorTotalImposto := ValorTotalImposto + ( (Prod.vProd ) * DM.cdsConsultaIBPT.FieldByName('ALIQNAC').AsFloat);

                //..........................................................................................
                //nova alteração 11/06/2013
                //..........................................................................................

                //imposto do produto   (video aula 10)
                Imposto.vTotTrib := ValorTotalImposto;

                with Imposto do
                begin
                  with ICMS do
                  begin

                      if DM.cdsDetalheVenda.FieldByName('cst').AsString = '000' then // 0 - Tributado    (revisar)
                      begin
                        vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQNAC').AsFloat ;
                        CSOSN         := csosn101; // {verificar }
                        ICMS.orig     := oeNacional;
                        ICMS.modBC    := dbiValorOperacao;
                        ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                        ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                        ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                        ICMS.modBCST  := dbisMargemValorAgregado;
                        ICMS.pMVAST   := 0;
                        ICMS.pRedBCST := 0;
                        ICMS.vBCST    := 0;
                        ICMS.pICMSST  := 0;
                        ICMS.vICMSST  := 0;
                        ICMS.pRedBC   := 0;
                        IPI.cEnq      := '999';

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst00;
                         end;

                        IPI.CST       := ipi53;
                        PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                        PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                        PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                        COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                        COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                        COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                        ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                        ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                        ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;

                     end;


                     if DM.cdsDetalheVenda.FieldByName('cst').AsString = '040' then //
                      begin
                        vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQNAC').AsFloat ;
                        CSOSN         := csosn101; // {verificar }
                        ICMS.orig     := oeNacional;
                        ICMS.modBC    := dbiValorOperacao;
                        ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                        ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                        ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                        ICMS.modBCST  := dbisMargemValorAgregado;
                        ICMS.pMVAST   := 0;
                        ICMS.pRedBCST := 0;
                        ICMS.vBCST    := 0;
                        ICMS.pICMSST  := 0;
                        ICMS.vICMSST  := 0;
                        ICMS.pRedBC   := 0;
                        IPI.cEnq      := '999';

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst40;
                         end;

                        IPI.CST       := ipi53;
                        PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                        PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                        PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                        COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                        COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                        COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                        ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                        ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                        ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;

                     end;



                      if DM.cdsDetalheVenda.FieldByName('cst').AsString = '060' then // 3 - Sub. Tributaria   (revisar)
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQNAC').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacional;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst60;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;

                      end;

                      if DM.cdsDetalheVenda.FieldByName('cst').AsString = '200' then // 4 - importado adquirido no mercado interno
                      begin
                          vTotTrib      := (Prod.vProd ) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeEstrangeiraAdquiridaBrasil;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst00;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;

                      end;


                       if DM.cdsDetalheVenda.FieldByName('cst').AsString = '240' then // 4 - importado
                      begin
                          vTotTrib      := (Prod.vProd ) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeEstrangeiraAdquiridaBrasil;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst40;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;

                      end;


                    if DM.cdsDetalheVenda.FieldByName('cst').AsString = '260' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeEstrangeiraAdquiridaBrasil;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst60;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;

                      if DM.cdsDetalheVenda.FieldByName('cst').AsString = '300' then // 3 - importado
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoSuperior40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst00;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;

                    if DM.cdsDetalheVenda.FieldByName('cst').AsString = '340' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoSuperior40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst40;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;


                       if DM.cdsDetalheVenda.FieldByName('cst').AsString = '360' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoSuperior40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst60;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;


                     if DM.cdsDetalheVenda.FieldByName('cst').AsString = '400' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoSuperior40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst00;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;


                      if DM.cdsDetalheVenda.FieldByName('cst').AsString = '440' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd ) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoSuperior40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst40;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;


                       if DM.cdsDetalheVenda.FieldByName('cst').AsString = '460' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoSuperior40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst60;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;

                    if DM.cdsDetalheVenda.FieldByName('cst').AsString = '500' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd ) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoInferiorIgual40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst00;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;

                 if DM.cdsDetalheVenda.FieldByName('cst').AsString = '540' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoInferiorIgual40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst40;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;


                    if DM.cdsDetalheVenda.FieldByName('cst').AsString = '560' then // 3 - importado com sub. tribut.  (revisar)
                      begin
                          vTotTrib      := (Prod.vProd ) * DM.cdsConsultaIBPT.FieldByName('ALIQIMP').AsFloat ;
                          CSOSN         := csosn101; // {verificar }
                          ICMS.orig     := oeNacionalConteudoImportacaoInferiorIgual40;
                          ICMS.modBC    := dbiValorOperacao;
                          ICMS.vBC      := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsbase').AsString,0); //valor total do produto
                          ICMS.pICMS    := DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;  //aliquota do icms
                          ICMS.vICMS    := StrToFloatDef(DM.cdsDetalheVenda.FieldByName('icmsvalor').AsString,0);  //valor do icms
                          ICMS.modBCST  := dbisMargemValorAgregado;
                          ICMS.pMVAST   := 0;
                          ICMS.pRedBCST := 0;
                          ICMS.vBCST    := 0;
                          ICMS.pICMSST  := 0;
                          ICMS.vICMSST  := 0;
                          ICMS.pRedBC   := 0;
                          IPI.cEnq      := '999';

                         if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) = '6502' then
                         begin
                           PIS.CST       := pis07;
                           COFINS.CST    := cof07;
                           CST           := cst41;
                         end;

                        if Trim(DM.cdsDetalheVenda.FieldByName('cfop').AsString) <> '6502' then
                         begin
                           PIS.CST       := pis01;
                           COFINS.CST    := cof01;
                           CST           := cst60;
                         end;

                          IPI.CST       := ipi53;
                          PIS.vBC       := DM.cdsDetalheVenda.FieldByName('basepis').AsFloat;  //valor da base do pis
                          PIS.pPIS      := DM.cdsDetalheVenda.FieldByName('pis').AsFloat;  //aliquota do pis
                          PIS.vPIS      := DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;  //valor do pis
                          COFINS.vBC    := DM.cdsDetalheVenda.FieldByName('basecofins').AsFloat;  //valor da base do cofins
                          COFINS.pCOFINS:= DM.cdsDetalheVenda.FieldByName('cofins').AsFloat;  //aliquota do cofins
                          COFINS.vCOFINS:= DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;  //valor do cofins
                          ValorTotalIcms:= ValorTotalIcms + DM.cdsDetalheVenda.FieldByName('icmsvalor').AsFloat;
                          ValorTotalPis := ValorTotalPis + DM.cdsDetalheVenda.FieldByName('valorpis').AsFloat;
                          ValorTotalCofins := ValorTotalCofins + DM.cdsDetalheVenda.FieldByName('valorcofins').AsFloat;
                      end;


                  end;
                  if (DM.cdsDetalheVenda.FieldByName('cst').AsString  = '001') or // 1 - Isento
                     (DM.cdsDetalheVenda.FieldByName('cst').AsString  = '002' ) then // 2 - Não tributado
                  begin
                    with II do
                      begin
                        vBc      := 0;
                        vDespAdu := 0;
                        vII      := DM.cdsDetalheVenda.FieldByName('totalnotaprodutos').AsFloat;
                        vIOF     := 0;
                      end;
                  end;
                  if DM.cdsDetalheVenda.FieldByName('cst').AsString  = '004'  then // 4 - Serviço
                    begin
                    with ISSQN do
                      begin
                          vBC        :=  DM.cdsDetalheVenda.FieldByName('totalnotaprodutos').AsFloat;
                          vAliq      :=  DM.cdsDetalheVenda.FieldByName('aliquotaicms').AsFloat;
                          vISSQN     := (DM.cdsDetalheVenda.FieldByName('totalnotaprodutos').AsFloat * DM.cdsDetalheVenda.FieldByName('cIcmsBase').AsFloat) / 100;
                          cMunFG     := 0;
                          cListServ  := '';
                      end;
                  end;
              end;
              DM.cdsDetalheVenda.Next;

            end;
       end;

          //informações finais da nfe  (video aula 11)
          // W - totais da nota
          Total.ICMSTot.vBC      :=  DM.cdsConsultaPedido.FieldByName('icmsbase').AsFloat;   // total da base de calculo
          Total.ICMSTot.vICMS    :=  ValorTotalIcms;   // total da base de calculo icms
          Total.ICMSTot.vBCST    :=  DM.cdsDetalheVenda.FieldByName('stvalor').AsFloat;   // total da base de calculo st
          Total.ICMSTot.vST      :=  (DM.cdsDetalheVenda.FieldByName('stvalor').AsFloat * DM.cdsDetalheVenda.FieldByName('icmsbase').AsFloat) / 100;   // valor st
          Total.ICMSTot.vProd    :=  DM.cdsDetalheVenda.FieldByName('totalnotaprodutos').AsFloat; // valor total da nota
          Total.ICMSTot.vFrete   :=  DM.cdsDetalheVenda.FieldByName('valorfrete').AsFloat; // valor do frete
          Total.ICMSTot.vSeg     :=  0; // valor do seguro
          Total.ICMSTot.vDesc    :=  DM.cdsDetalheVenda.FieldByName('valordesconto').AsFloat;  // valor desconto
          Total.ICMSTot.vII      :=  0;
          Total.ICMSTot.vIPI     :=  0;  // valor total IPI
          Total.ICMSTot.vPIS     :=  ValorTotalPis;;  // valor total PIS
          Total.ICMSTot.vCOFINS  :=  ValorTotalCofins;  // valor total Cofins
          Total.ICMSTot.vOutro   :=  0;
          Total.ICMSTot.vTotTrib :=  ValorTotalImposto;
          Total.ICMSTot.vNF      :=  DM.cdsDetalheVenda.FieldByName('totalnotaprodutos').AsFloat - DM.cdsDetalheVenda.FieldByName('valordesconto').AsFloat; // valor total da nota


          //dados de serviços  ******************************************************************************
          Total.ISSQNtot.vServ     := 0;
          Total.ISSQNtot.vBC       := 0;
          Total.ISSQNtot.vISS      := 0;
          Total.ISSQNtot.vPIS      := 0;
          Total.ISSQNtot.vCOFINS   := 0;

          //
          Total.retTrib.vRetPIS     := 0;
          Total.retTrib.vRetCOFINS  := 0;
          Total.retTrib.vBCIRRF     := 0;
          Total.retTrib.vIRRF       := 0;
          Total.retTrib.vRetPrev    := 0;

          //consulta a transportadora para a nota
          DM.cdsConsultaTransportadora.Close;
          DM.cdsConsultaTransportadora.CommandText := '';
          DM.cdsConsultaTransportadora.CommandText := 'select * from TB_TRANSPORTADORA where controletransportadora = ' + QuotedStr(ControleTransportadora) ;
          DM.cdsConsultaTransportadora.Open;

          if DM.cdsConsultaTransportadora.RecordCount > 0 then
           begin
                //dados da transportadora  ******************************************************************************


               if DM.cdsConsultaPedido.FieldByName('freteporconta').AsString = 'CIF' then
               // Modalidade do Frete ( CIF ou FOB )
                  Transp.modFrete   :=  mfContaEmitente
                else
                  Transp.modFrete   := mfContaDestinatario;



                Transp.Transporta.CNPJCPF   := DM.cdsConsultaTransportadora.FieldByName('cnpj').AsString; // cnpj da transportadora
                Transp.Transporta.xNome     := DM.cdsConsultaTransportadora.FieldByName('nome').AsString; // nome da transportadora
                Transp.Transporta.IE        := DM.cdsConsultaTransportadora.FieldByName('inscricaoestadual').AsString; // ie da transportadora
                Transp.Transporta.xEnder    := DM.cdsConsultaTransportadora.FieldByName('endereco').AsString;; // endereço da transportadora
                Transp.Transporta.xMun      := DM.cdsConsultaTransportadora.FieldByName('cidade').AsString; // município da transportadora (invertido de posição)
                Transp.Transporta.UF        := DM.cdsConsultaTransportadora.FieldByName('estado').AsString; // uf da transportadora   (invertido de posição)
           end;
          {
          with Transp.Reboque.Add do
           begin
              placa := '';   // placa
              UF    := '';   // uf do carro
              RNTC  := '';   // rntc do carro
           end;
           }
           
           //informações de volume *********************************************************************************
           with Transp.Vol.Add do
            begin

                qVol  := StrToIntDef(DM.cdsConsultaPedido.FieldByName('volume').AsString,0);   // quantidade de volume
                esp   := DM.cdsConsultaPedido.FieldByName('especie').AsString;  //especie
                marca := '';//editMarca.Text; // marca
                nVol  := DM.cdsConsultaPedido.FieldByName('volume').AsString; //número de volumes
                pesoL := StrToFloatDef(DM.cdsConsultaPedido.FieldByName('peso').AsString,0); //peso liquido
                pesoB := StrToFloatDef(DM.cdsConsultaPedido.FieldByName('peso').AsString,0); // peso bruto
            end;




           Cobr.Fat.nFat  :=   DM.cdsDetalheVenda.FieldByName('controlepedido').AsString;   // número do pedido
           Cobr.Fat.vOrig :=   DM.cdsDetalheVenda.FieldByName('totalnotaprodutos').AsFloat;   // valor total
           Cobr.Fat.vDesc :=   DM.cdsDetalheVenda.FieldByName('valordesconto').AsFloat;  // valor desconto
           Cobr.Fat.vLiq  :=   DM.cdsDetalheVenda.FieldByName('totalnotaprodutos').AsFloat - DM.cdsDetalheVenda.FieldByName('valordesconto').AsFloat;  // valor liquido desconto


        // informações da cobrança   *********************************************************************************

           DM.cdsFinanceiro.Close;
           DM.cdsFinanceiro.CommandText := '';
           DM.cdsFinanceiro.CommandText :=
           'select a.numerodocumento, b.controletipomovimento, * from TB_RECEBIMENTO a            '+
           'inner join  tb_c_vendas b on b.controle = a.controlevenda                             '+
           'inner join  TB_TIPO_MOVIMENTO c on c.controletipomovimento  = b.controletipomovimento '+
           'where c.tipoentadasaida = ''S''                                                       '+
           'and b.controle = '+ QuotedStr(IntToStr(ControlePedido));
           DM.cdsFinanceiro.Open;

           DM.cdsFinanceiro.First;
            while not DM.cdsFinanceiro.Eof do
              begin

               with Cobr.Dup.Add do
                begin
                   nDup   := DM.cdsFinanceiro.FieldByName('descricao').AsString;         // número da duplicata
                   dVenc  := DM.cdsFinanceiro.FieldByName('datavencimento').AsDateTime;  // data de vencimento
                   vDup   := DM.cdsFinanceiro.FieldByName('valorreal').AsFloat;          // valor da duplicata
                end;

             DM.cdsFinanceiro.Next;
          end;
           ObservacaoNota := LimparCaracteres(DM.cdsConsultaPedido.FieldByName('ObsCliente').AsString) +  LimparCaracteres(DM.cdsConsultaPedido.FieldByName('observacao').AsString) ;

           //informações adicionais contabilidade e Fisco ************************************************************
           InfAdic.infAdFisco := '';
           InfAdic.infCpl     :=  ObservacaoNota;  // observação
          {
           with InfAdic.obsCont.Add do
            begin
               xCampo := '';
               xTexto := '';
            end;
           with InfAdic.obsFisco.Add do
            begin
               xCampo := '';
               xTexto := '';
            end;
           }
       end;


       //gerando em xml
      // DM.ACBrNFe1.NotasFiscais.Assinar;
      //grava em xml
      DM.ACBrNFe1.NotasFiscais.Items[0].SaveToFile;
      DM.ACBrNFe1.NotasFiscais.SaveToTXT('C:\ITNFE\NotaFiscal-' + Trim(editNumeroPedido.Text) + FormatDateTime('dd-mm-yyyy',Now) + '.txt');
      //
      varantigo := DM.sPathArq + '\NotaFiscal-' + Trim(editNumeroPedido.Text) + FormatDateTime('dd-mm-yyyy',Now) + '.txt';
      varnovo   := DM.sPathArq + '\NFE- ' + Trim(editNumeroPedido.Text) + '-'  + FormatDateTime('dd-mm-yyyy',Now) + '.txt';

      AssignFile(arquivoOrigem,varantigo);
      Reset(arquivoOrigem);
      AssignFile(arquivoNovo,varnovo);
      Rewrite(arquivoNovo);
      linha := 'NOTA FISCAL|1';
      Writeln(arquivoNovo,linha);
      linha := 'A|3.10|NFe';
      Writeln(arquivoNovo,linha);

      while not eof(arquivoOrigem) do
      begin
         Readln(arquivoOrigem,linha);
        if (linha <> 'NOTA FISCAL|1') then
         begin
           Writeln(arquivoNovo,linha);
         end;
      end;
      CloseFile(arquivoOrigem);
      CloseFile(arquivoNovo);
      DeleteFile(varantigo);
      ShowMessage('Arquivo gerado em:' + DM.sPathArq);


    // Dm.ACBrNFe1.NotasFiscais.Imprimir;

        {

     //envia o e-mail
      Mensagem := TStringList.Create;
      Mensagem.Add('NFe');
      Endereco := TStringList.Create;
      Endereco.Add(sEmailClienteEnvioNfe);


       if sEmailClienteEnvioNfe <> '' then
        begin
        //enviar email
      Dm.ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(Dm.sHostSMTP,
                                                    Dm.sPortaSMTP,
                                                    Dm.sUsuarioSMTP,
                                                    Dm.sSenhaSMTP,
                                                    'protenorte@protenorte.com.br',
                                                    sEmailClienteEnvioNfe,
                                                    'NFe',
                                                    Mensagem,
                                                    true,
                                                    true,
                                                    Endereco,
                                                    nil,
                                                    false,
                                                    true,
                                                    'Protenorte Ltda');
        end
       else
        begin
        Dm.ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(Dm.sHostSMTP,
                                                    Dm.sPortaSMTP,
                                                    Dm.sUsuarioSMTP,
                                                    Dm.sSenhaSMTP,
                                                    'protenorte@protenorte.com.br',
                                                    sEmailClienteEnvioNfe,
                                                    'NFe',
                                                    Mensagem,
                                                    true,
                                                    true,
                                                    Endereco,
                                                    nil,
                                                    false,
                                                    true,
                                                    'Protenorte Ltda');
        end;
        }

      FreeAndNil(Endereco);
      FreeAndNil(Mensagem);

end;



procedure TfrmGeraNota.DBGridPedidoCellClick(Column: TColumn);
begin
   ControlePedido           := DM.cdsConsultaPedido.FieldByname('controle').AsInteger;
   sEmailClienteEnvioNfe := Trim(DM.cdsConsultaPedido.FieldByname('emailnfe').AsString);
   ControleTransportadora   := DM.cdsConsultaPedido.FieldByname('controletransportadora').AsString;
end;

procedure TfrmGeraNota.FormShow(Sender: TObject);
begin
  DM.AtualizaConfigAcBr;
  editNumeroPedido.SetFocus();
end;





procedure TfrmGeraNota.editQtdVolumeKeyPress(Sender: TObject; var Key: Char);
begin
      if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
      key := #0;
end;

procedure TfrmGeraNota.editPesoBrutoKeyPress(Sender: TObject;
  var Key: Char);
begin
    if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
      key := #0;
end;

procedure TfrmGeraNota.MudarComEnter(var Msg: TMsg; var Handled: Boolean);
begin
if Msg.message = WM_KEYDOWN then
 begin
    Case Msg.wParam of
     VK_RETURN,VK_DOWN : Screen.ActiveForm.Perform(WM_NextDlgCtl,0,0);
     VK_UP : Screen.ActiveForm.Perform(WM_NextDlgCtl,1,0);
    end;
 end;
end;

procedure TfrmGeraNota.FormCreate(Sender: TObject);
begin
  Application.OnMessage := MudarComEnter;
end;

procedure TfrmGeraNota.editPesoLiquidoKeyPress(Sender: TObject;
  var Key: Char);
begin
    if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
      key := #0;
end;

procedure TfrmGeraNota.DBGridPedidoDblClick(Sender: TObject);
begin
  btnGerarFNe.OnClick(Self);
end;





end.
