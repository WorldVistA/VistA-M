LRUPA ;AVAMC/REG/WTY - LAB ACCESSION LIST:DATE & TEST ;9/25/00
 ;;5.2;LAB SERVICE;**72,248**;Sep 27, 1994
 ;
 ;Reference to ^%DT supported by IA #10003
 ;Reference to ^DIC supported by IA #10006
 ;
 I '$D(LRAA)!('$D(LRAA(1))) D ^LRUBYDIV G:'$D(Y) END
 S:'$D(LRO(68)) LRO(68)=LRAA(1) K C W !!?20,LRO(68)," ACCESSION LIST" S X="T",%DT="" D ^%DT S X=Y D D^LRU S Z(1)=Y,Y=X
 I $P(^LRO(68,LRAA,0),U,3)="Y" S X=$E(DT,2,3),%DT="" D ^%DT S X=Y D D^LRU S Z(1)=Y,Y=X
 W !!,"Accession list date:  ",Z(1),"  OK " S %=1 D YN^LRU G:%<0 END
A I %=2 W ! S %DT("A")="Select DATE: ",%DT="AQE" D ^%DT K %DT G:Y<1 END S X=Y D D^LRU S Z(1)=Y,Y=X
 S LRAD=$S($P(^LRO(68,LRAA,0),U,3)="Y":$E(Y,1,3)_"0000",1:Y)
 I '$D(^LRO(68,LRAA,1,LRAD,0)) W $C(7),!!,"No accession numbers for ",Z(1) S %=2 G A
N1 I LRAD'["0000" R !,"Start with Acc #: FIRST // ",N(1):DTIME G:'$T!(N(1)[U) END S:N(1)="" N(1)=1 I N(1)'?1N.N W $C(7),!!,"Enter NUMBERS only" G N1
 I LRAD["0000" R !,"Start with Acc #: ",N(1):DTIME G:N(1)=""!(N(1)[U) END I N(1)'?1N.N W $C(7),!!,"NUMBERS ONLY !!" G N1
N2 R !,"Go    to   Acc #: LAST // ",N(2):DTIME G:N(2)='$T!(N(2)[U) END S:N(2)="" N(2)=999999 I N(2)'?1N.N W $C(7),!!,"NUMBERS ONLY !!",!! G N2
 W !!,"LIST BY PATIENT " S %=2 D YN^LRU G:%=1 ^LRUPA2 G:%<1 END
 I "CHMI"[LRSS W !!,"LIST BY COLLECTION SAMPLE " S %=2 D YN^LRU G:%<0 END I %=1 S DIC=62,DIC(0)="AEMQ",DIC("A")="Select COLLECTION SAMPLE: " D ^DIC K DIC G:Y<1 END S C(1)=+Y,C=$P(Y,U,2)
 S ZTRTN="QUE^LRUPA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S (Q(1),Q(2))=0,LRU(1)=+$O(^LAB(62,"B","UNKNOWN",0)) D L^LRU,S^LRU,H S LR("F")=1
 S N=N(1)-1 F B=0:0 S N=$O(^LRO(68,LRAA,1,LRAD,1,N)) Q:'N!(N>N(2))!(LR("Q"))  S LRC(5)=$S($D(^LRO(68,LRAA,1,LRAD,1,N,3)):$P(^(3),"^",6),1:"") D ^LRUPA1
 Q:LR("Q")  I LRSS="CY" D:$Y>(IOSL-8) H Q:LR("Q")  W !?72,"-----",!,"Cell block (b) count: ",Q(1),?58,"Slide count:",?72,$J(Q(2),5)
 I $G(LRSS)="BB" W:IOST'?1"C".E @IOF
 I $G(LRSS)'="BB" D
 .W:IOST'?1"C".E&($E(IOST,1,2)'="P-"!($D(LR("FORM")))) @IOF
 D END^LRUTL,END
 Q
H ;from LRUPA1
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," ACCESSIONS for ",Z(1),! W:$D(C)#2 "Collection Sample: ",C,!
 W "# = Not VA patient  " W:LRSS="CY" "* = Reviewed by pathologist" W:LRSS="CH" ?30,"*=STAT" W ?55,$S("SPCYEMAU"[LRSS:"% =Incomplete",1:"") I LRSS="CY" W ?72,"Slide"
 W !,"Acc num",?12,$S(LRSS="MI":"Patient/Source",1:"Patient"),?28,"ID",?34,"Loc" I "CYEMSP"[LRSS W ?48,"Organ/tissue",!,LR("%") Q
 W ?40 W:"AUBBCYEMSP"'[LRSS "Specimen/Sample" W:LRSS="BB" "Specimen date" I LRSS="CY" W ?72,"Count"
 I "BBCHMI"[LRSS W ?64,"Test",?76,"Tech",!,LR("%") Q
 W:LRSS="AU" ?42,"Date/time of Autopsy" W !,LR("%") Q
 ;
END D V^LRU Q
