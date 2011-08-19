FHNO8 ; HISC/REL - History of Supp. Fdgs. ;5/17/93  14:24 
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;patch #5 - add outpatient SFs,
 ;
SF K FHDFN,X,WARD,SDT,EDT,STDT,ENDT
 S ADM="",FHALL=1 D ^FHOMDPA
 G:'FHDFN KIL
 I $O(^FHPT(FHDFN,"A",0))<1 W !!,"NO ADMISSIONS ON FILE!" G OSF
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="Q",DA=FHDFN,X="??" D ^DIC
 S WARD="" I $G(DFN)'="" S WARD=$G(^DPT(DFN,.1))
 K ADM
SF0 W !!,"Select ADMISSION or RETURN for OUTPATIENT ",$S(WARD'="":" (or C for CURRENT)",1:""),": " R X:DTIME G:X["^" KIL D:X="c" TR^FH
 I (X="")&'($D(^FHPT(FHDFN,"OP"))) W !!,"NO OUTPATIENT DATA ON FILE!" G SF
 I (X="")&($D(^FHPT(FHDFN,"OP"))) G OSF
 I WARD'="",X="C" S ADM=$G(^DPT("CN",WARD,DFN)) G CAD:ADM
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="EQM" D ^DIC G:Y<1 SF0 S ADM=+Y
CAD I $G(ADM),$G(^FHPT(FHDFN,"A",ADM,0)) G IN
 ;
SF1 I '($D(^FHPT(FHDFN,"OP"))) W !!,"NO OUTPATIENT DATA ON FILE!" G SF
 W !!,"Enter the Start Date and End Date for outpatient data.",!
 D STDATE^FHOMUTL S SDT=STDT I STDT="" Q
 S X="T+30" D ^%DT S ENDT=Y
 D DD^%DT S FHDTDF=Y K DIR
 S DIR("A")="Select End Date: ",DIR("B")=FHDTDF,DIR(0)="DAO^"_STDT
 D ^DIR
 Q:$D(DIRUT)  S ENDT=Y S Y=ENDT D DD^%DT W "  ",Y
 D ADM
 Q
OSF ;process outpatient SFs.
 ;
 S FHSFLG=0
 S FHSOOP=$O(^FHPT(FHDFN,"OP","B",DT-30))
 I '$D(^FHPT(FHDFN,"OP"))!'$G(FHSOOP) G FHNO8
 ;W !!,"Outpatient Recurring Meals... "
 D ASK0
 G:'$G(ADM) SF
 S (N1,LST)=0
 I $G(ADM) F K=0:0 S K=$O(^FHPT(FHDFN,"OP",ADM,"SF",K)) Q:K<1  S X=^(K,0),LST=K D LIS
 I $G(ADM),'N1 W !!,"No Supplemental Feedings for this outpatient date!",! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to Continue or '^' to Exit"  D ^DIR Q:'Y  G OSF
 I $G(ADM),$G(N1) G OSF0
 G OSF
OSF0 R !!,"Detailed Display of which Order #? ",X:DTIME G:'$T!("^"[X) FHNO8 I X'?1N.N!(X<1)!(X>LST) W *7," Enter # of Order to List" G OSF0
 S NO=+X,Y=$G(^FHPT(FHDFN,"OP",ADM,"SF",NO,0)) D:Y'="" L1^FHNO7
 G SF
 Q
ASK0 ;ask for Recurring Meal entry.
 K ADM
 W @IOF,!,"Outpatient Recurring Meals... "
 S FHQ=0,FHSDT=DT-60
 F FHI=FHSDT-1:0 S FHI=$O(^FHPT("RM",FHI)) Q:FHI'>0!FHQ  F FHJ=0:0 S FHJ=$O(^FHPT("RM",FHI,FHDFN,FHJ)) Q:FHJ'>0!FHQ  I ($P($G(^FHPT(FHDFN,"OP",FHJ,0)),U,15)'="C") D
 .S FHDA15=$G(^FHPT(FHDFN,"OP",FHJ,0))
 .S FHMEAL=$P(FHDA15,U,4),FHLOC=$P(FHDA15,U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHMEAL="B":"Break",FHMEAL="N":"Noon",1:"Even"),FH11=FHMEAL_"  "_FHLOCN
 .S Y=$P(FHDA15,U,1) X ^DD("DD") S DTP=Y
 .S (FHCOFLG,FHDATL,FHSF)=0
 .I $Y>(IOSL-5) K DIR S DIR(0)="E",DIR("A")="Enter RETURN to Continue or '^' to Quit Listing"  D ^DIR W:Y @IOF I 'Y S FHQ=1 Q
 .W !,DTP,?12,FH11
 .S FHDATL=$L(DTP)+13+$L(FH11)
 .S:$D(^FHPT(FHDFN,"OP",FHJ,"SF",0)) FHSF=$P(^FHPT(FHDFN,"OP",FHJ,"SF",0),U,3)
 .Q:'$G(FHSF)
 .S FHDA15SF=$G(^FHPT(FHDFN,"OP",FHJ,"SF",FHSF,0))
 .Q:$P(FHDA15SF,U,32)
 .S FHDASFNM=$P($G(^FH(118.1,$P(FHDA15SF,U,4),0)),U,1)
 .W ?40," (",FHDASFNM,")"
 W !
 K DIC S DIC(0)="AEQM"
 S DIC("W")="S FHMEAL=$P(^(0),U,4),FHLOC=$P(^(0),U,3),FHLOCN=$P($G(^FH(119.6,FHLOC,0)),U,1),FHMEAL=$S(FHMEAL=""B"":""Break"",FHMEAL=""N"":""Noon"",1:""Even""),FH11=FHMEAL_""  ""_FHLOCN D EN^DDIOL(FH11,"""",""?3"")"
 S DIC("S")="I $P(^FHPT(FHDFN,""OP"",+Y,0),U,1)>(DT-60)"
 S DIC="^FHPT(FHDFN,""OP"","
 S DIC("?")="Select a Date, '^' to exit"
 S DIC("A")="Select the Outpatient Date :" D ^DIC K DIC Q:(Y'>0)!$D(DTOUT)
 S ADM=+Y
 S FHMEAL=$P($G(^FHPT(FHDFN,"OP",ADM,0)),U,4)    ;outpatient standing orders.
 Q
 ;
 S ALL=1 D ^FHDPA G:'DFN KIL G:'FHDFN KIL
 I $O(^FHPT(FHDFN,"A",0))<1 W !!,"NO ADMISSIONS ON FILE!" G FHNO8
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="Q",DA=FHDFN,X="??" D ^DIC
A0 W !!,"Select ADMISSION",$S($D(^DPT(DFN,.1)):" (or C for CURRENT)",1:""),": " R X:DTIME G:'$T!("^"[X) KIL D:X="c" TR^FH
 ;
IN ;D ADM G SF0:ADM'>0
 ;
P0 S (N1,LST)=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"SF",K)) Q:K<1  S X=^(K,0),LST=K D LIS
 I 'N1 W !!,"No Supplemental Feedings for this Admission!" G FHNO8
P1 R !!,"Detailed Display of which Order #? ",X:DTIME G:'$T!("^"[X) FHNO8 I X'?1N.N!(X<1)!(X>LST) W *7," Enter # of Order to List" G P1
 S NO=+X,Y=$G(^FHPT(FHDFN,"A",ADM,"SF",NO,0)) D L1^FHNO7
 G SF
ADM ;S WARD=$G(^DPT(DFN,.1))
 ;I WARD="" W *7,!!,"NOT CURRENTLY AN INPATIENT!",! S ADM="" Q
 ;S ADM=$G(^DPT("CN",WARD,DFN)) Q
 ;
LIS I 'N1 W !!,"Ord  Date/Time Ordered  Supplemental Feeding Menu    Date/Time Cancelled",!
 S N1=N1+1,D1=$P(X,"^",2),NM=$P(X,"^",4),D2=$P(X,"^",32)
 S DTP=D1 D DTP^FH W !,$J(K,3),"  ",DTP
 S X=$P($G(^FH(118.1,+NM,0)),"^",1) W:X'="" ?24,X
 I D2 S DTP=D2 D DTP^FH W ?54,DTP
 Q
KIL G KILL^XUSCLEAN
