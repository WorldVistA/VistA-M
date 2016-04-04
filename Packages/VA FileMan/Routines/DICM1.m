DICM1 ;SFISC/XAK,TKW-LOOKUP WHEN INPUT MUST BE TRANSFORMED ; 20 Jun 2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**20,29,1032**
 ;
 G @Y
 ;
P ;POINTERS
 G P^DICM0
 ;
D ;DATES
 I $S(X'?.N:1,$L(X)>15:0,1:X>49) S %DT=$S($D(^DD(+DO(2),.001)):"N",1:"")_$P($P(DS,"%DT=""",2),"""") F %="E","R" D DZ
 I  D ^%DT S X=Y K %DT I X>1 D  Q
 . I $D(DINDEX(1,"TRANCODE"))#2 D  Q
 . . X DINDEX(1,"TRANCODE") I $G(X)="" K X S Y=-1 Q
 . . I ('$D(DINDEX(1,"TRANOUT"))#2)!(DIC(0)'["E")!($D(DDS)) Q
 . . N % S %=X N X S X=% X DINDEX(1,"TRANOUT") W "   ",X Q
 . Q:DIC(0)'["E"
 . I '$D(DDS) W "   " D DT^DIQ
 . S DIDA=1 Q
 K X Q
DZ S %DT=$P(%DT,%)_$P(%DT,%,2) Q
 ;
S ;SETS
 N A8,A9,DDH S DDH=0
 I $P(DS,U,2)["*"!($D(DIC("S"))) D SC
 S DICR(DICR,1)=1,I=$P(DS,U,3),DD=$P(";"_I,";"_X_":",2)
 N DS S DS=0
 I DD]"" S Y=X X:$D(A9) A9 I  D SDSP,SK Q
SS S DICMF=0
 F DICM=1:1 S DD=$P(I,";",DICM) Q:DD=""  I $P($P(DD,":",2),X)="" D
 . S Y=$P(DD,":"),DD=$P(DD,":",2) Q:DIC(0)["X"&(DD'=X)
 . I $D(A9) X A9 E  Q
 . I DIC(0)["O"!(DIC(0)'["E") S:DD=X DICMF=1 I DD'=X,DICMF=1 Q
 . S DS=DS+1 D SDSP
 . S DS(DS)=Y_"^     "_DDH_"   "_DDH(DDH,Y)
 G:DDH=0 NO
 I DDH=1 D  G SK
 . S X=$O(DDH(1,""))
 . W:DIC(0)["E"&('$D(DDS)) "  ("_DDH(1,X)_")"
 . S:$D(DS(1,"T")) X=DS(1,"T") Q
 G:DIC(0)'["E" NO
 I $D(DDS) S DD=DDH,DDD=2 K DDQ D LIST^DDSU K DDD,DDQ G:$D(DTOUT) NO
 I '$D(DDS) F  D  Q:DICM'="AGN"
 . F DICM=1:1:DDH W !,$P(DS(DICM),U,2,999)
 . W !,"CHOOSE 1-"_DDH_": "
 . R DIY:$S($D(DTIME):DTIME,1:300) E  Q
 . Q:U[DIY!(DIY[U)  I DIY?1.N,$D(DS(+DIY)) Q
 . W $C(7),"??" S DICM="AGN"
 G:+$P(DIY,"E")'=DIY NO G:'$D(DS(+DIY)) NO
 S X=$P(DS(DIY),U)
 I '$D(DDS) W "   "_DDH(DIY,X),!
 S:$D(DS(DIY,"T")) X=DS(DIY,"T")
 G SK
 ;
NO K X,Y S Y=-1
SK K DIC("S") S:$D(A8) DIC("S")=A8
 K DDH,DICM,DICMF,DICMS
 Q
SC ;SCREENS ON SETS
 S:$D(DIC("S")) A8=DIC("S") Q:$P(DS,U,2)'["*"
 Q:'$D(^DD(+DO(2),.01,12.1))  X ^(12.1) Q:'$D(DIC("S"))
 S Y="("_DIC,I="DIC"_DICR,%=""""_%_"""",A9="X DIC(""S"")"
 Q:$G(DICR(DICR))?1"""".E1""""
 ;I DS["DINUM=X" S D=D_" E  I $D"_Y_"Y,0))" Q
 S A9=A9_" E  F "_I_"=0:0 S "_I_"=$O"_Y
 I @("$O"_Y_%_",0))'=""""") S A9=A9_%_",Y,"_I_")) Q:"_I_"=""""  "_$S($D(A8):"X ""N Y S Y="_I_" ""_A8 I $T,",1:"I ")_"$D"_Y_I_",0)) Q" Q
 S A9=A9_I_")) Q:'"_I_"  "_$S($D(A8):"X ""N Y S Y="_I_" ""_A8 I $T,",1:"I ")_"$P(^("_I_",0),U)=Y Q" Q
 ;
SDSP ; Execute screen, transform, set up output for display
 N DISAVX,DISAVY,DIXX,DIOUT S DIOUT=0,DIXX=Y
 S DDH=DDH+1,DDH(DDH,Y)=$P("  (^",U,(DS=0))_Y
 I $D(DINDEX(1,"TRANCODE"))#2 D  S:'DIOUT&('DS) X=DIXX I DIOUT S Y=-1 Q
 . S DISAVY=Y N X,Y S X=DISAVY
 . X DINDEX(1,"TRANCODE") I $G(X)="" S DIOUT=1 Q
 . S DIXX=X I DS S DS(DS,"T")=X Q
 I $G(DINDEX(1,"TRANOUT"))]"" D
 . S DISAVY=Y N X,Y S X=DIXX X DINDEX(1,"TRANOUT")
 . S DDH(DDH,DISAVY)=$P("  (^",U,(DS=0))_$G(X) Q
 S DDH(DDH,Y)=DDH(DDH,Y)_"   "_$P(DD,";")_$P(")^",U,(DS=0))
 I DS=0,DIC(0)["E",'$D(DDS) W DDH(DDH,Y)
 Q
 ;
V ;VARIABLE POINTER
 I X["?BAD" K X Q
 D ^DICM2,DO^DIC1
 Q
 ;
T ; Execute TRANSFORM code for indexes other than Pointers, Date, VP or Sets.
 N DIXX S DIXX=X
 X DINDEX(1,"TRANCODE") I $G(X)="" K X S Y=-1 Q
 I DIXX=X K X S Y=-1
 Q
 ;
SOU ;
 S DSOU="01230129022455012623019202",DSOV=X,X=$C($A(X)-(X?1L.E*32)),DIX=$E(DSOU,$A(X)-64) F DIY=2:1 S Y=$E(DSOV,DIY) Q:","[Y  I Y?1A S %=$E(DSOU,$A(Y)-$S(Y?1U:64,1:96)) I %-DIX,%-9 S DIX=% I % S X=X_% Q:$L(X)=4
 S X=$E(X_"000",1,4) K DSOU,DSOV Q
 ;
ACT ;
 S DIY=Y,DIY(1)=DIC,DIC("W")="",DIX=X
A I $G(DO(2)) X:$D(^DD(+DO(2),0,"ACT")) ^("ACT")
 I Y<0 S DIC=DIY(1),X=DIX G W
 I $G(DO(2))["P" N % S %=^DD(+DO(2),.01,0) I $P(%,U,2)["P",$P(%,U,3)]"" S DIC=U_$P(%,U,3) D DO I $D(@(DIC_+$P(Y,U,2)_",0)")) S Y=+$P(Y,U,2)_U_$P(^(0),U) G A
 S Y=DIY,DIC=DIY(1),X=DIX
W K DIC("W")
DO K DO D DO^DIC1
 Q
