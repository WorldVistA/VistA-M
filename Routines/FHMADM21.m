FHMADM21 ; HISC/AAC - Multidivisional Served Meals Report ;10/9/03  16:07
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 ;This program is being modified for Multidivisional Reports
 ;Project ID 4QNFR03 - 2003
 ;
EN2 ; Print Meals Report
 ;
 D NOW^%DTC S DT=%\1 D DT^FHMADM2 G:"^"[X KIL
 ;
 ;Declare variables,determine total # of comm offices - alc 02-26-03
 ;
 S CONAME="",CO="",ZCO="",L=0,CONUM="",CONUMZ="",COUNT=0,COX="",COXX="",Y00=""
 ;S ZZOUT=$G(^FH(119.73,0)),ZOUT=$P(ZZOUT,"^",4)
 S ZZCOUNT=0 F ZZCOUNT=0:0 S ZZCOUNT=$O(^FH(119.73,ZZCOUNT)) Q:ZZCOUNT'>0  S ZOUT=ZZCOUNT
 F K=1:1:21 S S(K)="",SS(K)="",NN(K)=0
 ;
 R !,"Print report for all Communications Offices Y or N: ",ZCO:DTIME W ! S ZCO=$TR(ZCO,"y","Y") I ZCO="Y" G PRINT
 ;
EN3 ;Enter/Edit data - alc 02-26-03
 ;
 S DIC=119.73,DIC(0)="AEQ"
 D ^DIC I (Y=-1)&(CO="") G KIL Q
 I (Y=-1) G PRINT Q
 S CON=$P(Y,"^",1),CO=CON_"^"_CO,CONAM=$P(Y,"^",2),CONAME=CONAM_"^"_CONAME G EN3
 I Y=-1 K DIC Q     ;quit if lookup fails
 ;
PRINT W !!,"The report requires a 132 column printer.",!
 S NAMENO=$L(CONAME,"^"),CONUMX=$L(CO,"^")
 I ZCO="Y" S CONUMZ=$G(^FH(119.73,0)),CONUMZ=$P(CONUMZ,"^",4)
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHMADM21",FHLST="EDT^SDT^ZCO^CONUMX^CO^CONAM^CONAME^COUNT^CONUMZ^ZOUT^S(^SS(" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
 ;
Q1 S DTP=SDT\1 D DTP^FH S DTE=DTP_" to " S DTP=EDT\1 D DTP^FH S DTE=DTE_DTP
 S X=SDT D DOW^%DTC S DOW=Y+1
 D NOW^%DTC S DTP=% D DTP^FH S HDT=DTP,PG=0
 ;
Q2 ;Drivers for individual Comm Off report - alc 02-26-03
 ;
 I ZCO'="Y" S CONUMX=CONUMX-1 G:CONUMX=0 QUIT  S COXX=$P(CO,"^",CONUMX),NAME=$P(CONAME,"^",CONUMX) G:$D(^FH(119.73,COXX,"I")) Q2 G:'$D(^FH(119.73,COXX,0)) Q2
 I ZCO="Y" S COUNT=COUNT+1 G:COUNT>ZOUT QUIT  S NAME=$G(^FH(119.73,COUNT,0)),NAME=$P(NAME,"^") G:$D(^FH(119.73,COUNT,"I")) Q2 G:'$D(^FH(119.73,COUNT,0)) Q2
 ;W @IOF
 D HDR
 S DOW=Y+1 D Q3
 I CONUMX>0  G Q2
 Q
 ;
QUIT ;Drivers for report final totals/average - alc 02-26-03
 ;
 ;W @IOF
 S NAME="Total All Communications Offices "
 D HDR
 ;
 F K=1:1:18 S NN(K)=$J($S(NDX:SS(K)/NDX,1:0),0,0),NN(K)=$J($S(NN(K)<1:"",1:NN(K)),5)_" ",SS(K)=$S(SS(K)<1:$J("",6),SS(K)<100000:$J(SS(K),5)_" ",1:$J(SS(K),6))
 F K=19:1:21 S NN(K)=$J($S(NDX:SS(K)/NDX,1:0),0,0),NN(K)=$J($S(NN(K)<1:"",1:NN(K)),5)_" ",SS(K)=$S(SS(K)<1:$J("",6),SS(K)<100000:$J(SS(K),5)_" ",1:$J(SS(K),6))
 ;BREAK
 D FTOTALS
 Q
 ;
Q3 ;Looping thru dates/comm off load data buckets - alc 02-26-03
 ;
 S D1=SDT,(ND,TD,NDX,TDX)=0 F L1=0:0 D N1 S X1=D1,X2=1 D C^%DTC Q:(X>EDT)  S D1=X,DOW=DOW+1 S:DOW=8 DOW=1
 ;
 F K=1:1:18 S N(K)=$J($S(ND:S(K)/ND,1:0),0,0),N(K)=$J($S(N(K)<1:"",1:N(K)),5)_" ",S(K)=$S(S(K)<1:$J("",6),S(K)<100000:$J(S(K),5)_" ",1:$J(S(K),6))
 ;
 F K=19:1:21 S N(K)=$J($S(TD:S(K)/TD,1:0),0,0),N(K)=$J($S(N(K)<1:"",1:N(K)),5)_" ",S(K)=$S(S(K)<1:$J("",6),S(K)<100000:$J(S(K),5)_" ",1:$J(S(K),6))
 ;
 ;Print daily totals - alc 02-26-03
 ;
 D LN W !?4,"Total",?15,"|",S(1),S(2),S(3),"|",S(4),S(5),S(6),"|",S(7),S(8),S(9),"|",S(10),"|",S(11),S(13),S(16),"|",S(17),"|",S(18),"|",S(19),S(20),S(21),!
 ;
 W:ND ?4,"Avg. ",?15,"|",N(1),N(2),N(3),"|",N(4),N(5),N(6),"|",N(7),N(8),N(9),"|",N(10),"|",N(11),N(13),N(16),"|",N(17),"|",N(18),"|",N(19),N(20),N(21),!
 ;
 Q
 ;
FTOTALS ;PRINT FINAL TOTALS - alc 02-26-03
 ;
 D LN W !?4,"ALL Total",?15,"|",SS(1),SS(2),SS(3),"|",SS(4),SS(5),SS(6),"|",SS(7),SS(8),SS(9),"|",SS(10),"|",SS(11),SS(13),SS(16),"|",SS(17),"|",SS(18),"|",SS(19),SS(20),SS(21),!
 ;
 W:ND ?4,"Avg. ",?15,"|",NN(1),NN(2),NN(3),"|",NN(4),NN(5),NN(6),"|",NN(7),NN(8),NN(9),"|",NN(10),"|",NN(11),NN(13),NN(16),"|",NN(17),"|",NN(18),"|",NN(19),NN(20),NN(21),!
 ;
 Q
 ;
HDR ;Print report headings - alc 02-26-03
 ;
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,HDT,?44,"S E R V E D   M E A L S   W O R K S H E E T",?123,"Page ",PG
 ;
 ;S NAMENO=NAMENO-1,NAME=$P(CONAME,"^",NAMENO) 
 W !!,?1,NAME
 ;
 W ?(131-$L(DTE)\2),DTE
 W !!,?15,"|",?32,"MEALS SERVED ON INPATIENT BASIS",?79,"|",?82,"MEALS SERVED TO OTHERS",?105,"| TOTAL| SERVED TRAYS DATA"
 W !,?15,"|",?19,"DOMICILIARY",?34,"| NURSING HOME CU",?53,"|",?59,"HOSPITAL",?72,"| TOTAL|",?98,"| TOTAL| MEALS|"
 W !,?15,"|  Inp.  Abs.  Meal|  Inp.  Abs.  Meal|  Inp.  Abs.  Meal|      | Outp.  Paid Grat.|      |      |  Cafe   NPO Trays"
 W !,?15,"|   A     B     C  |   D     E     F  |   G     H     I  |   J  |   K     M    Q   |      |   R  |   T      U    V"
LN W ! F K=1:1:131 W "-"
 Q
 ;
N1 ;Get data from approp date/comm office globals - alc 02-26-03
 ;
 I ZCO="Y" F CONUM=1:1  Q:CONUM>ZOUT  S Y0=$G(^FH(117,D1,2,CONUM,0)),Y2=$P(Y0,"^"),Y1=($P(Y0,"^",2,99)),Y00=$G(^FH(117,D1,2,CONUM,1)),Y11=($P(Y00,"^",1,99))  Q:COUNT=Y2 
 ;
N2 I ZCO'="Y" F CONUM=1:1  Q:CONUM>ZOUT  S Y0=$G(^FH(117,D1,2,CONUM,0)),Y2=$P(Y0,"^"),Y1=($P(Y0,"^",2,99)),Y00=$G(^FH(117,D1,2,CONUM,1)),Y11=($P(Y00,"^",1,99))  Q:COXX=Y2
 ;
 K N S K=0 F L=1,2,4,5,7,8 S K=K+1,N(L)=$P(Y11,"^",K)
 S K=10 F L=1:3:16 S K=K+1,N(K)=$P(Y1,"^",L)+$P(Y1,"^",L+1)+$P(Y1,"^",L+2)
 ;
 ;Calcs - alc 02-26-03
 ;
 S N(19)=$P(Y1,"^",19),N(20)=$P(Y1,"^",20)
 S N(3)=N(1)-N(2)*3,N(6)=N(4)-N(5)*3,N(9)=N(7)-N(8)*3,N(10)=N(3)+N(6)+N(9)
 ;
 ;
 S N(16)=N(14)+N(15)+N(16),N(13)=N(12)+N(13),N(17)=N(11)+N(13)+N(16),N(18)=N(10)+N(17),N(19)=N(19)+N(17),N(21)=N(18)-N(19)-N(20) S:N(18) (ND,NDX)=ND+1 S:N(20) (TD,TDX)=TD+1
 ;
 ;Summarizing detail report data into totals - alc 02-26-03
 ;
 F K=1:1:21 S S(K)=S(K)+N(K),SS(K)=SS(K)+N(K)
 ;
 F K=1:1:21 S N(K)=$J($S(N(K)<1:"",1:N(K)),5)_" "
 ;
 ;Prints detail line by date - alc 02-26-03
 ;
 S DTP=D1 D DTP^FH D:$Y>(IOSL-8) HDR
 W !,$P("Sun Mon Tue Wed Thu Fri Sat"," ",DOW)," ",DTP
 W ?15,"|",N(1),N(2),N(3),"|",N(4),N(5),N(6),"|",N(7),N(8),N(9),"|",N(10),"|",N(11),N(13),N(16),"|",N(17),"|",N(18),"|",N(19),N(20),N(21)  Q
KIL ; Kill all used Variables
 G KILL^XUSCLEAN
