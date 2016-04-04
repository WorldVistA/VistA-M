DIFG4A ;SFISC/DG(OHPRD)-CONDITIONALS ; [ 08/21/91  5:15 PM ]
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
START ;
 D CHECK
 I $D(DIFGSTP) K DIFGSTP S DIFG("UNRESOLVED",DIFGSAVE(DIFG,"@NUM"))="" G X1
 S DIFGDRCT=0 F DIFGI=1:1 Q:'$D(DIFGDIC(DIFGDIC,DIFGI))  S DIFGDIGT=+$P(DIFGDIC(DIFGDIC,DIFGI),"DIFGPC(",2) D:$D(DIFGNUMF(DIFGDIGT)) GETVAL
 I $E(X)="`",$S('$D(Y):1,Y<0:1,1:0) NEW DIC S DIC=+$P($P(^DD(DIFGDIC,.01,0),U,2),"P",2) I DIC S DIC(0)="FMZ" D ^DIC S:Y>0 X=Y(0,0)
 I X'["`" S ^UTILITY("DIFGFLD",$J,.01)=X
 K Y
 D COND ;dg/ohprd 8-21-91
 I '$D(Y) S Y=-1
 I Y>0 S DIFG("CONDSET")=""
 I Y=-1 S DIFGER=22_U_DIFGY D ERROR^DIFG
 K DIFGDRCT,DIFGDIGT,^UTILITY("DIFGFLD",$J)
X1 Q
 ;
CHECK ; Check for existence of higher level conds, if exist quit this level
 ; and continue processing
 NEW % S %=0 F  S %=$O(DIFGCOND(%)) S:%<DIFG&% DIFGSTP="" Q:%=""!(%<DIFG)
 Q
 ;
GETVAL ; Save field numbers and values
 I $D(^UTILITY("DIFGX",$J,DIFGDIGT)) S ^UTILITY("DIFGFLD",$J,DIFGNUMF(DIFGDIGT))=^(DIFGDIGT)
 Q
 ;
COND ; Execute conditions
 NEW ORDR,CNUM,NUM,STP,FLD,OP,VAL
 F ORDR=0:0 S ORDR=$O(^DD(DIFGDIC,0,"FD","B",ORDR)) Q:'ORDR!$D(Y)  S CNUM=$O(^(ORDR,"")),TYPE=$P(^DD(DIFGDIC,0,"FD",CNUM,0),U,3) K STP F NUM=0:0 S NUM=$O(^DD(DIFGDIC,0,"FD",CNUM,NUM)) D:NUM'=+NUM SETY Q:NUM'=+NUM  D  Q:$D(STP)
 . S FLD=$P(^DD(DIFGDIC,0,"FD",CNUM,NUM),U),OP=$P(^(NUM),U,2),VAL=$P(^(NUM),U,3)
 . I $S('$D(^UTILITY("DIFGFLD",$J,FLD)):1,1:0) S STP="" Q
 . I @("^UTILITY(""DIFGFLD"",$J,FLD)"_OP_"VAL")
 . E  S STP=""
 Q
 ;
SETY ; Sets Y to value of "D" node or value from execution of "C" node
 I TYPE="M",$D(^DD(DIFGDIC,0,"FD",CNUM,"C")) X ^("C")
 I TYPE="F",$D(^DD(DIFGDIC,0,"FD",CNUM,"D")) S Y=^("D")
 I $D(Y),Y'>0 K Y
 E  I $D(Y),'$D(@(^DIC(DIFGDIC,0,"GL")_"Y)")) K Y
 Q
 ;
