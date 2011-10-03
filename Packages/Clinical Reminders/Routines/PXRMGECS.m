PXRMGECS ;SLC/JVS GEC-Reports-cont'd ;7/14/05  10:45
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
 ;____
DFN2 ;DFN array for By Provider Report
 N DFN,DOCT,DIADA,DATEV,FLAG,REF,DFN1
 S REF="^TMP(""PXRMGEC"",$J)",DFN1=0
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 W @IOF
 W "=============================================================================="
 W !,"GEC Provider"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Provider"
 I FOR W !,"  Patient",?17,"Completion Date",?41,"Dialog"
 I 'FOR W !,"Provider^IEN^Patient^SS#^Dialog^Completion Date"
 W !,"=============================================================================="
 W ! D PB Q:Y=0
 D E^PXRMGECV("DFN",1,BDT,EDT,"F",0)
 S DOCT=0 F  S DOCT=$O(@REF@("DFN",DOCT)),FLAG=1 Q:DOCT=""!(Y=0)  D
 .I PROV>0&('$D(PROVARY(DOCT))) Q
 .I FOR W:FLAG=1 !!,IOUON,$$GET1^DIQ(200,DOCT,.01)_" ("_DOCT_")",IOUOFF,! D PB Q:Y=0
 .I FOR D PB Q:Y=0
 .S DFN=0 F  S DFN=$O(@REF@("DFN",DOCT,DFN)) Q:DFN=""!(Y=0)  D
 ..S DATEV=0 F  S DATEV=$O(@REF@("DFN",DOCT,DFN,DATEV)) Q:DATEV=""  D
 ...S DIADA=0 F  S DIADA=$O(@REF@("DFN",DOCT,DFN,DATEV,DIADA)) Q:DIADA=""!(Y=0)  D
 ....I FOR W !,?2,$S(DFN'=DFN1!(FLAG=1):$P($G(^DPT(DFN,0)),"^",1)_" ("_$P($G(^DPT(DFN,0)),"^",9)_")"_" ("_$$CNT^PXRMGECL(DOCT,DFN)_" Evaluation(s) )",1:"") D PB Q:Y=0
 ....I FOR I DFN'=DFN1!(FLAG=1) W !
 ....S FLAG=0
 ....W ?17,$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1,2),?41,$P($P($G(^PXRMD(801.41,DIADA,0)),"^",1)," ",3,6)
 ....S DFN1=DFN
 ....I FOR D PB Q:Y=0
 ....I 'FOR W !,$$GET1^DIQ(200,DOCT,.01)_"^"_DOCT,"^",$P($G(^DPT(DFN,0)),"^",1)_"^"_$P($G(^DPT(DFN,0)),"^",9),"^",$P($P($G(^PXRMD(801.41,DIADA,0)),"^",1)," ",3,6),"^",$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1,2)
 K ^TMP("PXRMGEC",$J)
 Q
 ;
CTL ;Referrals Counts by Location
 N LOC,TOTAL,ACCTOT
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
 ;TMP("PXRMGEC",$J,"REFLOCC",LOC)="3"
 W ! D PB Q:Y=0
 S LOC=0 F  S LOC=$O(@REF@("REFLOCC",LOC)) Q:LOC=""  D
 .S TOTAL=$G(@REF@("REFLOCC",LOC)) S ACCTOT=ACCTOT+TOTAL
 .I FOR W !,LOC,?25,$J(TOTAL,3)
 .I 'FOR W !,LOC,"^",TOTAL
 I FOR W !,"_____________________________" D PB Q:Y=0
 I FOR W !,"Total Referrals",?25,$J(ACCTOT,3) D PB Q:Y=0
 K ^TMP("PXRMGEC",$J)
 Q
 ;______________________________________________________________
CTDR ;Referrals Counts by Provider
 N DOC,TOTAL,ACCTOT,DIEN
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
 ;TMP("PXRMGEC",$J,"REFDOCC",DOC,DIEN)="3"
 W ! D PB Q:Y=0
 S DOC=0 F  S DOC=$O(^TMP("PXRMGEC",$J,"REFDOCC",DOC)) Q:DOC=""  D
 .S DIEN=0 F  S DIEN=$O(^TMP("PXRMGEC",$J,"REFDOCC",DOC,DIEN)) Q:DIEN=""  D
 ..S TOTAL=$G(^TMP("PXRMGEC",$J,"REFDOCC",DOC,DIEN)) S ACCTOT=ACCTOT+TOTAL
 ..I FOR W !,DOC," ("_DIEN_")",?37,$J(TOTAL,3)
 ..I 'FOR W !,DOC,"^",DIEN,"^",TOTAL
 I FOR W !,"_____________________________" D PB Q:Y=0
 I FOR W !,"Total Referrals",?37,$J(ACCTOT,3) D PB Q:Y=0
 K ^TMP("PXRMGEC",$J)
 Q
 ;______________________________________________________________
CTP ;Referrals Counts by Patient
 N PATIENT,TOTAL,ACCTOT,CNT,DFNN,STATUS,DIV
 S ACCTOT=0
 D E^PXRMGECV("CTP",1,BDT,EDT,"F",0)
 I FORMAT="F" S FOR=1
 I FORMAT="D" S FOR=0
 W @IOF
 W "=============================================================================="
 W !,"Referral Count by Patient"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Patient",?25,"SSN",?37,"Total Count",?56,"Division"
 I 'FOR W !,"Patient^SSN^Total Count"
 W !,"=============================================================================="
 S CNT=0
 ;TMP("PXRMGEC",$J,"REFDFNN,PATIENT)="3"
 W ! D PB Q:Y=0
 S PATIENT=0 F  S PATIENT=$O(^TMP("PXRMGEC",$J,"REFDFNN",PATIENT)) Q:PATIENT=""  D
 .S DFNN=$O(^DPT("B",PATIENT,0))
 .S STATUS=$S($D(^DPT(DFNN,.1)):"INPATIENT",1:"OUTPATIENT")
 .S DIV=$$GET1^DIQ(2,DFNN,.19)
 .I STATUS["IN" I DIV="" S DIV="Unknown"
 .S CNT=CNT+1
 .S SSN=0 F  S SSN=$O(^TMP("PXRMGEC",$J,"REFDFNN",PATIENT,SSN)) Q:SSN=""  D
 ..S TOTAL=$G(^TMP("PXRMGEC",$J,"REFDFNN",PATIENT,SSN)) S ACCTOT=ACCTOT+TOTAL
 ..I FOR W !,CNT," ",PATIENT,?25,SSN,?37,$J(TOTAL,3),?44,STATUS,?56,DIV D PB Q:Y=0
 ..I 'FOR W !,PATIENT,"^",SSN,"^",TOTAL
 I FOR W !,"__________________________________" D PB Q:Y=0
 I FOR W !,"Total Referrals",?25,$G(SSN),?37,$J(ACCTOT,3)
 K ^TMP("PXRMGEC",$J)
 Q
 ;______________________________________________________________
CTD ;Referrals Counts by Date
 N DATE,TOTAL,ACCTOT
 S ACCTOT=0
 D E^PXRMGECV("CTD",1,BDT,EDT,"F",0)
 I FORMAT="F" S FOR=1
 I FORMAT="D" S FOR=0
 W @IOF
 W "=============================================================================="
 W !,"Referral Count by Date"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Date",?25,"Total Count"
 I 'FOR W !,"Date^Total Count"
 W !,"=============================================================================="
 ;TMP("PXRMGEC",$J,"REFDATE",DATE)="3"
 W ! D PB Q:Y=0
 S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"REFDATE",DATE)) Q:DATE=""  D
 .S TOTAL=$G(^TMP("PXRMGEC",$J,"REFDATE",DATE)) S ACCTOT=ACCTOT+TOTAL
 .I FOR W !,$$FMTE^XLFDT(DATE,"5ZM"),?25,$J(TOTAL,3) D PB Q:Y=0
 .I 'FOR W !,$$FMTE^XLFDT(DATE,"5ZM"),"^",TOTAL
 I FOR W !,"_____________________________" D PB Q:Y=0
 I FOR W !,"Total Referrals",?25,$J(ACCTOT,3) D PB Q:Y=0
 K ^TMP("PXRMGEC",$J)
 Q
 ;
PB ;PAGE BREAK
 S Y=""
 I $Y=(IOSL-2)!($Y=(IOSL-3)) D
 .K DIR
 .S DIR(0)="E"
 .D ^DIR
 .I Y=1 W @IOF S $Y=0
 .W !
 K DIR
 Q
 ;
