YTPIT ;SLC/TGA-Print test/interview items ;11/15/90  17:06 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSPIT
 ;
 W @IOF,!!,"Print Test/Interview Items"
PIT ;
 R !!,"Instrument: ",YSTS:DTIME
 S YSTOUT='$T,YSUOUT=YSTS["^"
 G:YSTOUT!YSUOUT!(YSTS']"") FIN
 I YSTS["?" S YSTESTN="?",YSXT="",YSORD=DUZ D ^YTLIST K YSTESTN,YSXT G PIT
 S YSTEST=$O(^YTT(601,"B",YSTS,0))
 I 'YSTEST W $C(7)," [Not found]" G PIT
 ;
 ;  Don't print batteries!!!
 I $P($G(^YTT(601,+YSTEST,0)),U,9)="B" W "   Battery selection not allowed..." G PIT ;->
 ;
 S %ZIS="Q" D ^%ZIS G:POP FIN I $D(IO("Q")) S ZTRTN="ENP^YTPIT",(ZTSAVE("YSTS"),ZTSAVE("YSTEST"))="",ZTDESC="YS INST ITEM PRINT" D ^%ZTLOAD G FIN
ENP ;
 K Y D ENDTM^YSUTL S YSLFT=0,YSTNM=$P($P(^YTT(601,YSTEST,"P"),U),"---",2),P0=$S(IOST?1"P".E:1,1:0),P1=$S(P0:8,1:3)
 U IO W @IOF W !!?4,YSTNM,"   (",YSTS,")","   ",YSDT(1),! F I=1:1 Q:'$D(^YTT(601,YSTEST,"Q",I,"T"))  D
 .D CK:$Y+1+P1>IOSL Q:YSLFT  W !!,$J(I,4,0),?7,^YTT(601,YSTEST,"Q",I,"T",1,0)
 .F J=2:1 Q:'$D(^YTT(601,YSTEST,"Q",I,"T",J,0))  D CK:$Y+P1>IOSL Q:YSLFT  W !?7,^(0)
 W ! D KILL^%ZTLOAD,^%ZISC G FIN
CK ;
 D:'P0 WAIT^YSUTL Q:YSLFT  W @IOF W:P0 !!?4,YSTNM,"   (",YSTS,")","   ",YSDT(1),! Q
FIN ;
 K %ZIS,I,I0,IO("Q"),J,P0,P1,YSDTM,YSLFT,YSORD,YSTM,YSTNM,YSTEST,YSTS,ZTSK Q
