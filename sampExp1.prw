#include 'protheus.ch'
#include 'fileio.ch'

User Function sampExp1()
	FwMsgRun( ,{|| ProcExpTxt()}, "Exemplo processamento", "processando..." )
return

Static Function ProcExpTxt()
	Local cFile := "/import/export_pessoas.txt"
	Local lContinua := .F.
	Local nHandle

	If File( cFile ) 
		nHandle := fOpen( cFile, FO_READWRITE + FO_EXCLUSIVE )
		If nHandle == -1
			lContinua := .F.
			// Algu�m j� est� fazendo a exporta��o dos dados e por isso n�o farei
			ApMsgInfo( "A exporta��o dos dados j� est� em processamento por outra inst�ncia!" )
		Else
			lContinua := .T.
		EndIf
	Else
		lContinua := .T.
	EndIf
	
	If lContinua
		// Fecha para criar zerado e inserir novamente os dados no arquivo
		fClose(nHandle)

		// Abre o arquivo
		nHandle := fCreate(cFile)
		If nHandle == -1
			MsgStop('Erro de abertura : FERROR ' + Str(fError(),4))
		Else
			// Posiciona no fim do arquivo
			FSeek(nHandle, 0, FS_END)
			
			// Percorre todos os registros da tabela ZJ0
			LeZj0( cFile, nHandle )
			
			// Fecha arquivo
			fClose(nHandle)
			
			MsgAlert('Processo conclu�do')
		EndIf
	EndIf
Return


Static Function LeZJ0( cFile, nHandle )
	Local cNovaLinha
	Local nTamLinha
	Local nGravados

	DbSelectArea("ZJ0")
	ZJ0->( DbSetOrder( 1 ) )
	ZJ0->( DbGoTop() )

	cNovaLinha := ZJ0->ZJ0_FILIAL + ;
						ZJ0->ZJ0_ID + ;
						ZJ0->ZJ0_NOME + ;
						If(ZJ0->ZJ0_ATIVO, "T", "F") + ;
						CRLF
	nTamLinha := Len(cNovaLinha)

	While ZJ0->(!EOF())
		cNovaLinha := ZJ0->ZJ0_FILIAL + ;
						ZJ0->ZJ0_ID + ;
						ZJ0->ZJ0_NOME + ;
						If(ZJ0->ZJ0_ATIVO, "T", "F") + ;
						CRLF

		// Insere texto no arquivo
		nGravados := FWrite(nHandle, cNovaLinha, nTamLinha)
		If ( nTamLinha != nGravados )
			ApMsgAlert( i18n("Problema na grava��o do arquivo #1 no registro da ZJ0 #2", ;
								{ cFile, ZJ0->(Recno()) } ) )
			Exit
		EndIf

		ZJ0->(DbSkip())
	End

Return

