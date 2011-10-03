FHMADM3 ; HISC/REL/AAC - Additional Meals Report ;10/9/03  16:07
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Print Meal Report
 D DT G:"^"[X KIL
 ;
 ;Get Communication Offices data
 F K=1:1:22 S SS(K)=0,S(K)=0
 S CONUM="",ZCO="",COXX="",CO="",CONAME="",CONAM="",COUNT=0
 ;S ZZOUT=$G(^FH(119.73,0)),ZOUT=$P(ZZOUT,"^",4)
 S ZZCOUNT=0 F ZZCOUNT=0:0 S ZZCOUNT=$O(^FH(119.73,ZZCOUNT)) Q:ZZCOUNT'>0  S ZOUT=ZZCOUNT
 ;
 R !,"Print report for all Communications Offices Y or N: ",ZCO:DTIME W ! S ZCO=$TR(ZCO,"y","Y") I ZCO'="Y" D N2 G KIL Q
 ;
PRINT W !!,"The report requires a 132 column printer.",!
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHMADM3",FHLST="CONAME^CO^CONUMX^EDT^SDT^ZCO^COUNT^ZOUT^S(^SS(" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
 ;
Q1 ; Process Printing the Meal Report
 ;
 S DTP=SDT\1 D DTP^FH S DTE=DTP_" to " S DTP=EDT\1 D DTP^FH S DTE=DTE_DTP
 S X=SDT D DOW^%DTC S DOW=Y+1
 D NOW^%DTC S DTP=% D DTP^FH S HDT=DTP,PG=0
 ;
Q2 ;
 ;Get Specific Communication Offices
 I ZCO'="Y" S CONUMX=CONUMX-1 G:CONUMX=0 QUIT  S COXX=$P(CO,"^",CONUMX),NAME=$P(CONAME,"^",CONUMX) G:$D(^FH(119.73,COXX,"I")) Q2 G:'$D(^FH(119.73,COXX,0)) Q2
 I ZCO="Y" S COUNT=COUNT+1 G:COUNT>ZOUT QUIT  S NAME=$G(^FH(119.73,COUNT,0)),NAME=$P(NAME,"^") G:$D(^FH(119.73,COUNT,"I")) Q2 G:'$D(^FH(119.73,COUNT,0)) Q2
 ;W @IOF
 D HDR
 S DOW=Y+1 D Q3
 I ZCO'="Y" I CONUMX>0  G Q2
 I ZCO="Y" G Q2
 Q
 ;
QUIT ;
 ;W @IOF
 S NAME="Total All Communications Offices "
 D HDR
 D FTOTALS
 D LN,LN
 Q
 ;
Q3 F L1=19:1:22 S N(L1)=0
 S D1=SDT F L1=0:0 D N1 S X1=D1,X2=1 D C^%DTC  Q:X>EDT  S D1=X,DOW=DOW+1 S:DOW=8 DOW=1
 ;
TOTALS ;
 ;Print Totals
 F K=1:1:22 S Z=$S(K<19:5,1:6),S(K)=$S(S(K)<1:$J("",Z),S(K)<10000:$J(S(K),Z-1)_" ",1:$J(S(K),Z))
 ;
 D LN W !,"  Total",?10,"|",S(1),S(2),S(3),S(4),S(5),S(6),S(19)," |",S(7),S(8),S(9),S(10),S(11),S(12),S(20)," |",S(13),S(14),S(15),S(16),S(17),S(18),S(21)," |",S(22),!
 Q
 ;
FTOTALS ; Final Totals
 ;
 F K=1:1:22 S Z=$S(K<19:5,1:6),SS(K)=$S(SS(K)<1:$J("",Z),SS(K)<10000:$J(SS(K),Z-1)_" ",1:$J(SS(K),Z))
 ;
 W !,"ALL Total",?10,"|",SS(1),SS(2),SS(3),SS(4),SS(5),SS(6),SS(19)," |",SS(7),SS(8),SS(9),SS(10),SS(11),SS(12),SS(20)," |",SS(13),SS(14),SS(15),SS(16),SS(17),SS(18),SS(21)," |",SS(22),!
 Q
 ;
HDR ;Print page headers
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,HDT,?50,"A D D I T I O N A L   M E A L S",?125,"Page ",PG
 W !!,?1,NAME
 W !!?(131-$L(DTE)\2),DTE
 W !!,?10,"|",?21,"B R E A K F A S T",?48,"|",?64,"N O O N",?86,"|",?99,"E V E N I N G",?124,"| TOTAL"
 W !,?10,"| Opt. Emp. Paid OOD  Vol. Grt. Total | Opt. Emp. Paid OOD  Vol. Grt. Total | Opt. Emp. Paid OOD  Vol. Grt. Total |"
LN W !,"-----------------------------------------------------------------------------------------------------------------------------------"
 Q
 ;
N1 ;Get specific records based on Communications Offices,Start/End Dates, etc
 I ZCO'="Y" F CONUM=1:1  Q:CONUM>ZOUT  S Y0=$G(^FH(117,D1,2,CONUM,0)),Y2=$P(Y0,"^"),Y1=$P(Y0,"^",2,99)  Q:COXX=Y2
 ;
 I ZCO="Y" F CONUM=1:1  Q:CONUM>ZOUT  S Y0=$G(^FH(117,D1,2,CONUM,0)),Y2=$P(Y0,"^"),Y1=$P(Y0,"^",2,99)  Q:COUNT=Y2
 ;
 S K=0 F L1=1:1:6 F L2=1:1:3 S K=K+1,N=L2-1*6+L1,Z=$P(Y1,"^",K),N(N)=Z,N(18+L2)=N(18+L2)+Z
 S N(22)=N(19)+N(20)+N(21)
 ;
 F K=1:1:22 S S(K)=S(K)+N(K),SS(K)=SS(K)+N(K),N(K)=$J($S(N(K)<1:"",1:N(K)),$S(K<19:4,1:5))_" "
 ;
 S DTP=D1 D DTP^FH D:$Y>(IOSL-8) HDR
 W !,$P("Sun Mon Tue Wed Thu Fri Sat"," ",DOW)," ",$E(DTP,1,6)
 W "|",N(1),N(2),N(3),N(4),N(5),N(6),N(19)," |",N(7),N(8),N(9),N(10),N(11),N(12),N(20)," |",N(13),N(14),N(15),N(16),N(17),N(18),N(21)," |",N(22) Q
 ;
N2 ;Get Communciation Offices
 S DIC=119.73,DIC(0)="AEQ",DIC("A")="Select Communication Offices: "
 D ^DIC I (Y=-1)&(CO="") Q
 I Y=-1 G PRINT Q
 S CON=$P(Y,"^",1),CO=CON_"^"_CO,CONAM=$P(Y,"^",2),CONAME=CONAM_"^"_CONAME S CONUMX=$L(CO,"^") G N2 Q
 I Y=-1 K DIC Q
 ;
DT ; Get From/To Dates
D1 S %DT="AEPX",%DT("A")="Starting Date: " W ! D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D1 S SDT=+Y
 I SDT'<DT W *7,"  [Must Start before Today!] " G D1
 ;
D2 ;
 S %DT="AEPX",%DT("A")=" Ending Date: " D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D2 S EDT=+Y
 I EDT'<DT W *7,"  [Must End before Today!] " G D2
 I EDT<SDT W *7,"  [End before Start?] " G D1
 Q
 ;
KIL G KILL^XUSCLEAN Q
EXIT Q
