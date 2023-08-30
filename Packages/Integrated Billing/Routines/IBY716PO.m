IBY716PO ;YMG/EDE - IB*2.0*716 POST INSTALL;;NOV 23 2021
 ;;2.0;Integrated Billing;**716**;21-MAR-94;Build 19
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*716")
 D NEWCANC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*716")
 Q
 ;
NEWCANC ; add new cancellation reason to file 350.3
 N FDA
 D MES^XPDUTL("     -> Adding new Cancellation Reason to file 350.3...")
 I $$FIND1^DIC(350.3,,"X","INDIAN ATTESTATION","B") D  Q
 .D MES^XPDUTL("        Already exists.")
 .Q
 S FDA(350.3,"+1,",.01)="INDIAN ATTESTATION"  ; name
 S FDA(350.3,"+1,",.02)="NAI"                 ; abbreviation
 S FDA(350.3,"+1,",.03)=3                     ; limit
 S FDA(350.3,"+1,",.04)=1                     ; can cancel UC
 S FDA(350.3,"+1,",.05)=2                     ; UC visit processing
 D UPDATE^DIE("","FDA")
 D MES^XPDUTL("        Done.")
 Q
