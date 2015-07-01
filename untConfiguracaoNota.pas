unit untConfiguracaoNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ImgList, ActnList, Buttons, IniFiles,
  DBCtrls;

type
  TfrmConfiguracaoNota = class(TForm)
    imgPop: TImageList;
    Panel1: TPanel;
    PageControl1: TPageControl;
    tabGeral: TTabSheet;
    PanelEntrada: TPanel;
    PanelFicha: TPanel;
    TabCertificado: TTabSheet;
    Panel3: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    TabEmitente: TTabSheet;
    Panel2: TPanel;
    Panel4: TPanel;
    TabWebService: TTabSheet;
    Panel5: TPanel;
    Panel7: TPanel;
    RadioFormas: TRadioGroup;
    GroupBox5: TGroupBox;
    SpeedButton1: TSpeedButton;
    EdtLogoMarca: TEdit;
    ChArquivos: TCheckBox;
    GroupBox6: TGroupBox;
    SpeedButton2: TSpeedButton;
    EdtArquivos: TEdit;
    ActionList1: TActionList;
    ActConfirmar: TAction;
    ActFechar: TAction;
    OpenDialog1: TOpenDialog;
    GroupBox7: TGroupBox;
    SpeedButton3: TSpeedButton;
    EdtCertificado: TEdit;
    GroupBox8: TGroupBox;
    EdtSenha: TEdit;
    GroupBox9: TGroupBox;
    EdtSerial: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    EdtRazao: TEdit;
    EdtFantasia: TEdit;
    EdtIE: TEdit;
    EdtCNPJ: TEdit;
    EdtEndereco: TEdit;
    EdtBairro: TEdit;
    EdtNum: TEdit;
    EdtCEP: TEdit;
    EdtCidade: TEdit;
    EdtTelefone: TEdit;
    EdtCodMun: TEdit;
    UF: TLabel;
    RadioAmbiente: TRadioGroup;
    GroupBox10: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    EdtHost: TEdit;
    EdtPorta: TEdit;
    EdtUsuario: TEdit;
    EdtSenhaWS: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EdtUFWS: TComboBox;
    EdtUF: TComboBox;
    RadioRegime: TRadioGroup;
    TabEmail: TTabSheet;
    Panel8: TPanel;
    GroupBox1: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    editHostEnvioEmail: TEdit;
    editPortaEnvioEmail: TEdit;
    editUsuarioEnvioEmail: TEdit;
    editSenhaEnvioEmail: TEdit;
    RadioA1: TRadioButton;
    RadioA3: TRadioButton;
    procedure ActConfirmarExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure EdtCodMunKeyPress(Sender: TObject; var Key: Char);
    procedure RadioA3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }


  end;

var
  frmConfiguracaoNota: TfrmConfiguracaoNota;

implementation

uses untDM;

{$R *.dfm}

{ TfrmConfiguracaoNota }



procedure TfrmConfiguracaoNota.ActConfirmarExecute(Sender: TObject);
begin
     try
        // GERAL
        DM.sFormas      := RadioFormas.ItemIndex;
        DM.sLogoMarca   := EdtLogoMarca.Text;
        DM.sSalvaArq    := ChArquivos.Checked;
        DM.sPathArq     := EdtArquivos.Text;
        // CERTIFICADO

        if RadioA1.Checked = true then
           DM.sTipoCertificado := '1'  //marcou a1
         else
           DM.sTipoCertificado := '3'; //marcou  a3

        DM.sCertificado := EdtCertificado.Text;
        DM.sSenha       := EdtSenha.Text;
        DM.sSerial      := EdtSerial.Text;
        // emitente
        DM.sRegime      := RadioRegime.ItemIndex;
        DM.sRazao       := EdtRazao.Text;
        DM.sFantasia    := EdtFantasia.Text;
        DM.sCNPJ        := EdtCNPJ.Text;
        DM.sIE          := EdtIE.Text;
        DM.sEndereco    := EdtEndereco.Text;
        DM.sNum         := EdtNum.Text;
        DM.sBairro      := EdtBairro.Text;
        DM.sCidade      := EdtCidade.Text;
        DM.sCEP         := EdtCEP.Text;
        DM.sUF          := EdtUF.Text;
        DM.sTelefone    := EdtTelefone.Text;
        DM.sCodMun      := EdtCodMun.Text;
        // WebService
        DM.sUFWS        := EdtUFWS.Text;
        DM.sAmbiente    := RadioAmbiente.ItemIndex;
        DM.sHost        := EdtHost.Text;
        DM.sPorta       := EdtPorta.Text;
        DM.sUsuario     := EdtUsuario.Text;
        DM.sSenhaWS     := EdtSenhaWS.Text;

        //email
        DM.sHostSMTP    := editHostEnvioEmail.Text;
        DM.sPortaSMTP   := editPortaEnvioEmail.Text;
        DM.sUsuarioSMTP := editUsuarioEnvioEmail.Text;
        DM.sSenhaSMTP   := editSenhaEnvioEmail.Text;



        // grava dados no arquivo
        DM.GravaArqIni;
        MessageDlg('Arquivo Gravado com sucesso!', mtInformation, [mbOK], 0);
        Close;
      except
        MessageDlg('Erro ao gravar arquivo de configuração!', mtError, [mbOK], 0);
      end;

end;

procedure TfrmConfiguracaoNota.ActFecharExecute(Sender: TObject);
begin
   Close;
end;

procedure TfrmConfiguracaoNota.FormShow(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  DM.LeArqIni;
  // GERAL
  RadioFormas.ItemIndex   := DM.sFormas;
  EdtLogoMarca.Text       := DM.sLogoMarca;
  ChArquivos.Checked      := DM.sSalvaArq;
  EdtArquivos.Text        := DM.sPathArq;
  // CERTIFICADO

  if DM.sTipoCertificado = '1' then
       RadioA1.Checked := True  //marcou a1
  else
      RadioA3.Checked := True;  //marcou  a3

  EdtCertificado.Text     := DM.sCertificado;
  EdtSenha.Text           := DM.sSenha;
  EdtSerial.Text          := DM.sSerial;
  // emitente
  RadioRegime.ItemIndex   := DM.sRegime;
  EdtRazao.Text           := DM.sRazao;
  EdtFantasia.Text        := DM.sFantasia;
  EdtCNPJ.Text            := DM.sCNPJ;
  EdtIE.Text              := DM.sIE;
  EdtEndereco.Text        := DM.sEndereco;
  EdtNum.Text             := DM.sNum;
  EdtBairro.Text          := DM.sBairro;
  EdtCidade.Text          := DM.sCidade;
  EdtCEP.Text             := DM.sCEP;
  EdtUF.Text              := DM.sUF;
  EdtTelefone.Text        := DM.sTelefone;
  EdtCodMun.Text          := DM.sCodMun;
  
  // WebService
  EdtUFWS.Text            := DM.sUFWS;
  RadioAmbiente.ItemIndex := DM.sAmbiente;
  EdtHost.Text            := DM.sHost;
  EdtPorta.Text           := DM.sPorta;
  EdtUsuario.Text         := DM.sUsuario;
  EdtSenhaWS.Text         := DM.sSenhaWS;

  //email
  editHostEnvioEmail.Text    := DM.sHostSMTP;
  editPortaEnvioEmail.Text   := DM.sPortaSMTP;
  editUsuarioEnvioEmail.Text := DM.sUsuarioSMTP;
  editSenhaEnvioEmail.Text   := DM.sSenhaSMTP;
 //   DM.sSMTP        := '';



end;

procedure TfrmConfiguracaoNota.SpeedButton1Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdtLogoMarca.Text := OpenDialog1.FileName;

end;

procedure TfrmConfiguracaoNota.SpeedButton2Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdtArquivos.Text := OpenDialog1.FileName;

end;

procedure TfrmConfiguracaoNota.SpeedButton3Click(Sender: TObject);
begin
  if RadioA1.Checked = true then
   begin
     OpenDialog1.Execute;
     EdtCertificado.Text := OpenDialog1.FileName
   end
  else
    begin
      EdtSerial.Text := DM.ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
    end;

end;



procedure TfrmConfiguracaoNota.EdtCodMunKeyPress(Sender: TObject;
  var Key: Char);
begin
 if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
   key := #0;
end;

procedure TfrmConfiguracaoNota.RadioA3Click(Sender: TObject);
begin
  EdtSerial.Text := '';
end;

end.
