IB20P159 ;ALB/MR - Diagnostic Measures Updates POST-INIT ;13-JUL-01
 ;;2.0;INTEGRATED BILLING;**159**;21-MAR-94
 ;
 ; -  Fix the wrong entry 'BILL PURGE' if necessary. The correct name
 ;    is 'BILL PURGED'.
 I $D(^IBE(356.8,"B","BILL PURGE")) D RNB
 ;
 Q
 ;
RNB ; - Fix the 'BILL PURGE' entry in the RNB file (#356.8)
 N IBRNB,DIE,DA,DR,DD,DINUM,Y
 ;
 D BMES^XPDUTL("Fixing 'BILL PURGED' entry in the RNB file")
 ;
 S IBRNB=$O(^IBE(356.8,"B","BILL PURGE",""))
 I IBRNB S DA=IBRNB,DIE="^IBE(356.8,",DR=".01///BILL PURGED" D ^DIE
 ;
 Q
