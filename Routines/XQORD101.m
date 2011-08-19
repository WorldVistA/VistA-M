XQORD101 ; slc/KCM - Build menus in XUTL (file 101) ;9/24/98  16:40
 ;;8.0;KERNEL;**98**;Sept. 24,1998
SET ;From: Cross reference in file 101, field 99  Entry: DA  Exit: DA
 ;NOTE:  Lock ^ORD(101,DA) when calling
 Q:$D(^ORD(101,DA,0))[0
 I $D(^ORD(101,DA,99)),$D(^XUTL("XQORM",DA_";ORD(101,",0)),$P(^ORD(101,DA,99),"^")=$P(^XUTL("XQORM",DA_";ORD(101,",0),"^") Q
 N ORCOL,ORCCOL,ORROW,ORCROW,ORPOS,ORTOT,S1,S2,X,X1
 K ^TMP("XQORM",$J) D KILL
 S ORCOL=1 I $P($G(^ORD(101,DA,4)),"^")>0 S ORCOL=80\$P(^(4),"^",1)
 S ^XUTL("XQORM",DA_";ORD(101,","COL")=ORCOL,(ORTOT,S2)=0
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
 . . . S X1=$S($L($P(X,"^",6)):$P(X,"^",6),1:$P(^ORD(101,+X,0),"^",2)),X1=$TR(X1,",=;-","    ") Q:'$L(X1)
 . . . S ^XUTL("XQORM",DA_";ORD(101,",ORPOS,0)=S2_"^"_+X_"^"_X1_"^"_$P(X,"^",2)_"^"_$P(X,"^",5)
 . . . I $P(X,"^",5)'="O" D
 . . . . S ^XUTL("XQORM",DA_";ORD(101,","B",$$UP(X1),ORPOS)=""
 . . . . I $L($P(X,"^",2)) S ^XUTL("XQORM",DA_";ORD(101,","B",$$UP($P(X,"^",2)),ORPOS)=1
 . . . . I $D(^ORD(101,+X,2)) S X1=0 F  S X1=$O(^ORD(101,+X,2,X1)) Q:X1'>0  I $L($G(^ORD(101,+X,2,X1,0))) S ^XUTL("XQORM",DA_";ORD(101,","B",$$UP($P(^(0),"^")),ORPOS)=1
 S X=$H,^XUTL("XQORM",DA_";ORD(101,",0)=X,^ORD(101,DA,99)=X
 K ^TMP("XQORM",$J)
 Q
UP(X) ;Convert X to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
KILL ;From: File 101, Field 99  Entry: DA  Exit: DA
 K ^XUTL("XQORM",DA_";ORD(101,") Q
REDO ;From: File 101, Field 7  Entry: DA  Exit: DA
 N I,X S X=$H I $D(^ORD(101,DA,0)) S ^(99)=X
 F I=0:0 S I=$O(^ORD(101,"AD",DA,I)) Q:I'>0  I $D(^ORD(101,I,0)) S ^(99)=X
 Q
REDOM ;From: File 101, Field 1.1  Entry: DA(1)  Exit: DA(1)
 N I,X S I=0,X=$H
 F  S I=$O(^ORD(101,"AD",DA(1),I)) Q:I'>0  I $D(^ORD(101,I,0)) S ^(99)=X
 Q
REDOX ;From: Subfile 101.01, Fields .01,2,3  Entry: DA(1)  Exit: DA(1)
 I $D(^ORD(101,DA(1),0)) S ^(99)=$H Q
TREE ;Look back up tree to make sure item is not ancestor (input xform)
 ;From: 101.01,.01 101.01,4 100.981,.01  Entry: DA(1),X,ORDDF
 S ORDDA=DA(1) K:X=ORDDA X D TREE1 K ORDDA,ORDDF,ORDD Q
TREE1 F ORDD=0:0 Q:'$D(X)  S ORDD=$O(^ORD(ORDDF,"AD",ORDDA,ORDD)) Q:ORDD'>0  K:ORDD=X X Q:'$D(X)  D TREE2
 Q
TREE2 N ORDDA S ORDDA=ORDD N ORDD D TREE1 Q
NAME ;CHECK NAMESPACING IN PACKAGE FILE.
 I $E(X,1)="A"!($E(X,1)="Z") S %=1,%1="Local" Q
 F %=4:-1:2 G:$D(^DIC(9.4,"C",$E(X,1,%))) NAMEOK
 I 0
 Q
NAMEOK S %1=$O(^DIC(9.4,"C",$E(X,1,%),0)) I %1 S:$D(^DIC(9.4,%1,0)) %1=$P(^(0),U) I 1 Q
 I 0 Q
CHKNAME ;CHECK A NAME, AND DISPLAY APPROPRIATE MESSAGE
 I $D(^ORD(101,"B",X)) W "   Duplicate names not allowed." K X Q
 D NAME E  W !,"Not a known package or a local namespace." Q
 W:'$D(ORNMCHK) !,"  Located in the ",$E(X,1,%)," (",%1,") namespace." Q
TEST W !,"Enter a name, and the computer will respond with the namespace to which",!,"that name belongs.  It does this by looking at the package file.",!!
T1 R !,"NAME: ",X:DTIME,"  " Q:X=""  D CHKNAME G T1
