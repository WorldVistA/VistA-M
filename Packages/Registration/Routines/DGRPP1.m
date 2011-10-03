DGRPP1 ;ALB/MRL - REGISTRATION SCREEN PROCESSOR (CONTINUED) ;06 JUN 88@2300
 ;;5.3;Registration;**489,508**;Aug 13, 1993
 ;
STR ;write string of selectable items on the bottom of the screen
 ;
 ;DGRPANP = string to print of selectable items (on bottom of screen)
 ;K = 1 if all items are not selectable (DGRPANP=x,y,z,)
 ;    0 if whole range is selectable (DGRPANP=x-y)
 ;K1 = first item
 ;K2 = last item
 ;
 S (K,K1,K2)="" F I=1:1 S J=+$P(DGRPAN,",",I) Q:'J  S K2=+J S:I=1 K1=J I +$P(DGRPAN,",",I+1),+$P(DGRPAN,",",I+1)'=(J+1) S K=1
 S DGRPANP=$S(K:$E(DGRPAN,1,$L(DGRPAN)-1),K1=K2:K1,1:K1_"-"_K2)
 K K,K1,K2,I,J,I1
 Q
 ;
LT ;local registration template questions
 I '$D(^DG(43,1,0)) W !!,*7,"Your MAS PARAMETER file is not properly set up!" Q
 S XX=$S($D(^DIE(+$P(^DG(43,1,0),"^",35),0)):$P(^(0),"^",1),1:"") I XX']"" Q
 W @IOF S DGRPCM=1,Z="LOCAL REGISTRATION QUESTIONS",X=25 D W^DGRPU
 S X1="",$P(X1,"=",81)="" W !,X1,!!
 S DR="["_XX_"]",DIE="^DPT(",(DA,Y)=DFN D ^DIE
 K XX Q
 ;
JUMP ;jump screens (^N)
 S X=+$E(DGRPANN,2,99) I $D(DGRPVV(X)) S X1=$E(DGRPVV,$P(X,".")) I X1]"",'X1 G @$S(X=1.1:"^DGRPCADD",1:"^DGRP"_X)
 S Z="INVALID SCREEN NUMBER...VALID SCREENS ARE " F I=1,1.1,2:1:DGRPLAST I '$E(DGRPVV,I) S Z=Z_$S(I=DGRPLAST:" and ",1:"")_I_$S(I<DGRPLAST:",",1:".")
 W !,*7 D W H 2
 G:DGRPS'=1.1 @("^DGRP"_DGRPS) G:DGRPS=1.1 ^DGRPCADD  ;return to same screen
 ;
WHICH ; if screen 9, which elements can be edited (vet, spouse, dependents)
 I DGRPS'=9 S DGRPSEL="" Q
 S DGRPSEL="V" I $D(DGREL("S")) S DGRPSEL=DGRPSEL_"S"
 I $O(DGREL("D",0)) S DGRPSEL=DGRPSEL_"D"
 Q
 ;
MOREHLP ; print additional help prompt for screen 9
 I DGRPVV(9)'["0"!+$G(DGRPV) Q  ;view only
 W !,"(To edit only veteran income, precede selection with 'V' [ex. 'V1-3']" I DGRPSEL]"V" W $S(DGRPSEL["SD":",",1:" or"),!
 I DGRPSEL["S" W "precede with 'S' to edit spouse" I DGRPSEL["D" W ", or "
 I DGRPSEL["D" W "precede with 'D' to edit dependents"
 W "): "
 Q
 ;
W ;write highlighted text on screen (if parameter on)
 I IOST="C-QUME",$L(DGVI)'=2 W Z
 E  W @DGVI,Z,@DGVO
 Q
