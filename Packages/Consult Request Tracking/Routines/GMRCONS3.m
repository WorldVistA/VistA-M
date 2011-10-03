GMRCONS3 ;ALB/MRY - Consult Status link report ;4/10/06  14:21
 ;;3.0;CONSULT/REQUEST TRACKING;**52**;DEC 27, 1997
NEWSTS ;
 N TEMPSTAT
 S TEMPSTAT=GMRCSTAT
 S GMRCSTAT=$$STS Q:GMRCSTAT=""
 ;S:$D(GMRCQUT) GMRCSTAT=TEMPSTAT
 D CT3
 Q
STS() ;Select a set of status for view.
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 N DIR,X,Y,GMRCSTCK
STSAGAIN ;Loop to get another status.
 S DIR(0)="SAOM^al:All Status's;ap:All Pending;dc:Discont.;c:Completed;p:Pending;a:Active;s:Scheduled;pr:Incomplete;x:Cancelled"
 S DIR("A")="Only Display Consults With Status of: "
 S DIR("B")="All Status's"
 I $D(GMRCSTCK) D
 . S DIR("A")="Another Status to display: "
 . K DIR("B")
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S GMRCQUT=1 G END
 I '$L(Y) G END
 D STCK($$LOW^XLFSTR(Y))
 I $D(GMRCSTCK),GMRCSTCK'="COM,PEN,ACT,SCH,INC,DSC,CAN" G STSAGAIN
END Q $S($D(GMRCSTCK):GMRCSTCK,1:"")
 ;
STCK(RES)     ;change code to status
 N CODE
 ; al:All Status's;dc:Discont.;c:Completed;h:On Hold;f:Flagged;p:Pending;a:Active;e:Expired;s:Scheduled
 ;;pr:Incomplete;d:Delayed;u:Unreleased;dce:Discont/Ed;x:Cancelled;l:Lapsed;rn:Renewed;':No Status")
CASE ;
 I RES="al" S GMRCSTCK="COM,PEN,ACT,SCH,INC,DSC,CAN" Q  ;All Status's
 ;                                display     no.  file name      file abbr.
 I RES="ap" D  Q
 .F CODE="PEN","ACT","SCH","INC" D CKCODE(CODE) ;   All Pending Statuses
 I RES="dc" D CKCODE("DSC") Q  ;  Discont.    1  DISCONTINUED       dc
 I RES="c" D CKCODE("COM") Q  ;   Completed   2  COMPLETE           c
 I RES="p" D CKCODE("PEN") Q  ;   Pending      5  PENDING            p
 I RES="a" D CKCODE("ACT") Q  ;   Active       6  ACTIVE             a
 I RES="s" D CKCODE("SCH") Q  ;   Scheduled    8  SCHEDULED          s
 I RES="pr" D CKCODE("INC") Q  ;  Incomplete   9  PARTIAL RESULTS   pr
 I RES="x" D CKCODE("CAN") Q  ;  Cancelled   13  CANCELLED          x
ENDCASE Q
 ;
CKCODE(CODE) ;
 I $D(GMRCSTCK),$$FND(CODE) W $C(7),!,"Already selected" Q
 ;I +$G(GMRCSTCK) S GMRCSTCK=GMRCSTCK_","_CODE
 ;I $G(GMRCSTCK) S GMRCSTCK=GMRCSTCK_","_CODE
 I $D(GMRCSTCK) S GMRCSTCK=GMRCSTCK_","_CODE
 E  S GMRCSTCK=CODE
 Q
 ;
FND(CD) ;status already selected?
 I GMRCSTCK=CD Q 1
 I $F(GMRCSTCK,(CD_",")) Q 1
 I $E(GMRCSTCK,$L(GMRCSTCK))=CD Q 1
 Q 0
 ;
NUMBER ;
 I GMRCCTRL'=120 S GMRCCTRL=120
 E  S GMRCCTRL=0
 Q
 ;
SUMARY ;
 ;;ACTERAP;Active, By Admin;Active, Edit Re-submit Admin Purpose
 ;;ACTERCC;Active, Can By Clinic;Active, Edit Re-submit, Cancel by Clinic
 ;;ACTERCP;Active, Can By Patient;Active, Edit Re-submit, Cancel by Patient
 ;;ACTERNS;Active, No-Show;Active, Edit Re-submit, No Show
 ;;ACTEROW;Active, Edit Resubmit;Active, Edit Re-submit, Old Way
 ;;ACTWOLHNWL;Active, Manually;Active, Without Link History
 ;;ACTWOLHWL;Active, EWL;Active, Without Link History
 ;;ACTWOLHIFC;Active, IFC;Active, Without Link History
 ;;CANCELED;Cancelled;Cancelled
 ;;COMPLETE;Completed;Completed
 ;;DSCNTUED;Discontinued;Discontinued
 ;;INCMPLTE;Incomplete;Incomplete
 ;;PENNWL;Pending;Pending
 ;;PENWL;Pending, EWL;Pending, Electronic Wait List
 ;;SCHWALCO;Sch, Linked, Ck'd Out;Scheduled, Linked, Checked Out;1
 ;;SCHWALNCO;Scheduled, Linked;Scheduled, Linked;1
 ;;SCHWHNAL;Sch, Not Linked now;Scheduled, Not Linked
 ;;SCHWOLHNWL;Sch, Never Linked;Scheduled, Without Link History
 ;;SCHWOLHWL;Schedule, EWL;Scheduled, Without Link history, wait listed
 ;;SCHWOLHIFC;Schedule, IFC;Scheduled, Without Link history, interfacility consult 
 ;;TOC;Total Open Consults;Total Open Consults
 ;;TCC;Total Closed Consults;Total Closed Consults
 ;;
CT3 ;print clinic summary
 D WAIT^DICD K ^TMP("GMRCR",$J)
 S LN=0,A="" F  S A=$O(^TMP($J,"B",A)) Q:A=""  D
 .K SUM S HDR="",B="" F  S B=$O(^TMP($J,"B",A,B)) Q:B=""  D:GMRCSTAT[$E(B,1,3)
 ..I $D(HDR) D HEADER K HDR
 ..S SUM(B)=^TMP($J,"B",A,B)
 ..S CNSDT=0 F  S CNSDT=$O(^TMP($J,"B",A,B,CNSDT)) Q:'+CNSDT  S CNSLT=0 F  S CNSLT=$O(^TMP($J,"B",A,B,CNSDT,CNSLT)) Q:'+CNSLT  S CNSLTND=^(CNSLT),PTNM=$P(CNSLTND,U),PRTCNDT=$E(CNSDT,4,5)_"-"_$E(CNSDT,6,7)_"-"_$E(CNSDT,2,3) D
 ...F TX=1:1 S TEXT=$T(SUMARY+TX),P3=$P(TEXT,";",3) Q:P3=""  I P3[B S P4=$P(TEXT,";",4),P6=$P(TEXT,";",6) D
 ....I P6=1 I $D(^SC("AWAS1",CNSLT)) D
 .....S CLINIC=$O(^SC("AWAS1",CNSLT,":"),-1),SDAPT=$O(^SC("AWAS1",CNSLT,CLINIC,":"),-1),STCOD=$P(^SC(CLINIC,0),U,7),STCOD=$P(^DIC(40.7,STCOD,0),U,2),CLINIC=$P(^SC(CLINIC,0),U),SDAPT1=$E(SDAPT,4,5)_"-"_$E(SDAPT,6,7)_"-"_$E(SDAPT,2,3)
 .....S Y=SDAPT D DD^%DT S SDAPTIM=$E($P(Y,"@",2),1,5)
 ....S SETNOD=$$SPC(P4,22),SETNOD=SETNOD_PRTCNDT,SETNOD=$$SPC(SETNOD,32),SETNOD=SETNOD_$P(CNSLTND,U,10),SETNOD=$$SPC(SETNOD,37),SETNOD=SETNOD_$P(CNSLTND,U,9),SETNOD=$$SPC(SETNOD,42),SETNOD=SETNOD_$E(PTNM,1,18),SETNOD=$$SPC(SETNOD,63)
 ....D:P6=1  D SETNOD
 .....S SETNOD=SETNOD_$E(CLINIC,1,15),SETNOD=$$SPC(SETNOD,80),SETNOD=SETNOD_SDAPT1_" @ "_SDAPTIM,SETNOD=$$SPC(SETNOD,98),SETNOD=SETNOD_$E(STCOD,1,5)
 .I $D(SUM) S SETNOD=" " D SETNOD D  S SETNOD=" " D SETNOD S SETNOD=" " D SETNOD
 ..S I="" F  S I=$O(SUM(I)) Q:I=""  F II=1:1 S SM=$T(SUMARY+II) S PC3=$P(SM,";",3) Q:PC3=""  I I=PC3 S SETNOD=$$SPC(" ",6),SETNOD=SETNOD_$$SPC(SUM(I),6),SETNOD=SETNOD_$P(SM,";",4) D SETNOD Q
 Q
HEADER ;
 S SETNOD=A_" "_FR_" - "_TO D SETNOD S SETNOD=$$SPC(" ",22),SETNOD=SETNOD_"Consult",SETNOD=$$SPC(SETNOD,63),SETNOD=SETNOD_"Clinic",SETNOD=$$SPC(SETNOD,80),SETNOD=SETNOD_"Appointment",SETNOD=$$SPC(SETNOD,97),SETNOD=SETNOD_"Stop" D SETNOD
 S SETNOD=$$SPC("Status",22),SETNOD=SETNOD_"Date",SETNOD=$$SPC(SETNOD,32),SETNOD=SETNOD_"SC",SETNOD=$$SPC(SETNOD,37),SETNOD=SETNOD_"L4",SETNOD=$$SPC(SETNOD,42),SETNOD=SETNOD_"Patient",SETNOD=$$SPC(SETNOD,63)
 S SETNOD=SETNOD_"Appointment",SETNOD=$$SPC(SETNOD,80),SETNOD=SETNOD_"Date/time",SETNOD=$$SPC(SETNOD,97),SETNOD=SETNOD_"Code" D SETNOD S SETNOD=DSH D SETNOD
 Q
SETNOD ;
 S LN=LN+1,^TMP("GMRCR",$J,"CP",LN,0)=SETNOD,SPC="",VALMCNT=LN
 Q
SPC(DATA,COL) ;
 N SPC S SPC=DATA,L2=COL,L1=$L(DATA) F L3=1:1:(L2-L1) S SPC=SPC_" "
 Q SPC
 Q
