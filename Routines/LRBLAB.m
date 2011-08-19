LRBLAB ;AVAMC/REG - BB ADM DATA ;4/18/93  07:45
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S X(1)=$P($G(^LRD(65,C,9,0)),"^",4) Q:'X(1)  I X(1)>1 S X=X(1) Q
 S X(1)=$O(^LRD(65,C,9,0)),X(1)=^(X(1),0),X(2)=$P(X(1),"^",2),X(1)=+X(1),(X(5),X(3))=0
 F  S X(3)=$O(^LRD(65,"B",X(2),X(3))) Q:'X(3)  I $P($G(^LRD(65,X(3),0)),"^",4)=X(1) S X(5)=1 Q
 Q:'X(5)  S X(4)=$P($G(^LRD(65,X(3),9,0)),"^",4)-1 S:X(4)>1 X=X(4) Q:X(4)'=1
 S X(1)=$G(^LRD(65,X(3),9,1,0)) Q:$P(X(1),"^",3)'=1  S X(2)=$P(X(1),"^",2),X(1)=+X(1)
 S (X(3),X(5))=0 F  S X(3)=$O(^LRD(65,"B",X(2),X(3))) Q:'X(3)  I $P($G(^LRD(65,X(3),0)),"^",4)=X(1) S X(5)=1 Q
 Q:'X(5)  S X(4)=$P($G(^LRD(65,X(3),9,0)),"^",4)-1 S:X(4)>1 X=X(4) Q
