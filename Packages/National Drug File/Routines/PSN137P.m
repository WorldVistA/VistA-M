PSN137P ;BIR/DMA-reindex "T" cross reference ; 26 Mar 2007  10:48 AM
 ;;4.0; NATIONAL DRUG FILE;**137**; 30 Oct 98;Build 2
 ;
 N DA,X
 S DA=0 F  S DA=$O(^PSNDF(50.67,DA)) Q:'DA  S X=$P(^(DA,0),"^",5),^PSNDF(50.67,"T",X,DA)=""
 K DA,X
 Q
