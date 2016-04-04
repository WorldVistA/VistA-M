DITM ;SFISC/JCM(OHPRD)-FILE COMPARE AND MERGE DRIVER ;6/8/94  14:21
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
START ;
 D ASK ; Asks file, from, to, merge ,etc.
 G:$D(DITM("QFLG")) END
 D ^DITM2
END D EOJ ;----------->Cleanup
 Q  ;-------------->End of routine
 ;--------------------------------------------------------------------
 ;
ASK ;
 D ASKX
 K DITM,%H,DSUB,DMSG,DTO,DFL,DNUM,DDON
 K D001,DHD,^UTILITY($J,"DIT")
 K DITM("QFLG")
 D T^DICRW
 I Y<0 S DITM("QFLG")="" G ASKX
 S (DSUB,DIT,L)=0,DSUB(L)=DIC,DITC=1
 D ^DITM1
 G:$D(DITM("QFLG")) ASKX
 G:'$D(DITM("DFF")) ASK
Q1 ;
 W ! K DIR
 D BLD^DIALOG(8086,"","","DIR(""A"")"),BLD^DIALOG(9041,"","","DIR(""?"")")
 S DIR(0)="YO",DIR("B")=$P($$EZBLD^DIALOG(7001),U,2)
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S DITM("QFLG")="" G ASKX
 S:Y=1 DITM("DIMERGE")=1
 G:'$D(DITM("DIMERGE")) Q6
 W ! F I=1,2 W !?4,I,?10,DTO(I,"X")
 K X,Y
Q2 ;
 W !
 S DIR(0)="N^1:2:0",DIR("?")="^S DMSG=3 D HELP^DITC0"
 S DIR("A",1)=" Note: Records will be merged into the entry selected for the default.",DIR("A")="WHICH ENTRY SHOULD BE USED FOR DEFAULT VALUES "
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S DITM("QFLG")="" G ASKX
 I X'=2 S DITM("DIT(1)")=DIT(2),DITM("DIT(2)")=DIT(1)
 S DITM("DDEF")=2 W !,"   *** Records will be merged into "_DTO(X,"X"),!
 I X'=2
 K X,Y
Q3 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="DO YOU WANT TO DELETE THE MERGED FROM ENTRY AFTER MERGING"
 S DIR("?")="If you enter NO the merged FROM entry will remain in this file"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S DITM("QFLG")="" G ASKX
 S:Y DITM("DELETE")=""
 K X,Y
 G:$D(DITM("SUB FILE")) Q6
Q4 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="DO YOU WANT TO REPOINT ENTRIES POINTING TO THIS ENTRY"
 D ^DIR K DIR
 S:$D(DTOUT)!($D(DUOUT)) DITM("QFLG")=""
 G:$D(DTOUT)!($D(DUOUT)) ASKX
 S:Y DITM("REPOINT")=""
 G:'$D(DITM("REPOINT")) Q6
 K X,Y
Q5 ;
 W !
 S DIR(0)="PO^1:EMZ"
 S DIR("A")="ENTER FILE TO EXCLUDE FROM REPOINT/MERGE"
 S DIR("?")="Any file entered here will not be repointed or merged."
 F DITM=0:0 D ^DIR Q:$D(DIRUT)!(Y<1)  S DITM("EXCLUDE",+Y)=""
 K DIR
 I $D(DUOUT)!($D(DTOUT)) S DITM("QFLG")="" G ASKX
 K X,Y
Q6 ;
 W !
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="DO YOU WANT TO DISPLAY ONLY THE DISCREPANT FIELDS"
 S DIR("?")="^S DMSG=2 D HELP^DITC0"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S DITM("QFLG")="" G ASKX
 S:Y DITM("DDIF")=1
 K X,Y
ASKX ;
 K DFL,DIC,DISYS,DITC,DSUB,I,X,Y,DIPGM,DMSG,%,DIR,DIT,DFF,DTO,DDSP
 Q
EOJ ;
 K DITM,DMSG,DIRUT,L
 Q
 ;8086 NOTE: This option should be used only during non-peak hours...
 ;9041 If you merge two entries within a file that is pointed-to...
 ;7001 Yes^No
