LRACP ;SLC/DCM - CUMULATIVE PURGE ;2/19/91  10:17 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
QUEUE S U="^"
 W !,"This option uses the number of days entered in the GRACE PERIOD FOR CUMULATIVE",!,"field in the LABORATORY SITE file to identify and purge patient lab data from",!,"the cumulative file.",!
 W !?10,"The file is set for ( ",+$P(^LAB(69.9,1,0),U,12)," ) days ",!
 W !,"Are you sure you want to continue" S %=2 D YN^DICN I %=2!(%=-1) Q
 S ZTRTN="ENT^LRACP",ZTDESC="Cumulative Purge",ZTIO="" D ^%ZTLOAD Q
MORE I '$D(^LR(LRDFN,0)) K ^LAC("LRAC",LRDFN) Q
 S X=^LR(LRDFN,0),LRDPF=$P(X,U,2),DFN=$P(X,U,3) Q:$O(^LR(LRDFN,"CH",0))<LRDAYS
 I LRDPF=2 D PT^LRX Q:$L(LRWRD)
 K ^LAC("LRAC",LRDFN),^LAC("LRAC","B",LRDFN)
 Q
IDT S LRDFN=0 F  S LRDFN=$O(^LAC("LRAC",LRDFN)) Q:LRDFN<1  D MORE
 Q
ENT ;
 S U="^" S:$D(ZTQUEUED) ZTREQ="@"
 G:'$P(^LAB(69.9,1,0),U,12) CLEAN S X1=DT,X2=-$P(^(0),"^",12) D C^%DTC S LRDAYS=9999999-X_.5,LRXLR="LRAC"
 D IDT
CLEAN ;
 K LRDAYS,LRDFN,LRDPF,DFN
 Q
