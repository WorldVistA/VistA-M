DVBCEDIT ;ALB/GTS-557/THM-EDIT 2507 DATA ; 6/19/91  1:22 PM
 ;;2.7;AMIE;**7**;Apr 10, 1995
 I $D(DUZ)#2=0 W *7,!!,"You have no user number.",!! Q
 ;
EN D HOME^%ZIS K OUT S FF=IOF,HD="Veteran Selection",HD2="2507 Exam Data Entry"
 ;
LOOK S %DT(0)=-DT D KILL W @FF,!?(80-$L(HD)\2),HD,!?(80-$L(HD2)\2),HD2,!!! S DIC("W")="D DICW^DVBCUTIL" S DIC="^DVB(396.3,",DIC(0)="AEQM",DIC("A")="Select VETERAN: " D ^DIC G:X=""!(X=U) EXIT I +Y<0 W "  ???" H 1 G LOOK
 S STAT=$P(^DVB(396.3,+Y,0),U,18) I STAT="N" W *7,!!,"This request has not been reported to MAS and may not be transcribed.",!! H 3 G LOOK
 S (REQDA,DA(1))=+Y D STATCHK^DVBCUTL4 H:$D(NCN) 2 G:$D(NCN) LOOK
 S DFN=$P(Y,U,2),REQDT=$P(^DVB(396.3,REQDA,0),U,2),PNAM=$S($D(^DPT(DFN,0)):$P(^(0),U,1),1:"Unknown"),SSN=$S($D(^(0)):$P(^(0),U,9),1:"Not specified")
 S CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown") K DICW
 F DA=0:0 S DA=$O(^DVB(396.4,"C",REQDA,DA)) Q:DA=""  S EXAM=$P(^DVB(396.4,DA,0),U,3) S EXAM=$P(^DVB(396.6,EXAM,0),U,1),STAT=$P(^DVB(396.4,DA,0),U,4),^TMP($J,EXAM)=STAT_U_DA
 ;
DATA K NCN,QUE D HDR^DVBCUTIL
 W !
 S Y=$$EXSRH^DVBCUTL4("Select Exam: ","I $D(^DVB(396.4,""ARQ""_REQDA,+Y))")
 G:$D(DTOUT) EXIT G:X=""!(X=U) LOOK
 I +Y<0 W *7,"  ???" G DATA
 S DVBCLCKD=$$XMLCK(+Y)
 I +DVBCLCKD'=1 W !!,*7,"This exam is currently being edited.   <RETURN> to continue." R DVBCTST:DTIME K DVBCTST G DATA
 S (EXMDA,DA)=+Y,EXMNM=$P(^DVB(396.4,+Y,0),U,3)
 S EXMNM=$P(^DVB(396.6,EXMNM,0),U,1)
 S STAT=$P(^TMP($J,EXMNM),U,1)
 D STATCHK^DVBCUTL4
 I STAT="C",$P(^DVB(396.4,EXMDA,0),U,10)]"" W !,*7,"These exam results have been electronically signed.",!,"No editing is allowed!" D CONTMES^DVBCUTL4 S DVBCLCKD=$$XMUNLCK(EXMDA) G DATA
 W:STAT="C" "But you may make changes until it is released.",!! H:STAT="C" 2 I $D(NCN)&("^X^RX^"[STAT) S DVBCLCKD=$$XMUNLCK(EXMDA) G DATA
 I STAT="T" W *7,!!,"This exam has been transferred to another facility.",!! H 2 S DVBCLCKD=$$XMUNLCK(EXMDA) G DATA
 K DR S (DIC,DIE)="^DVB(396.4,",DR="W @FF;70;W @FF,!!;.06R;.07R"
 S DA=EXMDA D ^DIE,COMP^DVBCUTL4
 S DVBCLCKD=$$XMUNLCK(EXMDA)
 G:$D(OUT) EXIT S STAT1=$P(^DVB(396.4,EXMDA,0),U,4),$P(^TMP($J,EXMNM),U,1)=STAT1
 S NFINAL=0
 F EXMDA=0:0 S EXMDA=$O(^DVB(396.4,"C",REQDA,EXMDA)) Q:EXMDA=""  S STAT=$P(^DVB(396.4,EXMDA,0),U,4) I STAT'="C"&(STAT'="X")&(STAT'="RX") S NFINAL=1
 I NFINAL=0,$P(^DVB(396.3,REQDA,0),U,12)="" S XMB="DVBA C 2507 EXAM READY",XMB(1)=PNAM,XMB(2)=SSN,Y=REQDT X ^DD("DD") S XREQDT=Y,XMB(3)=XREQDT D ^XMB K XMB,XREQDT
 ;
QUE K IO("Q"),%DT S QUE="N" I NFINAL=0 K DR S DIE="^DVB(396.3,",DA=REQDA,DR="11///NOW;17////T" D ^DIE S %DT(0)=-DT
 ;
QUE1 K IO("Q") W !!,"Do you want to print a review copy" S %=2 D YN^DICN G:$D(DTOUT) EXIT I %=1 S QUE="Y"
 I $D(%Y),%Y["?" W !!,"Enter Y to print a copy of the results for review",!,"or N to continue editing.",!! H 2 G QUE1
 I QUE="Y" S (DA(1),DA)=REQDA W !! S %ZIS="AEQ" D ^%ZIS K %ZIS I POP S QUE="N" K IO("Q")
 I '$D(IO("Q")),QUE="Y" S EDPRT=1 U IO D ZTSK^DVBCPRN1 K EDPRT,AUTO,ULINE,EXMNM,XEXMNM,PGHD,DVBCSITE
 I $D(IO("Q")) S ZTRTN="ZTSK^DVBCPRN1",ZTIO=ION,ZTDESC="2507 Review Report",ZTDTH=$H F I="DVBC*","DUZ*","DA*","REQDA","EXMNM" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD I $D(ZTSK) W !!,"2507 Request queued for review to device "_ION,!! H 2 K ZTRTN,ZTIO,ZTSAVE,ZTDTH,ZTSK,IO("Q")
 D ^%ZISC
 I QUE="Y" G LOOK
 G DATA
 ;
EXIT K DVBCLCKD D:$D(ZTQUEUED) KILL^%ZTLOAD K WPTYPE,%DT G KILL^DVBCUTIL
 ;
KILL K ^TMP($J),DIC,DA,D0,D1,DFN,X,Y,OLDEXAM,REQDT,DR,EXMNM,NCN,STAT,NOFND,NFINAL,QUE,%,%Y,%ZIS,IOP
 Q
 ;
XMLCK(DA) ;  ** Lock the 396.4 exam record selected for transcription **
 L +^DVB(396.4,+DA,0):1
 Q $T
 ;
XMUNLCK(DA) ;  ** Unlock the 396.4 exam record selected for transcription **
 L -^DVB(396.4,DA,0)
 Q 0
