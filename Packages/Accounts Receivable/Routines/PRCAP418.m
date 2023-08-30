PRCAP418 ;SAB/EDE - PRCA*4.5*418 POST INSTALL;;NOV 23 2021
 ;;4.5;Accounts Receivable;**418**;Mar 20, 1995;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for PRCA*4.5*418")
 D NEWCANC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for PRCA*4.5*418")
 Q
 ;
NEWCANC ; add new Suspend reason to file 433.001
 N FDA
 D MES^XPDUTL("     -> Adding new Suspend Reason to file 433.001...")
 I $$FIND1^DIC(433.001,,"X","14","B") D  Q
 .D MES^XPDUTL("        Already exists.")
 .Q
 S FDA(433.001,"+1,",.01)=14                    ; code
 S FDA(433.001,"+1,",.02)="CLELAND-DOLE"        ; name
 S FDA(433.001,"+1,",.03)=0                     ; Inactive
 D UPDATE^DIE("","FDA")
 D MES^XPDUTL("        Done.")
 Q
