&&29/12/2012	se agregaron dos parametros:
&&					a)tbSumGroup: evita que se produzca cualquier suma 
&&					b)tcCharSeparator: es el caracter que separa los formatos de celdas, esto con el fin de poder agregar comas al formato de moneda
&&				tambien se quito que cree grupos cuando se envia vacio tcGroupField
			
**EJEMPLO DE USO 
*DO frxtoxls WITH ;
	"NOMBRE",--------------------------->tcGroupField;  
	"NOMBRE",--------------------------->tcGroupFieldDescrip;	
	"CLI12",----------------------------->tcTable;	
	"Numero,Numero2,Nombre,Fecha,Dias,Total",-->tcLaTitles;
	"@;@;@;m/d/yyyy;###0.00;$###0.00;$#,##0.00",------------->tcAFormat;
	"Numero,Numero2,Nombre,Fecha,Dias,Total",------>tcAFields;
	"11,11,40,10,10,12",---------------------->tcAnchos;
	"cli12",----------------------------->tcTitle;
	"Reporte"--------------------------->tcTipoReporte
PROCEDURE frxtoxls
LPARAMETERS tcGroupField,tcGroupFieldDescrip,tcTable,tcLaTitles,tcAFormat,tcAFields,tcAnchos,tcTitle,tcTipoReporte,tbSumGroup,tcCharSeparator
	&&Crear obejto 
	oExcel = Createobject("Excel.Application")
	&&29/12/2012 se agrego comprobacion de version 
	
	IF VAL(oExcel.version)<12
		lcmsg=	"Version de Office debe ser 2007 o superior"+CHR(13)+;
				"puede continuar con la impresión del reporte, sin embargo algunas características"+CHR(13)+;
				"no funcionarán"
		MESSAGEBOX(lcmsg,16,"Advertencia")
		lbDoFormatPage=.f.
	ELSE
		lbDoFormatPage=.t.	
	ENDIF 
	oExcel.Workbooks.Add()
	oExcel.Sheets("Hoja1").Select()
	*oExcel.Visible = .T.  &&solo si se quiere mostrar la hoja durante la ejecucion 
	
	*29/12/2012:verificar numero de parametros enviados si son 9 se usara:
	*a)lbDontSumGroup=.f.
	*b)lcCharSeparator=","
	IF PCOUNT()=9
		lbSumGroup=.t.
		lcCharSeparator=","
	ELSE 
	*sino se usara los parametros que se envien 
		lbSumGroup=tbSumGroup
		lcCharSeparator=tcCharSeparator
	ENDIF 
	*fin 29/12/2012 
	
	lnRowInit=4
	lnTitleFont=10
	lnTitleColor=42
	lcTable=tcTable
	lnNumRegistros=RECCOUNT(lcTable)
	lnRowInit=5
	lcRowInit=ALLTRIM(STR(lnRowInit))
	lcRowInitTitle=ALLTRIM(STR(lnRowInit-1))
	lcGroupField=tcGroupField
	lcGroupFieldDEscrip=tcGroupFieldDescrip
	lcLastCellUsed=""

	SELECT (lctable) 
	lnCounterWait=RECCOUNT()
	lnStepCounter=20
	*FORMATOS MAS COMUNES PARA FECHA Y DINERO 
	*m/d/yyyy
	*$###0.00
	DO genATitles WITH tcLaTitles 	&&"Fecha,Codigo,Costo,Cantidad"
	DO genAFormat WITH tcAFormat  	&&"@;@;$###0.00;$###0.00;$#,##0.00"  
	DO genAFields WITH tcAFields  	&&"Fecha,Codigo,Costo,Cantidad"
	DO genAAnchos WITH tcAnchos   	&&"11,11,10,10"

	lcTitle=tcTitle
	lcTipoReport=tcTipoReporte

	*-- Títulos Reporte
	oExcel.Range("A1").Select()
	oExcel.ActiveCell.Value = lcTitle
	oExcel.selection.Font.Bold=.t.
	oExcel.selection.Font.size=lnTitleFont

	oExcel.Range("A2").Select()
	oExcel.ActiveCell.Value = lcTipoReport


	DO TITULOS WITH lcRowInitTitle
	DO FORMATOS 
	IF EMPTY(lcGroupField)
		DO CAMPOS 
	ELSE
		DO CAMPOSGROUP
	ENDIF 
	DO ANCHOS 
	IF lbDoFormatPage &&29/12/2012 formatpage solo se ejecutara si es 2007 o superior en las anteriores da problema 
		DO FORMATPAGE 
	ENDIF 
	SET FILTER TO IN (lcTable)
	oExcel.Range("A1").Select()
	oExcel.Visible = .T.
	Release oExcel
ENDPROC 

PROCEDURE CAMPOS
	
	lcGroupFieldValue=""
	lnOldCellGroup=""
	lnOldCellSum=0
	lnCounterSum=0
	nCellStart=lnRowInit
	GO TOP 
	DO WHILE !EOF()
	cCell = Transform(nCellStart)
			FOR N=1 TO ALEN(acFields)
				IF N>26
					IF N>52
						IF N>78
							IF N>104
								MESSAGEBOX("A sobrepasado el limite de periodos o cuentas posibles para comparar llame al programador y cotize actualizacion de sistema si desea comparar mas columnas")
							ENDIF 
							lcColumna=CHR(67)+CHR(64+(N-78))
							lcRange=lcColumna+cCell
						ELSE
							lcColumna=CHR(66)+CHR(64+(N-52))
							lcRange=lcColumna+cCell
						ENDIF 
					ELSE 
						lcColumna=CHR(65)+CHR(64+(N-26))
						lcRange=lcColumna+cCell
					ENDIF 
				ELSE 
					lcColumna=CHR(ASC("@")+N)
					lcRange=lcColumna+cCell
				ENDIF
				
				lcFieldName=acFields(N)
				oExcel.Range(lcRange).Select()
				lcExec=lcTable+"."+lcFieldName

				IF VARTYPE(&lcExec)="D"
					IF EMPTY(&lcExec)
						lcExec="TRANSFORM("+lcTable+"."+lcFieldName+")"
					ENDIF 
				ENDIF 
		
				oExcel.ActiveCell.Value =&lcExec
				
			ENDFOR
			lnCounterSum = lnCounterSum + 1  
			nCellStart = nCellStart +1
			SKIP 

				WAIT "Calculando...  Faltan "+TRANSFORM(lnCounterWait) WINDOW NOWAIT

			lnCounterWait= lnCounterWait- 1 

		
	ENDDO 
	DO suma WITH cCell,lnCounterSum 
	DO grupo WITH cCell,lnCounterSum 
	lcLastCellUsed=cCell
ENDPROC 




PROCEDURE CAMPOSGROUP
	
	lcGroupFieldValue=""
	lnOldCellGroup=""
	lnOldCellSum=0
	lnCounterSum=0
	nCellStart=lnRowInit
	
	GO TOP 
	DO WHILE !EOF()
	cCell = Transform(nCellStart)
		lcExec=lctable+"."+lcGroupField
		IF lcGroupFieldValue=&lcExec
			FOR N=1 TO ALEN(acFields)
				IF N>26
					IF N>52
						IF N>78
							IF N>104
								MESSAGEBOX("A sobrepasado el limite de periodos o cuentas posibles para comparar llame al programador y cotize actualizacion de sistema si desea comparar mas columnas")
							ENDIF 
							lcColumna=CHR(67)+CHR(64+(N-78))
							lcRange=lcColumna+cCell
						ELSE
							lcColumna=CHR(66)+CHR(64+(N-52))
							lcRange=lcColumna+cCell
						ENDIF 
					ELSE 
						lcColumna=CHR(65)+CHR(64+(N-26))
						lcRange=lcColumna+cCell
					ENDIF 
				ELSE 
					lcColumna=CHR(ASC("@")+N)
					lcRange=lcColumna+cCell
				ENDIF
				lcFieldName=acFields(N)
				oExcel.Range(lcRange).Select()
				lcExec=lcTable+"."+lcFieldName
				
				*MESSAGEBOX(lcExec)
				*MESSAGEBOX(&lcExec)
				IF VARTYPE(&lcExec)="D"
					IF EMPTY(&lcExec)
						lcExec="TRANSFORM("+lcTable+"."+lcFieldName+")"
					ENDIF 
				ENDIF 
				oExcel.ActiveCell.Value =&lcExec
				
			ENDFOR
			lnCounterSum = lnCounterSum + 1  
			nCellStart = nCellStart +1
			SKIP 

				WAIT "Calculando...  Faltan "+TRANSFORM(lnCounterWait) WINDOW NOWAIT

			lnCounterWait= lnCounterWait- 1 
			**Si el proveedor no es el mismo crear un nuevo grupo 						
			lcExec=lctable+"."+lcGroupField
			IF !lcGroupFieldValue=&lcExec
				nCellStart = nCellStart +1
				DO suma WITH cCell,lnCounterSum 
				DO grupo WITH cCell,lnCounterSum 
				
			ENDIF 

		ELSE 
				lnCounterSum =0
				lcExec=lctable+"."+lcGroupField+IIF(EMPTY(lcGroupFieldDEscrip),"","+' '+"+lctable+"."+lcGroupFieldDEscrip)		
				
				oExcel.Range("A"+cCell+":"+chr(ASC("A")+ALEN(acfields))+cCell).Select()
				oExcel.selection.Font.Bold=.t.
				oExcel.selection.Font.size=lnTitleFont
				oExcel.selection.Borders(9).LineStyle=1
				oExcel.selection.Borders(9).weight=2
				oExcel.selection.Borders(9).ColorIndex=11
				oExcel.ActiveCell.Value = &lcExec
				
				
				lcExec=lctable+"."+lcGroupField
				nCellStart = nCellStart +1
				lcGroupFieldValue=&lcExec
			
		ENDIF 
		
	ENDDO 
	lcLastCellUsed=cCell
ENDPROC 

PROCEDURE FORMATPAGE
	oExcel.ActiveSheet.PageSetup.PrintArea="$A$1:$"+chr(ASC("A")+ALEN(acfields))+lcLastCellUsed
	oExcel.ActiveSheet.PageSetup.FitToPagesWide=1
	oExcel.ActiveSheet.PageSetup.FitToPagesTall=999
	oExcel.ActiveSheet.PageSetup.CenterHorizontally=.t.
	oExcel.ActiveSheet.PageSetup.CenterVertically =.f.
	oExcel.ActiveSheet.PageSetup.LeftHeader=TTOC(DATETIME())
	oExcel.ActiveSheet.PageSetup.CenterHeader="Página &P"
*	oExcel.ActiveSheet.PageSetup.PaperSize=122
	oExcel.ActiveWindow.View = 2
	oExcel.ActiveSheet.PageSetup.FitToPagesWide = 1
	oExcel.ActiveSheet.PageSetup.FitToPagesTall = 999
	*oExcel.ActiveSheet.VPageBreaks(1).DragOff(-4161,1)
	oExcel.ActiveWindow.View = 1
ENDPROC 

PROCEDURE GRUPO
LPARAMETERS tcRow,lnRangeToGroup
	IF !EMPTY(lcGroupField)  &&29/12/2012 se agrego para que evite que genere grupos si no se mando campo de agrupacion
		lcRowIni=TRANSFORM(VAL(tcRow)-lnRangeToGroup)
		lcRowFin=TRANSFORM(VAL(tcRow)-1)
		oExcel.Range("A"+lcRowIni+":"+"A"+lcRowFin).select()
		oExcel.Selection.Rows.Group
	ENDIF 
ENDPROC 


PROCEDURE SUMA
LPARAMETERS tcRow,lnRangeToSum
lcRangeToSum=TRANSFORM(lnRangeToSum)
tcRow=TRANSFORM(VAL(tcRow)+1)
	FOR N=1 TO ALEN(acTitle)
		IF N>26
			IF N>52
				IF N>78
					IF N>104
						MESSAGEBOX("A sobrepasado el limite de periodos o cuentas posibles para comparar llame al programador y cotize actualizacion de sistema si desea comparar mas columnas")
					ENDIF 
					lcColumna=CHR(67)+CHR(64+(N-78))
					lcRange=lcColumna+tcRow
				ELSE
					lcColumna=CHR(66)+CHR(64+(N-52))
					lcRange=lcColumna+tcRow
				ENDIF 
			ELSE 
				lcColumna=CHR(65)+CHR(64+(N-26))
				lcRange=lcColumna+tcRow
			ENDIF 
		ELSE 
			lcColumna=CHR(ASC("@")+N)
			lcRange=lcColumna+tcRow
		ENDIF 
		oExcel.Range(lcRange).Select()
		IF lbSumGroup &&29/12/2012 sumar solo si se pide 
			IF oExcel.selection.NumberFormat="$###0.00" OR oExcel.selection.NumberFormat="$#,##0.00" &&29/12/2012 se agrego que tambien considere el formato con coma 
				oExcel.ActiveCell.FormulaR1C1="=SUM(R[-"+lcRangeToSum+"]C:R[-1]C)"
				oExcel.selection.Font.Bold=.t.
				oExcel.selection.Font.size=lnTitleFont
				oExcel.selection.interior.colorindex=lnTitleColor
				oExcel.selection.interior.Pattern=1
			ENDIF 
		ENDIF 
	ENDFOR 

ENDPROC 


PROCEDURE TITULOS 
	LPARAMETERS tcRow
	FOR N=1 TO ALEN(acTitle)
		IF N>26
			IF N>52
				IF N>78
					IF N>104
						MESSAGEBOX("A sobrepasado el limite de periodos o cuentas posibles para comparar llame al programador y cotize actualizacion de sistema si desea comparar mas columnas")
					ENDIF 
					lcColumna=CHR(67)+CHR(64+(N-78))
					lcRange=lcColumna+tcRow
				ELSE
					lcColumna=CHR(66)+CHR(64+(N-52))
					lcRange=lcColumna+tcRow
				ENDIF 
			ELSE 
				lcColumna=CHR(65)+CHR(64+(N-26))
				lcRange=lcColumna+tcRow
			ENDIF 
		ELSE 
			lcColumna=CHR(ASC("@")+N)
			lcRange=lcColumna+tcRow
		ENDIF 
		oExcel.Range(lcRange).Select()
		oExcel.ActiveCell.Value=acTitle(N)
		oExcel.selection.Font.Bold=.t.
		oExcel.selection.Font.size=lnTitleFont
		oExcel.selection.interior.colorindex=lnTitleColor
		oExcel.selection.interior.Pattern=1
	ENDFOR	
ENDPROC 

PROCEDURE ANCHOS
	FOR N=1 TO ALEN(anAnchos)
		IF N>26
			IF N>52
				IF N>78
					IF N>104
						MESSAGEBOX("A sobrepasado el limite de periodos o cuentas posibles para comparar llame al programador y cotize actualizacion de sistema si desea comparar mas columnas")
					ENDIF 
					lcColumna=CHR(67)+CHR(64+(N-78))
					lcRange=lcColumna+":"+lcColumna
				ELSE
					lcColumna=CHR(66)+CHR(64+(N-52))
					lcRange=lcColumna+":"+lcColumna
				ENDIF 
			ELSE 
				lcColumna=CHR(65)+CHR(64+(N-26))
				lcRange=lcColumna+":"+lcColumna
			ENDIF 
		ELSE 
			lcColumna=CHR(ASC("@")+N)
			lcRange=lcColumna+":"+lcColumna
		ENDIF 
		*oExcel.Columns(lcRange).Select()
		oExcel.Selection.Columns(lcRange).ColumnWidth=anAnchos(N)
	ENDFOR	
ENDPROC 





PROCEDURE FORMATOS
	FOR N=1 TO ALEN(acFormat)
		IF N>26
			IF N>52
				IF N>78
					IF N>104
						MESSAGEBOX("A sobrepasado el limite de periodos o cuentas posibles para comparar llame al programador y cotize actualizacion de sistema si desea comparar mas columnas")
					ENDIF 
					lcColumna=CHR(67)+CHR(64+(N-78))
					lcRange=lcColumna+":"+lcColumna
				ELSE
					lcColumna=CHR(66)+CHR(64+(N-52))
					lcRange=lcColumna+":"+lcColumna
				ENDIF 
			ELSE 
				lcColumna=CHR(65)+CHR(64+(N-26))
				lcRange=lcColumna+":"+lcColumna
			ENDIF 
		ELSE 
			lcColumna=CHR(ASC("@")+N)
			lcRange=lcColumna+":"+lcColumna
		ENDIF 
		oExcel.Columns(lcRange).Select()
		oExcel.selection.NumberFormat=acFormat(N)
	ENDFOR	
ENDPROC 

PROCEDURE genATitles
LPARAMETERS tcTitle
	**contar numero de comas en la expresion
	N=1
	DO WHILE !ATC(",",tcTitle,N)=0
		N = N + 1 
	ENDDO 
	**Separar expresiones para los titulos
	PUBLIC acTitle(N)
	lnStartPosition=1
	lnEndPosition=0
	lnCharReturn=0
	FOR N=1 TO ALEN(acTitle)
		lnEndPosition=IIF(ATC(",",tcTitle,N)=0,LEN(tcTitle)+1,ATC(",",tcTitle,N))
		lnCharReturn=lnEndPosition-lnStartPosition
		acTitle(N)=SUBSTR(tcTitle,lnStartPosition,lnCharReturn)
		lnStartPosition=lnEndPosition+1
	ENDFOR
ENDPROC 

PROCEDURE genAAnchos
LPARAMETERS tcAnchos

	**contar numero de comas en la expresion
	N=1
	DO WHILE !ATC(",",tcAnchos,N)=0
		N = N + 1 
	ENDDO 
	**Separar expresiones para los titulos
	PUBLIC anAnchos(N)
	lnStartPosition=1
	lnEndPosition=0
	lnCharReturn=0
	FOR N=1 TO ALEN(anAnchos)
		lnEndPosition=IIF(ATC(",",tcAnchos,N)=0,LEN(tcAnchos)+1,ATC(",",tcAnchos,N))
		lnCharReturn=lnEndPosition-lnStartPosition
		anAnchos(N)=VAL(SUBSTR(tcAnchos,lnStartPosition,lnCharReturn))
		lnStartPosition=lnEndPosition+1
	ENDFOR
ENDPROC 


PROCEDURE genAFormat
LPARAMETERS tcFormat
	**contar numero de comas(29/12/2012 ó puntos o comas ) en la expresion
	N=1
	DO WHILE !ATC(lcCharSeparator,tcFormat,N)=0 &&29/12/2012 se agregó lcCharSeparator
		N = N + 1 
	ENDDO 
	**Separar expresiones para los titulos
	PUBLIC  acFormat(N)
	lnStartPosition=1
	lnEndPosition=0
	lnCharReturn=0
	FOR N=1 TO ALEN(acFormat)
		lnEndPosition=IIF(ATC(lcCharSeparator,tcFormat,N)=0,LEN(tcFormat)+1,ATC(lcCharSeparator,tcFormat,N)) &&29/12/2012 se agregó lcCharSeparator
		lnCharReturn=lnEndPosition-lnStartPosition
		acFormat(N)=SUBSTR(tcFormat,lnStartPosition,lnCharReturn)
		lnStartPosition=lnEndPosition+1
	ENDFOR
ENDPROC 

PROCEDURE genAFields
LPARAMETERS tcFields
	**contar numero de comas en la expresion
	N=1
	DO WHILE !ATC(",",tcFields,N)=0
		N = N + 1 
	ENDDO 
	**Separar expresiones para los titulos
	PUBLIC  acFields(N)
	lnStartPosition=1
	lnEndPosition=0
	lnCharReturn=0
	FOR N=1 TO ALEN(acFields)
		lnEndPosition=IIF(ATC(",",tcFields,N)=0,LEN(tcFields)+1,ATC(",",tcFields,N))
		lnCharReturn=lnEndPosition-lnStartPosition
		acFields(N)=SUBSTR(tcFields,lnStartPosition,lnCharReturn)
		lnStartPosition=lnEndPosition+1
	ENDFOR
ENDPROC 

