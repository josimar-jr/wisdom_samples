#include 'protheus.ch'

user function samp9_2()
	Local nI := 0
	Local aConteudo := {}  // Vari�vel para conter as informa��es
	Local nLinha := 0
	Local aCampos := { "ZJ1_FILIAL", "ZJ1_ID", "ZJ1_NOME", "ZJ1_TIPO" }
	Local nColunas := 0
	Local nPosField := 0

	// Abrir ambiente
	RpcSetEnv('10','E1U1F1')

	// Carregar as informa��es da tabela de pessoas para o array
	// Abrir a tabela
	DbSelectArea('ZJ1')
	ZJ1->( DbSetOrder(2)) // ZJ1_FILIAL + ZJ1_NOME
	ZJ1->( DbSeek( xFilial("ZJ1"), .T. ) )

	// Os campos + �ltimo l�gico
	nColunas := Len(aCampos)+1

	// Percorrer enquanto n�o chegar ao fim
	While ZJ1->(!EOF())
		// Cria uma nova linha no array aConteudo
		aAdd( aConteudo, Array( nColunas ) )

		nLinha++ // O mesmo que pegar a �ltima linha inserida Len(aConteudo)
		
		// Adiciona o conte�do dos campos
		For nI := 1 To Len(aCampos)
			nPosField := ZJ1->( FieldPos( aCampos[nI] ) ) // FIELDPOS("ZJ1_FILIAL") > 1
			aConteudo[nLinha,nI] := ZJ1->( FieldGet( nPosField ) ) // FIELDGET(1)
		Next nI

		// �ltimo campo indicando estado da linha deletada? .T./.F.
		aConteudo[nLinha,nColunas] := .F.

		ZJ1->(DbSkip())
	End

	VarInfo('aConteudo', aConteudo)

	// Fechar Ambiente
	RpcClearEnv()
return
