TIUDD8 ; slc/KCM - Build menus in XUTL (file 8925.8) ;7/19/94  13:51 ;
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
SET ;From: Cross reference in file 8925.8, field 99  Entry: DA  Exit: DA
 ;NOTE:  Lock ^TIU(8925.8,DA) when calling
 Q:'$D(^TIU(8925.8,1,0))
 I $P($G(^TIU(8925.8,1,99)),"^")=$P($G(^XUTL("XQORM","1;TIU(8925.8,",0)),"^") Q
 N TIUCOL,TIUCCOL,TIUROW,TIUCROW,TIUPOS,TIUTOT,S1,S2,X,X1
 K ^TMP("XQORM",$J) D KILL
 S TIUCOL=3
 S ^XUTL("XQORM","1;TIU(8925.8,","COL")=TIUCOL,TIUTOT=0,S1=""
 F  S S1=$O(^TIU(8925.8,"B",S1)) Q:S1']""  D
 . S S2=+$O(^TIU(8925.8,"B",S1,0)) Q:+S2'>0
 . S TIUTOT=TIUTOT+1,^TMP("XQORM",$J,TIUTOT,S2)=""
 S TIUROW=TIUTOT\TIUCOL+$S(TIUTOT#TIUCOL:1,1:0),TIUCCOL=1,TIUCROW=0,S1=""
 F  S S1=$O(^TMP("XQORM",$J,S1)) Q:S1=""  S S2=0 D  ;S1 is sequence
 . F  S S2=$O(^TMP("XQORM",$J,S1,S2))  Q:S2'>0  D  ;S2 is record #
 . . S X=^TIU(8925.8,S2,0) ; X is the search category record
 . . S TIUCROW=TIUCROW+1 I TIUCROW>TIUROW S TIUCROW=1,TIUCCOL=TIUCCOL+1
 . . S TIUPOS=TIUCROW+(TIUCCOL/10)
 . . S X1=$S($L($P(X,"^",3)):$P(X,"^",3),1:$$MIXED^TIULS($P(X,"^")))
 . . S X1=$TR(X1,",=;-","    ") Q:'$L(X1)
 . . S ^XUTL("XQORM",1_";TIU(8925.8,",TIUPOS,0)=+S1_"^"_+S2_"^"_X1_"^"_+S1
 . . S ^XUTL("XQORM","1;TIU(8925.8,","B",$$UP(X1),TIUPOS)=""
 . . I +S1 S ^XUTL("XQORM","1;TIU(8925.8,","B",+S1,TIUPOS)=1
 S X=$H,^XUTL("XQORM","1;TIU(8925.8,",0)=X,^TIU(8925.8,1,99)=X
 K ^TMP("XQORM",$J)
 Q
UP(X) ; Convert X to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
KILL ; From: File 8925.8, Field 99  Entry: DA  Exit: DA
 K ^XUTL("XQORM","1;TIU(8925.8,") Q
REDO ; Update TIMESTAMP on Record #1 when Display Name Changes
 ; From: File 8925.8, Field .03  Entry: DA  Exit: DA
 N I,X S X=$H I $D(^TIU(8925.8,1,0)) S ^TIU(8925.8,1,99)=X,I=0
 Q
