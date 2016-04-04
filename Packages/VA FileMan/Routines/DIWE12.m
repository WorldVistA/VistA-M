DIWE12 ;SFISC/XAK,RWF-WORD PROCESSING CHANGE EDITORS ;29MAR2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1045**
 ;
 Q:$D(DIWE(1))  S DIWE(1)=DIWE D 1 K DIWE(1) Q
 ;
1 I '$D(DIWE(9)) D ASK G QX:U[X
2 S DIWE=DIWE(9) K DIWE(9) I $D(DIWE(1)),DIWE=DIWE(1) K DIWE(1) Q
OPT S DIWE(5)=$G(^DIST(1.2,DIWE,2)) I DIWE(5)]"" X DIWE(5) I '$T S:$D(DIWE(2)) DIWE(9)=1 G 1 ;Not valid
 Q:$D(DTOUT)  S @(DIC_"0)")=DWLC,DIWE(0)=$S($D(^DIST(1.2,DIWE,1)):^(1),1:"") I $G(DIWE)=1!$D(DDS)!$D(DIWE(1))!($G(DWPK)'="FM"&($D(DIWEPSE)[0)) X DIWE(0) G QQ
 K DIR I $G(DWPK)'="FM" S DIR(0)="E"
 E  D
 . N I,J
EGP . W:'DWLC !,$J("",$G(DL)*2)_$$EZBLD^DIALOG(8148) ;**CCO/NI "THERE ARE NO LINES"
 . I DWLC S I=DWLC,J=$S(I<11:1,1:I-8) W:J>1 ?7,". . .",!?7,". . ." X "F J=J:1:I W !,"_DIC_"J,0)" W !
E . S DIR(0)="Y",DIR("A")=$J("",$G(DL)*2)_$$EZBLD^DIALOG(8175),DIR("B")="NO",DIR("?")="^D BLD^DIALOG(8176),MSG^DIALOG(""WH"")" ;**CCO/NI 'YES' AND 'NO' HELP
 D ^DIR K DIR I '$D(DIRUT),Y=1 D
 .X DIWE(0)
 E  N DIDNEDIT S DIDNEDIT=1 ;DID NOT EDIT, SO DO NOT AUDIT
QQ K DIWEPSE,DUOUT I $D(DIWE(1)) S DIWE=DIWE(1),DIWE(5)=$G(^DIST(1.2,DIWE,3)) X:DIWE(5)]"" DIWE(5)
QX K DWOU I $D(DIWESW) K DIWESW G:'$D(DIWE(1)) 1
 D:$D(DIWE(2)) X^DIWE Q
 ;
ASK W !,$$EZBLD^DIALOG(8170) R X:DTIME S:'$T DTOUT=1,X=U G AQ:U[X!(X=".") ;**CCO/NI 'SELECT ALTERNATE EDITOR:'
 I X'?.UNP S X=$$UP^DILIBF(X) ;**CCO/NI  UPPERCASE TRANSLATION
 S Y=X I X?1U.ANP,'$D(^DIST(1.2,"B",X)) S X=$O(^(X)) S:$E(X,1,$L(Y))'=Y X="?"
 S J="^DIST(1.2," I X?1U.UNP S I=$O(^DIST(1.2,"B",X,0)) I I>0 S ^DISV(DUZ,J)=I,DIWE(9)=I W $P(X,Y,2) G AX
 I X=" ",$D(^DISV(DUZ,J)) S I=^(J) I $D(^DIST(1.2,I,0))#2 S DIWE(9)=I,X=$P(^(0),U,1) W X G AX
 W !,$$EZBLD^DIALOG(8171) ;**CCO/NI (plus next line)  HELP MESSAGE ABOUT CHOOSING AND ALTERNATE EDITOR
 I X?2"?".E W $$EZBLD^DIALOG(8172) S Y="" F I=0:0 S Y=$O(^DIST(1.2,"B",Y)) Q:Y']""  S DIWE=+$O(^(Y,0)),DIWE(5)=$G(^DIST(1.2,DIWE,2)) I 1 X:DIWE(5)]"" DIWE(5) I $T W !?10,Y
 G ASK
AQ S X=U
AX Q
 ;
 ;DIC is the root of the where the text is located.
 ;DWLC is the line count, must be updated by the editor.
 ;The @(DIC_"0)") node will be updated by DIWE on exit.
 ;Variables not to be changed:
 ;DWHD,DIWPT,DWO,DWLR,DWL,DWPK,DWAFT,DIWE
 ;DIWE = Pointer to current editor
 ;DIWE(0) = Calling code
 ;DIWE(1) = if $D Called from this editor, will return at end.
 ;DIWE(2) = if $D Flag to say prefered editor not R/W used in exit.
 ;DIWE(5) = if $D Other execute code for OK TO RUN, RETURN TO CALLING
 ;DIWE(9) = if $D then entry number of editor to switch to.
