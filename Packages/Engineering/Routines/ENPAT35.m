ENPAT35 ;(WIRMFO)/DH-Delete old incomplete PM Work Orders ;1.6.97
 ;;7.0;ENGINEERING;**35**;Aug 17,1993
 ;  Distributed as part of post-init for EN*7.0*35
PM I '$D(^ENG("PATCH 7*35 PM DELETE")) G PMDUN
 N SHOP,DA,ENDA,DIK,COUNT S COUNT=0
 S DIK="^ENG(6920,",ENDA("START")=$P(^ENG("PATCH 7*35 PM DELETE",0),U,2)
 S SHOP=0 F  S SHOP=$O(^ENG("PATCH 7*35 PM DELETE",SHOP)) Q:'SHOP  D
 . S ENDA=9999999999-ENDA("START")
 . F  S ENDA=$O(^ENG(6920,"AINC",SHOP,ENDA)) Q:'ENDA  D
 .. S DA=9999999999-ENDA
 .. I $E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-" D ^DIK S COUNT=COUNT+1
PMDUN K ^ENG("PATCH 7*35 PM DELETE"),^TMP($J)
 S XMY(DUZ)="",XMDUZ=.5,XMSUB="Deletion of Old Incomplete PM Work Orders"
 S ^TMP($J,1)=COUNT_" old incomplete PM work orders were just deleted."
 S XMTEXT="^TMP($J,"
 D ^XMD
 K XMY,XMDUZ,XMTEXT,XMSUB
 K ^TMP($J)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;ENPAT35
