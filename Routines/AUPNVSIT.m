AUPNVSIT ;OHPRD/LAB - EDITS FOR AUPNVSIT (VISIT:9000010) ;10/25/96
 ;;2.0;VISIT TRACKING;**1**;Aug 12, 1996
 ;;93.2;IHS PATIENT DICTIONARIES.;;JUL 01, 1993
 ;
VSIT01 ;EP;9000010,.01 (VISIT,VISIT/ADMIT DATE&TIME)
 I '$D(AUPNPAT) W:'$D(AUPNTALK)&('$D(ZTQUEUED)) "  <No direct entry allowed>" K X Q
 I $D(AUPNDOB),$D(AUPNDOD),AUPNDOB,$D(DT),DT D VSIT01B Q
 I '$D(AUPNTALK),'$D(ZTQUEUED) W "  <Required variables do not exist>"
 K X
 Q
VSIT01B ;
 I DT_".9999"<X W:'$D(AUPNTALK)&('$D(ZTQUEUED)) "  <Future dates not allowed>" K X Q
 I DUZ("AG")="I",AUPNDOD,$P(X,".",1)>AUPNDOD W:'$D(AUPNTALK)&('$D(ZTQUEUED)) "  <Patient died before this date>" K X Q
 I $P(X,".",1)<AUPNDOB W:'$D(AUPNTALK)&('$D(ZTQUEUED)) "  <Patient born after this date>" K X Q
 Q
 ;
POSTSLCT ;
 S AUPNVSIT=+Y,AUPNY=Y
 I '$D(AUPNPAT),$P(^AUPNVSIT(AUPNVSIT,0),U,5) S Y=$P(^(0),U,5) D ^AUPNPAT
 S Y=AUPNY K AUPNY
 Q
 ;
ADD ; ADD TO DEPENDENCY COUNT
 Q:'($D(^AUPNVSIT(X,0))#2)
 L +^AUPNVSIT(X,0):60 ;E  W:'$D(ZTQUEUED) !!,"VISIT locked.  Notify programmer!",! Q
 S:$P(^AUPNVSIT(X,0),U,9)<0 $P(^(0),U,9)=0
 S $P(^AUPNVSIT(X,0),U,9)=$P(^AUPNVSIT(X,0),U,9)+1 ;,$P(^(0),U,11)="" ;*** WILL NOT UNDELETE ***
 ;The next two lines are not used in the VA
 ;I $D(^AUPNVSIT("AMFI",X)),^AUPNVSIT("AMFI",X)="M"
 ;E  I DUZ'=".5",$D(^AUTTSITE(1,0)),$P(^AUTTSITE(1,0),U,16)="V",$P(^AUPNVSIT(X,0),U,15)'="A",$P(^(0),U,15)'="D" S $P(^AUPNVSIT(X,0),U,15)="M",^AUPNVSIT("AMFI",X)="M"
 L -^AUPNVSIT(X,0)
 Q
SUB ; SUBTRACT FROM DEPENDENCY COUNT
 Q:'($D(^AUPNVSIT(X,0))#2)
 L +^AUPNVSIT(X,0):60 ;E  W:'$D(ZTQUEUED) !!,"VISIT locked.  Notify programmer!",! Q
 S $P(^AUPNVSIT(X,0),U,9)=$P(^AUPNVSIT(X,0),U,9)-1 ;S:$P(^(0),U,9)<1 $P(^(0),U,11)=1 *** DON'T DELETE ***
 I $P(^AUPNVSIT(X,0),U,9)<0 S $P(^(0),U,9)=0 ; Should not happen but does
 ;The next two lines are not used in the VA
 ;I $P(^AUPNVSIT(X,0),U,15)="A"
 ;E  I DUZ'=.5,$D(^AUTTSITE(1,0)),$P(^AUTTSITE(1,0),U,16)="V" S $P(^AUPNVSIT(X,0),U,15)="D",^AUPNVSIT("AMFI",X)="D"
 L -^AUPNVSIT(X,0)
 Q
 ;
MOD ;EP;MODIFY A VISIT OR V FILE ENTRY 
 ;*******CANNOT BE CALLED FROM DIE **********CALLS DIE
 N X I X ;this line was added so that it will error if this entry is ever called so that you will know that this code was commented out for the VA.
 ;S DA=AUPNVSIT,DIE="^AUPNVSIT(",DR=".13////"_DT D ^DIE K DA,DIE,DIU,DIV,DR
 ;the following updates MFI information   **** NOT DONE IN THE VA ****
 ;Q:'$D(^AUTTSITE(1,0))
 ;Q:$P(^AUTTSITE(1,0),U,16)'="V"
 ;Q:DUZ=.5
 ;I $P(^AUPNVSIT(AUPNVSIT,0),U,15)'="A",$P(^(0),U,15)'="D" S DR=".15///M",DA=AUPNVSIT,DIE="^AUPNVSIT(" D ^DIE
 ;K DIE,DA,DR,DIU,DIV
 Q
 ;*******CANNOT BE CALLED FROM DIE**********CALLS DIE
DEL ;EP;*** EXTERNAL ENTRY POINT ***  SET DELETE FLAG
 N X I X ;this line was added so that it will error if this entry is ever called so that you will know that this code was commented out for the VA.
 ; The following exclusive NEW excepted from SAC by the Director, DSD. Request dated 12.14.92.  No suspense was mandated.
 ;N (DT,DUZ,AUPNVSIT,U)
 ;I $P(^AUPNVSIT(AUPNVSIT,0),U,9) S AUPNVSIT=-1 Q
 ;S DIK="^AUPNVSIT(",DA=AUPNVSIT,X=2 D DD^DIK,1^DIK1
 ;S DA=AUPNVSIT,DR=".11///1",DIE="^AUPNVSIT(" D ^DIE K DA,DIE,DR
 ;I DUZ'=.5,$D(^AUTTSITE(1,0)),$P(^AUTTSITE(1,0),U,16)="V",$P(^AUPNVSIT(AUPNVSIT,0),U,15)="A" S DA=AUPNVSIT,DR=".15///@",DIE="^AUPNVSIT(" D ^DIE K DA,DIE,DR Q
 ;I DUZ'=.5,$D(^AUTTSITE(1,0)),$P(^AUTTSITE(1,0),U,16)="V",$P(^AUPNVSIT(AUPNVSIT,0),U,15)'="A" S DA=AUPNVSIT,DR=".15///D",DIE="^AUPNVSIT(" D ^DIE K DA,DIE,DR Q
 Q
