SOWKNEW ;B'HAM ISC/SAB-Routine to add new worker and to replace old worker ; 17 Nov 93 / 9:40 AM
 ;;3.0; Social Work ;**3,13,16**;27 Apr 93
 W !!,"Are You: ",!,?5,"1. Adding and Replacing a Worker",!,?5,"2. Replacing a Worker" R !,"Enter 1 or 2  1// ",SWK:DTIME,! S:SWK="" SWK="1" G:"^"[SWK!('$T) CLO I "12"'[SWK D HP G SOWKNEW
 G:"2"[SWK SWP
WRK W ! S DIE("NO^")="OUTOK",DIC("S")="I '$D(^VA(200,+Y,654)),'$P(^VA(200,+Y,0),""^"",11)!($P(^(0),""^"",11)'<DT)",DIC="^VA(200,",DIC(0)="AQEM",DIC("A")="SELECT NEW WORKER: " D ^DIC G:"^"[X CLO S (DA,SWN)=+Y K DIC G:+Y'>0 WRK
 S SOWKNEW=1,DIE="^VA(200,",DR="654///1;654.15;S SOWKXX=1;654.1;654.2;K SOWKXX" W ! D ^DIE
 I $D(Y)!'$P(^VA(200,DA,654),"^",2)!'$P(^(654),"^",3)!'$P(^(654),"^",5) W !!,*7,"INCOMPLETE WORKER INFORMATION!!  DATA NOT ADDED." D DEL G CLO
 G SWR
 Q
SWR W !! S DIC="^VA(200,",DIC("A")="WHICH WORKER TO REPLACE ? ",DIC(0)="AQEM",DIC("S")="I SWN'=+Y,$O(^SOWK(650,""W"",+Y,0))" D ^DIC G:$D(DUOUT)!(Y<0) CLO S SWO=+Y K DIC
YN F Q=0:0 W !,"ARE YOU SURE YOU WANT TO REPLACE THIS WORKER" S %=2 D YN^DICN Q:%  I %Y["?" D YN^SOWKHELP
 G:%=2!(%=-1) CLO
 D WAIT^DICD F I=0:0 S I=$O(^SOWK(650,"W",SWO,I)) Q:'I  S $P(^SOWK(650,I,0),"^",3)=SWN,SWPT=$P(^(0),"^",8),^SOWK(650,"W",SWN,I)="" D DB I '$P(^SOWK(650,I,0),"^",18) D AC
 K ^SOWK(650,"W",SWO)
CLO K IFN,SWPT,II,%,VAR,%Y,Q,DIC,X,DA,SWN,Y,DIE,DR,SWO,I,SWK,SOWKNEW,SOWKXX,SOWKREC,SOWKEDIT,SOWKOUT
 Q
SWP W !! S DIC="^VA(200,",DIC("A")="REPLACEMENT WORKER ? ",DIC(0)="AQEM",DIC("S")="I $D(^VA(200,+Y,654)),$P(^VA(200,+Y,654),""^"")" D ^DIC G:$D(DUOUT)!(Y<0) CLO S SWN=+Y K DIC G SWR
 Q
AC S ^SOWK(650,"AC",$P(^SOWK(650,I,0),"^",8),SWN,$P(^(0),"^",5),I)="" K ^SOWK(650,"AC",$P(^SOWK(650,I,0),"^",8),SWO) Q
ADD ;ENTRY POINT TO ENTER/EDIT WORKERS
 W !! S DIC="^VA(200,",DIC("A")="SELECT WORKER: "
 S DIC(0)=$S($G(SOWKEDIT)=1:"EMQ",1:"AEQM") D ^DIC G:"^"[X CLO G:Y<0 ADD S DA=+Y,SOWKREC=$P(Y,U,2) K SOWKEDIT S:$D(^VA(200,+Y,654)) SOWKEDIT=1 K DIC S SOWKNEW=1 S DIE="^VA(200,",DR="[SOWKNWRK]",DIE("NO^")="OUTOK" W ! D ^DIE
 I '$P(^VA(200,DA,654),"^",2)!'$P(^(654),"^",3)!'$P(^(654),"^",5) W *7,!!,"INCOMPLETE WORKER INFORMATION!!  DATA NOT ADDED.",! I '$D(SOWKEDIT) D DEL Q
 I $D(SOWKEDIT),('$P(^VA(200,DA,654),"^",2)!('$P(^(654),"^",3))!('$P(^(654),"^",5))) K DIE,DA,DR S X=SOWKREC W:$D(SOWKEDIT) !,"WORKERS INFORMATION MUST BE COMPLETE" G ADD
 G CLO
 Q
DEL K ^VA(200,DA,654),^VA(200,"ASWB",DA,DA),^VA(200,"ASWE",DA) F I=0:0 S I=$O(^VA(200,"ASWC",I)) Q:'I  F II=0:0 S II=$O(^VA(200,"ASWC",I,II)) Q:'II  I II=DA K ^VA(200,"ASWC",I,II)
 S VAR="" F I=0:0 S VAR=$O(^VA(200,"ASWD",VAR)) Q:VAR=""  F II=0:0 S II=$O(^VA(200,"ASWD",VAR,II)) Q:'II  I II=DA K ^VA(200,"ASWD",VAR,II)
 F I=0:0 S I=$O(^VA(200,"ASWE",I)) Q:'I  F II=0:0 S II=$O(^VA(200,"ASWE",I,II)) Q:'II  I II=DA K ^VA(200,"ASWE",I,II)
 Q
HP W !!,"Entering the number one (1) will allow you to add a new worker and then assign",!,"that new worker a current worker's case load.",!,"The number two (2) allows you to assign a current worker's case load to another current worker."
 Q
DB I $D(^SOWK(655.2,SWPT,0)),$P(^(0),"^",3)=SWO S $P(^SOWK(655.2,SWPT,0),"^",3)=SWN,$P(^(0),"^",13)=$P(^VA(200,SWN,654),"^",2),^SOWK(655.2,"C",SWN,SWPT)="",^SOWK(655.2,"E",$P(^VA(200,SWN,654),"^",2),SWPT)="" D KXRF
 I $O(^SOWK(655.2,SWPT,23,"B",SWO,0)) S IFN=$O(^SOWK(655.2,SWPT,23,"B",SWO,0)),$P(^SOWK(655.2,SWPT,23,IFN,0),"^")=SWN,^SOWK(655.2,SWPT,23,"B",SWN,IFN)="" K ^SOWK(655.2,SWPT,23,"B",SWO,IFN)
 Q
KXRF K ^SOWK(655.2,"C",SWO,SWPT),^SOWK(655.2,"E",$P(^VA(200,SWO,654),"^",2),SWPT)
 Q
