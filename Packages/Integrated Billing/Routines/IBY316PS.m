IBY316PS ;;DAOU/DJW - Post Installation Program ;13-September-2005
 ;;2.0;INTEGRATED BILLING;**316**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;Program Description: This is the post install routine for IB*2.0*316
 ;
 ; Set 'INQUIRE POPULAR PAYERS'='NO'(#51.09) and 'NO. POPULAR PAYERS'=1 (#51.1)
 ; 
 ; Remove data from the following fields:
 ; - 'MOST POPULAR LAST SAVE DATE' (#51.21)
 ; - list of 'POPULAR PAYERS' (#51.18)
 ; 
 N DA,DIK,DIE,DR,D,D0,DIC,DQ,X,DI,%
 S DIK="^IBE(350.9,1,51.18,",DA(1)=1,DA=0
 F  S DA=$O(^IBE(350.9,1,51.18,DA)) Q:'DA  D ^DIK
 ;
 S DA=1,DIE="^IBE(350.9,",DR="51.21///@" D ^DIE
 S DA=1,DIE="^IBE(350.9,",DR="51.1///^S X=1" D ^DIE
 S DA=1,DIE="^IBE(350.9,",DR="51.09///^S X=0" D ^DIE
 ;
 Q
