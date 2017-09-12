PRCA192P ;BAY-OI/RLC- PRE-INIT FOR 192 TO UPDATE CHAMPUS TO TRICARE ;03/31/03
 ;;4.5;Accounts Receivable;**192 **;Mar 20, 1995
 ;Change references to CHAMPUS to TRICARE
 D F4302
 D F3473
 Q
 ;
F4302 ; update file 430.2 with new Category name and Abbreviation
 ; along with the corresponding "B" and "C" cross references
 N DA,PRNM,PRNAME,PRAB,PRABB
 S (PRNM,PRAB,PRABB,PRNAME)="",U="^"
 F  S PRNM=$O(^PRCA(430.2,"B",PRNM)) Q:PRNM=""  D
 .  Q:PRNM'["CHAMPUS"
 .  S PRNAME=$TR($E(PRNM,1,7),"CHAMPUS","TRICARE")_$E(PRNM,8,$L(PRNM))
 .  S DA=$O(^PRCA(430.2,"B",PRNM,0)) Q:'DA
 .  S PRAB=$P(^PRCA(430.2,DA,0),U,2)
 .  S PRABB=$TR($E(PRAB,1),"C","T")_$E(PRAB,2,$L(PRAB))
 .  S $P(^PRCA(430.2,DA,0),U,1)=PRNAME,$P(^(0),U,2)=PRABB
 .  S ^PRCA(430.2,"B",PRNAME,DA)="",^PRCA(430.2,"C",PRABB,DA)=""
 .  K ^PRCA(430.2,"B",PRNM,DA),^PRCA(430.2,"C",PRAB,DA)
 K DA,PRNM,PRNAME,PRAB,PRABB
 Q
 ;
F3473 ; Inactivate Champus Revenue Source Codes file 347.3
 S INACT=1
 F DA=8025,8026,8027 D
 . L +^RC(347.3,DA):10
 . S DIE="^RC(347.3,",DR=".03///^S X=INACT"
 . D ^DIE
 . L -^RC(347.3,DA)
 K DA,DR,DIE,INACT
 Q
