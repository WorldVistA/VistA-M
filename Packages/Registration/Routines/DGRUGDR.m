DGRUGDR ;ALB/MLI - DRIVER ROUTINE TO HANDLE SEPARATE GROUPERS ; 22 NOV 88 @ 1830
 ;;5.3;Registration;**89**;Aug 13, 1993
 ;
EE ;ENTER/EDIT
 I $D(DGCNH),$D(^XUSEC("DG RUG SUPERVISOR",DUZ)) S DGFCNH=1
 I '$D(DGCNH),$D(^XUSEC("DG RUG SUPERVISOR",DUZ)) S (DGFCNH,DGCNH)=""
 W !
 S DIC="^DG(45.9,",DIC(0)="AEQMN"
 S DIC("S")="D CLOSEOUT^DGRUG I $S($P(^(0),U,2)<DGLCO:0,'$D(^DG(45.9,+Y,""C"")):1,$D(^DG(45.9,+Y,""C""))&(+^DG(45.9,+Y,""C"")=1!(+^(""C"")=5)):1,1:0)&($$PTSCREEN^DGRUGU1)"
 D ^DIC K DIC G Q:Y'>0
 S DGCON=$S('$D(^DG(43,1,"RUG")):2891002,$P(^("RUG"),"^",2)]"":$P(^("RUG"),"^",2),1:2891002),DIE="^DG(45.9,",(DGPT,DA)=+Y,DGAS=$P(^DG(45.9,DGPT,0),"^",2),DR=$S(DGAS<DGCON:"[DGRUG16]",1:"[DGRUG]"),DGD=$P(^DG(45.9,DA,0),U,7) D ^DIE
 G Q:'$D(DA) D @("SET^DGRUG"_$S(DGAS<DGCON:16,1:"")) G EE
Q K DGAS,DGCON
 I $D(DGFCNH),(DGFCNH'=1) K DGFCNH,DGCNH
 G QUIT^DGRUG1
 ;
VADATS S VATNAME="RUG-II" D ^VATRAN G QUIT:VATERR
 W !,*7,"This option will send the RUG/PAI data to the Austin DPC."
A S %=2 W !,"Are you sure you want to continue" D YN^DICN I '% W !,"REPLY (Y)ES OR (N)O" G A
 D START:%=1
QUIT K ^UTILITY($J),%,%DT,D,DA,DGBC,DGPG,DGPTM,DGCNT,DGED,DGFLG,DGI,DGP,DGPG,DGROW,DGS,DGSD,DGVAR,DGXX,DGSDI,VAT,VATERR,VATNAME,DIE,DR,I,I1,J,K,L,POP,S,X,XMDUZ,XMSUB,XMTEXT,XMY,Y Q
START K ^UTILITY($J) D LO^DGUTL R !,"Survey purpose: (A)dmission/transfer & CNH or (S)emi-annual? ",X:DTIME G QUIT:X[U,HELP:"AS"'[X S DGP=$S(X="A":1,X="S":2,1:0) G QUIT:'DGP
DT D CLOSEOUT^DGRUG S DGCNT=0,%DT("A")="ASSESSMENT START DATE: ",%DT="AEPX" D ^%DT K %DT("A") G QUIT:Y<0,CLOUT:Y<DGLCO,FUT:Y>DT S DGSD=Y-.1 S %DT(0)=DGSD+.1,%DT("A")="END DATE: " D ^%DT K %DT("A") G QUIT:Y<0,FUT:Y>DT S DGED=Y
 S DGCON=$S('$D(^DG(43,1,"RUG")):2891002,$P(^("RUG"),"^",2)']"":2891002,1:$P(^("RUG"),"^",2)) I DGSD+.1<DGCON,(DGED'<DGCON) G DTHELP
 W !!,"You must have transmission turned on to Q-",$S(DGED<DGCON:"PAF",1:"RUG")," and off for Q-",$S(DGED<DGCON:"RUG",1:"PAF")
 W !!?5,"Transmission is presently turned on to:" S I="",DGFLG=0 F I1=0:0 S I=$O(VAT(I)) Q:'I  W !?15,VAT(I) I VAT(I)[("@Q-"_$S(DGED<DGCON:"RUG",1:"PAF")) S DGFLG=1 W "***"
 I DGFLG=1 W !!,*7,*7,"Transmission is turned on to the wrong queue.  Can not proceed at this time." G QUIT
 W !!,"Enter '^' at the device prompt to leave this option.",! G @("DEV^"_$S(DGED<DGCON:"DGRUGV16",1:"DGRUGV"))
HELP W !!,"Depending on type of survey being transmitted enter",!?5,"A - Admission/Transfer and CNH PAI Surveys",!?5,"S - Semi-annual PAI survey",! G START
CLOUT W !!,*7,"Start date must be within current closeout cycle.",!,"Date must not be before " S Y=DGLCO D DT^DIQ W ".",!! G DT
FUT W !!,*7,"Can not transmit for future dates",!! G DT
DTHELP W !!,*7,"You can not overlap the RUG17 Conversion date.",!,"Dates must both be prior to or after " S Y=DGCON D DT^DIQ W !! G DT
