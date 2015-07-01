program NotaFiscal;

uses
  Forms,
  Windows,
  untConfiguracaoNota in 'untConfiguracaoNota.pas' {frmConfiguracaoNota},
  untOpcoes in 'untOpcoes.pas' {frmOpcoes},
  untStatusServico in 'untStatusServico.pas' {frmStatusServico},
  untDM in 'untDM.pas' {DM: TDataModule},
  untGeraNota in 'untGeraNota.pas' {frmGeraNota},
  untValidaXml in 'untValidaXml.pas' {frmValidaXml},
  untEnviarNfe in 'untEnviarNfe.pas' {frmEnviarNfe},
  untCancelamentoNfe in 'untCancelamentoNfe.pas' {frmCancelamentoNfe},
  untInutilizarNumero in 'untInutilizarNumero.pas' {frmInutilizarNumero},
  untImpressaoDanfe in 'untImpressaoDanfe.pas' {frmImpressaoDanfe},
  untEnviarEmailNfe in 'untEnviarEmailNfe.pas' {frmEnviarEmailNfe};

{$R *.res}

//Não deixar abrir o mesmo programa mais de uma vez
//na unit principal
var
  Aplicativo : THandle;
begin
  { "Faça essa modificação no seu programa, teste e o nome do executável" }
  //Este comando altera o titulo da aplicação, o mesmo e usado para
  //verificar se o mesmo esta aberto.
  Aplicativo := FindWindow('TApplication', 'Sistema de Emissão de Nota Fiscal');
  { "Se, não estiver aberto" }
  If (Aplicativo = 0) then
   begin
     Application.Initialize;
     Application.Title := 'Sistema de Emissão de Nota Fiscal';
     Application.CreateForm(TDM, DM);
     Application.CreateForm(TfrmOpcoes, frmOpcoes);
     Application.Run;
   end
    else
     { "Se, estiver aberto ele restaura a janela" }
     ShowWindow(Aplicativo, SW_RESTORE);

end.
