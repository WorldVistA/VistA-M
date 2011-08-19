TIUDD ; slc/KCM - Build menus in XUTL (file 8925.1) ;7/19/94  13:51 ;
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
SET ;From: Cross reference in file 8925.1, field 99  Entry: DA  Exit: DA
 ;NOTE:  Lock ^TIU(8925.1,DA) when calling
 Q:$D(^TIU(8925.1,DA,0))[0
 I $D(^TIU(8925.1,DA,99)),$D(^XUTL("XQORM",DA_";TIU(8925.1,",0)),($P(^TIU(8925.1,DA,99),"^")=$P(^XUTL("XQORM",DA_";TIU(8925.1,",0),"^")) Q
 N TIUCOL,TIUCCOL,TIUROW,TIUCROW,TIUPOS,TIUTOT,S1,S2,X,X1
 K ^TMP("XQORM",$J) D KILL
 S TIUCOL=3
 S ^XUTL("XQORM",DA_";TIU(8925.1,","COL")=TIUCOL,(TIUTOT,S2)=0
 F  S S2=$O(^TIU(8925.1,DA,10,S2)) Q:S2'>0  D
 . S X=^TIU(8925.1,DA,10,S2,0) I '$D(^TIU(8925.1,+X,0)) Q
 . S X=$S(+$P(X,"^",3):+$P(X,"^",3),+$P(X,"^",2):+$P(X,"^",2),$L($P(X,"^",2)):"M"_$P(X,"^",2),1:"Z"_$P(^TIU(8925.1,+X,0),"^",2))
 . S ^TMP("XQORM",$J,X,S2)="",TIUTOT=TIUTOT+1
 S TIUROW=TIUTOT\TIUCOL+$S(TIUTOT#TIUCOL:1,1:0),TIUCCOL=1,TIUCROW=0,S1=""
 F  S S1=$O(^TMP("XQORM",$J,S1)) Q:S1=""  S S2=0 D  ;S1 is sequence
 . F  S S2=$O(^TMP("XQORM",$J,S1,S2))  Q:S2'>0  D  ;S2 is item subscript
 . . S X=^TIU(8925.1,DA,10,S2,0) ; X is the item node
 . . I '$D(^TIU(8925.1,+X,0)) K ^TIU(8925.1,DA,10,S2),^("B",+X,S2) S $P(^TIU(8925.1,DA,10,0),"^",3,4)=S2_"^"_($P(^TIU(8925.1,DA,10,0),"^",4)-1) Q
 . . S TIUCROW=TIUCROW+1 I TIUCROW>TIUROW S TIUCROW=1,TIUCCOL=TIUCCOL+1
 . . S TIUPOS=TIUCROW+(TIUCCOL/10)
 . . S X1=$S($L($P(X,"^",4)):$P(X,"^",4),1:$P(^TIU(8925.1,+X,0),"^",3))
 . . S X1=$TR(X1,",=;-","    ") Q:'$L(X1)
 . . S ^XUTL("XQORM",DA_";TIU(8925.1,",TIUPOS,0)=S2_"^"_+X_"^"_X1_"^"_$P(X,"^",2)
 . . S ^XUTL("XQORM",DA_";TIU(8925.1,","B",$$UP(X1),TIUPOS)=""
 . . I $L($P(X,"^",2)) S ^XUTL("XQORM",DA_";TIU(8925.1,","B",$$UP($P(X,"^",2)),TIUPOS)=1
 S X=$H,^XUTL("XQORM",DA_";TIU(8925.1,",0)=X,^TIU(8925.1,DA,99)=X
 K ^TMP("XQORM",$J)
 Q
UP(X) ; Convert X to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
KILL ; From: File 8925.1, Field 99  Entry: DA  Exit: DA
 K ^XUTL("XQORM",DA_";TIU(8925.1,") Q
REDO ; Update TIMESTAMP on self & parents when Print Name Changes
 ; From: File 8925.1, Field .03  Entry: DA  Exit: DA
 N I,X S X=$H I $D(^TIU(8925.1,DA,0)) S ^(99)=X,I=0
 F  S I=$O(^TIU(8925.1,"AD",DA,I)) Q:I'>0  D
 . I $D(^TIU(8925.1,I,0)) S ^(99)=X
 Q
REDOX ; From: Subfile 8925.14, Fields .01,2,3  Entry: DA(1)  Exit: DA(1)
 I $D(^TIU(8925.1,DA(1),0)) S ^(99)=$H Q
TREE ; Look back up tree to make sure item is not ancestor (input xform)
 ; From: 8925.14,.01 Entry: DA(1),X
 S TIUDDA=DA(1) K:X=TIUDDA X D TREE1 K TIUDDA,TIUDD
 Q
TREE1 ; Traverse up tree
 S TIUDD=0 F  Q:'$D(X)  S TIUDD=$O(^TIU(8925.1,"AD",TIUDDA,TIUDD)) Q:TIUDD'>0  K:TIUDD=X X Q:'$D(X)  D TREE2
 Q
TREE2 ; Recurse one level
 N TIUDDA S TIUDDA=TIUDD N TIUDD D TREE1
 Q
ASUBS(SUBJECT,TIUTYP,TIUSTAT,TIUIDT,DA) ; SET logic for "ASUB" X-ref
 N TIUI,TIUWORD S TIUI=0
 D PARSE^TIULS(SUBJECT,.TIUWORD)
 F  S TIUI=$O(TIUWORD(TIUI)) Q:+TIUI'>0  D
 . S ^TIU(8925,"ASUB",TIUWORD(TIUI),+TIUTYP,+TIUSTAT,+TIUIDT,+DA)=""
 Q
ASUBK(SUBJECT,TIUTYP,TIUSTAT,TIUIDT,DA) ; SET logic for "ASUB" X-ref
 N TIUI,TIUWORD S TIUI=0
 D PARSE^TIULS(SUBJECT,.TIUWORD)
 F  S TIUI=$O(TIUWORD(TIUI)) Q:+TIUI'>0  D
 . K ^TIU(8925,"ASUB",TIUWORD(TIUI),+TIUTYP,+TIUSTAT,+TIUIDT,+DA)
 Q
APRBS(TIUTYP,TIUSTAT,TIUIDT,DA,TIUPROB) ; SET logic for "APRB" X-ref
 N TIUI
 S TIUI=0 F  S TIUI=+$O(^TIU(8925.9,"B",+DA,TIUI)) Q:+TIUI'>0  D
 . S:$G(TIUPROB)']"" TIUPROB=$P($G(^TIU(8925.9,+TIUI,0)),U,5)
 . I TIUPROB]"" D
 . . S ^TIU(8925,"APRB",$$UPPER^TIULS(TIUPROB),+TIUTYP,+TIUSTAT,+TIUIDT,+DA)=""
 Q
APRBK(TIUTYP,TIUSTAT,TIUIDT,DA,TIUPROB) ; KILL logic for "APRB" X-ref
 N TIUI
 S TIUI=0 F  S TIUI=+$O(^TIU(8925.9,"B",+DA,TIUI)) Q:+TIUI'>0  D
 . S:$G(TIUPROB)']"" TIUPROB=$P($G(^TIU(8925.9,+TIUI,0)),U,5)
 . I TIUPROB]"" D
 . . K ^TIU(8925,"APRB",$$UPPER^TIULS(TIUPROB),+TIUTYP,+TIUSTAT,+TIUIDT,+DA)
 Q
