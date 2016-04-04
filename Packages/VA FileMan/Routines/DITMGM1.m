DITMGM1 ;SFISC/EDE(OHPRD)-INTERACTIVE MERGE ;
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
START ;
 K DITMGMRG
 S DITMGMRG("GO")=0
 S DIC=1,DIC(0)="AEMQ" D ^DIC K DIC
 Q:Y<0
 S DITMGMRG("FILE")=+Y
 S DIC=DITMGMRG("FILE"),DIC(0)="AEMQ",DIC("A")="From entry: " D ^DIC K DIC
 Q:Y<0
 S DITMGMRG("FR")=+Y
 S DIC=DITMGMRG("FILE"),DIC(0)="AEMQ",DIC("A")="To entry: " D ^DIC K DIC
 Q:Y<0
 S DITMGMRG("TO")=+Y
 I DITMGMRG("FR")=DITMGMRG("TO") W !!,"From entry same as to entry!",!,$C(7) Q
 S DIC=1,DIC(0)="AEMQ",DIC("A")="Enter file to exclude from merge: " F  D ^DIC Q:Y<1  S DITMGMRG("EXCLUDE",+Y)=""
 K DIC
 S DIR(0)="Y",DIR("A")="Exclude files in affected packages",DIR("B")="NO"
 S DIR("?",1)="This routine normally relinks/merges all files.  Do you want to exclude"
 S DIR("?")="files that are part of a package that has its own merge routine?"
 D ^DIR K DIR
 Q:$D(DIRUT)
 I Y S DITMGMRG("PACKAGE")="",DITMGMRG("GO")=1 Q
 S DIR(0)="Y",DIR("A")="Merge only files in a specific package?",DIR("B")="NO"
 S DIR("?",1)="If you say NO you will merge all files pointing to the primary file."
 S DIR("?",2)="If you say YES you will be asked for a package file entry and only"
 S DIR("?")="merge the files in that package that point to the primary file."
 D ^DIR K DIR
 Q:$D(DIRUT)
 I 'Y S DITMGMRG("GO")=1 Q
 S DIC=9.4,DIC(0)="AEMQ" D ^DIC K DIC
 Q:Y<0
 S DITMGMRG("PACKAGE")=+Y
 S DITMGMRG("GO")=1
 Q
