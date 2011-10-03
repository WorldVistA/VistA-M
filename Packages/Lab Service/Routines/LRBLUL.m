LRBLUL ;AVAMC/REG - BB UTIL ;4/13/93  07:17 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;from input transform 65,.01
 S X(1)=+$P($G(^LRD(65,DA,0)),"^",4),X(2)=0 F  S X(2)=$O(^LRD(65,"B",X,X(2))) Q:'X(2)  I $P(^LRD(65,X(2),0),"^",4)=X(1) D W Q
 Q
C ; from input transform 65,.04
 S X(1)=$P(^LRD(65,DA,0),U),X(2)=0 F  S X(2)=$O(^LRD(65,"B",X(1),X(2))) Q:'X(2)  I $P(^LRD(65,X(2),0),"^",4)=X D W Q
 Q
 ;
W W $C(7),!,$P(^LAB(66,$P(^LRD(65,X(2),0),U,4),0),U)," unit already exists in inventory" K X Q
