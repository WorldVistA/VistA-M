LRBLDRR1 ;AVAMC/REG/CYM - LABEL-RELEASE COMPONENTS COND'T ;11/5/97  09:28 ;
 ;;5.2;LAB SERVICE;**72,90,97,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
A W !!,"Select COMPONENT by number (",B," choice",$S(B=1:"",1:"s"),"): " R X:DTIME I X[U!(X="") D FRE Q
 I X'?1N.N!(X<1)!(X>B) W $C(7),!?5,"Enter a number up to ",B G A
 W " ",$P(F(X),U,4) I '$L($P(F(X),"^",5))!('$L($P(F(X),"^",6))) W $C(7),!,"No Date/time Stored &/or Expiration date entered." D FRE Q
 S C=$P(F(X),"^",7),C(9)=$P(F(X),"^",8)
 I $P(F(X),U,9) W $C(7),!,$S($P(F(X),U,9)=2:"Discarded",1:"Quarantine") Q:'$D(^XUSEC("LRBLSUPER",DUZ))  W !,"Do you want to delete DISPOSITION " S %=2 D YN^LRU G:%=1 EN^LRBLDRR2 D FRE Q
 I $P(F(X),U,3)]"" W !,"Component already released to inventory" D FRE Q
 S Y(1)=$P(F(X),U,2),Y(1)=$S(Y(1)="":"",Y(1):Y(1),1:+$P(Y(1),"(",2))
 I Y(1)="" W !,"OK to label component " S %=1 D YN^LRU D:%<1 FRE Q:%<1  D:%=1 L Q:'LR&(%=1)  I %=2 W !,"QUARANTINE or DISCARD component " S %=2 D YN^LRU D:%=1 ^LRBLDRR2 D FRE Q
 S X=0 F A=12,13,14,16,18,19 S A(1)=$P(LRB(A),":"_LRJ(A)_";") I $E(A(1),$L(A(1)))=1 S X=1 Q
 I X=0 F A=17,20 I $G(LRH(A)) S A(1)=$P(LRB(A),":"_LRJ(A)_";") I $E(A(1),$L(A(1)))=1 S X=1 Q
 I X S LRQ("X")=1 I LRQ("S")'="A" W !!?15,$C(7),"Component should not be released- Unit quarantined.",! S $P(^LRE(LRQ,5,LRI,0),"^",10)=1 D ^LRBLDRR2 D FRE Q
 S X=0 F A=12,13,14,16,18,19 I LRJ(A)=""!(LRJ(A)="NOT DONE") S X=1 Q
 I X=0 F A=17,20 I $G(LRH(A)),LRJ(A)=""!(LRJ(A)="NOT DONE") S X=1 Q
 I X W $C(7),!!,"Testing not completed.  OK to continue " S %=2 D YN^LRU D:%=2 FRE Q:%=2  S LRQ("X")=1
 I 'LR,DUZ=Y(1) W !,$C(7),"Since you labeled component someone else must release to inventory" D FRE Q
 S E=$P(^LRE(LRQ,5,LRI,66,C,0),"^",4) I 'E W $C(7),!,"No expiration date entered for component" D FRE Q
X S LRABO="" K X R !?14,"ABO/Rh LABEL: ",X:DTIME Q:X=""!(X[U)  I LR,$E(X,1,$L(LR(2)))=LR(2) D A^LRBLB I '$D(X) W !,$C(7),"No such ABO/Rh bar code",! G X
 I LRABO="" D T^LRBLB G:'$D(X) X
 S X=LRABO_" "_LRRH I X'=V(12) W $C(7),!!,"ABO/Rh label does NOT match ABO/Rh of unit",! G X
 S X=^LRE(LRQ,5,LRI,0) I $P(X,"^",11)="A",$P(X,"^",12)="" W $C(7),!,"Cannot release autologous unit without assigning unit to a patient." D FRE Q
 W !,"OK to release component " S %=1 D YN^LRU D:%<1 FRE Q:%<1  G:%=2 ^LRBLDRR2
 I $D(^LRD(65,"AI",C,LRG)) W !,"Component in inventory" D FRE Q
 S X="N",%DT="T" D ^%DT L +^LRD(65,0):5 I '$T W $C(7),!!,"I can't do this now... Someone else has this record.  Try again later...",!! Q
 S LRX=$P(^LRD(65,0),U,3) F B=0:0 S LRX=LRX+1 Q:'$D(^LRD(65,LRX))
 N NODE,VOL
 S NODE=$G(^LRE(LRQ,5,LRI,66,C,0)) S VOL=$P(NODE,U,5)
 S LRK=Y,X=^LRD(65,0),^(0)=$P(X,U,1,2)_U_LRX_U_($P(X,U,4)+1),^LRD(65,LRX,0)=LRG_"^SELF^00^"_C_U_Y_U_E_U_V(10)_U_V(11)_"^^^"_VOL_"^^^^^"_DUZ(2) L -^LRD(65,0) S:LRV]"" $P(^(0),U,15)=LRV S:LRQ("X") ^LRD(65,LRX,8)="^1^"
 S ^LRD(65,"D",DUZ(2),LRX)="",^LRD(65,"B",LRG,LRX)="",^LRD(65,"AI",C,LRG,E,LRX)="",^LRD(65,"A",Y,LRX)="",^LRD(65,"AE",C,E,LRX)=""
 I LRQ("S")]"","DA"[LRQ("S") S ^LRD(65,LRX,8)=LRQ("D")_"^"_LRQ("X")_"^"_LRQ("S"),^LRD(65,"AU",LRQ("D"),LRX)=""
 S X=$P(^LAB(69.9,1,0),"^",18)+1 I $L(LRG)>4,X>1 S ^LRD(65,"C",$E(LRG,X,$L(LRG)),LRX)=""
 S X=^LRE(LRQ,5,LRI,66,C,0),^(0)=$P(X,U,1)_U_Y_U_$P(X,U,3)_U_E_U_$P(X,U,5)_U_$P(X,U,6)_U_DUZ_U_0
 I LRA S ^LRD(65,LRX,10)=$S($D(^LRE(LRQ,5,LRI,10)):$P(^LRE(LRQ,5,LRI,10),"^",1,3)_"^"_1,1:""),^LRD(65,LRX,11)=$S($D(^LRE(LRQ,5,LRI,11)):$P(^LRE(LRQ,5,LRI,11),"^",1,3)_"^"_1,1:"")
 D:C(9)=1 B I LRCAPA S LRT=+LRW("LG") F A=0:0 S A=$O(LRW("LG",A)) Q:'A  S LRT(A)=""
 D:LRCAPA ^LRBLW K LRT Q
B L +^LRD(65,LRX,60):5 I '$T W $C(7),!,"I cannot ADD the Antigen typings to the Inventory file.  Someone else is editing this record...",!!,"Use the Inventory-Unit Phenotyping option to enter typing results ",!! G B1
 S A=0 F B=0:1 S A=$O(^LRE(LRQ,1.1,A)) Q:'A  S ^LRD(65,LRX,60,A,0)=A
 I B S ^LRD(65,LRX,60,0)="^65.04PA^"_B_"^"_B
 L -^LRD(65,LRX,60)
B1 L +^LRD(65,LRX,70):5 I '$T W $C(7),!,"I cannot DELETE the Antigen typings from the Inventory file.  Someone else is editing this record...",!!,"Use the Inventory-Unit Phenotyping option to enter typing results",!! G B2
 S A=0 F B=0:1 S A=$O(^LRE(LRQ,1.2,A)) Q:'A  S ^LRD(65,LRX,70,A,0)=A
 I B S ^LRD(65,LRX,70,0)="^65.05PA^"_B_"^"_B
 L -^LRD(65,LRX,70)
B2 L +^LRD(65,LRX,80):5  I '$T W $C(7),!,"I cannot ADD the HLA Antigen typings to the Inventory file.  Someone else is editing this record...",!!,"Use the Inventory-Unit Phenotyping option to enter typing results ",!! G B3
 S A=0 F B=0:1 S A=$O(^LRE(LRQ,1.3,A)) Q:'A  S ^LRD(65,LRX,80,A,0)=A
 I B S ^LRD(65,LRX,80,0)="^65.08PA^"_B_"^"_B
 L -^LRD(65,LRX,80)
B3 L +^LRD(65,LRX,90):5 I '$T W $C(7),!,"I cannot DELETE the HLA Antigen typings from the Inventory file.  Someone else is editing this record...",!!,"Use the Inventory-Unit Phenotyping option to enter typing results ",!! G F
 S A=0 F B=0:1 S A=$O(^LRE(LRQ,1.4,A)) Q:'A  S ^LRD(65,LRX,90,A,0)=A
 I B S ^LRD(65,LRX,90,0)="^65.09PA^"_B_"^"_B
 L -^LRD(65,LRX,90)
F D:'LRA EN Q
L S $P(^LRE(LRQ,5,LRI,66,$P(F(X),"^",7),0),"^",6)=DUZ I $P(F(X),"^",10) S Y="RR" D:LRCAPA SET^LRBLWD S %=1
 D FRE Q
EN ;from LRBLJD,LRBLPED2
 L +^LRO(69.2,LRAA,6):5 I '$T W $C(7),!!,"I cannot add this unit to the ABO/Rh Testing Worksheet",!!,"Please be sure to add it manually when requesting the worksheet.",!! Q
 S:'$D(^LRO(69.2,LRAA,6,0)) ^(0)="^69.26A^^" S Y=^(0) Q:$D(^(LRX))  S ^LRO(69.2,LRAA,6,0)=$P(Y,"^",1,2)_"^"_LRX_"^"_($P(Y,"^",4)+1),^(LRX,0)=LRX L -^LRO(69.2,LRAA,6)
 Q
FRE L -^LRE(LRQ,5,LRI) Q
