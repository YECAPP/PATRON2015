IF INPUTBOX("Ingrese su Clave","Clave","Clave")="admin"
IF MESSAGEBOX("Esta seguro que desea borrar todas la informacion de la base de datos",20,"Atencion")=6
	IF MESSAGEBOX("Esta operacion no puede deshacerse",20,"Atencion")=6
		DELETE FROM c1 
		DELETE FROM c2
	ELSE
		MESSAGEBOX("Operacion Abortada",16,"Proceso Cancelado")
	ENDIF 
ELSE
	MESSAGEBOX("Operacion Abortada",16,"Proceso Cancelado")
ENDIF 
ELSE
	MESSAGEBOX("Clave no es valida ",16,"Error")
ENDIF 