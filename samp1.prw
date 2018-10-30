#include 'protheus.ch'

user function samp1()
	Local nI := 1

	Alert(++nI)
	Alert(nI++)

	samp2( nI )
	Alert(nI)
	samp2( @nI )
	Alert(nI)

return 


static function samp2( nNumero )
	nNumero += 10
return 