*
* PROGRAMA PRINCIPAL
*
**ESTABLECIENDO PATHS VALIDOS 
SET PATH TO "DATA"

LOCAL lcnombre
LCNOMBRE="Ingrese un Nombre De Empresa"
ON KEY LABEL CTRL+F12 do form ventanacomandos

SELECT nombre FROM nombre WHERE id="default" INTO ARRAY lanombre
IF !VARTYPE(lanombre)="U"
	lcnombre=lanombre
ENDIF 

_SCREEN.CAPTION = lcnombre
_SCREEN.CLOSABLE =  .F.
CLEAR ALL
CLOSE ALL
_SCREEN.WindowState= 2 
SET DELE ON
SET EXAC ON
SET EXCL OFF
SET ESCA OFF
SET NOTI OFF
SET SAFE OFF
SET STAT OFF
SET TALK OFF
SET STATUS BAR OFF

SET DEVI TO SCREEN
SET DATE TO FRENCH
SET REPR TO 3 SECOND
SET CENTU ON
SET SYSMENU SAVE
SET SYSMENU TO
CLEAR
   _SCREEN.ADDOBJECT('img1','image')
   _SCREEN.IMG1.PICTURE = 'CENTRALIMAGE.JPG'
   _SCREEN.IMG1.LEFT = (_SCREEN.WIDTH - _SCREEN.IMG1.WIDTH)/2
   _SCREEN.IMG1.TOP = (_SCREEN.HEIGHT - _SCREEN.IMG1.HEIGHT)/2
   _SCREEN.IMG1.VISIBLE = .T.
 DO MENUM.MPR
 PUBLIC ENOMBRE 
ENOMBRE = _SCREEN.CAPTION 

**30/12/2012 4:57 am agregar barra de herramientas general 
IF VARTYPE(_screen.otoolbar)="U"
	SET CLASSLIB TO lib1.0\conta.vcx ADDITIVE
	_screen.AddProperty("otoolbar")
	_screen.otoolbar=CREATEOBJECT("toolMain")
	_screen.otoolbar.Show
	_screen.otoolbar.Dock(0)
ENDIF 
**03/01/2013 4:59 am agregar clase general para manejo de la aplicacion 
IF VARTYPE(_screen.yoapp1)="U"
	SET CLASSLIB TO lib1.0\yoapp.vcx ADDITIVE
	_screen.AddProperty("yoapp1")
	_screen.yoapp1=CREATEOBJECT("yoapp")
ENDIF 

**31/10/2013 11:31 se agrego manejo de utilidades de conta desde clase
**esta clase maneja utilidades como verificacion de catalogo verificacion de cta de mayor y otros 
**03/01/2013 4:59 am agregar clase general para manejo de la aplicacion 
IF VARTYPE(_screen.utilityconta1)="U"
	_screen.NewObject("utilityconta1","utilityconta")	
ENDIF 



**02/01/2013 CREAR DIRECTORIOS DATA 
DO CHANGECRITICOS 

**03/01/2013 4:59 am verificar parametros para generarlos en caso que no existan 
_screen.yoapp1.ContaVerParams()
**04/01/2013 2:59 pm actualizar cambios en data  automaticamente 
_screen.yoapp1.updateChanges()
READ EVENTS

**02/01/2013 CAMBIOS CRITICOS 
PROCEDURE CHANGECRITICOS
	**VERIFICAR QUE EXISTA DIRECTORIO DATA Y PASAR ARCHIVOS A DATA 
	IF DIRECTORY("DATA")
	ELSE
		MD "DATA"
	ENDIF 
	
	DIMENSION LAFILES2COPY(13)
	LAFILES2COPY(1)="C1.DBF"
	LAFILES2COPY(2)="C1.FPT"
	LAFILES2COPY(3)="C1.CDX"
	LAFILES2COPY(4)="C2.DBF"
	LAFILES2COPY(5)="C2.CDX"
	LAFILES2COPY(6)="INFOAPP.DBF"
	LAFILES2COPY(7)="NOMBRE.DBF"	
	LAFILES2COPY(8)="NSC.DBF"
	LAFILES2COPY(9)="NSC.FPT"		
	LAFILES2COPY(10)="NSC.CDX"
	LAFILES2COPY(11)="TBDTUP.DBF"				
	LAFILES2COPY(12)="C2TEMP.DBF"
	LAFILES2COPY(13)="C2TMP.DBF"	
	FOR N=1 TO ALEN(LAFILES2COPY,1)	
		LCFILE=LAFILES2COPY(N)
		
		IF FILE("DATA\"+LCFILE)=.F.
			IF FILE(LCFILE)
				COPY FILE (LCFILE) TO "DATA\"+LCFILE
				DELETE FILE  (LCFILE) RECYCLE 
			ENDIF 
		ELSE &&si el archivo ya existe en data 
		ENDIF &&FILE("DATA\"+LCFILE)=.F.
	ENDFOR &&	FOR N=1 TO ALEN(LAFILES2COPY,1)	
	
	**verificar si existe tabla para manejo de versiones sino crearla 
	CLOSE TABLES ALL 
	IF FILE("DATA\tbsrcdtup.dbf")=.F.
		DO addtbDataUpdates  IN altertable2 WITH .t. 
		SELECT tbsrcdtup
		USE 
	ENDIF 
	
	IF FILE("tbdtup.dbf")=.F.
		DO addtbDataUpdates  IN altertable2 WITH .t. 
		SELECT tbdtup
		USE 
	ENDIF 
ENDPROC 


