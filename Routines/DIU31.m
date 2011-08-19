DIU31 ;SFISC/GFT-UNEDITABLE, INPUT TRANS., OUTPUT TRANS. ;10/4/90  8:57 AM
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
9 ;
 S %=2,DA=+Y
 I $P(Y(0),U,2)["I" W !,$C(7),"FIELD IS ALREADY UNEDITABLE",!,"DO YOU WANT TO ALLOW EDITING AGAIN" D YN^DICN Q:%-1  S X=$P(^(0),U,2),^(0)=$P(^(0),U,1)_U_$P(X,"I",1)_$P(X,"I",2)_$P(X,"I",3)_U_$P(^(0),U,3,99) W "  ..OK" S %=1 G 2
 W !,"WANT TO PREVENT ALL USERS FROM CHANGING OR DELETING DATA VALUES",!
 W "THAT ARE ENTERED FOR THE '"_$P(Y,U,2)_"' FIELD" D YN^DICN Q:%-1  S ^(0)=$P(^(0),U,1,2)_"I^"_$P(^(0),U,3,99) W $C(7),!?9,"...FIELD IS NOW UNEDITABLE!" S %=2
2 I $D(DDA) S A0="UNEDITABLE^",(A1,A2)="",@("A"_%)="I" D IT^DICATTA
 G DIEZ^DIU0
 ;
5 W !,$P(Y,U,2) S DA=+Y,Y=$P(Y(0),U,5,99) S:$D(DDA) DDA=Y
 W " INPUT TRANSFORM: ",Y D RW^DIR2 Q:X=""  S %=$L($P(Y(0),U,1,4))+$L(X) I %>244 W !!?5,$C(7),"Input Transform is TOO LONG by ",%-244," characters.",! K X S Y=DA_U_$P(Y(0),U) G 5
 I $P(Y(0),U,2)["K",X'[" ^DIM" K X S Y=DA_U_$P(Y(0),U) W $C(7),!?5,"Input Transform must contain D ^DIM",! G 5
 I $P(Y(0),U,2)["F",X["DINUM" W $C(7),!?5,"DINUM on a Freetext field can cause database",!?5,"problems unless you are sure DINUM is numeric."
 D ^DIM I '$D(X) W $C(7),"??" S Y=DA_U_$P(Y(0),U) G 5
 S ^DD(DI,DA,0)=$P(Y(0),U,1,2)_$E("X",$P(Y(0),U,2)'["X")_U_$P(Y(0),U,3,4)_U_X
 I $D(DDA),DDA'=X S A0="INPUT TRANSFORM^.5",A1=DDA,A2=X D IT^DICATTA
 S DR="3:4" I $P(Y(0),U,2)["P" S %=$F(X," D ^DIC") I % S X=$E(X,1,%-8),%=$F(X,"DIC(""S"")=") I % S X=$E(X,%-9,$L(X)),^(12.1)="S "_X,DR=DR_";12EXPLANATION OF SCREEN"
 S DIE=DIC I $P(Y(0),U,2)["C" D PZ^DIU0 G Q
 F %=3,4,12.1 S:$D(^DD(DI,DA,%)) ^UTILITY("DDA",$J,DI,DA,%)=^(%)
 S DDA=DI D ^DIE S DI=DDA D IT1^DICATTA,DIEZ^DIU0 G Q
 ;
O S DIK=1,DJJ=+Y W !,$P(Y,U,2)_" OUTPUT TRANSFORM: "
 I '$D(^DD(DI,DJJ,2)) R X:DTIME I '$T S DTOUT=1 G Q
 I $D(^(2)) S (DIK,Y)=^(2) S:$D(DDA) DDA=Y S:$D(^(2.1)) Y=^(2.1) W Y D RW^DIR2 I X="@" W !?9,"DELETED!" K ^(2),^(2.1) S Y=$P(^(0),U,2),$P(^(0),U,2)=$P(Y,"O")_$P(Y,"O",2),%="" G EX
 G Q:X="" I X?."?" S Y=DJJ_U_$P(^(0),U) W !?4,"Enter a computed-field expression using '"_$P(Y,U,2)_"'",! W:DUZ(0)="@" ?4,"or MUMPS code that takes Y and transforms it to a different Y.",! G O
 K ^(2) S DICOMPX(1,DI,DJJ)="Y(0)",DA=DIC_DJJ_",2,",DGG=X,DQI="Y("
 D ^DICOMP K DQI,DICOMPX F %=9.2:.1 Q:'$D(X(%))  S @(DA_"%)=X(%)")
 I $D(X) S ^DD(DI,DJJ,2)="S Y(0)=Y "_X_$P(" S Y=X",U,Y'["X"),^(2.1)=DGG S:$P(^(0),U,2)'["O" $P(^(0),U,2)=$P(^(0),U,2)_"O" S %=^(2) G EX
 S:'DIK ^DD(DI,DJJ,2)=DIK
X W $C(7),"??" Q
 ;
EX S DA=DJJ I $D(DDA),DDA'=% S A1=DDA,A2=%,A0="OUTPUT TRANSFORM^2" D IT^DICATTA
 D PZ^DIU0
Q G Q^DIU
