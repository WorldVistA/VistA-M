TIUDD98 ; slc/KCM - Build menus in XUTL (file 8925.1) ;7/19/94  13:51 ;
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
SET ;From: Cross reference in file 8925.98, field 99  Entry: DA  Exit: DA
 ;NOTE:  Lock ^TIU(8925.98,DA) when calling
 Q:$D(^TIU(8925.98,DA,0))[0
 I $D(^TIU(8925.98,DA,99)),$D(^XUTL("XQORM",DA_";TIU(8925.98,",0)),($P(^TIU(8925.98,DA,99),"^")=$P(^XUTL("XQORM",DA_";TIU(8925.98,",0),"^")) Q
 N TIUCOL,TIUCCOL,TIUROW,TIUCROW,TIUPOS,TIUTOT,S1,S2,X,X1
 K ^TMP("XQORM",$J) D KILL
 S TIUCOL=3
 S ^XUTL("XQORM",DA_";TIU(8925.98,","COL")=TIUCOL,(TIUTOT,S2)=0
 F  S S2=$O(^TIU(8925.98,DA,10,S2)) Q:S2'>0  D
 . S X=^TIU(8925.98,DA,10,S2,0) I '$D(^TIU(8925.1,+$P(X,U),0)) Q
 . S X=$S(+$P(X,"^",2):+$P(X,"^",2),$P(X,"^",3)]"":$P(X,"^",3),1:$P($G(^TIU(8925.1,+X,0)),U))
 . S ^TMP("XQORM",$J,X,S2)="",TIUTOT=TIUTOT+1
 S TIUROW=TIUTOT\TIUCOL+$S(TIUTOT#TIUCOL:1,1:0),TIUCCOL=1,TIUCROW=0,S1=""
 F  S S1=$O(^TMP("XQORM",$J,S1)) Q:S1=""  S S2=0 D  ;S1 is sequence
 . F  S S2=$O(^TMP("XQORM",$J,S1,S2))  Q:S2'>0  D  ;S2 is item subscript
 . . S X=^TIU(8925.98,DA,10,S2,0) ; X is the item node
 . . I '$D(^TIU(8925.1,+$P(X,U),0)) D  Q
 . . . K ^TIU(8925.98,DA,10,S2),^TIU(8925.98,DA,10,"B",+X,S2)
 . . . S $P(^TIU(8925.98,DA,10,0),"^",3,4)=S2_"^"_($P(^TIU(8925.98,DA,10,0),"^",4)-1)
 . . S TIUCROW=TIUCROW+1 I TIUCROW>TIUROW S TIUCROW=1,TIUCCOL=TIUCCOL+1
 . . S TIUPOS=TIUCROW+(TIUCCOL/10)
 . . S X1=$S($L($P(X,"^",3)):$P(X,"^",3),1:$P(^TIU(8925.1,+$P(X,U),0),"^",3))
 . . S X1=$E(X1,1,22) I $E(X1,$L(X1))=" " D
 . . . N I F I=$L(X1):-1:1 Q:$E(X1,I)'=" "  S X1=$E(X1,1,(I-1))
 . . S X1=$TR(X1,",=;-","    ") Q:'$L(X1)
 . . S ^XUTL("XQORM",DA_";TIU(8925.98,",TIUPOS,0)=S2_"^"_+$P(X,U)_"^"_X1_"^"_$P(X,"^",2)
 . . S ^XUTL("XQORM",DA_";TIU(8925.98,","B",$$UP(X1),TIUPOS)=""
 . . I $L($P(X,"^",2)) S ^XUTL("XQORM",DA_";TIU(8925.98,","B",$$UP($P(X,"^",2)),TIUPOS)=1
 S X=$H,^XUTL("XQORM",DA_";TIU(8925.98,",0)=X,^TIU(8925.98,DA,99)=X
 K ^TMP("XQORM",$J)
 Q
UP(X) ; Convert X to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
KILL ; From: File 8925.98, Field 99  Entry: DA  Exit: DA
 K ^XUTL("XQORM",DA_";TIU(8925.98,") Q
REDO ; Update TIMESTAMP on self when Print Name Changes
 ; From: File 8925.9801, Field .03  Entry: DA  Exit: DA
 I $D(^TIU(8925.98,+$G(DA(1)),0)) S ^(99)=$H
 Q
