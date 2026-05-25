PSOSUP ;BHAM ISC/SAB-ENTER PHARMACISTS ; 07/13/92 16:43
 ;;7.0;OUTPATIENT PHARMACY;**10,268,501,770**;DEC 1997;Build 145
 N DIC,X,Y,DR,PSN,DIE,KEY,PHARM,A,H,J,C,G,PSOSCRY,PSOFIRST,PSOSTOP,Z
 D EX
 W @IOF
 I DUZ(0)'="@",'$D(^XUSEC("XUMGR",DUZ)),'$D(^XUSEC("PSORPH",DUZ)) W !,$C(7),"You Must Hold the 'PSORPH' key in order to be able to use this option!",! G EX
ASK R !!,"Select PHARMACIST: ",X:DTIME I '$T!(X="") S X="^"
 G:X["^" EX D PHASK:X["?" G PSOSUP:$G(PSOSTOP)
 K DIC S DIC=200,DIC(0)="EQMZ" D ^DIC
 G PSOSUP:X["?"!(Y<0) S PHARM=$P(Y(0),"^"),PSN=+Y
 S DA=PSN,DIC(0)="EQMZ",(DIE,DIC)=200 D ^DIC
 ;
 W ! K DIC S DIC(0)="AEMQ",DIC=19.1 ;,DIC("B")="PSORPH"
 S DIC("S")="I "",PSORPH,PSO ERX WORKLOAD TECH,PSO ERX WORKLOAD RPH,""[("",""_X_"","")"
 D ^DIC I $G(Y)'>0 D EX G ASK
 S KEY=X
 ;
 I PSN>0 S DA=+PSN,DIE=200,DR="51///"_KEY,DR(51,200.051)=".01///"_KEY_";1////"_$S($G(DUZ):DUZ,1:"")_";2////"_DT L +^VA(200,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) D ^DIE L -^VA(200,DA)
 I $D(Y)!('$D(^XUSEC(KEY,PSN))) W !,$P(^VA(200,PSN,0),"^")_" DOES NOT hold the '"_KEY_"' Security Key",! D EX G ASK
 W !,$P(^VA(200,PSN,0),"^")_" now holds the '"_KEY_"' Security Key",! G ASK
EX K %,X,Y,%Y,C,D0,D1,DA,DI,DIE,DIQ,DIH,DIU,DIV,DLAYGO,DQ,DR,I,PSN,PHARM,Z,DIC,PSOSTOP
 Q
 ;
PHASK W !,"The pharmacist is an entry in the NEW PERSON file and holds the PSORPH",!,"key in the SECURITY KEY file.",!,"To delete a pharmacist, enter the name at the Select Pharmacist prompt and"
 W !,"when the key PSORPH is shown as a default enter @ press return.",!,"The current list of PSORPH holders are:"
 S A="",C=0,G=18,PSOFIRST=1
 F J=0:0 S J=$O(^XUSEC("PSORPH",J)) Q:'J!($G(PSOSTOP))  W !?5,$P($G(^VA(200,J,0)),"^") S PSOSCRY=$G(PSOSCRY)+1 I $S(PSOFIRST:PSOSCRY+7>IOSL,1:PSOSCRY+2>IOSL) D
 .R !,"Enter '^' to stop",A:DTIME S:A["^" PSOSTOP=1 S PSOSCRY=1,PSOFIRST=0
 K A,H,J,PSOSCRY,PSOFIRST Q
