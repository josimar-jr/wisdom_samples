#include 'protheus.ch'

user function samp9_1()
	Local aConteudo := {}  // Variável para conter as informações
	Local nLinha := 0

	// Abrir ambiente
	RpcSetEnv('10','E1U1F1')
	
	// Carregar as informações da tabela de pessoas para o array
	// Abrir a tabela
	DbSelectArea('ZJ0')
	ZJ0->(DbSetOrder(1)) // ZJ0_FILIAL + ZJ0_ID
	// Percorrer enquanto não chegar ao fim
	While ZJ0->(!EOF())
		// Cria uma nova linha no array aConteudo
		aAdd( aConteudo, Array(4+1) ) // Os 4 campos + último lógico
		nLinha++ // O mesmo que pegar a última linha inserida Len(aConteudo)
		// Adicionar os itens sendo:
		//  primeira posição: FILIAL
		aConteudo[nLinha,1] := ZJ0->ZJ0_FILIAL
		//  segunda posição: ID
		aConteudo[nLinha,2] := ZJ0->ZJ0_ID
		//  terceira posição: NOME
		aConteudo[nLinha,3] := ZJ0->ZJ0_NOME
		//  quarta posição: ATIVO
		aConteudo[nLinha,4] := ZJ0->ZJ0_ATIVO

		// último campo indicando estado da linha deletada? .T./.F.
		aConteudo[nLinha,5] := .F.

		ZJ0->(DbSkip())
	End

	VarInfo('aConteudo', aConteudo)

	// Fechar Ambiente
	RpcClearEnv()
return