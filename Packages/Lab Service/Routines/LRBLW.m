LRBLW ;AVAMC/REG - STUFF WORKLOAD IN 65 ;11/5/93  10:38
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q:'LRCAPA!('LRT)  I '$D(LRCAPA(2))!('$D(LRCAPA(3))) D S
 S:'$D(^LRD(65,LRX,99,0)) ^(0)="^65.3PA^^" I '$D(^(LRT,0)) S ^(0)=LRT,X=^LRD(65,LRX,99,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRD(65,LRX,99,LRT,1,0)) ^(0)="^65.31DA^^" I '$D(^LRD(65,LRX,99,LRT,1,LRK,0)) S ^(0)=LRK_U_DUZ_U_DUZ(2)_U_LRCAPA(2)_U_LRCAPA(3),X=^LRD(65,LRX,99,LRT,1,0),^(0)=$P(X,U,1,2)_U_LRK_U_($P(X,U,4)+1)
 F C=0:0 S C=$O(LRT(C)) Q:'C  D STF
 S ^LRD(65,"AA",LRX,LRT,LRK)=$P(^LRD(65,LRX,0),"^") I '$D(^LRD(65,LRX,99,LRT,1,LRK,1,0)) K ^LRD(65,LRX,99,LRT,1,LRK) S X=^LRD(65,LRX,99,LRT,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 Q
STF I $D(^LRD(65,LRX,99,LRT,1,LRK,1,C,0)) S X=$P(^(0),"^",2) S:'X X=1 S X=X+1,$P(^(0),"^",2,3)=X_"^"_0 Q
 S:'$D(^LRD(65,LRX,99,LRT,1,LRK,1,0)) ^(0)="^65.311PA^^" S X=^(0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1),^(C,0)=C_"^"_1 Q
 ;
RS S LRT=LRW("S") F A=0:0 S A=$O(LRW("S",A)) Q:'A  S LRT(A)=""
 D DT^LRBLU,LRBLW K LRT Q
 ;
S S X=$G(^LAB(69.9,1,8.1,DUZ(2),0)),LRCAPA(2)=$P(X,"^",2),LRCAPA(3)=$P(X,"^",3) Q
 ;
EN ;from LRBLDX,LRBLDT
 W !,"Same date/time work completed for all entries " S %=2 D YN^LRU S:%=1 LRK("LRK")=1 Q
