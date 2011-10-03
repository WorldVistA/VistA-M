LRBLJPA ;AVAMC/REG/CYM - BB INVENTORY FINAL DISPOSITION ;6/20/96  09:22 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 I '$D(^LRO(69.2,LRAA,8,0)) S ^(0)="^69.31A^^"
 I '$D(^LRO(69.2,LRAA,8,65,0)) S ^(0)=65,X=^LRO(69.2,LRAA,8,0),^(0)="^69.31A^65^"_($P(X,"^",4)+1)
 W @IOF,?18,"INVENTORY- UNITS WITH FINAL DISPOSITION",!?21,"FROM ONE DATE RECEIVED TO ANOTHER",!
 S (%Y,%)="" I $O(^LRO(69.2,LRAA,8,65,1,0)) S X=$P(^LRO(69.2,LRAA,8,65,0),"^",4) W $C(7),!,"There is a list of units printed by ",$P(^VA(200,X,0),"^"),!,"They should be deleted before printing another list. OK " S %=1 D YN^LRU
 G:%Y["^" END I %=1 W !!,"Use supervisor option RU- Remove units with final disposition to delete list.",! G END
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 S ZTRTN="QUE^LRBLJPA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU K ^LRO(69.2,LRAA,8,65) S LR=0,^LRO(69.2,LRAA,8,65,0)=65_U_LRSTR_U_LRLST_U_DUZ,^(1,0)="^69.32A^^"
 F B=0:0 S LRSDT=$O(^LRD(65,"A",LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"A",LRSDT,LRI)) Q:'LRI  I $D(^LRD(65,LRI,4)),$P(^(4),"^")]"",$D(^(0)) S LRND=^(0) D:$P(LRND,"^",5)=LRSDT SET
 S A=$O(^LRO(69.2,LRAA,8,65,1,0)) S:'A A=0 S ^LRO(69.2,LRAA,8,65,1,0)="^69.32A^"_A_"^"_LR
 D ^LRBLJPA1
 D END^LRUTL,END Q
SET S LR=LR+1,^LRO(69.2,LRAA,8,65,1,LRI,0)=$P(LRND,"^"),^LRO(69.2,LRAA,8,65,1,"B",$P(LRND,"^"),LRI)="" Q
END D V^LRU K LRTABO,LRTRH,LRTINS Q
