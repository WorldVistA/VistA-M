LRUET ;AVAMC/REG - RESULTS FOR A TEST RANGE ;2/18/93  12:43 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D V^LRU W ! S DIC("A")="Select lab test to check a range of values: "
 S DIC=60,DIC(0)="AEQMOZ",DIC("S")="I $P(^(0),U,5)[""CH""" D ^DIC K DIC G:Y<1 END
 S LRC=+Y,N(1)=$P(^LAB(60,LRC,.1),"^"),LRN=$P($P(Y(0),U,5),";",2)
ASK S DIC(0)="AEQMO",DIC="^LAB(61,",DIC("A")="Select Specimen Type to check: " D ^DIC K DIC G:Y<1 END S LRA=+Y,LRA(1)=$P(Y,U,2) I '$D(^LAB(60,LRC,1,LRA,0)) W $C(7),!,"Not a valid specimen for the test selected." G ASK
A W !!,?15,"1. Greater than a value",!?15,"2. Less than a value",! R "Select 1 or 2: ",X:DTIME G:X=""!(X[U) END I X<1!(X>2) W $C(7),"  Enter 1 or 2" G A
 S LRG=$S(X=1:">",1:"<")
B R !,"Select value: ",X:DTIME G:X=""!(X[U) END S X=+X I 'X W $C(7),!,"Must be a numeric value." G B
 S LRB=LRG_X,LRQ(2)=N(1)_LRB_" ("_LRA(1)_")"
 D B^LRU Q:Y<0  S LRLDT(1)=LRLDT+.99,LRSDT(1)=LRSDT-.01,LRLDT=9999998-LRLDT,LRSDT=9999999-LRSDT
 S ZTRTN="QUE^LRUET" D BEG^LRUTL Q:POP!($D(ZTSK))
QUE U IO K ^TMP($J) D L^LRU,S^LRU,H S LR("F")=1
 F LRDFN=0:0 S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  I $D(^LR(LRDFN,0)),$P(^(0),"^",2)=2 S LRI=LRLDT F A=0:0 S LRI=$O(^LR(LRDFN,"CH",LRI)) Q:LRI<1!(LRI>LRSDT)  D C
 D D K ^TMP($J) D END,END^LRUTL Q
C Q:'$D(^LR(LRDFN,"CH",LRI,LRN))!($P(^(0),"^",5)'=LRA)  S X=$P(^(LRN),"^") G:$E(X)=LRG S I @(+^(LRN)_LRB),^(LRN)'="canc" G S
 Q
S S DFN=$P(^LR(LRDFN,0),"^",3) Q:'DFN  S X=^DPT(DFN,0),LRP=$P(X,"^"),SSN=$P(X,"^",9),^TMP($J,LRP,LRDFN,LRN,LRI)=$P(^LR(LRDFN,"CH",LRI,LRN),"^"),^TMP($J,LRP)=SSN,^TMP($J,"B",LRP,LRI)=$P(^LR(LRDFN,"CH",LRI,0),"^",11) Q
 ;
D S LRP=0 F LRA=0:0 S LRP=$O(^TMP($J,LRP)) Q:LRP=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  D LRT
 Q
LRT D:$Y>(IOSL-6) H Q:LR("Q")  S X=^TMP($J,LRP) W !!,LRP,?31,X
 F LRT=0:0 S LRT=$O(^TMP($J,LRP,LRDFN,LRT)) Q:'LRT!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  S LRE=0 F LRI=0:0 S LRI=$O(^TMP($J,LRP,LRDFN,LRT,LRI)) Q:'LRI!(LR("Q"))  S LRX=^(LRI),LRE=LRE+1 D W
 Q
W D:$Y>(IOSL-6) H1 Q:LR("Q")  S Y=9999999-LRI D DT^LRU W !,^TMP($J,"B",LRP,LRI) W:LRE=1 ?31,N(1) W ?41,Y,?65,$J(LRX,5) Q
 ;
H Q:LR("Q")  I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRQ(2)," From: ",LRSTR," to ",LRLST,!,"Report for: ",$P(^VA(200,DUZ,0),U),!,"Patient",?34,"SSN",!,"Location",?31,"Test",?45,"Date",?65,"Result",!,LR("%") Q
H1 D H Q:LR("Q")  W !,LRP,?31,^TMP($J,LRP) Q
 ;
END D V^LRU Q
