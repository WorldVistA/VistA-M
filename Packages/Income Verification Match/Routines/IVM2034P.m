IVM2034P ;HEC/KSD - Post-Install Driver for IVM*2*34; 12/7/00 8:48am ; 5/13/02 8:26am
 ;;2.0;INCOME VERIFICATION MATCH;**34**;12.07.2000
 ;
EN ; Entry Point used as a driver for post-installation updates
 ; (assumes: TCPDATA array - install question responses)
 ;
 S (TCPDATA(1),TCPDATA(2),TCPDATA(3))=""   ;install questions no longer used
 D NOTIFY
 Q
 ;
NOTIFY ; Generates a notification message that the facility has
 ; installed the patch in a production account.
 ;
 N DIFROM,IVMSITE,IVMNOW,IVMTEXT,SERVLINE,XMTEXT,XMSUB,XMDUZ,XMY,Y,%,IVMPORT,IVMIP
 ;
 ; Quit if not VA production primary domain
 Q:$G(^XMB("NETNAME"))'[".VA.GOV"
 X ^%ZOSF("UCI") S %=^%ZOSF("PROD")
 S:%'["," Y=$P(Y,",")
 Q:Y'=%
 ;
NOTIFY2 ;
 ;
 D BMES^XPDUTL(">>> Sending a 'completed installation' notification to the HEC...")
 ;
 S IVMSITE=$$SITE^VASITE   ; get facility name/station#
 S IVMNOW=$$NOW^XLFDT      ; current date/time
 ;
 ;S X="QDQMGR."  ;FOR TESTING ONLY
 S X=""  ; *** USE THIS FOR PRODUCTION ***
 ;
 S XMSUB="Patch IVM*2*34 Installed "_"("_$P(IVMSITE,"^",3)_")" ;subj
 S XMDUZ="REGISTRATION PACKAGE"   ;sender
 S XMY(DUZ)="",XMY(.5)=""       ;local recipients
 S XMY("G.IRM SOFTWARE SECTION@"_X_"IVM.VA.GOV")=""   ;remote recipient
 S XMY("S.AYC PATCH SERVER@"_X_"IVM.VA.GOV")=""    ;remote server option
 ;
 ; Notification MSG text
 S XMTEXT="IVMTEXT("
 S SERVLINE="PATCHID:IVM*2*34|"_$P(IVMSITE,"^",3)_"|"_IVMNOW
 S SERVLINE=SERVLINE_"|"_TCPDATA(2)_"|"_TCPDATA(3)
 S IVMTEXT(1)=SERVLINE
 S IVMTEXT(2)=""
 S IVMTEXT(3)=""
 S IVMTEXT(4)=""
 S IVMTEXT(5)="     Facility Name :"_$P(IVMSITE,"^",2)
 S IVMTEXT(6)="    Station Number :"_$P(IVMSITE,"^",3)
 S IVMTEXT(7)=" Installed IVM*2*34 patch on:  "_$$FMTE^XLFDT(IVMNOW)
 ;
 D ^XMD
 ;
 D BMES^XPDUTL("     Notification message sent.")
 Q
