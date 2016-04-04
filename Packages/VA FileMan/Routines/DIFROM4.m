DIFROM4 ;SFISC/XAK-CREATES 'INIT3' ;2:49 PM  25 Sep 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S DNAME=E_3,DIRS=E_4,DL=0,(DH,Q)=" ;"
 K ^UTILITY($J) F DD=1:1 S X=$T(TXT+DD) Q:X=""  S ^UTILITY($J,DD,0)=$E(X,4,999) S:$E(X,4,5)="OR" ^(0)=^(0)_DIRS
 D ^DIFROM41
 S DIFROM=2 D ZI^DIFROM3 G ^DIFROM42
TXT ;
 ;; K ^UTILITY("DIFROM",$J) S DIC(0)="LX",(DIC,DLAYGO)=3.6,N="BUL" D ADD:$D(^XMB(3.6,0))
 ;; S X=0 F R=0:0 S X=$O(^UTILITY("DIFROM",$J,N,X)) Q:X=""  W !,"'",X,"' BULLETIN FILED -- Remember to add mail groups for new bulletins."
 ;; I $D(^DIC(9.4,0))#2,^(0)?1"PACK".E S N="PKG",(DIC,DLAYGO)=9.4 D ADD
 ;; G NP:'$D(DA) S %=+$O(^DIC(9.4,DA,22,"B",DIFROM,0)) I $D(^DIC(9.4,DA,22,%,0)) S $P(^(0),U,3)=DT
 ;; I $D(^DIC(9.4,DA,0))#2 S %=$P(^(0),U,4) I %]"" S %=$O(^DIC(9.2,"B",%,0)) S:%]"" $P(^DIC(9.4,DA,0),U,4)=%
 ;;OR I $D(^ORD(100.99))&$O(^UTILITY(U,$J,"OR","")) D EN^
 ;;NP K DIC,^UTILITY("DIFROM",$J) S DIC(0)="LX" I $D(^DIC(19,0))#2,^(0)?1"OPTION".E S (DIC,DLAYGO)=19,N="OPT" D ADD,OP
 ;; I $D(^DIC(19.1,0))#2,($P(^(0),U)?1"SECUR".E)!($P(^(0),U)="KEY") S (DIC,DLAYGO)=19.1,N="KEY" D ADD K ^UTILITY("DIFROM",$J)
 ;; I $D(^DIC(9.8,0))#2,^(0)?1"ROUTINE^".E S (DIC,DLAYGO)=9.8,N="RTN" D ADD
 ;; S DIC=.5,DLAYGO=0,N="FUN" D ADD
 ;; I $P($G(^DIC(8994,0)),U)="REMOTE PROCEDURE" S (DIC,DLAYGO)=8994,N="REM" D ADD
 ;; S DIC("S")="I $P(^(0),U,4)=DIFL" F N="DIPT","DIBT","DIE" S DIC=U_N_"(" D ADD
 ;; K DIC("S") S N="DIST(.404,",DIC=U_N,DLAYGO=.404 D ADD
 ;; S DIC("S")="I $P(^(0),U,8)=DIFL",N="DIST(.403,",DIC=U_N,DLAYGO=.403 D ADD
 ;; K ^UTILITY(U,$J),DIC,DLAYGO F DIFR="DIE","DIPT" D DIEZ
 ;; K ^UTILITY("DIFROM",$J) Q
