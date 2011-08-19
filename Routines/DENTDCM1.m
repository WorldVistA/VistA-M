DENTDCM1 ;WASH ISC/TJK-MODIFIED DICM1 ROUTINE  ; 29-Jul-1987 4:21 pm;09/23/91  4:16 PM
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 G @Y
 ;
P ;POINTERS
 S DICR(DICR,1)=DIC,DIC=U_$P(DS,U,3),Y=DIC(0),D=$P(Y,"L",1)_$P(Y,"L",2),DICR(DICR,2)=$S(%="B":Y,1:D),DICR(DICR,2.1)=$S($P(DS,U,2)["'":D,1:Y)
 S DIC(0)=$P(D,"N",1)_$P(D,"N",2)
 F Y="S","P","W" I $D(DIC(Y)) S DICR(DICR,Y)=DIC(Y) K DIC(Y)
AST G P1:$P(DS,U,2)'["*"
 F D=" D ^DIC"," D IX^DIC"," D MIX^DIC1" S Y=$F(DS,D) I Y X $P($E(DS,1,Y-$L(D)-1),U,5,99) S:DS["DIC(0)=" DICR(DICR,2.1)=DIC(0) I $D(DIC("S")) S DICR(DICR,31)=DIC("S")
P1 S Y="("_DICR(DICR,1) G L1:'$D(DO) K DO I @("$O"_Y_"0))'>0") G L1
 S I="DIC"_DICR,D="X ""I 0"" F "_I_"=0:0 S "_I_"=$O"_Y,%=""""_%_""""
 I @("$O"_Y_%_",0))>0") S D=D_%_",Y,"_I_")) S:"_I_"="""" "_I_"=-1 Q:"_I_"'>0  I $D"_Y_I_",0))"
 E  I DS["DINUM=X" S D="I $D"_Y_"Y,0))"
 E  S D=D_I_")) S:"_I_"="""" "_I_"=-1 Q:"_I_"'>0  I +^("_I_",0)=Y"
 I $D(DICR(DICR,31)) S D="X DICR("_DICR_",31) "_D
 I $D(DICR(DICR,"S")) S D=D_" S %Y"_DICR_"=Y,Y="_I_" X DICR("_DICR_",""S"") S Y=%Y"_DICR_" I "
 S DIC("S")=D_" Q",D="B",Y=0 D X^DENTDC
L1 K DIC("S"),@("DIC"_DICR) I Y'>0,'$D(DICR(DICR,8)) S:$D(DICR(DICR,31)) DIC("S")=DICR(DICR,31) G RETRY
 I DICR(DICR,2)["L",DICR(DICR,2)["E",@("$P("_DIC_"0),U,2)'[""O""") W !?9,"...OK" S %=1 D YN^DENTDCN W ! I %-1 X DJCP G NO:%-2 S DIC("S")="I Y-"_+Y_$S($D(DICR(DICR,31)):" "_DICR(DICR,31),1:""),X=DICR(DICR) W ?5,X G RETRY
R K DICW,DO,DIC("W"),DIC("S") S DIC=DICR(DICR,1),%=DICR(DICR,2),DIC(0)=$P(%,"M",1)_$P(%,"M",2) F X="S","P","W" S:$D(DICR(DICR,X)) DIC(X)=DICR(DICR,X)
 D DO^DENTDC1 S X=+Y K:X'>0 X Q
 ;
RETRY D DO^DENTDC1 K DICR(U,+DO(2)) S D="B",DIC(0)=DICR(DICR,2.1) D X^DENTDC K DICR(DICR,6)
 G R
 ;
NO S Y=-1 G R
 ;
D ;DATES
 I $S(X?.N:X>49,1:1) S Y=$S($D(^DD(+DO(2),.001)):"N",1:"")_$P($P(DS,"%DT=""",2),"""",1),%DT=$P(Y,"E",1)_$P(Y,"E",2) D ^%DT S X=Y K %DT I X>1 Q:DIC(0)'["E"  W "   " G DT^DIQ
 K X Q
 ;
S ;SETS
 S DICR(DICR,1)=1,Y=$P(DS,U,3),DD=$P(";"_Y,";"_X_":",2) I DD]"" W:DIC(0)["E" "  (",$P(DD,";",1),")" Q
SS S DD=$P(Y,";",1),Y=$P(Y,";",2,99) I DD]"" G SS:DD'[(":"_X) W:DIC(0)["E" $P(DD,X,2,9) S X=$P(DD,":",1) Q
 K X S Y=-1 Q
 ;
V ;VARIABLE POINTER
 I X["?BAD" K X Q
 G ^DENTDCM2
 ;
LC ;
 Q:DIC(0)["X"  S DIC(0)=$P(DIC(0),"L",1)_$P(DIC(0),"L",2)
 F %=1:1 S Y=$E(X,%) I Y?.L Q:Y=""  S X=$E(X,1,%-1)_$C($A(Y)-32)_$E(X,%+1,999)
 G DIC^DENTDCM
 ;
SOU ;
 S DSOU="01230129022455012623019202",DSOV=X,X=$C($A(X)-(X?1L.E*32)),DIX=$E(DSOU,$A(X)-64) F DIY=2:1 S Y=$E(DSOV,DIY) Q:","[Y  I Y?1A S %=$E(DSOU,$A(Y)-$S(Y?1U:64,1:96)) I %-DIX,%-9 S DIX=% I % S X=X_% Q:$L(X)=4
 S X=$E(X_"000",1,4) K DSOU,DSOV
