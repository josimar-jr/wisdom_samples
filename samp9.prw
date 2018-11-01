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
	AADD(aMenu, {"Visualizar Meu"	,"u_Smp9Vis" ,0,2})
	AADD(aMenu, {"Incluir Meu"		,"u_Smp9Inc" ,0,3})
	AADD(aMenu, {"Alterar Meu"		,"u_Smp9Alt" ,0,4})
	AADD(aMenu, {"Excluir Meu"		,"u_Smp9Exc" ,0,5})
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
	oEnchoice:oBox:Align := CONTROL_ALIGN_ALLCLIENT

	Activate MSDialog oDlg CENTERED ON INIT EnchoiceBar(oDlg, ;
			{|| If( Obrigatorio( oEnchoice:aGets, oEnchoice:aTela ), (nOpca := 1, oDlg:End() ), Nil ) }/*bOK*/,;
			 {|| oDlg:End() } /*bCancel*/ )

	If nOpca == 1
		Gravar( 3 )
	EndIf
Return


User Function Smp9Alt( cAlias, nRecno, nOpcMenu )
	Local oDlg := Nil
	Local oEnchoice := Nil
	Local nOpca := 0

	Define MSDialog oDlg Title "Vínculos - Alterar" From 0,0 To 400,600 Pixel
	
	RegToMemory("ZJ2",.F.)
	oEnchoice := MsMGet():New("ZJ2" /*cAlias*/, , 4 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 30/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	Activate MSDialog oDlg CENTERED ON INIT EnchoiceBar(oDlg, {|| nOpca := 1, oDlg:End() }/*bOK*/, {|| If( MsgYesNo("Tem certeza que deseja sair?"), (Alert("Saindo..."), oDlg:End()), Nil ) } /*bCancel*/ )

	If nOpca == 1
		Gravar( 4 )
	EndIf
Return


User Function Smp9Exc( cAlias, nRecno, nOpcMenu )
	Local oDlg := Nil
	Local oEnchoice := Nil
	Local nOpca := 0

	Define MSDialog oDlg Title "Vínculos - Excluir" From 0,0 To 400,600 Pixel
	
	RegToMemory("ZJ2",.F.)
	oEnchoice := MsMGet():New("ZJ2" /*cAlias*/, , 5 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 30/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	Activate MSDialog oDlg CENTERED ON INIT EnchoiceBar(oDlg, {|| nOpca := 1, oDlg:End() }/*bOK*/, {|| If( MsgYesNo("Tem certeza que deseja sair?"), (Alert("Saindo..."), oDlg:End()), Nil ) } /*bCancel*/ )

	If nOpca == 1
		Gravar( 5 )
	EndIf
Return

Static Function Gravar( nOpc )
	If nOpc == 5
		Reclock("ZJ2",.F.)
			ZJ2->(DbDelete())
		ZJ2->(MsUnlock())
	Else
		Reclock("ZJ2",(nOpc==3))
			ZJ2->ZJ2_FILIAL := xFilial("ZJ2")
			ZJ2->ZJ2_IDPESS := M->ZJ2_IDPESS
			ZJ2->ZJ2_IDANIM := M->ZJ2_IDANIM
		ZJ2->(MsUnlock())
	EndIf
Return



User Function Smp9Vis( cAlias, nRecno, nOpcMenu )
	Local oDlg := Nil
	Local oEnchoice := Nil

	Define MSDialog oDlg Title "Vínculos - Visualizar" From 0,0 To 400,600 Pixel
	
	RegToMemory("ZJ2",.F.)
	oEnchoice := MsMGet():New("ZJ2" /*cAlias*/, , 2 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 30/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	Activate MSDialog oDlg CENTERED ON INIT EnchoiceBar(oDlg, {|| nOpca := 1, oDlg:End() }/*bOK*/, {|| If( MsgYesNo("Tem certeza que deseja sair?"), (Alert("Saindo..."), oDlg:End()), Nil ) } /*bCancel*/ )
Return