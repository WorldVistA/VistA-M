ECTPIND ;B'ham ISC/PTD-Individual PAID Inquiry ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**4,8,10**;
 I '$D(^PRSPC) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Current Employee' File - #450 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^PRSPC(0)) W *7,!!,"'Current Employee' File - #450 has not been populated on your system.",!! S XQUIT="" Q
 I '$O(^PRST(455,0)) W *7,!!,"'Payperiod 8B' File - #455 has not been populated on your system.",!! S XQUIT="" Q
DIC W !! S DIC="^PRSPC(",DIC(0)="QEANMZ",DIC("A")="Select EMPLOYEE name: " D ^DIC K DIC G:Y<0 EXIT^ECTPIND1 S EMPDA=+Y,NM=Y(0,0),EMPSN=$P(Y(0),"^",9)
 S FST=$O(^PRST(455,0)) W !!,"The earliest pay period/date in the file is: "_$E(FST,4,5)_" - '"_$E(FST,2,3)
 W !,"You may select the pay period/date RANGE:",!
BPP R !,"Enter BEGINNING Pay Period: ",BPP:DTIME G:'$T!("^"[BPP) EXIT^ECTPIND1 I (BPP'?.N)!(BPP<1)!(BPP>27) W !!,"You MUST answer with a number between 1 and 27." G BPP
 S:$L(BPP)=1 BPP="0"_BPP
BYR W ! S %DT="AE",%DT("A")="Enter calendar year associated with BEGINNING pay period: ",%DT(0)=2000000 D ^%DT G:$D(DTOUT)!("^"[X) EXIT^ECTPIND1 S BYR=$E(Y,1,3),BYRPP=BYR_BPP
EPP R !!,"Enter ENDING Pay Period: ",EPP:DTIME G:'$T!("^"[EPP) EXIT^ECTPIND1 I (EPP'?.N)!(EPP<1)!(EPP>27) W !!,"You MUST answer with a number between 1 and 27." G EPP
 S:$L(EPP)=1 EPP="0"_EPP
EYR W ! S %DT="AE",%DT("A")="Enter calendar year associated with ENDING pay period: ",%DT(0)=BYR_"0000" D ^%DT G:$D(DTOUT)!("^"[X) EXIT^ECTPIND1 S EYR=$E(Y,1,3),EYRPP=EYR_EPP
 I +BYRPP>+EYRPP W *7,!!?10,"ENDING pay period/date must be equal to",!?10,"or come after BEGINNING pay period/date!",!! K BPP,BYR,BYRPP,EPP,EYR,EYRPP G BPP
PP S FLG=0,YP=(BYRPP-1) F J=0:0 S YP=$O(^PRST(455,"B",YP)) Q:'YP  Q:YP>EYRPP  S FLG=1 Q:FLG=1
 I FLG=0 W *7,!!,"There is NO DATA in the file for the selected date range!",!! G EXIT^ECTPIND1
EMP S YP=(BYRPP-1),MS=0 F J=0:0 S YP=$O(^PRST(455,"B",YP)) Q:'YP  Q:YP>EYRPP  I '$O(^PRST(455,YP,1,EMPDA,0)) S MYP(YP)=""
 I $O(MYP(0)) W *7,!!,"There is NO DATA for SELECTED EMPLOYEE for pay period(s):"
 I  F K=0:0 S MS=$O(MYP(MS)) Q:'MS  W !?10,"'"_$E(MS,2,3)_"  -  "_$E(MS,4,5)
 I  G EXIT^ECTPIND1
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G EXIT^ECTPIND1
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^ECTPIND",ZTDESC="Individual PAID Inquiry" F G="EMPDA","NM","EMPSN","BYRPP","BYR","BPP","EYRPP","EYR","EPP" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD K ZTSK G EXIT^ECTPIND1
 U IO
 ;
ENQ ;ENTRY PT
 K ^TMP($J) S YP=(BYRPP-1)
 F J=0:0 S YP=$O(^PRST(455,YP)) G:'YP EN1^ECTPIND1 G:YP>EYRPP EN1^ECTPIND1 D GTDTA
 ;
GTDTA ;INDIV DATA FOR PP
 I '$D(^PRST(455,YP,1,EMPDA,0)) S ^TMP($J,YP)="" Q
 I '$D(^PRST(455,YP,1,EMPDA,1)) S LOC0=^PRST(455,YP,1,EMPDA,0) F PC=1,2,3,6,7,11,12,13,17,18,19,47,48,49,50,51,53 S $P(LOC1,"^",PC)="000"
 I  G CALC
 S LOC0=^PRST(455,YP,1,EMPDA,0),LOC1=^PRST(455,YP,1,EMPDA,1)
CALC ;COMPUTE TOTALS FOR PP
 S (AL,SL,LWOP,AA,CTE,CTU,OT)=0
PHYS ;FULL-TIME PHYSICIAN/RESIDENT
 I (($P(LOC0,"^",10)="J")!($P(LOC0,"^",10)="L")),($P(LOC0,"^",11)=1) D CONV^ECTPAS0 G SETGL
AL S AL1=$P(LOC0,"^",13),AL2=$P(LOC0,"^",48),AL=(($E(AL1,3)/4)+($E(AL1,1,2))+($E(AL2,3)/4)+($E(AL2,1,2)))
SL S SL1=$P(LOC0,"^",14),SL2=$P(LOC0,"^",49),SL=(($E(SL1,3)/4)+($E(SL1,1,2))+($E(SL2,3)/4)+($E(SL2,1,2)))
LWOP S LWOP1=$P(LOC0,"^",15),LWOP2=$P(LOC0,"^",50),LWOP=(($E(LWOP1,3)/4)+($E(LWOP1,1,2))+($E(LWOP2,3)/4)+($E(LWOP2,1,2)))
AA S AA1=$P(LOC0,"^",17),AA2=$P(LOC0,"^",52),AA=(($E(AA1,3)/4)+($E(AA1,1,2))+($E(AA2,3)/4)+($E(AA2,1,2)))
CTE S CTE1=$P(LOC0,"^",19),CTE2=$P(LOC1,"^"),CTE=(($E(CTE1,3)/4)+($E(CTE1,1,2))+($E(CTE2,3)/4)+($E(CTE2,1,2)))
CTU S CTU1=$P(LOC0,"^",20),CTU2=$P(LOC1,"^",2),CTU=(($E(CTU1,3)/4)+($E(CTU1,1,2))+($E(CTU2,3)/4)+($E(CTU2,1,2)))
OT S (OT1,OT2)=0 F PC=25,29,30,31,33,35,36,37 S OT1=OT1+$P(LOC0,"^",PC) I $E(OT1,$L(OT1))>3 S OT1=OT1+6
 F PC=6,7,49 S OT1=OT1+$P(LOC1,"^",PC) I $E(OT1,$L(OT1))>3 S OT1=OT1+6
 F PC=11,12,13,17,18,19,47,48,50,51,53 S OT2=OT2+$P(LOC1,"^",PC) I $E(OT2,$L(OT2))>3 S OT2=OT2+6
 S OT1=$E("000",1,3-$L(OT1))_OT1,OT2=$E("000",1,3-$L(OT2))_OT2,OT=(($E(OT1,3)/4)+($E(OT1,1,2))+($E(OT2,3)/4)+($E(OT2,1,2)))
SETGL ;SET TMP GLOBAL
 S ^TMP($J,YP)=AL_"^"_SL_"^"_LWOP_"^"_AA_"^"_CTE_"^"_CTU_"^"_OT
 Q
 ;
