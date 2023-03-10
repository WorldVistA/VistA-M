PRCAP393 ;EDE/SAB - PRCA*4.5*393 POST INSTALL;02/11/21
 ;;4.5;Accounts Receivable;**393**;Mar 20, 1995;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*393")
 D REINDEX
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*393")
 Q
 ;
REINDEX ;Update the Auto Add Field to set all active plans to Yes
 ;
 N DA,DIK,X,Y               ; ^DIE variables
 D MES^XPDUTL("Re-indexing the Description field in the AR SUSPEND REASON file ... ")
 ;
 S DIK="^PRCA(433.001,",DIK(1)=".02^C" D ENALL^DIK
 ;
 D MES^XPDUTL(" ... Done. ")
 Q
 ;
