#include 'protheus.ch'

user function xt3312()
	Local aAll := Array(30)
	Local aPares := {}
	Local aImpares := {}
	Local nI := 1

	For nI := 1 To Len(aAll)
		aAll[nI] := nI
		If (nI % 2 == 0)
			aAdd( aPares, nI )
		Else
			aAdd( aImpares, nI )
		EndIf
	Next nI

	Ord( 1, aPares )
	Ord( -1, aImpares )

	VarInfo( 'aPares', aPares )
	VarInfo( 'aImpares', aImpares )
return

static function Ord( nTipo, aArr )
	Local nI := 1
	Local nJ := 1
	Local nCur_nI := 0
	Local nMax := Len( aArr )
	Local nInicio := 1
	Local nVal := 1
	Local nVal_Aux := 0

	For nI := nInicio To nMax Step nVal
		nCur_nI := aArr[nI]

		For nJ := nI + 1 To nMax Step nVal
			nCur_nJ := aArr[nJ]

			If ( (nTipo == 1 .And. nJ <= nMax .And. nCur_nJ < nCur_nI ) ;
				.Or. ( nTipo == -1 .And. nJ <= nMax .And. nCur_nJ > nCur_nI ) )
				
				nVal_Aux  := aArr[nI]
				aArr[nI] := aArr[nJ]
				aArr[nJ] := nVal_Aux
			EndIf

		Next nJ
	Next nI
return 


function u_xtOrdsamp()
	Local aPessoas := { {'Alberto', 20}, {'Pedro', 10}, { 'João', 15 }, {"Maria", 30 } } 
	Local aOrdNum := {}
	Local aOrdNome := {}
	
	aOrdNum := aSort( aPessoas, , , {|x,y| x[2] < y[2] } )
	VarInfo('aOrdNum', aOrdNum)
	
	aOrdNome := aSort( aPessoas, , , {|x,y| x[1] < y[1] } )
	VarInfo('aOrdNome', aOrdNome)
return