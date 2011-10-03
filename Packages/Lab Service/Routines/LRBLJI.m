LRBLJI ;AVAMC/REG - CHECK FILE ENTRIES ;2/18/93  09:14 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!?17,"Check inventory file entries for missing data.",!!
 S ZTRTN="QUE^LRBLJI" D BEG^LRUTL G:POP!($D(ZTSK)) END D QUE W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
QUE U IO S:$D(ZTQUEUED) ZTREQ="@"
 D L^LRU,S^LRU,H S LR("F")=1 F LRI=0:0 S LRI=$O(^LRD(65,LRI)) Q:'LRI!(LR("Q"))  K LRB S W=$S($D(^(LRI,0)):^(0),1:"?"),W(4)=$S($D(^(4)):^(4),1:"") D C
 D K W !!,"Done." W !! W:$E(IOST,1,2)="P-" @IOF D END^LRUTL,END Q
C S LR=$P(W,"^") I LR="?" W !,"IFN: ",LRI,"  0th subscript missing- Database degradation!" Q
 I $L(LR)>4 F X(1)=2:1:4 I $A($E(LR,X(1)))>64 S ^LRD(65,"C",$E(LR,X(1),$L(LR)),LRI)="" Q
 I '$D(^LRD(65,"B",LR,LRI)) S ^LRD(65,"B",LR,LRI)="" D W Q:LR("Q")  W !,"""B"" Cross reference required re-setting"
 I $P(W,"^",2)="" D W Q:LR("Q")  W !,"SOURCE missing"
 I '$P(W,"^",5) D W Q:LR("Q")  W !,"DATE/TIME RECEIVED missing"
 I $P(W,"^",3)="" D W Q:LR("Q")  W !,"INVOICE# missing"
 I '$P(W,"^",6) D W Q:LR("Q")  W !,"EXPIRATION DATE/TIME missing"
 I $P(W(4),"^",2),$P(W(4),"^")="" D W Q:LR("Q")  W !,"DISPOSITION DATE present but DISPOSITION missing" Q
 Q:$P(W(4),"^")=""  I '$P(W(4),"^",2) D W Q:LR("Q")  W !,"DISPOSITION DATE missing"
 I $P(W(4),"^",3)="" D W Q:LR("Q")  W !,"DISPOSITION ENTERING PERSON missing"
 I $P(W(4),"^")="MO",$O(^LRD(65,LRI,9,0))="" D W Q:LR("Q")  W !,"MODIFIED TO/FROM missing" Q
 S X=+$P(W,"^",4),X=$S($D(^LAB(66,X,0)):$P(^(0),"^",27),1:"") I X,$P(W,"^",2)="SELF",$O(^LRD(65,LRI,9,0))="" D W Q:LR("Q")  W !,"MODIFIED TO/FROM missing"
 Q
W D:$Y>(IOSL-6) H Q:LR("Q")  Q:$D(LRB)  W !,LR("%"),!,"(IFN:",LRI,") Unit ID: ",LR,?39 S LRB=1,X=$P(W,"^",4),X=$S('X:"",$D(^LAB(66,X,0)):$P(^(0),"^"),1:"") W:X]"" X I X="" W "Component missing"
 Q
K S X=0 F LRA=0:0 S X=$O(^LRD(65,"B",X)) Q:X=""  F DA=0:0 S DA=$O(^LRD(65,"B",X,DA)) Q:'DA  K:'$D(^LRD(65,DA,0)) ^LRD(65,"B",X,DA) I $D(^LRD(65,DA,0)) D:X'=$P(^(0),"^") D
 S X=0 F LRA=0:0 S X=$O(^LRD(65,"C",X)) Q:X=""  F DA=0:0 S DA=$O(^LRD(65,"C",X,DA)) Q:'DA  K:'$D(^LRD(65,DA,0)) ^LRD(65,"C",X,DA)
 Q
D F LRF=1,2,3 X:$D(^DD(65,.01,1,LRF,2)) ^(2)
 S Y=^LRD(65,DA,0),S=$P(Y,"^",2),C=$P(Y,"^",4) I C,S]"" S Y=$O(^LAB(66,C,"SU","B",S,0)) S:Y Y=$L($P(^LAB(66,C,"SU",Y,0),"^",10)) K:Y ^LRD(65,"C",$E(X,Y+1,$L(X)),DA)
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !?20,"Missing data from Blood Bank Inventory File",!,LR("%") Q
 ;
END D V^LRU Q
LRCKF ; Entry point for check all laboratory files option  Routine LRCKF
 D END G QUE
