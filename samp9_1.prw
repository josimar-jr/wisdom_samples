#include 'protheus.ch'

user function samp9_1()
	Local aConteudo := {}  // Vari�vel para conter as informa��es
	Local nLinha := 0

	// Abrir ambiente
	RpcSetEnv('10','E1U1F1')
	
	// Carregar as informa��es da tabela de pessoas para o array
	// Abrir a tabela
	DbSelectArea('ZJ0')
	ZJ0->(DbSetOrder(1)) // ZJ0_FILIAL + ZJ0_ID
	// Percorrer enquanto n�o chegar ao fim
	While ZJ0->(!EOF())
		// Cria uma nova linha no array aConteudo
		aAdd( aConteudo, Array(4+1) ) // Os 4 campos + �ltimo l�gico
		nLinha++ // O mesmo que pegar a �ltima linha inserida Len(aConteudo)
		// Adicionar os itens sendo:
		//  primeira posi��o: FILIAL
		aConteudo[nLinha,1] := ZJ0->ZJ0_FILIAL
		//  segunda posi��o: ID
		aConteudo[nLinha,2] := ZJ0->ZJ0_ID
		//  terceira posi��o: NOME
		aConteudo[nLinha,3] := ZJ0->ZJ0_NOME
		//  quarta posi��o: ATIVO
		aConteudo[nLinha,4] := ZJ0->ZJ0_ATIVO

		// �ltimo campo indicando estado da linha deletada? .T./.F.
		aConteudo[nLinha,5] := .F.

		ZJ0->(DbSkip())
	End

	VarInfo('aConteudo', aConteudo)

	// Fechar Ambiente
	RpcClearEnv()
return