LROW2 ;SLC/CJS - TEST & SAMPLE VERIFICATION ;8/11/97
 ;;5.2;LAB SERVICE;**121,290**;Sep 27, 1994
COL S $P(^LRO(69,LRODT,1,LRSN,0),U,2)=DUZ Q
REST ;from LRFAST, LROE1, LROW
 I '$D(LRNCWL),'$D(LRORDER) K %ZIS S IOP="P",%ZIS="N" D ^%ZIS K %ZIS,IOP S:'POP LRORDER=ION I POP S %ZIS="NQ",%ZIS("A")="ORDER COPY DEVICE:" D ^%ZIS S:'POP LRORDER=ION I POP S IOP="HOME" D ^%ZIS
 S LRLLOC=$P(LRSNO,U,7),LRSSP=-1
 I $D(LRADDTST) S LRORD=+LRADDTST,LRADDTST="" G PAST
 D ORDER
PAST S J=0 D CHECK:$D(LRADDTST) G BAD:J K LRXS S LRCS=0 F J=0:0 S LRCS=$O(LRXST(LRCS)) Q:LRCS<1  S T=0 F  S T=$O(LRXST(LRCS,T)) Q:T<1  S LRXS(LRCS,LRXST(LRCS,T),T)=""
 S LRSSP=0 F  S LRSSP=$O(LRXS(LRSSP)) Q:LRSSP<1  S LRSPEC=0 F  S LRSPEC=$O(LRXS(LRSSP,LRSPEC)) Q:LRSPEC<1  D DUP^LROW2A
 W:$E(IOST,1,2)="P-" @IOF D ^%ZISC
 Q
ORDER ;from LRMIBL, LROE1, LRORD1, LRQCLOG
 N LRYR
 S LRYR=$E(DT,1,3)_"0000" I '$D(^LRO(69,LRYR,2)) S ^LRO(69,LRYR,0)=LRYR,^(2)=0,^LRO(69,"B",LRYR,LRYR)="" ;HAPPY NEW YEAR!
NEXT L +^LRO(69,LRYR,2) S LRORD=1+^LRO(69,LRYR,2) F  Q:'$D(^LRO(69,"C",LRORD))  S LRORD=LRORD+1
 S ^LRO(69,LRYR,2)=LRORD L -^LRO(69,LRYR,2)
 S J=0 D CHECK G NEXT:J
 Q:$G(LRQUIET)
 W:'$D(ZTQUEUED) !,"LAB Order number: ",LRORD
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CHECK ;from LROE1
 S D=0 F  S D=$O(^LRO(69,"C",LRORD,D)) Q:D<1  D C2
 Q
C2 S S=0 F  S S=$O(^LRO(69,"C",LRORD,D,S)) Q:S<1  I $D(^LRO(69,D,1,S,0)),LRDFN'=+^(0) S J=1 Q
 Q
BAD ;from LROE1
 W !,"The ORDER NUMBER is in use, contact the site manager.",$C(7),!,"This order has been CANCELED, you will need to re-order.",! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
DUPL ;from LROW1
 S LREND=1 W !,"Since this test, collection sample, and site/specimen has already",!,"been requested on this order, it will NOT be duplicated.",$C(7),!,"If you really need a duplicate, place a separate order."
 Q
TCOM ;from LROW1
 S LRCCOM="~For Test: "_$P(^LAB(60,+LRTEST(LRTSTN),0),U)_"   "_$P(^LAB(62,LRSAMP,0),U) S:$P(^(0),U)'=$P(^LAB(61,LRSPEC,0),U) LRCCOM=LRCCOM_"   "_$P(^LAB(61,LRSPEC,0),U) W !,LRCCOM
 D RCS^LRORD2 Q
% R %:DTIME S:'$T DTOUT=1 Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
OR ;OE/RR 2.5
 Q  ;Following logic not required - 2.5 is obsolete version
 S LRORIFN=$P(LRTEST(LRI),"^",7) I 'LRORIFN D SET^LROR S $P(LRTEST(LRI),"^",7)=LRORIFN Q
 S ORIFN=LRORIFN,ORETURN("ORPK")=LRODT_"^"_LRSN_"^"_LRTN D RETURN^ORX:ORIFN
 Q
