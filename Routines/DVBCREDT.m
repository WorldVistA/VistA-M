DVBCREDT ;ALB/GTS-557/THM-EDIT STATIC C&P INFO ; 11/20/90  6:29 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;**Note:  Priority E is Insufficient
 ;         Priority 'E is not insufficient
 ;
 K ^TMP("DVBCEDIT",$J) I $D(DUZ)#2=0 W !!,*7,"Your user number is invalid.",!! H 3 G EXIT
 S LN="EDIT C&P STATIC INFORMATION" D HOME^%ZIS S FF=IOF
 G EN1
 ;
COMPARE I '$D(^TMP("DVBCEDIT",$J,DA,2,I,0)) S DVBCMOD=1 Q
 I ^DVB(396.3,DA,2,I,0)'=^TMP("DVBCEDIT",$J,DA,2,I,0) S DVBCMOD=1 Q
 Q
 ;
EN1 W @IOF,!?(IOM-$L(LN)\2),LN,!!! S DIC="AE",DIC("A")="Enter VETERAN NAME: ",DIC="^DVB(396.3,",DIE=DIC,DIC(0)="AEQM" D ^DIC G:X=""!(X=U) EXIT S DA=+Y I DA<0 G EN1
 S STAT=$P(^DVB(396.3,DA,0),U,18) I STAT'="N"&(STAT'="P") W !!,"The status of this request is not NEW or PENDING, REPORTED.",!,"It cannot, therefore, be modified.",*7,!! S DVBCMOD=1 G CON
 F I=0:0 S I=$O(^DVB(396.3,DA,2,I)) Q:I=""  S ^TMP("DVBCEDIT",$J,DA,2,I,0)=^DVB(396.3,DA,2,I,0) ;save lines for compare
 ;
EDIT ;
 N DVBARQST,SAVEDA,ENTTOUT
 S DVBARQST=$P(^DVB(396.3,DA,0),U,10)
 S SAVEDA=DA
 W !! S DR="W @IOF,!!;9;10:10.2;24;29;21;W !!;23" D ^DIE
 S:$D(DTOUT) ENTTOUT=""
 ;
 ;**Priority E -> E
 I DVBARQST="E",($P(^DVB(396.3,DA,0),U,10)="E"&('$D(ENTTOUT))) DO
 .W !
 .N UPDT2507
 .K DTOUT,DUOUT
 .S DIR(0)="Y^AO",DIR("A")="Do you want to change the request this insufficient is linked to"
 .S DIR("?")="Enter Yes to change the link and No to keep the current link.",DIR("B")="NO" D ^DIR
 .S:+Y=1 UPDT2507=""
 .I $D(UPDT2507) DO
 ..K DIR,Y
 ..N REQDA S REQDA=SAVEDA
 ..S NODE5=""
 ..S:$D(^DVB(396.3,REQDA,5)) NODE5=^DVB(396.3,REQDA,5) ;**Save link node
 ..D CLINSF^DVBCLOG2 S DA=SAVEDA D INSUF^DVBCLOG2 ;*Update 2507 Link info
 ..I '$D(DVBAOUT),('$D(DUOUT)) D INSUFXM^DVBCUTA2 ;*Update exam info
 ..I $D(DVBAOUT)!($D(DUOUT)) D RESTLINK^DVBCUTA2 ;*Restore 2507 link
 ..K NODE5
 .I '$D(UPDT2507) DO  ;**Exam info update check
 ..W !
 ..N REQDA S REQDA=SAVEDA
 ..S NODE5=^DVB(396.3,REQDA,5) ;**Save the link info node
 ..D INSUFXM^DVBCUTA2 ;**Update exam info
 ..K XMEDT,NODE5
 .S DA=SAVEDA
 ;
 ;**Priority 'E -> E
 I DVBARQST'="E",($P(^DVB(396.3,DA,0),U,10)="E"&('$D(ENTTOUT))) DO
 .K DIR,Y
 .N REQDA,XMDA S REQDA=SAVEDA
 .D INSUF^DVBCLOG2 ;**Enter 2507 insuf link info
 .I '$D(DVBAOUT) DO  ;**Enter insuf info on exams
 ..N EXMNM,XMSTAT
 ..K DTOUT
 ..F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:(XMDA=""!($D(DTOUT)))  DO
 ...W @IOF
 ...D XMUPDT^DVBCUTA2 ;**Exam info
 ..S:$D(DTOUT) DVBAOUT="" K Y,^TMP($J,"NEW")
 .I $D(DVBAOUT) DO  ;**Restore priority info when time out
 ..N MSG,RESET,EXMCLR
 ..S (RESET,MSG,EXMCLR)=""
 ..D RESTORE
 .S DA=SAVEDA
 ;
 ;**Priority E -> 'E
 I DVBARQST="E",($P(^DVB(396.3,DA,0),U,10)'="E") DO
 .N REQDA,EXMCLR S REQDA=SAVEDA S EXMCLR=""
 .D RESTORE ;**Clear link and insuf info on exams
 .S DA=SAVEDA
 ;
 ;**If Timed out of information edit in DR string
 I $D(ENTTOUT) DO
 .I DVBARQST'="E",($P(^DVB(396.3,DA,0),U,10)="E") DO  ;**clear insf info
 ..N REQDA,MSG,RESET
 ..S REQDA=SAVEDA S (MSG,RESET)=""
 ..D RESTORE
 S DA=SAVEDA
 S DIE="^DVB(396.3,"
 I $P(^DVB(396.3,DA,0),U,2)[DT G CONK ;no check if entered today
 K DVBCMOD F I=0:0 S I=$O(^DVB(396.3,DA,2,I)) Q:I=""  D COMPARE Q:$D(DVBCMOD)
 I $D(DVBCMOD) S DR="23.5///NOW;23.6////^S X=DUZ" D ^DIE W @IOF,!!,*7,"Since you have modified the REMARKS section,",!,"a new copy of the request will be issued to the",!,"medical center tomorrow morning."
 ;
CON I $D(DVBCMOD) W !!,"Press RETURN to continue  " R ANS:DTIME G:'$T!(ANS=U) EXIT
CONK K I,DVBCMOD,DIC,DA,DIE,X,Y G EN1
 ;
EXIT K ^TMP("DVBCEDIT",$J) G KILL^DVBCUTIL
 ;
RESTORE ;** Remove insufficient info from 2507
 K DIE,DA,DR
 D CLINSF^DVBCLOG2 ;**Clear 2507 info
 I $D(RESET) DO  ;**Reset Priority
 .S DA=REQDA,DR="9////^S X=DVBARQST",DIE="^DVB(396.3,"
 .D ^DIE K DA,DR,DIE
 I $D(EXMCLR) DO  ;**Clear exam info
 .F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:(XMDA="")  DO
 ..K DA,DR,DIE
 ..S DA=XMDA,DR=".11////@;.12///@;80///@",DIE="^DVB(396.4,"
 ..D ^DIE
 .K DA,DR,DIE
 I $D(MSG) DO  ;**Output message
 .S TVAR(1,0)="1,3,0,2:1,0^Insufficient link info not updated!...Priority restored"
 .D WR^DVBAUTL4("TVAR")
 .K TVAR
 .D CONTMES^DVBCUTL4
 Q
