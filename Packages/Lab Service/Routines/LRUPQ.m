LRUPQ ;AVAMC/REG - LAB RESULTS BY ACCESSION AREA ;2/18/93  13:12 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S DIC=68,DIC(0)="AEMOQ",DIC("S")="I $P(^(0),U,2)=""CH""" D ^DIC K DIC Q:Y<1  S LR=+Y,LR(1)=$P(Y,U,2),LR(3)="CH"
 K C W !!?20,LR(1)," ACCESSION LIST" S X="T",%DT="" D ^%DT S X=Y D D^LRU S Z(1)=Y,Y=X
 I $P(^LRO(68,LR,0),U,3)="Y" S X=$E(DT,2,3),%DT="" D ^%DT S X=Y D D^LRU S Z(1)=Y,Y=X
 W !!,"Accession list date:  ",Z(1),"  OK " S %=1 D YN^LRU Q:%<0
A I %=2 W ! S %DT("A")="Select DATE: ",%DT="AQE" D ^%DT K %DT Q:Y<1  S X=Y D D^LRU S Z(1)=Y,Y=X
 S LRAD=$S($P(^LRO(68,LR,0),U,3)="Y":$E(Y,1,3)_"0000",1:Y)
 I '$O(^LRO(68,LR,1,LRAD,1,0)) W $C(7),!!,"No accession numbers for ",Z(1) S %=2 G A
N1 I LRAD'["0000" R !,"Start with Acc #: FIRST // ",N(1):DTIME Q:'$T!(N(1)[U)  S:N(1)="" N(1)=1 I N(1)'?1N.N W $C(7),!!,"Enter NUMBERS only" G N1
 I LRAD["0000" R !,"Start with Acc #: ",N(1):DTIME Q:N(1)=""!(N(1)[U)  I N(1)'?1N.N W $C(7),!!,"NUMBERS ONLY !!" G N1
N2 R !,"Go    to   Acc #: LAST // ",N(2):DTIME Q:N(2)='$T!(N(2)[U)  S:N(2)="" N(2)=999999 I N(2)'?1N.N W $C(7),!!,"NUMBERS ONLY !!",!! G N2
 S ZTRTN="QUE^LRUPQ" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L,L^LRU,S^LRU S (Q(1),Q(2))=0,LRU=+$O(^LAB(61,"B","UNKNOWN",0)),LRU(1)=+$O(^LAB(62,"B","UNKNOWN",0)) D H S LR("F")=1
 S N=N(1)-1 F B=0:0 S N=$O(^LRO(68,LR,1,LRAD,1,N)) Q:'N!(N>N(2))!(LR("Q"))  S LRC(5)=$S($D(^LRO(68,LR,1,LRAD,1,N,3)):$P(^(3),"^",6),1:"") W !,LR(4) D ^LRUPQ1
 W:IOST'?1"C".E @IOF D END^LRUTL,END Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE ",?22,LR(1)," ACCESSIONS for ",Z(1)
 W !,"Acc #",?7,"Patient",?28,"SSN",?35,"LOC",?41,"Specimen",?56,"Received",?68,"Verified",!,LR("%") Q
 ;
L S LR(4)="" F X=2:1:IOM S LR(4)=LR(4)_"-"
 Q
 ;
END D V^LRU Q
