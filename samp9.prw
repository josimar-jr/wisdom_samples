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
	AxInclui(cAlias, nReg, nOpc)
Return
