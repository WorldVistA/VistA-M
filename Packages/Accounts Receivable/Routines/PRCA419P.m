PRCA419P ;MNTVBB/RS - PRCA patch 419 post install ; MAR 21, 2023
 ;;4.5;Accounts Receivable;**419**;Mar 20, 1995;Build 5
 ;
 Q
 ;
POST ; 
 ; Update the (#259)field of Active ChampVA bills in (#430) file
 N IBA
 D BMSG("PRCA*4.5*419 Post-Install starts.....")
 D UPDATE
 D BMSG("PRCA*4.5*419 Post-Install is complete.")
 Q
 ;
UPDATE ;UPDATE THE #259 FIELD OF THE #430 FILE
 N PRCACAT,PRCASTA,PRCAREF
 S DA=0 F  S DA=$O(^PRCA(430,DA)) Q:'DA  D
 .S PRCACAT=$P(^PRCA(430,DA,0),"^",2),PRCASTA=$P(^PRCA(430,DA,0),"^",8)
 .I "^27^28^"[("^"_PRCACAT_"^"),PRCASTA=16 D
 ..S PRCAREF=$P(^PRCA(430,DA,11),"^",10)
 ..I PRCAREF=9 S DR="259///02",DIE="^PRCA(430," D ^DIE
 ..Q
 .Q
 K DA,DR,DIE
 Q
 ;
BMSG(IBA) ;
 D BMES^XPDUTL(IBA)
 Q
