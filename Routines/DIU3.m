DIU3 ;SFISC/GFT-IDENTIFIERS ;6/22/98  12:25
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
3 ;
 S %=2,X="W """"",DA=+Y
 I $D(^DD(DI,0,"ID",+Y)) W !,"'",$P(Y,U,2),"' is already an Identifier; Want to delete it" D YN^DICN Q:%'=1  K ^DD(DI,0,"ID",+Y) D:$D(DDA) A Q
 S %=$O(^DD("KEY","AP",DI,"P",0)) I %,$O(^DD("KEY",%,2,"B",+Y,0)) D
 . W !!,$C(7),"  **NOTE:'"_$P(Y,U,2)_"' is part of the PRIMARY KEY for this file."
 . W !,"  Making it an Identifier is redundant.",! Q
 S %=2 W !,"Want to make '",$P(Y,U,2),"' an Identifier" D YN^DICN Q:%-1
 S %=$O(^DD(DI,0,"NM",0))
 W !,"Want to display "_$P(Y,U,2)_" whenever a lookup is done",!,"  on an entry in the '"_%_"' File" S %=1 D YN^DICN
 I %-1 G S:%=2&(Y-.001) W $C(7),"??" Q
 S V=$P(Y(0),U,2),X=$P(Y(0),U,4),D="W",%="(^(0)",%Y=$P(X,";")
 I %Y'=0 S D=$S(+%Y=%Y:"",V["S":"""""",1:""""),%="(^("_D_%Y_D_")",D="W"_$S(+Y'=.001:":$D(^("_$E(D)_%Y_$E(D)_"))",1:"")
 S %Y=$P(X,";",2),X=$S(+Y=.001:"Y",%Y:"$P"_%_",U,"_%Y_")",1:"$E"_%_","_+$E(%Y,2,9)_","_$P(%Y,",",2)_")")
 I V["D" N DIRUT D  Q:$D(DIRUT)
 . N DIR,DIOUT,DTOUT,DUOUT,DIROUT,Y,DISAVX S DISAVX=X
 . S DIR(0)="S^1:MM-DD-YY (ex. 06-01-00);2:MM-DD-YYYY (ex. 06-01-2000);3:MMM DD,YYYY (ex. Jun 1,2000)"
 . S DIR("A")="Select date format",DIR("B")=1
 . D ^DIR S X=DISAVX
 . I Y=2!(Y=3) S X="$$FMTE^DILIBF("_X_","_$S(Y=2:6,1:5)_")" Q
 . S X="$E("_X_",4,5)_""-""_$E("_X_",6,7)_""-""_$E("_X_",2,3)" Q
 I V["P" S X="S %I=Y,Y=$S('$D"_%_"):"""",$D(^"_$P(Y(0),U,3)_"+"_X_",0))#2:$P(^(0),U,1),1:""""),C=$P(^DD("_+$P(V,"P",2)_",.01,0),U,2) D Y^DIQ:Y]"""" W ""   "",Y,@(""$E(""_DIC_""%I,0),0)"") S Y=%I K %I" G S
 I V["V" S X=$P(Y(0),U,4),X="S DIY=$S($D(@(DIC_(+Y)_"","""""_$P(X,";",1)_""""")"")):$P(^("""_$P(X,";",1)_"""),U,"_$P(X,";",2)_"),1:"""") D NAME^DICM2 W ""   "",DINAME,@(""$E(""_DIC_""Y,0),0)"")" G S
 I V["S" S X="@(""$P($P($C(59)_$S($D(^DD("_DI_","_+Y_",0)):$P(^(0),U,3),1:0)_$E(""_DIC_""Y,0),0),$C(59)_"_X_"_"""":"""",2),$C(59),1)"")"
 S X=D_" ""   "","_X
S S ^DD(DI,0,"ID",+Y)=X,X=DIU I $D(DDA) S A0="IDENTIFIER^",A1="",A2="ID" D IT^DICATTA
 I N S V=N,P=$O(^DD(J(N-1),"SB",DI,0)) S:P="" P=-1 S X="^DD(J(N-1),P,"
 S @("X="_X_"0)"),%=$P(X,U,2) I %'["I" S ^(0)=$P(X,U)_U_%_"I"_U_$P(X,U,3,99)
 I N S DIFLD=+Y D WAIT^DICD,0^DIVR S:DE?.E1"  " DE=$E(DE,1,$L(DE)-2) X DE K DE,DA,X,W,DIFLD
 Q
 ;
A S A0="IDENTIFIER^",A1="ID",A2="" D IT^DICATTA K A0,A1,A2 Q
 ;
