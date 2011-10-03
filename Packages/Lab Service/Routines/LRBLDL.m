LRBLDL ;AVAMC/REG - BLOOD DONOR LIST ;2/18/93  08:55 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W @IOF,!?28,"BLOOD DONOR LISTS/LABELS"
 S LR(2)="",LR=0,%DT="AEX",%DT(0)="-N",%DT("A")="Date since last donation: " D ^%DT K %DT G:Y<1 END S LRSDT=9999998-Y D D^LRU S LRSTR=Y
 W !!,"DONORS FROM A SPECIFIC GROUP AFFILIATION " S %=2 D YN^LRU G:%<1 END
 I %=1 S DIC=65.4,DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)[""G""",DIC("A")="Select DONOR GROUP AFFILIATION: " D ^DIC K DIC G:X=""!(X[U) END S LR=+Y,LR(2)=$P(Y,U,2)
S R !!,"START WITH BLOOD DONOR NAME: FIRST// ",X:DTIME G:X[U!'$T END I X="" S P(1)=0,P(2)="z" G L
 I X["?"!(X'?1U.E)!($L(X)>30) D H^LRU G S
 S P(1)=X I $L(X)>1 S X(1)=$A(X,$L(X))-1,X(1)=$C(X(1)),P(1)=$E(X,1,$L(X)-1)_X(1)
F R !,"GO TO BLOOD DONOR NAME: LAST// ",X:DTIME G:X[U!'$T END I X="" S P(2)="z" G L
 I X["?"!(X'?1U.E)!($L(X)>30) D H1^LRU G F
 S P(2)=X
L W !!?14,"1. PRINT DONOR LIST",!?14,"2. PRINT DONOR LABELS",!,"Select (1-2): " R X:DTIME Q:X=""!(X[U)  I X'=1&(X'=2) W $C(7),!,"Enter the number 1 or the number 2" G L
 G:X=2 B S ZTRTN="QUE^LRBLDL" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,H S LR("F")=1
 S P=P(1) F A=0:1 S P=$O(^LRE("B",P)) Q:P=""!(P]P(2))!(LR("Q"))  F I=0:0 S I=$O(^LRE("B",P,I)) Q:I<1!(LR("Q"))  S W=$O(^LRE(I,5,0)) I W>LRSDT S W=^(W,0) D W
 D END,END^LRUTL Q
 ;
W Q:$P(^LRE(I,0),"^",10)  D:$Y>(IOSL-11) H Q:LR("Q")  S W(7)=$P(W,"^",7) I LR,W(7)'=LR,'$D(^LRE(I,2,LR)) Q
 W !,P S Y=+W D D^LRU W ?31,$E(Y,1,12) I W(7),$D(^LAB(65.4,W(7),0)) W ?45,$E($P(^(0),"^",3),1,30)
 I $D(^LRE(I,1)) S X=^(1),Y=$P(X,"^",7),O=$P(X,"^",8) W:IOM>118 ?76,Y,?93,O W:IOM<119&(Y]""!(O]"")) !?5,Y,?25,O
 F B=0:0 S B=$O(^LRE(I,2,B)) Q:'B!(LR("Q"))  I B'=W(7),$D(^LAB(65.4,B,0)) W !?45,$E($P(^(0),"^",3),1,30)
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRAA(1),!,LR(2),"  NO DONATIONS SINCE ",LRSTR
 W !,"Donor",?31,"Last donation",?55,"Group" W:IOM>118 ?76,"Home phone",?93,"Work phone" W:IOM<119 !?5,"Home phone",?25,"Work phone" W !,LR("%") Q
 ;
B W !!?33,"REMEMBER TO",!?13,"ALIGN THE PRINT HEAD ON THE FIRST LINE OF THE LABEL" S LR(1)=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),"^",7),1:"")
I W !!?20,"ENTER  NUMBER OF LINES  FROM",!?20,"TOP OF ONE LABEL TO ANOTHER: ",LR(1),$S(LR(1):"// ",1:"") R X:DTIME Q:'$T!(X[U)  S X=$S(X="":LR(1),$L(X)>2:X=1,1:X)
 X $P(^DD(69.2,.07,0),"^",5,99) I '$D(X) W:$D(^DD(69.2,.07,3)) !,$C(7),^(3) X:$D(^(4)) ^(4) G I
 S LR(1)=X
 S ZTRTN="^LRBLDL1" D BEG^LRUTL G:POP!($D(ZTSK)) END
 W ! G ^LRBLDL1
 ;
END D V^LRU Q
