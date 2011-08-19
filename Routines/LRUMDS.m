LRUMDS ;AVAMC/REG - MD SELECTED PATIENT GROUPS ;10/15/91  19:22 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!?19,"1. Single patient",!?19,"2. Group of patients",!?19,"3. Patients for a ward",!?19,"4. Patients for a clinic" R !,"Select 1,2,3 or 4: ",X:DTIME I X=""!(X[U) K X Q
 I X<1!(X>4) W $C(7) G LRUMDS
 G EN1:X=2,W:X=3,C:X=4
S W ! K DIC D ^LRDPA K DIC I LRDFN<1 K X Q
 S LRDFN(1)=LRDFN,Z="P" Q
W W ! S DIC=42,DIC(0)="AEQM",DIC("A")="Select WARD: " D ^DIC K DIC I Y<1 K X Q
 S LRG=$P(Y,U,2) Q
C W ! S DIC=44,DIC(0)="AEQM",DIC("S")="I $P(^(0),U,3)=""C""",DIC("A")="Select CLINIC: " D ^DIC K DIC I Y<1 K X Q
 S LRE(1)=$P(Y,U,2),LRE=+Y
D S %DT="AEXQ",%DT("A")="Select CLINIC DATE: " D ^%DT I Y<1 S LRE="" K LRE(1),X Q
 S (Z,X)=Y D DW^%DTC S Y=Z,Z=X W " ",Z
 I $P($O(^SC(LRE,"S",Y)),".")'=Y S A=Y,X="T",%DT="" D ^%DT S T=Y,Y=A,X=$S(A<T:"did",1:"does") D D^LRU W $C(7),!?2,LRE(1) W:LRE(1)'["CLINIC" " clinic" W " ",X,"n't meet on ",Z," ",Y G D
 S LRE(2)=Y Q
EN1 ;from LRUMD2
 S A=0 F Y=1:1 S A=$O(^LRO(69.2,LRAA,7,DUZ,1,"D",A)) Q:A=""  S A(Y)=A W !?21,Y,". ",A
 I Y=1 W $C(7),!,"You have no groups to select from." K X Q
 R !,"Select group number: ",X:DTIME I X=""!(X[U) K X Q
 I X<1!(X>(Y-1))!(+X'=X) W !,$C(7),"Select a number from 1-",Y-1 G EN1
 S Z="P",LRA=A(X) K A Q
EN ; from LRUMD
 I '$O(^LRO(69.2,LRAA,7,DUZ,60,0)) S %=1 Q
 W !,"Print ALL test lists " S %=1 D YN^LRU Q:%<2
SEL W !!,"Enter test list number(s): " R X:DTIME I X=""!(X[U) S %=0 Q
 I X["?" W !,"Enter your test list numbers",!,"For 2 or more selections separate each with a ',' (ex. 1,3,4 ).",!!,"Your test list numbers are:" F Y=0:0 S Y=$O(^LRO(69.2,LRAA,7,DUZ,60,Y)) Q:'Y  W "  ",Y
 I X["?" W !!,"To see the tests for the above numbers use the",!,"'Enter/edit user defined lab test lists' option." G SEL
 I X?.E1CA.E!($L(X)>200) W $C(7),!,"No CONTROL CHARACTERS, LETTERS or more than 200 characters allowed." G SEL
 I '+X W $C(7),!,"START with a NUMBER !!",! G SEL
 F Y(1)=0:0 S Y=+X,X=$E(X,$L(Y)+2,$L(X)) S:$D(^LRO(69.2,LRAA,7,DUZ,60,Y)) LR(Y)="" Q:'$L(X)
 Q
