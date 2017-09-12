PRCAI149 ;WISC/RFJ-post init patch 149 ; 1 Feb 00
 ;;4.5;Accounts Receivable;**149**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start pre init
 ;  remove the comment field from the receipt file so the c cross
 ;  reference will be deleted.  the field will be reinstalled with
 ;  the kids build
 N %,DA,DIC,DIK,X,Y
 S DIK="^DD(344.1,",DA=1,DA(1)=344.1
 D ^DIK
 ;
 ;  kill cross reference data
 K ^RC(344.1,"C")
 Q
