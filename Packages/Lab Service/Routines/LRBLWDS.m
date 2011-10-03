LRBLWDS ;AVAMC/REG - STUFF WORKLOAD IN 65.5 ;3/3/93  14:37
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S:'$D(^LRE(LRQ,5,LRI,99,0)) ^(0)="^65.599PA^^" I '$D(^(LRT,0)) S ^(0)=LRT,X=^LRE(LRQ,5,LRI,99,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRE(LRQ,5,LRI,99,LRT,1,0)) ^(0)="^65.5991DA^^" I '$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,0)) S ^(0)=LRK_"^"_DUZ,X=^LRE(LRQ,5,LRI,99,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_LRK_"^"_($P(X,"^",4)+1)
 F LR("W")=0:0 S LR("W")=$O(LRT(LR("W"))) Q:'LR("W")  D STF
 S ^LRE("AA",LRQ,LRI,LRT,LRK)=$P(^LRE(LRQ,5,LRI,0),"^",4) I '$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0)) K ^LRE(LRQ,5,LRI,99,LRT,1,LRK) S X=^LRE(LRQ,5,LRI,99,LRT,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 D:LR(60,320) CAP Q
STF I $D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,LR("W"),0)) S X=$P(^(0),"^",2) S:'X X=1 S X=X+1,$P(^(0),"^",2,3)=X_"^"_0 Q
 S:'$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0)) ^(0)="^65.59911PA^^" S X=^(0),^(0)=$P(X,"^",1,2)_"^"_LR("W")_"^"_($P(X,"^",4)+1),^(LR("W"),0)=LR("W")_"^"_1 Q
 ;
CAP K ^TMP($J) I '$O(^LAB(62.07,LR(60,320),9,0)) W $C(7),!!,"No WKLD CODES to select from for ",$P(^LAB(62.07,LR(60,320),0),U)," in EXECUTE CODE file." Q
 F LRA=0:0 S DIC="^LAB(62.07,LR(60,320),9,",DIC(0)="AEQM",DIC("A")="Select "_$P(^LAB(62.07,LR(60,320),0),U)_" WKLD CODES: " D ^DIC K DIC Q:Y<1  D C S ^TMP($J,+Y)=X
 I '$D(^TMP($J)) W $C(7),!,"No WKLD CODES selected." Q
 W !!,"Count  WKLD CODES Selected: " F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S B=^(A),X=^LAM(A,0) S:'B B=1 W !,$J(B,2),?6,$P(X,U,2),?16,$P(X,U)
 W !,"WKLD CODES selected OK " S %=1 D YN^LRU Q:%<1  I %'=1 W !!,$C(7),"No WKLD codes selected.  Try again." G CAP
 S LRG=0 F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S B=^(A) I '$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,A,0)) S ^(0)=A_"^"_B,LRG=LRG+1,C=A
 I LRG S X=^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+LRG)
 Q
C R !,"  Enter WKLD CODE COUNT if more than one: ",X:DTIME Q:X=""!(X[U)  I +X'=X!(X<2)!(X>20) W $C(7),!,"Enter a number from 2 to 20" G C
 Q
