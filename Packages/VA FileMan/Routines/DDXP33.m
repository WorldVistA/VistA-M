DDXP33 ;SFISC/DPC - CREATE EXPORT TEMPLATE (CONT) ;12:45 PM  7 Jun 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**9**
 ;
FLDTEMP ;
 S DDXPOUT=0
 S DIC="^DIPT(",DIC(0)="QEASZ",DIC("S")="I $P(^(0),U,8)=7",DIC("A")="Enter SELECTED EXPORT FIELDS Template: ",D="F"_DDXPFINO W ! D IX^DIC K DIC,D
 I Y=-1 S DDXPOUT=1 Q
 S DDXPFDTM=+Y,DDXPFDNM=$P(Y,U,2)
 N DDXPY
 S DDXPY=Y(0)
 D SHOWFLD G:DDXPOUT FLDTEMP
 Q
SHOWFLD ;
 W !!,"Do you want to see the fields stored in the "_DDXPFDNM_" template?"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 I $D(DIRUT) S DDXPOUT=1 Q
 I Y D  Q:DDXPOUT
 . W ! S D0=DDXPFDTM D ^DIPT K D0
 . W !,"Do you want to use this template?"
 . S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR W !
 . I 'Y!$D(DIRUT) S DDXPOUT=1
 . Q
 S DDXPTMDL=0
 I DUZ(0)[$E($P(DDXPY,U,6),1)!(DUZ(0)="@") D  I $D(DIRUT) K DDXPY S DDXPOUT=1 Q
 . W !!,"Do you want to delete the "_DDXPFDNM_" template"
 . W !,"after the export template is created?"
 . S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR W !
 . S:Y DDXPTMDL=1
 . K DDXPY
 Q
