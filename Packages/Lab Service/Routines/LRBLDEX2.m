LRBLDEX2 ;AVAMC/REG/CYM - EX-BLOOD DONORS ;7/3/96  11:30 ;
 ;;5.2;LAB SERVICE;**1,72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
T Q:'Y  S Y=Y_"0000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_$S(Y'[".":"",1:"@"_$E(Y,9,10)_":"_$E(Y,11,12)) Q
 ;
EN ;from LRBLDEX1
 S W=0 F B=0:1 S W=$O(^LRE(LRI,5,W)) Q:'W!(LR("Q"))  D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  S M=^LRE(LRI,5,W,0),Y=+M D T,R
 Q:LR("Q")  D:$D(^LRE(LRI,99)) W Q:LR("Q")  W ! Q
 ;
R W !,"Donation **",Y,"**" S X=$P(M,"^",6) S:X X=$S($D(^LAB(65.4,X,0)):$P(^(0),"^"),1:"") W:X]"" " Site:",X S X=$P(M,"^",7)
 S:X X=$S($D(^LAB(65.4,X,0)):$P(^(0),"^"),1:"") W:X]"" " Group:",X S Y=$P(M,"^",8) W:IOM<($X+9) ! I Y]"" D:Y EN1^LRBLDEX1 Q:LR("Q")  W " Edit:",Y
 D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  S X=$P(M,"^",11) W !,"Donation type:",$$EXTERNAL^DILFD(65.54,1.1,"",X) S X=$P(M,"^",2) W " ",$$EXTERNAL^DILFD(65.54,1,"",X) G:X="N:" O
 S X=$P(M,"^",3) I X W:IOM<($X+39) ! W " Reaction:",$E($P(^LAB(65.4,X,0),"^",3),1,30)
 I $P(M,"^",9)]"" W:IOM<($X+40) ! W " Taken by:",$P(M,"^",9)
 I $P(M,"^",5)]"" W:IOM<($X+43) ! W "  Credit for:",$P(M,"^",5)
 S X=$P(M,"^",4) Q:X=""  D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  S ^TMP("LRBL",$J,X)=LRP W !,"UNIT ID: ",X S X=$P(M,"^",10)
 I X]"" W " Disposition: ",$$EXTERNAL^DILFD(65.54,6.1,"",X) F B=0:0 S B=$O(^LRE(LRI,5,W,3,B)) Q:'B!(LR("Q"))  D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  W !,^LRE(LRI,5,W,3,B,0)
 Q:LR("Q")  K M I $D(^LRE(LRI,5,W,2)) S M=^(2),X=$P(M,U) W:X]"" !,"Primary bag: ",$$EXTERNAL^DILFD(65.54,4.1,"",X) S X=$P(M,U,9) W:X]"" "  ",$$EXTERNAL^DILFD(65.54,4.11,"",X)
 I $D(M) S X=$P(M,"^",10) W:X]"" " (lot#",X,")" S X=$P(M,"^",5) W:X " tot gm:",X S X=$P(M,"^",6) W:X " empty wt:",X S X=$P(M,"^",7) W:X " ml:",X S Y=$P(M,"^",8) I Y]"" W:IOM<($X+10) ! D:Y EN1^LRBLDEX1 W " tech: ",Y
 I $D(M) S Y=$P(M,"^",2) D T W !,"Collection start:",Y S Y=$P(M,"^",3) D T W "  stop:",Y S Y=$P(M,"^",4) D T W "  process:",Y
 I $D(^LRE(LRI,5,W,10))!($D(^(11)))!($D(^(12)))!($D(^(13)))!($D(^(14)))!($D(^(15)))!($D(^(16)))!($D(^(17)))!($D(^(18)))!($D(^(19)))!($D(^(20))) D:$Y>55 EN^LRBLDEX1 W !,"Test",?31,"Tech"
 F M=10:1:20 I $D(^LRE(LRI,5,W,M)) S Z=^(M),Z(1)=$P(Z,"^") W !,$E(LR(M),1,15),?16,$$EXTERNAL^DILFD(65.54,M,"",Z(1)),?31 S Y=$P(Z,"^",2) D:Y EN1^LRBLDEX1 W Y,?35,$P(Z,"^",3)
 S M(1)=0 D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")
 F Z=0:1 S M(1)=$O(^LRE(LRI,5,W,66,M(1))) Q:'M(1)!(LR("Q"))  D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  S M=^(M(1),0) W:'Z !,"Component",?41,"Grams",?47,"Date stored",?62,"Expiration date" W !,$P(^LAB(66,M(1),0),"^"),?41,$P(M,"^",5) D D
 Q
D S Y=$P(M,"^",3) D T W ?47,Y S Y=$P(M,"^",4) D T W ?62,Y
 S Y=$P(M,U,6) D:Y EN1^LRBLDEX1 W !,"Label tech:",Y
 S X=$P(M,U,8) W " Disposition:",$$EXTERNAL^DILFD(65.66,.08,"",X)," date:" S Y=$P(M,"^",2) D T W Y," tech:" S Y=$P(M,"^",7) D:Y EN1^LRBLDEX1 W Y
 F E=0:0 S E=$O(^LRE(LRI,5,W,66,M(1),1,E)) Q:'E!(LR("Q"))  D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  W !,^LRE(LRI,5,W,66,M(1),1,E,0)
 Q
 ;
O S N=0 F C=0:1 S N=$O(^LRE(LRI,5,W,1,N)) Q:'N!(LR("Q"))  S M=^(N,0) W:'C !,"Deferral reason:" D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  W !,$P(^LAB(65.4,M,0),"^",3)
 Q
W W !,"Permanent deferral reason:" K ^UTILITY($J) S DIWR=IOM-5,DIWL=5,DIWF="W" S LRX=0 F LRR=0:1 S LRX=$O(^LRE(LRI,99,LRX)) Q:'LRX!(LR("Q"))  D:$Y>(IOSL-6) EN^LRBLDEX1 Q:LR("Q")  S X=^LRE(LRI,99,LRX,0) D ^DIWP
 Q:LR("Q")  D:LRR ^DIWW Q
