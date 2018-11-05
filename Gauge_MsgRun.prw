#INCLUDE 'PROTHEUS.CH'

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Gauge_MsgRun.prw     | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_GMsgRun()                                            |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Demonstracao da funcao MsgRun e dbEval()                        |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

USER FUNCTION GMsgRun()
LOCAL nCnt := 0

dbSelectArea("SX1")
dbGoTop()

MsgRun("Lendo arquivo, aguarde...","Título opcional",{|| dbEval({|x| nCnt++}) })

ApMsgInfo("Ufa!!!, li "+AllTrim(Str(nCnt))+" registros",FunName())

Return NIL
