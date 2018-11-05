#include 'protheus.ch'

Static cMarca := ""

User Function sampMark()
	Static oMark 
	oMark := FWMarkBrowse():New()
	oMark:SetMenudef("SampMark")
	oMark:SetAlias('ZJ0')
	oMark:SetFieldMark("ZJ0_MARK")

	oMark:Activate()
Return


Static Function Menudef()
	Local aMenu := {}
	AADD(aMenu,{"Visualizar Lote","U_VisMark" ,0,2})
Return aMenu


User Function VisMark(cAlias, nRecno, nOpcMenu)
	DbSelectArea("SA1")
	ZJ0->(DbGoTop())
	
	Conout("Registros Marcados")
	While ZJ0->(!EOF())
		If ZJ0->ZJ0_MARK == oMark:cMark
			Conout( ZJ0->(ZJ0_FILIAL + ZJ0_ID + ZJ0_NOME ) )
		EndIf
		ZJ0->(DbSkip())
	End
Return



