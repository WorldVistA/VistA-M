PRCAP318 ;BIRM/EWL ALB/PJH - ePayment Lockbox Post-Installation Processing ;Dec 20, 2014@14:08:45
 ;;4.5;Accounts Receivable;**318**;Jan 21, 2014;Build 37
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PRE ; pre-installation processing
 N DIK
 D MES^XPDUTL("Deleting PAYER NAME index on EDI THIRD PARTY EFT DETAIL file (#344.31)")
 S DIK="^RCY(344.31,",DIK(1)=".02^C" D ENALL2^DIK
 ;
 ; IA #6747 allows us to use fileman to touch the field LOCK(#19,3)
 D MES^XPDUTL("Removing lock from menu option EDI Diagnostic Measures Reports [RCDPE EDI NATIONAL REPORTS]")
 N DA,PRCADA
 S DA=$$FIND1^DIC(19,,,"RCDPE EDI NATIONAL REPORTS")
 I 'DA G PREEXIT
 S PRCADA(19,DA_",",3)="@"
 D FILE^DIE("","PRCADA")
PREEXIT ; 
 Q
 ;
POST ; PRCA*4.5*318 post-installation processing
 N DIK
 D MES^XPDUTL("Re-indexing PAYER NAME on EDI THIRD PARTY EFT DETAIL file (#344.31)")
 S DIK="^RCY(344.31,",DIK(1)=".02^C" D ENALL^DIK
 Q
