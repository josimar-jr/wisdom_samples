#include 'protheus.ch'

user function samp9()
	Local cTab := "ZJ2"
	Private cCadastro := "Pessoas x Animais"

	DbSelectArea(cTab)
	(cTab)->(DbSetOrder(1))

	MBrowse(,,,,cTab)
return

Static Function Menudef()
	Local aMenu := {}

	AADD(aMenu, {"Pesquisar Meu"	,"AxPesqui"	 ,0,1})
	AADD(aMenu, {"Visualizar Meu"	,"AxVisual"	 ,0,2})
	AADD(aMenu, {"Incluir Meu"		,"u_Smp9Inc" ,0,3})
	AADD(aMenu, {"Alterar Meu"		,"AxAltera"	 ,0,4})
	AADD(aMenu, {"Excluir Meu"		,"AxDeleta"	 ,0,5})
Return aMenu


User Function Smp9Inc( cAlias, nRecno, nOpcMenu )
	Local oDlg := Nil
	Local oEnchoice := Nil
	Local nOpca := 0

	Define MSDialog oDlg Title "Vínculos - Incluir" From 0,0 To 400,600 Pixel
	
	RegToMemory("ZJ2",.T.)
	oEnchoice := MsMGet():New("ZJ2" /*cAlias*/, , 3 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 30/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	Activate MSDialog oDlg CENTERED ON INIT EnchoiceBar(oDlg, {|| nOpca := 1, oDlg:End() }/*bOK*/, {|| If( MsgYesNo("Tem certeza que deseja sair?"), (Alert("Saindo..."), oDlg:End()), Nil ) } /*bCancel*/ )

	If nOpca == 1
		Gravar()
	EndIf
Return


Static Function Gravar()
	Reclock("ZJ2",.T.)
		ZJ2->ZJ2_FILIAL := xFilial("ZJ2")
		ZJ2->ZJ2_IDPESS := M->ZJ2_IDPESS
		ZJ2->ZJ2_IDANIM := M->ZJ2_IDANIM
	ZJ2->(MsUnlock())
Return