DIWE1 ;SFISC/GFT-WORD PROCESSING FUNCTION ;4JUN2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1003,158***
 ;
 ;**CCO/NI  THIS ROUTINE THOROUGHLY CHANGED  DIALOGS #9150-9175 ARE NOW USED AS THE OPTIONS
 G X:$D(DTOUT) I '$D(DWL) S I=DWLC,J=$S(I<11:1,1:I-8) W:J>1 ?7,". . .",!?7,". . ." D LL
1 G X:$D(DTOUT) D  G X:'$D(X)
 .N DIR,DIRUT,DDS
 .S DIR(0)="FO",DIR("A")=$$EZBLD^DIALOG(8149),DIR("?")="^D HELP^DIWE1" ;**CCO/NI READ 'EDIT OPTION:'
 .D ^DIR I X="."!$D(DIRUT) K X
LC I X?1L S X=$$UP^DILIBF(X)
 S J="^DOPT(""DIWE1""," I X?1U F I=1:1:26 S DIWEX1=$C(64+I) I DWO[DIWEX1,$F($$EZBLD^DIALOG(I+9150),X)=2 S ^DISV(DUZ,J)=I G OPT
 I X=" ",$D(^DISV(DUZ,J)) S DIWEX1=$C(64+^(J)) I DWO[DIWEX1 W ! G OPT
 I X?1N.N S DIWEX1="E" D LN G E2:X
 D HELP G 1
 ;
HELP ;CALLED FROM DIR READER
 W !?5,$$EZBLD^DIALOG(9149)
 I X?2"?".E F I=1:1:26 S J=$C(64+I) I DWO[J W !?10,$$EZBLD^DIALOG(I+9150)
 W !?5,$$EZBLD^DIALOG(9150) Q
 ;
OPT Q:$D(DTOUT)  S X=$$PROMPT I '$X W $E(X)
 E  I $F($$EZBLD^DIALOG($A(DIWEX1)-64+9150),X)'=2 W !,$E(X)
 W $E(X,2,99) G @DIWEX1
A ;;Add  -- DIALOG #9151
 D ^DIWE2 S (DWL,DWLC)=DWI,@(DIC_"0)=DWLC") G 1:DWLC,X
B ;;Break  #9152
 D RD G B^DIWE4
C ;;Change #9153
 G C^DIWE2
D ;;Delete #9154
 D RD G D^DIWE3
E ;;Edit #9155
 D RD G OPT:X="",1:X=U,LC:X?1A,E2
G ;;Get Data from Another Source #9157
 G X^DIWE5
I ;;Insert #9159
 D RD G I^DIWE2
J ;;Join #9160
 D RD G J^DIWE4
L ;;List #9162
 S DIWELAST=$S($G(DIWELAST):DIWELAST,1:1) W DIWELAST_"//" R X:DTIME S:'$T X=U,DTOUT=1 S:X="" X=DIWELAST D LN G LIST:X,1:X=U W !,$$EZBLD^DIALOG(9162) G L
M ;;Move #9163
 D RD G M^DIWE3
P ;;Print #9166
 R X:DTIME S:'$T X=U,DTOUT=1 S:X="" X=1 D LN,^DIWE4:X G 1
R ;;Repeat #9168
 D RD G R^DIWE3
S ;;Search #9169
 G S^DIWE2
T ;;Transfer #9170
 D RD,Z^DIWE3 G DIWE1
U ;;Utilities #9171
 D ^DIWE11 G 1
Y ;;Y;Y-Programmer Edit #9175
 G Y^DIWE4
 ;;
PROMPT() Q $$EZBLD^DIALOG($A(DIWEX1)-64+9150.1)
 ;
E2 S Y=^(0) S:Y="" Y=" " W !,$J(DWL,3)_">"_Y,! S DIRWP=1 D RW^DIR2 K DIRWP G E2:X?1."?",X:X?1."^"
TAB I X[$C(9) S X=$P(X,$C(9),1)_$C(124)_"TAB"_$C(124)_$P(X,$C(9),2,999) G TAB
 S:X]"" ^(0)=X
 ;check if line is greater than max, DWLW, break line up and treat as an insert
 I $L(X)>DWLW D
 . N I,J,DIC1
 . K ^UTILITY($J,"W") S DIC1=DIC,DIC="^UTILITY($J,""W"",",@(DIC_"0)")=""
 . F DWI=1:1 Q:$L(X)'>DWLW  S J=$F(X," ",DWLW-7),J=$S(J<1!(J>DWLW):DWLW,1:J),@(DIC_"DWI,0)")=$E(X,1,J-1),X=$E(X,J,256)
 . S @(DIC_"DWI,0)")=X
 . W !,$$EZBLD^DIALOG(8123,DWI-1)
 . X "F J=DWL+1:1:DWLC S DWI=DWI+1,"_DIC_"DWI,0)="_DIC1_"J,0) W ""."""
 . S I=DWL X "F J=1:1 Q:'$D("_DIC_"J,0))  S "_DIC1_"I,0)=^(0),I=I+1 W ""."""
 . S DWLC=I-1,DIC=DIC1 K ^UTILITY($J,"W")
 E  I X="@" S (DW1,DW2)=DWL W $$EZBLD^DIALOG(8015) D DEL^DIWE3 ;*CCO/NI   "DELETED"
 W ! S DIWEX1="E" G OPT
 ;
RD R X:DTIME S:'$T DTOUT=1 I X?1."?" D  G RD
 .N I S I(1)=1,I(2)=DWLC W !?5,$$EZBLD^DIALOG(9148,.I),!!,$$PROMPT ;**CCO/NI  "ENTER LINE 1-99"
LN I U[X!(X=".") S X=U Q
 Q:DIWEX1="E"&(X?1A)  I 'DWLC,I<27,I-13 S X=U W "  ",$$EZBLD^DIALOG(8148),! Q  ;**CCO/NI  'NO LINES!'
 I "+- "[$E(X),X?1P.N,$D(DWL) S:X?1P X=X_1 S X=X+DWL W "  "_X
 E  S X=+X
 I (DIWEX1="I"!(DIWEX1="R")&(X=0))!$D(@(DIC_"X,0)")) S DWL=X Q
 S X="" G LNQ^DIWE5
 ;
X K DIWELAST
 G X^DIWE
 ;
LIST W "  "_$$EZBLD^DIALOG(8117)_DWLC_"// " R I:DTIME S:'$T DTOUT=1 S I=$S(I="":DWLC,1:I) I I,I>DWLC!(I<1) S I=DWLC
 S J=X,DIWELAST=$S(DWLC=I:1,1:I) D LL G 1
LL X "F J=J:1:I W !,$J(J,3)_"">""_"_DIC_"J,0)"
