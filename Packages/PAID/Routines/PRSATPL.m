PRSATPL ; HISC/REL-Daily T&L Listing ;3/23/94  09:38
 ;;4.0;PAID;;Sep 21, 1995
TK ; Timekeeper Entry
 S PRSTLV=2 G TL
PAY ; Payroll Entry
 S PRSTLV=7 G TL
TL D ^PRSAUTL G:TLI<1 EX S %DT="X",X="T+3" D ^%DT
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT("B")="T-1",%DT(0)=-Y W ! D ^%DT
 G:Y<1 EX S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I PPI="" W !!,*7,"Pay Period is Not Open Yet!" G EX
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSATPL",PRSALST="TLE^PPI^DAY" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Process
 S PPE=$P($G(^PRST(458,PPI,0)),"^",1),DTE=$P($G(^PRST(458,PPI,2)),"^",DAY),DTI=$P($G(^(1)),"^",DAY)
 S (QT,PG)=0 D HDR
 S NN="" F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  I $D(^PRST(458,PPI,"E",DFN,0)) D CHK I QT G EX
 D H1 G EX
CHK ; List Employee Day
 D:$Y>(IOSL-5) HDR Q:QT
 K Y1,Y2 S Y1=$G(^PRST(458,PPI,"E",DFN,"D",DAY,1)),Y2=$G(^(2)),Y3=$G(^(3)),Y4=$G(^(4)),TC=$P($G(^(0)),"^",2)
 I Y1="" S Y1=$S(TC=1:"Day Off",TC=2:"Day Tour",TC=3!(TC=4):"Intermittent",1:"NO TOUR ENTERED")
 I " 1 3 4 "'[TC,$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,10)),"^",1)="" S Y2(1)="Unposted"
 I TC=3,$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,10)),"^",4)=1 S Y2(1)="Day Worked"
 W !!,$E($P($G(^PRSPC(DFN,0)),"^",1),1,25) S (L3,L4)=0 I Y1="",Y2="" Q
 D S1
 F K=1:1 Q:'$D(Y1(K))&'$D(Y2(K))  W:K>1 ! W:$D(Y1(K)) ?27,Y1(K) W:$D(Y2(K)) ?52,$P(Y2(K),"^",1),?69,$P(Y2(K),"^",2)
 W:Y3'="" !?10,Y3 Q
S1 ; Set Schedule Array
 F L1=1:3:19 S A1=$P(Y1,"^",L1) Q:A1=""  S L3=L3+1,Y1(L3)=A1 S:$P(Y1,"^",L1+1)'="" Y1(L3)=Y1(L3)_"-"_$P(Y1,"^",L1+1) I $P(Y1,"^",L1+2)'="" S L3=L3+1,Y1(L3)="  "_$P($G(^PRST(457.2,+$P(Y1,"^",L1+2),0)),"^",1)
 G:Y4="" S2
 F L1=1:3:19 S A1=$P(Y4,"^",L1) Q:A1=""  S L3=L3+1,Y1(L3)=A1 S:$P(Y4,"^",L1+1)'="" Y1(L3)=Y1(L3)_"-"_$P(Y4,"^",L1+1) I $P(Y4,"^",L1+2)'="" S L3=L3+1,Y1(L3)="  "_$P($G(^PRST(457.2,+$P(Y4,"^",L1+2),0)),"^",1)
S2 ; Set Worked Array
 F L1=1:4:25 D  I A1="" G S3
 .S A1=$P(Y2,"^",L1+2) Q:A1=""  S L4=L4+1
 .S A2=$P(Y2,"^",L1) I A2'="" S Y2(L4)=A2_"-"_$P(Y2,"^",L1+1)
 .S K=$O(^PRST(457.3,"B",A1,0)) S $P(Y2(L4),"^",2)=A1_" "_$P($G(^PRST(457.3,+K,0)),"^",2)
 .I $P(Y2,"^",L1+3)'="" S L4=L4+1,Y2(L4)="  "_$P($G(^PRST(457.4,+$P(Y2,"^",L1+3),0)),"^",1)
 .Q
S3 Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?27,DTE," for T&L ",TLE
 W !!,"Employee",?27,"Scheduled Tour",?52,"Tour Exceptions"
 W !,"------------------------------------------------------------------------------"
 Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
