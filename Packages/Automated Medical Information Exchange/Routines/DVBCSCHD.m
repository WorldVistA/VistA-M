DVBCSCHD ;ALB/GTS-557/THM-SCHEDULE C&P EXAMS ; 9/23/91  9:54 AM
 ;;2.7;AMIE;**17**;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - GTS/Set DVBADA,DVBASDRT SD Event driver  (Enhc 13)
 ;
SETUP D HOME^%ZIS S HD="SCHEDULE C&P EXAMS",FF=IOF
 I $D(DUZ)#2=0 W *7,!!,"You have no user number !",!! H 3 G EXIT
 S SUPER=0 I $D(^XUSEC("DVBA C SUPERVISOR",DUZ)) S SUPER=1
 ;
EN D ZAP W @FF,?(IOM-$L(HD)\2),HD,!!!
 S DIC="^DVB(396.3,",DIC(0)="AEQM",DIC("A")="Enter VETERAN NAME: ",DIC("W")="D DICW^DVBCUTIL"
 D ^DIC G:X=""!(X[U)!($D(DTOUT)) EXIT
 I +Y>0 S (OLDDA,REQDA)=+Y,DFN=$P(Y,U,2)
 I $O(^DVB(396.4,"C",REQDA,0))="" W !!,*7,"This request has no exams on it and should",!,"be completely cancelled.",!! H 3 G EN
 D GO1 I '$D(TFIND) W !!,*7,"This request has been completely transferred to another site.",!,"Scheduling will not be allowed.",!! H 3 G EN
 S STAT=$P(^DVB(396.3,+Y,0),U,18) D STATCHK I $D(NCN) G EN
 S DTSCHED=$P(^DVB(396.3,+Y,0),U,6) I DTSCHED]"" W !!,*7,"Scheduling has been completed for this request as of ",$$FMTE^XLFDT(DTSCHED,"5DZ")_".",!
 I DTSCHED]"",SUPER=0 W "Only supervisors can change it.",!! H 3 G EN
 ;
ASK K %,%Y I DTSCHED]"",SUPER=1 W "Do you want to change" S %=2 D YN^DICN G:$D(DTOUT)!(%<0) EXIT
 I $D(%Y),%Y["?" W !!,"Enter Y to be able to change the scheduling information or N to backup.",!! G ASK
 I $D(%),%'=1 G EN
 ;
ASK1 I $D(^DVB(396.3,REQDA,4)),$P(^(4),U,1)="y" W !!,"Note:  One or more exams on this request have transferred out."
 W !!,"Do you want to make an appointment for a clinic" S %=1 D YN^DICN G:$D(DTOUT)!(%<0) EXIT I %=1 W @FF,"Schedule a Clinic Appointment for 2507 Exam",!!! S ORACTION=1,DVBADA=REQDA,DVBASDRT="",ORVP=DFN D OERR^SDM
 I $D(%Y),%Y["?" W !!,"Enter Y to make an appointment via ADT/Scheduling or N to skip." G ASK1
 ;
EN1 W @FF,"Enter Scheduling Information for 2507 Exams",!!
 ;
ASK2 W !,"Has scheduling for all exams been completed" S %=2 D YN^DICN G:$D(DTOUT)!(%<0) EXIT
 I $D(%Y),%Y["?" W !!,"Enter Y if scheduling is completed, N if not.",!! G ASK2
 G:%'=1 EN
 W !!,"Ok, then please complete the following:",!!
 S:$P(^DVB(396.3,REQDA,0),U,6)="" DR="5///NOW",DIE="^DVB(396.3,",DA=REQDA D ^DIE:$P(^DVB(396.3,REQDA,0),U,6)="",EXAMS I '$D(Y) G EN
 I $D(Y) W *7,!!,"Important scheduling information is missing!",!,"2507 file NOT updated!",!! S DR="5///@",DIE="^DVB(396.3,",DA=REQDA D ^DIE H 2 G EN ;delete date if "^"
 ;
ZAP K %,%Y,NCN,DFN,EXAM,JDR,JDT,DTSCHED,REQDA,RO,RONAME,STAT,TFIND,TSTDT
 Q
 ;
EXIT K TFIND,ORACTION,ORVP,DVBAXJ,DVBASDRT G KILL^DVBCUTIL
 ;
STATCHK Q:STAT="P"!(STAT="N")!(STAT="NT")!(STAT="S")!(STAT="O")
 W !!,*7,"This request has been ",$S(STAT="RX":"cancelled by the RO",STAT="X":"cancelled by MAS",STAT="T":"transcribed",STAT="R":"released",STAT="C":"completed",STAT="CT":"completed, transferred out",1:"given an incorrect status"),".",!!
 S NCN=1 H 2 Q
 ;NCN=no can do
 Q
 ;
EXAMS H 1 S DA(1)=REQDA
 F DA=0:0 S DA=$O(^DVB(396.4,"C",DA(1),DA)) Q:DA=""!(+DA=0)  S EXNAME=+$P(^DVB(396.4,DA,0),U,3),EXST=$P(^(0),U,4),EXNAME=$S($D(^DVB(396.6,EXNAME,0)):$P(^(0),U,1),1:"") I EXST'["X",EXST'="T" D EXAMS1 ;screen cancels, transfers
 Q
 ;
EXAMS1 I EXNAME]"" S DIE="^DVB(396.4,",DR=".08//NO;.09//CLINIC" W @IOF,!!!,"Exam: ",EXNAME,!!! D ^DIE Q:$D(Y)
 Q
 ;
GO1 K TFIND F DVBAXJ=0:0 S DVBAXJ=$O(^DVB(396.4,"C",REQDA,DVBAXJ)) Q:DVBAXJ=""  I $P(^DVB(396.4,DVBAXJ,0),U,4)'="T" S TFIND=1
 Q
 ;if $D(TFIND) at least one exam to be done locally
 ;if '$D(TFIND) all exams are transferred/don't consider
