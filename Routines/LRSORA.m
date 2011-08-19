LRSORA ;DRH/DALISC - HIGH/LOW VALUE REPORT ;2/19/91  11:42 ;
 ;;5.2;LAB SERVICE;**344,357,369**;Sep 27, 1994;Build 2
MAIN D INIT,GDT,GAA:'LREND,GLRT:'LREND,GLOG:'LREND,SORTBY^LRSORA1:'LREND
 D PATS^LRSORA1:'LREND,LOCS^LRSORA1:'LREND,GDV:'LREND,RUN:'LREND
 D STOP
 Q
RUN ;
 K ^TMP("LR",$J)
 S:$D(ZTQUEUED) ZTREQ="@" U IO
 S (LRPAG,LREND)=0,$P(LRDASH,"-",IOM)="-"
 K %DT S X=$P(LRSDT,"."),%DT="X" D ^%DT,DD^LRX S LRSDAT=Y
 K %DT S X=LREDT,%DT="X" D ^%DT,DD^LRX S LREDAT=Y
 S LRHDR2="For date range: "_LREDAT_" to "_LRSDAT
 D:'LREND START^LRSORA2
 D:$D(ZTQUEUED) STOP
 Q
STOP ;
 D STOP^LRSORA0
 Q
GAA ;
 D GAA^LRSORA0
 Q
GLRT ;
 W ! K LRTST S LRTST=1
 F I=0:0 D GTSC Q:'$D(LRTST(LRTST,1))  W ! S LRTST=LRTST+1
 K LRTST(LRTST) S LRTST=LRTST-1 Q
GTSC ;
 S LRA=1
 F I=0:0 D @$S(LRA=2:"SPEC",LRA=3:"CND",LRA=4:"GV",1:"TST") Q:LRA=0
 Q
TST ;
 K DIC S DIC="^LAB(60,",DIC(0)="AEMOQ"
 S DIC("S")="I $P(^(0),U,5)[""CH"",""BO""[$P(^(0),U,3)" D ^DIC
 S LRA=$S(Y>0:2,1:0)
 S:X["^" LREND=1
 I Y>0 S $P(LRTST(LRTST,3),"^",1)=$P($P(^LAB(60,+Y,0),U,5),";",2)
 I  S $P(LRTST(LRTST,2),"^",1)=$P(Y,"^",2)
 Q
SPEC ;
 S LRCNT=LRCNT+1
 K DIC S DIC="^LAB(61,",DIC(0)="AEMOQ"
 S DIC("A")="Select SPECIMEN/SITE: ANY// " D ^DIC
 S:Y<1 $P(LRTST(LRTST,3),"^",2)="",$P(LRTST(LRTST,2),"^",2)=""
 S LRA=$S(X["^":1,1:3)
 I Y>0 S $P(LRTST(LRTST,3),"^",2)=+Y,$P(LRTST(LRTST,2),"^",2)=$P(Y,"^",2)
 Q
CND ;
 W !,"Select CONDITION: " R X:DTIME S:'$T X="^"
 D @$S(X?1.N1":"1.N:"RNG",1:"GC") Q
RNG ;
 N Y
 S LRV=+$P(X,":",1),LRV2=+$P(X,":",2),LRA=0
 S:LRV>LRV2 X=LRV,LRV=LRV2,LRV2=X
 S $P(LRTST(LRTST,2),U,3)="BETWEEN "_LRV_" AND "_LRV2
 S X=$P(LRTST(LRTST,3),U,1)
 S Y="I $D(^("_X
 S Y=Y_")) S LRVX=$P(^("_X
 S Y=Y_"),U),LRVX=$S(LRVX?1A.E:LRVX,"
 S Y=Y_"""<>""[$E(LRVX):$E(LRVX,2,$L(LRVX)),1:LRVX)"
 S LRTST(LRTST,1)=Y_" I LRVX>"_LRV_",LRVX<"_LRV2
 D ASPC Q
GC ;
 S DIC="^DOPT(""DIS"",",DIC(0)="EMQZ",DIC("S")="I $L($P(^(0),U,2))"
 D ^DIC K DIC
 S LRA=$S(X["^":2,Y<0:3,1:4) D:X["?" HLP1 W:'$L(X) " ??" Q:Y<0
GV ;
 N LY,ALPHA,DEC,II,TT
 W !,"Enter VALUE: "
 R X:DTIME S:'$T X="^"
 S LRA=$S(X["^":3,"?"[X:4,1:0)
 W:X="" " ??" D:X["?" HLP2 Q:LRA
 S:"<>"[$P(Y(0),U,2) X=+X
 S $P(LRTST(LRTST,2),"^",3)=$P(Y(0),"^",1)_" "_X
 ;
 ; determine if entered value is alphanumeric
 S (ALPHA,DEC)=0
 F II=1:1 S TT=$E(X,II) Q:TT=""  D  Q:ALPHA
 . I TT?1N Q
 . I TT?1"." S DEC=DEC+1 S:DEC>1 ALPHA=1 Q
 . S ALPHA=1
 I X="""""" S ALPHA=0 ;ADDED FOR LR*5.2*357
 ;
 S LY="I $D(^("_$P(LRTST(LRTST,3),U)
 S LY=LY_")) S LRVX=$P(^("
 S LY=LY_$P(LRTST(LRTST,3),U)
 S LY=LY_"),U),LRVX=$S(LRVX?1A.E:LRVX,"
 S LY=LY_"""<>""[$E(LRVX):$E(LRVX,2,$L(LRVX)),1:LRVX) I LRVX"
 S LRTST(LRTST,1)=LY_$P(Y(0),U,2)_$S(ALPHA:""""_X_"""",1:X) D ASPC Q
ASPC ;
 S:$L($P(LRTST(LRTST,3),U,2)) LRTST(LRTST,1)=LRTST(LRTST,1)_",$P(^(0),U,5)="_$P(LRTST(LRTST,3),U,2) Q
INIT ;
 S LRCNT=0
 S U="^"
 S LREND=0
 S LRLONG=0
 S LRSDT="TODAY"
 S LREDT="T-1"
 S LRTW=.00001
 S:'$D(DTIME) DTIME=300
 W !,"SPECIAL REPORT - Search for high/low values" Q
GDT ;
 F W=0:0 D SDF,GSD Q:LREND  S LRSDT=Y D GED I Y>0 S LREDT=Y S:LREDT>LRSDT X=LREDT,LREDT=LRSDT,LRSDT=X D CXR W:Y'>0 !!,"No data for the year selected.",! Q:Y>0
 K %DT S X=$P(LRSDT,"."),%DT="X" D ^%DT,DD^LRX S LRSDAT=Y
 K %DT S X=$P(LREDT,"."),%DT="X" D ^%DT,DD^LRX S LREDAT=Y
 S LRHDR2="For date range: "_LREDAT_" to "_LRSDAT
 K LRSDAT,LREDAT,%DT Q
GSD ;
 S %DT("A")="Enter START date: ",%DT("B")=LRSDT,%DT="AET"
 D ^%DT S LREND=Y<1 Q
GED ;
 S %DT("A")="Enter END date: ",%DT("B")=LREDT D ^%DT Q
CXR ;
 S Y=$E(LREDT,1,3)_"0000" F I=0:0 S Y=$O(^LRO(69,Y)) Q:Y=""!($D(^LRO(69,+Y,1,"AN")))
 I Y>LREDT D DD^LRX W !,"The earliest date in the X-ref is ",Y,".  Long search required.",! D CXR1
 Q
CXR1 ;
 F I=0:0 S %=2 W "  OK to continue" D YN^DICN S:%=2!(%<0) LREND=1 S:%=1 LRLONG=1 Q:%  W !,"Enter 'YES' for the long search, 'NO' to exit.",!
 Q
SDF ;
 I LRSDT?1.7N S Y=LRSDT D DD^LRX S LRSDT=Y
 I LREDT?1.7N S Y=LREDT D DD^LRX S LREDT=Y
 Q
GLOG ;
 S:LRTST=1 LRTST(0)="A" D:LRTST>1 EN^LRSORA1 S:LRTST<1 LREND=1 Q
GDV ;
 S %ZIS="Q" D ^%ZIS K %ZIS I POP S LREND=1 Q
 I $D(IO("Q")) K IO("Q") S (LRQUE,LREND)=1,ZTRTN="RUN^LRSORA",ZTDESC="Lab Special Report",ZTSAVE("LR*")="" D ^%ZTLOAD
 Q
HLP1 ;
 W !,"A VALUE RANGE may also be entered (value:value).",!,"  For Example, 100:200 will search for values between 100 and 200.",!
 Q
HLP2 ;
 W !,"Enter a value for the comparison:  "
 W $P(LRTST(LRTST,2),U,1)," ",$P(Y(0),U,1)_" _____."
 Q
XX ;
WAIT K DIR S DIR(0)="E" D ^DIR S:($D(DUOUT))!($D(DTOUT)) LREND=1
 Q
