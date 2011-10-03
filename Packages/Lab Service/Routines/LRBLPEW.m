LRBLPEW ;AVAMC/REG - BB WORKLOAD ;3/9/94  13:09
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S:LRLLOC="" LRLLOC="UNKNOWN"
 I '$D(^LRO(69.2,LRAA,3,LRDFN,0)) S ^(0)=LRDFN_"^"_LRLLOC,^LRO(69.2,LRAA,3,"C",LRLLOC,LRDFN)="",X=^LRO(69.2,LRAA,3,0),^(0)=$P(X,"^",1,2)_"^"_LRDFN_"^"_($P(X,"^",4)+1)
 S LRY=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0),LRV=$P(LRY,"^",5)
 I LRV,$O(^(0)),'LRW K ^LRO(68,LRAA,1,LRAD,1,"AD",$P(LRV,"."),LRAN),^LRO(68,LRAA,1,LRAD,1,"AC",LRV,LRAN) Q
 D DT^LRBLU
 S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)=$P(LRY,"^")_"^"_$P(LRY,"^",2)_"^"_$P(LRY,"^",3)_"^"_DUZ_"^"_LRK_"^",$P(^LR(LRDFN,LRSS,LRI,0),"^",3)=LRK,^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)=""
 S ^LRO(68,LRAA,1,LRAD,1,"AD",$P(LRK,"."),LRAN)="",^LRO(68,LRAA,1,LRAD,1,"AC",LRK,LRAN)=""
 S Y=^LRO(68,LRAA,1,LRAD,1,LRAN,0),Y(4)=$P(Y,"^",4),Y(5)=$P(Y,"^",5)
 I Y(4),Y(5),$D(^LRO(69,Y(4),1,Y(5),3)) S $P(^(3),"^",2)=LRK
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^" S LRF=^(0),(C,LRG)=0
 F A=0:0 S A=$O(^LAB(60,LRT,9,A)) Q:'A  I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,A,0)) S ^(0)=A_"^1^0^^^"_LRK_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,LRG=LRG+1,C=A
 I LRG S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)=$P(LRF,"^",1,2)_"^"_C_"^"_($P(LRF,"^",4)+LRG)
 I 'LRW(2.1),$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,LRW(0,86250),0)) K ^(0) S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 D:LRW(2.4)!(LRW(2.6)) CMB D:DR="[LRBLPAG]" PH Q:'LRW
CAP K ^TMP($J)
 W !!,"Enter Antibody Identification Workload"
 S LR(62.07)=$P(LRT(LRT),U,3)
 I '$O(^LAB(62.07,LR(62.07),9,0)) W $C(7),!!,"No WKLD CODES to select for ",$P(^LAB(62.07,LR(62.07),0),U)," in EXECUTE CODE file." Q
 F LRA=0:0 S DIC="^LAB(62.07,LR(62.07),9,",DIC(0)="AEQM" D ^DIC K DIC Q:Y<1  D C S ^TMP($J,+Y)=X
 I '$D(^TMP($J)) W $C(7),!,"No WKLD CODES selected." Q
 W !!,"Count  WKLD CODES Selected: " F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S B=^(A),X=^LAM(A,0) S:'B B=1 W !,$J(B,2),?6,$P(X,U,2),?16,$P(X,U)
 W !,"WKLD CODES selected OK " S %=1 D YN^LRU Q:%<1  I %'=1 W !!,$C(7),"No WKLD codes selected.  Try again." G CAP
 S LRG=0 F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S B=^(A) I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,A,0)) S ^(0)=A_"^"_B_"^0^^^"_LRK_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,LRG=LRG+1,C=A
 I LRG S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+LRG)
 Q
CMB I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,LRW(0,86250),0)) S ^(0)=LRW(0,86250)_"^^0^^^"_LRK_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_LRW(0,86250)_"^"_($P(X,"^",4)+1)
 S X=1 S:LRW(2.4) X=X+1 S:LRW(2.6) X=X+1 S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,LRW(0,86250),0),"^",2)=X Q
 ;
C R !,"  Enter WKLD CODE COUNT if more than one: ",X:DTIME Q:X=""!(X[U)  I +X'=X!(X<2)!(X>20) W $C(7),!,"Enter a number from 2 to 20" G C
 Q
PH F A=1.1,1.2,1.3,1.4 F B=0:0 S B=$O(^LR(LRDFN,"BB",LRI,A,B)) Q:'B  F C=0:0 S C=$O(^LAB(61.3,B,9,C)) Q:'C  D STF
 Q
STF I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)) S X=^(0),$P(X,"^",2)=$S($P(X,"^",3):1,1:$P(X,"^",2)+1),$P(X,"^",3)=0,^(0)=X Q
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^" S X=^(0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1),^(C,0)=C Q
