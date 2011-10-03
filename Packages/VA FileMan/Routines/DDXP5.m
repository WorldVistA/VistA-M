DDXP5 ;SFISC/DPC-PRINT FOREIGN FORMAT DOC ;12/17/92  10:15
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 ;
 N SEL,CHOICE,OUT,NOMORE K DIS
 S DIR(0)="SM^1:Only print selected foreign formats;2:Print all foreign formats"
 D ^DIR K DIR Q:$D(DIRUT)  S SEL=Y,OUT=0
 I SEL=1 D  Q:$G(CHOICE)=1
 . S DIC="^DIST(.44,",DIC(0)="QEAM",NOMORE=0
 . F CHOICE=1:1 D  Q:OUT
 . . W ! D ^DIC I Y=-1 S OUT=1 Q
 . . S DIS(CHOICE)="I D0="_+Y
 . . Q
 . K DIC
 . Q
 S DIC="^DIST(.44,",L=0,FLDS="[DDXP FORMAT DOC]",DHD="[DDXP FORMAT DOC HDR]",BY="NAME;S2;C1",FR="" W !
 D EN1^DIP
 K Y,DIRUT
 Q
