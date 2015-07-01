object frmConfiguracaoNota: TfrmConfiguracaoNota
  Left = 214
  Top = 269
  Width = 687
  Height = 330
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#227'o do Sistema NFe'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 292
    Cursor = crArrow
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 2
      Top = 2
      Width = 667
      Height = 288
      ActivePage = tabGeral
      Align = alClient
      Images = imgPop
      Style = tsFlatButtons
      TabOrder = 0
      object tabGeral: TTabSheet
        Cursor = crHandPoint
        Caption = 'Geral'
        ImageIndex = 6
        object PanelEntrada: TPanel
          Left = 0
          Top = 0
          Width = 659
          Height = 41
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Label1: TLabel
            Left = 106
            Top = 11
            Width = 314
            Height = 20
            Caption = 'Configura'#231#227'o de Nota Fiscal Eletr'#244'nica'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object PanelFicha: TPanel
          Left = 0
          Top = 41
          Width = 659
          Height = 215
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object RadioFormas: TRadioGroup
            Left = 8
            Top = 14
            Width = 497
            Height = 74
            Caption = ' Forma de Emiss'#227'o '
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Normal'
              'DPEC'
              'Conting'#234'ncia'
              'SCAN'
              'FSDA')
            TabOrder = 0
          end
          object GroupBox5: TGroupBox
            Left = 8
            Top = 88
            Width = 497
            Height = 47
            Caption = ' Logomarca '
            TabOrder = 1
            object SpeedButton1: TSpeedButton
              Left = 320
              Top = 16
              Width = 23
              Height = 22
              Caption = '...'
              OnClick = SpeedButton1Click
            end
            object EdtLogoMarca: TEdit
              Left = 8
              Top = 16
              Width = 305
              Height = 21
              TabOrder = 0
            end
          end
          object ChArquivos: TCheckBox
            Left = 8
            Top = 138
            Width = 313
            Height = 17
            Caption = 'Salvar Arquivos de Envio e Resposta'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
          object GroupBox6: TGroupBox
            Left = 9
            Top = 151
            Width = 497
            Height = 57
            Caption = ' Path para arquivo '
            TabOrder = 3
            object SpeedButton2: TSpeedButton
              Left = 320
              Top = 16
              Width = 23
              Height = 22
              Caption = '...'
              OnClick = SpeedButton2Click
            end
            object EdtArquivos: TEdit
              Left = 8
              Top = 16
              Width = 305
              Height = 21
              TabOrder = 0
            end
          end
          object BitBtn1: TBitBtn
            Left = 509
            Top = 18
            Width = 139
            Height = 33
            Action = ActConfirmar
            Caption = 'F2 - Confirmar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            Glyph.Data = {
              76060000424D7606000000000000360400002800000018000000180000000100
              08000000000040020000120B0000120B0000000100004D00000033333300D5D4
              D100E0A17C00D0713E00A9460500A2755D00AAA8A400EEEEEE005F5D5C00EAB6
              9B00D38A5D00C5744300BCBAB600E4AB8C00E6E6E6004C4A4A00C4C4C400C5A0
              88009E9C9900B7602D00DFDFDF00FFFFFF00E7C3AE00DD936D00CA7B4C00A4A3
              9F00B87A5300CCCCCC00EBEAE900CF825400B6B5B100B4592000BD977E00F8F8
              F8006967660056535200C5683300A1897D00DD9A7300F7E6DD00F2D1C400B052
              1900E3A78500E7E2DF00D8906500CC7E5000D6D6D600A8877400B0AEAB00BDBD
              BD00D7855A00D7967300DA8D64005B595800B5633100F9ECE500C87848005252
              4A00F1ECE800AE5D280066666600EBB9A000DFA48500D37B4C00DE9F7A00BD6A
              3900D57F5100B1541E00D68D6100D1865900E29776006E6C6A00BC653100B75E
              2800AD4E1200BC7B530000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000015152121070E
              14141414141414140E1C2121211C0E0721151521072E1B101010101010101010
              101B2E142E1B10010715210701203B0F0000000000000000000000002543044B
              0E21072E1A13330F31121212121212121212310F2433091F14210E1141090939
              3119101010191919191931393209094A14210E363E090D2331063F3F3F060606
              0606312332090929142114430909263531303F3F3F303030303031353F090943
              1421141F09092608311E3F3F3F1E1E1E1E1E31083F09091F1421144909094022
              310C4242420C0C0C0C0C31084209094914211413090902472E14141414141414
              14142E2242090913142114480909022F47474747474747474747470517090948
              1421144109093E3E3E3E3E3E3E3E3E3E3E3E3E3E3E0909411421144109092A2A
              2A2A2A2A2A2A2A2A2A2A2A2A2A0909411421140B090934030303030303030303
              030303033409090B1421140B09093F3A21212121212121212121213A3F09090B
              1421143809094221010101010101010101010121420909381421141809093221
              2E2E2E2E2E2E2E2E2E2E2E21320909181421142D090934211414141414141414
              141414213409092D1421141D092817212B2B2B2B2B2B2B2B2B2B2B211728091D
              14211445094646210E0E0E0E0E0E0E0E0E0E0E212646094514212B443D090221
              1C1C1C1C1C1C1C1C1C1C1C2102093D0A0E213A2C273737152121212121212121
              2121212127372744071521162C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C16
              2115151521212121212121212121212121212121212121151515}
          end
          object BitBtn2: TBitBtn
            Left = 510
            Top = 55
            Width = 138
            Height = 33
            Action = ActFechar
            Caption = 'F10 - Fechar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
            Glyph.Data = {
              76060000424D7606000000000000360400002800000018000000180000000100
              08000000000040020000120B0000120B00000001000061000000087C0800D6D6
              D60070C173003FAF3F00FFFFFF002B9B2B00B7C0B70042D37600EFEFEF0040C9
              6B007FE0A10018861D0042C25C002BAD4900C6C6C60049AE4E0088C88800E5E5
              E500A1B9A1009FE8B800C9DFC900288C280037A0370048D57A0080AD800042BB
              51005ABF6B001082100035BC5C005A9D5A00F7F7F70067DB9000DFDFDF0034A4
              3400A4CFA40065B9650056D783003A923A00239323009FB79F00B1D4B1001687
              160040CF7200CBE1CB002E9D30003DA83E0092D79F00CCCCCC0051AC510043D4
              780042C561005CC9780039C466003BAA3B007BAA7B005ED98A001E841E00ADCE
              AD0042C05A0028A33B00BAEBC800BABABA008EDCA300A2C2A20031B14D00E5ED
              E50042CC6C00A6E9BD00209C34008BB78B00C1CAC10050B55B0023952700C4E9
              CB0084CC8C0074DD990053CD790064DB8D0038A838001A8B1A00299229001E8E
              1E0084DEA10030A33B00178F240052B55200B9C2B900A2BAA200C4E5C50038BF
              5E00A5D6A50060BA61003AC56B00ACD6AC002FB45200D0E6D000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000040404040404
              04041E4111081E0404040404040404040404040404040404041E413F4601111E
              04040404040404040404040404040404041E1100382701110804040404040404
              040404041E1E04041E0801005E0B362F20081E040404040404041E081111081E
              08202F003134541D0E20081E04040404040408010E0E0111112F3D1B31312A44
              255601111E0404040404110000000020201B1B1B313131310D15120111080404
              04041100313100202029313131313231311C4F182F20081E0404111B31311B20
              204F31313131190C070734481D0E01081E04112931312920204F31313A3A3A3A
              3A2A312A3B250601111E114F31314F20205131313A3A3A3A3A3A423131405057
              0108115131315120205131310C0C0C0C0C0C0C42313159484520112631312620
              2026313132323232323232323207070953391148313148202048313132323232
              323232324207174C53281105313105202005313109090909090909093137332C
              221E112C31312C202005313142424242424242174B1A16141E04112131312120
              202C31312A2A2A2A2A0724524730411E0404114E31314E20202C313131310707
              071F3E0F0208040404040835131335111121131331313131522E2D5A1E040404
              04041E030303031E08212121313117434A0F2B1E04040404040404041E1E0404
              0408204E314D3C0223411E04040404040404040404040404041E11350A495B10
              08040404040404040404040404040404041E410358555D1E0404040404040404
              040404040404040404041E03555F1E0404040404040404040404}
          end
        end
      end
      object TabCertificado: TTabSheet
        Cursor = crHandPoint
        Caption = 'Certificado'
        ImageIndex = 5
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 659
          Height = 256
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Panel6: TPanel
            Left = 2
            Top = 2
            Width = 655
            Height = 252
            Align = alClient
            BevelInner = bvLowered
            BevelWidth = 2
            TabOrder = 0
            object GroupBox7: TGroupBox
              Left = 28
              Top = 24
              Width = 445
              Height = 76
              Caption = ' Path do Certificado '
              TabOrder = 0
              object SpeedButton3: TSpeedButton
                Left = 310
                Top = 43
                Width = 23
                Height = 22
                Caption = '...'
                OnClick = SpeedButton3Click
              end
              object EdtCertificado: TEdit
                Left = 8
                Top = 44
                Width = 297
                Height = 21
                TabOrder = 0
              end
              object RadioA1: TRadioButton
                Left = 8
                Top = 16
                Width = 73
                Height = 17
                Caption = 'A1'
                TabOrder = 1
              end
              object RadioA3: TRadioButton
                Left = 112
                Top = 16
                Width = 113
                Height = 17
                Caption = 'A3'
                Checked = True
                TabOrder = 2
                TabStop = True
                OnClick = RadioA3Click
              end
            end
            object GroupBox8: TGroupBox
              Left = 180
              Top = 122
              Width = 145
              Height = 45
              Caption = ' Senha '
              TabOrder = 1
              object EdtSenha: TEdit
                Left = 8
                Top = 16
                Width = 121
                Height = 21
                TabOrder = 0
              end
            end
            object GroupBox9: TGroupBox
              Left = 28
              Top = 122
              Width = 145
              Height = 45
              Caption = ' N'#250'mero do S'#233'rie '
              TabOrder = 2
              object EdtSerial: TEdit
                Left = 8
                Top = 16
                Width = 121
                Height = 21
                TabOrder = 0
              end
            end
          end
        end
      end
      object TabEmitente: TTabSheet
        Cursor = crHandPoint
        Caption = 'Emitente'
        ImageIndex = 3
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 659
          Height = 256
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Panel4: TPanel
            Left = 2
            Top = 2
            Width = 655
            Height = 252
            Align = alClient
            BevelInner = bvLowered
            BevelWidth = 2
            TabOrder = 0
            object Label2: TLabel
              Left = 19
              Top = 23
              Width = 63
              Height = 13
              Caption = 'Raz'#227'o Social'
            end
            object Label3: TLabel
              Left = 19
              Top = 47
              Width = 71
              Height = 13
              Caption = 'Nome Fantasia'
            end
            object Label4: TLabel
              Left = 19
              Top = 71
              Width = 27
              Height = 13
              Caption = 'CNPJ'
            end
            object Label5: TLabel
              Left = 216
              Top = 74
              Width = 47
              Height = 13
              Caption = 'I.Estadual'
            end
            object Label6: TLabel
              Left = 19
              Top = 103
              Width = 46
              Height = 13
              Caption = 'Endereco'
            end
            object Label7: TLabel
              Left = 19
              Top = 123
              Width = 27
              Height = 13
              Caption = 'Bairro'
            end
            object Label8: TLabel
              Left = 319
              Top = 98
              Width = 25
              Height = 13
              Caption = 'Num.'
            end
            object Label9: TLabel
              Left = 19
              Top = 145
              Width = 21
              Height = 13
              Caption = 'CEP'
            end
            object Label10: TLabel
              Left = 19
              Top = 169
              Width = 33
              Height = 13
              Caption = 'Cidade'
            end
            object Label11: TLabel
              Left = 250
              Top = 170
              Width = 14
              Height = 13
              Caption = 'UF'
            end
            object Label12: TLabel
              Left = 19
              Top = 194
              Width = 42
              Height = 13
              Caption = 'Telefone'
            end
            object Label16: TLabel
              Left = 19
              Top = 220
              Width = 70
              Height = 13
              Caption = 'C'#243'd. Municipio'
            end
            object EdtRazao: TEdit
              Left = 99
              Top = 23
              Width = 121
              Height = 21
              TabOrder = 0
            end
            object EdtFantasia: TEdit
              Left = 99
              Top = 47
              Width = 121
              Height = 21
              TabOrder = 1
            end
            object EdtIE: TEdit
              Left = 267
              Top = 71
              Width = 121
              Height = 21
              TabOrder = 2
            end
            object EdtCNPJ: TEdit
              Left = 99
              Top = 71
              Width = 105
              Height = 21
              TabOrder = 3
            end
            object EdtEndereco: TEdit
              Left = 99
              Top = 95
              Width = 211
              Height = 21
              TabOrder = 4
            end
            object EdtBairro: TEdit
              Left = 99
              Top = 119
              Width = 121
              Height = 21
              TabOrder = 5
            end
            object EdtNum: TEdit
              Left = 347
              Top = 96
              Width = 41
              Height = 21
              TabOrder = 6
            end
            object EdtCEP: TEdit
              Left = 99
              Top = 143
              Width = 121
              Height = 21
              TabOrder = 7
            end
            object EdtCidade: TEdit
              Left = 99
              Top = 167
              Width = 121
              Height = 21
              TabOrder = 8
            end
            object EdtTelefone: TEdit
              Left = 99
              Top = 191
              Width = 121
              Height = 21
              TabOrder = 9
            end
            object EdtCodMun: TEdit
              Left = 99
              Top = 215
              Width = 121
              Height = 21
              TabOrder = 10
              OnKeyPress = EdtCodMunKeyPress
            end
            object EdtUF: TComboBox
              Left = 272
              Top = 166
              Width = 56
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 24
              TabOrder = 11
              Text = 'SP'
              Items.Strings = (
                'AC '
                'AL '
                'AP '
                'AM '
                'BA'
                'CE '
                'DF'
                'ES'
                'GO '
                'MA '
                'MT '
                'MS '
                'MG '
                'PA'
                'PB '
                'PR '
                'PE '
                'PI '
                'RJ'
                'RN '
                'RS'
                'RO '
                'RR '
                'SC '
                'SP'
                'SE '
                'TO')
            end
            object RadioRegime: TRadioGroup
              Left = 348
              Top = 130
              Width = 293
              Height = 73
              Caption = 'Regime da Empresa:'
              ItemIndex = 0
              Items.Strings = (
                'Simples Nacional'
                'Regime Normal'
                'Simples Nacional - excesso de sublime da receita bruta')
              TabOrder = 12
            end
          end
        end
      end
      object TabWebService: TTabSheet
        Cursor = crHandPoint
        Caption = 'WebService'
        ImageIndex = 1
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 659
          Height = 256
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Panel7: TPanel
            Left = 2
            Top = 2
            Width = 655
            Height = 252
            Align = alClient
            BevelInner = bvLowered
            BevelWidth = 2
            TabOrder = 0
            object UF: TLabel
              Left = 25
              Top = 19
              Width = 14
              Height = 13
              Caption = 'UF'
            end
            object RadioAmbiente: TRadioGroup
              Left = 21
              Top = 43
              Width = 193
              Height = 51
              Caption = ' Ambiente de Destino '
              Items.Strings = (
                'Produ'#231#227'o'
                'Homologa'#231#227'o')
              TabOrder = 0
            end
            object GroupBox10: TGroupBox
              Left = 21
              Top = 104
              Width = 250
              Height = 129
              Caption = ' Conex'#227'o '
              TabOrder = 1
              object Label13: TLabel
                Left = 16
                Top = 24
                Width = 22
                Height = 13
                Caption = 'Host'
              end
              object Label14: TLabel
                Left = 16
                Top = 50
                Width = 25
                Height = 13
                Caption = 'Porta'
              end
              object Label15: TLabel
                Left = 16
                Top = 74
                Width = 36
                Height = 13
                Caption = 'Usu'#225'rio'
              end
              object Label17: TLabel
                Left = 16
                Top = 98
                Width = 31
                Height = 13
                Caption = 'Senha'
              end
              object EdtHost: TEdit
                Left = 64
                Top = 24
                Width = 167
                Height = 21
                TabOrder = 0
              end
              object EdtPorta: TEdit
                Left = 64
                Top = 48
                Width = 167
                Height = 21
                TabOrder = 1
              end
              object EdtUsuario: TEdit
                Left = 64
                Top = 72
                Width = 167
                Height = 21
                TabOrder = 2
              end
              object EdtSenhaWS: TEdit
                Left = 64
                Top = 96
                Width = 167
                Height = 21
                TabOrder = 3
              end
            end
            object EdtUFWS: TComboBox
              Left = 45
              Top = 15
              Width = 56
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 24
              TabOrder = 2
              Text = 'SP'
              Items.Strings = (
                'AC '
                'AL '
                'AP '
                'AM '
                'BA'
                'CE '
                'DF'
                'ES'
                'GO '
                'MA '
                'MT '
                'MS '
                'MG '
                'PA'
                'PB '
                'PR '
                'PE '
                'PI '
                'RJ'
                'RN '
                'RS'
                'RO '
                'RR '
                'SC '
                'SP'
                'SE '
                'TO')
            end
          end
        end
      end
      object TabEmail: TTabSheet
        Caption = 'Email'
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 659
          Height = 256
          Align = alClient
          BevelInner = bvLowered
          BevelWidth = 2
          TabOrder = 0
          object GroupBox1: TGroupBox
            Left = 21
            Top = 16
            Width = 292
            Height = 129
            Caption = ' Conex'#227'o '
            TabOrder = 0
            object Label19: TLabel
              Left = 16
              Top = 24
              Width = 22
              Height = 13
              Caption = 'Host'
            end
            object Label20: TLabel
              Left = 16
              Top = 50
              Width = 25
              Height = 13
              Caption = 'Porta'
            end
            object Label21: TLabel
              Left = 16
              Top = 74
              Width = 36
              Height = 13
              Caption = 'Usu'#225'rio'
            end
            object Label22: TLabel
              Left = 16
              Top = 98
              Width = 31
              Height = 13
              Caption = 'Senha'
            end
            object editHostEnvioEmail: TEdit
              Left = 64
              Top = 24
              Width = 162
              Height = 21
              TabOrder = 0
            end
            object editPortaEnvioEmail: TEdit
              Left = 64
              Top = 48
              Width = 162
              Height = 21
              TabOrder = 1
            end
            object editUsuarioEnvioEmail: TEdit
              Left = 64
              Top = 72
              Width = 162
              Height = 21
              TabOrder = 2
            end
            object editSenhaEnvioEmail: TEdit
              Left = 64
              Top = 96
              Width = 162
              Height = 21
              TabOrder = 3
            end
          end
        end
      end
    end
  end
  object imgPop: TImageList
    Left = 488
    Top = 72
    Bitmap = {
      494C010107000A000C0010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      00006C6A6A006C6A6A0000000000000000006C6A6A006C6A6A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B1908E00B190
      8E00B1908E00B1908E00B1908E00B1908E00B1908E00B1908E00B1908E00B190
      8E00B1908E00B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006C6A
      6A00AAA7A700A19F9F006C6A6A006C6A6A006C6A6A00E5E3E3006C6A6A006C6A
      6A006C6A6A000000000000000000000000000000000000000000C9680000C968
      0000C9680000C9680000C9680000C9680000C9680000C9680000C9680000C968
      0000C9680000C968000000000000000000000000000000000000B1908E00FEFB
      FA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFB
      FA00FEFBFA00B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006C6A6A00DAD9
      D900A19F9F00A19F9F00A19F9F0037363600353535006C6D6D00BFBFBF00E1E2
      E200B7B6B6006C6A6A006C6A6A006C6A6A0000000000C9680000FEE9D000FEE6
      CA00FEE1C200FEDEBB00FED9B300FED8B100FED5AA00FED3A600FDD1A100FDD1
      A100FDD1A100FDD1A100C9680000000000000000000000000000B1908E00FEFB
      FA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFBFA00FEFB
      FA00FEFBFA00B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006C6A6A00D4D3D300CACA
      CA008E8C8C008E8C8C008E8C8C003C3B3B000A090A00070707000B0B0B000707
      07007A7A7A00BBBBBB006C6A6A000000000000000000C9680000FEEBD500FEE8
      CF00FEE6CA00FEE1C200FEDEBB00FEDCB700FED8B100FED5AA00FED3A600FDD1
      A100FDD1A100FDD1A100C9680000000000000000000000000000B1908E00FEFA
      F400FEFAF400FEFAF400FEFAF400FEFAF400FEFAF400FEFAF400FEFAF400FEFA
      F400FEFAF400B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006C6A6A00CACACA00CACACA008E8C
      8C00D7D4D400CECBCB00BFBCBC00B1AFAF00A3A0A000888686005E5B5C000707
      070009090900080808006C6A6A007673730000000000C9680000FEEEDC000080
      0000008000000080000000800000008000000080000000800000008000000080
      000000800000FDD1A100C9680000000000000000000000000000B1908E00FEF7
      F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7F000FEF7
      F000FEF7F000B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006C6A6A00CACACA008E8C8C00EFEE
      EE00FFFEFE00FBFAFA00E3E0E100DEDEDE00DEDDDD00CFCECE00BDBCBC00ADAB
      AB008B898900585656007A7878007573730000000000C9680000FEF1E300FEEE
      DC00FEEBD500FEE9D000FEE6CA00FEE1C200FEDEBB00FEDCB700FED8B100FED5
      AA00FED3A600FDD1A100C9680000000000000000000000000000B1908E00FEF4
      EB00FEF4EB00FEF4EB00FEF4EB00FEF4EB00FEF4EB00FEF4EB00FEF4EB00FEF4
      EB00FEF4EB00B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006C6A6A008E8C8C00FFFFFF00FEFC
      FC00FAFAFA00D5D4D50098919300A0989900B2ABAC00C4C0C100D7D7D700D8D8
      D800C7C6C600B7B6B600918F8F006C69690000000000C9680000FEF4E8000080
      0000008000000080000000800000008000000080000000800000008000000080
      000000800000FED3A600C9680000000000000000000000000000B1908E00FEF2
      E600FEF2E600FEF2E600FEF2E600FEF2E600FEF2E600FEF2E600FEF2E600FEF2
      E600FEF2E600B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006C6A6A006C6A6A00EDEB
      EB00B1A6A7007A6F72008A83880096929500969091009D9798009A9395009E98
      9900BBBABA00D1D1D100C2C2C2006C6A6A0000000000C9680000FEF7F000FEF4
      E800FEF1E200FEEFDF00FEEBD500FEE9D000FEE6CA00FEE1C200FEDEBB00FEDC
      B700FED8B100FED5AA00C9680000000000000000000000000000B1908E00FEEF
      E200FEEFE200FEEFE200FEEFE200FEEFE200FEEFE200FEEFE200FEEFE200FEEF
      E200FEEFE200B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006C6A
      6A00BB897F00A7876D008B6F64007D6760006F626500797379008F8B8E00A9A3
      A400CBCACA00C1C1C1006C6A6A000000000000000000C9680000FEFAF4000080
      0000008000000080000000800000008000000080000000800000008000000080
      000000800000FED8B100C9680000000000000000000000000000B1908E00FFED
      DD00FFEDDD00FFEDDD00FFEDDD00FFEDDD00FFEDDD00FFEDDD00FFEDDD00FFED
      DD00FFEDDD00B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BD828100FFE3B400FFD39F00E9B28100C9997300BA916C00BD828100807D
      7E006C6A6A006C6A6A00000000000000000000000000C9680000FEFBF800FEFA
      F400FEF7F000FEF4E800FEF1E200FEEEDC00FEEBD500FEE9D000FEE6CA00FEE1
      C200FEDEBB00FEDCB700C9680000000000000000000000000000B1908E00FFED
      DD00FFEBD900FFEDDD00FFEBD900FFEDDD00FFEBD900D3C1B100D3C1B100D3C1
      B100D3C1B100B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BD828100FFE0B800FFD3A700FFD09D00FFCE9000FFC68800BD8281000000
      00000000000000000000000000000000000000000000C9680000FEFCF9000080
      0000008000000080000000800000008000000080000000800000008000000080
      000000800000FEDEBB00C9680000000000000000000000000000B1908E00FFEB
      D900FFE6CF00FFEBD900FFE6CF00FFEBD900FFEBD900B5A19300B2A09200B09E
      9000B09E9000B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C086
      8300FFE7CF00FFE0C000FFD9B200FFD3A500FFD09900BD828100000000000000
      00000000000000000000000000000000000000000000C9680000FEFCF900FEFC
      F900FEFBF700FEFAF400FEF7F000FEF4E800FEF1E200FEEFDF00FEEBD500FEE9
      D000FEE6CA00FEE1C200C9680000000000000000000000000000B1908E00FFE6
      CF00FFE6CF00FFE6CF00FFE6CF00FFE6CF00FFE6CF009C8B7E009C8B7E009C8B
      7E009C8B7E00B1908E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BD82
      8100FEEBD800FFE6CC00FFDEBD00FFD8B100FED3A400BD828100000000000000
      00000000000000000000000000000000000000000000C9680000FEFCF9000080
      0000008000000080000000800000008000000080000000800000008000000080
      000000800000FEE6CA00C9680000000000000000000000000000B1908E00FFE6
      CF00FFE1C600FFE6CF00FFE1C600FFE6CF00B5A19300FEF4EB00FEF4EB00DECF
      CE00B1908E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD828100FFFF
      F200FFFFF200FFEBD800FFE5CA00FFE1BD00F3C7A700BD828100000000000000
      00000000000000000000000000000000000000000000C9680000FEFCF900FEFC
      F900FEFCF900FEFCF900FEFBF700FEFAF400FEF7F000FEF4E800FEF1E200FEEF
      DF00FEEBD500FEE9D000C9680000000000000000000000000000B1908E00FFE1
      C600FFE1C600FFE1C600FFE1C600FFE1C600BAA69700FEFAF400D3C1B100B190
      8E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD828100BD82
      8100BD828100FBEFE200FBE3CF00FBDDC200BD82810000000000000000000000
      0000000000000000000000000000000000000000000000000000C9680000C968
      0000C9680000C9680000C9680000C9680000C9680000C9680000C9680000C968
      0000C9680000C968000000000000000000000000000000000000B1908E00FFDE
      C200FFDEC200FFDEC200FFDEC200FFDEC200B5A19300D3C1B100B1908E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BD828100BD828100BD8281000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B1908E00B190
      8E00B1908E00B1908E00B1908E00B1908E00B1908E00B1908E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000094000000
      9400000094000000940000009400000094000000940000009400000094000000
      9400000094000000940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000094000000
      9400000094000000940000009400000094000000940000009400000094000000
      9400000094000000940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000094000000
      9400000000000000940000009400000000000000000000000000000000000000
      0000000094000000940000000000000000000000000000000000000000000000
      0000636363006363630063636300636363006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000007B0000007B000000
      0000000000000000000000000000000000000000000000000000000094000000
      9400000000000000940000009400000000000000000000009400000094000000
      0000000094000000940000000000000000000000000000000000000000000000
      000063636300CECECE00CECECE00CECECE00CECECE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000007B0000007B000000
      0000000000000000000000000000000000000000000000000000000094000000
      9400000000000000000000009400000094000000940000009400000094000000
      0000000094000000940000000000000000000000000000000000000000000000
      000063636300CECECE00CECECE00CECECE00CECECE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B00000000000000000000000000000000000000000000007B000000
      7B00000000000000000000000000000000000000000000000000000094000000
      9400000000000000000000000000000094000000940000000000000000000000
      0000000094000000940000000000000000000000000000000000000000000000
      000063636300CECECE00CECECE00CECECE00CECECE0063636300636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B00000000000000000000000000000000000000000000000000000000000000
      7B0000007B000000000000000000000000000000000000000000000094000000
      9400000000000000000000009400000094000000940000009400000000000000
      0000000094000000940000000000000000000000000000000000000000000000
      0000636363006363630063636300636363006363630063636300CECECE006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000000000000000000000000000007B0000007B0000007B000000
      7B0000007B000000000000000000000000000000000000000000000094000000
      9400000000000000000000009400000000000000940000009400000094000000
      0000000094000000940000000000000000000000000000000000000000000000
      0000636363006363630063636300636363006363630063636300CECECE006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000094000000
      9400000000000000000000009400000000000000000000009400000094000000
      0000000094000000940000000000000000000000000000000000000000000000
      0000000000000000000063636300CECECE00CECECE00CECECE00CECECE006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7B0000007B0000000000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000000000000000000000000000000094000000
      9400000000000000000000000000000000000000000000000000000000000000
      0000000094000000940000000000000000000000000000000000000000000000
      0000000000000000000063636300636363006363630063636300636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000000000000000000000000000000094000000
      9400000094000000940000009400000094000000940000009400000094000000
      9400000094000000940000000000000000000000000000000000000000000000
      0000000000000000000063636300636363006363630063636300636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE630000CE630000CE63
      0000CE6300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000094000000
      9400000094000000940000009400000094000000940000009400000094000000
      9400000094000000940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00F33FFFFFC0030000E007C003C0030000
      C0008001C003000080018001C003000000008001C003000000008001C0030000
      00008001C003000080008001C0030000E0018001C0030000F0038001C0030000
      F01F8001C0030000E03F8001C0030000E03F8001C0070000C03F8001C00F0000
      C07FC003C01F0000F8FFFFFFC03F0000FFFFFFFFFFFFFFFFFFFFF800FFFFFFFF
      FFFFFBFEC003FFFFFFFF0202C003FFFFFFFF7BFEC9F3F03FA22A439EC993F03F
      AFBF7B9ECC13F03FA23F63CECE73F00FBBBF6BE6CC33F00FA23F6306CD13F00F
      FFFF6BFECD93FC0FFFFF6000CFF3FC0FFFFF7800C003FC0FFFFF0000C003FFFF
      FFFF001FFFFFFFFFFFFF001FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Left = 512
    Top = 136
    object ActConfirmar: TAction
      Caption = 'F2 - Confirmar'
      ShortCut = 113
      OnExecute = ActConfirmarExecute
    end
    object ActFechar: TAction
      Caption = 'F10 - Fechar'
      ShortCut = 121
      OnExecute = ActFecharExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 548
    Top = 160
  end
end
