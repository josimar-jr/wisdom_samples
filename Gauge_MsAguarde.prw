#INCLUDE 'PROTHEUS.CH'

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Gauge_MsAguarde.prw  | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_GMsAguarde()                                         |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Demonstracao da utilizacao das funcoes MsAgurde/MsProcTxt       |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

USER FUNCTION GMsAguarde()
PRIVATE lEnd := .F.

MsAguarde({|lEnd| RunProc(@lEnd)},"Aguarde...","Processando Clientes",.T.)

Return NIL

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Gauge_Processa2.prw  | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - Proc()                                                 |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao de processamento                                         |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

STATIC FUNCTION RunProc(lEnd)

dbSelectArea("SX5")
SX5->(dbSetOrder(1))
SX5->(dbGoTop())

While !SX5->(Eof())
   
   If lEnd
      ApMsgInfo(cCancel,"Fim")
      Exit
   Endif
   
   MsProcTxt("Tabela: "+SX5->X5_TABELA+" Chave: "+SX5->X5_CHAVE)
   
   SX5->(dbSkip())
End

ApMsgInfo( 'Processamento finalizado.')

Return NIL
