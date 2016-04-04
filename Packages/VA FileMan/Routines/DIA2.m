DIA2 ;SFISC/GFT-SELECT ENTRY TO EDIT, ^LOOP ;16MAY2007
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1009,147,1028**
 ;
 K ^UTILITY("DIT",$J),DA,DRS,DW,DIAP,DI I '$D(DR(1,J(0))) S DR(1,J(0))=".01:99999999"
 I $L(DR(1,J(0)))+$L(DIA)<216,+DR(1,J(0))=.01 S DR(1,J(0))="S:DIA(9) DQ=2,X=$P("_DIA_"DA,0),U,1);"_DR(1,J(0))
DIC W !! G Q^DIB:$D(DTOUT) D L S DIA(1)=+Y,DIA(9)=$P(Y,U,3) I Y>0 D DIE,^DIA3:'$D(DA) G DIC
 I X'["LOOP",X'["loop" D PTS^DITP:$O(^UTILITY("DIT",$J,0))>0 K ^UTILITY("DIT",$J) G Q^DIB
 S L="EDIT ENTRIES",DHD="@",IOP="HOME",FLDS="",DHIT="S DCC="""_$$CONVQQ^DILIBF(DIA)_""" D LOOP^DIA2 S:'$D(DCC) DN=0" D EN1^DIP W !!?4,"LOOP ENDED!" Q:$D(DTOUT)  G DIC
 ;
L K Y,I,J,F,DIC S (DIC,DIE)=DIA,DIC(0)="QEALM" D  K DIE S DIE=DIA Q
 .N DIA,DR D ^DIC ;could go to a custom lookup that deranges these variables
 ;
DIE S DP=DIA("P"),DA=+Y,DR=DR(1,DP)
 K DIC,Y,C,DB S DIC=DIE,DILK=DIE_DA_")" D LOCK^DILF(DILK) ;**147
 E  W $C(7),!,"ANOTHER TERMINAL IS EDITING THIS ENTRY!" K DILK Q
 I DR?1"^".AN D @DR L @("-"_DILK) K DILK Q
 E  D GO^DIE L @("-"_DILK) K DILK Q
 ;
LOOP ;DELETE OR REPLACE POINTERS
 G NUL:$D(@(DCC_D0_",-9)")) I '($G(DIFIXPT)=1) W !!,?3
 S X=$P(@(DCC_"0)"),U,2) G NUL:'$D(^(D0,0)) S (DI,Y)=$P(^(0),U,1),C=$P(^DD(+X,.01,0),U,2)
 D
 . N X D Y^DIQ
 I $G(DIFIXPT)=1 D
 . I $D(DIFIXPTH) S ^TMP("DIFIXPT",$J,DIFIXPTC)=DIFIXPTH,DIFIXPTC=DIFIXPTC+1 K DIFIXPTH
 . S ^TMP("DIFIXPT",$J,DIFIXPTC)=" Entry:"_D0_"-"_$E(Y,1,20)_"     "
 . Q
 I '($G(DIFIXPT)=1) W Y
 S Y=D0,(DIE,DIC)=DCC,%C=0
 I X["I",'($G(DIFIXPT)=1) S %Y=0 F  S %C=$O(^DD(+X,0,"ID",%C)) Q:%C=""  S %=^(%C) D
 . N DIQUIET
 . W "  ",$E(@(DCC_"Y,0)"),0) X %
 K DO S %C=-1,DO(2)=X,Y=Y_U_DI,DIC(0)=$P("E^",U,('($G(DIFIXPT)=1))) D ACT^DICM1 S DI=99 K DO,DIY Q:Y<0
 S Y=D0 D DIE S:$G(DIFIXPT) DIFIXPTC=DIFIXPTC+1 I $D(DTOUT) K DCC,Y
 I $D(Y) K Y I '($G(DIFIXPT)=1) S %=1 W $C(7),!!,"WANT TO STOP LOOPING" D YN^DICN I %-2 K DCC
NUL S DI=99,(^UTILITY($J,99,0),DX(0))="Q" K D1,D2,D3,D4,D5
 Q
