DIWE2 ;SFISC/GFT-WP SEARCH, CHANGE, INSERT ;09:56 AM  26 Oct 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,999**
 ;
 S DWI=DWLC,DWJ=0,DWLR=DWLW I DWLC W !,$J(DWLC,3),">",@(DIC_DWLC_",0)")
NEWL W !,$J(DWJ+DWI+1,3),">" R X#245:DTIME I '$T,X="" S DTOUT=1 Q
 I X="",DIWPT'="" S X=" "
 Q:U[X!(DIWPT=X)
 I X?."?" D IQ^DIWE5 G NEWL
TAB F  Q:X'[$C(9)  S X=$S($L(X)+4>245:$TR(X,$C(9)," "),1:$P(X,$C(9))_"|TAB|"_$P(X,$C(9),2,999))
 I X'?.ANP W $C(7),!?9,$$EZBLD^DIALOG(8129),! F Y=1:1 I $E(X,Y)?.C G:Y>$L(X) NEWL:X="",G S X=$E(X,1,Y-1)_$E(X,Y+1,999),Y=Y-1 ;**CCO/NI  CONTROL CHARACTERS REMOVED!!
G G NW:'DWPK,NW:X?." "!(X[($C(124)_"TAB"_$C(124)))!($A(X)=124),NL:DWPK=1 S:DWI Y=@(DIC_DWI_",0)") S J=$L(X) I J+DWLR<DWLW S @(DIC_"DWI,0)")=Y_$E(" ",$A(Y,DWLR)'=32)_X,DWLR=$L(@(DIC_"DWI,0)")) G NEWL
 I DWLR+7<DWLW F J=DWLW-DWLR:-1:1 IF $E(X,J)=" " S @(DIC_"DWI,0)")=Y_$E(" ",$A(Y,DWLR)'=32)_$E(X,1,J-1),X=$E(X,J+1,256),DWLR=$L(X) Q
NL I $L(X)>DWLW S J=$F(X," ",DWLW-7),J=$S(J<1!(J>DWLW):DWLW,1:J),DWI=DWI+1,@(DIC_"DWI,0)")=$E(X,1,J-1),X=$E(X,J,256),DWLR=J G NL
 S:$L(X) DWI=DWI+1,@(DIC_"DWI,0)")=X,DWLR=$L(X) G NEWL
NW S:$L(X) DWI=DWI+1,@(DIC_"DWI,0)")=X,DWLR=DWLW G NEWL
 ;
I ;INSERT
 G 1:X=U,OPT^DIWE1:X=DIWPT S DWJ=X W:X !,$J(DWJ,3),">",^(0) K ^UTILITY($J,"W") S DWI=0,DIC(1)=DIC,DIC="^UTILITY($J,""W"",",@(DIC_"0)")="",DWLR=DWLW D NEWL G D:'DWI
 W !,$$EZBLD^DIALOG(8123,DWI) ;**CCO/NI 'N LINES INSERTED..'
 X "F DWL=DWI+DWLC:-1:DWJ+DWI+1 S "_DIC(1)_"DWL,0)="_DIC(1)_"DWL-DWI,0) W ""."""
 X "F DWL=DWI:-1:1 S "_DIC(1)_"DWJ+DWL,0)="_DIC_"DWL,0) W ""."""
D S DWLC=DWLC+DWI,DIC=DIC(1) K ^UTILITY($J,"W"),DIC(1)
1 G ^DIWE1
 ;
S ;SEARCH
 R X:DTIME S:'$T DTOUT=1 I X]"" W " ...",! X "F I=1:1:DWLC I "_DIC_"I,0)[X W $J(I,3)_"">""_^(0),! S DWL=I"
 G 1^DIWE1
 ;
C ;CHANGE;  **CCO/NI  THIS WHOLE SUBROUTINE IS CHANGED
 R DWI:DTIME S:'$T DTOUT=1 G 1:DWI="" W $$EZBLD^DIALOG(8122) R DWJ:DTIME S:'$T DTOUT=1 G 1:'$T
 W !,$$EZBLD^DIALOG(8125) S %=2 D YN^DICN G 1:%<1 S DWL=%=1
FR D  G 1:'X S J=X
 .N DIR S DIR(0)="NAO^1:"_DWLC_":0",DIR("A")=$$EZBLD^DIALOG(8118),DIR("B")=1 D ^DIR
TO D  G 1:'X S I=X
 .N DIR,DTOUT S DIR(0)="NAO^"_+J_":"_DWLC_":0",DIR("A")=$$EZBLD^DIALOG(8117),DIR("B")=DWLC D ^DIR
 W " ...",! F J=J:1:I I @(DIC_"J,0)")[DWI D
 .N L,DIR,DTOUT
 .S DIR(0)="YOA",DIR("A")=$$EZBLD^DIALOG(8124),DIR("B")=$P($$EZBLD^DIALOG(7001),U)
 .S Y=0,L=^(0) I DWL W $J(J,3)_">"_L D ^DIR W ! I $G(Y)-1 S:$D(DTOUT) J=I Q
 .F  S Y=$F(L,DWI,Y) Q:'Y   S L=$E(L,1,Y-$L(DWI)-1)_DWJ_$E(L,Y,999),Y=Y-$L(DWI)+$L(DWJ)
 .W $J(J,3)_">"_L,! S ^(0)=L
 G 1
 ;8117 = 'to line'
 ;8118 = 'from line:'
 ;8122 = 'change to: '
 ;8124 = 'OK to change'
 ;8125 = 'Ask OK for each line found'
