GMVDCVAM ;HOIFO/DAD,FT-VITALS COMPONENT: VALIDATE DATA (CONT.) ;9/26/00  15:31
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls       (supported)
 ;
DUPCHK ; *** Check for duplicate records ***
 N GMVD0,GMVDATA,GMVDUP
 S (GMVD0,GMVDUP)=0
 D DUPCH
 F  S GMVD0=$O(^GMR(120.5,"AA",GMVDFN,GMVVD0,9999999-GMVDTDUN,GMVD0)) Q:(GMVD0'>0)!(GMVDUP>0)  I $P($G(^GMR(120.5,GMVD0,2)),U)'>0 D
 . S GMVDATA=$G(^GMR(120.5,GMVD0,0))
 . I $P(GMVDATA,U,5,6)=(GMVHOSPL_U_GMVENTBY),$P(GMVDATA,U,8)=$P(GMVVMEAS,";") D DUPCH
 . Q
 S ^TMP($J,"GMVXREF",GMVVABBR,GMVQARRY)=""
 Q
 ;
DUPCH ; *** Get qualifier lists for duplicate check ***
 I "^BP^CG^P^R^"[(U_GMVVABBR_U) D  ; Vital types allowed to have dups
 . N GMVFLAG,GMVQD0,GMVSUB,GMVSUP
 . I GMVD0>0 D
 .. S GMVQD0=0,GMVQARRY(0)=U
 .. S GMVDUP(0)=$S($O(^GMR(120.5,GMVD0,5,"B",GMVQD0))>0:1,1:0)
 .. F  S GMVQD0=$O(^GMR(120.5,GMVD0,5,"B",GMVQD0)) Q:GMVQD0'>0  D
 ... S GMVQARRY(0)=GMVQARRY(0)_GMVQD0_U
 ... Q
 .. S GMVDUP(0)=$$DUPC(GMVQARRY(0),GMVQARRY,GMVDUP(0))
 .. Q
 . E  D
 .. S GMVQARRY(0)=""
 .. S GMVDUP(0)=$S($O(^TMP($J,"GMVXREF",GMVVABBR,GMVQARRY(0)))]"":1,1:0)
 .. F  S GMVQARRY(0)=$O(^TMP($J,"GMVXREF",GMVVABBR,GMVQARRY(0))) Q:(GMVQARRY(0)="")!(GMVDUP(0)'>0)  S GMVDUP(0)=$$DUPC(GMVQARRY(0),GMVQARRY,GMVDUP(0))
 .. Q
 . I GMVDUP(0)>0 D DUPMSG
 . Q
 E  D
 . I GMVD0>0 D
 .. D DUPMSG
 .. Q
 . E  D
 .. I $D(^TMP($J,"GMVXREF",GMVVABBR)) D DUPMSG
 .. Q
 . Q
 Q
 ;
DUPC(GMVQ1,GMVQ2,GMVDUP) ;
 ; *** Compare qualifiers look for duplicates ***
 N GMV,GMVSUB,GMVSUP
 S GMVSUP=$S($L(GMVQ1,U)>$L(GMVQ2,U):GMVQ1,1:GMVQ2)
 S GMVSUB=$S($L(GMVQ1,U)<$L(GMVQ2,U):GMVQ1,1:GMVQ2)
 I $L(GMVQ1,U)=$L(GMVQ2,U) S GMVSUP=GMVQ1,GMVSUB=GMVQ2
 F GMV=2:1:$L(GMVSUB,U)-1 I GMVSUP'[(U_$P(GMVSUB,U,GMV)_U) S GMVDUP=0 Q
 Q GMVDUP
 ;
DUPMSG ; *** Duplicate message ***
 S GMVDUP=1
 D MSG^GMVDCVAL("ERROR: Duplicate Vital Measurement data found (V^"_GMVVNUM_"="_GMVVHOLD_")")
 Q
 ;
BP ; *** Validate Systolic only Blood Pressure data ***
 I GMVVABBR'="BP" Q
 I $P(GMVVMEAS,";")?1.N S GMVSYSBP=1
 Q
 ;
PO2 ; *** Validate Supplemental O2 data ***
 S GMVVMEAS("PO2")=""
 I GMVVABBR'="PO2" Q
 I $$OMIT(GMVVMEAS),($P(GMVVMEAS,";",2)]"")!($P(GMVVMEAS,";",3)]"") D
 . D MSG^GMVDCVAL("ERROR: Supplemental O2 data not allowed if Pulse Oximetry is omitted (V^"_GMVVNUM_"="_GMVVHOLD_")")
 . Q
 I $P(GMVVMEAS,";",2)]"" D
 . I ($P(GMVVMEAS,";",2)'<.5)&($P(GMVVMEAS,";",2)'>20) D
 .. S GMVVMEAS("PO2")=$P(GMVVMEAS,";",2)_"L/min"
 .. Q
 . E  D
 .. D MSG^GMVDCVAL("ERROR: O2 Flow Rate must be in the range 0.5-20 (V^"_GMVVNUM_"="_GMVVHOLD_")")
 .. Q
 . Q
 I $P(GMVVMEAS,";",3)]"" D
 . I ($P(GMVVMEAS,";",3)'<0)&($P(GMVVMEAS,";",3)'>100) D
 .. S GMVVMEAS("PO2")=GMVVMEAS("PO2")_$S(GMVVMEAS("PO2")]"":" ",1:"")_$P(GMVVMEAS,";",3)_"%"
 .. Q
 . E  D
 .. D MSG^GMVDCVAL("ERROR: Percent O2 Concentration must be in the range 0-100 (V^"_GMVVNUM_"="_GMVVHOLD_")")
 .. Q
 . Q
 S GMVVMEAS=$P(GMVVMEAS,";")
 Q
 ;
OMIT(GMVVMEAS) ;
 ; *** Determine if measurement was omitted ***
 ; Input:
 ;  GMVVMEAS = A vital measurement
 ; Output:
 ;  1 - Measurement was omitted, 0 - Measurement was not omitted
 Q "^UNAVAILABLE^PASS^REFUSED^"[(U_$$UP^XLFSTR($P(GMVVMEAS,";"))_U)
 ;
