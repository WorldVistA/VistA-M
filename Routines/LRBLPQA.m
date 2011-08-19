LRBLPQA ;AVAMC/REG - TRANSFUSION REQUEST DATA ;2/18/93  09:45 ;
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !!?20 D END,I,Z G:Y=-1 END
A R !!?3,"(A)ll components or (S)ingle component: ",X:DTIME Q:X["^"!(X="")  I $A(X)'=65,$A(X)'=83 W $C(7),!,"Enter 'A' for all blood components or 'S' for a single component" G A
 G:$A(X)=65 D
B S DIC=66,DIC(0)="AEQM",DIC("S")="I $P(^(0),U,4)=""BB""" D ^DIC K DIC G:Y<1 END S LRC=+Y,LRC(1)=$P(Y,"^",2) I '$D(^LRO(69.2,LRAA,8,66,1,LRC)) W $C(7),!,"There are no entries to print",!! G B
D D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 S ZTRTN="QUE^LRBLPQA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,H S LR("F")=1 I $D(LRC) D W G OUT
 S LRC(1)=0 F LRA=0:0 S LRC(1)=$O(^LRO(69.2,LRAA,8,66,1,"B",LRC(1))) Q:LRC(1)=""!(LR("Q"))  F LRC=0:0 S LRC=$O(^LRO(69.2,LRAA,8,66,1,"B",LRC(1),LRC)) Q:'LRC!(LR("Q"))  D W
OUT W:IOST'?1"C".E @IOF D END,END^LRUTL Q
W D:$Y>(IOSL-10) H Q:LR("Q")  W !!?20,LRC(1)
 F LRD=0:0 S LRD=$O(^LRO(69.2,LRAA,8,66,1,LRC,1,LRD)) Q:'LRD!(LR("Q"))  S LRB=^(LRD,0) I +LRB<LRLDT&(+LRB>LRSDT) S $P(^(0),"^",4)=1,SSN=$P(LRB,"^",3) D:$Y>(IOSL-10) H1 Q:LR("Q")  S Y=+LRB D D^LRU D W1
 Q
W1 W !!,Y," ",$P(LRB,"^",2),"  SSN:",SSN
 F A=0:0 S A=$O(^LRO(69.2,LRAA,8,66,1,LRC,1,LRD,1,A)) Q:'A!(LR("Q"))  S LR=^(A,0) D:$Y>(IOSL-10) H2 Q:LR("Q")  W !,LR
 Q
EN ;
 Q  D Z G:Y=-1 END W !!,"This option deletes inappropriate transfusion requests",!,"that have been previously printed.  OK " S %=2 D YN^LRU G:%'=1 END
 W ! F A=0:0 S A=$O(^LRO(69.2,LRAA,8,66,1,A)) Q:'A  S C=0 D K
 W !,"DONE",! G END
K F B=0:0 S B=$O(^LRO(69.2,LRAA,8,66,1,A,1,B)) Q:'B  I $P(^(B,0),"^",4) K ^LRO(69.2,LRAA,8,66,1,A,1,B) S C=C+1 W "."
 Q:'C
 S X=^LRO(69.2,LRAA,8,66,1,A,1,0),Y=$P(X,"^",4)-C
 I Y<1 S V=^LRO(69.2,LRAA,8,66,1,A,0) K ^LRO(69.2,LRAA,8,66,1,A),^LRO(69.2,LRAA,8,66,1,"B",V,A) S Y=$O(^LRO(69.2,LRAA,8,66,1,0)) S:'Y Y=0 S X=^LRO(69.2,LRAA,8,66,1,0),^(0)=$P(X,"^",1,2)_"^"_Y_"^"_($P(X,"^",4)-1) Q
 S X(1)=$O(^LRO(69.2,LRAA,8,66,1,A,1,0)) S:'X(1) X(1)=0 S ^LRO(69.2,LRAA,8,66,1,A,1,0)=$P(X,"^",1,2)_"^"_X(1)_"^"_Y Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK",!?20 D I W !,LR("%") Q
H1 D H Q:LR("Q")  W !!?20,LRC(1) Q
H2 D H1 Q:LR("Q")  W ! S Y=+LRB D D^LRU W Y," ",$P(LRB,"^",2)," ",SSN Q
I W "Inappropriate transfusion requests report" Q
Z S X="BLOOD BANK" D ^LRUTL Q
END D V^LRU Q
