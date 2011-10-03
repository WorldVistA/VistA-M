GMTSXQ04 ; SLC/JER - XQOR3 for Export w/Health Summary ;1/10/92  14:58
 ;;2.5;Health Summary;;Dec 16, 1992
XQOR3 ; SLC/KCM - Process Menus, Protocol Menus ;12/5/89  10:16 ;
 ;;6.52;Copyright 1990, DVA;
MENU ;From: XQOR1
 S ^UTILITY("XQORS",$J,XQORS,"ITM")=0,XQORM=^UTILITY("XQORS",$J,XQORS,"VPT") S:$D(XQORM(0))[0 XQORM(0)="AD" I $D(XQORM("S")),'$L(XQORM("S")) K XQORM("S")
 D:^UTILITY("XQORS",$J,0,"FILE")=";ORD(101," MENU1 S:'$D(XQORM("H")) XQORM("H")="W @IOF,*13 I $D(@(^UTILITY(""XQORS"",$J,XQORS,""REF"")_""0)"")) S X=$P(^(0),""^"",2) W ?(36-($L(X)\2)),""--- ""_X_"" ---"",!"
 S X=$P(^UTILITY("XQORS",$J,XQORS,"INP"),"^",4) I X[";" D EAT^XQORM1 I $E(X)'=";" S X=$P(X,";",2,99),ORNSV=XQORM(0) S XQORM(0)=$S(+XQORM(0):+XQORM(0),1:"")_$S(XQORM(0)["F":"F",1:"") S XQORM("H")="" D ^XQORM
 S:$D(^UTILITY("XQORS",$J,XQORS,"X")) X=^UTILITY("XQORS",$J,XQORS,"X")
 I $S($D(ORNSV):Y<0,1:1) S:$D(ORNSV) XQORM(0)=ORNSV D ^XQORM
 S I=0
SET S I=$O(Y(I)) G:I'>0 EX
 S ^UTILITY("XQORS",$J,XQORS,"ITM")=^UTILITY("XQORS",$J,XQORS,"ITM")+1
 S ^UTILITY("XQORS",$J,XQORS,"ITM",^UTILITY("XQORS",$J,XQORS,"ITM"))=$P(Y(I),"^",2)_^UTILITY("XQORS",$J,0,"FILE")
 S ^UTILITY("XQORS",$J,XQORS,"ITM",^UTILITY("XQORS",$J,XQORS,"ITM"),"IN")=Y(I)
 I ^UTILITY("XQORS",$J,0,"FILE")=";ORD(101,",$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),10,+Y(I),0)),+$P(^(0),"^",4) S ^UTILITY("XQORS",$J,XQORS,"ITM",^UTILITY("XQORS",$J,XQORS,"ITM"),"MA")=$P(^(0),"^",4)_^UTILITY("XQORS",$J,0,"FILE")
 G SET
EX K ORNSV,XQORM Q
MENU1 ;Get Protocol file specific XQORM fields
 I '$D(XQORM("H")),$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),26))'[0,$L(^(26)) S XQORM("H")=^(26)
 I '$D(XQORM("S")),$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),24))'[0,$L(^(24)) S XQORM("S")=^(24)
 I '$D(XQORM("?")),$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),27))'[0,$L(^(27)) S XQORM("?")=^(27)
 I '$D(XQORM("A")),$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),28))'[0,$L(^(28)) S XQORM("A")=^(28)
 I '$D(XQORM("B")),$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),29))'[0,$L(^(29)) S XQORM("B")=^(29)
 I '$D(XQORM("M")),$D(^ORD(101,+^UTILITY("XQORS",$J,XQORS,"VPT"),4))'[0,+$P(^(4),"^",2) S XQORM("M")=$P(^(4),"^",2)
 Q
