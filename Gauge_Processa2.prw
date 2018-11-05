#INCLUDE 'PROTHEUS.CH'

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Gauge_Processa2.prw  | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_GProces2()                                           |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Demonstracao de como utilizar o processa2()                     |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
User Function GProces2()
Private oProcess := NIL

oProcess := MsNewProcess():New({|lEnd| RunProc(lEnd,oProcess)},"Processando","Lendo...",.T.)
oProcess:Activate()

Return NIL

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Gauge_Processa2.prw  | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - RunProc()                                              |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao de processamento                                         |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
Static Function RunProc(lEnd,oObj)
Local aTabela := {}
Local nCnt := 0
Local nI    := 0
                   
aTabela := {{"00",0},{"13",0},{"35",0},{"T3",0},{'HB',0},{'SW',0},{'BH',0}}

dbSelectArea("SX5")
cFilialSX5 := xFilial("SX5")

dbSetOrder(1)

For nI := 1 To Len(aTabela)

   SX5->( dbSeek( cFilialSX5 + aTabela[nI][1]) )

   While !SX5->(Eof()) .And. SX5->X5_FILIAL+SX5->X5_TABELA == cFilialSX5+aTabela[nI][1]
     
      If lEnd
         Exit
      Endif

      nCnt++
      
      SX5->(dbSkip())

   End

   aTabela[nI][2] := nCnt

   nCnt := 0

Next nI

oObj:SetRegua1(Len(aTabela))

For nI := 1 To Len(aTabela)

   If lEnd
      Exit
   Endif

   oObj:IncRegua1("Lendo Tabela: "+aTabela[nI][1])
   dbSelectArea("SX5")

   SX5->( dbSeek( cFilialSX5+aTabela[nI][1] ) )

   oObj:SetRegua2(aTabela[nI][2])

   While !SX5->(Eof()) .And. SX5->X5_FILIAL+SX5->X5_TABELA == cFilialSX5+aTabela[nI][1]
      oObj:IncRegua2("Lendo chave: "+X5_CHAVE)

      If lEnd
         Exit
      Endif

      SX5->(dbSkip())
   End

Next nI

Return NIL
