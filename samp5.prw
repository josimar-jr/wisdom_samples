#include 'protheus.ch'

function u_samp5()
	Local cCodigo := '1'
	Local cProd := 'A'
	Local lFound := .F.

	RpcSetEnv('15','00001')

	cFilAnt := "00002"

	DbSelectArea("ZZ1")
	ZZ1->( DbSetOrder( 2 ) ) // ZZ1_FILIAL + ZZ1_CPROD

	lFound := ZZ1->( DbSeek( xFilial("ZZ1")+"X" ) )
	lFound := ZZ1->( DbSeek( xFilial("ZZ1")+cProd ) )
	lFound := ZZ1->( DbSeek( xFilial("ZZ1")+cCodigo ) )

	RpcClearEnv()
return


