#include 'protheus.ch'
#include 'fileio.ch'

User Function sampExp1()
	ProcExpTxt()
return

Static Function ProcExpTxt()
	Local cFile 
	Local cNovaLinha 
	// Abre o arquivo
	nHandle := fCreate(cFile)
	If nHandle == -1
		MsgStop('Erro de abertura : FERROR '+str(fError(),4))
	Else
		FSeek(nHandle, 0, FS_END)         // Posiciona no fim do arquivo
		
		cNovaLinha := "Nova Linha" + CRLF
		FWrite(nHandle, cNovaLinha, Len(cNovaLinha)) // Insere texto no arquivo
		
		fClose(nHandle)                   // Fecha arquivo
		
		MsgAlert('Processo concluído')
	EndIf
Return