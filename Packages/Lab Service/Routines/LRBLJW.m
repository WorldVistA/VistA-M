LRBLJW ;AVAMC/REG/CYM - INVENTORY ABO/RH WORKSHEET ;6/14/96  20:40 ;
 ;;5.2;LAB SERVICE;**72,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S LR("M")=1,X="BLOOD BANK" D ^LRUTL G:Y=-1 END S:'$D(^LRO(69.2,LRAA,6,0)) ^(0)="^69.26A^^"
 W !?24,"PRINT ABO/RH INVENTORY WORKSHEET",!!
 I $O(^LRO(69.2,LRAA,6,0)) W !,"List ABO/Rh worksheet entries " S %=2 D YN^LRU Q:%<1  I %=1 S LR("Q")=0 D L K ^TMP($J)
 W !,"Add/delete ABO/Rh worksheet entries " S %=2 D YN^LRU Q:%<1  D:%=1 C
 I '$O(^LRO(69.2,LRAA,6,0)) W $C(7),!!,"THERE ARE NO ENTRIES TO PRINT !" Q
 W !!,"Save list for repeat printing " S %=2 D YN^LRU Q:%<1  S:%=1 S=1
 S ZTRTN="QUE^LRBLJW" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S C(3)=0 D L^LRU,S^LRU,H S LR("F")=1
 S LRN=1 D L K:'$D(S) ^LRO(69.2,LRAA,6) D FT,END^LRUTL,END Q
WRK D:$Y>(IOSL-10) H1 Q:LR("Q")  W !,$J(C,3),")",?5,$P(LRI,"^"),?19,$J($P(LRI,"^",7),2),?23,$P(LRI,"^",8),?27,"|",?38,"|",?43,"|  |  |  |  |  |  |  |",!,LR("%") Q
 ;
S F LR=0:0 S LR=$O(^LRO(69.2,LRAA,6,LR)) Q:'LR  I $D(^LRD(65,LR,0)) S X=^(0),^TMP($J,$P(X,"^",3),$P(X,"^"),LR)=X
 Q
 ;
C W ! S DIC="^LRD(65,",DIC(0)="AEFQM",DIC("A")="Select Unit ID: ",DIC("S")="I $P(^(0),U,16)" D ^DIC K DIC Q:X=""!(X[U)  S LR=+Y
 I $D(^LRO(69.2,LRAA,6,LR)) W !?3,$P(Y,U,2)," is an entry for the ABO/RH INVENTORY WORKSHEET.",!?3,"Do you want to delete it " S %=2 D YN^LRU G:%'=1 C D D G C
 W !?3,"Do you want to add ",$P(Y,U,2)," to the ABO/RH INVENTORY WORKSHEET " S %=2 D YN^LRU G:%'=1 C
 S:'$D(^LRO(69.2,LRAA,6,0)) ^(0)="^69.26A^^"
 L +^LRO(69.2,LRAA,6):5 I '$T W $C(7),!!,"I can't add this to the worksheet now ",!!,"Someone else is editing this record",!! G C
 S X=^LRO(69.2,LRAA,6,0),^(0)=$P(X,U,1,2)_"^"_LR_"^"_($P(X,"^",4)+1),^LRO(69.2,LRAA,6,LR,0)=LR L -^LRO(69.2,LRAA,6)
 G C
D L +^LRO(69.2,LRAA,6):5 I '$T W $C(7),!!,"I can't delete this from the worksheet now",!!,"Someone else is editing this record",!! Q
 K ^LRO(69.2,LRAA,6,LR) S X=^LRO(69.2,LRAA,6,0),X(1)=$O(^(0)),^(0)=$P(X,U,1,2)_U_X(1)_U_$S(X(1)="":"",1:($P(X,U,4)-1)) L -^LRO(69.2,LRAA,6) Q
 ;
L D S S (A,C,E,F)=0
 F G=0:0 S F=$O(^TMP($J,F)) Q:F=""!(LR("Q"))  D:$D(LRN) INV S:$D(LRN) C=0 F B=0:0 S A=$O(^TMP($J,F,A)) Q:A=""!(LR("Q"))  F I=0:0 S I=$O(^TMP($J,F,A,I)) Q:'I!(LR("Q"))  S C=C+1,LRI=^(I) D @$S($D(LRN):"WRK",1:"W")
 Q
W W:C#2=1 ! W:C#2=0 ?40 W $J(C,2),") ",$P(LRI,"^"),"  ",$J($P(LRI,"^",7),2)," ",$P(LRI,"^",8) D:C#40=0 M Q
INV Q:LR("Q")  W !,"Invoice #: ",F Q
 ;
M W !,"'^' TO STOP: " R X:DTIME W $C(13),$J("",15),$C(13) S:'$T!(X[U) LR("Q")=1 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," INVENTORY ABO/Rh TESTING WORKSHEET"
 W !,"Incubator temp:",?28,"Reagent rack:",!,"Num",?5,"Donor ID",?18,"|Supplier",?27,"|VA interp",?38,"|    |---ANTI----|Rh|  |Du|"
 W !?18,"|ABO Rh",?27,"| ABO Rh",?38,"|tech",?42,"|A |B |AB| D|Ct|Du|Ct|",!,LR("%") Q
H1 D H,INV Q
FT S LRI=$O(^LAB(65.9,"B","INVENTORY WORKSHEET",0)) I 'LRI W !!,"INVENTORY WORKSHEET must be an entry in the LAB LETTER FILE (65.9)",!,"to print legend." Q
 D:$Y>(IOSL-6) H Q:LR("Q")  K ^TMP($J) S X=^LAB(65.9,LRI,0),DIWL=$P(X,U,5),DIWR=IOM-$P(X,U,6),DIWF="W"
 S LRA=0 F LRZ=0:1 S LRA=$O(^LAB(65.9,LRI,2,LRA)) Q:'LRA!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  S X=^LAB(65.9,LRI,2,LRA,0) D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW Q
END D V^LRU Q
