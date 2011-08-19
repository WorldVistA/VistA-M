LRBLJTS ;AVAMC/REG - TRANSFUSION STATISTICS ;4/12/93  15:19 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?10,"Transfusion by treating specialty/physician",!
A R !!,"Start with TREATING SPECIALTY: FIRST// ",X:DTIME G:'$T!(X[U) END I X="" S LRA="/" G B
 S DIC="^DIC(45.7,",DIC(0)="EQM" D ^DIC K DIC G:Y<1 A S X=$P(Y,"^",2),A=$A(X,$L(X))-1,A=$C(A),LRA=$E(X,1,$L(X)-1)_A_"z"
B R !,"Go    to   TREATING SPECIALTY: LAST// ",X:DTIME G:'$T!(X[U) END I X="" S LRB="{" G C
 S DIC="^DIC(45.7,",DIC(0)="EQM" D ^DIC K DIC G:Y<1 B S LRB=$P(Y,"^",2)
C R !!,"Within TREATING SPECIALTY  Start with BLOOD COMPONENT: FIRST// ",X:DTIME G:'$T!(X[U) END I X="" S LRC="/" G D
 S DIC="^LAB(66,",DIC(0)="EQM" D ^DIC K DIC G:Y<1 C S X=$P(Y,"^",2),A=$A($E(X,$L(X)))-1,A=$C(A),LRC=$E(X,1,$L(X)-1)_A_"z"
D R !,"Within TREATING SPECIALTY  Go    to   BLOOD COMPONENT: LAST// ",X:DTIME G:'$T!(X[U) END I X="" S LRE="{" G E
 S DIC="^LAB(66,",DIC(0)="EQM" D ^DIC K DIC G:Y<1 D S LRE=$P(Y,"^",2)
E W !! D B^LRU Q:Y<0  S X=LRSDT,Y=LRLDT,LRQ(1)="("_+$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_"-"_+$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(X,2,3)_")"
 S ZTRTN="QUE^LRBLJTS" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRF("?")="?",LRSDT=LRSDT-.0001,LRLDT=LRLDT+.9999,X=$P(^DD(66,.26,0),U,3) F A=1:1 S B=$P(X,";",A) Q:B=""  S LRF($P(B,":"))=$P(B,":",2)
 D L^LRU,S^LRU,^LRBLJTS1
 D END^LRUTL,END Q
 ;
END D V^LRU Q
