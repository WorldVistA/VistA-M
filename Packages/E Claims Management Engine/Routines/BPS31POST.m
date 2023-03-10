BPS31POST ;AITC/PD - Post-install for BPS*1.0*31 ;10/21/2014
 ;;1.0;E CLAIMS MGMT ENGINE;**31**;JUN 2004;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; BPS*1*31 patch post install
 ;
 Q
 ;
EN ; Entry Point for post-install
 ;
 N COUNT
 ;
 D MES^XPDUTL("  Starting post-install for BPS*1*31")
 ;
 ; Set MCCF TAS EDI Progress Flag to 1 for Unstranded Txns
 D UNSTRAND
 ;
EX ; exit point
 D BMES^XPDUTL("  Finished post-install of BPS*1*31")
 Q
 ;
UNSTRAND ; Set MCCF TAS EDI Progress Flag to 1 for Unstranded Txns
 ;
 N IEN
 ;
 D BMES^XPDUTL("    Process NTR Unstranded Txns")
 ;
 S COUNT=0
 ;
 S IEN=""
 F  S IEN=$O(^BPSTL("C",3,IEN)) Q:'IEN  D
 . ; Only reset txns with Payer Response status of E UNSTRANDED
 . I $$GET1^DIQ(9002313.57,IEN,4.0098)'["UNSTRANDED" Q
 . ;
 . ; Reset MCCF TAS EDI Progress Flag to 1 (Ready to Send)
 . N BPSA,BPSFN,BPSREC
 . S BPSFN=9002313.57
 . S BPSREC=IEN_","
 . S BPSA(BPSFN,BPSREC,20)=1
 . D FILE^DIE("","BPSA","")
 . ;
 . ; Update count of how many txns reset to use in mail message
 . S COUNT=COUNT+1
 ;
 ; E-mail results to development team
 D MAIL(COUNT)
 ;
 Q
 ;
MAIL(COUNT) ; E-mail development team # of txns reset
 ;
 N BPSSITENAME,BPSSITENUMBER,BPSVASITE,BPSX,DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 ;
 S BPSVASITE=$$NS^XUAF4($$KSP^XUPARAM("INST"))
 S BPSSITENAME=$P(BPSVASITE,"^")
 S BPSSITENUMBER=$P(BPSVASITE,"^",2)
 S XMSUB="BPS*1.0*31 Post Install Unstranded Txns"
 S XMDUZ=BPSSITENUMBER_" - "_BPSSITENAME
 I '$$PROD^XUPROD(1) S XMY(DUZ)=""
 I $$PROD^XUPROD(1) D
 . S XMY("Mark.Dawson3@domain.ext")=""
 . S XMY("Paul.Devine@domain.ext")=""
 S XMTEXT="BPSX("
 S BPSX(1)=""
 S BPSX(2)=COUNT_" unstranded txn(s) reset for site "_BPSSITENAME_" ("_BPSSITENUMBER_")."
 S BPSX(3)=""
 D ^XMD
 ;
 Q
