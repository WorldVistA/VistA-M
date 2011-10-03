GMVDCCNV ;HOIFO/DAD,FT-VITALS COMPONENT: CONVERT UNITS ;9/29/00  09:15
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10143 - XLFMSMT calls        (supported)
 ;
CNV(GMVALUE,GMVMSYS,GMVOPER,GMVTYPE) ;
 ; Unit conversion
 ; Input:
 ;  GMVALUE = The value to be converted
 ;  GMVMSYS = The desired Measurement system
 ;  GMVOPER = The operation taking place (G - Get data, S - Save data)
 ;  GMVTYPE = The Vital Type abbreviation
 ; Output:
 ;  The measurement expressed in the desired units
 I $G(GMVALUE)]"",$G(GMVMSYS)]"",$G(GMVOPER)]"",$G(GMVTYPE)]"" D
 . I "^T^"[(U_GMVTYPE_U) S GMVALUE=$$TMP(GMVALUE,GMVMSYS,GMVOPER)
 . I "^WT^"[(U_GMVTYPE_U) S GMVALUE=$$WEI(GMVALUE,GMVMSYS,GMVOPER)
 . I "^CVP^"[(U_GMVTYPE_U) S GMVALUE=$$CVP(GMVALUE,GMVMSYS,GMVOPER)
 . I "^HT^AG^FH^HC^CG^"[(U_GMVTYPE_U) S GMVALUE=$$LEN(GMVALUE,GMVMSYS,GMVOPER)
 . Q
 Q $G(GMVALUE)
 ;
TMP(GMVALUE,GMVMSYS,GMVOPER) ;
 ; Temperature conversion
 ; Input:
 ;  GMVALUE = The value to be converted
 ;  GMVMSYS = The desired Measurement system
 ;  GMVOPER = The operation taking place (G - Get data, S - Save data)
 ; Output:
 ;  The measurement expressed in the desired units
 I GMVMSYS="M" D
 . N GMVFR,GMVTO
 . I GMVOPER="G" S GMVFR="F",GMVTO="C"
 . I GMVOPER="S" S GMVFR="C",GMVTO="F"
 . S GMVALUE=$P($$TEMP^XLFMSMT(GMVALUE,GMVFR,GMVTO)," ")
 . Q
 Q GMVALUE
 ;
LEN(GMVALUE,GMVMSYS,GMVOPER) ;
 ; Length conversion
 ; Input:
 ;  GMVALUE = The value to be converted
 ;  GMVMSYS = The desired Measurement system
 ;  GMVOPER = The operation taking place (G - Get data, S - Save data)
 ; Output:
 ;  The measurement expressed in the desired units
 I GMVMSYS="M" D
 . N GMVFR,GMVTO
 . I GMVOPER="G" S GMVFR="IN",GMVTO="CM"
 . I GMVOPER="S" S GMVFR="CM",GMVTO="IN"
 . S GMVALUE=$P($$LENGTH^XLFMSMT(GMVALUE,GMVFR,GMVTO)," ")
 . Q
 Q GMVALUE
 ;
WEI(GMVALUE,GMVMSYS,GMVOPER) ;
 ; Weight conversion
 ; Input:
 ;  GMVALUE = The value to be converted
 ;  GMVMSYS = The desired Measurement system
 ;  GMVOPER = The operation taking place (G - Get data, S - Save data)
 ; Output:
 ;  The measurement expressed in the desired units
 I GMVMSYS="M" D
 . N GMVFR,GMVTO
 . I GMVOPER="G" S GMVFR="LB",GMVTO="KG"
 . I GMVOPER="S" S GMVFR="KG",GMVTO="LB"
 . S GMVALUE=$P($$WEIGHT^XLFMSMT(GMVALUE,GMVFR,GMVTO)," ")
 . Q
 Q GMVALUE
 ;
CVP(GMVALUE,GMVMSYS,GMVOPER) ;
 ; Central Venous Pressure conversion
 ; Input:
 ;  GMVALUE = The value to be converted
 ;  GMVMSYS = The desired Measurement system
 ;  GMVOPER = The operation taking place (G - Get data, S - Save data)
 ; Output:
 ;  The measurement expressed in the desired units
 I GMVMSYS="M" D
 . I GMVOPER="G" S GMVALUE=$J(GMVALUE/1.36,0,3)
 . I GMVOPER="S" S GMVALUE=$J(GMVALUE*1.36,0,3)
 . Q
 Q GMVALUE
