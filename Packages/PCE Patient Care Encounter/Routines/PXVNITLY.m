PXVNITLY ;BIR/CML3,ADM - IMMUNIZATION NIGHTLY TASK ;20 MAY 2015
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210**;Aug 12, 1996;Build 21
 ;
EXP ; set STATUS of expired lots to INACTIVE
 ; - must be run nightly immediately after midnight
 ; - loops through entire list every time to avoid missing dates in case
 ;   the process fails to run daily for whatever reason
 ;
 N DA,DIE,DR,PXVDT,X
 D DT^DICRW
 S PXVDT=0
 F  S PXVDT=$O(^AUTTIML("AE",PXVDT)) Q:'PXVDT  I DT>PXVDT D
 .S DA=0 F  S DA=$O(^AUTTIML("AE",PXVDT,DA)) Q:'DA  D
 ..S X=$P($G(^AUTTIML(DA,0)),"^",3)
 ..I 'X S DIE="^AUTTIML(",DR=".03////1" D ^DIE
 Q
LXC ; check for lot number entries that have expired
 ; need to find way to NOT loop through entire list every time,
 ; to stop at orders already checked
 ; PXVDT - date (no time), seeded with today's date
 ; "AE" x-ref - ^AUTTIML("AE",lot number expiration date, lot number IEN)
 ;
 ;
 ;N PXVDT,%,$H,DA,DIE,DILOCKTM,DISYS,X,Y
 ;D DT^DICRW S PXVDT=DT
 ;F  S PXVDT=$O(^AUTTIML("AE",PXVDT),-1) Q:'PXVDT  D  ;
 ;.S DA=0 F  S DA=$O(^AUTTIML("AE",PXVDT,DA)) Q:'DA  D  ;
 ;..S X=$P($G(^AUTTIML(DA,0)),"^",3)
 ;..I 'X S DIE="^AUTTIML(",DR=".O3///2" D ^DIE
 Q
