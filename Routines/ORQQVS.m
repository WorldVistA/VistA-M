ORQQVS ; slc/CLA,STAFF - Functions which return patient visits ;3/16/05  10:27
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,195,215,271**;Dec 17, 1997;Build 2
 ;
 ; DBIA 2812   NOTES^TIUSRVLV   ^TMP("TIULIST",$J)
 ; DBIA 2944   TGET^TIUSRVR1    ^TMP("TIUVIEW",$J)
 ; DBIA 1905   SELECTED^VSIT    ^TMP("VSIT",$J)
 ; 
LIST(ORY,PT,ORSDT,OREDT,LOC) ; return visits for a patient between start & end dates for a location, if no location return all visits
 N VIEN,NUM,CNT,INVDT,ORSRV,CNTLIMIT,ORX
 S CNTLIMIT=100  ;limit visits to 100 most recent Visit entries
 S VIEN="A",NUM=0,CNT=1
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 I ORSDT="" D
 .I '$L(LOC) S ORSDT=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQEAPT ENC APPT START",1,"E"))
 .I ORSDT="" S ORSDT="T-730" ;default start date is two years ago
 I OREDT="" D
 .I '$L(LOC) S OREDT=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQEAPT ENC APPT STOP",1,"E"))
 .I OREDT="" S OREDT="T" ;default end date is today
 ;CONVERT ORSDT AND OREDT INTO FILEMAN DATE/TIME
 D DT^DILF("T",ORSDT,.ORSDT,"","")
 D DT^DILF("T",OREDT,.OREDT,"","")
 I (ORSDT=-1)!(OREDT=-1) S ORY(1)="^Error in date range." Q 
 K ^TMP("VSIT",$J)  ;DBIA 1905
 D SELECTED^VSIT(PT,ORSDT,OREDT,LOC,"")  ;DBIA 1905
 F  S VIEN=$O(^TMP("VSIT",$J,VIEN),-1) Q:VIEN=""!(CNT>CNTLIMIT)  D
 .F  S NUM=$O(^TMP("VSIT",$J,VIEN,NUM)) Q:NUM=""  D
 ..S ORX=^TMP("VSIT",$J,VIEN,NUM),INVDT=9999999-$P(ORX,U)
 ..I $$ACTLOC^ORWU(+$P(ORX,U,2))=1 D
 ...S ORY(CNT)=VIEN_U_ORX_U_INVDT,CNT=CNT+1
 K ^TMP("VSIT",$J)
 Q
VSITAPPT(ORVY,PT,SDT,EDT,DUMMY) ; return past visits and future appointments for a patient between start and end dates
 N NDT,CNT,I,TS,ORVSITY K ORVY D NOW^%DTC S NDT=+%,CNT=1 K %
 D PTAPPTS^ORQPTQ2(.ORYA,PT,NDT,EDT,"") ;get future appointments
 S I=0 F  S I=$O(ORYA(I)) Q:I<1  I ORYA(I)'["No appts",+ORYA(I) D
 .S ORVY(CNT)=$P(ORYA(I),U)_";s"_U_$P(ORYA(I),U,2)_U_"sched:"_U_$P(ORYA(I),U)
 .S ORVY(CNT)=ORVY(CNT)_U_$P(ORYA(I),U,5),CNT=CNT+1
 D LIST(.YV,PT,SDT,NDT,"") ;get past visits
 S I=0 F  S I=$O(YV(I)) Q:I<1  D
 .S ORVY(CNT)=$P(YV(I),U)_";v"_U_$P($P(YV(I),U,3),";",2)
 .I $P(YV(I),U,4)="H" D
 ..S ORVY(CNT)=$P(YV(I),U)_";a"_U_"Inpatient Stay"_U_"admitted:"
 .I $P(YV(I),U,4)'="H" S ORVY(CNT)=ORVY(CNT)_U_"visited:"
 .S ORVY(CNT)=ORVY(CNT)_U_$P(YV(I),U,2)_U_$P(YV(I),U,8),CNT=CNT+1
 S:+$G(ORVY(1))<1 ORVY(1)="^No appts or visits found."
 S TSTDT=DT_".2359"
 D DT^DILF("T",EDT,.EDT,"","")
 I (EDT>TSTDT) D
 . I '$L($P($G(ORYA(1)),U)),$L($P($G(ORYA(1)),U,2)),'$L($O(ORYA(1))) D
 . . K ORVY S ORVY(1)=ORYA(1)
 K ORYA,YV
 Q
DETNOTE(ORVY,ORPT,ORVIEN) ;return progress notes for a patient's visit
 N ORTY,ORY,TDT,ORVI
 S TDT=0
 K ^TMP("TIULIST",$J)  ;DBIA 2812
 D NOTES^TIUSRVLV(.ORY,ORVIEN)  ;DBIA 2812
 I '+$O(^TMP("TIULIST",$J,0)) D  Q
 . S ORVY(1)="No Progress Notes for this visit."
 S ORVI=1
 F  S TDT=$O(^TMP("TIULIST",$J,TDT)) Q:+TDT'>0  D
 . N SEQ,TIEN S SEQ=0
 . F  S SEQ=$O(^TMP("TIULIST",$J,TDT,SEQ)) Q:+SEQ'>0  D
 . . N TSEQ K ^TMP("TIUVIEW",$J)  ;DBIA 2944
 . . S TIEN=$P(^TMP("TIULIST",$J,TDT,SEQ),U)
 . . D TGET^TIUSRVR1(.ORTY,TIEN)  ;DBIA 2944
 . . S TSEQ=0
 . . F  S TSEQ=$O(@ORTY@(TSEQ)) Q:TSEQ=""  D
 . . . S ORVY(ORVI)=@ORTY@(TSEQ),ORVI=ORVI+1
 . . S ORVY(ORVI)=" ",ORVI=ORVI+1
 . . S ORVY(ORVI)=" ",ORVI=ORVI+1
 K ^TMP("TIULIST",$J)
 Q
DETSUM(ORVY,ORPT,ORVIEN) ;return discharge summary for a patient's visit
 N CR,ORTY,ORY,TDT
 S TDT=0
 K ^TMP("TIULIST",$J)
 D SUMMARY^TIUSRVLV(.ORY,ORVIEN)
 I '+$O(^TMP("TIULIST",$J,0)) D  Q
 . S ORVY(1)="No Discharge Summary found for this stay."
 F  S TDT=$O(^TMP("TIULIST",$J,TDT)) Q:+TDT'>0  D
 . N SEQ,TIEN S SEQ=0
 . F  S SEQ=$O(^TMP("TIULIST",$J,TDT,SEQ)) Q:+SEQ'>0  D
 . . N TSEQ,ORVI K ^TMP("TIUVIEW",$J)
 . . S TIEN=$P(^TMP("TIULIST",$J,TDT,SEQ),U)
 . . D TGET^TIUSRVR1(.ORTY,TIEN)
 . . S TSEQ=0,ORVI=1
 . . F  S TSEQ=$O(@ORTY@(TSEQ)) Q:TSEQ=""  D
 . . . S ORVY(ORVI)=@ORTY@(TSEQ),ORVI=ORVI+1
 . . S ORVY(ORVI)=" ",ORVI=ORVI+1
 . . S ORVY(ORVI)=" ",ORVI=ORVI+1
 K ^TMP("TIULIST",$J)
 Q
