LRUCNBB ;AVAMC/REG - COOMBS/ANTIBODY REPORT ;02/12/89  12:30 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 K LRE,LRB S X=^LR(LRDFN,0),LRPABO=$P(X,"^",5),LRPRH=$P(X,"^",6)
 I '$O(^LR(LRDFN,1.7,0)) W !!,"No serum antibodies present." G:'$D(LRI) F
 I $D(LRI),'$O(^LR(LRDFN,1.7,0)),'$O(^LR(LRDFN,LRSS,LRI,"EA",0)) D E,P1 G F
 K ^TMP($J) W !! S LRC=0 F LRZ=0:1 S LRC=$O(^LAB(65.9,LRL,2,LRC)) Q:'LRC  D:$Y>(IOSL-12) H S X=^LAB(65.9,LRL,2,LRC,0) D ^DIWP
 D:LRZ ^DIWW S LRF="SERUM " F LRA=0:0 S LRA=$O(^LR(LRDFN,1.7,LRA)) Q:'LRA  S LRX=^(LRA,0) D:$Y>(IOSL-12) H D W
 I $D(LRI) S LRF="ELUATE" F LRA=0:0 S LRA=$O(^LR(LRDFN,"BB",LRI,"EA",LRA)) Q:'LRA  D:$Y>(IOSL-12) H D W
 S LRB=1 F LRA=0:0 S LRA=$O(LRB(LRA)) Q:'LRA  S LRB=LRB*LRB(LRA)
 W !,"Patient is ",LRPABO," ",LRPRH,".  ",$J(LRB*100,5,1)," % OF THE POPULATION WILL BE COMPATIBLE."
 I $D(LRI),'$O(^LR(LRDFN,"BB",LRI,"EA",0)) D E,P1
F S LRE=1 D F^LRUCN Q
W S X=^LAB(61.3,LRA,0),Y=$P(X,"^",6) W !,LRF," ANTIBODY: ",$P(X,"^") I Y]"" W ?40,"% Compatible Units: ",$J(Y*100,3,1) S LRB(LRA)=Y
 D:$Y>(IOSL-12) H
 K ^TMP($J) W ! S LRC=0 F LRZ=0:1 S LRC=$O(^LAB(61.3,LRA,7,LRC)) Q:'LRC  D:$Y>(IOSL-12) H S X=^LAB(61.3,LRA,7,LRC,0) D ^DIWP
 D:LRZ ^DIWW
 F LRC=0:0 S LRC=$O(^LAB(61.3,LRA,"JR",LRC)) Q:'LRC  I $P(^(LRC,0),"^",7) S LRX=^(0) D L
 Q
L D:$Y>(IOSL-12) H W !,"Reference: ",$P(LRX,"^"),!,$P(LRX,"^",2),! I $P(LRX,"^",3) W $P(^LAB(95,$P(LRX,"^",3),0),"^")," Vol.",$P(LRX,"^",4)," Pg:",$P(LRX,"^",5) S Y=$P(LRX,"^",6) D D^LRU W " Date:",Y,!
 Q
H D F^LRUCN,H^LRUCN Q
P1 K ^TMP($J) D:$Y>(IOSL-12) H W ! S LRC=0 F LRZ=0:1 S LRC=$O(^LAB(65.9,LRL,4,LRC)) Q:'LRC  D:$Y>(IOSL-12) H S X=^LAB(65.9,LRL,4,LRC,0) D ^DIWP
 D:LRZ ^DIWW Q
E D:$Y>(IOSL-12) H W !! K ^TMP($J) S X="Patient has a positive Direct Coombs Test; however, no eluate antibodies are present for specimen dated: "_LRI(1) D ^DIWP,^DIWW Q
