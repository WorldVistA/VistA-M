QANVAL ;;HISC/GJC-Utilities for Incident Reporting ;4/26/91
 ;;2.0;Incident Reporting;**1,27**;08/07/1992
 ;
EN1 ;
 N QANBFLG,QANFFLG
 S (QANFLAG(0),QANOUT,QANXIT,QANAGN)=0,(QAN(0),QANBFLG,QANFFLG)=0
 W @IOF S QANIEN="" F QAN=0:0 S QANIEN=$O(^QA(742.4,"ACS",QANIEN)) Q:QANIEN=""  I "02"'[+QANIEN F QAN=0:0 S QAN=$O(^QA(742.4,"ACS",QANIEN,QAN)) Q:QAN'>0  S QAN(0)=QAN(0)+1
 I QAN(0)>0 W !!?12,$C(7),"There exist "_QAN(0)_" open INCIDENT CASE(S) on the system.",!!
 E  W !!?12,"There exists ZERO open INCIDENT CASE(S) on the system." K QAN,QANIEN
 I 'QANAGN F  W !!,"Do you wish to create a new incident event record" S %=2 D YN^DICN Q:"-112"[%  W !,$C(7),"Enter (Y)es, or (N)o, or ""^"" to quit."
 I 'QANAGN,%=-1 K QAN,QANIEN Q
 I 'QANAGN,%=1 S (QANFLAG(0),QANFFLG)=1,QANF="" D ^QANCDNT Q:QANXIT
 D:'QANFLAG(0) EDIT I QANXIT D CLEAN Q
 D:$D(QANDFN)&$D(QANIEN) EN2^QANUTL2
 F  W !!,"Do you wish to edit a particular open incident" S %=2 D YN^DICN Q:"-112"[%  W !!,"Enter (Y)es, (N)o, or ""^"" to exit"
 I %=1 S QANAGN=1 G EN1
 D CLEAN Q
CASE ;
 K DIC S DIC=742.4,DIC(0)="QEANZ",DIC("A")="Select Case Number: ",DIC("S")="I ""13""[+$P(^(0),U,8)",DIC("W")="D EN1^QANUTL" D ^DIC K DIC
 I +Y=-1 S QANXIT=1 W !!,$C(7),"Case Number not selected, exiting!!"
 E  S QANIEN=+Y
 Q
DATE ;
 K DIC,D S DIC="^QA(742.4,",DIC(0)="QEAMZ",DIC("A")="Select Date of Incident: ",D="BDT",DIC("S")="I ""13""[+$P(^(0),U,8)",DIC("W")="D EN1^QANUTL" D IX^DIC K DIC,D
 I +Y=-1 S QANXIT=1 W !!,$C(7),"Date of Incident not selected, exiting!!"
 E  S QANIEN=+Y
 Q
EDIT K DIR S DIR("A",1)="Would you like to: ",DIR("A",2)="1. Edit by the Case Number",DIR("A",3)="2. Edit by the Date of the Incident",DIR("A",4)="3. Edit by the Patient",DIR("A",5)="4. Edit by the Type of Incident"
 S DIR("A")="Enter a number: (1-4) ",DIR(0)="NOA^1:4:0",DIR("B")=3,DIR("?",1)="Choose the manner in which you wish to edit the record.",DIR("?")="Enter a number no less than 1, no greater than 4."
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) S QANXIT=1 Q
 S QANTYPE=+Y
 D @$S(QANTYPE=1:"CASE",QANTYPE=2:"DATE",QANTYPE=3:"PAT^QANUTL1",1:"TYPE")
 Q:$G(QANXIT)
 I $G(QANBFLG)'=1 L +^QA(742.4,QANIEN):5 I '$T W !!?16,$C(7),"Another person is editing this Incident Report." S QANXIT=1
 Q:QANXIT  D:$G(QANTYPE)'=3 PAT0^QANUTL1
 Q
TYPE ;
 K DIC,D S DIC="^QA(742.4,",DIC(0)="QEAMZ",DIC("A")="Select Type of Incident: ",DIC("S")="I ""13""[+$P(^(0),U,8)",D="BINC",DIC("W")="D EN1^QANUTL" D IX^DIC K DIC,D
 I +Y=-1 S QANXIT=1 W !!,$C(7),"Type of Incident not selected, exiting!!"
 E  S QANIEN=+Y
 Q
PATMAN ;DELETING A PATIENT'S RECORD
 ;***********************************************************************
 ;*** NOTE: Execution of this subroutine deletes the "ACN" x-ref from ***
 ;*** the global ^QA(742.4!                                           ***
 ;***********************************************************************
 K DIC S (DIC,DIE)="^QA(742,",DIC(0)="QEAMZ",DIC("A")="Select Patient: "
 S DIC("S")="I $D(^QA(742,""BPRS"",1,+Y))"
 S DIC("W")="D DICW^QANUTL1",QANXX=1,D="B^BS5"
 D MIX^DIC1 K DIC S QANPAT=+Y
 I QANPAT'>0 G K9
 S QANINCD=+$O(^QA(742.4,"ACN",QANPAT,"")) G:QANINCD'>0 K9
 I $O(^QA(742,"BCS",QANINCD,""))=QANPAT,$O(^QA(742,"BCS",QANINCD,QANPAT))']"" D WARN^QANAUX1 G K9
 S DIE="^QA(742,",DR=".13R",DA=QANPAT D ^DIE S QANPTST=+$P(^QA(742,QANPAT,0),U,12)
 K QAUDIT S QAUDIT("FILE")="742^50",QAUDIT("DA")=QANPAT,QAUDIT("ACTION")=$S(QANPTST=1:"o",QANPTST=-1:"d",1:"c"),QAUDIT("COMMENT")=$S(QANPTST=1:"Open ",QANPTST=-1:"Delete ",1:"Close ")_"a patient record" D ^QAQAUDIT
K9 K %W,%X,%Y,C,D0,DA,DIE,DISYS,DR,QAN,QANINCD,QANPAT,QANSSN,QANST,QANXX,X
 K QANPTST,QAUDIT,Y
 Q
CLEAN ;Kill and quit.
 K C,D,DIC,D0,DA,MSSG0,MSSG1,MSSG2,QAN,QANADM,QANADMDT,QANAFRM,QANAME
 K QANCHK,QANCODE,QANDFN,QANDGPM,QANDT,QANDUZ,QANF,QANFLAG,QANHOME
 K QANINC,QANIEN,QANINCR,QANINPAT,QANINV,QANMAIL,QANMIEN,QANOUT,QANPLC
 K X,X1,X2,QANPID,QANPIEN,QANSITE,QANSSN,QANST,QANST1,QANTRSP,QANWARD
 K QANXIT,QANZERO,QANPAT,QANTYPE,QANX,QANZER0,QANTTL,QANSERV,QANPSDO
 K QANDOB,QANHOLD,^UTILITY($J),QANDOB,QANAGE,QANQAN,QANAGN,QANYN,POP
 K QANEOP,QANHEAD,QANINS,QANLINE,QANRSP0,QANRSP1,QANSTAT,QANPAGE,QANCS
 K QANDED,VAIN,VAERR,QANIRIN,QANLCTN,QANGLB0,QAUDIT,DTOUT,DUOUT,DIROUT
 K %,%T,%W,%X,%Y,DI,DIR,DQ,J,QANIC,QANPT,QANYN,QANPT0,Y,DIRUT,%DT,DIE,DR
 K QANPRS,QAHDNM,QAHDSSN,QAHOLD
 Q
