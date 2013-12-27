TRY 
SELECT COUNT(codigo) FROM c1 INTO ARRAY laCount
MESSAGEBOX("Asegurese que el Archivo de Excel sea guardado en formato de excel 95 ó 2003/97",16,"Atencion")

IF laCount=0
	lcfile=GETFILE("xls","Seleccionar el archivo")
	IF !EMPTY(lcfile)
		IF FILE(lcfile)
			IF !USED("C1")
				USE c1 IN 0 
			ENDIF 
			SELECT c1
			APPEND FROM (lcfile) FIELDS codigo,nombre TYPE XLS 
			
			DO verificacion
			SELECT c1
			BROWSE FIELDS codigo, nombre noedit 
			SELECT c1
			USE 
		ENDIF 
	ENDIF 
ELSE
	MESSAGEBOX("Existen "+TRANSFORM(laCount)+" Cuentas en el catalogo actual"+CHR(13)+;
				"Elimine todas las cuentas antes de importar un nuevo catalogo",16,"Error al importar")
ENDIF 
CATCH TO err
	MESSAGEBOX(err.Details)
	MESSAGEBOX("1-Asegurese que el Archivo de Excel sea guardado en formato de excel 95 ó 2003/97"+CHR(13)+;
			"2-asegurese que el archivo que esta importando este cerrado y no este en uso por ningun otro usuario",16,"Error")

ENDTRY 