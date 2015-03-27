#INCLUDE XLSINCLUDE.H

oExcel = Createobject("Excel.Application")
oExcel.Workbooks.Add()
oExcel.Sheets("Hoja1").Select()
oSelect=oExcel.Range("A8:B8") &&CREANDO EL OBJETO


DO Encabezado

SelectRange("A11")
DO cuerpo

SelectRange("A23")
DO cuerpo



oExcel.Visible = .T.
RELEASE oExcel
PROCEDURE Cuerpo 
	MoverValue(2,0,"D, G, de T..")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"Ch. # 9448326")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"11023.07")
	MoverValue(0,1,"Dirección General de Tesorería")
	MoverValue(0,1,"Declaraciòn Retenciones del I.S.R. Correspondientes a ")
	MoverValue(1,0,"Planillas mes de AGOSTO de 2014, según detalle.")
	MoverValue(-1,7,"11023.07")
	MoverValue(0,4,"4297.95")
	MoverValue(0,2,"6472.28")
	MoverValue(0,2,"178.17")
	MoverValue(0,2,"74.67")	 

	Mover(0,2)
	SumarHorizontal(-1,-8)	


**Linea 2
	Mover(0,-25)
	MoverValue(2,0,"AFP CRECER")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"Ch. # 9448327")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"4104.45")
	MoverValue(0,1,"AFP CRECER, S.A.")
	MoverValue(0,1,"Cancelación Planilla al mes de AGOSTO de 2014.")
	MoverValue(1,0,"Planillas mes de AGOSTO de 2014, según detalle.")
	MoverValue(-1,7,"4104.45")
	MoverValue(0,4,"490.3")
	MoverValue(0,1,"529.53")
	MoverValue(0,1,"1382.58")	
	MoverValue(0,1,"1493.16")
	MoverValue(0,1,"100.42")
	MOverValue(0,1,"108.46")
	
	Mover(0,3)
	SumarHorizontal(-1,-8)	
**Linea 3
	Mover(0,-25)
	MoverValue(2,0,"AFP CONFIA")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"Ch. # 9448328")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"3270.06")
	MoverValue(0,1,"AFP CONFIA, S.A.")
	MoverValue(0,1,"Cancelación Planilla al mes de AGOSTO de 2014.")
	MoverValue(1,0,"Planillas mes de AGOSTO de 2014, según detalle.")
	MoverValue(-1,7," $3,270.06")
	MoverValue(0,4,"818.72")
	MoverValue(0,1,"884.22")
	MoverValue(0,1,"753.43")	
	MoverValue(0,1,"813.69")
	MoverValue(0,1,"")
	MOverValue(0,1,"")
	
	Mover(0,3)
	SumarHorizontal(-1,-8)	


**Linea 4
	Mover(0,-25)
	MoverValue(2,0,"TRASL.FOND.")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"Ch. # 7754234")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"")
	MoverValue(0,1,"Banco Davivienda Salvadoreño")
	MoverValue(0,1,"Traslado fondos cancelac. Planillas  I Quincena SEPT.  2014")
	MoverValue(1,0,"")
	MoverValue(-1,6," 12000")
	MoverValue(0,3," 12000")	




**Linea 5
	Mover(0,-15)
	MoverValue(2,0,"TRASL.FOND.")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"Ch. # 7754235")
	MoverValue(0,1,"11/09/2014")
	MoverValue(0,1,"")
	MoverValue(0,1,"Banco Davivienda Salvadoreño")
	MoverValue(0,1,"Traslado fondos cancelac. Planillas  I Quincena SEPT.  2014")
	MoverValue(1,0,"")
	MoverValue(-1,6," 18000")
	MoverValue(0,3," 18000")	

	
**Linea 6
	Mover(0,-15)
	MoverValue(2,0,"Liq. gtos.Giras")
	MoverValue(0,1,"08/09/2014")
	MoverValue(0,1,"Ch. # 7754236")
	MoverValue(0,1,"12/09/2014")
	MoverValue(0,1,"103.79")
	MoverValue(0,1,"María Antonieta Luna de Echegoyén")
	MoverValue(0,1,"Liquidación gastos Giras/Gtos. de Personal/Gtos. Representac.")
	MoverValue(0,10," $103.79")
	MoverValue(0,2,"103.79")
	Mover(0,7)	
	
	SumarHorizontal(-1,-8)	


	


	
ENDPROC 


PROCEDURE Encabezado
	DO EncabezadoMemo
	DO EncabezadoDatos
	DO EncabezadoDetalle
	DO EncabezadoOtrosServicios
	DO EncabezadoPruebaArit 
ENDPROC 

PROCEDURE EncabezadoMemo
	SelectRange("A8:B8")
	oSelect.Merge()
	oSelect.HorizontalAlignment=xlCenter
	oSelect.Value="Memo N°"
	
	
	SelectRange("A9")
	oSelect.Value="Intern. Order"	
	SelectRange("B9")
	oSelect.Value="Gte.Marca"
	
	SelectRange("A10")
	oSelect.Value="Liq. gt.giras"
	SelectRange("B10")
	oSelect.Value="Gte./Coord."

	SelectRange("A11")
	oSelect.Value="# Autoriz."
	SelectRange("B11")
	oSelect.Value="Fecha"
	
	SelectRange("A8:B11")
	oSelect.Interior.color=65535
	
	Cuadricular()
	
ENDPROC 

PROCEDURE EncabezadoDatos
	SelectRange("C8:E10")
	oSelect.Merge()
	oSelect.HorizontalAlignment=xlCenter
	oSelect.Value="Datos generales operación bancaria"

	SelectRange("C11")
	oSelect.Value="Cheque N°"
	SelectRange("D11")
	oSelect.Value="Fecha"
	SelectRange("E11")
	oSelect.Value="Cant. US$D"
	
	SelectRange("C8:E11")
	oSelect.Interior.color=65535
	Cuadricular()
	
ENDPROC 

PROCEDURE EncabezadoDetalle
	SelectRange("F8:Q8")
	oSelect.EntireColumn.Hidden=.T.
	
	SelectRange("R8:w9")
	oSelect.Merge()
	oSelect.Value="DETALLE DE UNIDADES  DE NEGOCIO QUE FUNCIONAN EN EL SALVADOR"
	
	SelectRange("R10:S10")
	oSelect.Merge()
	oSelect.Value="CONSUMER HEALTH"
	
	SelectRange("T10:U10")
	oSelect.Merge() 
	oSelect.Value="CARDIOMETAB.C & GM"
*	SelectRangeValue("T10","CARDIOMETAB.C & GM")	

	
	SelectRange("V10:W10")
	oSelect.Merge()
	oSelect.Value="BIOTECNOLOGIA"
	
	SelectRangeValue("R11","Balance")		
	SelectRangeValue("S11","Resultado")		

	SelectRangeValue("T11","Balance")		
	SelectRangeValue("U11","Resultado")		

	SelectRangeValue("V11","Balance")		
	SelectRangeValue("W11","Resultado")		

	SelectRange("R8:W11")
	oSelect.Interior.color=65535
	Cuadricular()	
ENDPROC 

PROCEDURE EncabezadoOtrosServicios
	SelectRange("X8:Y9")
	oSelect.Merge()
	oSelect.Value="OTROS SERVICIOS "
	
	SelectRange("X10:Y10")
	oSelect.Merge()
	oSelect.Value="MENSAJERO/ENCARG. MTTO."
	
	SelectRange("X11")
	oSelect.Value="Balance"
	
	SelectRange("Y11")
	oSelect.Value="Resultado"
	
	
	SelectRange("X8:Y11")
	oSelect.Interior.color=65535
	Cuadricular()	
	

	
ENDPROC 

PROCEDURE EncabezadoPruebaArit
	SelectRange("Z8:Z11")
	oSelect.Merge()
	oSelect.Value="Prueba "+ CHR(13)+"Aritmética"

	oSelect.Interior.color=65535
	Cuadricular()
	
ENDPROC 

PROCEDURE SelectRangeValue
PARAMETERS tcRange,tcValue
	SelectRange(tcRange)
	oSelect.Value=tcValue
ENDPROC



PROCEDURE SelectRange
PARAMETERS tcRange
	oExcel.Range(tcRange).Select()
	oSelect=oExcel.Range(tcRange)
ENDPROC

PROCEDURE Cuadricular
LPARAMETERS tcRange

	oSelect.HorizontalAlignment=xlCenter

	oSelect.Borders(xlEdgeLeft).LineStyle = xlContinuous
	oSelect.Borders(xlEdgeLeft).Weight = xlThin
	
	oSelect.Borders(xlEdgeTop).LineStyle = xlContinuous
	oSelect.Borders(xlEdgeTop).Weight = xlThin
	
	oSelect.Borders(xlEdgeBottom).LineStyle = xlContinuous
	oSelect.Borders(xlEdgeBottom).Weight = xlThin
	
	oSelect.Borders(xlEdgeRight).LineStyle = xlContinuous
	oSelect.Borders(xlEdgeRight).Weight = xlThin

	oSelect.Borders(xlInsideVertical).LineStyle = xlContinuous
	oSelect.Borders(xlInsideVertical).Weight = xlThin

	oSelect.Borders(xlInsideHorizontal).LineStyle = xlContinuous
	oSelect.Borders(xlInsideHorizontal).Weight = xlThin

ENDPROC 


PROCEDURE MoverValue
lparameters tnRow,tnCol,tcValue
	Mover(tnRow,tnCol)
	IF SUBSTR(tcValue,1,1)="="
		oSelect.FormulaR1C1=tcValue
	ELSE
		oSelect.Value=tcValue		
	ENDIF 

ENDPROC 

PROCEDURE Mover
lparameters tnRow,tnCol
	IF VARTYPE(tnRow)="L"
		tnRow=0
	ENDIF 
	IF VARTYPE(tnCol)="L"
		tnCol=0
	ENDIF 
	
	IF IIF(tnRow<0,oSelect.Row-tnRow<0,.F.)
		tnRow=0
		WAIT "Rango fuera de hoja" WINDOW NOWAIT 
	ENDIF 

	IF IIF(tnCol<0,oSelect.Column-tnCol<0,.F.)
		tnCol=0
		WAIT "Rango fuera de hoja" WINDOW NOWAIT 
	ENDIF 

	oSelect=oExcel.Range(oSelect.offset(tnRow,tnCol).Address)
	
ENDPROC 
PROCEDURE Sumar
LPARAMETERS tcRange
	**ejemploRango horizontal RC[-2]:RC[-1]
	**ejemploRango vertical R[-2]C:R[-1]C
	lcFormula="=SUM("+tcRange+")"
	oSelect.FormulaR1C1=lcFormula
ENDPROC 

PROCEDURE SumarVertical
LPARAMETERS tnInit,tnEnd
	lcFormula="=SUM(R["+TRANSFORM(tnInit)+"]C:R["+TRANSFORM(tnEnd)+"]C)"
	oSelect.FormulaR1C1=lcFormula
ENDPROC 

PROCEDURE SumarHorizontal
LPARAMETERS tnInit,tnEnd
	lcFormula="=SUM(RC["+TRANSFORM(tnInit)+"]:RC["+TRANSFORM(tnEnd)+"])"
	oSelect.FormulaR1C1=lcFormula
ENDPROC 