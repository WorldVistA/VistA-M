DIWE11 ;SFISC/GFT,MWE-WORD PROCESSING UTILITY FUNCTION ;08:12 AM  16 Jan 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 ;**CCO/NI   ENTIRE ROUTINE CHANGED
 N DWOU
 S DWOU="ABC"
1 W ! D  Q:'$D(X)
 .N DIR,DIRUT
 .S DIR(0)="FO",DIR("A")=$$EZBLD^DIALOG(9189),DIR("?")="^D HELP^DIWE11"
 .D ^DIR I X="."!$D(DIRUT) K X
LC I X?1L S X=$$UP^DILIBF(X)
 S J="^DOPT(""DIWE11""," I X?1U F I=1:1:3 S DIWEX1=$C(64+I) I DWOU[DIWEX1,$F($$EZBLD^DIALOG(I+9189),X)=2 S ^DISV(DUZ,J)=I G OPT
 I X=" ",$D(^DISV(DUZ,J)) S DIWEX1=$C(64+^(J)) I DWO[DIWEX1 W ! G OPT
 D HELP G 1
 ;
HELP ;CALLED FROM DIR READER
 W !?5,$$EZBLD^DIALOG(8068)
 F I=1:1:3 S J=$C(64+I) I DWO[J W !?10,$$EZBLD^DIALOG(I+9189)
 Q
 ;
OPT Q:$D(DTOUT)  S X=$$EZBLD^DIALOG($A(DIWEX1)-64+9189) I '$X W $E(X)
 W $E(X,2,99) G @DIWEX1
A ;;Editor Change  9190
 D ^DIWE12 W !! Q
 ;
B ;;File Transfer from Foreign CPU  9191
 D X^DIWE5 Q
 ;
C ;;Text-Terminator-String Change  9192
 D  W !! Q
 .N DIR,DTOUT,DUOUT
 .S DIR("A")=$$EZBLD^DIALOG(9184)
 .S DIR("B")=$S(DIWPT="":$$EZBLD^DIALOG(7080),1:DIWPT)
 .S DIR(0)="FO^1:99^K:X[""?"" X"
 .S DIR("?")="^D BLD^DIALOG(9185),MSG^DIALOG(""WH"")"
 .D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 .I "@"[X!(X=$$EZBLD^DIALOG(7080)) W !?5,$$EZBLD^DIALOG(9186) S X=""
 .S DIWPT=X
