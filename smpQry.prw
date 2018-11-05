#include 'protheus.ch'

User Function smpQry()
	Local cQuery := ""
	Local nLinha := 0

	cQuery := " SELECT ZJ2_FILIAL, ZJ2_IDPESS, ZJ0_NOME, ZJ2_IDANIM, ZJ1_NOME"
	cQuery += " FROM ZJ2100 ZJ2"
	cQuery += " INNER JOIN ZJ0100 ZJ0 ON ZJ0_FILIAL = 'E1U1F1'"
	cQuery += 						" AND ZJ0_ID = ZJ2_IDPESS"
	cQuery += 						" AND ZJ0.D_E_L_E_T_ = ' '"
	cQuery += " JOIN ZJ1100 ZJ1 ON ZJ1_FILIAL = 'E1U1F1'"
	cQuery += 						" AND ZJ1_ID = ZJ2_IDANIM"
	cQuery += 						" AND ZJ1.D_E_L_E_T_ = ' '"
	cQuery += " WHERE ZJ2_FILIAL = 'E1U1F1'"
	cQuery += " AND ZJ2.D_E_L_E_T_=' '"

	cQuery := ChangeQuery( cQuery )

	dbUseArea( .T.,'TOPCONN', TcGenQry(,,cQuery),"TMP",.T.,.T. )

	While !TMP->( EOF() )
		Conout( "Linha " + cValToChar(nLinha) + " >> " +;
			ZJ2->(ZJ2_FILIAL + ZJ2_IDPESS + ZJ0_NOME + ZJ2_IDANIM + ZJ1_NOME) )

		TMP->(DbSkip())
	End
Return