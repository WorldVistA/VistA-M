PRCAP404 ;EDE/SAB - PRCA*4.5*378 POST INSTALL;02/11/21
 ;;4.5;Accounts Receivable;**404**;Mar 20, 1995;Build 7
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*404")
 D UPDAUTO
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*404")
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
 .  Q:RCSTAT>5    ;status is not Terminated, Closed, or PAID IN FULL
 .  ; Update the Auto-Add flag
 .  S DIE="^RCRP(340.5,",DA=RCI,DR=".12///1"
 .  D ^DIE
 .  K DR,DA,DIE
 ;
 Q
 ;
