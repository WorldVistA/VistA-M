DVBARL21 ;ALB/GTS-557/THM-EDIT 21 DAY CERTIFICATE TEXT ;21 JUL 89@0600
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 I $D(DUZ)#2=0 W *7,!!,"You have no user number.",!! H 3 Q
TERM D HOME^%ZIS S OPER=$S($D(^VA(200,+DUZ,0)):$P(^(0),U,1),1:"Unknown"),HD="21-DAY CERTIFICATE TEXT ENTRY/EDITING"
 S DVBAENTR=0
 ;
SETUP D UNLOCK^DVBAUTL6(DVBAENTR)
 K DVBAQUIT W @IOF S DIE="^DVB(396,",DR="6.81;D RELEASE^DVBARL21 I $D(DVBAQUIT) S Y=""@99"";6.82////R;6.83////"_DT_";6.84///"_OPER_";W !!,""This record is now released."",!! H 2;@99",DIC=DIE,DIC(0)="AEQM",DIC("A")="Enter PATIENT NAME: "
 I '$D(^XUSEC("DVBA 21-DAY CERT CLERK",+DUZ)) W !!,*7,"You do not have the proper key to use this option.",!! H 3 G EXIT
 D DICW^DVBAUTIL
 ;
EDIT D ^DIC G:X=U!(X="") EXIT W:Y<0 *7,"  ??" G:Y<0 EDIT
 S OUT=0
 I '$$LOCK^DVBAUTL6(Y) G SETUP
 I Y>0 S DVBAENTR=+Y,DA=+$P(Y,U,1),DFN=$P(Y,U,2),NAME=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9) W !!
 I $D(^DVB(396,DA,2)) I $P(^(2),U,10)="L" W !!,*7,"Wrong request type !",!,"This is an ACTIVITY DATE request, not ADMISSION DATE.",!! H 3 G SETUP
 ;I $P(^DVB(396,DA,1),U,12)]"" W !!,*7,"This request has already been FINALIZED and the text may not be changed.",!! H 3 G SETUP ;for future revisions
 I $P(^DVB(396,DA,0),U,7)'="YES" W *7,!!,"No 21-day certificate has been requested for this Veteran.",!! H 3 G SETUP
 I $P(^DVB(396,DA,0),U,7)="YES",'$D(^(4)) W !!,*7,"This Veteran has a 21-day certificate requested but",!," it has not yet been processed.",!! H 3 G SETUP
 I $P(^DVB(396,DA,4),U,1)'="N" W !!,*7,"This certificate has been released to the RO",!,$S($P(^(4),U,1)="R":" but has not been printed.",$P(^(4),U,1)="P":" and has already been printed.",1:" but the status is unknown."),!! H 3 G SETUP
 S Y=$P(^DVB(396,DA,0),U,4) X ^DD("DD") S ADMDT=Y
 H 1 W @IOF,!?(79-$L(HD)\2),HD,!!!,?15,"Name: ",NAME,!,?16,"SSN: ",SSN,?40,"Admit date: ",ADMDT,!!! D ^DIE
 G SETUP
 ;
EXIT W @IOF K DVBAENTR,OUT,WWHO,DVBAQUIT G KILL^DVBAUTIL
 Q
RELEASE ;verify release is ok
 I '$D(^XUSEC("DVBA RELEASE 21-DAY CERT",+DUZ)) S DVBAQUIT=1 Q
 W !!,"Ok to release this 21-day certificate text" S %=2 D YN^DICN
 I $D(%Y) I %Y["?" W !!,"Enter Y to go ahead and release this certificate to the RO",!,"or N to be able to make corrections and release later.",!! G RELEASE
 I %'=1 S DVBAQUIT=1
 Q
