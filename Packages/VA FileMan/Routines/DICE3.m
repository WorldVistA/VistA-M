DICE3 ;SFISC/GFT-TRIGGER LOGIC ;8/14/89  12:37
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 G DIU:DIK=1
 ;
DEL ;
 G DIU:'DLAY
 W !!,$C(7),"ARE YOU SURE YOU WANT TO 'ADD A NEW ENTRY' WHEN THIS "_$P("SET^KILL",U,DIK)_" LOGIC OCCURS"
 S %=2 D YN^DICN W ! I %<1 S X=U Q
 G DIU:%=1 W "..OK, LET ME THINK A SECOND...",! S X=DCNEW,DICOMP="",DA="^DD("_DI_","_DL_",1,"_DQ_","_9 D DICOMP^DICE1
 S DFLD=X F %=9.2:.1 Q:'$D(X(%))  S ^UTILITY("DICE",$J,90+%)=X(%)
DIU S Y=DFLD_" S DIU=X K Y",DA="^DD("_DI_","_DL_",1,"_DQ_","
