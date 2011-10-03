ONCOAIC ;Hines OIFO/GWB - Create first primary for a patient ;06/23/10
 ;;2.11;ONCOLOGY;**1,24,25,27,32,42,44,45,51**;Mar 07, 1995;Build 65
 ;
EN ;Create first ONCOLOGY PRINMARY (165.5) record
 D KILL
 W @IOF
 W !!?5,"******** CREATE FIRST PRIMARY RECORD FOR THIS PATIENT*******",!!
 W:$D(ONCONM) ?5,"PATIENT: ",ONCONM
 ;
LOOK1 ;Select first primary
 K DIC,ONCOPN,ONCOSIT
 S DIC="^ONCO(164.2,",DIC(0)="AEQM"
 S DIC("A")="     Select first Primary SITE/GP: "
 S DIC("S")="I '$P(^(0),U,3)"
 W ! D ^DIC K DIC G EX:Y<0
 S (XX,X,ONCOSIT)=+Y,ONCOPN=$P(Y,U,2),XD0=ONCOD0
 D SEX^ONCOCKI G LOOK1:'$D(X)
 ;
A2 ;Create first ONCOLOGY PRIMARY (165.5) record for this patient
 L +(^ONCO(165.5,"ACAY"),^ONCO(165.5,"ACD"),^ONCO(165.5,"AF")):2
 I '$T G ASK
 W !
 K DIR,ONCOD0P
 S DIR("A")="     Ok to ADD:",DIR("B")="Yes",DIR(0)="Y" D ^DIR
 G A:Y,EN:Y=0 Q
 ;
A K DO
 W !,?5,"Creating a new Primary record for ",ONCONM
 S DIC="^ONCO(165.5,",DIC(0)="Z"
 S X=ONCOSIT
 S DIC("DR")="2000////^S X=DUZ(2);236////^S X=DT"
 D FILE^DICN
 K DIC,X G EX:Y<0
 S ONCOD0P=+Y
 S $P(^ONCO(165.5,+Y,0),U,2)=ONCOD0,$P(^(7),U,2)=0
 S ^ONCO(165.5,"C",ONCOD0,ONCOD0P)=""
 ;
NAN ;New ACCESSION NUMBER (165.5,.05)
 K DIR
 S DIR(0)="N^:2099",DIR("A")="     ACCESSION YEAR"
 S DIR("B")=$E(DT,1)+17_$E(DT,2,3)
 S Y=$G(^ONCO(165.5,"ACAY"))
 W ! D ^DIR
 I Y[U!(Y="") S Y=ONCOD0P D KLN Q
 I $L(Y)'=4 W !!?5,"ACCESSION YEAR must be 4 digits!" G NAN
 S YR=Y,^ONCO(165.5,"ACAY")=YR,AC=$O(^ONCO(165.5,"ACD",Y,0))
 I AC'="" S AC=Y_AC,SEQ="00" G DIE
NA S MR=YR_"00001",XR=999999999-((YR+1)_"00000")
 S NR=$O(^ONCO(165.5,"AF",XR))
 G AC:NR=""
 I NR<(999900002-MR) W !!?5,"SYSTEM appears out of numbers.  Looking for unassigned ones" D FND G DIE:Y'="",EX
 I NR>(999999999-MR) S NR=""
AC S AC=$S(NR="":YR_"00001",1:(1000000000-NR)),SEQ="00"
 S AC=$S($L(AC)=1:"00000"_AC,$L(AC)=2:"0000"_AC,$L(AC)=3:"000"_AC,$L(AC)=4:"00"_AC,$L(AC)=5:"0"_AC,1:AC)
 ;
DIE S DIE="^ONCO(165.5,",DA=ONCOD0P
 S DR="W !,?5;.07///^S X=YR;.05//^S X=AC;.06//^S X=SEQ"
 S ACN=AC_"/"_SEQ
 D ^DIE
LOCK L -(^ONCO(165.5,"ACAY"),^ONCO(165.5,"ACD"),^ONCO(165.5,"AF")):1 G ASK:'$T,PID:$D(Y)=0 S Y=ONCOD0P D KLN G EX
 ;
ASK W !
 S DIR("A")="     Another user is accessioning.  Try Again",DIR(0)="Y"
 S DIR("B")="Y"
 S DIR("?")=" "
 S DIR("?",1)="   Another user is obtaining the next available ACCESSION NUMBER."
 S DIR("?",2)="   Please wait a few seconds and try again."
 D ^DIR G A2:Y=1
 Q
 ;
FND ;Search for unused accession numbers
 S NR=YR_"00000",MR=(YR+1)_"00000"
NR S NR=NR+1 I NR<MR G:$D(^ONCO(165.5,"AA",NR)) NR S AC=NR,SEQ="00",Y=1 Q
 W !!?10,"OUT of ACCESSION Numbers for "_YR S Y=""
 Q
 ;
PID ;Continue defining Primary Record
 S ONCOACN=AC_"/"_SEQ,Y=1 D KILL Q
 ;
KLN ;KILL entry
 S DA=+Y,DIK="^ONCO(165.5," D ^DIK,KILL
 R !?5,"<ENTRY DELETED> - press RETURN to continue->",DA:DTIME
 Q:'$T!(DA=U)
 W !
 Q
 ;
KILL ;KILL variables 
 K AC,ACN,DA,DIC,DIE,DIK,DIR,DR
 K MR,NR,SEQ,X,XX,XD0,XR,YR
 Q
 ;
EX ;Exit
 D KILL S Y=0
 Q
 ;
CLEANUP ;Cleanup
 K ONCOACN,ONCOD0,ONCONM,Y
