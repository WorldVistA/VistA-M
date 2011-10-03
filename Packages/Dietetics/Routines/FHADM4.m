FHADM4 ; HISC/REL/NCA - Staffing Data Report ;1/23/98  16:08
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Staffing Data
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D EN1^FHMADM4 Q
 D NOW^%DTC S DT=%\1
E1 S %DT="AEPX",%DT("A")="STAFFING DATA Date: " W ! D ^%DT G KIL:"^"[X!$D(DTOUT),E1:Y<1
 S DA=+Y I DA>DT W *7,!!,"** Date must not be in the future!",! G E1
 K DIC,DIE S DIE="^FH(117.1," I '$D(^FH(117.1,DA,0)) S ^FH(117.1,DA,0)=DA,^FH(117.1,"B",DA,DA)="",X0=^FH(117.1,0),$P(^FH(117.1,0),"^",3,4)=DA_"^"_($P(X0,"^",4)+1)
 S X1=DA,X2=-1 D C^%DTC S DM1=X,FHX1=$P($G(^FH(117.1,DM1,0)),"^",2,6)
 S DR="[FHADM4]" D ^DIE G EN1
EN2 ; Print Staffing Data Report
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D EN2^FHMADM4 Q
 D DT^FHADM2 G:"^"[X KIL
 W !!,"The report requires a 132 column printer.",!
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHADM4",FHLST="EDT^SDT" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Process Printing Staffing Report
 S DTP=SDT\1 D DTP^FH S DTE=DTP_" to " S DTP=EDT\1 D DTP^FH S DTE=DTE_DTP
 S X=SDT D DOW^%DTC S DOW=Y+1
 D NOW^%DTC S DTP=% D DTP^FH S HDT=DTP,PG=0 D HDR
 K S,AV F K=1:1:23 S S(K)=0
 S SIZ="61 51 51 51 51 50 30 30 30 30 30 30 30 30 30 30 30 30 30 51 50 50 50"
 S D1=SDT,(ND,FHTOT,TO1,TOT)=0 F L1=0:0 D N1 S X1=D1,X2=1 D C^%DTC Q:X>EDT  S D1=X,DOW=DOW+1 S:DOW=8 DOW=1
 D LN G:ND>62 Q2
 W !?7,"Total",?15 F K=1:1:5,20,21,6:1:10,22,11:1:19,23 S X=$P(SIZ," ",K) W $J(S(K),$E(X,1)+1,$E(X,2))
Q2 I ND W !?7,"Avg.",?15 F K=1:1:5,20,21,6:1:10,22,11:1:19,23 S X=$P(SIZ," ",K) W $J(S(K)/ND,$E(X,1)+1,$E(X,2))
 I S(22) W !?7,"% Paid",?68 F K=8,9,10,22,11:1:19,23 S X=$P(SIZ," ",K) W $J(S(K)/S(22)*100,$E(X,1)+1,0)
 I TOT W !!?7,"Adjustment for Unscheduled and Intermittent",!!?7,"UNS/INT Total " S TOT=TOT/8 W $J(TOT,5,1)," FTEE",!?7,"Adjusted Measured FTEE " S TOT=TOT+TO1 W $J(TOT,6,1) I ND W !?7,"Avg Measured FTEE       ",$J(TOT/ND,5,1)
 I FHTOT S MAN=S(22)*60 W !!?7,"Man Minutes/Meal:    ",$J(MAN/FHTOT,0,0)
 W ! Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?4,HDT,?44,"S T A F F I N G   D A T A   W O R K S H E E T",?122,"Page ",PG
 W !!?(132-$L(DTE)\2),DTE
 W !!?15,"| DAILY| CLIN|ADMIN| SUPP| SUPV| MEAS| POT | OFF |WOP| OT|UNS|INT| PAID|COP| AL| SL|OTH|LND|CMP|TRN|VOL|BOR|TOTAL"
 W !?15,"|  FTEE| FTEE| FTEE| FTEE| FTEE| FTEE| HRS | HRS |HRS|HRS|HRS|HRS| HRS |HRS|HRS|HRS|HRS|HRS|HRS|HRS|HRS|HRS| HRS"
LN W !?4,"----------------------------------------------------------------------------------------------------------------------------" Q
N1 S Y0=$G(^FH(117.1,D1,0)),ND=ND+1
 S DTP=D1 D DTP^FH D:$Y>(IOSL-8) HDR
 K N F L=2:1:20 S N(L-1)=$P(Y0,"^",L)
 S N(20)=N(1)-N(2)-N(3)-N(4)-N(5),N(21)=N(20)*8
 S N(22)=N(21)-N(6)-N(7)+N(8)+N(9)+N(10),N(23)=N(22)-N(11)-N(12)-N(13)-N(14)-N(15)+N(16)+N(17)+N(18)+N(19),TOT=TOT+N(9)+N(10),TO1=TO1+N(20)
 W !?4,$P("Sun Mon Tue Wed Thu Fri Sat"," ",DOW)," ",$E(DTP,1,6)," "
 F K=1:1:5,20,21,6:1:10,22,11:1:19,23 S S(K)=S(K)+N(K),X=$P(SIZ," ",K),N(K)=$S('N(K):$J("",$E(X,1)),1:$J(N(K),$E(X,1),$E(X,2))) W "|",N(K)
 D M1
 Q
M1 ; Get total Meals
 S Y1=$G(^FH(117,D1,0)) Q:Y1=""  S Y2=$G(^FH(117,D1,1))
 K M S K=1 F L=1,2,4,5,7,8 S K=K+1,M(L)=$P(Y1,"^",K)
 S K=10 F L=1:3:16 S K=K+1,M(K)=$P(Y2,"^",L)+$P(Y2,"^",L+1)+$P(Y2,"^",L+2)
 S M(3)=M(1)-M(2)*3,M(6)=M(4)-M(5)*3,M(9)=M(7)-M(8)*3
 S M(10)=M(3)+M(6)+M(9)
 S M(16)=M(14)+M(15)+M(16),M(13)=M(12)+M(13),M(17)=M(11)+M(13)+M(16),M(18)=M(10)+M(17)
 S FHTOT=FHTOT+M(18) Q
KIL G KILL^XUSCLEAN
