#include 'protheus.ch'


function u_xt3212()
	Local bVar := {|a,b| a * b }

	Local cMacro := "Conout"


	Conout( Eval(bVar, 10, 100) )
	Conout( Eval(bVar, 11, 100) )
	Conout( Eval(bVar, 12, 100) )
	Conout( Eval(bVar, 13, 100) )

	&cMacro.("Hello mundo!")
	&("u_meuhello()")
return


function u_meuhello()
	alert("hello")
Return