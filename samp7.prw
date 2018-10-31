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

	oEnchoice := MsMGet():New("ZJ0" /*cAlias*/, , 4 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 0/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						/*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )
	
	oGetDados := MsNewGetDados():New( 100/*nTop*/, 0/*nLeft*/,300/*nBottom*/,400/*nRight*/,;
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
	
	DbSelectArea("ZJ2")

	cSeek  := xFilial("ZJ2")+ZJ0->ZJ0_ID 
 	cWhile := "ZJ2->ZJ2_FILIAL + ZJ2->ZJ2_IDPESS"

	FillGetDados( 4, "ZJ2", 1, cSeek,; 
				{||&(cWhile)}, /*{|| bCond,bAct1,bAct2}*/, /*aNoFields*/,; 
				/*aYesFields*/, /*lOnlyYes*/, /*cQuery*/, /*bMontAcols*/, .F. /*lEmptyInc*/,; 
				aHeaderZJ2 /*aHeaderAux*/, aColsZJ2 /*aColsAux*/,/*bafterCols*/ , /*bBeforeCols*/,;
				/*bAfterHeader*/, /*cAliasQry*/)
	
	Define MSDialog oDlg Title "Alterar Vínculos" From 0,0 To 300,400 Pixel

	oEnchoice := MsMGet():New("ZJ0" /*cAlias*/, , 4 /*nOpc*/,;
						, , , /*aAcho*/,;
						/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						/*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	// Cria o grid para alteração
	oGetDados := MsNewGetDados():New( 0/*nTop*/, 0/*nLeft*/,510/*nBottom*/,460/*nRight*/,;
								GD_INSERT + GD_UPDATE + GD_DELETE /*nStyle*/, /*uLinhaOk*/,/*uTudoOk*/,/*cIniCpos*/,;
								/*aAlter*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,;
								/*uSuperDel*/,/*uDelOk*/, oDlg /*oWnd*/, aHeaderZJ2 /*aHeader*/,;
								aColsZJ2 /*aCols*/, /*uChange*/, /*cTela*/ )

	Activate MSDialog oDlg Centered



Return