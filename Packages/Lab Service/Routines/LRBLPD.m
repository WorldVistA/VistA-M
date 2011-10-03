LRBLPD ;AVAMC/REG - BB PT INFO ;2/18/93  09:42 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END I LRSS'="BB" W $C(7),!!,"MUST BE BLOOD BANK" G END
 S LRQ=1 D ^LRUL I '$O(^LRO(69.2,LRAA,7,DUZ,1,0)) D R^LRUL G END
 S X=$P(^DD(66,.26,0),U,3),LRF(1)="RBC",LRG(1)="1^RBC",C=1 F A=7:1 S B=$P(X,";",A) Q:B=""  S C=C+1,LRG(C)=A_"^"_$P(B,":",2),LRF(A)=$P(B,":",2)
 W !,"List all blood components " S %=1 D YN^LRU G:%<1 END S LRE=$S(%=1:1,1:0) I 'LRE D ASK G:'LRF END
 W !,"List only total number of units for each component " S %=2 D YN^LRU G:%<1 END S LRJ=$S(%=1:1,1:0)
 D B^LRU G:Y<0 END S LRLDT=9999998-LRLDT,LRSDT=9999999-LRSDT
 K DIC,DIE,DR S ZTRTN="QUE^LRBLPD" D BEG^LRUTL D:POP R^LRUL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU
 S DIWL=5,DIWR=IOM-5,DIWF="W",LRC(1.7)="RBC Antibody present:",LRC(1)="RBC Antigen present :",LRC(1.5)="RBC Antigen absent  :"
 S LRP=0 F LRP(1)=0:0 S LRP=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",LRP)) Q:LRP=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  D LOOP
 D EN^LRUL,END^LRUTL,END Q
LOOP K ^TMP($J) S LRQ=0,SSN=$P(^LRO(69.2,LRAA,7,DUZ,1,LRDFN,0),"^",10),X=^LR(LRDFN,0),LRPABO=$P(X,"^",5),LRPRH=$P(X,"^",6),LRDPF=$P(X,U,2) D H S LR("F")=1
 S LRI=LRLDT F B=1:1 S LRI=$O(^LR(LRDFN,1.6,LRI)) Q:'LRI!(LRI>LRSDT)  D SET
 S A=0 F B=1:1 S A=$O(^TMP($J,A)) Q:A=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W ! S LRT=0 D N Q:LR("Q")  W:LRT !,"Total ",$S($D(LRF(A)):LRF(A),1:"?"),": ",LRT
 Q:LR("Q")  I B=1 W !,"No transfused units" W:'LRE " for ",LRF(LRF) W " on record for specified period.",!
 W !! K ^TMP($J) S A=0 F B=0:1 S A=$O(^LR(LRDFN,3,A)) Q:'A!(LR("Q"))  S LRX=^(A,0) D:$Y>(IOSL-6) H Q:LR("Q")  S X=LRX D ^DIWP
 D:B ^DIWW W ! F C=1.7,1,1.5 Q:LR("Q")  W ! S A=0 F B=0:1 S A=$O(^LR(LRDFN,C,A)) Q:'A!(LR("Q"))  W:'B LRC(C) W:B ! W ?21,$P(^LAB(61.3,A,0),"^") D:$Y>(IOSL-6) H Q:LR("Q")
 Q
 ;
SET S X=^LR(LRDFN,1.6,LRI,0),Z=+$P(X,"^",2),Z=$S($D(^LAB(66,Z,0)):^(0),1:""),Y=+$P(Z,"^",19),Z=+$P(Z,"^",26),Z=$S(Y:1,'Z:"?",1:Z) I 'LRE,LRF'=Z Q
 S ^TMP($J,Z,B)=LRI_"^"_X Q
 ;
ASK S (A,LRF)=0 F B=0:0 S B=$O(LRG(B)) Q:'B  W !?13,$J(B,2),?18,$P(LRG(B),"^",2) S A=A+1
 W !!,"Select (1-",A,"): " R X:DTIME Q:X=""!(X[U)  I +X'=X!(X<1)!(X>A) W $C(7),!!,"Select a NUMBER from 1 to ",A G ASK
 S LRF=+LRG(X) W ?18,$P(LRG(X),"^",2) Q
 ;
N F C=0:0 S C=$O(^TMP($J,A,C)) Q:'C!(LR("Q"))  S X=^(C),LRI=+X,Y=$P(X,U,2) D D^LRU,O Q:LR("Q")  D:$Y>(IOSL-6) H Q:LR("Q")
 Q
O S X(1)=+$P(X,U,3),X(7)=$P(X,U,8),X(10)=$P(X,U,11),M=$S($D(^LAB(66,X(1),0)):$E($P(^(0),U),1,30),1:"component not known"),LRT=LRT+$S(X(7):X(7),1:1)
 Q:LRJ  W !,$P(X,"^",4),?18,$E($P(M,"^"),1,30) I X(7)!(X(10)) W ?45,"(",X(7),"/",X(10),")"
 W ?54,$P(X,"^",6)_" "_$P(X,"^",7),?60,Y
 F F=1,2 F E=0:0 S E=$O(^LR(LRDFN,1.6,LRI,F,E)) Q:'E!(LR("Q"))  W !?6,^(E,0) D:$Y>(IOSL-6) H Q:LR("Q")
 Q
 ;
END D V^LRU Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"TRANSFUSION SERVICE/BLOOD BANK REPORT from ",LRSTR," to ",LRLST,!,"PATIENT: ",LRP," ",SSN," ",$J(LRPABO,2)," ",LRPRH
 W:'LRJ !,"Unit Transfused",?18,"Component",?36,"(# of Units/ml )",?60,"Date/Time Completed" W:LRJ !,"Components Transfused" W !,LR("%")
 Q
