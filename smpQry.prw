#include 'protheus.ch'

User Function smpQry()
	Local cQuery := ""
	Local nLinha := 0

	Local cTmpAlias := GetNextAlias()

	cQuery := " SELECT ZJ2_FILIAL, ZJ2_IDPESS, ZJ0_NOME, ZJ2_IDANIM, ZJ1_NOME"
	cQuery += " FROM "+RetSQlName("ZJ2")+" ZJ2"
	cQuery += " INNER JOIN "+RetSQlName("ZJ0")+" ZJ0 ON ZJ0_FILIAL = '"+xFilial("ZJ0")+"'"
	cQuery += 						" AND ZJ0_ID = ZJ2_IDPESS"
	cQuery += 						" AND ZJ0.D_E_L_E_T_ = ' '"
	cQuery += " JOIN "+RetSQlName("ZJ1")+" ZJ1 ON ZJ1_FILIAL = '"+xFilial("ZJ1")+"'"
	cQuery += 						" AND ZJ1_ID = ZJ2_IDANIM"
	cQuery += 						" AND ZJ1.D_E_L_E_T_ = ' '"
	cQuery += " WHERE ZJ2_FILIAL = '"+xFilial("ZJ2")+"'"
	cQuery += " AND ZJ2.D_E_L_E_T_=' '"

	cQuery := ChangeQuery( cQuery )
	dbUseArea( .T.,'TOPCONN', TcGenQry(,,cQuery), cTmpAlias,.T.,.T. )

	While (cTmpAlias)->( !EOF() )
		nLinha += 1
		Conout( "Linha " + cValToChar(nLinha) + " >> " +;
			(cTmpAlias)->(ZJ2_FILIAL + ZJ2_IDPESS + ZJ0_NOME + ZJ2_IDANIM + ZJ1_NOME) )

		(cTmpAlias)->(DbSkip())
	End

	(cTmpAlias)->(DbCloseArea())
Return


// User Function QryEbdSql()

// 	BeginSql Alias "TMP"
// 		SELECT ZJ2_FILIAL, ZJ2_IDPESS, ZJ0_NOME, ZJ2_IDANIM, ZJ2_NOME
// 		FROM %Table:ZJ2% ZJ2
// 			INNER JOIN %Table:ZJ0% ZJ0 ON ZJ0_FILIAL = %xFilial:ZJ0%
// 										AND ZJ0_ID = ZJ2_IDPESS
// 										AND ZJ0.%NotDel%
// 			INNER JOIN %Table:ZJ1% ZJ1 ON ZJ1_FILIAL = %xFilial:ZJ1%
// 										AND ZJ1_ID = ZJ2_IDANIM
// 										AND ZJ1.%NotDel%
// 		WHERE ZJ2_FILIAL = %xFilial:ZJ2%
// 			AND ZJ2.%NotDel%
// 	EndSql
// Return