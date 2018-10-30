#include 'protheus.ch'
function u_samp4()
	Local cFilTabs := ''
	Local lFound := .F.
	Local cCodigo := "C7    "
	Local cNome := "CLIENTE 7                               "
	RpcSetEnv('15','00001')

	DbSelectArea("SA1")
	cFilTabs := xFilial("SA1")
	lFound := SA1->( DBSeek( cFilTabs + cCodigo ))
	
	SA1->( DbSetOrder( 2 ) )

	DbSelectArea("SA2")
	
	lFound := SA1->( DBSeek( cFilTabs + cCodigo ))
	lFound := SA1->( DBSeek( cFilTabs + cNome ))

	RpcClearEnv()
return



Static Function grava()

	Reclock("ZZ1",.T.)
		// gravei meus campos
		ZZ1_FILIAL
		ZZ1_CODIGO
		ZZ1_CPROD

		If ExistBlock("zz1grava")
			ExecBlock("zz1grava")
		EndIf
	ZZ1->(MsUnlock())

Return


user function zz1grava()
	ZZ1_XCMP1
	ZZ1_XCMP2
	ZZ1_XCMP3
	ZZ1_XCMP4
	ZZ1_XCMP5
return