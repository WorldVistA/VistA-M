PRCAI150 ;WISC/RFJ-post init patch 150 ; 1 Feb 00
 ;;4.5;Accounts Receivable;**150**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start pre init
 ;  remove the checksum field from the auto payment file
 ;
 N %,DA,DIC,DIK,X,Y
 S DIK="^DD(344.2,",DA=.06,DA(1)=344.2
 D ^DIK
 Q
