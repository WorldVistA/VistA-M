DVBCUTL6 ;ALB/GTS-AMIE C&P APPT LINK DISPLAY SUBRTNS ; 10/20/94  1:45 PM
 ;;2.7;AMIE;**1**;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
LKHDOUT ;** Link MGNT screen hdr
 W @IOF
 W "AMIE/C&P Appointment Link Management",!!,"Current appointment links"
 W !,"Clinic",?32,"Date/Time",?51,"Status",!
 Q
 ;
EXMOUT(LPDA) ;** Output exam
 W !!,"Exam: ",$P(^DVB(396.6,$P(^DVB(396.4,LPDA,0),U,3),0),U,2)
 W !,"Clinic",?32,"Date/Time",?49,"Status"
 Q
 ;
EXMDISP(REQDA) ;** Output Open/Completed exams
 D EXMHD
 N DVBADA,DVBASTAT
 S DVBADA=""
 F  S DVBADA=$O(^DVB(396.4,"C",REQDA,DVBADA)) Q:(DVBADA=""!($D(DTOUT)!$D(DUOUT)))  DO
 .I $D(^DVB(396.4,DVBADA,0)) DO
 ..S DVBASTAT=$P(^DVB(396.4,DVBADA,0),U,4)
 ..D EXAMLST^DVBCUTA4(DVBADA,DVBASTAT)
 Q
 ;
EXMHD ;** Exam header
 W @IOF
 N DVBALN
 S Y=$P(^DVB(396.3,REQDA,0),U,5)
 X ^DD("DD")
 W !!,"AMIE exams on 2507 request for: ",$P(^DPT($P(^DVB(396.3,REQDA,0),U,1),0),U,1)
 W !,"2507 Request Date Reported to MAS: ",Y
 S $P(DVBALN,"-",80)=""
 W !,DVBALN
 W !!,"Exam:",?40,"Status:"
 K Y
 Q
 ;
APPTSEL(DVBADFN,APPTTYPE,REQDA,STRTDT,ENDDT) ;Select appt
 ;** APPTTYPE = appt type to select
 ;** STRTDT,ENDDT = selected date range
 ;
 ;** APPTSEL creates ^TMP = appt's of APPTTYPE in date range
 ;** ^TMP=appt dte-ext ^ Clinic-ext ^ Status-ext ^ appt dte-int
 W @IOF
 N TMPDA
 S STRTDT=STRTDT-.1,TMPDA=1
 S:+STRTDT<0 STRTDT=0
 S:'$D(ENDDT) ENDDT=""
 S:ENDDT="" ENDDT=9999999
 K STATUS,STATVAR
 I $D(^DPT(DVBADFN,"S")) DO
 .F  S STRTDT=$O(^DPT(DVBADFN,"S",STRTDT)) Q:(STRTDT=""!(STRTDT>ENDDT))  DO
 ..I $P(^DPT(DVBADFN,"S",STRTDT,0),U,16)=APPTTYPE DO
 ...S TMPDA=TMPDA+1
 ...S DA=DVBADFN,DA(2.98)=STRTDT,DR="1900",DR(2.98)=".01",DIC=2
 ...S DIQ="DVBAARY" K ^UTILITY("DIQ",$J)
 ...D EN^DIQ1 K ^UTILITY("DIQ",$J)
 ...S Y=STRTDT X ^DD("DD")
 ...S STATVAR=$$STATUS^SDAM1(DVBADFN,STRTDT,$P(^DPT(DVBADFN,"S",STRTDT,0),U,1),^DPT(DVBADFN,"S",STRTDT,0))
 ...S STATUS=$P(STATVAR,";",3)
 ...S ^TMP("DVBC",$J,TMPDA)=Y_"^"_DVBAARY(2.98,STRTDT,.01)_"^"_STATUS_"^"_STRTDT
 ...K DVBAARY(2.98),Y,STATUS,STATVAR
 D ARYDISP
 Q
 ;
ARYDISP ;** Display appts for selection
 ;** run APPTSEL before ARYDISP
 ;
 ;** DVBAAPT returned (= selected ^TMP node)
 ;
 K DA,DR,DIC,DIQ
 I '$D(DVBAMORE) N DVBAMORE
 I '$D(TMPDA) N TMPDA
 W !!!,"Select an appointment to link to the 2507 request",!
 W !,?1,"1",?4,"Display Current C&P Appointment Links"
 S ^TMP("DVBC",$J,1)=""
 F TMPDA=2:1 Q:'$D(^TMP("DVBC",$J,TMPDA))  DO
 .W !,?1,TMPDA,?4,$P(^TMP("DVBC",$J,TMPDA),U,1)
 .W ?23,$E($P(^TMP("DVBC",$J,TMPDA),U,2),1,22)
 .W:$D(^DVB(396.95,"AB",REQDA,$P(^TMP("DVBC",$J,TMPDA),U,4))) ?47,"*CL"
 .W ?51,$E($P(^TMP("DVBC",$J,TMPDA),U,3),1,27)
 .S DVBAMORE=$O(^TMP("DVBC",$J,TMPDA))
 .I +DVBAMORE'>0 D SELAPT
 .I (+DVBAMORE>0)&(TMPDA#5=0) D SELAPT
 S DVBAAPT=""
 I $D(Y) DO
 .S DVBAAPT=^TMP("DVBC",$J,+Y)
 .K ^TMP("DVBC",$J,+Y)
 Q
 ;
SELAPT ;** Select Appt
 W !
 S DIR("A",1)="ENTER '^' TO STOP, OR"
 S DIR("A")="CHOOSE 1-"_TMPDA_": "
 S DIR(0)="NOA^1:"_TMPDA_"^I X["".""!('$D(^TMP(""DVBC"",$J,+Y))) K X"
 S DIR("?",1)="Select an appointment by entering its associated number."
 S DIR("?",2)=" *CL following Clinic means the appointment date is the"
 S DIR("?",2)=DIR("?",2)_" Current Date for"
 S DIR("?",3)=" an existing link."
 S DIR("?",4)="Enter '1' to see the current links to this 2507."
 S DIR("?")="Select from the numbers listed."
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S TMPDA=9999,DVBAOUT=""
 S:+Y>1 TMPDA=9999
 W:+Y'>0 !
 I +Y=1 DO
 .W @IOF
 .D LNKARY^DVBCUTA3(REQDA,DVBADFN)
 .D LNKLIST^DVBCUTA3
 .S:TMPDA'>5 TMPDA=TMPDA-1
 .S:(TMPDA>5&(TMPDA#5=0)) TMPDA=TMPDA-5
 .S:(TMPDA>5&(TMPDA#5'=0)) TMPDA=TMPDA-1
 .D REFRSH^DVBCUTA4(TMPDA)
 .K Y
 I $D(Y),(+Y'>0) K Y
 K DIR,DTOUT,DUOUT
 Q
 ;
LINKINF(REQDA,CURRAPT) ;** Display Link info
 N LINKNODE,LINKDA,INITDTE,ORIGDTE,VETDTE
 S LINKDA=""
 S LINKDA=$O(^DVB(396.95,"AB",REQDA,CURRAPT,LINKDA))
 S LINKNODE=^DVB(396.95,LINKDA,0)
 S INITDTE=$P(LINKNODE,U,1)
 S ORIGDTE=$P(LINKNODE,U,2)
 S VETDTE=$P(LINKNODE,U,5)
 I INITDTE'=CURRAPT DO
 .K Y
 .S Y=INITDTE
 .X ^DD("DD")
 .W !,"Initial Appt: ",?36,Y
 I ORIGDTE'=CURRAPT DO
 .K Y
 .S Y=ORIGDTE
 .X ^DD("DD")
 .W !,"Clock Stop Appt: ",?36,Y
 I VETDTE'=""&(VETDTE'=CURRAPT) DO
 .K Y
 .S Y=VETDTE
 .X ^DD("DD")
 .W !,"Last Veteran requested Appointment: ",?36,Y
 K Y
 S Y=CURRAPT
 X ^DD("DD")
 W !,"Current Appt: ",?36,Y
 K Y
 Q
