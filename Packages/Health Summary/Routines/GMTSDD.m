GMTSDD ; SLC/KCM,KER - Health Summary DD calls ; 02/27/2002
 ;;2.7;Health Summary;**7,49**;Oct 20, 1995
 ;               
 ; External References
 ;   DBIA  2430  ^XUTL("XQORM")
 ;   DBIA 10018  ^DIE (file #142)
 ;   DBIA 10104  $$UP^XLFSTR
 ;                     
SET ; From: x-ref in 142,99      Entry: DA  Exit: DA
 ;                     
 ;   NOTE:  Lock ^XUTL("XQORM",XQORM) and 
 ;          ^GMT(142,DA) before calling
 ;                     
 N I,J,X,X0,X1,COL,CCOL,IEN,ORD,ROW,TOT,GMNAME
 I $D(^XUTL("XQORM",DA_";GMT(142,",0)),$D(^GMT(142,DA,99)),($P(^GMT(142,DA,99),"^",1)=$P(^XUTL("XQORM",DA_";GMT(142,",0),"^",1)) Q
 K ^TMP("XQORM",$J) D KILL S TOT=0
 S IEN=0 F  S IEN=$O(^GMT(142,DA,1,IEN)) Q:IEN'>0  I $D(^GMT(142,DA,1,IEN,0)) S X=^(0) I $D(^GMT(142.1,+$P(X,"^",2),0)),($P(^(0),"^",6)'="P"),($P(^(0),U,6)'="T") S TOT=TOT+1,GMNAME=$P($G(^(0)),U) D ORD
 S COL=$S(TOT\2>20:3,1:2),X=TOT\COL S:TOT#COL X=X+1 S ROW=X,CCOL=.1,^XUTL("XQORM",DA_";GMT(142,","COL")=COL
 S ORD="" F  S ORD=$O(^TMP("XQORM",$J,ORD)) Q:ORD=""  D
 . S IEN=0 F  S IEN=$O(^TMP("XQORM",$J,ORD,IEN)) Q:+IEN'>0  S CCOL=$S((CCOL\1)'<ROW:1+($P(CCOL,".",2)/10)+.1,1:CCOL+1) D BILD
 S X=$H,(^XUTL("XQORM",DA_";GMT(142,",0),^GMT(142,DA,99))=X
 K ^TMP("XQORM",$J) Q
ORD ; Summary Order
 S ^TMP("XQORM",$J,GMNAME,IEN)=""
 Q
BILD ; Build XQORM array
 S X0=^GMT(142,DA,1,IEN,0) Q:'$P(X0,"^",2)
 S X1=^GMT(142.1,$P(X0,"^",2),0),X=$S($L($P(X0,U,5)):$P(X0,U,5),$L($P(X1,"^",9)):$P(X1,"^",9),1:$E($P(X1,"^",1),1,19))
 F %=1:1:$L(X) I ",=;-"[$E(X,%) S X=$E(X,1,%-1)_" "_$E(X,%+1,999)
 S ^XUTL("XQORM",DA_";GMT(142,",CCOL,0)=IEN_"^"_$P(X0,"^",1)_"^"_X_"^"_$P(X1,"^",4)
 I $L(X) S X=$$UP^XLFSTR(X),^XUTL("XQORM",DA_";GMT(142,","B",X,CCOL)=""
 S X=$P(X1,"^") I $L(X) S X=$$UP^XLFSTR(X),^XUTL("XQORM",DA_";GMT(142,","B",X,CCOL)=1
 S X=$P(X1,"^",4) I $L(X) S X=$$UP^XLFSTR(X),^XUTL("XQORM",DA_";GMT(142,","B",X,CCOL)=1
 Q
KILL ; From: x-ref in 142,99       Entry: none   Exit: none
 K ^XUTL("XQORM",DA_";GMT(142,")
 Q
REDO ; From: 142.1,.01 142.1,3     Entry: DA     Exit: DA
 N I,X S X=$H S I=0
 F  S I=$O(^GMT(142,"AE",DA,I)) Q:I'>0  D
 . I $D(^GMT(142,I,99)) S $P(^(99),"^",1)=X
 Q
REDOX ; From: 142.01,.01 142.01,1   Entry: DA(1)  Exit: DA(1)
 I $D(^GMT(142,DA(1),0)) S ^(99)=$H
 Q
CLEANUP ; Delete broken pointers from 142.01 to 142.1
 N %,%Y,D0,DI,DIC,DIJ,DIKS,DISYS,DR,DIE,GMDA,GMI,GMJ,X,Y
 S GMDA=+GMCMP,GMI=0 F  S GMI=$O(^GMT(142,"AE",GMDA,GMI)) Q:+GMI'>0  D
 . W !,"Deleting pointers from the "_$P(^GMT(142,+GMI,0),U)_" Health Summary Type"
 . S GMJ=0 F  S GMJ=$O(^GMT(142,"AE",GMDA,GMI,GMJ)) Q:+GMJ'>0  D
 . . S DIE="^GMT(142,"_GMI_",1,",DR=".01///@",DA=GMJ,DA(1)=GMI D ^DIE W "."
 Q
CHKNAME ; Called by input transform on ^DD(142.1,.01,0)
 I $D(^GMT(142.1,"B",X)),($G(Y)=-1) D
 . W "   Duplicate NAMES not allowed." K X
 Q
CHKRTN ; Called by input transform on ^DD(142.1,1,0)
 I @("$L($T("_$P(X,";")_U_$P(X,";",2)_"))'>0") D
 . W "   Nonexistent ENTRY POINT" K X
 Q
CHKNUM ; Called by input transform of ^DD(142.1,.001,0)
 I $S('$D(DUZ(2)):0,$G(DUZ(2))'=5000:1,1:0) D
 . I $S(X<100001:1,X>9999999:1,1:0) W "  # Out of Range" K X
 Q
