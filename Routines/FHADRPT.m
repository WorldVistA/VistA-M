FHADRPT ; HISC/NCA - Print Dietetic Annual Report ;1/23/98  16:05
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Get the Station Data for Printing
 D GET^FHADR1 G:Y<1 KIL
 S FHX1=+Y,LS=$E(DT,1,3) W !
Q0 K %DT S PRE="",FG=0,%DT="AEP",%DT("A")="Enter YR: "
 D ^%DT S:$D(DTOUT) X="^" G KIL:U[X,Q0:Y<1
 I $E(Y,1,3)>LS W *7,"  Do Not Enter Future Year." G Q0
 I $E(Y,4,7)>0 W *7,"  Enter Year Only." G Q0
 S Y=$E(Y,1,3)_"0000",PRE=Y,FG=1
 S QTR=$E(PRE,5),YR=$E(PRE,2,3)
L0 K IOP,%ZIS,ZTUCI,ZTRTN,ZTSAVE,ZTDESC
 W !!,"The report requires a 132 column printer.",!
 S %ZIS="QM",%ZIS("B")="",IOP="Q" W !! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) D  G KIL
 .S ZTRTN="TSK^FHADRPT",ZTREQ="@",ZTSAVE("ZTREQ")=""
 .S ZTSAVE("FG")="",ZTSAVE("FHX1")="",ZTSAVE("PRE")=""
 .S ZTSAVE("QTR")="",ZTSAVE("YR")=""
 .S ZTDESC="Print the Dietetic Annual Report"
 .D ^%ZTLOAD
 .Q
 E  D  G L0
 .D ^%ZISC
 .W !?5,"This is a very long and time consuming"
 .W !?5,"report, it must be queued to print.",*7
 .Q
 G KIL
TSK ; Tasking the Report
 U IO D Q1 D ^%ZISC K %ZIS,IOP,ZTSK G KIL
Q1 ; Display the Report
 S PG=0,LIN=IOSL-6
 S FHYR=$E(PRE,1,3) D NOW^%DTC S DTP=% D DTP^FH S HEAD=DTP
 D EN2^FHADR1A,EN2^FHADR3A,EN2^FHADR2,Q1^FHADR4,Q0^FHADR5,EN2^FHADR6
 D EN2^FHADR61,EN2^FHADR7,EN2^FHADR81,EN2^FHADR9A,EN2^FHADR10
 Q
Q2 ; Find the Starting Month and Ending Month of Each Quarter
 S (EDT,MTH,SDT)=""
 S MTH=$P("October^January January^April April^July July^October"," ",QTR)
 I MTH="" W *7," Error! Wrong Qtr" Q
L1 K %DT S X=$P(MTH,"^",1)_" "_(1700+$E(FHYR,1,3)) D ^%DT I QTR=1 S X1=+Y,X2=-365 D C^%DTC S X=$E(X,1,6)_"1" S SDT=+X G L2
 S SDT=Y+1
L2 I SDT>DT S SDT="" Q
 S X=$P(MTH,"^",2)_" "_(1700+$E(FHYR,1,3)) D ^%DT S X1=Y,X2=-1 D C^%DTC S EDT=X
 I EDT>DT S EDT="" Q
 S SDT=SDT\1,EDT=EDT\1
 Q
HDR ; Report Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !?13,HEAD,?50,"D I E T E T I C   R E P O R T",?116,"Page ",PG
 W !!?105 S Q1=$S(FG:"1 - 4",1:"") W Q1," Qtr   FY ",$E(FHYR,2,3) Q
KIL G KILL^XUSCLEAN
