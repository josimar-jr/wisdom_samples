#INCLUDE 'PROTHEUS.CH'

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Gauge_Processa.prw   | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - GProces1()                                             |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao que demonstra a utilizacao das funcoes Processa(),       |//
//|           | ProcRegua() e IncProc()                                         |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
User Function GProces1()
Local aSay    := {}
Local aButton := {}
Local nOpc    := 0
Local cTitulo := "Exemplo de Funções"
Local cDesc1  := "Este programa exemplifica a utilização da função Processa() em conjunto"
Local cDesc2  := "com as funções de incremento ProcRegua() e IncProc()"

Private cPerg := PadR("PROCES",Len(SX1->X1_GRUPO))

CriaSX1()
Pergunte(cPerg,.F.)

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )

aAdd( aButton, { 5, .T., {|| Pergunte(cPerg,.T. )    }} )
aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
aAdd( aButton, { 2, .T., {|| FechaBatch()            }} )

FormBatch( cTitulo, aSay, aButton )

If nOpc <> 1
   Return NIL
Endif

Processa( {|lEnd| RunProc(@lEnd)}, "Aguarde...","Executando rotina.", .T. )

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
Static Function RunProc(lEnd)
Local nCnt := 0

dbSelectArea("SX5")
dbSetOrder(1)
SX5->(dbSeek(xFilial("SX5")+mv_par01,.T.))

While !SX5->(Eof()) .And. SX5->X5_FILIAL == xFilial("SX5") .And. SX5->X5_TABELA <= mv_par02
   nCnt++
   SX5->(dbSkip())
End

SX5->(dbSeek(xFilial("SX5")+mv_par01,.T.))

ProcRegua(nCnt) // Quantidade de Registro

While !SX5->(Eof()) .And. SX5->X5_FILIAL == xFilial("SX5") .And. SX5->X5_TABELA <= mv_par02

    // Incrementa a regua e mostra o titulo
    IncProc("Processando tabela: "+SX5->( X5_TABELA + ' ' + X5_CHAVE ))

    If lEnd
       ApMsgInfo(cCancela,"Fim")
       Exit
    Endif
    
    SX5->(dbSkip())
End

Return .T.

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | Gauge_Processa2.prw  | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - CriaSX1()                                              |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao de cria o grupo de perguntas se necessario               |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
Static Function CriaSx1()
Local nY := 0
Local aAreaAnt := GetArea()
Local aAreaSX1 := SX1->(GetArea())
Local aReg := {} 
Local nJ   := 0

aAdd(aReg,{cPerg,"01","Tabela de ?         ","mv_ch1","C", 2,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
aAdd(aReg,{cPerg,"02","Tabela ate ?        ","mv_ch2","C", 2,0,0,"G","(mv_par02>=mv_par01)","mv_par02","","","","","","","","","","","","","","",""})
aAdd(aReg,{"X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_CNT01","X1_VAR02","X1_DEF02","X1_CNT02","X1_VAR03","X1_DEF03","X1_CNT03","X1_VAR04","X1_DEF04","X1_CNT04","X1_VAR05","X1_DEF05","X1_CNT05","X1_F3"})

dbSelectArea("SX1")
dbSetOrder(1)

For ny:=1 to Len(aReg)-1

	If !dbSeek(aReg[ny,1]+aReg[ny,2])
		RecLock("SX1",.T.)

		For nj:=1 to Len(aReg[ny])
			FieldPut(FieldPos(aReg[Len(aReg)][nj]),aReg[ny,nj])
		Next nj

		MsUnlock()
	EndIf
Next ny

RestArea(aAreaSX1)
RestArea(aAreaAnt)

Return NIL

