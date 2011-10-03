PRSADP ; HISC/REL-Display Posting Date ;3/18/94  08:54
 ;;4.0;PAID;;Sep 21, 1995
TK ; Timekeeper - Display Single Day
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX S %DT="X",X="T+3" D ^%DT
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT("B")="T-1",%DT(0)=-Y W ! D ^%DT
 G:Y<1 EX S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I PPI="" W !!,*7,"Pay Period is Not Open Yet!" G EX
 S PPE=$P($G(^PRST(458,PPI,0)),"^",1),DTE=$P($G(^PRST(458,PPI,2)),"^",DAY)
NME K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE,$D(^PRST(458,PPI,""E"",+Y))",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 G:DFN<1 EX
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSADP",PRSALST="DFN^PPI^PPE^DAY^DTE" D QUE^PRSAUTL G NME
 U IO D Q1 D ^%ZISC K %ZIS,IOP G NME
Q1 D ^PRSADP1
 I $E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
