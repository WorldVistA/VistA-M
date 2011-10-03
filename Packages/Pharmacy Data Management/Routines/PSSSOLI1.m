PSSSOLI1 ;BIR/RTR-Manual match Solutions to Orderable Items continued ; 09/01/98 7:13
 ;;1.0;PHARMACY DATA MANAGEMENT;**15**;9/30/97
ADD ;
 S PSND=$G(^PSDRUG(PSDISP,"ND")),PSND1=$P(PSND,"^"),PSND3=$P(PSND,"^",3),DA=PSND1,K=PSND3
 I PSND1,PSND3 S X=$$PSJDF^PSNAPIS(DA,K) S PSDOSPTR=$P(X,"^")
 I $G(PSDOSPTR),$D(^PS(50.606,PSDOSPTR,0)) S PSDOSNM=$P(^(0),"^") W !!?3,"*** Dose Form from NDF:  ",PSDOSNM G PASS
 W ! K DIC S DIC="^PS(50.606,",DIC(0)="QEAMZ",DIC("A")="Select Dose Form: " D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G ^PSSSOLIT
 S PSDOSPTR=+Y,PSDOSNM=$P($G(^PS(50.606,PSDOSPTR,0)),"^")
PASS S PSOIDOSE=PSDOSPTR W !!,"Solution Name ->  ",$G(PSSNAME),!,"       Volume ->  ",$G(PSSVOL),!,"    Dose Form ->  ",PSDOSNM
 S XXX=PSSNAME D CHECK
 S PSANS=0 I ZZFLAG W $C(7),!!,"There is already an Orderable Item named:",!?5,$P($G(^PS(50.7,ZZFLAG,0)),"^")_"   "_$P($G(^PS(50.606,+$P(^(0),"^",2),0)),"^"),!
 I  K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Match to this Orderable Item" D ^DIR S PSANS=Y K DIR I Y["^"!($D(DTOUT)) G ^PSSSOLIT
 I PSANS W !!,"Matching: ",PSSNAME_"   "_$G(PSSVOL),!,"   to",!,$P($G(^PS(50.7,ZZFLAG,0)),"^")_"   "_$G(PSDOSNM) W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK" D ^DIR G:Y=1 SOMAT^PSSSUTIL G:Y["^"!($D(DTOUT)) ^PSSSOLIT
XDIR W ! K DIR S DIR(0)="F^3:40",DIR("A")="Enter Orderable Item Name" S X=PSSNAME D INPUT I $L(PSSNAME)>2,$L(PSSNAME)<41,'INFLAG S DIR("B")=PSSNAME
 D ^DIR K DIR I Y["^"!(Y="")!($D(DUOUT))!($D(DTOUT)) G ^PSSSOLIT
 S HOLDOI=X
 D INPUT I INFLAG W $C(7),!?5,"??",! G XDIR
 S PPFLAG=0 F QQ=0:0 S QQ=$O(^PS(50.7,"ADF",HOLDOI,PSOIDOSE,QQ)) Q:'QQ!(PPFLAG)  I QQ,$P($G(^PS(50.7,QQ,0)),"^",3) S PPFLAG=QQ
 I PPFLAG W !!,"Matching: ",PSSNAME_"   "_$G(PSSVOL),!,"   to",!,$P($G(^PS(50.7,PPFLAG,0)),"^")_"   "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")
 I  W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK" D ^DIR K DIR W ! G:Y["^"!($D(DTOUT)) ^PSSSOLIT G:Y=0 XDIR
 I PPFLAG S ZZFLAG=PPFLAG G SOMAT^PSSSUTIL
NEW ;Create new entry in 50.7
 W !!,"Matching: ",PSSNAME_"   "_$G(PSSVOL),!,"   to",!,HOLDOI_"   "_PSDOSNM
 W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK" D ^DIR K DIR W ! I Y'=1 G XDIR
 K DIC,DD,DO S DIC="^PS(50.7,",DIC(0)="L",X=HOLDOI,DIC("DR")=".02////"_PSOIDOSE_";.03////"_1 D FILE^DICN K DIC I Y<1 W !!,"Unable to create entry, try again!",! G XDIR
 S PSNEWOI=+Y S SCOUNT=0 F SS=0:0 S SS=$O(^PS(52.7,PSSIEN,3,SS)) Q:'SS  S SCOUNT=SCOUNT+1,SYN(SCOUNT)=^(SS,0)
 K DIE S DIE="^PS(52.7,",DA=PSSIEN,DR="9////"_PSNEWOI D ^DIE K DIE
 I SCOUNT S ^PS(50.7,PSNEWOI,2,0)="^50.72^"_SCOUNT_"^"_SCOUNT F WW=0:0 S WW=$O(SYN(WW)) Q:'WW  S ^PS(50.7,PSNEWOI,2,WW,0)=SYN(WW)
 S NEWFLAG=1 S PSSOI=PSNEWOI D DIR^PSSPOIM3 I $G(PSSDIR) W !!?3,"Now editing Orderable Item:",!?3,$P(^PS(50.7,PSSOI,0),"^"),"   ",$P($G(^PS(50.606,+$P(^(0),"^",2),0)),"^") D INACT^PSSSOLIT
 K NEWFLAG,PSSDIR D EN^PSSPOIDT(PSSOI) D:'$G(PSSSSS) EN2^PSSHL1(PSSOI,"MAD")
 G ^PSSSOLIT
INPUT S INFLAG=0 I X[""""!($A(X)=45)!('(X'?1P.E))!(X?2"z".E) S INFLAG=1
 Q
CHECK ;
 S (ZZFLAG,ZZXFLAG)=0 F VV=0:0 S VV=$O(^PS(50.7,"ADF",XXX,PSOIDOSE,VV)) Q:'VV  S:VV&($P($G(^PS(50.7,VV,0)),"^",3)) (ZZFLAG,ZZXFLAG)=VV
 Q
