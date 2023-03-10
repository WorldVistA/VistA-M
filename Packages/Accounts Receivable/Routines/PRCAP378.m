PRCAP378 ;EDE/SAB - PRCA*4.5*378 POST INSTALL;02/11/21
 ;;4.5;Accounts Receivable;**378**;Mar 20, 1995;Build 54
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*378")
 D UPCAT
 D UPDPAR
 D UPDAUTO
 D UPDBILL
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*378")
 Q
 ;
UPCAT ; update field 1.06 in the AR Category file for "NURSING HOME PROCEEDS" category
 N CAT,FDA
 D MES^XPDUTL("Updating ELIG FOR RPP field for 'NURSING HOME PROCEEDS' AR Category ... ")
 S CAT=+$O(^PRCA(430.2,"B","NURSING HOME PROCEEDS","")) Q:CAT'>0
 S FDA(430.2,CAT_",",1.06)=0
 D FILE^DIE("","FDA")
 D MES^XPDUTL("   Done.")
 Q
 ;
UPDPAR ; update field .16 in the AR SITE PARAMETER file 
 N CAT,FDA
 D MES^XPDUTL("Updating METRICS RETENTION DAYS field in the AR SITE PARAMETER file ... ")
 S FDA(342,"1,",.16)=180
 D FILE^DIE("","FDA")
 D MES^XPDUTL("   Done.")
 Q
 ;
UPDAUTO ;Update the Auto Add Field to set all active plans to Yes
 ;
 N RCI,RCDATA,RCSTAT     ; RPP variables
 N X,Y,DIE,DA,DR,DTOUT   ; ^DIE variables
 D MES^XPDUTL("Activating New Bill AUTO ADD functionality for all active Repayment Plans ... ")
 S RCI=0
 F  S RCI=$O(^RCRP(340.5,RCI)) Q:'RCI  D
 .  S RCDATA=$G(^RCRP(340.5,RCI,0))
 .  S RCSTAT=$P(RCDATA,U,7)
 .  Q:RCSTAT<6    ;status is not Terminated, Closed, or PAID IN FULL
 .  ; Update the Auto-Add flag
 .  S DIE="^RCRP(340.5,",DA=RCI,DR=".12///1"
 .  D ^DIE
 .  K DR,DA,DIE
 ;
 Q
 ;
UPDBILL ; Update all billes associated with a new RPP that is in a closed state, but RPP info is still in the bill.
 ;
 N RCI,RCD4,RCRPID,RCRPST    ; Routine Variables
 N X,Y,DIE,DA,DR,DTOUT       ; ^DIE variables
 S RCI=0
 F  S RCI=$O(^PRCA(430,RCI)) Q:'RCI  D
 .  S RCD4=$G(^PRCA(430,RCI,4))
 .  S RCRPID=$P(RCD4,U,5)
 .  Q:RCRPID=""     ;Bill not linked to a new style Repayment Plan
 .  S RCRPST=$$GET1^DIQ(340.5,RCRPID_",",.07,"I")
 .  Q:RCRPST<6
 .  S DIE="^PRCA(430,",DA=RCI,DR="45///@;41///@"
 .  D ^DIE
 .  K DR,DA,DIE
 Q
