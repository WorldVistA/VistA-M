FHADM21 ; HISC/REL/NCA - Served Meals Report ;1/23/98  16:07
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Print Meals Report
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D ^FHMADM21 Q
 D NOW^%DTC S DT=%\1 D DT^FHADM2 G:"^"[X KIL
 W !!,"The report requires a 132 column printer.",!
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHADM21",FHLST="EDT^SDT" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 S DTP=SDT\1 D DTP^FH S DTE=DTP_" to " S DTP=EDT\1 D DTP^FH S DTE=DTE_DTP
 S X=SDT D DOW^%DTC S DOW=Y+1
 D NOW^%DTC S DTP=% D DTP^FH S HDT=DTP,PG=0 D HDR
 K S F K=1:1:21 S S(K)=0
 S D1=SDT,(ND,TD)=0 F L1=0:0 D N1 S X1=D1,X2=1 D C^%DTC Q:X>EDT  S D1=X,DOW=DOW+1 S:DOW=8 DOW=1
 F K=1:1:18 S N(K)=$J($S(ND:S(K)/ND,1:0),0,0),N(K)=$J($S(N(K)<1:"",1:N(K)),5)_" ",S(K)=$S(S(K)<1:$J("",6),S(K)<100000:$J(S(K),5)_" ",1:$J(S(K),6))
 F K=19:1:21 S N(K)=$J($S(TD:S(K)/TD,1:0),0,0),N(K)=$J($S(N(K)<1:"",1:N(K)),5)_" ",S(K)=$S(S(K)<1:$J("",6),S(K)<100000:$J(S(K),5)_" ",1:$J(S(K),6))
 D LN W !?4,"Total",?15,"|",S(1),S(2),S(3),"|",S(4),S(5),S(6),"|",S(7),S(8),S(9),"|",S(10),"|",S(11),S(13),S(16),"|",S(17),"|",S(18),"|",S(19),S(20),S(21),!
 W:ND ?4,"Avg. ",?15,"|",N(1),N(2),N(3),"|",N(4),N(5),N(6),"|",N(7),N(8),N(9),"|",N(10),"|",N(11),N(13),N(16),"|",N(17),"|",N(18),"|",N(19),N(20),N(21),!
 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,HDT,?44,"S E R V E D   M E A L S   W O R K S H E E T",?125,"Page ",PG
 W !!?(131-$L(DTE)\2),DTE
 W !!,?15,"|",?32,"MEALS SERVED ON INPATIENT BASIS",?79,"|",?82,"MEALS SERVED TO OTHERS",?105,"| TOTAL| SERVED TRAYS DATA"
 W !,?15,"|",?19,"DOMICILIARY",?34,"| NURSING HOME CU",?53,"|",?59,"HOSPITAL",?72,"| TOTAL|",?98,"| TOTAL| MEALS|"
 W !,?15,"|  Inp.  Abs.  Meal|  Inp.  Abs.  Meal|  Inp.  Abs.  Meal|      | Outp.  Paid Grat.|      |      |  Cafe   NPO Trays"
 W !,?15,"|   A     B     C  |   D     E     F  |   G     H     I  |   J  |   K     M    Q   |      |   R  |   T      U    V"
LN W ! F K=1:1:131 W "-"
 Q
N1 S Y0=$G(^FH(117,D1,0)),Y1=$G(^(1))
 K N S K=1 F L=1,2,4,5,7,8 S K=K+1,N(L)=$P(Y0,"^",K)
 S K=10 F L=1:3:16 S K=K+1,N(K)=$P(Y1,"^",L)+$P(Y1,"^",L+1)+$P(Y1,"^",L+2)
 S N(19)=$P(Y1,"^",19),N(20)=$P(Y1,"^",20)
 S N(3)=N(1)-N(2)*3,N(6)=N(4)-N(5)*3,N(9)=N(7)-N(8)*3,N(10)=N(3)+N(6)+N(9)
 S N(16)=N(14)+N(15)+N(16),N(13)=N(12)+N(13),N(17)=N(11)+N(13)+N(16),N(18)=N(10)+N(17),N(19)=N(19)+N(17),N(21)=N(18)-N(19)-N(20) S:N(18) ND=ND+1 S:N(20) TD=TD+1
 F K=1:1:21 S S(K)=S(K)+N(K)
 F K=1:1:21 S N(K)=$J($S(N(K)<1:"",1:N(K)),5)_" "
 S DTP=D1 D DTP^FH D:$Y>(IOSL-8) HDR
 W !,$P("Sun Mon Tue Wed Thu Fri Sat"," ",DOW)," ",DTP
 W ?15,"|",N(1),N(2),N(3),"|",N(4),N(5),N(6),"|",N(7),N(8),N(9),"|",N(10),"|",N(11),N(13),N(16),"|",N(17),"|",N(18),"|",N(19),N(20),N(21) Q
KIL ; Kill all used Variables
 G KILL^XUSCLEAN
