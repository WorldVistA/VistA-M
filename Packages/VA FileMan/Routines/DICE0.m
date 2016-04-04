DICE0 ;SFISC/GFT,XAK-XREF'S ;5/24/94  2:21 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S ^DD(J(N),DA,1,0)="^.1",^(DQ,0)=J(N-DH)_U_DE,X=I(0)
 F Y=N:-1:DH+1 S X=X_"DA("_Y_"),"_I(N+1-Y)_","
 S X=X_""""_DE_""",",Y=",DA)" F %=1:1:DH S Y=",DA("_%_")"_Y
 D @DREF ;I DE'="B" K DICOMPX S DE(0)=Y(0) D COND^DICE4 S Y(0)=DE(0) I $D(DCOND) S ^(1)=X_" I X S X=DIV "_^DD(J(N),DA,1,DQ,1),^(2)=X_" I X S X=DIV "_^(2),^("CONDITION")=DCOND(0)
 S DIK="^DD(J(N),",DA(1)=J(N) D IX1^DIK
 I $D(^DD(J(0),0,"DIK")) S X=^("DIK"),Y=J(0),DMAX=^DD("ROU") D EN^DIKZ
 Q
 ;
1 S Y="$E(X,1,30)"_Y,^(2)="K "_X_Y
 S ^DD(J(N),DA,1,DQ,1)="S "_X_Y_"=""""" Q
 ;
2 S ^(0)=^(0)_"^KWIC",^(1)="S %1=1 F %=1:1:$L(X)+1 S I=$E(X,%) I """_DIKWIC_"""[I S I=$E($E(X,%1,%-1),1,30),%1=%+1 I $L(I)>2,^DD(""KWIC"")'[I S "_X_"I"_Y_"="""""
 S ^(2)="S %1=1 F %=1:1:$L(X)+1 S I=$E(X,%) I """_DIKWIC_"""[I S I=$E($E(X,%1,%-1),1,30),%1=%+1 I $L(I)>2 K "_X_"I"_Y K DIKWIC Q
 ;
3 D 1 S ^(1)="S:'$D("_X_Y_") ^(DA)=1",^(2)="I $D("_X_Y_"),^(DA) K ^(DA)",^(0)=^(0)_"^MNEMONIC" Q
 ;
4 S ^(0)=^(0)_"^MUMPS",^(1)=X(1),^(2)=X(2) K X Q
 ;
5 S ^(0)=^(0)_"^SOUNDEX",X=X_"X_I"_Y,Y="S I=$E(X,1,27) D SOU^DICM ",^(1)=Y_"S "_X_"=""""",^(2)=Y_"K "_X,(^DD(J(N),0,"LOOK"),^("QUES"))="SOUNDEX" Q
 ;
6 ;
 D ^DICE1 G Q:U[X S ^UTILITY("DICE",$J,0)="^^TRIGGER^"_DIN_U_DENEW,^("FIELD")=DCNEW
 F DIK=1,2 D ^DICE2 G M^DICATT:$D(DTOUT),Q:U=X
 I '$D(^DD(DIN,DENEW,9))!($G(^(9))="") S %=2 W !!,"WANT TO PROTECT THE '",DNEW,"' FIELD, SO THAT",!,"IT CAN'T BE CHANGED BY THE 'ENTER & EDIT' ROUTINE" D YN^DICN G QQ:%<0 S:%=1 ^(9)=U
 ;
X ;
 S DA=DL,%Y="^DD("_DI_","_DL_",1,"_DQ_",",%X="^UTILITY(""DICE"",$J," I @("$O("_%Y_"0))>0") W $C(7),!!,"HEY, WHILE WE WERE TALKING, SOMEONE ELSE CREATED CROSS-REFERENCE #"_DQ_"!!!" G Q
 D %XY^%RCR,DSC^DICE,DIEZ^DIU0 I $D(DDA) S DDA="N" D XA^DICATTA
 D:$D(^DD(J(0),0,"DIK")) D^DICD D QQ S DIK="^DD("_DI_","_DL_",1,",(DA,DREF)=DQ,DA(1)=DL,DA(2)=DI,@(DIK_"0)=U_.1") D IX1^DIK W !,"...CROSS-REFERENCE IS SET"
 S %=2 I @(DIK_DREF_",1)'=""Q"""),@("$O("_DIU_"0))>0") W !!,"DO YOU WANT TO RUN THE CROSS-REFERENCE FOR EXISTING ENTRIES NOW" D YN^DICN I %=1 S X=^DD(DI,DL,1,DQ,1) D DD^DICD
Q G Q^DICE
QQ G QQ^DICE
