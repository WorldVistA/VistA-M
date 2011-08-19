LRBLPED1 ;AVAMC/REG/CRT - PEDIATRIC UNIT PREPARATION ;2/6/91  09:18 ; 11/28/00 10:31am
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 I $P(LRF,"^",12)=0 W $C(7),!,$P(LRF,"^",2)," Cannot use this unit.  Volume=0",!,"Please enter DISGARD in disposition field." Q
VOL I '$P(LRF,"^",12) S $P(LRF,"^",12)=LRV,$P(^LRD(65,+LRF,0),"^",11)=LRV
 S LRV(2)=$P(LRF,"^",12),X=LRV(2)*LRS,Y=$P(X,".",2)_"000",Z=$P(X,"."),LRG=$S($E(Y,1,3)>499:Z+1,1:Z),(DA,LRX)=+LRF
 W !!,$P(LRF,"^",2),?20,$J($P(LRF,"^",8),2)," ",$P(LRF,"^",9) S Y=$P(LRF,"^",7) D DT^LRU W ?28,Y,"  Vol(ml): ",LRV(2),"  Wt(gm): ",LRG
A W !?3,"VOL('W' to edit weight, 'V' to edit volume): ",LRV(2),"ml// " R X:DTIME Q:X[U!'$T  G:X="" PREP
 I X'="W"&(X'="V") W $C(7),!!,"To change the weight enter an 'E' or to change the volume enter a 'V'",!,"Press 'RETURN' or 'ENTER' key to accept default volume.",! G VOL
 D @X G VOL
 ;
PREP I LRV(2)<LRV(.6) W !!,$C(7),"Volume of unit is below ",LRV(.6)," ml.",!,"Do you still want to use it " S %=2 D YN^LRU Q:%'=1
 R !!,"Enter volume(ml) for pediatric unit: ",X:DTIME Q:X=""!(X[U)  I X<1!(X>LRV(.4))!(X[".")!(X>LRV(2)) W $C(7),!!,"Volume must be whole number from 1 to ",$S(X>LRV(2):LRV(2),1:LRV(.4)) G PREP
 S LRV(1)=X,B=0
 I $P(^LAB(66,+$P(^LRD(65,+LRF,0),"^",4),0),"^",29) D  ; ISBT-128!
 .S LRI=$P(LRF,"^",2)
 E  S A=$P(LRF,"^",2)_"P" F B=65:1:91 S LRI=A_$C(B) Q:'$D(^LRD(65,"B",LRI))  S Z=1 D CK Q:Z
 I B=91 W $C(7),"Sorry, the limit is 26 pediatric units from ",$P(LRF,"^",2),"." Q
 S LRABO=$P(LRF,"^",8),LRRH=$P(LRF,"^",9) W !!,LRI,"  ",LRABO," ",LRRH," vol(ml):",LRV(1)
DATE S %DT="AETX",%DT("A")="Expiration date: ",%DT(0)="N" D ^%DT K %DT Q:Y<1  I Y>LRE W $C(7),!?3,"Cannot exceed expiration date of selected unit." G DATE
 S LRE(1)=Y I LR(66,.135) S %DT="T",X="N" D ^%DT S (LRO(2),X1)=Y,X2=LR(66,.135) D C^%DTC I X>LRO(2),LRE(1)>X W $C(7),!?3,"Exceeds allowable expiration date" G DATE
 W !!,"OK to process pediatric unit " S %=2 D YN^LRU Q:%'=1
 D DT^LRBLU G ^LRBLPED2
CK F C=0:0 S C=$O(^LRD(65,"B",LRI,C)) Q:'C  I $P(^LRD(65,C,0),"^",4)=LRP S Z=0 Q
 Q
W R !,"Enter corrected weight in grams: ",X:DTIME Q:X=""!(X[U)  I X<1!(X>500)!(X[".") W !,$C(7),"Enter a whole number from 1 to 500" G W
 S X=X/LRS,Y=$P(X,".",2)_"000",Z=$P(X,"."),X=$S($E(Y,1,3)>499:Z+1,1:Z)
 S LRV=X,$P(LRF,"^",12)="" I X'=LRV(2) S O=LRV(2),Z="65,.11" D EN^LRUD
 Q
V R !,"Enter corrected volume in ml: ",X:DTIME Q:X=""!(X[U)  I X<1!(X>500)!(X[".") W !,$C(7),"Enter a whole number from 1 to 500" G V
 S LRV=X,$P(LRF,"^",12)="" I X'=LRV(2) S O=LRV(2),Z="65,.11" D EN^LRUD
 Q
