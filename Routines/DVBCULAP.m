DVBCULAP ;ALB/GTS-AMIE UNLINKED APPT REPORT ; 10/19/94  3:30 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
 ;** DVBCULAP run if 2507 Integrity Report Status parameter not OFF,
 ;**   ^TMP("DVBA",$J) global is defined, C&P Report Parameter is ON
 ;
 ;** Variable Descriptions
 ;** ^TMP("DVBA",$J,NAME,DFN) must be defined for vets to be reported
 ;**    prior to executing this routine.  Global KILLed by calling rtn
 ;** ^TMP("DVBC",$J,NAME,DFN) will be equal to:
 ;**    ^ exam date (ext) ^ date appt made ^ clerk ^ Appt Status (ext)
 ;
EN N TMPDA,STRTDT,PARAMDA,BEGDT,TODAYDT,SITE,LPCNT,SSN
 N DVBAPNAM,DVBADFN
 S SITE=$$SITE^DVBCUTL4
 S (DVBAPNAM,DVBADFN)=""
 S PARAMDA=0
 S PARAMDA=$O(^DVB(396.1,PARAMDA))
 D NOW^%DTC
 S Y=X X ^DD("DD") S TODAYDT=Y K Y
 ;
 ;**Only appts for date previous to report date by number of days in
 ;** AMIE Site Parameter File - Days to Keep 2507 History
 S X2=-(+$P(^DVB(396.1,PARAMDA,0),U,11)) S X1=X K X
 D C^%DTC
 S BEGDT=X-.0001,TMPDA=0 K X,X1,X2,STATUS,STATVAR
 ;
 ;**  Create ^TMP("DVBC",$J) global entry for C&P appt in date range
 F  S DVBAPNAM=$O(^TMP("DVBA",$J,DVBAPNAM)) Q:DVBAPNAM=""  DO
 .F  S DVBADFN=$O(^TMP("DVBA",$J,DVBAPNAM,DVBADFN)) Q:DVBADFN=""  DO
 ..S STRTDT=BEGDT
 ..F  S STRTDT=$O(^DPT(DVBADFN,"S",STRTDT)) Q:STRTDT=""  DO
 ...I $P(^DPT(DVBADFN,"S",STRTDT,0),U,16)=1 DO  ;**Appt is type C&P
 ....S TMPDA=TMPDA+1
 ....S DA=DVBADFN,DA(2.98)=STRTDT,DR="1900",DR(2.98)="19;20",DIC=2
 ....S DIQ="DVBAARY"
 ....K ^UTILITY("DIQ1",$J)
 ....D EN^DIQ1
 ....K ^UTILITY("DIQ1",$J)
 ....S Y=STRTDT X ^DD("DD")
 ....S OUTDT=Y
 ....S STATVAR=$$STATUS^SDAM1(DVBADFN,STRTDT,$P(^DPT(DVBADFN,"S",STRTDT,0),U,1),^DPT(DVBADFN,"S",STRTDT,0))
 ....S STATUS=$P(STATVAR,";",3)
 ....I DVBAARY(2.98,STRTDT,20)="" DO  ;**If info in Hosp Loc file (#44)
 .....K DA,DR,DIC,Y
 .....S DIC="^SC("_$P(^DPT(DVBADFN,"S",STRTDT,0),U,1)_",""S"","_STRTDT_",1,"
 .....S DIC(0)="MQ",X=DVBADFN
 .....D ^DIC S SCIEN=+Y
 .....K Y,DA,DR,DIC,DIQ,^UTILITY("DIQ1",$J)
 .....S DA=$P(^DPT(DVBADFN,"S",STRTDT,0),U,1),DIC="^SC("
 .....S DA(44.001)=STRTDT,DA(44.003)=SCIEN
 .....S DR="1900",DR(44.001)="2",DR(44.003)="7;8"
 .....S DIQ="DVBAARY"
 .....D EN^DIQ1
 .....K ^UTILITY("DIQ1",$J)
 .....S ^TMP("DVBC",$J,DVBAPNAM,DVBADFN,TMPDA)=OUTDT_"^"_$S($D(DVBAARY(44.003,SCIEN,7)):DVBAARY(44.003,SCIEN,8)_"^"_DVBAARY(44.003,SCIEN,7)_"^"_STATUS,'$D(DVBAARY(44.003,SCIEN,7)):"BAD Hospital Location record - Contact IRM")
 .....K SCIEN
 ....I DVBAARY(2.98,STRTDT,20)'="" DO  ;**If info in DPT "S" node
 .....S ^TMP("DVBC",$J,DVBAPNAM,DVBADFN,TMPDA)=OUTDT_"^"_DVBAARY(2.98,STRTDT,20)_"^"_DVBAARY(2.98,STRTDT,19)_"^"_STATUS
 ....K DVBAARY(2.98),Y,STATUS,STATVAR
 ..K DVBAARY(44.003)
 I '$D(DVBCQUIT) D:$D(^TMP("DVBC",$J)) RPTHD
 S (DVBADFN,DVBAPNAM,DVBANPGE)=""
 K DVBCOUT
 S:$D(DVBCQUIT) DVBCOUT=""
 F  S DVBAPNAM=$O(^TMP("DVBC",$J,DVBAPNAM)) Q:(DVBAPNAM=""!($D(DVBCOUT)))  DO
 .I $Y>(IOSL-13) DO
 ..I IOST?1"C-".E DO
 ...D PAUSE^DVBCUTL4
 ...S:+Y=0 DVBCOUT=""
 ..D:'$D(DVBCOUT) RPTHD
 ..S DVBANPGE=""
 .I '$D(DVBCOUT) DO
 ..S DVBADFN=""
 ..F  S DVBADFN=$O(^TMP("DVBC",$J,DVBAPNAM,DVBADFN)) Q:DVBADFN=""!($D(DVBCOUT))  DO
 ...I $Y>(IOSL-7) DO
 ....I IOST?1"C-".E DO
 .....D PAUSE^DVBCUTL4
 .....S:+Y=0 DVBCOUT=""
 ....D:'$D(DVBCOUT) RPTHD
 ....S DVBANPGE=""
 ...I '$D(DVBCOUT) DO
 ....S SSN=$P(^DPT(DVBADFN,0),U,9)
 ....K DVBCSSNO
 ....D SSNSHRT^DVBCUTIL
 ....D RPTSUBHD
 ....S TMPDA=""
 ....F  S TMPDA=$O(^TMP("DVBC",$J,DVBAPNAM,DVBADFN,TMPDA)) Q:TMPDA=""!($D(DVBCOUT))  DO
 .....I $Y>(IOSL-4) DO
 ......I IOST?1"C-".E DO
 .......D PAUSE^DVBCUTL4
 .......S:+Y=0 DVBCOUT=""
 ......S DVBANPGE=""
 ......D:'$D(DVBCOUT) RPTHD,RPTSUBHD
 .....I '$D(DVBCOUT) DO
 ......W !,$P(^TMP("DVBC",$J,DVBAPNAM,DVBADFN,TMPDA),U,1)
 ......W ?25,$P(^TMP("DVBC",$J,DVBAPNAM,DVBADFN,TMPDA),U,2)
 ......W ?50,$P(^TMP("DVBC",$J,DVBAPNAM,DVBADFN,TMPDA),U,3)
 I (IOST?1"C-".E),('$D(DVBCOUT)&($D(^TMP("DVBC",$J)))) D PAUSE^DVBCUTL4
 KILL ^TMP("DVBC",$J),DVBCSSNO,DVBCOUT,OUTDT,DVBANPGE,DVBAARY(44.003)
 Q
 ;
RPTHD ;
 W @IOF
 N DVBALN
 W !,?(80-$L(SITE)\2),SITE
 W !!,"AMIE appointment integrity report"
 W !,"Date: ",TODAYDT
 S $P(DVBALN,"-",80)=""
 W !,DVBALN
 Q
 ;
RPTSUBHD ;
 W:'$D(DVBANPGE) !!
 W !,"Veteran: ",DVBAPNAM,?50,"SSN: ",DVBCSSNO
 W !!,"Appt Date",?25,"Date Appt Made",?50,"Clerk"
 W !
 K DVBANPGE
 Q
