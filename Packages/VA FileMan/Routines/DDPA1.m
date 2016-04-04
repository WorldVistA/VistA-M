DDPA1 ;SFISC/TKW  RESET IX NODES ON HAND-EDITED TEMPLATES ;5/12/95  11:23
V ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ;
 N A,B,I,J,X,DIR
 S DIR("?",1)="This will repair known hand-edited templates in national packages.",DIR("?",2)="If none show on the report, it means that none of the templates on your system"
 S DIR("?")="needed to be repaired."
 S DIR(0)="Y",DIR("A")="Repair ""IX"" nodes on hand-edited templates",DIR("B")="Yes" D ^DIR Q:Y'=1
 W !!,"Searching Sort Template file...please wait",!!,"Report of templates repaired",!!
 K ^TMP($J) S U="^"
 S ^TMP($J,"DG FEMALE INPATIENTS")="^DPT(""CN"",^DPT(^2"
 S ^TMP($J,"RT WARD LIST")="^DPT(""AA"",^DPT(^2"
 S J="RT CHARGED BY HOME BY BOR^RT CHARGED BY HOME BY NAME^RT OVER BY HOME BY BOR^RT OVER BY HOME BY NAME^RT OVER BY DIV BY BOR^RT OVER BY DIV BY NAME^RT OVER BY DIV BY TD^RT OVER BY HOME BY TD^RT CHARGED BY HOME BY TD"
 F I=1:1 S X=$P(J,U,I) Q:X=""  S ^TMP($J,X)="^RT(""AC"",^RT(^2"
 S J="RT HOME LIST BY BOR^RT HOME LIST BY NAME^RT HOME LIST BY TD"
 F I=1:1 S X=$P(J,U,I) Q:X=""  S ^TMP($J,X)="^RT(""AH"",^RT(^2"
 S ^TMP($J,"RT LOOSE FILING")="^RT(""AL"",^RT(^2"
 S ^TMP($J,"DGPT WORKFILE")="^DG(45.85,""ACENSUS"",^DG(45.85,^2"
 S ^TMP($J,"A1B2 OUTPUT1")="^A1B2(11500.2,""AREM"",^A1B2(11500.2,^2"
 S ^TMP($J,"DG PTF NO ADMISSION")="^DGPM(""ATT3"",^DGPM(^2"
 S (^TMP($J,"XTLK KEYWORD ALPHA"),^TMP($J,"XTLK KEYWORD CODES"))="^XT(8984.1,""AD"",^XT(8984.1,^2"
 F I=0:0 S I=$O(^DIBT(I)) Q:'I  S X=$P($G(^(I,0)),U) I $D(^TMP($J,X)) D
 . S B=$G(^DIBT(I,2,1,"IX")),A=^TMP($J,X) Q:A=B
 . W X,!,"  Before: ",B,!
 . S ^DIBT(I,2,1,"IX")=A
 . W "  After:  ",^DIBT(I,2,1,"IX"),!
 . Q
 K ^TMP($J) W !!!,"DONE!!",!
 Q
