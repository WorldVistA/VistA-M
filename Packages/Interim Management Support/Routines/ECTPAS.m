ECTPAS ;B'ham ISC/PTD-PAID Data for All Services ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$O(^PRST(455,0)) W *7,!!,"'Payperiod 8B' File - #455 has not been populated on your system.",!! S XQUIT="" Q
 I '$O(^ECC(730,"ALS",0)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"Local services have not been identified!",!,"Use the 'Identify Station's Services' option.",!! S XQUIT="" Q
 S SRVDA=0 F K=0:0 S SRVDA=$O(^ECC(730,"ALS",SRVDA)) Q:'SRVDA  S TL=0 F J=0:0 S TL=$O(^ECC(730,SRVDA,"TL",TL)) Q:'TL  S SRVTL(SRVDA,$P(^PRST(455.5,TL,0),"^"))=""
 I '$O(SRVTL(0)) W *7,!!,"There are no T&L units defined for services.",!,"Use the 'Identify T&L for Services' option.",!! G EXIT^ECTPAS1
 S FST=$O(^PRST(455,0)) W !!,"The earliest pay period/date in the file is: "_$E(FST,4,5)_" - '"_$E(FST,2,3)
 W !,"You may select the pay period/date RANGE:",!
BPP R !,"Enter BEGINNING Pay Period: ",BPP:DTIME G:'$T!("^"[BPP) EXIT^ECTPAS1 I (BPP'?.N)!(BPP<1)!(BPP>27) W !!,"You MUST answer with a number between 1 and 27." G BPP
 S:$L(BPP)=1 BPP="0"_BPP
BYR W ! S %DT="AE",%DT("A")="Enter calendar year associated with BEGINNING pay period: ",%DT(0)=2000000 D ^%DT G:$D(DTOUT)!("^"[X) EXIT^ECTPAS1 S BYR=$E(Y,1,3),BYRPP=BYR_BPP
EPP R !!,"Enter ENDING Pay Period: ",EPP:DTIME G:'$T!("^"[EPP) EXIT^ECTPAS1 I (EPP'?.N)!(EPP<1)!(EPP>27) W !!,"You MUST answer with a number between 1 and 27." G EPP
 S:$L(EPP)=1 EPP="0"_EPP
EYR W ! S %DT="AE",%DT("A")="Enter calendar year associated with ENDING pay period: ",%DT(0)=BYR_"0000" D ^%DT G:$D(DTOUT)!("^"[X) EXIT^ECTPAS1 S EYR=$E(Y,1,3),EYRPP=EYR_EPP
 I +BYRPP>+EYRPP W *7,!!?10,"ENDING pay period/date must be equal to",!?10,"or come after BEGINNING pay period/date!",!! K BPP,BYR,BYRPP,EPP,EYR,EYRPP G BPP
PP S FLG=0,YP=(BYRPP-1) F J=0:0 S YP=$O(^PRST(455,"B",YP)) Q:'YP  Q:YP>EYRPP  S FLG=1 Q:FLG=1
 I FLG=0 W *7,!!,"There is NO DATA in the file for the selected date range!",!! G EXIT^ECTPAS1
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G EXIT^ECTPAS1
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^ECTPAS0",ZTDESC="PAID Data for All Services" S ZTSAVE("SRVTL(")="" F G="BYRPP","BYR","BPP","EYRPP","EYR","EPP" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD K ZTSK G EXIT^ECTPAS1
 U IO G ^ECTPAS0
 ;
