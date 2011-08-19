XQOR2 ; SLC/KCM - Process Extended Actions, Protocols ;8/23/91  10:33 ;
 ;;8.0;KERNEL;;Jul 10, 1995
ACT ;From: STAK^XQOR1
 I ^TMP("XQORS",$J,0,"FILE")=";ORD(101,",$D(@(^TMP("XQORS",$J,XQORS,"REF")_"26)"))'[0 S X=^(26) X:$L(X) X
 S ORNSV="" I ^TMP("XQORS",$J,0,"FILE")=";ORD(101,",$D(@(^TMP("XQORS",$J,XQORS,"REF")_"24)"))'[0 S ORNSV=^(24)
 K Y S (J,^TMP("XQORS",$J,XQORS,"ITM"))=0
ORD S J=$O(@(^TMP("XQORS",$J,XQORS,"REF")_"10,"_J_")")) G:J'>0 SET
 I $D(@(^TMP("XQORS",$J,XQORS,"REF")_"10,"_J_",0)")) S X=^(0) I +X D:$L(ORNSV) ACT1 I $T S Y=$S(+$P(X,"^",3):+$P(X,"^",3),1:1000+J),Y(Y,J)=X
 G ORD
SET S (I,Y)=0
SET1 S Y=$O(Y(Y)) G:Y="" EX S J=0
SET2 S J=$O(Y(Y,J)) G:J="" SET1
 S ^TMP("XQORS",$J,XQORS,"ITM")=^TMP("XQORS",$J,XQORS,"ITM")+1,^TMP("XQORS",$J,XQORS,"ITM",^TMP("XQORS",$J,XQORS,"ITM"))=+Y(Y,J)_";"_$P(^TMP("XQORS",$J,XQORS,"VPT"),";",2)
 S ^TMP("XQORS",$J,XQORS,"ITM",^TMP("XQORS",$J,XQORS,"ITM"),"IEN")=J
 I ^TMP("XQORS",$J,0,"FILE")=";ORD(101,",+$P(Y(Y,J),"^",4) S ^TMP("XQORS",$J,XQORS,"ITM",^TMP("XQORS",$J,XQORS,"ITM"),"MA")=$P(Y(Y,J),"^",4)_^TMP("XQORS",$J,0,"FILE")
 I $L($P($G(@(^TMP("XQORS",$J,XQORS,"REF")_"10,"_J_",1)")),"^")) S ^TMP("XQORS",$J,XQORS,"PMT",$$UP($P(^(1),"^")),^TMP("XQORS",$J,XQORS,"ITM"))=""
 G SET2
EX K ORNSV Q
ACT1 N DA S DA(1)=+^TMP("XQORS",$J,XQORS,"VPT"),DA=J N J,X,Y X ORNSV
 Q
NUL ;From: STAK^XQOR1
 I ^TMP("XQORS",$J,0,"FILE")=";ORD(101,",$D(@(^TMP("XQORS",$J,XQORS,"REF")_"26)"))'[0 S X=^(26) X:$L(X) X
 S ^TMP("XQORS",$J,XQORS,"ITM")=0
 Q
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
