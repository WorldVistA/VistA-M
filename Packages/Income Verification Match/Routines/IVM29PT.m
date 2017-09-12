IVM29PT ;ALB/KCL - POST-INSTALL FOR PATCH IVM*2*9 ; 15-DEC-1997
 ;;2.0;INCOME VERIFICATION MATCH;**9**; 21-OCT-94
 ;
 ;
EN ; Entry point for post-install
 ;
 D NOTIFY  ; send 'installation' notification msg
 ;
 Q
 ;
 ;
NOTIFY ; --
 ; This function will generate a notification message that the facility has installed the patch in a production account.
 ;
 N DIFROM,IVMSITE,IVMTEXT,XMTEXT,XMSUB,XMDUZ,XMY,Y
 ;
 ; if not in production account, do not send notification message (exit)
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") Q
 ;
 D BMES^XPDUTL(">>> Sending a 'completed installation' notification to the HEC...")
 ;
 ; get facility name/station number
 S IVMSITE=$$SITE^VASITE
 ;
 S XMSUB="Patch IVM*2*9 Installed "_"("_$P(IVMSITE,"^",3)_")"  ; subject
 S XMDUZ="IVM PACKAGE"  ; sender
 S XMY(DUZ)="",XMY(.5)=""  ; local recipient
 S XMY("G.ENROLLMENT EXTRACT@IVM.DOMAIN.EXT")=""  ; remote recipient
 ;
 ; message text
 S XMTEXT="IVMTEXT("
 S IVMTEXT(1)="               Facility Name:  "_$P(IVMSITE,"^",2)
 S IVMTEXT(2)="              Station Number:  "_$P(IVMSITE,"^",3)
 S IVMTEXT(3)="                Installed By:  "_$P($G(^VA(200,+$G(DUZ),0)),"^")
 S IVMTEXT(4)=""
 S IVMTEXT(5)="  Installed IVM*2*9 patch on:  "_$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 D ^XMD
 ;
 D BMES^XPDUTL("Notification message sent.")
 ;
 Q
