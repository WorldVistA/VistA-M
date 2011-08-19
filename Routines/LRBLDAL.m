LRBLDAL ;AVAMC/REG - BLOOD DONOR LETTERS ;7/18/91  08:52 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 U IO S ^TMP("LRBLY",65.5,2)=LRY,^TMP("LRBLY",65.5,6.2)=LRF I '$D(^LAB(65.9,+LRL,0)) W !!,"Blood bank letter ",$P(LRL,U,2)," has been deleted." G END
 D SET
 S LRP=LRP(1) F LRA=0:1 S LRP=$O(^LRE("B",LRP)) Q:LRP=""!(LRP]LRP(2))  F LRI=0:0 S LRI=$O(^LRE("B",LRP,LRI)) Q:LRI<1  S LRW=$O(^LRE(LRI,5,0)) I LRW>LRSDT S LRW=^(LRW,0) D W
 G END
W S X=^LRE(LRI,0) Q:$P(X,"^",10)  Q:LRABO]""&($P(X,"^",5)'=LRABO)  Q:LRRH]""&($P(X,"^",6)'=LRRH)
 S LRW(7)=$P(LRW,"^",7) I LR,LRW(7)'=LR,'$D(^LRE(LRI,2,LR)) Q
SGL I $D(LRJ) S A=0 D AA Q:A
EN1 ;from LRBLDAA
 S X=^LRE(LRI,0),^TMP("LRBLY",65.5,.05)=$P(X,"^",5),^(.07)=$P(X,"^",7),^(.08)=$P(X,"^",8),X=$P(X,"^",6),^(.06)=$S(X="POS":"POSITIVE",X="NEG":"NEGATIVE",1:"")
 S X1=+LRW,X2=$S(LRY="W":57,LRY="P":3,1:"") D C^%DTC S Y=X D D^LRU S ^TMP("LRBLY",65.5,"NEXT")=Y
 S LRD=$S($D(^LRE(LRI,1)):^(1),1:""),LRQ=1,Y=+LRW D:Y M
 S ^TMP("LRBLY",65.5,5)=Y,X=$P(LRW,"^",6),X=$S('X:"",$D(^LAB(65.4,X,0)):$P(^(0),U,3),1:""),^TMP("LRBLY",65.54,.02)=X,X=$P(LRW,"^",7),X=$S('X:"",$D(^LAB(65.4,X,0)):$P(^(0),U,3),1:""),^TMP("LRBLY",65.54,.03)=X
 W @IOF F X=1:1:LRT W !
 W ?LRS(1),LRT(1),!!
 F X=2:1:6 W:LRS(X)]"" !?LRS(1),LRS(X)
 W !!?DIWL-1,$P(LRP,",",2)," ",$P(LRP,",")
 F X=1:1:3 I $P(LRD,"^",X)]"" W !?DIWL-1,$P(LRD,"^",X)
 W !?DIWL-1,$P(LRD,"^",4) S X=$P(LRD,"^",5) I X,$D(^DIC(5,X,0)) W ", ",$P(^(0),"^",2)," ",$P(LRD,"^",6)
 S Y=$P($P(LRP,",",2)," "),X=$E(Y,2,99) D C^LRUA S Y=$E(Y)_X
 W !!?DIWL-1,"Dear ",Y,","
 W !! K ^TMP($J) S LRC=0 F LRZ=0:1 S LRC=$O(^LAB(65.9,LRL,2,LRC)) Q:'LRC  D:$Y>(IOSL-LRB) HDR S X=^LAB(65.9,LRL,2,LRC,0) D:+$P(X,"[",2) ^LRBLY D:X["|TOP|" TOP D ^DIWP
 D:LRZ ^DIWW I LRV(3) D:$Y>(IOSL-LRB-LRV(3)) HDR F A=1:1:LRV(3) W !
 W:LRV(1)]"" !?LRS(1),LRV(1) W:LRV(2)]"" !?LRS(1),LRV(2) Q
 ;
AA F B=0:0 S B=$O(LRJ(B)) Q:'B  I '$D(^LRE(LRI,1.2,B)) S A=1 Q
 Q
 ;
HDR S LRQ=LRQ+1 W @IOF,$P(LRP,",",2)," ",$P(LRP,","),?(IOM-10),"pg:",LRQ
 F X=1:1:LRT W !
 Q
TOP S Z=$P(X,"|TOP|")_$P(X,"|TOP|",2) D HDR S X=Z Q
 Q
SET S LRL=+LRL,X=^LAB(65.9,LRL,0),LRT=$P(X,U,3),LRB=$P(X,U,4),DIWL=$S($P(X,U,5):$P(X,U,5),1:5),DIWR=IOM-$P(X,U,6),DIWF=$S($P(X,U,7):"D",1:""),DIWF=DIWF_$S($P(X,U,8):"R",1:"")
 S X=$S($D(^LAB(65.9,LRL,3)):^(3),1:"") F A=1:1:3 S LRV(A)=$P(X,"^",A)
 S X=$S($D(^LAB(65.9,LRL,1)):^(1),1:"") F A=1:1:6 S LRS(A)=$P(X,"^",A)
 S X="T",%DT="" D ^%DT,D^LRU S LRT(1)=Y Q
EN ;single donor
 U IO G:'$D(^LAB(65.9,+LRL,0)) END S:$D(LRF) ^TMP("LRBLY",65.5,6.2)=LRF S X=$O(^LRE(LRI,5,0)),LRW=$S('X:"",1:^(X,0)) D SET,SGL G END
 ;
M S X=+$E(Y,4,5),X=$P("January^February^March^April^May^June^July^August^September^October^November^December","^",X),Y=X_" "_+$E(Y,6,7)_", "_(1700+$E(Y,1,3)) Q
END K ^TMP("LRBLY") D END^LRUTL,V^LRU Q
