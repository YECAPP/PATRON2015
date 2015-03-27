lnHandle=SQLSTRINGCONNECT('dsn=sqlfox')
IF lnHandle>1
	MESSAGEBOX("ejecutando contra el server")
	IF SQLEXEC(lnHandle,"use yData")<>-1
		SQLEXEC(lnHandle,"select * from yContaCatalogo",'yContaCatalogo')
		SELECT yContaCatalogo
		BROWSE 
	ELSE
		MESSAGEBOX("No existe la Bd")
	ENDIF 
ENDIF 