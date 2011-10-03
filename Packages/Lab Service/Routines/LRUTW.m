LRUTW ;AVAMC/REG - DISPLAY LAB TEST INFO FOR LAB ; 2/14/89  17:19 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 N N,LRCSREC,AGE,SEX
 S AGE="??",SEX="M",IOP="HOME" D ^%ZIS W @IOF
ASK S DIC="^LAB(60,",DIC(0)="AEMOQZ",DIC("S")="I $E($P(^(0),U,3),1)'[""N""" D ^DIC K DIC G:X=""!(X[U)!(Y<0) END S LRIFN=+Y
 D HDR I $D(^LAB(60,LRIFN,5)),$P(^(5,0),U,4) W !,"Synonym: " F X=0:0 S X=$O(^LAB(60,LRIFN,5,X)) Q:'X  D:$Y>21 SYN W !?5,$P(^LAB(60,LRIFN,5,X,0),U,1)
 I $D(^LAB(60,LRIFN,2)),$P(^(2,0),U,4) W !,"Tests in panel:" F X=0:0 S X=$O(^LAB(60,LRIFN,2,X)) Q:'X  D:$Y>21 PANEL W !?5,$P(^LAB(60,+^LAB(60,LRIFN,2,X,0),0),U,1)
 I $D(^LAB(60,LRIFN,1,0)),$P(^LAB(60,LRIFN,1,0),U,4)>0 D NORM
 I $D(^LAB(60,LRIFN,6)),$P(^(6,0),U,4) W !,"General Ward Instructions:" F M=0:0 S M=$O(^LAB(60,LRIFN,6,M)) Q:'M  D:$Y>21 WARD W !,^LAB(60,LRIFN,6,M,0)
 I $D(^LAB(60,LRIFN,3,0)),$P(^LAB(60,LRIFN,3,0),U,4)>0 D LIST
 W !! G ASK
LIST I $D(^LAB(60,LRIFN,3)),$P(^(3,0),U,4) D COL S N=0 F A=1:1 S N=$O(^LAB(60,LRIFN,3,N)) Q:'N  D:$Y>21 COLL S LRND=^LAB(60,LRIFN,3,N,0) D SHOW
 Q
SHOW S LRCSREC=$G(^LAB(62,+LRND,0))
 W:A>1 ! W !,$S($L($P(LRCSREC,U)):$E($P(LRCSREC,U),1,20),1:"??")
 W ?21,$E($P(LRND,U,2),1,15),?37,$E($P(LRCSREC,U,3),1,30)
 W ?68,$E($P(LRND,U,4),1,12)
 Q:'$D(^LAB(60,LRIFN,3,N,1,0))
 I $D(^LAB(60,LRIFN,3)),$P(^(3,0),U,4) W !,"Ward Instructions:" S M=0 F B=1:1 S M=$O(^LAB(60,LRIFN,3,N,1,M)) Q:'M  D:$Y>21 WARD W !,^LAB(60,LRIFN,3,N,1,M,0)
LAB ;S M=0 F C=1:1 S M=$O(^LAB(60,LRIFN,3,N,2,M)) Q:'M  W:C=1 !!,"Lab Processing Instructions:" W !,^LAB(60,LRIFN,3,N,2,M,0)
 Q
NORM S N=0 F A=1:1 S N=$O(^LAB(60,LRIFN,1,N)) Q:'N  W:A=1 !!,"Reference Values",?22,"Ref Low",?30,"Ref High",?41,"Critical Low",?54,"Critical High",!,?22,"<---",?63,"--->",! D LST
 Q
LST W !,$E($P(^LAB(61,N,0),U),1,19) S P=^LAB(60,LRIFN,1,N,0)
 W ?25,@$S($P(P,U,2)'="":$P(P,U,2),1:""""""),?32,@$S($P(P,U,3)'="":$P(P,U,3),1:""""""),?48,@$S($P(P,U,4)'="":$P(P,U,4),1:""""""),?60,@$S($P(P,U,5):$P(P,U,5),1:""""""),?70,$P(P,U,7)
 I $L($P(P,U,11,12))>1 W !,?10,"Therapeutic low: ",$P(P,U,11),?37,"Therapeutic high: ",$P(P,U,12)
 F X=0:0 S X=$O(^LAB(60,LRIFN,1,N,1,X)) Q:'X  W !,^(X,0)
 Q
PANEL D HOLD W !,"Tests in panel: " Q
 Q
HDR W @IOF,"Lab test",?20,"Highest allowed urgency  Cost",!
 W $E($P(Y(0),U,1),1,26),?28,$S($P(Y(0),U,16):$E($P(^LAB(62.05,$P(Y(0),U,16),0),U,1),1,14),1:"any"),?45,$P(Y(0),U,11) Q
HOLD R !,"Press any key to continue ",%:DTIME D HDR Q
COL W !,"Collection Sample",?21,"VA Lab Slip",?37,"Container",?68,"Vol Req(ml)" Q
COLL D HOLD,COL Q
WARD D HOLD W !,"Ward Instructions:" Q
SYN D HOLD W !,"Synonym:" Q
END D V^LRU Q
