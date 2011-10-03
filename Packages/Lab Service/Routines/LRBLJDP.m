LRBLJDP ;AVAMC/REG -  PRINT UNIT DISPOSITION ;10/11/95  07:47 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END K LR S X=$P(^DD(65,4.1,0),U,3) F Y=1:1 S Z=$P(X,";",Y) Q:Z=""  S LR($P(Z,":"))=$P(Z,":",2)
 K LR("T")
ASK R !!,"Select DISPOSITION: ",X:DTIME G:X=""!(X[U) END I '$D(LR(X)) D SEL G ASK
 W "  ",LR(X) S LRD=X,LRD(1)=LR(X) D B^LRBLU G:Y<0 END S LRSDT=LRSDT-.0001,LRLDT=$S(LRLDT'[".":LRLDT+.99,1:LRLDT)
 S ZTRTN="QUE^LRBLJDP" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU,H S LR("F")=1
 S LRO=LRSDT F A=0:0 S LRO=$O(^LRD(65,"AB",LRO)) Q:'LRO!(LRO>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"AB",LRO,LRI)) Q:'LRI  D S
 F LRC=0:0 S LRC=$O(^TMP($J,LRC)) Q:'LRC!(LR("Q"))  S LRC(1)=$P(^LAB(66,LRC,0),"^") D:$Y>(IOSL-6) H Q:LR("Q")  W !!,LRC(1) D T
 I LRD="MO" D:$Y>(IOSL-6) HDR Q:LR("Q")  W !!,"Units modified to:",?41,"Count:" F LRL=0:0 S LRL=$O(LRM(LRL)) Q:'LRL  D:$Y>(IOSL-6) HDR Q:LR("Q")  W !,$P(^LAB(66,LRL,0),"^"),?41,$J(LRM(LRL),5)
 D END^LRUTL,END Q
T F LRO=0:0 S LRO=$O(^TMP($J,LRC,LRO)) Q:'LRO!(LR("Q"))  S Y=LRO D DT^LRU S LRY=Y,LRA=0 F LRB=0:0 S LRA=$O(^TMP($J,LRC,LRO,LRA)) Q:LRA=""!(LR("Q"))  S LRI=^(LRA),LRE=^LRD(65,LRI,0) D W
 Q
W D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,LRA,?15,LRY W:LRD'="MO"&(LRD'="S")&(LRD'="R") ?30,$P(LRE,"^",2) W:LRD="S"!(LRD="R") ?30,$E($P(^LRD(65,LRI,4),"^",5),1,30)
 I LRD'="MO" S Y=$P(LRE,"^",5),R=$P(LRE,"^",8) D DT^LRU W ?61,$J($P(LRE,"^",7),2),$S(R="POS":"+",R="NEG":"-",1:"") W:LRD'="S"&(LRD'="R") ?65,Y W:LRD="S"!(LRD="R") ?69,$P(LRE,"^",13)
 I LRD="MO" S LRL=0 F LRG=0:1 S LRL=$O(^LRD(65,LRI,9,LRL)) Q:'LRL!(LR("Q"))  S LRF=^(LRL,0),LRM=+LRF D:$Y>(IOSL-6) H2 Q:LR("Q")  D A
 Q:LR("Q")  F LRL=0:0 S LRL=$O(^LRD(65,LRI,5,LRL)) Q:'LRL!(LR("Q"))  S LRF=^(LRL,0) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?3,LRF
 Q
A W:LRG ! W ?30,$E($P(^LAB(66,LRM,0),"^"),1,36),?67,$P(LRF,"^",2) S:'$D(LRM(LRM)) LRM(LRM)=0 S LRM(LRM)=LRM(LRM)+1 Q
S I '$D(^LRD(65,LRI,4)) K ^LRD(65,"AB",LRO,LRI) Q
 Q:$P(^LRD(65,LRI,4),"^")'=LRD  S Y=^LRD(65,LRI,0) S:$P(Y,"^",16)=DUZ(2) ^TMP($J,$P(Y,"^",4),LRO,$P(Y,"^"))=LRI Q
HDR I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK ",LRAA(4)
 W !,"UNIT DISPOSITION: ",LRD(1)," (from ",LRSTR," to ",LRLST,")" Q
H D HDR Q:LR("Q")  W !,"UNIT ID",?15,"DISP DATE",?30,$S(LRD="MO":"MODIFY TO",LRD="S"!(LRD="R"):"SHIPPED TO",1:"SOURCE")
 W:LRD'="MO" ?58,"ABO/Rh" W:LRD'="S"&(LRD'="R")&(LRD'="MO") ?65,"DATE RECEIVED" W:LRD="MO" ?67,"UNIT ID" W:LRD="S"!(LRD="R") ?69,"INVOICE" W !,LR("%") Q
H1 D H Q:LR("Q")  W !,"COMPONENT: ",LRC(1),! Q
H2 D H1 Q:LR("Q")  W !,LRA,?15,LRY," (Continued from pg ",LRQ-1,")",! Q
 ;
SEL W !!,"Select from:" S X=0 F A=0:0 S X=$O(LR(X)) Q:X=""  W !?3,X,?6,"for",?10,LR(X)
 Q
 ;
END D V^LRU Q
