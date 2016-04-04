DIU3 ;SFISC/GFT-IDENTIFIERS ;2015-01-02  12:12 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1050**
 ;
3 ;
 S %=2,DA=+Y
 I $D(^DD(DI,0,"ID",DA)) W !,"'",$P(Y,U,2),"' is already an Identifier; Want to delete it" D YN^DICN Q:%'=1  K ^DD(DI,0,"ID",DA) D A Q
 I $D(^DD(DI,0,"ID","W"_DA)) W !,"'",$P(Y,U,2),"' is already an Identifier; Want to delete it" D YN^DICN Q:%'=1  K ^DD(DI,0,"ID","W"_DA) D A Q
 S %=$O(^DD("KEY","AP",DI,"P",0)) I %,$O(^DD("KEY",%,2,"B",+Y,0)) D
 . W !!,$C(7),"  **NOTE:'"_$P(Y,U,2)_"' is part of the PRIMARY KEY for this file."
 . W !,"  Making it an Identifier is redundant.",! Q
 S %=2 W !,"Want to make '",$P(Y,U,2),"' an Identifier" D YN^DICN Q:%-1
 ;
 N DIWID,DIFILENM,X
 S DIFILENM=$O(^DD(DI,0,"NM",0)),X="W """""
 W !,"Want to require that a value for '",$P(Y,U,2),"' be asked",!,"  whenever a new '",DIFILENM,"' is created" S %=1 D YN^DICN
 Q:%<1  S DIWID=%=2 ;DIWID true means we are only going to display, with a "W" node under ^DD(DI,0,"ID")
 W !,"Want to display '"_$P(Y,U,2)_"' value whenever a lookup is done",!,"  on an entry in the '"_DIFILENM_"' File" S %=1 D YN^DICN
 I %-1 G S:%=2&(Y-.001)&'DIWID W $C(7),"??" Q
 ;Now build the WRITE code
 S V=$P(Y(0),U,2),X=$P(Y(0),U,4),D="W",%="(^(0)",%Y=$P(X,";")
 I %Y'=0 S D=$S(+%Y=%Y:"",V["S":"""""",1:""""),%="(^("_D_%Y_D_")",D="W"_$S(+Y'=.001:":$D(^("_$E(D)_%Y_$E(D)_"))",1:"")
 S %Y=$P(X,";",2),X=$S(+Y=.001:"Y",%Y:"$P"_%_",U,"_%Y_")",1:"$E"_%_","_+$E(%Y,2,9)_","_$P(%Y,",",2)_")")
EGP I V["D" S X="$$NAKED^DIUTL(""$$DATE^DIUTL("_X_")"")" ;**CCO/NI  DATE-TYPE IDENTIFIER USES ^DD("DD")!
 I V["P" S X="S %I=Y,Y=$S('$D"_%_"):"""",$D(^"_$P(Y(0),U,3)_"+"_X_",0))#2:$P(^(0),U,1),1:""""),C=$P(^DD("_+$P(V,"P",2)_",.01,0),U,2) D Y^DIQ:Y]"""" W ""   "",Y,@(""$E(""_DIC_""%I,0),0)"") S Y=%I K %I" G S
 I V["V" S X=$P(Y(0),U,4),X="S DIY=$S($D(@(DIC_(+Y)_"","""""_$P(X,";",1)_""""")"")):$P(^("""_$P(X,";",1)_"""),U,"_$P(X,";",2)_"),1:"""") D NAME^DICM2 W ""   "",DINAME,@(""$E(""_DIC_""Y,0),0)"")" G S
 I V["S" S X="@(""$P($P($C(59)_$S($D(^DD("_DI_","_+Y_",0)):$P(^(0),U,3),1:0)_$E(""_DIC_""Y,0),0),$C(59)_"_X_"_"""":"""",2),$C(59),1)"")"
 S X=D_" ""   "","_X
S ;'X' at this point is the WRITE code
 S Y=+Y I DIWID S Y="W"_Y ;associate it with the field number, or with "W" concatenated with the field numbber 
 S ^DD(DI,0,"ID",Y)=X,X=DIU I $D(DDA) S A0="IDENTIFIER^",A1="",A2="ID" D IT^DICATTA
 I N S V=N,P=$O(^DD(J(N-1),"SB",DI,0)) S:P="" P=-1 S X="^DD(J(N-1),P," ;N means that we are at a lower multiple level
 S @("X="_X_"0)"),%=$P(X,U,2) I %'["I" S ^(0)=$P(X,U)_U_%_"I"_U_$P(X,U,3,99)
 I N S DIFLD=+Y D WAIT^DICD,0^DIVR S:DE?.E1"  " DE=$E(DE,1,$L(DE)-2) X DE K DE,DA,X,W,DIFLD
 Q
 ;
A S A0="IDENTIFIER^",A1="ID",A2="" D IT^DICATTA ;In the audit of the DD, remember that IDENTIFIER was removed.
 K A0,A1,A2 Q
