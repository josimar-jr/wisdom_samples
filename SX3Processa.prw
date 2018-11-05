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
User Function SX3PROC()
Local aSay    := {}
Local aButton := {}
Local nOpc    := 0
Local cTitulo := "Exemplo de Funções"
Local cDesc1  := "Este programa exemplifica a utilização da função Processa() em conjunto"
Local cDesc2  := "com as funções de incremento ProcRegua() e IncProc()"

aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )

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
Local nCt := 0

dbSelectArea("SX3")
dbGoTop()

ProcRegua( SX3->(RecCount()) ) // Quantidade de Registro

While !SX3->(Eof())

	nCt++
	
    // Incrementa a regua e mostra o titulo
    IncProc("Processando tabela: "+SX3->X3_ARQUIVO )

    If lEnd
       ApMsgInfo(cCancela,"Fim")
       Exit
    Endif
    
    SX3->(dbSkip())
End

ApMsgInfo("O Protheus tem "+AllTrim(Str(nCt))+" campos")

Return .T.
