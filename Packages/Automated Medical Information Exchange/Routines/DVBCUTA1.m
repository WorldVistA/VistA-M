DVBCUTA1 ;ALB/GTS-AMIE C&P UTILITY ROUTINE A-1 ; 11/9/94  11:15 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 15)
 ;
INSXM ;**Update Insuf exam info
 ;
 ;** Variable Descriptions
 ;    DVBAXMDA - 396.4 IEN - new Exam Rec
 ;    DVBAXMTP - 396.6 IEN - new exam
 ;    DVBAPROV - Provider on insufficiently completed exam
 ;    DVBAORXM - 396.4 IEN - insufficiently completed exam
 ;    DVBACMND - Local var containing Mumps code
 ;                X DVBACMND returns DVBAORXM
 ;    DVBCADEX - Indicates exam being added to 2507
 ;
 I '$D(OUT)&($P(^DVB(396.3,REQDA,0),"^",10)="E") DO
 .S TVAR(1,0)="0,0,0,2,0^Enter the following information for the "_EXMNM
 .S TVAR(2,0)="0,0,0,1:1,0^ exam being returned as insufficient."
 .D WR^DVBAUTL4("TVAR")
 .K TVAR
 .N DVBAXMDA,REASON
 .S DVBAXMDA=+Y
 .K DIC,Y,DA
 .S REASON=+$$INRSLK^DVBCUTA3
 .S:+REASON'>0 DTOUT=""
 .I +REASON>0 DO
 ..K DIE,Y,DA,DR
 ..S DIE="^DVB(396.4,",DR=".11////^S X=REASON;80;S:+$P(^DVB(396.3,REQDA,5),""^"",1)>0 Y="""";.12"
 ..S DA=DVBAXMDA S DIE("NO^")="" D ^DIE K DIE,DA,DR W !!
 .I '$D(DTOUT),(+$P(^DVB(396.3,REQDA,5),"^",1)>0) DO
 ..K DIE,Y,DR,DA ;**2507 Linked
 ..N DVBAXMTP,DVBAPROV,DVBAORXM,DVBACMND ;**S/W update Original Provider
 ..S DVBAXMTP=$P(^TMP($J,"NEW",EXMNM),U,1),DVBAORXM="",DVBAPROV=""
 ..S DVBACMND="S DVBAORXM=$O(^DVB(396.4,""ARQ"_DVBAINDA_""","_DVBAXMTP_",DVBAORXM))"
 ..N XREF S XREF="ARQ"_DVBAINDA
 ..I $D(^DVB(396.4,XREF,DVBAXMTP)) X DVBACMND ;**Return insuff exam IEN
 ..S:+DVBAORXM>0 DVBAPROV=$P(^DVB(396.4,DVBAORXM,0),U,7)
 ..I '$D(DVBCADEX)&(DVBAPROV="") DO
 ...S DVBAPROV="Unknown" ;**Bad 'ARQ' X-Ref
 ..K DVBADMNM
 ..I +DVBAORXM>0 DO
 ...I $D(^DVB(396.4,DVBAORXM,"TRAN")),(+$P(^DVB(396.4,DVBAORXM,"TRAN"),U,3)>0) DO
 ....S DVBADMNM=$P(^DIC(4.2,+$P(^DVB(396.4,DVBAORXM,"TRAN"),U,3),0),U,1)
 ....S DVBADMNM=$P(DVBADMNM,".",1)
 ..S:$D(DVBADMNM) DVBAPROV=DVBAPROV_" at "_DVBADMNM
 ..I $D(DVBCADEX)&(+DVBAORXM'>0) DO
 ...S DIR(0)="FAO^1:30"
 ...S DIR("A")="ORIGINAL PROVIDER: "
 ...S DIR("?",1)="Enter the Original Provider who performed the examination,"
 ...S DIR("?",2)="if the exam was performed on the original 2507 request."
 ...S DIR("?")="Include the facility name if the exam was performed at another site." D ^DIR S DVBAPROV=X K DIR,X,Y
 ..S DIE="^DVB(396.4,",DR=".12////^S X=DVBAPROV",DA=DVBAXMDA
 ..D ^DIE K DVBADMNM
 Q
 ;
RPTTYPE() ;** Report type - Detailed/Summary
 ;**RPTTYPE requires an entry.  Up-arrow exit allowed.
 ;**  All variables KILLed, EXCEPT DTOUT,DUOUT when user times
 ;**    or Up-Arrows out.  DTOUT,DUOUT KILLed by calling rtn.
 N TYPE
 S DIR(0)="SO^D:Detailed;S:Summary"
 S DIR("A",1)=" "
 S DIR("A")="Report Type"
 D ^DIR
 S TYPE=Y
 K X,Y,DIR
 Q TYPE
 ;
INSFTME(CURIEN) ;** Calc Insuff 2507 total process time
 ;** Variables
 ;**   CURIEN - 396.3 IEN for 2507 in process
 ;**   PROCTM - Processing time running total
 ;**   LPQUIT - Exit loop indicator
 ;
 N PROCTM,LPQUIT
 S PROCTM=+$$PROCDAY^DVBCUTL2(CURIEN)
 F  Q:$D(LPQUIT)  DO
 .S:'$D(^DVB(396.3,CURIEN,5)) LPQUIT=""
 .I $D(^DVB(396.3,CURIEN,5)) DO
 ..I +$P(^DVB(396.3,CURIEN,5),U,1)'>0 DO
 ...S PROCTM=PROCTM+$P(^DVB(396.3,CURIEN,5),U,2)
 ...S LPQUIT=""
 ..I +$P(^DVB(396.3,CURIEN,5),U,1)>0 DO
 ...S CURIEN=+$P(^DVB(396.3,CURIEN,5),U,1)
 ...S PROCTM=PROCTM+$$PROCDAY^DVBCUTL2(CURIEN)
 Q PROCTM
 ;
LINKDISP ;** Display Appt Links
 W @IOF
 N DVBAMORE
 W !,"Examination Appointment Links"
 W !!,"   Which Current Appt is "_$P(DVBAAPT,U,1)_" a reschedule of?",!
 W !,?4,"Initial Appt",?23,"Clock Stop Appt",?42,"Current Appt",?61,"Clinic"
 S ARYDA=""
 F ARYDA=1:1 Q:'$D(TMP("DVBC LINK",ARYDA))  DO
 .S SELDA=""
 .S SELDA=$O(TMP("DVBC LINK",ARYDA,SELDA))
 .W !,?1,ARYDA,?4,$P(TMP("DVBC LINK",ARYDA,SELDA),U,1)
 .W ?23,$P(TMP("DVBC LINK",ARYDA,SELDA),U,2),?42,$P(TMP("DVBC LINK",ARYDA,SELDA),U,3)
 .W ?61,$E($P(TMP("DVBC LINK",ARYDA,SELDA),U,4),1,18)
 .S DVBAMORE=$O(TMP("DVBC LINK",ARYDA))
 .I +DVBAMORE'>0 D SELLNK W !
 .I +DVBAMORE>0,(ARYDA#5=0) D SELLNK W !
 S SELDA=""
 I $D(Y) S SELDA=$O(TMP("DVBC LINK",Y,SELDA))
 K TMP("DVBC LINK")
 Q
 ;
SELLNK ;** Select link to modify
 W !
 S DIR("A",1)="ENTER '^' TO STOP OR"
 S DIR("A")="CHOOSE 1-"_ARYDA_": "
 S DIR(0)="NOA^1:"_ARYDA_"^I X["".""!('$D(TMP(""DVBC LINK"",+Y))) K X"
 S DIR("?",1)="Select a link by entering its associated number."
 S DIR("?",2)="  'Initial Appt' is the first appointment made to complete the exam."
 S DIR("?",3)="  'Clock Stop Appt' is the date the processing clock will be stopped for the"
 S DIR("?",4)="    series of linked appointments, if the veteran reschedules or no shows."
 S DIR("?",5)="  'Current Appt' is the appointment the link shows as currently scheduled"
 S DIR("?",6)="    to complete the examination."
 S DIR("?")="Select from the numbers listed."
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S ARYDA=9999
 S:+Y>0 ARYDA=9999
 I +Y'>0 K Y
 K DIR,DTOUT,DUOUT
 Q
