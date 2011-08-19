ONCOU0 ; WISC/MLH - UTILITIES for File 160 (ONCOLOGY PATIENT) ;6/25/93  09:51
 ;;2.11;ONCOLOGY;**24**;Mar 07, 1995
RXFU ;    reindex FOLLOW-UP (#400)
 N DA S DA(1)=0
 W:'$D(ZTQUEUED) !!,"Re-indexing FOLLOW-UP"
 FOR  S DA(1)=$O(^ONCO(160,DA(1))) Q:'DA(1)  D
 .  N DIK
 .  I '$D(ZTQUEUED) W:$R(100)=0 "."
 .  K ^ONCO(160,DA(1),"AA"),^("B"),DIK
 .  S DIK="^ONCO(160,"_DA(1)_",""F"",",DIK(1)=.01
 .  F DIK(1)=.01,1 D ENALL^DIK
 .  Q
 ;END FOR
 ;
 W:'$D(ZTQUEUED) !,"Done!",!! Q
 ;
INAUTPSY ;    initialize AUTOPSY (#22.9) to 1 if performed
 N PI S PI=0 W:'$D(ZTQUEUED) !!,"Initializing AUTOPSY" F  S PI=$O(^ONCO(160,PI)) Q:'PI  L +^ONCO(160,PI) S:$P($G(^ONCO(160,PI,1)),U,9) $P(^(1),U,13)=1 L -^ONCO(160,PI) I '$D(ZTQUEUED) W:$R(100)=0 "."
 W:'$D(ZTQUEUED) !,"Done!",!! Q
