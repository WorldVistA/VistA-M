DVBCIUTL ;ALB/GTS-AMIE INSUFFICIENT RPT UTILITY RTN ; 11/14/94  9:15 AM
 ;;2.7;AMIE;**13,17,19,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 15)
 ;
DETHD ;** Detailed Report header
 N DVBAI,DVBATXT S DVBAI=2
 S:'$D(DVBAPG1) TVAR(1,0)="0,15,0,1,0^Detailed Insufficient Exam Report"
 S:$D(DVBAPG1) TVAR(1,0)="0,15,0,1,1^Detailed Insufficient Exam Report"
 S DVBATXT=$$PRHD(DVBAPRTY)
 S TVAR(DVBAI,0)="0,"_((63-$L(DVBATXT))\2)_",0,1,0^"_DVBATXT
 S DVBAI=DVBAI+1
 S TVAR(DVBAI,0)="0,11,0,2,0^For Date Range: "_STRTDT_" to "_LSTDT
 D WR^DVBAUTL4("TVAR")
 K TVAR
 Q
 ;
 ;Input : DVBAPRTY - Priority Exam Code (File #396.3 Fld #9)
 ;Output: Description for Priority Exam Code
PRHD(DVBAPRTY) ;priority exam type header info
 N DVBATXT
 S DVBATXT=$S((DVBAPRTY["BDD"):"Benefits Delivery at Discharge",1:"X")
 S:(DVBATXT="X") DVBATXT=$S((DVBAPRTY["QS"):"Quick Start",1:"X")
 S:(DVBATXT="X") DVBATXT=$S((DVBAPRTY["DCS"):"DES Claimed Condition by Service Member",1:"X")
 S:(DVBATXT="X") DVBATXT=$S((DVBAPRTY["DFD"):"DES Fit for Duty",1:"X")
 S:(DVBATXT="X") DVBATXT=$S((DVBAPRTY["AO"):"Agent Orange",1:"Excludes Exam Priorities: AO,BDD,DCS,DFD,QS")
 S:(DVBATXT'["Excludes") DVBATXT="Priority of Exam: "_DVBATXT
 Q $G(DVBATXT)
 ;
EXMOUT ;** Output exam information for reason/type
 I $Y>(IOSL-9) DO
 .I IOST?1"C-".E D TERM^DVBCUTL3
 .I '$D(GETOUT) DO
 ..D DETHD
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
 .S DVBASSN=$P(^DPT(DFN,0),U,9)
 .S DVBACNUM="" S:$D(^DPT(DFN,.31)) DVBACNUM=$P(^DPT(DFN,.31),U,3)
 .I DVBAORXM'="",($D(^DVB(396.4,DVBAORXM,0))) S DVBAORDT=$P(^DVB(396.4,DVBAORXM,0),U,6)
 .I DVBAORXM'="",('$D(^DVB(396.4,DVBAORXM,0))) S (DVBAORDT,DVBADTE)=""
 .S:DVBAORXM="" (DVBAORDT,DVBADTE)=""
 .I DVBAORDT'="" DO
 ..S DVBADTWK=$P(DVBAORDT,".",1)
 ..S DVBADTE=$$FMTE^XLFDT(DVBADTWK,"5DZ")
 .S DVBAORPV=$P(^DVB(396.4,XMDA,0),U,12)
 .S DVBAORP1=$E(DVBAORPV,1,15)
 .S DVBANAM1=$E(DVBANAME,1,15)
 .W !,DVBAORP1
 .W:$L(DVBAORPV)>$L(DVBAORP1) "**" ;**Indicate that Dr.'s Name truncated
 .W ?20,DVBADTE,?32,DVBANAM1
 .W:$L(DVBANAME)>$L(DVBANAM1) "**" ;**Indicate that Vet's Name truncated
 .W ?52,DVBASSN,?66,DVBACNUM
 .I DVBAXDT]"" D
 ..W !,"Exam request of "_DVBARQDT_" to correct insufficiency was cancelled on "_DVBAXDT_"."
 ..W !,"Reason: "_DVBAXRS_"."
 Q
 ;
RESOUT ;** Output the Reason
 W !!!!!,"Reason: ",$P(^DVB(396.94,$P(^DVB(396.4,XMDA,0),U,11),0),U,3)
 Q
 ;
TYPEOUT ;** Output the Exam
 W !,"Exam: ",$P(^DVB(396.6,$P(^DVB(396.4,XMDA,0),U,3),0),U,2)
 W !,"Provider",?20,"Exam Dt",?32,"Patient Name",?52,"SSN",?66,"Claim #"
 Q
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
 S DIR(0)=DIR(0)_"DES:DES Claimed Condition by Service Member / Fit for Duty;"
 S DIR(0)=DIR(0)_"ALL:All Others"
 S DIR("A")=$S($G(DVBADIRA)]"":DVBADIRA,1:"Select Priority of Exam for the Report")
 S DIR("B")="All Others"
 S DIR("T")=DTIME  ;time-out value specified by system
 S DIR("?",1)="Select the priority of exam(s) to report on or ALL for the original report,"
 S DIR("?")="which excludes the AO, BDD and DES exam priorities."
 D ^DIR
 Q Y
