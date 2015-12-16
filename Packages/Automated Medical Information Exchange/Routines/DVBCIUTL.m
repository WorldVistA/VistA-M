DVBCIUTL ;ALB/GTS-AMIE INSUFFICIENT RPT UTILITY RTN ; 11/14/94  9:15 AM
 ;;2.7;AMIE;**13,17,19,149,184,185,192**;Apr 10, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 15)
 ;
DETHD ;** AMIE Detailed Report header
 N DVBAI,DVBATXT S DVBAI=2
 ;I DVBADLMTR="," S:DVBAPRTY'["QS" MSGCNT=1 S:$G(DVBAP)="QS" ^TMP("INSUFF",$J,MSGCNT)=$C(13)_$C(13),MSGCNT=MSGCNT+1 D DETHDLIM Q 
 I DVBADLMTR="," D  Q
 . S MSGCNT=MSGCNT+1
 . S:$G(DVBAP)="QS" ^TMP("INSUFF",$J,MSGCNT)=$C(13)_$C(13),MSGCNT=MSGCNT+1 D DETHDLIM Q
 . I MSGCNT=1!(MSGCNT=2) D DETHDLIM Q
 S:'$D(DVBAPG1) TVAR(1,0)="0,15,0,1,0^Detailed Insufficient Exam Report"
 S:$D(DVBAPG1) TVAR(1,0)="0,15,0,1,1^Detailed Insufficient Exam Report"
 S DVBATXT=$$PRHD(DVBAPRTY)
 S TVAR(DVBAI,0)="0,"_((63-$L(DVBATXT))\2)_",0,1,0^"_DVBATXT
 S DVBAI=DVBAI+1
 S TVAR(DVBAI,0)="0,11,0,2,0^For Date Range: "_STRTDT_" to "_LSTDT
 D WR^DVBAUTL4("TVAR")
 K TVAR
 Q
CAPDETHD ;** CAPRI Detailed Report header
 N DVBAI,DVBATXT S DVBAI=2
 I DVBADLMTR="," D  Q
 . S MSGCNT=MSGCNT+1
 . I MSGCNT=1!(MSGCNT=2) D DETHDLIM Q
 S:'$D(DVBAPG1) TVAR(1,0)="0,15,0,1,0^Detailed Insufficient Exam Report"
 S:$D(DVBAPG1) TVAR(1,0)="0,15,0,1,1^Detailed Insufficient Exam Report"
 S DVBATXT=""
 S TVAR(DVBAI,0)="0,"_((63-$L(DVBATXT))\2)_",0,0,0^"_DVBATXT
 S DVBAI=DVBAI+1
 S TVAR(DVBAI,0)="0,11,0,1,0^For Date Range: "_STRTDT_" to "_LSTDT
 D WR^DVBAUTL4("TVAR")
 K TVAR
 Q
 ;
DETHDLIM ;Print Report Header in delimited format
 S ^TMP("INSUFF",$J,MSGCNT)="Detailed Insufficient Exam Report"_$C(13),MSGCNT=MSGCNT+1
 S ^TMP("INSUFF",$J,MSGCNT)="FOR DATE RANGE: "_STRTDT_" TO "_LSTDT_$C(13)_$C(13),MSGCNT=MSGCNT+1
 S ^TMP("INSUFF",$J,MSGCNT)="Reason"_DVBADLMTR_"Exam"_DVBADLMTR_"Provider"_DVBADLMTR_"Exam Date"_DVBADLMTR_"Patient Name"_DVBADLMTR_"SSN"_DVBADLMTR
 S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_"Claim #"_DVBADLMTR_"Claim Type"_DVBADLMTR_"Special Consideration(s)"_DVBADLMTR_"Priority of Exam"_DVBADLMTR
 S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_"Cancellation Information"_DVBADLMTR_"Cancellation Reason"_$C(13),MSGCNT=MSGCNT+1
 Q
 ;
 ;Input : DVBAPRTY - Priority Exam Code (File #396.3 Fld #9)
 ;Output: Description for Priority Exam Code
PRHD(DVBAPRTY) ;priority exam type header info
 N DVBATXT
 S DVBATXT=$S((DVBAPRTY["BDD"):"Benefits Delivery at Discharge",1:"X")
 S:(DVBATXT="X") DVBATXT=$S((DVBAPRTY["QS"):"Quick Start",1:"X")
 S:(DVBATXT="X") DVBATXT=$S((DVBAPRTY["IDES"):"Integrated Disability Evaluation System",1:"X")
 S:(DVBATXT="X") DVBATXT=$S((DVBAPRTY["AO"):"Agent Orange",1:"Excludes Exam Priorities: AO,BDD,IDES,QS")
 S:(DVBATXT'["Excludes") DVBATXT="Priority of Exam: "_DVBATXT
 Q $G(DVBATXT)
 ;
EXMOUT ;** Output exam information for reason/type
 I $Y>(IOSL-9) DO
 .I IOST?1"C-".E D TERM^DVBCUTL3
 D
 .I '$D(GETOUT) DO
 ..;D DETHD
 ..D RESOUT
 ..W !
 ..D TYPEOUT
 ..S (DVBARSPT,DVBAXMPT)=""
 I '$D(GETOUT) DO
 .I '$D(DVBARSPT) DO
 ..D RESOUT
 ..S DVBARSPT=""
 .I '$D(DVBAXMPT) DO
 ..W !
 ..D TYPEOUT
 ..S DVBAXMPT=""
 .S (DVBARQDT,DVBAXDT,DVBAXRS)=""
 .S REQDA=$P(^DVB(396.4,XMDA,0),U,2) ;*REQDA of PRIORITY Insuf 2507
 .I $D(^DVB(396.4,XMDA,"CAN")) D
 ..S DVBAXDT=$P(^DVB(396.4,XMDA,"CAN"),U,1),DVBAXRS=$P(^("CAN"),U,3)
 ..I DVBAXDT S DVBAXDT=$$FMTE^XLFDT(DVBAXDT,"5DZ")
 ..I DVBAXRS S DVBAXRS=$P(^DVB(396.5,DVBAXRS,0),U,1)
 .I +REQDA>0 DO  ;*Get REQDA of Orig 2507
 ..S DFN=$P(^DVB(396.3,REQDA,0),U,1),DVBARQDT=$P(^(0),U,2),DVBARQDT=$$FMTE^XLFDT(DVBARQDT,"5DZ")
 ..I '$D(^DVB(396.3,REQDA,5)) S REQDA=""
 ..I +REQDA>0,($D(^DVB(396.3,REQDA,5))) S REQDA=$P(^DVB(396.3,REQDA,5),U,1)
 .S DVBAORXM=""
 .I +REQDA>0 DO  ;*If link to orig 2507
 ..S DVBAXMTP=$P(^DVB(396.4,XMDA,0),U,3)
 ..S DVBACMND="F  S DVBAORXM=$O(^DVB(396.4,""ARQ"_REQDA_""","_DVBAXMTP_",DVBAORXM)) Q:DVBAORXM=""""  Q:$D(^DVB(396.4,""APS"","_DFN_","_DVBAXMTP_",""C"",DVBAORXM))"
 ..X DVBACMND ;**Return DA of original, insuff exam
 .S DVBANAME=$P(^DPT(DFN,0),U,1)
 .D DEM^VADPT I $G(VADM(1))'="" S DVBASSN=$S(DVBADLMTR=",":$P($G(VADM(2)),U,2),1:$P($G(VADM(2)),U,1))
 .S DVBACNUM="" S:$D(^DPT(DFN,.31)) DVBACNUM=$P(^DPT(DFN,.31),U,3)
 .I DVBAORXM'="",($D(^DVB(396.4,DVBAORXM,0))) S DVBAORDT=$P(^DVB(396.4,DVBAORXM,0),U,6)
 .I DVBAORXM'="",('$D(^DVB(396.4,DVBAORXM,0))) S (DVBAORDT,DVBADTE)=""
 .S:DVBAORXM="" (DVBAORDT,DVBADTE)=""
 .S:DVBAORDT="" DVBADTE=""
 .I DVBAORDT'="" DO
 ..S DVBADTWK=$P(DVBAORDT,".",1)
 ..S DVBADTE=$$FMTE^XLFDT(DVBADTWK,"5DZ")
 .S DVBAORPV=$P(^DVB(396.4,XMDA,0),U,12)
 .S DVBABIEN=$P(^DVB(396.4,XMDA,0),U,2)
 .D CLAIMTYP,SPEC,PRIORITY
 .I DVBADLMTR="," D DETDELIM D:DVBAXDT]"" DETITEMS S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_$C(13),MSGCNT=MSGCNT+1 Q
 .S DVBAORP1=$E(DVBAORPV,1,15)
 .S DVBANAM1=$E(DVBANAME,1,15)
 .W !,DVBAORP1
 .W:$L(DVBAORPV)>$L(DVBAORP1) "**" ;**Indicate that Dr.'s Name truncated
 .W ?20,DVBADTE,?32,DVBANAM1
 .W:$L(DVBANAME)>$L(DVBANAM1) "**" ;**Indicate that Vet's Name truncated
 .W ?52,DVBASSN,?66,DVBACNUM
 .W !,?2,"Claim Type: "_DVBCTW,!,?2,"Special Consideration(s): "_DVBSCWA,!,?2,"Priority Of Exam: "_DVBPOX
 .I DVBAXDT]"" D
 ..W !,"Exam request of "_DVBARQDT_" to correct insufficiency was cancelled on "_DVBAXDT_"."
 ..W !,"Reason: "_DVBAXRS_"."
 K DVBAA,DVBABIEN,DVBSC,DVBSCC,DVBSCN,DVBSCNS,DVBSCW,DVBSCWA,DVBPOX,DVBPOXID
 Q
 ;
DETDELIM ; Print details of Insufficient Exams
 ; Reason,Exam,Provider,Exam Date,Patient Name,SSN,Claim #,Claim Type,Special Consideration(s),Priority of Exam
 I $D(^TMP("INSUFF",$J,MSGCNT)) D
 .S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_""""_DVBAORPV_""""_DVBADLMTR_DVBADTE_DVBADLMTR_""""_DVBANAME_""""_DVBADLMTR_DVBASSN_DVBADLMTR
 .S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_$C(160)_DVBACNUM_DVBADLMTR_DVBCTW_DVBADLMTR_""""_DVBSCWA_""""_DVBADLMTR_DVBPOX_"" Q
 I '$D(^TMP("INSUFF",$J,MSGCNT)) D
 .S ^TMP("INSUFF",$J,MSGCNT)=DVBADLMTR_DVBADLMTR_""""_DVBAORPV_""""_DVBADLMTR_DVBADTE_DVBADLMTR_""""_DVBANAME_""""_DVBADLMTR_DVBASSN_DVBADLMTR_$C(160)_DVBACNUM_DVBADLMTR_DVBCTW_DVBADLMTR_""""_DVBSCWA_""""_DVBADLMTR_DVBPOX_""
 Q
 ;
DETITEMS ; Print final exam details
 S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_DVBADLMTR_"Exam request of "_DVBARQDT_" to correct insufficiency was cancelled on "_DVBAXDT_"."
 S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_DVBADLMTR_DVBAXRS_"."
 Q
 ;
RESOUT ;** Output the Reason
 I DVBADLMTR="," S ^TMP("INSUFF",$J,MSGCNT)=$P(^DVB(396.94,$P(^DVB(396.4,XMDA,0),U,11),0),U,3)_DVBADLMTR Q
 W !!!!!,"Reason: ",$P(^DVB(396.94,$P(^DVB(396.4,XMDA,0),U,11),0),U,3)
 Q
 ;
TYPEOUT ;** Output the Exam
 I DVBADLMTR="," D TYPEDLIM Q 
 W !,"Exam: ",$P(^DVB(396.6,$P(^DVB(396.4,XMDA,0),U,3),0),U,2)
 W !,"Provider",?20,"Exam Dt",?32,"Patient Name",?52,"SSN",?66,"Claim #"
 Q
 ;
TYPEDLIM ; ** Output the delimited Exam 
 I $D(^TMP("INSUFF",$J,MSGCNT)) S ^TMP("INSUFF",$J,MSGCNT)=^TMP("INSUFF",$J,MSGCNT)_""""_$P(^DVB(396.6,$P(^DVB(396.4,XMDA,0),U,3),0),U,2)_""""_DVBADLMTR Q
 I '$D(^TMP("INSUFF",$J,MSGCNT)) S ^TMP("INSUFF",$J,MSGCNT)=$P(^DVB(396.94,$P(^DVB(396.4,XMDA,0),U,11),0),U,3)_DVBADLMTR_""""_$P(^DVB(396.6,$P(^DVB(396.4,XMDA,0),U,3),0),U,2)_""""_DVBADLMTR Q
 ;
RSEL ;** Select Reasons
 ;** The selection prompt is defaulted to ALL.  If the user selects
 ;**  'All', only reasons for exams entered on requests with a
 ;**  priority of 'Insufficient' will be reported.  Not all reasons.
 ;
 W @IOF,!
 W !,"Insufficient Reason Selection"
 S DVBCYQ=""
 N RESANS,DVBAOUT S DVBAOUT="" ;**Pre-read
 K Y,DTOUT,DUOUT,DVBATSAV
 F  Q:(DVBAOUT=1!(DVBCYQ=1))  DO
 .W !!,"  Enter '^' to end Reason Selection"
 .W !,"  'Return' to select all Insufficient Reasons",!
 .K DIC,DTOUT,DUOUT,Y
 .W !,"  Enter Insufficient Reason: ALL//"
 .R RESANS:DTIME
 .S:$T DVBATSAV=""
 .I RESANS=""&($D(DVBATSAV)) S Y=-1 D INREAS^DVBCIUT1
 .S:('$D(DVBATSAV)!(RESANS["^")) DVBAOUT="1"
 .I DVBAOUT'=1,('$D(Y)) DO
 ..I RESANS["?" DO
 ...N LPDA S LPDA=0
 ...W !,"CHOOSE FROM:"
 ...F  S LPDA=$O(^DVB(396.94,LPDA)) Q:+LPDA'>0  DO
 ....W !,?3,$P(^DVB(396.94,LPDA,0),U,1)
 ...W !
 ..I RESANS'["?" DO
 ...S DIC="^DVB(396.94,"
 ...S DIC(0)="EMQ"
 ...S X=RESANS
 ...D ^DIC
 ...D:+Y>0 INREAS^DVBCIUT1
 .I RESANS="",($D(Y)&(+Y=-1)) S DVBCYQ=1
 K DTOUT,DUOUT,Y,DIC,DVBCYQ,DVBATSAV
 Q
 ;
XMSEL ;** Select Exams
 ;** The selection prompt is defaulted to ALL.  If the user selects
 ;**  'All', only exams entered on requests with a priority of 
 ;**  'Insufficient' will be reported.  Not all exams.
 ;
 W @IOF,!
 W !,"AMIE Exam Selection"
 S DVBCYQ=""
 K Y,DTOUT,DUOUT
 F  Q:($D(DTOUT)!($D(DUOUT)!(DVBCYQ=1)))  DO
 .W !!,"  Enter '^' to end Exam Selection"
 .W !,"  'Return' to select all AMIE Exams",!
 .K DIC,DTOUT,DUOUT
 .S DIC="^DVB(396.6,"
 .S DIC(0)="AEMQ"
 .S DIC("A")="  Enter Exam: ALL//"
 .;removed screen for inactive exams
 .D ^DIC
 .I '$D(DTOUT),('$D(DUOUT)) D EXMTPE^DVBCIUT1
 .I $D(Y),(+Y=-1) S DVBCYQ=1
 K DTOUT,DUOUT,Y,DIC,DVBCYQ
 Q
 ;
 ;Input: DVBADIRA - Prompt to display for DIR call
 ;Ouput: Code selected from set or ^ if user exited selection
EXMPRTY(DVBADIRA) ;** Select Priority of Exam
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="S^AO:Agent Orange;BDD:Benefits Delivery at Discharge / Quick Start;"
 S DIR(0)=DIR(0)_"IDES:Integrated Disability Evaluation System;"
 S DIR(0)=DIR(0)_"ALL:All Others"
 S DIR("A")=$S($G(DVBADIRA)]"":DVBADIRA,1:"Select Priority of Exam for the Report")
 S DIR("B")="All Others"
 S DIR("T")=DTIME  ;time-out value specified by system
 S DIR("?",1)="Select the priority of exam(s) to report on or ALL for the original report,"
 S DIR("?")="which excludes the AO, BDD and IDES exam priorities."
 D ^DIR
 Q Y
CLAIMTYP ;THE CLAIM TYPE OF A 2507 REQUEST
 S DVBCTW=""
 Q:'$D(^DVB(396.3,DVBABIEN,9,0))
 ;DVBIEN is the 2507 REQUEST FILE IEN
 ;DVBCTW is the string /name of the CLAIM TYPE
 D GETS^DIQ(396.3,DVBABIEN_",","9.1*","E","MSG","ERR")
 S DVBCTW=MSG("396.32","1,"_DVBABIEN_",",".01","E")
 Q
SPEC ;SPECIAL CONSIDERATION(S) FOR A 2507 REQUEST
 K DVBSCW
 S DVBSCWA=""
 Q:'$D(^DVB(396.3,DVBABIEN,8))
 ;DVBABIEN is the 2507 REQUEST FILE IEN
 ;DVBSC is a the SPECIAL CONSIDERATION entry for the 2507 REQUEST
 ;DVBSCN is the pointer number to the SPECIAL CONSIDERATION file 396.25
 ;DVBSCW is the string /name of the SPECIAL CONSIDERATION
 S DVBAA=$P(^DVB(396.3,DVBABIEN,8,0),U,4)
 S (DVBSC,DVBCNT)=0 F  S DVBSC=$O(^DVB(396.3,DVBABIEN,8,DVBSC)) Q:'DVBSC  D
 .S DVBSCN=$P(^DVB(396.3,DVBABIEN,8,DVBSC,0),U,1)
 .S DVBSCW(DVBSC)=$G(^DVB(396.25,DVBSCN,0))
 .S DVBCNT=DVBCNT+1
 .I (DVBCNT'=DVBAA) S:$D(DVBSCW(DVBSC)) DVBSCW(DVBSC)=DVBSCW(DVBSC)_","
 S DVBX="" F  S DVBX=$O(DVBSCW(DVBX)) Q:'DVBX  S DVBSCWA=DVBSCWA_DVBSCW(DVBX)
 Q
PRIORITY ;
 S DVBPOX=""
 Q:($P(^DVB(396.3,DVBABIEN,0),U,10))=""
 S DVBPOXID=$P(^DVB(396.3,DVBABIEN,0),U,10)
 S DVBPOX=$$GET1^DIQ(396.3,DVBABIEN,"PRIORITY OF EXAM")
 Q
