LADOWN1 ;DALOI/DG - UTILITY PARTS OF DOWNLOAD ;7/20/90  08:07
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,42,57**;Sep 27, 1994
 ;
BUILD ; Build a test expansion and codes into ^TMP
 ;
 N LAI,T,P1,P2,P3,S1,J1
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 K ^TMP($J)
 ;
 S LAI=0
 F  S LAI=$O(^LAB(62.4,LRINST,3,LAI)) Q:LAI'>0  D
 . S T=$G(^LAB(62.4,LRINST,3,LAI,0)),^TMP($J,+T,+T)=$P(T,"^",6)
 ;
 ; Expand the LL test.
 S P1=0
 F  S P1=$O(^LRO(68.2,LRLL,10,P1)) Q:P1'>0  D
 . S P2=0
 . F  S P2=$O(^LRO(68.2,LRLL,10,P1,1,P2)) Q:P2'>0  S P3=^(P2,0) D BU2
 ;
 Q
 ;
 ;
BU2 S (J,S1)=0,(T,X)=+P3
 D TREE
 Q
 ;
 ;
TREE ;
 ; Bad LRTEST number; from LREXPD
 I '$D(^LAB(60,X,0)) Q
 I $P(^LAB(60,X,0),U,5)]"",$D(^TMP($J,X,X)) S ^TMP($J,T,X)=^TMP($J,X,X)
 ; Not a panel
 Q:'$D(^LAB(60,X,2,0))  Q:$O(^(0))<1
 ;
 S S1=S1+1,S1(S1)=X,J1(S1)=J
 F J=0:0 S J=$O(^LAB(60,S1(S1),2,J)) Q:J<1  S X=+^(J,0) D TREE
 S J=J1(S1),X=S1(S1),S1=S1-1
 ;
 Q
