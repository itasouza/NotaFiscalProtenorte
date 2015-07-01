object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 568
  Top = 202
  Height = 383
  Width = 363
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.PathSalvar = 'C:\Arquivos de programas\Borland\Delphi7\Bin\'
    Configuracoes.Geral.ExibirErroSchema = True
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.RetirarAcentos = True
    Configuracoes.Geral.ValidarDigest = False
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.IntervaloTentativas = 0
    Configuracoes.WebServices.AjustaAguardaConsultaRet = False
    DANFE = ACBrNFeDANFERaveCB1
    Left = 56
    Top = 208
  end
  object cdsConsultaPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGenerico'
    RemoteServer = SocketConnection
    Left = 56
    Top = 72
  end
  object SocketConnection: TSocketConnection
    ServerGUID = '{00812C7D-616F-4B91-9CBB-52990924A759}'
    ServerName = 'ServidorSicVic.ClasseServidorVic'
    Address = '10.10.10.199'
    Left = 48
    Top = 16
  end
  object cdsDetalheVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGenerico'
    RemoteServer = SocketConnection
    Left = 56
    Top = 144
  end
  object cdsConsultaEnderecoEntrega: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGenerico'
    RemoteServer = SocketConnection
    Left = 195
    Top = 72
  end
  object cdsConsultaIBPT: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGenerico'
    RemoteServer = SocketConnection
    Left = 193
    Top = 133
  end
  object ACBrNFeDANFERaveCB1: TACBrNFeDANFERaveCB
    ACBrNFe = ACBrNFe1
    PathPDF = 'c:\temp\'
    MostrarPreview = True
    MostrarStatus = True
    TipoDANFE = tiSemGeracao
    NumCopias = 1
    ImprimirDescPorc = False
    ImprimirTotalLiquido = False
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    CasasDecimais._qCom = 2
    CasasDecimais._vUnCom = 2
    ExibirResumoCanhoto = False
    FormularioContinuo = False
    TamanhoFonte_DemaisCampos = 10
    ProdutosPorPagina = 0
    ImprimirDetalhamentoEspecifico = True
    NFeCancelada = False
    LocalImpCanhoto = 0
    ImprimeItens = True
    ViaConsumidor = True
    TamanhoCampoCodigo = 0
    TamanhoCampoVlUnit = 0
    TamanhoFonte_ANTT = 10
    TamanhoFonte_infComplementares = 6
    Fonte = ftTimes
    EspessuraBorda = 2
    ExpandirDadosAdicionaisAuto = False
    MostrarSetup = False
    TributosPercentual = ptValorProdutos
    ImprimirDesconto = True
    ImprimirTributosItem = False
    Left = 55
    Top = 264
  end
  object cdsConsultaTransportadora: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGenerico'
    RemoteServer = SocketConnection
    Left = 192
    Top = 184
  end
  object cdsFinanceiro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGenerico'
    RemoteServer = SocketConnection
    Left = 197
    Top = 240
  end
end
