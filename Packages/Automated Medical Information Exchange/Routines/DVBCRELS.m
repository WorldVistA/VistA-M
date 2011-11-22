DVBCRELS ;ALB/GTS-557/THM-RELEASE 2507 REQUEST TO RO ; 5/27/91  4:54 PM
 ;;2.7;AMIE;**83**;Apr 10, 1995
 ;
 I $D(DUZ)#2=0 W *7,!!,"Invalid user number (DUZ)",!! H 3 Q
 I '$D(^XUSEC("DVBA C RELEASE 2507",DUZ)) W *7,!!,"You are not authorized to release 2507 requests!!",!! H 3 Q
 G EN
 ;
EXAM S EXAM=$P(^DVB(396.4,DA,0),U,3),EXAM=$P(^DVB(396.6,+EXAM,0),U,1)
 S STAT=$P(^DVB(396.4,DA,0),U,4)
 I STAT'="C"&(STAT'["X") S NFINAL=1 W !,EXAM," is not complete " W:STAT="T" " (transferred)"
 Q
 ;
EN D HOME^%ZIS S FF=IOF,HD="Veteran Selection",HD2="2507 Exam Release"
 ;
LOOK D KILL W @FF,!?(IOM-$L(HD)\2),HD,!?(IOM-$L(HD2)\2),HD2,!!! S DIC("W")="D DICW^DVBCUTIL" S DIC="^DVB(396.3,",DIC(0)="AEQM",DIC("A")="Select VETERAN: " D ^DIC G:X=""!(X=U) EXIT I +Y<0 W *7,"  ???" G LOOK
 S STAT=$P(^DVB(396.3,+Y,0),U,18) D STATCHK G:$D(NCN) LOOK
 S REQDA=+Y,DFN=+$P(Y,U,2),REQDT=$P(^DVB(396.3,REQDA,0),U,2)
 S (PNAM,SSN)="Unknown" I $D(^DPT(DFN,0)) S PNAM=$P(^(0),U,1),SSN=$P(^(0),U,9)
 S CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown") K DICW
 S STAT=$P(^DVB(396.3,REQDA,0),U,18) D STATCHK I $D(NCN) K NCN G LOOK
 W !!,"Please wait while the individual exam statuses are checked.  " H 1 W !
 ;
DATA S NFINAL=0 F DA=0:0 S DA=$O(^DVB(396.4,"C",REQDA,DA)) Q:DA=""  D EXAM
 I NFINAL=0 W !!,"All exams have been completed, please enter the following:",!!
 I NFINAL=1 W *7,!!,"Since there are still incomplete exams,",!,"  this request cannot be released to the RO.  " W !!,"Press RETURN or ""^"" to exit  " R ANS:DTIME G:'$T!(ANS=U) EXIT G LOOK
 S DVBOTH=$P(^DVB(396.3,REQDA,1),U,3),DVBABY=$P(^(1),U,5),DVBDTA=$P(^(1),U,6)
 S:DVBABY="" DVBABY="@" S:DVBDTA="" DVBDTA="@"
 I NFINAL=0 K DR S CTIM=$$NOW^XLFDT,DA=REQDA,DIE="^DVB(396.3,",DR="12////"_CTIM_";13////"_CTIM_";14////^S X=DUZ;17///R;W *7;22;25R;26R" D ^DIE K CTIM
 I '$D(Y),NFINAL=0 W !!,"This request is now released.",!! H 2
 I '$D(Y),$P(^DVB(396.3,REQDA,0),U,22)]"",$P(^(0),U,22)'=$P(^XMB(1,1,0),U,1) D ^DVBCXFRE K DIC,DIE,DR,DA S FAX="Y",RSTAT="CT" G FX ;transfers
 ;set back to transcribed if error or not completed
 I $D(Y) W *7,!!,"Release NOT COMPLETED !!",!! H 2 S DR="6///@;12///@;13///@;14///@;17////T;25////"_DVBABY_";26////"_DVBDTA,DIE="^DVB(396.3,",DA=REQDA,DIC=DIE,$P(^DVB(396.3,REQDA,1),U,3)=DVBOTH D ^DIE G LOOK
 S FAX=$S($D(^DVB(396.3,REQDA,1)):$P(^(1),U,3),1:"N"),RSTAT="C"
 ;
FX ;if to be faxed or transferred out, set like RO has printed it
 I FAX="Y" K DR S CTIM=$$NOW^XLFDT,DR="6////"_CTIM_";15////"_CTIM_";16////^S X=DUZ;17////"_RSTAT S (DIE,DIC)="^DVB(396.3,",DA=REQDA D ^DIE
 G LOOK
 ;
EXIT G KILL^DVBCUTIL
 ;
KILL K CNUM,SSN,PNAM,FAX,CTIM,DIC,DA,D0,D1,DFN,X,Y,NCN,STAT,%,NOFND,NFINAL,REQDA,STAT,RSTAT,DVBDTA,DVBOTH,DVBABY
 Q
 ;
STATCHK I STAT="RX" W *7,!!,"This request has been cancelled by the RO.",!! H 2 S NCN=1 Q
 I STAT="CT" W *7,!!,"This request has been completed and transferred out.",!! H 2 S NCN=1 Q
 I STAT="X" W *7,!!,"This request has been cancelled by MAS.",!! H 2 S NCN=1 Q
 I STAT="R" W *7,!!,"This request has been released to the RO.",!! H 2 S NCN=1 Q
 I STAT="C" W *7,!!,"This request has been printed by the RO.",!! H 2 S NCN=1 Q
 I STAT="N"!(STAT="NT") W *7,!!,"This request is new and has not yet been reported to MAS.",!! H 2 S NCN=1
 Q
