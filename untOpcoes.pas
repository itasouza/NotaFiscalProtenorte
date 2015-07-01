unit untOpcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, jpeg, ACBrNFe, XPMan, ImgList;

type
  TfrmOpcoes = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    NFe1: TMenuItem;
    StatusdoServio1: TMenuItem;
    GerarNFe1: TMenuItem;
    ValidarXML1: TMenuItem;
    N3: TMenuItem;
    CancelamentoNFe1: TMenuItem;
    InutilizarNmerao1: TMenuItem;
    N6: TMenuItem;
    Consultas1: TMenuItem;
    ConsultarCarregamentoXML1: TMenuItem;
    ConsultarReciboLote1: TMenuItem;
    ConsultarDPEC1: TMenuItem;
    N4: TMenuItem;
    ImprimirDanfe1: TMenuItem;
    EnviarEmailNFe1: TMenuItem;
    Confuguraes1: TMenuItem;
    Sair1: TMenuItem;
    Panel5: TPanel;
    Panel7: TPanel;
    Image1: TImage;
    XPManifest1: TXPManifest;
    ImageList1: TImageList;
    Timer1: TTimer;
    CriareEnviarNfe1: TMenuItem;
    procedure Confuguraes1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure StatusdoServio1Click(Sender: TObject);
    procedure GerarNFe1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ValidarXML1Click(Sender: TObject);
    procedure CriareEnviarNfe1Click(Sender: TObject);
    procedure CancelamentoNFe1Click(Sender: TObject);
    procedure InutilizarNmerao1Click(Sender: TObject);
    procedure ImprimirDanfe1Click(Sender: TObject);
    procedure EnviarEmailNFe1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cap  : String;
    ncar : Integer;
  public
    { Public declarations }
  end;

var
  frmOpcoes: TfrmOpcoes;

implementation

uses untConfiguracaoNota, untStatusServico, untGeraNota, midaslib,
  untValidaXml, untEnviarNfe, untCancelamentoNfe, untInutilizarNumero,
  untImpressaoDanfe, untEnviarEmailNfe;

{$R *.dfm}

procedure TfrmOpcoes.Confuguraes1Click(Sender: TObject);
begin
  try
     frmConfiguracaoNota :=TfrmConfiguracaoNota.Create(Application);
     frmConfiguracaoNota.ShowModal;
  finally
     FreeAndNil(frmConfiguracaoNota);
  end;
end;

procedure TfrmOpcoes.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmOpcoes.StatusdoServio1Click(Sender: TObject);
begin
  try
    frmStatusServico :=TfrmStatusServico.Create(Application);
    frmStatusServico.ShowModal;
  finally
    FreeAndNil(frmStatusServico);
  end;
end;

procedure TfrmOpcoes.GerarNFe1Click(Sender: TObject);
begin
  try
    frmGeraNota :=TfrmGeraNota.Create(Application);
    frmGeraNota.ShowModal;
  finally
    FreeAndNil(frmGeraNota);
  end;
end;

procedure TfrmOpcoes.FormShow(Sender: TObject);
begin
  cap := 'Pretenorte | O rumo Certo da segurança';
  ncar := 0;
  try
    frmGeraNota :=TfrmGeraNota.Create(Application);
    frmGeraNota.ShowModal;
  finally
    FreeAndNil(frmGeraNota);
  end;

end;

procedure TfrmOpcoes.Timer1Timer(Sender: TObject);
begin
  if ncar <= length(cap) then
    begin
      frmOpcoes.caption := copy(cap,1,ncar);
      ncar := ncar +1;
    end
   else
    begin
     ncar := 0;
    end;

end;

procedure TfrmOpcoes.ValidarXML1Click(Sender: TObject);
begin
 try
   frmValidaXml := TfrmValidaXml.Create(Application);
   frmValidaXml.ShowModal;
 finally
   FreeAndNil(frmValidaXml);
 end;
end;

procedure TfrmOpcoes.CriareEnviarNfe1Click(Sender: TObject);
begin
 try
   frmEnviarNfe := TfrmEnviarNfe.Create(Application);
   frmEnviarNfe.ShowModal;
 finally
   FreeAndNil(frmEnviarNfe);
 end;
end;

procedure TfrmOpcoes.CancelamentoNFe1Click(Sender: TObject);
begin
 try
   frmCancelamentoNfe := TfrmCancelamentoNfe.Create(Application);
   frmCancelamentoNfe.ShowModal;
 finally
   FreeAndNil(frmCancelamentoNfe);
 end;
end;

procedure TfrmOpcoes.InutilizarNmerao1Click(Sender: TObject);
begin
 try
   frmInutilizarNumero := TfrmInutilizarNumero.Create(Application);
   frmInutilizarNumero.ShowModal;
 finally
   FreeAndNil(frmInutilizarNumero);
 end;
end;

procedure TfrmOpcoes.ImprimirDanfe1Click(Sender: TObject);
begin
 try
   frmImpressaoDanfe := TfrmImpressaoDanfe.Create(Application);
   frmImpressaoDanfe.ShowModal;
 finally
   FreeAndNil(frmImpressaoDanfe);
 end;
end;

procedure TfrmOpcoes.EnviarEmailNFe1Click(Sender: TObject);
begin
 try
   frmEnviarEmailNfe := TfrmEnviarEmailNfe.Create(Application);
   frmEnviarEmailNfe.ShowModal;
 finally
   FreeAndNil(frmEnviarEmailNfe);
 end;
end;

procedure TfrmOpcoes.FormCreate(Sender: TObject);
begin

  if ParamStr(1) <> '' then
  begin
      try
        frmGeraNota :=TfrmGeraNota.Create(Application);
        frmGeraNota.editNumeroPedido.Text := QuotedStr(ParamStr(1));
        frmGeraNota.btnLocalizar.OnClick(Self);
        frmGeraNota.ShowModal;
      finally
        FreeAndNil(frmGeraNota);
      end;

  end;

end;

end.
