ONCOU55B ;WISC/MLH-UTILITY ROUTINE #3 for ONCOLOGY PRIMARY File (#165.5) ;9/10/93  10:08
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
RXTS ;    reindex TUMOR STATUS (#73) on ONCOLOGY PRIMARY (#165.5) - called by RXTS^ONCOU55
 ;    should only be run after re-indexing follow-up (RXFU^ONCOU0)
 N KT,DA
 N KTS S KTS=0
 W:'$D(ZTQUEUED) !!,"Re-indexing TUMOR STATUS" S DA(1)=0
 F KT=1:1 S DA(1)=$O(^ONCO(165.5,DA(1))) Q:'DA(1)  D RXTSD
 ;END FOR
 ;
 W:'$D(ZTQUEUED) !,KT," primaries processed.",!,KTS," tumor statuses deleted lacking corresponding followups.",!!
 Q
 ;
RXTSD ;    check FU tumor statuses for a primary - called by RXTS
 S DA=0
 F  S DA=$O(^ONCO(165.5,DA(1),"TS",DA)) Q:'DA  D RXTSD1 ;    check a single follow up
 ;
 ;    re-index all xrefs on the .01 field
 N DIK S DIK="^ONCO(165.5,"_DA(1)_",""TS"",",DIK(1)=.01
 K ^ONCO(165.5,DA(1),"TS","AA"),^("B")
 D ENALL^DIK,LTS^ONCOU55(DA(1))
 I '$D(ZTQUEUED) W:$R(100)=0 "."
 Q
 ;
RXTSD1 ;    check a single follow up, delete if dangling - called by RXTSD
 N TSDAT S TSDAT=$P($G(^ONCO(165.5,DA(1),"TS",DA,0)),U,1)
 N PAT S PAT=$P($G(^ONCO(165.5,DA(1),0)),U,2)
 I TSDAT,PAT,$D(^ONCO(160,PAT,"F","B",TSDAT)) ;    all OK
 E  K ^ONCO(165.5,DA(1),"TS",DA) W "*" S KTS=KTS+1 ;    no match - delete
 Q
 ;
 QUIT
