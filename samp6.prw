#include "protheus.ch"

user function samp6()
	Local cTab := "ZZ1"
	
	DbSelectArea(cTab)
	(cTab)->(DbSetOrder(2))

	MBrowse( ,,,,cTab)
return

Static Function Menudef()
	Local aMenu := {}

	AADD(aMenu, {"Pesquisar Meu"	,"AxPesqui"	 ,0,1})
	AADD(aMenu, {"Visualizar Meu"	,"AxVisual"	 ,0,2})
	AADD(aMenu, {"Incluir Meu"		,"u_Smp6Inc"    ,0,3})
	AADD(aMenu, {"Alterar Meu"		,"AxAltera"	 ,0,4})
	AADD(aMenu, {"Excluir Meu"		,"AxDeleta"	 ,0,5})
Return aMenu


User Function Smp6Inc( cAlias, nReg, nOpc )
	AxInclui(cAlias, nReg, nOpc)
Return
