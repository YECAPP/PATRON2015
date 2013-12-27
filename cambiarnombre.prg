IF INPUTBOX("Ingrese su Clave","Clave","Clave")="admin"
lcNombre=INPUTBOX("Escriba el nombre de la empresa","Nombre de empresa","Nombre Empresa")

IF !EMPTY(lcNombre)
	UPDATE nombre SET nombre=lcNombre WHERE id="default"
	enombre=lcNombre
	_screen.Caption=lcNombre
ELSE
	MESSAGEBOX("Escriba un nombre valido",16,"Error")	
ENDIF 
ELSE
	MESSAGEBOX("Clave no es valida ",16,"Error")
ENDIF 

