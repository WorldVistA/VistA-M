PSOSUP ;BHAM ISC/SAB-ENTER PHARMACISTS ; 07/13/92 16:43
 ;;7.0;OUTPATIENT PHARMACY;**10,268**;DEC 1997;Build 9
 W @IOF
 I DUZ(0)'="@",'$D(^XUSEC("XUMGR",DUZ)),'$D(^XUSEC("PSORPH",DUZ)) W !,$C(7),"You Must Hold the 'PSORPH' key in order to be able to use this option!",! G EX
ASK R !!,"Select PHARMACIST: ",X:DTIME S:'$T X="^" G:"^"[X EX D PHASK:X["?" S DIC=200,DIC(0)="EQMZ" D ^DIC G PSOSUP:X="?"!(Y<0) S PHARM=$P(Y(0),"^"),PSN=+Y
 S DA=PSN,DIC(0)="EQMZ",(DIE,DIC)=200 D ^DIC I Y>0 S DA=+Y,DIE=DIC,DR="51///PSORPH",DR(51,200.051)=".01///PSORPH;1////"_$S($G(DUZ):DUZ,1:"")_";2///"_DT L +^VA(200,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) D ^DIE L -^VA(200,DA)
 I $D(Y)!('$D(^XUSEC("PSORPH",PSN))) W !,$P(^VA(200,PSN,0),"^")_" DOES NOT hold the 'PSORPH' Security Key",! D EX G ASK
 W !,$P(^VA(200,PSN,0),"^")_" now holds the 'PSORPH' Security Key",! G ASK
EX K %,X,Y,%Y,C,D0,D1,DA,DI,DIE,DIQ,DIH,DIU,DIV,DLAYGO,DQ,DR,I,PSN,PHARM,Z,DIC,DIG
 Q
PHASK W !,"The pharmacist is an entry in the NEW PERSON file and holds the PSORPH",!,"key in the SECURITY KEY file.",!,"To delete a pharmacist, enter the name at the Select Pharmacist prompt and"
 W !,"when the key PSORPH is shown as a default enter @ press return.",!,"The current list of PSORPH holders are:"
 S A="",C=0,G=18
 ;F J=0:0 S J=$O(^XUSEC("PSORPH",J)) Q:'J  W !?5,$P($G(^VA(200,J,0)),"^") S C=C+1 I C>G R !,"Enter '^' to stop",A:DTIME S:'$T A="^" S C=0
 F J=0:0 S J=$O(^XUSEC("PSORPH",J)) Q:'J  W !?5,$P($G(^VA(200,J,0)),"^") D:$Y+4>IOSL
 .R !,"Enter '^' to stop",A:DTIME S:'$T A="^" S C=0
 K A,H,J,C,G Q
