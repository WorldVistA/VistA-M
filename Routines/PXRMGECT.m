PXRMGECT ;SLC/JVS GEC-Queued Reports-cont'd ;7/14/05  10:45
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
CTL ;Referrals Counts by Location
 N LOC,TOTAL,ACCTOT,PAGE
 S ACCTOT=0
 S REF="^TMP(""PXRMGEC"",$J)"
 D E^PXRMGECV("CTL",1,BDT,EDT,"F",0)
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 W @IOF
 W "=============================================================================="
 W !,"Referral Count by Location"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Location",?25,"Total Count"
 I 'FOR W !,"Location^Total Count"
 W !,"=============================================================================="
 S PAGE=1
 ;TMP("PXRMGEC",$J,"REFLOCC",LOC)="3"
 W ! D PAGE^PXRMGECZ
 S LOC=0 F  S LOC=$O(@REF@("REFLOCC",LOC)) Q:LOC=""  D
 .S TOTAL=$G(@REF@("REFLOCC",LOC)) S ACCTOT=ACCTOT+TOTAL
 .I FOR W !,LOC,?25,$J(TOTAL,3) D PAGE^PXRMGECZ
 .I 'FOR W !,LOC,"^",TOTAL D PAGE^PXRMGECZ
 I FOR W !,"_____________________________" D PAGE^PXRMGECZ
 I FOR W !,"Total Referrals",?25,$J(ACCTOT,3) D PAGE^PXRMGECZ
 K ^TMP("PXRMGEC",$J)
 Q
 ;______________________________________________________________
CTDR ;Referrals Counts by Provider
 N DOC,TOTAL,ACCTOT,DIEN,PAGE
 S ACCTOT=0
 D E^PXRMGECV("CTDR",1,BDT,EDT,"F",0)
 I FORMAT="F" S FOR=1
 I FORMAT="D" S FOR=0
 W @IOF
 W "=============================================================================="
 W !,"Referral Count by Provider"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Provider",?37,"Total Count"
 I 'FOR W !,"Provider^IEN^Total Count"
 W !,"=============================================================================="
 S PAGE=1
 ;TMP("PXRMGEC",$J,"REFDOCC",DOC)="3"
 W ! D PAGE^PXRMGECZ
 S DOC=0 F  S DOC=$O(^TMP("PXRMGEC",$J,"REFDOCC",DOC)) Q:DOC=""  D
 .S DIEN=0 F  S DIEN=$O(^TMP("PXRMGEC",$J,"REFDOCC",DOC,DIEN)) Q:DIEN=""  D
 ..S TOTAL=$G(^TMP("PXRMGEC",$J,"REFDOCC",DOC,DIEN)) S ACCTOT=ACCTOT+TOTAL
 ..I FOR W !,DOC," ("_DIEN_")",?37,$J(TOTAL,3) D PAGE^PXRMGECZ
 ..I 'FOR W !,DOC,"^",DIEN,"^",TOTAL D PAGE^PXRMGECZ
 I FOR W !,"_____________________________" D PAGE^PXRMGECZ
 I FOR W !,"Total Referrals",?37,$J(ACCTOT,3) D PAGE^PXRMGECZ
 K ^TMP("PXRMGEC",$J)
 Q
 ;______________________________________________________________
CTP ;Referrals Counts by Patient
 N PATIENT,TOTAL,ACCTOT,SSN,CNT,PAGE,DFNN,STATUS,DIV
 S ACCTOT=0
 D E^PXRMGECV("CTP",1,BDT,EDT,"F",0)
 I FORMAT="F" S FOR=1
 I FORMAT="D" S FOR=0
 W @IOF
 W "=============================================================================="
 W !,"Referral Count by Date"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Patient",?37,"Total Count",?56,"Division"
 I 'FOR W !,"Patient^SSN^Total Count"
 W !,"=============================================================================="
 S PAGE=1
 S CNT=0
 ;TMP("PXRMGEC",$J,"REFDFNN,PATIENT)="3"
 W ! D PAGE^PXRMGECZ
 S PATIENT=0 F  S PATIENT=$O(^TMP("PXRMGEC",$J,"REFDFNN",PATIENT)) Q:PATIENT=""  D
 .S DFNN=$O(^DPT("B",PATIENT,0))
 .S STATUS=$S($D(^DPT(DFNN,.1)):"INPATIENT",1:"OUTPATIENT")
 .S DIV=$$GET1^DIQ(2,DFNN,.19)
 .I STATUS["IN" I DIV="" S DIV="Unknown"
 .S CNT=CNT+1
 .S SSN=0 F  S SSN=$O(^TMP("PXRMGEC",$J,"REFDFNN",PATIENT,SSN)) Q:SSN=""   D
 ..S TOTAL=$G(^TMP("PXRMGEC",$J,"REFDFNN",PATIENT)) S ACCTOT=ACCTOT+TOTAL
 ..I FOR W !,CNT," ",PATIENT,?25,SSN,?37,$J(TOTAL,3),?44,STATUS,?56,DIV D PAGE^PXRMGECZ
 ..I 'FOR W !,PATIENT,"^",SSN,"^",TOTAL D PAGE^PXRMGECZ
 I FOR W !,"_____________________________" D PAGE^PXRMGECZ
 I FOR W !,"Total Referrals",?25,SSN,?37,$J(ACCTOT,3) D PAGE^PXRMGECZ
 K ^TMP("PXRMGEC",$J)
 Q
 ;______________________________________________________________
CTD ;Referrals Counts by Date
 N DATE,TOTAL,ACCTOT,PAGE
 S ACCTOT=0
 D E^PXRMGECV("CTD",1,BDT,EDT,"F",0)
 I FORMAT="F" S FOR=1
 I FORMAT="D" S FOR=0
 W @IOF
 W "=============================================================================="
 S PAGE=1
 W !,"Referral Count by Date"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Date",?25,"Total Count"
 I 'FOR W !,"Date^Total Count"
 W !,"=============================================================================="
 ;TMP("PXRMGEC",$J,"REFDATE",DATE)="3"
 W !
 S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"REFDATE",DATE)) Q:DATE=""  D
 .S TOTAL=$G(^TMP("PXRMGEC",$J,"REFDATE",DATE)) S ACCTOT=ACCTOT+TOTAL
 .I FOR W !,$$FMTE^XLFDT(DATE,"5ZM"),?25,$J(TOTAL,3) D PAGE^PXRMGECZ
 .I 'FOR W !,$$FMTE^XLFDT(DATE,"5ZM"),"^",TOTAL D PAGE^PXRMGECZ
 I FOR W !,"_____________________________" D PAGE^PXRMGECZ
 I FOR W !,"Total Referrals",?25,$J(ACCTOT,3) D PAGE^PXRMGECZ
 K ^TMP("PXRMGEC",$J)
 Q
 ;______________________________________________________________
