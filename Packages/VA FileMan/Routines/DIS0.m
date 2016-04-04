DIS0 ;SFISC/GFT-SEARCH, IF STATEMENT AND MULTIPLE COMBO'S ;30JAN2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**144**
 ;
 W ! K R,N,DL,DE,DJ
 S O=0,E=$D(DC(2)),N="IF: A// ",DE=$S(E:"IF: ",1:N),DL=0
 S C=","
R W !,DE K DV R X:DTIME S:'$T DTOUT=1 G Q:X[U!'$T
 I X="" S DV=1,DU=X G 1:DL S DQ="TYPE '^' TO EXIT",Y="^1^",DL=1 G BAD:E D ASKQ G L
 S Y=U,P=0,DU="",D="",DL=DL+1
P S P=P+1,DQ=$E(X,P) I DQ="" G BAD:Y=U,L
 I DQ?.A S DV=$A(DQ)-64 I $D(DC(DV)) D ASKQ G CHK
 G P:"&+ "[DQ I DU="","'-"[DQ S DU="'" G P
BAD D  W !! K DJ(DL),DE(DL) S DL=DL-1 G R
 .I DQ?."?" D BLD^DIALOG($S($D(DC(2)):8004.2,1:8004.1)),MSG^DIALOG("WH") Q  ;HELP depending on whether there is a CONDITION B
 .W "   <",DQ,">??"
 ;
ASKQ S J=DC(DV),%=J["?."" """,I=J["^'"+(DU["'")#2 I J["W^" S DV(DV)=$S(I:2-%,1:%+%+1) S:% DC(DV)=$E(J,1,$L(J)-5)_"=""""" Q
 S:$P(J,U)[C DV(DV)=J?.E1",.01^".E&%+(I+%#2) Q
 ;
CHK S %=$F(Y,U_DV) I % S %=$P($E(Y,%),U,1)'=DU,DQ=""""_DQ_""" AND """_$E("'",%)_DQ_""" IS "_$P("REDUNDANT^CONTRADICTORY",U,%+1) G BAD
 S %=1,Y=Y_DV_DU_U,DU="",J=$P(DC(DV),U,1) G P:J'[C F Z=2:1 I $P(J,C,Z,99)'[C S J=$P(J,C,1,Z-1)_C Q
 I J=D D SAMEQ S:%=1 DJ(DL,DV)=DX(DV)
 S D=J,DJ=DV G P:%>0
Q G Q^DIS2
 ;
SAMEQ I J<0,$P(DY(-J),U,3)="" Q
 W !?8,"CONDITION -"_$C(DV+64)_"- WILL APPLY TO THE SAME MULTIPLE AS CONDITION -"_$C(DJ+64)_"-",!?8,"...OK" G YN^DICN
 ;
L S P=O,DL(DL)=Y,DE="OR: " F %=2:1 S X=$P(Y,U,%) Q:X=""  S O=O+1,^UTILITY($J,O,0)=$S(%>2:$S($D(DJ(DL,+X)):"  together with ",1:"   and "),O=1:"",1:" Or ")_$P("not ",U,X["'")_O(+X)
 W:$X>18 ! W "   " F %=P+1:1 Q:'$D(^UTILITY($J,%,0))  S X=^(0) W:$L(X)+$X>77 !?13 W " "_$P(X,U) I $P(X,U,2)'="" W " ("_$P(X,U,2)_")"
 S DV=0
DV S DV=$O(DV(DV)) S:DV="" DV=-1 G:DV'>0 R:E,1 G DV:$D(DJ(DL,DV)) S I=$P(DC(DV),U,1),D=DK,DN=0,Y="DO YOU WANT THIS SEARCH SPECIFICATION TO BE CONSIDERED TRUE FOR CONDITION -"_$C(DV+64)_"-"
G S DN=DN+1,P=$P(I,C,1),I=$P(I,C,2,99) G W:P["W",DV:I="" I P<0 S J=DY(-P),D=+J,R=" '"_$P(^DIC(D,0),U,1)_"' ENTRIES " G G:'$P(J,U,3)
 E  S D=+$P(^DD(D,P,0),U,2),R=" '"_$O(^DD(D,0,"NM",0))_"' MULTIPLES "
HOW W !!,Y,!?8,"1) WHEN AT LEAST ONE OF THE"_R_"SATISFIES IT"
 W !?8,"2) WHEN ALL OF THE"_R_"SATISFY IT" S X=2
 I DV(DV) W !?8,"3) WHEN ALL OF THE"_R_"SATISFY IT,",!?16,"OR WHEN THERE ARE NO"_R S X=3
 W !?4,"CHOOSE 1-"_X_": " I DV(DV)>1 W 3 S %1=3
 E  W 1 S %1=1
 R "// ",%:DTIME,! S:'$T DTOUT=1 S:%="" %=%1 K %1 G Q:%=U!'$T,HOW:%>X!'% I %>1 S DE(DL,DV,DN)=%,O=O+1,^UTILITY($J,O,0)="   for all"_R_$P(", or when no"_R_"exist",U,%>2)
 G G
 ;
W I DV(DV)-2 S DE(DL,DV,DN)=DV(DV) G DV
 W !!,Y,!?7,"WHEN THERE IS NO '"_$P(^DD(D,+P,0),U,1)_"' TEXT AT ALL"
 S %=1 D YN^DICN G Q:%<0,W:'% S DE(DL,DV,DN)=4-% G DV
 ;
1 K O,DX,Y G ^DIS1
