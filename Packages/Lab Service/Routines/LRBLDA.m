LRBLDA ;AVAMC/REG - BLOOD DONOR LIST ;2/18/93  08:43 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END S (LRF,LRY)=""
 W @IOF,!?24,"PRINT BLOOD DONOR LIST/LABELS/LETTERS"
L W !!?14,"1. DONOR LIST",!?14,"2. DONOR LABELS",!?14,"3. DONOR PRE -VISIT LETTERS",!?14,"4. DONOR POST-VISIT LETTERS",!,"Select (1-4): " R X:DTIME G:X=""!(X[U) END
 I X'=+X!(X<1)!(X>4) W $C(7),!,"Enter a number from 1 to 4" G L
 S LRS=X G:X=4 ^LRBLDAA I X=3 W !!,"Letter for a single donor " S %=2 D YN^LRU G:%=1 O W !!
 S LR(2)="",LR=0,%DT="AEX",%DT(0)="-N",%DT("A")="Date since last donation: " D ^%DT K %DT G:Y<1 END S LRSDT=9999998-Y D D^LRU S LRSTR=Y
 W !!,"DONORS FROM A SPECIFIC GROUP AFFILIATION " S %=2 D YN^LRU G:%<1 END
 I %=1 S DIC=65.4,DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,2)[""G""",DIC("A")="Select DONOR GROUP AFFILIATION: " D ^DIC K DIC G:X=""!(X[U) END S LR=+Y,LR(2)=$P(Y,U,2),LRY=$P(Y(0),U,3)
S R !!,"Start with BLOOD DONOR NAME: FIRST// ",X:DTIME G:X[U!'$T END I X="" S LRP(1)=0,LRP(2)="z" G A
 I X["?"!(X'?1U.E)!($L(X)>30) D H^LRU G S
 S LRP(1)=X I $L(X)>1 S X(1)=$A(X,$L(X))-1,X(1)=$C(X(1)),LRP(1)=$E(X,1,$L(X)-1)_X(1)
F R !,"Go to BLOOD DONOR NAME: LAST// ",X:DTIME G:X[U!'$T END I X="" S LRP(2)="z" G A
 I X["?"!(X'?1U.E)!($L(X)>30) D H1^LRU G F
 S LRP(2)=X
A S (LRABO,LRRH)="" W !!,"Specify ABO Group and/or Rh Type " S %=2 D YN^LRU G:%<1 END I %=1 D EN^LRBLDA1 G:'$D(Y) END
 G B:LRS=2,C:LRS=3 S ZTRTN="QUE^LRBLDA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,H S LR("F")=1
 S LRP=LRP(1) F LRA=0:1 S LRP=$O(^LRE("B",LRP)) Q:LRP=""!(LRP]LRP(2))!(LR("Q"))  F LRI=0:0 S LRI=$O(^LRE("B",LRP,LRI)) Q:LRI<1!(LR("Q"))  S LRW=$O(^LRE(LRI,5,0)) I LRW>LRSDT S LRW=^(LRW,0) D W
 D END^LRUTL,V^LRU Q
 ;
W S X=^LRE(LRI,0) Q:$P(X,"^",10)  Q:LRABO]""&($P(X,"^",5)'=LRABO)  Q:LRRH]""&($P(X,"^",6)'=LRRH)
 D:$Y>(IOSL-11) H Q:LR("Q")  S LRW(7)=$P(LRW,"^",7) I LR,LRW(7)'=LR,'$D(^LRE(LRI,2,LR)) Q
 W !,LRP S Y=+LRW D D^LRU W ?31,$E(Y,1,12) I LRW(7),$D(^LAB(65.4,LRW(7),0)) W ?45,$E($P(^(0),"^",3),1,30)
 I $D(^LRE(LRI,1)) S X=^(1),Y=$P(X,"^",7),O=$P(X,"^",8) W:IOM>118 ?76,Y,?93,O W:IOM<119&(Y]""!(O]"")) !?5,Y,?25,O
 F B=0:0 S B=$O(^LRE(LRI,2,B)) Q:'B  I B'=LRW(7),$D(^LAB(65.4,B,0)) W !?45,$E($P(^(0),"^",3),1,30)
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRAA(1),!,"NO " W:LR(2)]"" LR(2)," " W "DONATIONS SINCE ",LRSTR
 W !,"Donor",?31,"Last donation",?55,"Group" W:IOM>118 ?76,"Home phone",?93,"Work phone" W:IOM<119 !?5,"Home phone",?25,"Work phone" W !,LR("%") Q
 ;
B W !!?33,"REMEMBER TO",!?13,"ALIGN THE PRINT HEAD ON THE FIRST LINE OF THE LABEL" S LR(1)=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),"^",7),1:"")
I W !!?20,"ENTER  NUMBER OF LINES  FROM",!?20,"TOP OF ONE LABEL TO ANOTHER: ",LR(1),$S(LR(1):"// ",1:"") R X:DTIME Q:'$T!(X[U)  S X=$S(X="":LR(1),$L(X)>2:X=1,1:X)
 X $P(^DD(69.2,.07,0),"^",5,99) I '$D(X) W:$D(^DD(69.2,.07,3)) !,$C(7),^(3) X:$D(^(4)) ^(4) G I
 S LR(1)=X
 S ZTRTN="^LRBLDA1" D BEG^LRUTL G:POP!($D(ZTSK)) END
 W ! G ^LRBLDA1
 ;
LTR W ! S DIC("S")="I '$P(^(0),U,2)",DIC="^LAB(65.9,",DIC(0)="AEQMZ",DIC("A")="Select BLOOD DONOR LETTER: " D ^DIC K DIC S LRL=Y I $P(Y,U,2)="RBC ANTIGEN ABSENT, DONOR" D EN1^LRBLDA1 S Y=1 S:'$D(LRJ) Y=-1
 Q
C D LTR G:Y<1 END S ZTRTN="^LRBLDAL" D BEG^LRUTL G:POP!($D(ZTSK)) END
 W ! G ^LRBLDAL
 ;
O D LTR G:Y<1 END
ASK W ! S DIC="^LRE(",DIC(0)="AEQMZ" D ^DIC K DIC G:Y<1 END
 S LRP=$P(Y,U,2),LRI=+Y I $P(Y(0),U,10) W $C(7),!,"Donor permanently deferred.  Are you sure " D YN^LRU G:%'=1 ASK
 S ZTRTN="EN^LRBLDAL" D BEG^LRUTL G:POP!($D(ZTSK)) END W ! G EN^LRBLDAL
 ;
END K ^TMP("LRBLY") D V^LRU Q
