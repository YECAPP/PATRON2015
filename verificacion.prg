IF !USED("c1")
	USE  ? &&"F:\CONTA SAMUEL act\c1" 
ENDIF 
GO TOP IN c1 
SELECT c1 
SET ORDER TO CODIGO   && CODIGO
RELEASE aCodigo


SELECT valor FROM infoapp WHERE idinfo="0000000002" INTO ARRAY laDeudoras
IF VARTYPE(laDeudoras)="U"
	INSERT INTO INFOAPP (IDINFO,DSC,TP,VALOR);
		VALUES ("0000000002","Cuenta Deudoras",5,"1,4")
	lcCuentaDeudora="1,4"
ELSE
	lcCuentaDeudora=laDeudoras
ENDIF 





SELECT valor FROM infoapp WHERE idinfo="0000000004" INTO ARRAY laGasto
IF VARTYPE(laGasto)="U"
	INSERT INTO INFOAPP (IDINFO,DSC,TP,VALOR);
		VALUES ("0000000004","Cuenta de Gastos",5,"4")
	lcCuentaGasto="4"
ELSE
	lcCuentaGasto=laGasto
ENDIF 

SELECT valor FROM infoapp WHERE idinfo="0000000005" INTO ARRAY laIng
IF VARTYPE(laIng)="U"
	INSERT INTO INFOAPP (IDINFO,DSC,TP,VALOR);
		VALUES ("0000000005","Cuenta de Ingresos",5,"5")
	lcCuentaIng="5"
ELSE

	lcCuentaIng=laIng
ENDIF 



SELECT valor FROM infoapp WHERE idinfo="0000000006" INTO ARRAY laRes
IF VARTYPE(laRes)="U"
	INSERT INTO INFOAPP (IDINFO,DSC,TP,VALOR);
		VALUES ("0000000006","Cuenta de Ingresos",5,"6")
	lcCuentaRes="6"
ELSE
	lcCuentaRes=laRes
ENDIF 

SELECT valor FROM infoapp WHERE idinfo="0000000007" INTO ARRAY laOrden
IF VARTYPE(laOrden)="U"
	INSERT INTO INFOAPP (IDINFO,DSC,TP,VALOR);
		VALUES ("0000000007","Cuenta de Ingresos",5,"7")
	lcCuentaOrd="7"
ELSE
	lcCuentaOrd=laOrden
ENDIF 

SELECT valor FROM infoapp WHERE idinfo="0000000008" INTO ARRAY laPres
IF VARTYPE(laPres)="U"
	INSERT INTO INFOAPP (IDINFO,DSC,TP,VALOR);
		VALUES ("0000000008","Cuenta de Presupuestos",5,"8")
	lcCuentaPres="8"
ELSE
	lcCuentaPres=laPres
ENDIF 


DO WHILE !EOF()
	lcCodigo=ALLTRIM(c1.codigo)
	WAIT "Configurando cuenta:"+lcCodigo WINDOW NOWAIT  
	SELECT;
		c1.codigo;
	FROM ;
		c1 ;
	WHERE ;
		SUBSTR(c1.codigo,1,LEN(lcCodigo))==lcCodigo;
	INTO ARRAY ;
		aCodigo
		
		
	
	IF alen(aCodigo)>1
		*MESSAGEBOX(lcCodigo+"Es de _mayor ")
		replace c1.cta  WITH 1
	ELSE 
		*MESSAGEBOX(lcCodigo+"Es de detalle ")
		replace c1.cta  WITH 2
	ENDIF 
	
	
	*IF MESSAGEBOX("desea seguir ",4,"",1)=7
		RELEASE aCodigo
	*	EXIT 
	*ELSE 
	DO CASE
	CASE INLIST(SUBSTR(lcCodigo,1,1),"1","2","3")
		REPLACE TIPO WITH 1
	CASE INLIST(VAL(SUBSTR(lcCodigo,1,1)),&lcCuentaGasto)
		REPLACE TIPO WITH 2
	CASE INLIST(VAL(SUBSTR(lcCodigo,1,1)),&lcCuentaIng)
		REPLACE TIPO WITH 3
	CASE INLIST(VAL(SUBSTR(lcCodigo,1,1)),&lcCuentaRes)
		REPLACE TIPO WITH 4
	CASE INLIST(VAL(SUBSTR(lcCodigo,1,1)),&lcCuentaOrd)
		REPLACE TIPO WITH 4		
	CASE INLIST(VAL(SUBSTR(lcCodigo,1,1)),&lcCuentaPres)
		REPLACE TIPO WITH 4				
	OTHERWISE
		REPLACE TIPO WITH 4
	ENDCASE
	
		
	IF INLIST(VAL(SUBSTR(lcCodigo,1,1)),&lcCuentaDeudora)
		REPLACE SALDO WITH 1
	ELSE
		REPLACE SALDO WITH 2
	ENDIF 	
	
		SKIP 1 IN c1 
	*ENDIF 	
			
ENDDO 
