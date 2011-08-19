GMTSXQ12 ; SLC/JER - XQORMX for Export w/Health Summary ;1/10/92  15:10
 ;;2.5;Health Summary;;Dec 16, 1992
XQORMX ; SLC/KCM - Build formatted menus ; 5/2/89  14:55 ;
 ;;6.52;Copyright 1990, DVA;
SET ;From: XQORM (when navigating file 19)  Entry: DA  Exit: DA
 ;NOTE:  Lock ^DIC(19,DA) when calling
 N X I $D(^XUTL("XQORM",DA_";DIC(19,",0)),$D(^DIC(19,DA,99)),($P(^DIC(19,DA,99),"^",1)=$P(^XUTL("XQORM",DA_";DIC(19,",0),"^",1)) Q
 K ^UTILITY("XQORM",$J),^XUTL("XQORM",DA_";DIC(19,")
 S ORMN=1,^XUTL("XQORM",DA_";DIC(19,","COL")=ORMN,ORMT=0
 F ORM=0:0 S ORM=$O(^DIC(19,DA,10,ORM)) Q:ORM'>0  I $D(^DIC(19,DA,10,ORM,0)) S ORMX=^(0) D ORD
 S ORM=ORMT\ORMN S:ORMT#ORMN ORM=ORM+1 S ORMT=ORM,ORMC=.1
 S ORMI="" F ORM=0:0 S ORMI=$O(^UTILITY("XQORM",$J,ORMI)) Q:ORMI=""  F ORM=0:0 S ORM=$O(^UTILITY("XQORM",$J,ORMI,ORM)) Q:ORM'>0  I $D(^DIC(19,DA,10,ORM,0)) S ORMX=^(0),ORMC=$S((ORMC\1)'<ORMT:1+($P(ORMC,".",2)/10)+.1,1:ORMC+1) D BILD
 I $D(^DIC(19,DA,99)) S ORM=$P(^(99),"^",1),^XUTL("XQORM",DA_";DIC(19,",0)=ORM
 K ORM,ORMX,ORMN,ORMT,ORMC,ORMI,^UTILITY("XQORM",$J) Q
ORD S ORMI=$S(+$P(ORMX,"^",3):+$P(ORMX,"^",3),+$P(ORMX,"^",2):+$P(ORMX,"^",2),$L($P(ORMX,"^",2)):"M"_$P(ORMX,"^",2),1:"Z"_$S($D(^DIC(19,+$P(ORMX,"^",1),0)):$P(^(0),"^",2),1:"")) S ^UTILITY("XQORM",$J,ORMI,ORM)="",ORMT=ORMT+1
 Q
BILD S X=$S($D(^DIC(19,+$P(ORMX,"^",1),0)):$P(^(0),"^",2),1:"")
 F %=1:1:$L(X) I ",=;-"[$E(X,%) S X=$E(X,1,%-1)_" "_$E(X,%+1,999)
 S ^XUTL("XQORM",DA_";DIC(19,",ORMC,0)=ORM_"^"_$P(ORMX,"^",1)_"^"_X_"^"_$P(ORMX,"^",2)
 I $L(X) D UP S ^XUTL("XQORM",DA_";DIC(19,","B",X,ORMC)=""
 S X=$P(ORMX,"^",2) I $L(X) D UP S ^XUTL("XQORM",DA_";DIC(19,","B",X,ORMC)=1
 Q
UP F %=1:1:$L(X) I $E(X,%)?1L S X=$E(X,1,%-1)_$C($A(X,%)-32)_$E(X,%+1,99)
 Q
