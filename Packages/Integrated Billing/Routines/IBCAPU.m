IBCAPU ;ALB/WCJ - Claims Auto Processing Utilities;27-AUG-10
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; 
CMSPRINT() ; Returns the CMS-1500 Printer defined in the IB Site Parameters. 
 N DIC,DA,DR,DIC,DIQ,RESULT,D0
 S DIC="^IBE(350.9,"
 S DR="8.14"
 S DA=1,DIQ="RESULT"
 D EN^DIQ1
 Q $G(RESULT(350.9,1,8.14))
 ;
UBPRINT() ; Returns the UB-04 Printer defined in the IB Site Parameters. 
 N DIC,DA,DR,DIC,DIQ,RESULT,D0
 S DIC="^IBE(350.9,"
 S DR="8.15"
 S DA=1,DIQ="RESULT"
 D EN^DIQ1
 Q $G(RESULT(350.9,1,8.15))
 ;
EOBPRINT() ; Returns the UB-04 Printer defined in the IB Site Parameters.  
 N DIC,DA,DR,DIC,DIQ,RESULT,D0
 S DIC="^IBE(350.9,"
 S DR="8.16"
 S DA=1,DIQ="RESULT"
 D EN^DIQ1
 Q $G(RESULT(350.9,1,8.16))
