RCDPP283 ;ALB/TXH - PRCA*4.5*283 PRE-INIT
 ;;4.5;Accounts Receivable;**283**;Mar 20, 1995;Build 8
 ;
 Q
PRE ; Pre-init to delete field .03 from file 344.3
 ; the data is not deleted.
 ;
 N DIK,DA
 S DIK="^DD(344.3,",DA=.03,DA(1)=344.3
 D ^DIK
 K DIK,DA
 ;
 Q
