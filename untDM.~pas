unit untDM;

interface

uses
  SysUtils, Classes, Menus, ACBrNFe, IniFiles, pcnConversao,
  ACBrNFeDANFEClass, ACBrNFeDANFERave,Windows, Messages, Variants, Graphics, Controls, Forms, ExtCtrls,
  ComCtrls, ImgList, Dialogs, DBXpress, FMTBcd, DBClient, Provider, DB,
  SqlExpr, XPMan, MConnect, SConnect, ACBrNFeDANFERaveCB;

type
  TDM = class(TDataModule)
    ACBrNFe1: TACBrNFe;
    cdsConsultaPedido: TClientDataSet;
    SocketConnection: TSocketConnection;
    cdsDetalheVenda: TClientDataSet;
    cdsConsultaEnderecoEntrega: TClientDataSet;
    cdsConsultaIBPT: TClientDataSet;
    ACBrNFeDANFERaveCB1: TACBrNFeDANFERaveCB;
    cdsConsultaTransportadora: TClientDataSet;
    cdsFinanceiro: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    { Public declarations }
    sNumItem     : Integer;
    sTipoConta   : Integer;
    sProcessoQui : Integer;
    sArquivo     : TextFile;
    sTotalReg    : Integer;
    sLBloco,sLArquivo,sLRegistro : Integer;
    // configurações do AcBr
    sFormas, sRegime, sAmbiente : Integer;
    sSalvaArq : Boolean;
    sLogoMarca, sPathArq, sCertificado, sSenha, sSerial,
    sRazao, sFantasia, sCNPJ, sIE, sEndereco, sNum,
    sBairro, sCidade, sCEP, sUF, sTelefone, sCodMun, sUFWS, sHost,
    sPorta, sUsuario, sSenhaWS,  sTipoCertificado, sIPConexao : String;
    sHostSMTP, sPortaSMTP, sUsuarioSMTP, sSMTP, sSenhaSMTP:String;

    procedure LeArqIni;
    procedure GravaArqIni;
    procedure AtualizaConfigAcBr;
    procedure GravaChaveNFEPedido(pChaveNFe, pNumPed: String);
  end;

var
  DM: TDM;
  sEmailClienteEnvioNfe :String;

implementation

{$R *.dfm}

{ TDM }

procedure TDM.AtualizaConfigAcBr;
  var OK : Boolean;
begin
  // realiza a leidura dos dados do arquivo de configuração
  LeArqIni;
  // Repassa Dados para componente AcBrNFe
  {$IFDEF AcBrMFeOpenSSL}
    ACBrNFe1.configuracoes.Certificados.Certificado := sCertificado;
    AcBrNFe1.Configuracoes.Certificados.Senha       := sSenha;
  {$ELSE}
    AcBrNFe1.Configuracoes.Certificados.NumeroSerie := sSerial;
  {$ENDIF}
  // Geral
  ACBrNFe1.Configuracoes.Geral.FormaEmissao         := StrToTpEmis(OK,IntToStr(sFormas));
  ACBrNFe1.Configuracoes.Geral.Salvar               := sSalvaArq;
  ACBrNFe1.Configuracoes.Geral.PathSalvar           := sPathArq;
  // WebServices
  ACBrNFe1.Configuracoes.WebServices.UF             := sUFWS;
  ACBrNFe1.Configuracoes.WebServices.Ambiente       := StrToTpAmb(OK,IntToStr(sAmbiente));
  ACBrNFe1.Configuracoes.WebServices.Visualizar     := True;
  ACBrNFe1.Configuracoes.WebServices.ProxyHost      := sHost;
  ACBrNFe1.Configuracoes.WebServices.ProxyPort      := sPorta;
  ACBrNFe1.Configuracoes.WebServices.ProxyUser      := sUsuario;
  ACBrNFe1.Configuracoes.WebServices.ProxyPass      := sSenhaWS;
  //adicionado para a nova versão do xml 3.10
  ACBrNFe1.Configuracoes.Geral.ModeloDF             := moNFCe;
  ACBrNFe1.Configuracoes.Geral.VersaoDF             := ve310;


  //
  if ACBrNFe1.DANFE <> nil then
  begin
    ACBrNFe1.DANFE.TipoDANFE := StrToTpImp(OK,'1');
    ACBrNFe1.DANFE.Logo      := sLogoMarca;
  end;

end;

procedure TDM.GravaArqIni;
  var ArqINI : TIniFile;
begin
  inherited;
  ArqINI := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Configuracao.ini');
  // GERAL
  ArqINI.WriteInteger('GERAL','FORMA_EMISSAO',sFormas);
  ArqINI.WriteString('GERAL','LOGOMARCA',sLogoMarca);
  ArqINI.WriteBool('GERAL','SALVA_ARQUIVO',sSalvaArq);
  ArqINI.WriteString('GERAL','PATH_ARQUIVO',sPathArq);
  // CERTIFICADO
  ArqINI.WriteString('CERTIFICADO','TIPO_CERITIFICADO',sTipoCertificado);
  ArqINI.WriteString('CERTIFICADO','PATH_CERTIFICADO',sCertificado);
  ArqINI.WriteString('CERTIFICADO','SENHA_CERT',sSenha);
  ArqINI.WriteString('CERTIFICADO','NUM_SERIE',sSerial);
  // emitente
  ArqINI.WriteInteger('EMITENTE','REGIME_EMPRESA',sRegime);
  ArqINI.WriteString('EMITENTE','RAZAO',sRazao);
  ArqINI.WriteString('EMITENTE','FANTASIA',sFantasia);
  ArqINI.WriteString('EMITENTE','CNPJ',sCNPJ);
  ArqINI.WriteString('EMITENTE','I_ESTADUAL',sIE);
  ArqINI.WriteString('EMITENTE','ENDERECO',sEndereco);
  ArqINI.WriteString('EMITENTE','NUMERO',sNum);
  ArqINI.WriteString('EMITENTE','BAIRRO',sBairro);
  ArqINI.WriteString('EMITENTE','CIDADE',sCidade);
  ArqINI.WriteString('EMITENTE','CEP',sCEP);
  ArqINI.WriteString('EMITENTE','UF',sUF);
  ArqINI.WriteString('EMITENTE','TELEFONE',sTelefone);
  ArqINI.WriteString('EMITENTE','MUNICIPIO',sCodMun);
  // WebService
  ArqINI.WriteString('WS','UFWS',sUFWS);
  ArqINI.WriteInteger('WS','AMBIENTE',sAmbiente);
  ArqINI.WriteString('WS','HOST',sHost);
  ArqINI.WriteString('WS','PORTA',sPorta);
  ArqINI.WriteString('WS','USUARIO',sUsuario);
  ArqINI.WriteString('WS','SENHA',sSenhaWS);

  //email
  ArqINI.WriteString('EMAIL','SMTPHOST',sHostSMTP);
  ArqINI.WriteString('EMAIL','SMTPPORT',sPortaSMTP);
  ArqINI.WriteString('EMAIL','SMTPUSUARIO',sUsuarioSMTP);
  ArqINI.WriteString('EMAIL','SMTPSENHA',sSenhaSMTP);


  //
  ArqINI.Free;

end;

procedure TDM.GravaChaveNFEPedido(pChaveNFe, pNumPed: String);
begin
  try
    cdsConsultaPedido.Close;
    cdsConsultaPedido.CommandText := '';
    cdsConsultaPedido.CommandText := ' update TB_C_VENDAS set chavenfe = :pChave where controlepedido = :pNumped';
    cdsConsultaPedido.FetchParams;
    cdsConsultaPedido.Params.ParamByName('pChave').ParamType := ptInput;
    cdsConsultaPedido.Params.ParamByName('pNumped').ParamType := ptInput;
    cdsConsultaPedido.Params.ParamByName('pChave').AsString := pChaveNFe;
    cdsConsultaPedido.Params.ParamByName('pNumped').AsString := pNumPed;
    cdsConsultaPedido.Execute;

  finally
    FreeAndNil(cdsConsultaPedido);
  end;

end;

procedure TDM.LeArqIni;
 var ArqINI : TIniFile;
     aux : String;
begin
  aux := ExtractFilePath(Application.ExeName)+'Configuracao.ini';
  ArqINI := TIniFile.Create(aux);
  // GERAL
  sFormas      := ArqINI.ReadInteger('GERAL','FORMA_EMISSAO',0);
  sLogoMarca   := ArqINI.ReadString('GERAL','LOGOMARCA','C:\logo.jpg');
  sSalvaArq    := ArqINI.ReadBool('GERAL','SALVA_ARQUIVO',true);
  sPathArq     := ArqINI.ReadString('GERAL','PATH_ARQUIVO','C:\');
  // CERTIFICADO
  sTipoCertificado := ArqINI.ReadString('CERTIFICADO','TIPO_CERITIFICADO','');
  sCertificado     := ArqINI.ReadString('CERTIFICADO','PATH_CERTIFICADO','');
  sSenha           := ArqINI.ReadString('CERTIFICADO','SENHA_CERT','');
  sSerial          := ArqINI.ReadString('CERTIFICADO','NUM_SERIE','');
  // emitente
  sRegime      := ArqINI.ReadInteger('EMITENTE','REGIME_EMPRESA',0);
  sRazao       := ArqINI.ReadString('EMITENTE','RAZAO','');
  sFantasia    := ArqINI.ReadString('EMITENTE','FANTASIA','');
  sCNPJ        := ArqINI.ReadString('EMITENTE','CNPJ','');
  sIE          := ArqINI.ReadString('EMITENTE','I_ESTADUAL','');
  sEndereco    := ArqINI.ReadString('EMITENTE','ENDERECO','');
  sNum         := ArqINI.ReadString('EMITENTE','NUMERO','');
  sBairro      := ArqINI.ReadString('EMITENTE','BAIRRO','');
  sCidade      := ArqINI.ReadString('EMITENTE','CIDADE','');
  sCEP         := ArqINI.ReadString('EMITENTE','CEP','');
  sUF          := ArqINI.ReadString('EMITENTE','UF','');
  sTelefone    := ArqINI.ReadString('EMITENTE','TELEFONE','');
  sCodMun      := ArqINI.ReadString('EMITENTE','MUNICIPIO','');
  // WebService
  sUFWS        := ArqINI.ReadString('WS','UFWS','');
  sAmbiente    := ArqINI.ReadInteger('WS','AMBIENTE',0);
  sHost        := ArqINI.ReadString('WS','HOST','');
  sPorta       := ArqINI.ReadString('WS','PORTA','');
  sUsuario     := ArqINI.ReadString('WS','USUARIO','');
  sSenhaWS     := ArqINI.ReadString('WS','SENHA','');
  //
  //email
  sHostSMTP    := ArqINI.ReadString('EMAIL','SMTPHOST','');
  sPortaSMTP   := ArqINI.ReadString('EMAIL','SMTPPORT','');
  sUsuarioSMTP := ArqINI.ReadString('EMAIL','SMTPUSUARIO','');
  sSenhaSMTP   := ArqINI.ReadString('EMAIL','SMTPSENHA','');

  sIPConexao   := ArqINI.ReadString('CONEXAO','IP','');


  ArqINI.Free;

end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
 LeArqIni;
 SocketConnection.Address := sIPConexao;
end;

end.
