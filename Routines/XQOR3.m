XQOR3 ; SLC/KCM - Process Menus, Protocol Menus ;4/8/94  12:03 ;
 ;;8.0;KERNEL;;Jul 10, 1995
MENU ;From: XQOR1
 S ^TMP("XQORS",$J,XQORS,"ITM")=0,XQORM=^TMP("XQORS",$J,XQORS,"VPT") S:$D(XQORM(0))[0 XQORM(0)="AD" I $D(XQORM("S")),'$L(XQORM("S")) K XQORM("S")
 D:^TMP("XQORS",$J,0,"FILE")=";ORD(101," MENU1 S:'$D(XQORM("H")) XQORM("H")="W @IOF I $D(@(^TMP(""XQORS"",$J,XQORS,""REF"")_""0)"")) S X=$P(^(0),""^"",2) W ?(36-($L(X)\2)),""--- ""_X_"" ---"",!"
 S X=$P(^TMP("XQORS",$J,XQORS,"INP"),"^",4) I X[";" D EAT^XQORM1 I $E(X)'=";" S X=$P(X,";",2,99),ORNSV=XQORM(0) S XQORM(0)=$S(+XQORM(0):+XQORM(0),1:"")_$S(XQORM(0)["F":"F",1:"") S XQORM("H")="" D ^XQORM
 S:$D(^TMP("XQORS",$J,XQORS,"X")) X=^TMP("XQORS",$J,XQORS,"X")
 I $S($D(ORNSV):Y<1,1:1) S:$D(ORNSV) XQORM(0)=ORNSV D ^XQORM
 S I=0
SET S I=$O(Y(I)) G:I'>0 EX
 S ^TMP("XQORS",$J,XQORS,"ITM")=^TMP("XQORS",$J,XQORS,"ITM")+1
 S ^TMP("XQORS",$J,XQORS,"ITM",^TMP("XQORS",$J,XQORS,"ITM"))=$P(Y(I),"^",2)_^TMP("XQORS",$J,0,"FILE")
 S ^TMP("XQORS",$J,XQORS,"ITM",^TMP("XQORS",$J,XQORS,"ITM"),"IN")=Y(I)
 I ^TMP("XQORS",$J,0,"FILE")=";ORD(101,",$D(^ORD(101,+^TMP("XQORS",$J,XQORS,"VPT"),10,+Y(I),0)),+$P(^(0),"^",4) S J=$P(^(0),"^",4),^TMP("XQORS",$J,XQORS,"ITM",^TMP("XQORS",$J,XQORS,"ITM"),"MA")=J_^TMP("XQORS",$J,0,"FILE")
 G SET
EX K J,ORNSV,XQORM Q
MENU1 ;Get Protocol file specific XQORM fields
 I '$D(XQORM("H")),$D(^ORD(101,+^TMP("XQORS",$J,XQORS,"VPT"),26))'[0,$L(^(26)) S XQORM("H")=^(26)
 I '$D(XQORM("S")),$D(^ORD(101,+^TMP("XQORS",$J,XQORS,"VPT"),24))'[0,$L(^(24)) S XQORM("S")=^(24)
 I '$D(XQORM("?")),$D(^ORD(101,+^TMP("XQORS",$J,XQORS,"VPT"),27))'[0,$L(^(27)) S XQORM("?")=^(27)
 I '$D(XQORM("A")),$D(^ORD(101,+^TMP("XQORS",$J,XQORS,"VPT"),28))'[0,$L(^(28)) S XQORM("A")=^(28)
 I '$D(XQORM("B")),$D(^ORD(101,+^TMP("XQORS",$J,XQORS,"VPT"),29))'[0,$L(^(29)) S XQORM("B")=^(29)
 I '$D(XQORM("M")),$D(^ORD(101,+^TMP("XQORS",$J,XQORS,"VPT"),4))'[0,+$P(^(4),"^",2) S XQORM("M")=$P(^(4),"^",2)
 Q
