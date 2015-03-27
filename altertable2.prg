***********************************************************************
**altertable2 se creo para realizar todos los cambios que afectan tablas 
*04/01/2013 2:43 am se elimino todo e contenido y se dejo este solo para conta; addtbDataUpdates se dejo por que se usa para la ventana comandos 
**ENE 2013 SE AGREGO TABLA CONTRIB 
**14/01/2013 SE GREGO QUE CREE TABLAS TEMPORALES PARA IMPORTACION DE PDA 
**04/02/2014 se agregaron campos de proyectos a tablas de conta, para manejarlos en conta y luego cotejarlos con el sistema general 

PROCEDURE FEB2014ADDPROYFIELDS2C2
	CLOSE TABLES ALL 
	LCTB="C2"
	LCFLD="IDPROY"
	LNPRECISION="C(10)"
	LCTYPEOPERATION="ADD"
	DO MAKECHANGES WITH LCTB,LCFLD,LNPRECISION,LCTYPEOPERATION	

	CLOSE TABLES ALL 
	LCTB="C2"
	LCFLD="IDDEPTO"
	LNPRECISION="C(10)"
	LCTYPEOPERATION="ADD"
	DO MAKECHANGES WITH LCTB,LCFLD,LNPRECISION,LCTYPEOPERATION	

	CLOSE TABLES ALL 
	LCTB="C2"
	LCFLD="IDCLIPROV"
	LNPRECISION="C(10)"
	LCTYPEOPERATION="ADD"
	DO MAKECHANGES WITH LCTB,LCFLD,LNPRECISION,LCTYPEOPERATION	


	
ENDPROC 

PROCEDURE JUN2013ADDWAREHOUSE 
	LPARAMETERS tbSilenceMode
	LOCAL lbregresar
	IF DIRECTORY("DATA")
		CD DATA 
		lbregresar=.t. 
	ENDIF

	lcTable="CONTADWCONTA"
	IF FILE(lcTable+".dbf")=.f.
		CREATE TABLE (lcTable) (;
			CODIGO C (15 ),;
			DESCRIP 	C (45 ),;
			MES 	C (2),;
			AÑO		C (4),;
			MONTO   N(10,2),;
			PRESUP N(10,2);
			)
		IF !tbSilenceMode
			MESSAGEBOX("Tabla "+lcTable +" Creada Con exito")
		ENDIF 
		USE IN (lcTable)
	ELSE
		IF !tbSilenceMode
			MESSAGEBOX("Tabla ya "+lcTable+" existe ")
		ENDIF 
	ENDIF 

	IF lbregresar
		cd..
	ENDIF 

	
	
ENDPROC 


PROCEDURE ENE2013ADDC2TEMP
	LPARAMETERS tbSilenceMode
	LOCAL lbregresar
	IF DIRECTORY("DATA")
		CD DATA 
		lbregresar=.t. 
	ENDIF

	lcTable="C2TMP"
	IF FILE(lcTable+".dbf")=.f.
		CREATE TABLE (lcTable) (;
			CODIGO 	C (15 ),;
			CUENTA 	C (50 ),;
			DESCRIP 	C (45 ),;
			DESCRIP2 	C (45 ),;
			REFERENCIA 	C (20 ),;
			CFISCAL 	C (11 ),;
			DEBE 	N (12 ,2 ),;
			HABER 	N (12 ,2 );
			)
		IF !tbSilenceMode
			MESSAGEBOX("Tabla "+lcTable +" Creada Con exito")
		ENDIF 
		USE IN (lcTable)
	ELSE
		IF !tbSilenceMode
			MESSAGEBOX("Tabla ya "+lcTable+" existe ")
		ENDIF 
	ENDIF 
	
		lcTable="C2TEMP"
	IF FILE(lcTable+".dbf")=.f.
		CREATE TABLE (lcTable) (;
			CODIGO 	C (15 ),;
			NUMERO 	N (8 ,0 ),;
			DESCRIP 	C (45 ),;
			DEBE 	N (12 ,2 ),;
			HABER 	N (12 ,2 ),;
			REFERENCIA 	C (20 ),;
			CHEQUE 	C (8 ),;
			CFISCAL 	C (11 ),;
			DESCRIP2 	C (45 ),;
			ORDEN 	C (1 ),;
			FECHA 	D ,;
			TP 	N (1 ,0 ),;
			PROYECTO 	C (10 ),;
			REGISTRO 	C (15 ),;
			QUEDAN 	C (8 ),;
			CUENTA 	C (50 );
			)
		IF !tbSilenceMode
			MESSAGEBOX("Tabla "+lcTable +" Creada Con exito")
		ENDIF 
		USE IN (lcTable)
	ELSE
		IF !tbSilenceMode
			MESSAGEBOX("Tabla ya "+lcTable+" existe ")
		ENDIF 
	ENDIF 

	
	IF lbregresar
		cd..
	ENDIF 
	
ENDPROC 


PROCEDURE ENE2013ADDCONTRIB 
	LPARAMETERS tbSilenceMode
	LOCAL lbregresar
	IF DIRECTORY("DATA")
		CD DATA 
		lbregresar=.t. 
	ENDIF

	lcTable="CONTRIB"
	IF FILE(lcTable+".dbf")=.f.
		CREATE TABLE (lcTable) (;
			REGISTRO C(8),;
			NOMBRE C(40),;
			NIT  C(14),;
			CLASI I;
			)
		SELECT (lcTable)
		INDEX ON REGISTRO TAG REGISTRO
		INDEX ON NOMBRE TAG NOMBRE
		INDEX ON NIT TAG NIT
		INDEX ON CLASI TAG CLASI
		IF !tbSilenceMode
			MESSAGEBOX("Tabla "+lcTable +" Creada Con exito")
		ENDIF 
		USE IN (lcTable)
	ELSE
		IF !tbSilenceMode
			MESSAGEBOX("Tabla ya "+lcTable+" existe ")
		ENDIF 
	ENDIF 
	IF lbregresar
		cd..
	ENDIF 
	
ENDPROC 

PROCEDURE ENE2013ADDIDNUM
	CLOSE TABLES ALL 
	LCTB="C2"
	LCFLD="IDNUM"
	LNPRECISION="C(10)"
	LCTYPEOPERATION="ADD"
	DO MAKECHANGES WITH LCTB,LCFLD,LNPRECISION,LCTYPEOPERATION
ENDPROC 



PROCEDURE addtbDataUpdates 
LPARAMETERS lbSilenceMode
	*Inicio de: Creando tabla CLCALLS para llamadas 
	lcTable="tbSrcDtUp"
	IF FILE(lcTable+".dbf")=.f.
		CREATE TABLE (lcTable) (;
			line i,;
			proc  c(25),;
			descrip c(60),;
			creado t;
			)
		IF lbSilenceMode=.f.
			MESSAGEBOX("Tabla "+lcTable +"Creada con exito")
		ENDIF 
	ELSE
		IF lbSilenceMode=.f.
			MESSAGEBOX("Tabla ya "+lcTable+" existe ")
		ENDIF 
	ENDIF 
	**Fin de: Creando tabla CLCALLS para llamadas 



	CD DATA
	*Inicio de: Creando tabla CLCALLS para llamadas 
	lcTable="tbDtUp"
	IF FILE(lcTable+".dbf")=.f.
		CREATE TABLE (lcTable) (;
			line i,;
			proc  c(25),;
			descrip c(60),;
			creado t,;
			update t;
			)
		IF lbSilenceMode=.f.
			MESSAGEBOX("Tabla "+lcTable +"Creada con exito")
		ENDIF 
	ELSE
		IF lbSilenceMode=.f.	
			MESSAGEBOX("Tabla ya "+lcTable+" existe ")
		ENDIF 
	ENDIF 
	**Fin de: Creando tabla CLCALLS para llamadas 
	CD..	
ENDPROC 


*******************************************************************************************************
**PROCEDIMIENTOS GENERICOS 
PROCEDURE MAKECHANGES
	LPARAMETERS TCTB,TCFLD,TNPRECISION,TCTYPEOPERATION	
	
	IF FILE(TCTB+".DBF")=.F.
		MESSAGEBOX("TABLA "+TCTB+"NO EXISTE ",16,"Actualizando datos",2)
		RETURN .t. 
	ENDIF 
	DO OPENTABLE WITH TCTB
	IF TCTYPEOPERATION="ADD"
		IF VERIFIELDEXIS(TCTB,TCFLD)=.F.
			ALTER TABLE (TCTB) &TCTYPEOPERATION COLUMN &TCFLD &TNPRECISION 
			MESSAGEBOX("CAMPO: "+TCFLD+" AGREGADO CON EXITO EN "+TCTB,16,"Actualizando datos",2)
		ELSE
			MESSAGEBOX("YA EXISTE EL CAMPO: "+TCFLD+" EN LA TABLA "+TCTB,16,"Actualizando datos",2)
		ENDIF 
	ELSE 
		IF VERIFIELDEXIS(TCTB,TCFLD)=.T.
			ALTER TABLE (TCTB) &TCTYPEOPERATION COLUMN &TCFLD &TNPRECISION 
			MESSAGEBOX("CAMPO: "+TCFLD+" MODIFICADO  CON EXITO EN "+TCTB,16,"Actualizando datos",2)
		ELSE
			MESSAGEBOX("CAMPO: "+TCFLD+" NO EXISTE EN LA TABLA "+TCTB,16,"Actualizando datos",2)
		ENDIF 
	ENDIF 
	CLOSE TABLES ALL 	
ENDPROC







PROCEDURE OPENTABLE
	PARAMETERS LCTABLE
	
	IF !USED(LCTABLE)
		TRY 
			USE (LCTABLE) EXCLUSIVE  IN 0 
			
		ENDTRY  
	ELSE
		SELECT (LCTABLE)
		USE 
		USE (LCTABLE) EXCLUSIVE IN 0 
	ENDIF 
ENDPROC 

PROCEDURE VERIFIELDEXIS
	PARAMETERS LCTABLE,LCCAMPO
	IF !USED(LCTABLE)
		USE LCTABLE IN 0 
	ENDIF 
	SELECT (LCTABLE) 
	AFIELDS(LACAMPOS,LCTABLE)
	RETURN ASCAN(LACAMPOS,LCCAMPO)>=1
ENDPROC 

PROCEDURE addreport 
	LPARAMETERS tcidreport,tcdescrip, tcdescrip2, tcimage, tctp, tctpllama
	
	IF !EMPTY(tcidreport) 
		IF !EMPTY(tctp)
			SELECT idreport FROM reports WHERE idreport=tcidreport INTO ARRAY lareportexist
			IF VARTYPE(lareportexist)="U"
				INSERT INTO REPORTS(IDREPORT,DESCRIP,DESCRIP2,IMAGE,TP,TPLLAMA) VALUES (;
					tcidreport,;
					tcdescrip,;
					tcdescrip2,;
					tcimage,;
					tctp,;
					tctpllama;
					)
				MESSAGEBOX("REPORTE:"+tcidreport+ " agregado con exito ")
			ELSE
				MESSAGEBOX("REPORTE:"+tcidreport+ " ya existe ")
			ENDIF 
		ELSE
			MESSAGEBOX("tp esta vacio " )
		ENDIF 
	ELSE 
		MESSAGEBOX("id del reporte esta vacio")
	ENDIF 
ENDPROC 




PROCEDURE UpdateTableFromServer
	LPARAMETERS tcTable 
	**Inicio de: Estableciendo el ambiente de operacion 
		SET EXCLUSIVE OFF 
		SET DATE FRENCH 
		SET DELETED ON 
		CLOSE TABLES ALL 
	**Fin de :Estableciendo el ambiente de operacion 
	
	**Inicio de: Estableciendo variables 
		lcServer="\\servidor\DATA\SGAA\DATA\"
		lcLocal="c:\users\yec\documents\fox\gaa\data\"
		lnRecCounts=0
		lcFields=""
		lnFieldsCount=0
		lnFieldsLine=0
		lbHaveLine=.f.
	**Fin de: Estableciendo variables 
	
	**Inicio de: Verificando que exista la tabla en el servidor 
		IF FILE(lcServer+tcTable+".dbf")
			**Inicio de: Verificando que exista la tabla en el localmente
				IF FILE(lcLocal+tcTable+".dbf")
					**Inicio de: Borrando datos 
						USE (lcLocal+tcTable+".dbf") ALIAS  Tblocal  IN 0 exclusive 
						SELECT tblocal
						IF MESSAGEBOX("Seguro de borrar: "+DBF(),4)=6
							IF MESSAGEBOX("Seguro de borrar: "+DBF(),4)=6
								ZAP  
								**Inicio de: Quitando line de autoinc 
									AFIELDS(laFields,"tblocal")
									lnFieldsCount=ALEN(laFields,1)
									MESSAGEBOX("lnFieldsCount")
									MESSAGEBOX(lnFieldsCount)
									FOR N=1 TO ALEN(laFields,1)
										IF laFields(n,18)=0
											lcfield=laFields(n,1)+","
											
											*IF n=lnFieldsCount
											*	lcFields=lcFields+laFields(n,1)
											*ELSE
											*	lcFields=lcFields+laFields(n,1)+","
											*ENDIF 
										ELSE 
											lcfield=""
											lnFieldsLine = lnFieldsLine + 1 
											*lnFieldsCount = lnFieldsCount - 1 
											lbHaveLine=.t.
										ENDIF 
										
										*IF n=(lnFieldsCount-lnFieldsLine)
										*	lcTerminacion=""
										*ELSE
										*	lcTerminacion=","
										*ENDIF 
										
										lcFields = lcFields +  lcField
										
									ENDFOR 
									lcFields=SUBSTR(lcFields,1,LEN(lcFields)-1)
								**Fin de: Quitando line de autoinc 
								**Inicio de: Trayendo datos 
									*IF lbHaveLine
										MESSAGEBOX("lcFields")
										MESSAGEBOX(lcFields)
									*ELSE
								
										APPEND FROM  (lcServer+tcTable+".dbf") FIELDS  &lcFields
										lnRecCounts=RECCOUNT("tblocal")
										MESSAGEBOX(TRANSFORM(lnRecCounts)+" Registros Importados con exito")
										BROWSE 
										CLOSE TABLES ALL 
									*ENDIF 
								**Fin de: trayendo  datos 						

							ENDIF 
						ENDIF 
					**Fin de: Borrando datos 
				ELSE
					MESSAGEBOX("Tabla no existe localmente")
				ENDIF 
			**Fin de: Verificando que exista la tabla en el localmente 
			 
			
		ELSE
			MESSAGEBOX("Tabla no existe en el servidor")
		ENDIF 
	**Fin de: Verificando que exista la tabla en el servidor 
	
	**Inicio de: 
	
ENDPROC 

PROCEDURE addDoc
LPARAMETERS tcIdDoc, tcNombre,TcIdTrans,tcPrefijo,tcLegal,tcDescrip,tcImage,tcCat,tcSkipper
	SELECT iddoc FROM documentos  WHERE ALLTRIM(iddoc)==tcIdDoc INTO ARRAY ladoc
	IF VARTYPE(ladoc)="U"
		INSERT INTO DOCUMENTOS(;
			IDDOC,;
			NOMBRE,;
			IDTRANS,;
			PREFIJO,;
			LEGAL,;
			DESCRIPCION,;
			ICONO,;
			CATEGORIA,;
			SKIPPER);
		VALUES ; 
			(tcIdDoc,tcNombre,TcIdTrans,tcPrefijo,tcLegal,;
			tcDescrip,tcImage,tcCat,VAL(tcSkipper))



		INSERT INTO MENUSTRU(Idmenu, Descripcion);
			values(;
			tcSkipper,;
			tcDescrip)


		INSERT INTO MENUS(CODIGO, NOMBRE, IDCARGO);
			values(;
			tcSkipper,;
			tcDescrip,;
			"O-01")

		INSERT INTO MENUS(CODIGO, NOMBRE, IDCARGO);
			values(;
			tcSkipper,;
			tcDescrip,;
			"A-01")

		INSERT INTO MENUS(CODIGO, NOMBRE, IDCARGO);
			values(;
			tcSkipper,;
			tcDescrip,;
			"A-02")
			
		MESSAGEBOX("Documento "+tcIdDoc+" ingresado exitosamente ")
	ELSE	
		MESSAGEBOX("Documento "+tcIdDoc+" ya fue ingresado a tabla documentos y estructura del menu ")
	ENDIF 

	
ENDPROC 


**agrega cargos al sistema 
PROCEDURE AddCargos
	LPARAMETERS tcIdCargo,tcDescrip,tbActualizar
	
	SELECT idcargo FROM usuarios WHERE ALLTRIM(idcargo)=ALLTRIM(tcIdCargo) INTO ARRAY lacargoExist 
	IF VARTYPE(lacargoExist)="U"
		INSERT INTO usuarios (idcargo,descripcion) ;
			VALUES (tcIdCargo,tcDescrip)
			lcMsg="Cargo: "+tcIdCargo+tcDescrip +" Agregado con exito "
		
	ELSE
		IF tbActualizar=.t.
			UPDATE USUARIOS SET DESCRIPCION=tcDescrip WHERE ALLTRIM(idcargo)=ALLTRIM(tcIdCargo) 
			lcMsg="Cargo: "+tcIdCargo+tcDescrip +" Actualizado con exito"
		ELSE
			lcMsg="Cargo: "+tcIdCargo+tcDescrip +" ya existe"
		ENDIF 
	ENDIF 
	MESSAGEBOX(lcMsg,16,"Resultado")
ENDPROC 

**agrega cargos al sistema 
PROCEDURE AddAcceso
	LPARAMETERS tcCodigo,tcIdCargo,tbActualizar
		
		
	SELECT ;
		idcargo ;
	FROM ;
		menus ;
	WHERE ;
		ALLTRIM(idcargo)==ALLTRIM(tcIdCargo) AND ;
		ALLTRIM(codigo)==ALLTRIM(tcCodigo) ;
	INTO ARRAY laAccExist 

	SELECT descripcion FROM menustru WHERE ALLTRIM(idmenu)==ALLTRIM(tcCodigo) INTO ARRAY laMenuExist 
	IF !VARTYPE(laMenuExist)="U"	
		IF VARTYPE(laAccExist )="U"
				INSERT INTO menus(codigo,nombre,idcargo) ;
					VALUES (tcCodigo,laMenuExist,tcIdCargo)
					lcMsg="Menu: "+tcCodigo+laMenuExist+" y cargo: "+tcIdCargo+" Agregado con exito "
		ELSE
			IF tbActualizar=.t.
			
				UPDATE menus SET nombre=laMenuExist WHERE ALLTRIM(idcargo)==ALLTRIM(tcIdCargo) AND ALLTRIM(codigo)==ALLTRIM(tcCodigo) 
				lcMsg="Menu: "+tcCodigo+laMenuExist+" y cargo: "+tcIdCargo+" Actualizado con exito "
			ELSE
				lcMsg="Menu: "+tcCodigo+laMenuExist+" y cargo: "+tcIdCargo+" ya existe"
			ENDIF 
		ENDIF 
	ELSE
		lcMsg="Menu: "+tcCodigo+" No existe"
	ENDIF 
	
	MESSAGEBOX(lcMsg,16,"Resultado",1500)
ENDPROC 

PROCEDURE AddAcceso2
**crea el menustru y actualiza el acceso 
	LPARAMETERS tcCodigo,tcIdCargo,tcdescrip,tbActualizar
	SELECT idmenu FROM menustru WHERE idmenu==tcCodigo INTO ARRAY laMenuStruExist
	IF VARTYPE(laMenuStruExist)="U"
		INSERT INTO menustru (idmenu,descripcion) VALUES (tcCodigo,tcdescrip)
		MESSAGEBOX("Menu creado con exito",16,"Ingresado",1500)
		DO AddAcceso WITH tcCodigo,tcIdCargo,tbActualizar

	ELSE
		IF tbActualizar
			UPDATE menustru SET descripcion=tcdescrip WHERE idmenu==tcCodigo
			MESSAGEBOX("Menu actualizado con exito",16,"Actualizado",1500)
			DO AddAcceso WITH tcCodigo,tcIdCargo,tbActualizar
		ENDIF 
	ENDIF 
ENDPROC 

PROCEDURE inserparam 
	PARAMETERS tcidparam,tctipo,tcvalor,tcclasif 
	
	SELECT idparametro FROM parametros WHERE ALLTRIM(idparametro)==ALLTRIM(tcidparam) INTO ARRAY laParamExist

	IF VARTYPE(laParamExist)="U"
		INSERT INTO PARAMETROS(IDPARAMETRO,TIPO,VALOR,CLASIF) VALUES (tcidparam,tctipo,tcvalor,tcclasif )
		MESSAGEBOX("PArametro "+tcidparam+": "+tcvalor+" Insertado ",16," Insercion",1500)
	ELSE
		UPDATE parametros SET TIPO=tctipo,VALOR=tcvalor,CLASIF=tcclasif  WHERE ALLTRIM(idparametro)==ALLTRIM(tcidparam) 
		MESSAGEBOX("PArametro "+tcidparam+": "+tcvalor+" Actualizado ",16," Actualizacion",1500)
	ENDIF 
	
ENDPROC 


PROCEDURE AddDetLine
	LPARAMETERS tctabla
	IF !USED(tctabla)
		USE (tctabla) EXCLUSIVE  IN 0 
	ELSE
		SELECT (tctabla)
		USE 
		USE (tctabla) EXCLUSIVE IN 0 
	ENDIF 
	TRY 
		ALTER table (tctabla) ADD COLUMN LINE I 
		
		SELECT (tctabla)
		ln=1
		SCAN 
			replace line WITH ln  IN (tctabla)
			ln = ln + 1 
		ENDSCAN

		ALTER table (tctabla) alter  COLUMN LINE I AUTOINC NEXTVALUE ln
		PACK IN (tctabla)
	CATCH
		MESSAGEBOX("YA EXISTEN LOS CAMPOS")
	ENDTRY 	
	USE IN (tctabla)
	CLOSE TABLES ALL 
	CLOSE DATABASES ALL 
	
ENDPROC 

PROCEDURE extractIntfromiddoc
	LPARAMETERS tciddoc2int 
	LOCAL lnChar,lnReturn,lcChar,lnToReturnChar
	lnchar=0
	lnReturn=0
	lcChar=""
	lnToReturnChar=0
	FOR n=1 TO LEN(tciddoc2int) 
		lnChar=n
		lcChar=SUBSTR(tciddoc2int,lnChar,1)
		IF INLIST(lcChar,"0","1","2","3","4","5","6","7","8","9")
			lnToReturnChar=lnChar
			EXIT 
		ELSE
			lnToReturnChar=0
		ENDIF 

	ENDFOR 
	
	lnReturn=VAL(SUBSTR(tciddoc2int,lnToReturnChar,LEN(tciddoc2int)))
	RETURN lnReturn
ENDPROC 

PROCEDURE INSERTDOCNUM
LPARAMETERS TCIDDOC
*SELECT IDDOC,PREFIJO,VAL("0"),VAL("1") FROM DOCUMENTOS WHERE (IDDOC,"5","02","4","3") INTO ARRAY ladoc2inserts
**14/01/2013 6:18 pm no se usa en conta 
*!*	SELECT IDDOC,PREFIJO,VAL("0"),VAL("1") FROM DOCUMENTOS WHERE IDDOC=TCIDDOC INTO ARRAY ladoc2inserts
*!*		IF !VARTYPE(ladoc2inserts)="U"

*!*			FOR lnIddoc=1 TO ALEN(ladoc2inserts,1)

*!*				RELEASE ladoc2insert
*!*				lcIdDoc=ladoc2inserts(lnIddoc,1) &&calculando iddoc 
*!*				lcPrefijo=ladoc2inserts(lnIddoc,2) &&calculando prefijo 
*!*				SELECT ID FROM docnum WHERE ALLTRIM(iddoc)==ALLTRIM(lcIdDoc) INTO ARRAY ladoc2insert
*!*				IF !VARTYPE(ladoc2insert)="U" 
*!*					&&ver cual es mayor e insertar ese 
*!*					lnIdStored=gennumdoc(lcIdDoc) &&EL ALMACENADO EN LA TABLA DEL DOCUMENTO (GENNUMDOC())
*!*					lnIdDocNum=ladoc2insert &&EL ALMACENADO EN LA TABLA DOCNUM 
*!*					IF lnIdDocNum>extractIntfromiddoc(lnIdStored) &&SI EL QUE TIENE DOCNUM ES MAYOR QUE EL GENNUMDOC
*!*						UPDATE docnum SET prefijo=lcPrefijo,id=lnIdDocNum,estado=2 WHERE iddoc=lcIdDoc &&PONER EL DOCNUM 
*!*					ELSE
*!*						UPDATE docnum SET prefijo=lcPrefijo,id=extractIntfromiddoc(lnIdStored),estado=2 WHERE iddoc=lcIdDoc &&PONER EL GENNUMDOC()
*!*					ENDIF 
*!*				ELSE 
*!*					&&insertar el que sigue SI NO SE HA AGREGADO 
*!*					lnIdStored=gennumdoc(lcIdDoc)
*!*					INSERT INTO docnum(iddoc,prefijo,id, estado ) VALUES (lcIdDoc,lcPrefijo,extractIntfromiddoc(lnIdStored),1)
*!*				ENDIF 

*!*			ENDFOR 
*!*		ENDIF 
ENDPROC 

PROCEDURE AddPlper_Elem 
LPARAMETERS tcTable,tcName,tnTp,tnNaturalize
****14/01/2013 6:18 pm no se usa en conta puesto en comment por que no se usa en conta, son para planilla 
*!*	IF UPPER(tcTable)="PLPER_ELEM"
*!*		IF !VARTYPE(_SCREEN.Function1)="O"
*!*			_screen.NewObject("Function1","Functions","lib1.0\_vars.vcx")
*!*		ENDIF 
*!*		
*!*		IF VARTYPE(gaPlPer_elem)="U"
*!*			_screen.Function1.Genplsmatrix()
*!*		ELSE
*!*			_screen.Function1.Genplsmatrix(.t.)
*!*			_screen.Function1.Genplsmatrix(.f.)
*!*		ENDIF 
*!*		
*!*		lcCategoria=gaPlPer_elem(IIF(tnTp=0,1,tnTp))
*!*		lcIcono=gaPlPer_elemImage(IIF(tnTp=0,1,tnTp))
*!*		
*!*	*!*		MESSAGEBOX("tcName")
*!*	*!*		MESSAGEBOX(tcName)
*!*	*!*		MESSAGEBOX(vartype(tcName))
*!*	*!*		MESSAGEBOX("tnTp")
*!*	*!*		MESSAGEBOX(VARTYPE(tnTp))
*!*	*!*		MESSAGEBOX("tnNaturalize")
*!*	*!*		MESSAGEBOX(VARTYPE(tnNaturalize))

*!*		SELECT IDELEMENT FROM plper_elem WHERE UPPER(ALLTRIM(descrip))=UPPER(ALLTRIM(tcName)) INTO ARRAY laDescripPlper_Elem 
*!*		IF VARTYPE(laDescripPlper_Elem )="U"
*!*			lcDocnum=gennumdoc("4905")	

*!*			INSERT INTO plper_elem(IDELEMENT,DESCRIP,TP,CATEGORIA,ICONO,SKIPPER,CANUPDATE,NATURALIZE);
*!*			VALUES (lcDocnum,tcName,tnTp,lcCategoria,lcIcono,"51405",.F.,tnNaturalize)
*!*		ELSE 
*!*				
*!*			UPDATE plper_elem ;
*!*			SET DESCRIP=tcName,tp=tnTp,CATEGORIA=lcCategoria,ICONO=lcIcono,SKIPPER="51405",CANUPDATE=.f.,NATURALIZE=tnNaturalize;
*!*			WHERE IDELEMENT=laDescripPlper_Elem
*!*		ENDIF 
*!*	ELSE 

*!*		
*!*	ENDIF 
ENDPROC 

PROCEDURE AddPlie 
LPARAMETERS tcDescrip,tbActivo,tiCbase,tnmonto,tbMsaldo,tiAplica,tcIdperson,tiPeriodi,tdFecpl,tiTipo,tiSr
**14/01/2013 6:18 pm no se usa en conta 
*!*		IF !EMPTY(tcDescrip)
*!*			SELECT IDIE FROM PLIE WHERE UPPER(ALLTRIM(descrip))=UPPER(ALLTRIM(tcDescrip)) INTO ARRAY laIdPlie 

*!*			IF VARTYPE(laIdPlie )="U"
*!*				lcDocPlie=gennumdoc("4904")	
*!*				
*!*				INSERT INTO PLIE(IDIE,		DESCRIP,	ACTIVO,		CBASE,	MONTO,	MSALDO,		APLICA,		IDPERSON,	PERIODI,	FEC_PL,	TIPO,	ESTADO,	SR);
*!*				VALUES			(lcDocPlie,	tcDescrip,	tbActivo,	tiCbase,tnmonto,tbMsaldo,	tiAplica,	tcIdperson,	tiPeriodi,	tdFecpl,tiTipo,	1,		tiSr)
*!*			ELSE 
*!*				UPDATE PLIE;
*!*				SET ;
*!*					DESCRIP=tcDescrip,;
*!*					ACTIVO=tbActivo,;
*!*					CBASE=tiCbase,;
*!*					MONTO=tnmonto,;
*!*					MSALDO=tbMsaldo,;
*!*					APLICA=tiAplica,;
*!*					IDPERSON=tcIdperson,;
*!*					PERIODI=tiPeriodi,;
*!*					FEC_PL=tdFecpl,;
*!*					TIPO=tiTipo,;
*!*					ESTADO=1,;
*!*					SR=tiSr;
*!*				WHERE DESCRIP=laIdPlie 
*!*			ENDIF 
*!*		ENDIF 
ENDPROC