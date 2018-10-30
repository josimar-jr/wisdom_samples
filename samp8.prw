#include 'protheus.ch'

user function samp8()
	Local cTab := "ZJ1"
	Private cCadastro := "Animais"

	DbSelectArea(cTab)
	(cTab)->(DbSetOrder(3))

	MBrowse(,,,,cTab)
return

Static Function Menudef()
	Local aMenu := {}

	AADD(aMenu, {"Pesquisar Meu"	,"AxPesqui"	 ,0,1})
	AADD(aMenu, {"Visualizar Meu"	,"AxVisual"	 ,0,2})
	AADD(aMenu, {"Incluir Meu"		,"u_Smp8Inc"    ,0,3})
	AADD(aMenu, {"Alterar Meu"		,"AxAltera"	 ,0,4})
	AADD(aMenu, {"Excluir Meu"		,"AxDeleta"	 ,0,5})
Return aMenu


User Function Smp8Inc( cAlias, nReg, nOpc )
	AxInclui(cAlias, nReg, nOpc)
Return
