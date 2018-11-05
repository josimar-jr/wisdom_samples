#include 'protheus.ch'

User Function sampImp1()
	ProcImpTxt()
return

Static Function ProcImpTxt()
	Local cFile := "/import/import_pessoa.txt"
	Local nHandle := 0
	Local cLine := ""
	Local cFilZJ0
	Local cIdPessoa
	Local cNomePessoa
	Local lAtivo 
	// Abre o arquivo
	nHandle := FT_FUse(cFile)

	// Se houver erro de abertura abandona processamento
	If nHandle != -1
		// Posiciona na primeria linha
		FT_FGoTop()
		
		// Retorna o número de linhas do arquivo
		// nLast := FT_FLastRec()
		
		While !FT_FEOF()
			// Retorna o conteúdo da linha corrente
			cLine  := FT_FReadLn()

			TrataDados( cLine, @cFilZJ0, @cIdPessoa, @cNomePessoa, @lAtivo )

			GravaLinha( cFilZJ0, cIdPessoa, cNomePessoa, lAtivo )

			// Pula para próxima linha
			FT_FSKIP()
		End
		// Fecha o Arquivo
		FT_FUSE()

		ApMsgInfo(i18n("Processamento do arquivo #1 finalizado.", { cFile } ) )
	Else
		ApMsgAlert(i18n("Arquivo #1 não foi aberto corretamente.", { cFile } ) )
	EndIf

Return

Static Function TrataDados( cLinha, cFilZJ0, cIdPessoa, cNomePessoa, lAtivo )
	Local nPosLinha

	DbSelectArea("ZJ0")
	ZJ0->(DbSetOrder(1))

	nPosLinha := 1
	cFilZJ0 := SubStr( cLinha, nPosLinha, Len( ZJ0->ZJ0_FILIAL ) )
	nPosLinha += Len( ZJ0->ZJ0_FILIAL )

	cIdPessoa := SubStr( cLinha, nPosLinha, Len( ZJ0->ZJ0_ID ) )
	nPosLinha += Len( ZJ0->ZJ0_ID )

	cNomePessoa := SubStr( cLinha, nPosLinha, Len( ZJ0->ZJ0_NOME ) )
	nPosLinha += Len( ZJ0->ZJ0_NOME )

	lAtivo := ( SubStr( cLinha, nPosLinha, 1 ) == "T" )
	nPosLinha += 1

Return


Static Function GravaLinha( cFilZJ0, cIdPessoa, cNomePessoa, lAtivo )
	Local lUpdate := .F.

	DbSelectArea("ZJ0")
	ZJ0->(DbSetOrder(1))
	lUpdate := ( ZJ0->( DbSeek( cFilZJ0 + cIdPessoa ) ) )

	Reclock("ZJ0", !lUpdate)
		ZJ0->ZJ0_FILIAL := cFilZJ0
		ZJ0->ZJ0_ID     := cIdPessoa
		ZJ0->ZJ0_NOME   := cNomePessoa
		ZJ0->ZJ0_ATIVO  := lAtivo
	ZJ0->(MsUnlock())
Return
