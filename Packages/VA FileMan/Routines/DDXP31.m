DDXP31 ;SFISC/DPC-CREATE EXPORT TEMPLATE ;30SEP2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1005**
 ;
XPT ;
 N DIC,DIR,DLAYGO
 W ! S DDXPOUT=0
 ;S DIR(0)="F^2:30",DIR("A")="Enter name for EXPORT Template"
 ;S DIR("?",1)="Enter the name of the Export Template to be produced.",DIR("?",2)="The name must be from 2 to 30 characters." ;,DIR("?")="The new Export Template cannot overwrite an existing Print Template file entry."
 ;D ^DIR
 ;I $D(DIRUT) S DDXPOUT=1 Q
 S DIC("S")="I $P(^(0),U,8)=3,$P(^(0),U,4)=DDXPFINO,$P(^(0),U,5)=DUZ!'$P(^(0),U,5)" ;**GFT Let them pick one of their own existing EXPORT TEMPLATES for this FILE
 S DIC="^DIPT(",DIC(0)="AOVELZ",DLAYGO=0 W ! D ^DIC I Y<0 S DDXPOUT=1 Q
 I '$P(Y,U,3) S $P(^(0),U,4)="",X=0 F  S X=$O(^(X)) Q:X=""  K ^(X) ;Throw away FILE so it can be stuffed back. throw away rest of Template
 ;'$P(Y,U,3) W !,$C(7),$P(Y,U,2)_" entry in the Print Template file already exists.",!,"Please enter the name of a new template.",!! G XPT
 S DDXPXTNO=+Y
 Q
 ;
LENGTH ;
 W !!,"This template will produce fixed length records."
 W !,"Enter the length of each field below."
 W !,"The specified number should be the length in the TARGET file.",!!
 D GETOUT Q:DDXPOUT
 S DDXPTLEN=0
 S DIR(0)="N^1:255:0",DIR("?")="Enter a number from 1 to 255 as the length of this field in the TARGET file"
 F DDXPFLD=1:1:DDXPTOTF D  I DDXPOUT Q  G LENGTH
 . I DDXPNOUT(DDXPFLD) S DDXPFLEN(DDXPFLD)=0 Q
 . S DIR("A")=DDXPFCAP(DDXPFLD),DDXPOUT=0 D ^DIR
 . I $D(DIRUT) S DDXPOUT=1 Q
 . S DDXPFLEN(DDXPFLD)=Y,DDXPTLEN=DDXPTLEN+Y
 . Q
 K DIR,X,Y
 Q
FLDNAME ;
 W !!,"Enter the name of the fields below in the TARGET file."
 W !,"If you press <RET>, no name will be used.",!!
 D GETOUT Q:DDXPOUT
 S DIR(0)="FO^0:30"
 S DIR("?")="Enter up to 30 characters as the name of this field in the TARGET file"
 F DDXPFLD=1:1:DDXPTOTF D  I DDXPOUT=1 Q  G FLDNAME
 . I DDXPNOUT(DDXPFLD) Q
 . S DIR("A")=DDXPFCAP(DDXPFLD),DDXPOUT=0 D ^DIR
 . I $D(DTOUT)!$D(DUOUT) S DDXPOUT=1 Q
 . S DDXPFFNM(DDXPFLD)=Y
 . Q
 K DIR,X,Y
 Q
DTYPE ;
 W !!,"Enter the data types of the fields being exported below.",!!
 D GETOUT Q:DDXPOUT
 S DIR(0)=".42,1"
 F DDXPFLD=1:1:DDXPTOTF D  I DDXPOUT=1 Q  G DTYPE
 . I DDXPNOUT(DDXPFLD) Q
 . S DIR("A")=DDXPFCAP(DDXPFLD),DIR("B")=$P(^DI(.81,DDXPDT(DDXPFLD),0),U,1),DDXPOUT=0 D ^DIR
 . I $D(DIRUT) S DDXPOUT=1 Q
 . S DDXPDT(DDXPFLD)=+Y
 . Q
 K DIR,X,Y
 Q
IOM ;
 S DDXPOUT=0
 W !!,"Enter the maximum length of a physical record that can be exported.",!,"Enter '^' to stop the creation of an EXPORT template.",!
 I $D(DDXPTLEN) D
 . W "The default shown is based on the total lengths of the fields being exported.",!
 . S DIR("B")=DDXPTLEN+1
 . Q
RIOM S DIR(0)=".44,7" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S DDXPOUT=1 Q
 I Y>255,$P(DDXPFMZO,U,6) W !!,$C(7),"The length cannot be greater than 255 when sending fixed length records.",! G RIOM
 S DDXPIOM=Y
 Q
 ;
ASKDELM ;
 S DDXPOUT=0
 W !!,"You can choose a delimiter to be placed between output fields.",!,"Enter <RET> to use no delimiter.",!,"Enter '^' to stop the creation of an EXPORT template.",!
 S DIR(0)=".44,1" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) S DDXPOUT=1 Q
 S:X="@" Y=X S DDXPDELM=Y
 Q
ASKRDLM ;
 S DDXPOUT=0
 W !!,"You can choose a delimiter to be placed between output records.",!,"Enter <RET> to use no delimiter",!,"Enter '^' to stop the creation of an EXPORT template.",!
 S DIR(0)=".44,2" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) S DDXPOUT=1 Q
 S:X="@" Y=X S DDXPRDLM=Y
 Q
GETOUT ;To see if user wants to continue.
 S DDXPOUT=0
 W "Do you want to continue?"
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("?")="If you do not give this information, an EXPORT template will NOT be created."
 D ^DIR K DIR I $D(DIRUT)!'Y S DDXPOUT=1 Q
 W !!
 Q
