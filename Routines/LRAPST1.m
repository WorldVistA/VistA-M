LRAPST1 ;AVAMC/REG/WTY - AUTOPSY TISSUE STAIN LOOK-UP ;9/25/00
 ;;5.2;LAB SERVICE;**72,248**;Sep 27, 1994
 ;
 F A=0:0 S A=$O(^LR(LRDFN,33,A)) Q:'A!(LRM[U)  S LRB=^(A,0) D:$Y>(IOSL-3) M^LRAPST Q:LRM[U  W !,$P(LRB,U) D A
 W ! Q
A F E=0:0 S E=$O(^LR(LRDFN,33,A,E)) Q:'E!(LRM[U)  S B=0 F F=1:1 S B=$O(^LR(LRDFN,33,A,E,B)) Q:'B!(LRM[U)  S LRB(1)=^(B,0) D:$Y>(IOSL-3) M^LRAPST Q:LRM[U  D T
 Q
T W:F=1 !,LRSS(LRSS,E) W !?3,$P(LRB(1),U),?21,"Stain/Procedure" S Y=$P(LRB(1),U,2) D D^LRU W ?59,Y
 F C=0:0 S C=$O(^LR(LRDFN,33,A,E,B,1,C)) Q:'C!(LRM[U)  S Y=^(C,0),X=$P(Y,U,2),Z=$P(Y,U,3) D:$Y>(IOSL-3) M^LRAPST Q:LRM[U  D W
 Q
W W !?16,$S($D(^LAB(60,C,0)):$P(^(0),U),1:C),?47 W:X $J(X,5) W:Z ?52,"/",Z S Y=$P(Y,U,4) D:Y D^LRU W ?59,Y Q
 ;
AU I $P($P($G(^LR(LRDFN,"AU")),U,6)," ")'=LRABV D  Q
 .W $C(7),!!,"No autopsy entry for ",LRP,!! S A=1
 S LRA=^LR(LRDFN,"AU"),LREP=$P(LRA,U,6)
 I LREP']"" W $C(7),!!,"No autopsy # for ",LRP S A=1 Q
 S Y=+LRA D D^LRU W !,"Autopsy performed: ",Y,"  Acc # ",LREP
 W !!,"Is this the patient " S %=1 D YN^LRU S:%'=1 A=1
 Q
