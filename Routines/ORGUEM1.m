ORGUEM1 ; slc/KCM - Build menu in seq #, name format ;2/5/92 17:16;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
SET(DA) ;From: ORGUEM Entry: DA  Exit: DA
 I $L($G(^ORD(101,DA,99))),$P($G(^(99)),"^")=$P($G(^XUTL("XQORM",DA_";"_$J,0)),"^") Q
 N ORCOL,ORCCOL,ORROW,ORCROW,ORPOS,ORTOT,S1,S2,X,X1
 K ^TMP("XQORM",$J) D KILL
 S ORCOL=1 I $P($G(^ORD(101,DA,4)),"^")>0 S ORCOL=80\$P(^(4),"^",1)
 S ^XUTL("XQORM",DA_";"_$J,"COL")=ORCOL,(ORTOT,S2)=0
 F  S S2=$O(^ORD(101,DA,10,S2)) Q:S2'>0  D
 . S X=^ORD(101,DA,10,S2,0)
 . S X=$S(+$P(X,"^",3):+$P(X,"^",3),+$P(X,"^",2):+$P(X,"^",2),$L($P(X,"^",2)):"M"_$P(X,"^",2),1:"Z"_$P(^ORD(101,+X,0),"^",2))
 . S ^TMP("XQORM",$J,X,S2)="",ORTOT=ORTOT+1
 S ORROW=ORTOT\ORCOL+$S(ORTOT#ORCOL:1,1:0),ORCCOL=1,ORCROW=0,S1=""
 F  S S1=$O(^TMP("XQORM",$J,S1)) Q:S1=""  S S2=0 D      ;S1 is sequence (#,M_,Z_)
 . F  S S2=$O(^TMP("XQORM",$J,S1,S2))  Q:S2'>0  D       ;S2 is IEN of item multiple
 . . S X=^ORD(101,DA,10,S2,0)                           ;X is the item node
 . . I '$D(^ORD(101,+X,0)) K ^ORD(101,DA,10,S2),^("B",+X,S2) S $P(^ORD(101,DA,10,0),"^",3,4)=S2_"^"_($P(^ORD(101,DA,10,0),"^",4)-1) Q
 . . S ORCROW=ORCROW+1 I ORCROW>ORROW S ORCROW=1,ORCCOL=ORCCOL+1
 . . S ORPOS=ORCROW+(ORCCOL/10) D
 . . . S X1=$TR($P(^ORD(101,+X,0),"^"),",=;-","    ") Q:'$L(X1)
 . . . S ^XUTL("XQORM",DA_";"_$J,ORPOS,0)=S2_"^"_+X_"^"_$E(X1,1,80\ORCOL-5)_"^"_$P(X,"^",3)
 . . . S ^XUTL("XQORM",DA_";"_$J,"B",$$UP(X1),ORPOS)=""
 . . . I $L($P(X,"^",3)) S ^XUTL("XQORM",DA_";"_$J,"B",$$UP($P(X,"^",3)),ORPOS)=1
 S ^XUTL("XQORM",DA_";"_$J,0)=$G(^ORD(101,DA,99))
 K ^TMP("XQORM",$J)
 Q
UP(X) ;Convert X to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
KILL ;From: File 101, Field 99  Entry: DA  Exit: DA
 K ^XUTL("XQORM",DA_";"_$J)
 Q
