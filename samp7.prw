#include "protheus.ch"

user function samp7()
	Local cTab := "ZJ0"
	Private cCadastro := "Pessoas"

	DbSelectArea(cTab)
	(cTab)->(DbSetOrder(1))

	MBrowse(,,,,cTab)
return


Static Function Menudef()
	Local aMenu := {}
	Local aOptAnimais := {}

	AADD(aMenu, {"Pesquisar"	,"AxPesqui"	 , 0, 1 } )
	AADD(aMenu, {"Visualizar"	,"AxVisual"	 , 0, 2 } )
	AADD(aMenu, {"Incluir"		,"AxInclui"  , 0, 3 } )
	AADD(aMenu, {"Alterar"		,"AxAltera"	 , 0, 4 } )
	AADD(aMenu, {"Excluir"		,"AxDeleta"	 , 0, 5 } )
	
	AADD(aOptAnimais, {"Ver Animais"	, "u_s7Ver"	 , 0, 2 } )
	AADD(aOptAnimais, {"Alterar Vínculos", "u_s7Alt"	 , 0, 4 } )

	AADD(aMenu, {"Animais"	,aOptAnimais	 , 0, 1 } )
Return aMenu


User Function s7Ver(cAlias, nRecno, nOpc)
	Local aHeaderZJ2 := {}
	Local aColsZJ2 := {}
	Local cSeek := ""
	Local cWhile := ""
	Local oGetDados := Nil
	Local oDlg := Nil
	Local oEnchoice := Nil
	
	DbSelectArea("ZJ2")

	cSeek  := xFilial("ZJ2")+ZJ0->ZJ0_ID 
 	cWhile := "ZJ2->ZJ2_FILIAL + ZJ2->ZJ2_IDPESS"

	FillGetDados( 2, "ZJ2", 1, cSeek,; 
				{||&(cWhile)}, /*{|| bCond,bAct1,bAct2}*/, /*aNoFields*/,; 
				/*aYesFields*/, /*lOnlyYes*/, /*cQuery*/, /*bMontAcols*/, .F. /*lEmptyInc*/,; 
				aHeaderZJ2 /*aHeaderAux*/, aColsZJ2 /*aColsAux*/,/*bafterCols*/ , /*bBeforeCols*/,;
				/*bAfterHeader*/, /*cAliasQry*/)
	
	Define MSDialog oDlg Title "Ver Animais" From 0,0 To 400,600 Pixel

	RegToMemory("ZJ0",.F.)
	oEnchoice := MsMGet():New("ZJ0" /*cAlias*/, , 2 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 0/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	oGetDados := MsNewGetDados():New( 100/*nTop*/, 0/*nLeft*/,200/*nBottom*/,300/*nRight*/,;
								/*GD_INSERT + GD_UPDATE + GD_DELETE*/ /*nStyle*/, /*uLinhaOk*/,/*uTudoOk*/,/*cIniCpos*/,;
								/*aAlter*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,;
								/*uSuperDel*/,/*uDelOk*/, oDlg /*oWnd*/, aHeaderZJ2 /*aHeader*/,;
								aColsZJ2 /*aCols*/, /*uChange*/, /*cTela*/ )

	Activate MSDialog oDlg Centered
Return


User Function s7Alt(cAlias, nRecno, nOpc)
	Local aHeaderZJ2 := {}
	Local aColsZJ2 := {}
	Local cSeek := ""
	Local cWhile := ""
	Local oGetDados := Nil
	Local oDlg := Nil
	Local oEnchoice := Nil
	Local nOpca := 0
	
	DbSelectArea("ZJ2")

	cSeek  := xFilial("ZJ2")+ZJ0->ZJ0_ID 
 	cWhile := "ZJ2->ZJ2_FILIAL + ZJ2->ZJ2_IDPESS"

	FillGetDados( 4, "ZJ2", 1, cSeek,; 
				{||&(cWhile)}, /*{|| bCond,bAct1,bAct2}*/, /*aNoFields*/,; 
				/*aYesFields*/, /*lOnlyYes*/, /*cQuery*/, /*bMontAcols*/, .F. /*lEmptyInc*/,; 
				aHeaderZJ2 /*aHeaderAux*/, aColsZJ2 /*aColsAux*/,/*bafterCols*/ , /*bBeforeCols*/,;
				/*bAfterHeader*/, /*cAliasQry*/)
	
	Define MSDialog oDlg Title "Alterar Vínculos" From 0,0 To 400,600 Pixel
	
	RegToMemory("ZJ0",.F.)
	oEnchoice := MsMGet():New("ZJ0" /*cAlias*/, , 2 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 30/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	// Cria o grid para alteração
	oGetDados := MsNewGetDados():New( 100/*nTop*/, 0/*nLeft*/,200/*nBottom*/,300/*nRight*/,;
								GD_INSERT + GD_UPDATE + GD_DELETE /*nStyle*/, /*uLinhaOk*/,/*uTudoOk*/,/*cIniCpos*/,;
								/*aAlter*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,;
								/*uSuperDel*/,/*uDelOk*/, oDlg /*oWnd*/, aHeaderZJ2 /*aHeader*/,;
								aColsZJ2 /*aCols*/, /*uChange*/, /*cTela*/ )

	Activate MSDialog oDlg CENTERED ON INIT EnchoiceBar(oDlg, {|| nOpca := 1, oDlg:End() }/*bOK*/, {|| oDlg:End() } /*bCancel*/ )

	If nOpca == 1
		// Gravar os dados do aCols na tabela ZJ2
		Gravar( aHeaderZJ2, oGetDados:aCols )
	EndIf

Return


Static Function Gravar( aHeader, aCols )
	Local nLinha := 0
	Local nPosRecWt := 0
	Local nLastPos := 0

	// Descobrir posição do campo RecnoWT no aHeader
	nPosRecWt := aScan( aHeader, {|x|x[2]=="ZJ2_REC_WT" } )
	nLastPos := Len(aHeader)+1
	
	For nLinha := 1 To Len(aCols)
		// Avaliar se o RecnoWT é Zero no aCols
		If aCols[nLinha,nPosRecWt] == 0
			// Se for 0 devo incluir um registro
			// Reclock com .T.
			GravarZJ2( 3,;
					 /*como pegar o id pessoa / M->ZJ0_ID funciona? */,;
					 /*como pegar o id animal / e aqui precisa do quê? */ )
		Else
		// Caso não seja inclusão
			// Posicionar no Recno lido do campo RecnoWT
			ZJ2->( DbGoTo( aCols[nLinha,nPosRecWt] ) )
			// A linha foi excluída no aCols?

			If aCols[nLinha,nLastPos]
			//   verificar o último campo do aCols (.T. foi excluída)
				// usar o DbDelete
				GravarZJ2( 5,; // precisa dos demais parâmetros?
					 /*como pegar o id pessoa / M->ZJ0_ID funciona? */,;
					 /*como pegar o id animal / e aqui precisa do quê? */ )
			Else
			// Se não foi  excluída a linha 
				// Alterar o conteúdo dos campos na linha posicionada
				GravarZJ2( 4,; // precisa dos demais parâmetros?
					 /*como pegar o id pessoa / M->ZJ0_ID funciona? */,;
					 /*como pegar o id animal / e aqui precisa do quê? */ )
			EndIf

		EndIf
	Next nLinha

Return


Static Function GravarZJ2( nOpc, cIdPessoa, cIdAnimal )
	If nOpc == 5
		Reclock("ZJ2",.F.)
			ZJ2->(DbDelete())
		ZJ2->(MsUnlock())
	Else
		Reclock("ZJ2",(nOpc==3))
			ZJ2->ZJ2_FILIAL := xFilial("ZJ2")
			ZJ2->ZJ2_IDPESS := cIdPessoa
			ZJ2->ZJ2_IDANIM := cIdAnimal
		ZJ2->(MsUnlock())
	EndIf
Return