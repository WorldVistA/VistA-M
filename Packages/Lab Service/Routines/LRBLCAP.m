LRBLCAP ;AVAMC/REG - BB CAP WORKLOAD ;3/3/93  14:31
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
L ;blood component log-in workload capture
 F A=0:0 S A=$O(L(A)) Q:'A  S C=+L(A) D SET
 Q
SET S:'$D(^LRD(65,C,9,0)) ^(0)="^65.3PA^^"
 I $D(^LRD(65,C,9,LRCAP,0)) S X=+$P(^(0),"^",5),^(0)=LRCAP_"^^^^"_W(5) K ^LRD(65,"AA",X,C,LRCAP) G CAP
 L +^LRD(65,C,9) S X=^LRD(65,C,9,0),^(0)=$P(X,"^",1,2)_"^"_LRCAP_"^"_($P(X,"^",4)+1),^(LRCAP,0)=LRCAP_"^^^^"_W(5) L -^LRD(65,C,9)
CAP S ^LRD(65,"AA",W(5),C,LRCAP)=$P(^LRD(65,C,0),"^") S:'$D(^LRD(65,C,9,LRCAP,1,0)) ^(0)="^65.31PA^^"
 L +^LRD(65,C,9,LRCAP,1) S A=0 F Y=0:0 S Z="",Y=$O(LRCAP(LRCAP,Y)) Q:'Y  S:$D(^LRD(65,C,9,LRCAP,1,Y,0)) Z=^(0) S B=$P(Z,"^",2)+1 S:Z="" A=A+1 S ^(0)=Y_"^"_B_"^0^"_$P(Z,"^",4)
 I A S X=^LRD(65,C,9,LRCAP,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)+A)
 L -^LRD(65,C,9,LRCAP,1) Q
 ;
L1 S LRCAP=$O(^LAB(60,"B","BLOOD COMPONENT LOG-IN",0)) I LRCAP F X=0:0 S X=$O(^LAB(60,LRCAP,9,X)) Q:'X  S LRCAP(LRCAP,+^(X,0))=""
 Q
