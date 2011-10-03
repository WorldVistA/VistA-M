PRSATPG ; HISC/REL-List Prior Exceptions ;8/22/95  13:42
 ;;4.0;PAID;;Sep 21, 1995
PAY ; Payroll Entry Point - All Exceptions
 R !!,"Select T&L Unit (or ALL): ",X:DTIME G:'$T!("^"[X) EX S X=$TR(X,"al","AL") I X="ALL" S TLE="" G L1
 K DIC S DIC="^PRST(455.5,",DIC(0)="EMQ" D ^DIC G EX:$D(DTOUT),PAY:Y<1
 S TLE=$P(Y,"^",2),PRSTLV=3 G L1
SUP ; Supervisor Entry Point
 S PRSTLV=3 D ^PRSAUTL G EX:TLI<1,L1
TK ; TimeKeeper Entry Point
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
L1 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSATPG",PRSALST="TLE" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Process List
 D NOW^%DTC S DT=%\1,(PG,QT)=0 D HDR I TLE'="" D Q2 G:QT EX D:$Y>3 H1 G EX
 S ATL="ATL00" F  S ATL=$O(^PRSPC(ATL)) Q:ATL=""  S TLE=$E(ATL,4,6) D Q2 G:QT EX
 D:$Y>3 H1 G EX
Q2 S NX="" F  S NX=$O(^PRSPC("ATL"_TLE,NX)) Q:NX=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NX,DFN)) Q:DFN<1  I $D(^PRST(458.5,"C",DFN)) D  G:QT Q3
 .F PDA=0:0 S PDA=$O(^PRST(458.5,"C",DFN,PDA)) Q:PDA<1  D CHK
 .Q:'$D(^PRST(458.5,"C",DFN))
 .S Y0=$G(^PRSPC(DFN,0)),EHDR=1
 .F PDA=0:0 S PDA=$O(^PRST(458.5,"C",DFN,PDA)) Q:PDA<1  D PRT Q:QT
 .Q
Q3 Q
CHK ; Check Exception
 S X=$G(^PRST(458.5,PDA,0)),PDTI=$P(X,"^",3) Q:'PDTI  Q:$P(X,"^",6)
 S Y=$G(^PRST(458,"AD",PDTI)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2) Q:'PPI
 S ESTR=$P(X,"^",5)_"^"_$P(X,"^",4)
 D ^PRSATPE I '$D(ER) S DA=PDA D REM^PRSATPF Q
 F K=0:0 S K=$O(ER(K)) Q:K<1  I ER(K)=ESTR K ER(K) G C1
 S DA=PDA D REM^PRSATPF
C1 F K=0:0 S K=$O(ER(K)) Q:K<1  S X1=PDTI,X2=ER(K) D ^PRSATPF
 Q
PRT ; List entries
 S X=$G(^PRST(458.5,PDA,0)),PDTI=$P(X,"^",3),TIM=$P(X,"^",4),TXT=$P(X,"^",5) Q:'PDTI  Q:$P(X,"^",6)
 I EHDR D EHDR S EHDR=0
 I $Y>(IOSL-6) D HDR Q:QT  D EHDR
 S X=PDTI D DTP^PRSAPPU W !?5,Y W:TIM'="" ?16,TIM W ?24,TXT Q
EHDR ; Employee Header
 W !!,$P(Y0,"^",1) W:$P(Y0,"^",8)'="" " (",$P(Y0,"^",8),")" Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?26,"PRIOR PAY PERIOD EXCEPTIONS"
 S X=DT D DTP^PRSAPPU W !?35,Y Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
