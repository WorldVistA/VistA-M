IBY714PO ;YMG/EDE - IB*2.0*714 POST INSTALL;;DEC 17 2021
 ;;2.0;Integrated Billing;**714**;21-MAR-94;Build 8
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*714")
 D UPDCANC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*714")
 Q
 ;
UPDCANC ; update cancellation reason in file 350.3
 N FDA,IEN
 D MES^XPDUTL("     -> Updating Cancellation Reason in file 350.3...")
 S IEN=+$$FIND1^DIC(350.3,,"X","COMPACT","B")
 I IEN D
 .S FDA(350.3,IEN_",",.05)=2  ; UC visit processing
 .D FILE^DIE("","FDA")
 .Q
 D MES^XPDUTL("        Done.")
 Q
