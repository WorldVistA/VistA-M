DICE4 ;SFISC/GFT-TRIGGER LOGIC ;26NOV2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,37,157**
 ;
 D SET S DTAG="S DIH=$G("_DREF_DSUB_")),DIV=X "_$P("I $D(^(0)) ","""",A>99)_X_",DIH="_DIN_",DIG="_DENEW_" D ^DICR",X=""
 S:$L(DE)+$L(DTAG)>160&($L(DE)>30) ^UTILITY("DICE",$J,DIK+.1)=DE,DE="X "_DA_DIK_".1)" S X=DE
F ;
 S DB=DA_DIK
 S:$L(Y)+$L(X)>190 ^UTILITY("DICE",$J,DIK+.2)=Y,Y="X "_DB_".2)" S:$L(Y) X=Y_" "_X
 K DICOMPX(DNEW) S DHI=X,DCOND=DCOND_"TING OF '"_DNEW_"'" D COND G P:'$D(DCOND) I DLAY,DICOMPX,DICOMPX-DI W !,"SORRY, CAN'T DO THIS WHEN 'LAYGO' ALLOWED" S X=U Q
 S DHI="I X S X=DIV "_DHI I $O(J(A))>0 S ^("DIC")=""
P S:$L(DHI)+$L(X)>220 ^UTILITY("DICE",$J,DIK+.3)=X,X="X "_DB_".3)" S X=X_" "_DHI
 S:$L(DTAG)+$L(X)>225 ^UTILITY("DICE",$J,DIK+.4)=DTAG,DTAG="X "_DB_".4)" S ^UTILITY("DICE",$J,DIK)=X_" "_DTAG K DTAG,D Q
 ;
SET G PIECE:DLOC S DHI=$P(DLOC,",",2),%=+$E(DLOC,2,9),X="S DE="_(%-1)_"-$L(DIH),DIU=$E(DIH,"_%_","_DHI_"),Y=$E(DIH,"_(DHI+1)_",999),^("_DSUB_")="
 I %>1 S X=X_"$E(DIH,1,"_(%-1)_")_"
 S X=X_"$J("""",$S(DE>0:DE,1:0))_DIV_$S(Y?."" "":"""",1:$J("""","_(DHI-%+1)_"-$L(DIV))_Y)" Q
PIECE S X="S $P(^("_DSUB_"),U,"_DLOC_")=DIV" Q
 ;
COND S DE=" DIV=X" F %=0:1:N S DE=DE_",D"_%_"=DA"_$S(%=N:"",1:"("_(N-%)_")") I A#100'<% S DE=DE_",DIV("_%_")=D"_%
 D CC I $D(DCOND) S DE=DE_" "_X
 S X="K DIV S"_DE
Q Q
 ;
CC ;
 S DA=DA_(DIK+5)
R W !!,"DO YOU WANT TO MAKE THE "_DCOND_" CONDITIONAL" K DICOMPX S %=2,DICOMPX="",DICOMP="?",D="ENTER AN EXPRESSION FOR THE CONDITION: " D YN^DICN I %-1 K DCOND Q
 I DIK=1 S DICOMPX("Y(0)")="Y(0)",DICOMPX(1,DI,DL)="Y(0)",DICOMPX("Y(0)",U)=DI_U_DL
 E  W ! D OLD^DICE2 S Y="CREATE CONDITION" I $D(^UTILITY("DICE",$J,Y)) W !,D_^(Y)_"// " R X:DTIME S:'$T DTOUT=1 G Q:X=U!'$T S:X="" X=^(Y) G X
 W !,D R X:DTIME S:'$T DTOUT=1 G Q:X=U!'$T
X I X?."?" W !,"ENTER A TRUTH-VALUED 'COMPUTED-FIELD' EXPRESSION ",!?4,"(PERHAPS INVOLVING '"_DOLD_"')" G R
 S DCOND(0)=X D ^DICOMP I $D(X) W:Y'["B" !,"WARNING--THIS DOESN'T LOOK LIKE A CONDITION EXPRESSION!" S X="S Y(0)=X "_X,^UTILITY("DICE",$J,$P("CREA^DELE",U,DIK)_"TE CONDITION")=DCOND(0) F %=9.2:.1 G Q:'$D(X(%)) S ^(DIK+5*10+%)=X(%) K X(%)
 W $C(7),"??" G R
