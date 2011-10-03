LRUTA ;AVAMC/REG - DISPLAY LAB TEST INFO FOR LAB ; 2/14/89  17:18 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 N N,LRCSREC
 S IOP="HOME" D ^%ZIS W @IOF
ASK S DIC="^LAB(60,",DIC(0)="AEMOQZ",DIC("S")="I $E($P(^(0),U,3),1)'[""N""" D ^DIC K DIC Q:X=""!(X[U)  S LRIFN=+Y
HDR W @IOF,"Lab test",?32,"Stat ok ?",?44,"Cost",?58,"Lab Test Synonym",!
 W $E($P(Y(0),U),1,30),?35,$S($P(Y(0),U,16)=1:"YES",1:"NO"),?42,$P(Y(0),U,11),?51,$E($P(Y(0),U,2),1,30)
 I $D(^LAB(60,LRIFN,2)) D PANEL R !!,"< Press ANY key to continue >",X:DTIME
 I $D(^LAB(60,LRIFN,1,0)),$P(^LAB(60,LRIFN,1,0),U,4)>0 D NORM
 I $D(^LAB(60,LRIFN,3,0)),$P(^LAB(60,LRIFN,3,0),U,4)>0 D LIST
 W !! G ASK
LIST S N=0
 F A=1:1 S N=$O(^LAB(60,LRIFN,3,N)) Q:'N  D
 . W:A=1 !!,"Collection Sample",?21,"VA Lab Slip",?37,"Container"
 . W ?68,"Vol Req(ml)"
 . S LRND=^LAB(60,LRIFN,3,N,0)
 . D SHOW
 Q
SHOW S LRCSREC=$G(^LAB(62,+LRND,0))
 W !,$S($L($P(LRCSREC,U)):$E($P(LRCSREC,U),1,20),1:"??")
 W ?21,$E($P(LRND,U,2),1,15),?37,$E($P(LRCSREC,U,3),1,30)
 W ?68,$E($P(LRND,U,4),1,12)
WRD S M=0 F B=1:1 S M=$O(^LAB(60,LRIFN,3,N,1,M)) Q:'M  W:B=1 !!,"Ward Instructions:" W !,^LAB(60,LRIFN,3,N,1,M,0)
LAB S M=0 F C=1:1 S M=$O(^LAB(60,LRIFN,3,N,2,M)) Q:'M  W:C=1 !!,"Lab Processing Instructions:" W !,^LAB(60,LRIFN,3,N,2,M,0)
 Q
NORM S N=0 F A=1:1 S N=$O(^LAB(60,LRIFN,1,N)) Q:'N  W:A=1 !!,"Reference Values",?22,"Ref Low",?30,"Ref High",?41,"Critical Low",?54,"Critical High",!,?22,"<---",?37,$P(^LAB(60,LRIFN,1,N,0),U,7),?63,"--->",! D LST
 Q
LST W !,$E($P(^LAB(61,N,0),U),1,19),?25,$P(^LAB(60,LRIFN,1,N,0),U,2),?32,$P(^(0),U,3),?48,$P(^(0),U,4),?60,$P(^(0),U,5)
 F X=0:0 S X=$O(^LAB(60,LRIFN,1,N,1,X)) Q:'X  W !,^(X,0)
 Q
PANEL W !,"Tests in panel:" S X=0 F A=1:1 S X=$O(^LAB(60,LRIFN,2,X)) Q:'X  S Y=+^(X,0) W:A#2 ! W:A#2=0 ?40 W $P(^LAB(60,Y,0),U,1)
 Q
