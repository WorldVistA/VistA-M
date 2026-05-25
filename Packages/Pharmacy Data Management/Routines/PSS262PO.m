PSS262PO ;BIR/KML-Post Install routine for patch PSS*1*262 ;10/19/2023
 ;;1.0;PHARMACY DATA MANAGEMENT;**262**;9/30/97;Build 66
 ;External reference to ^XOB(18.02 supported by DBIA 5814
 ;External reference to ^XOB(18.12 supported by DBIA 7204
 ;Reference to REGREST^XOBWLIB is supported by DBIA# 5421
 ;
 ; registers an additional entry to the WEB SERVICE FILE #18.02 in global ^XOB(18.02,
 ; defines an additional entry to the WEB SERVER FILE #18.12 in global ^XOB(18.12,
 ; performs web service calls to validate the server connections
 ; adds entries to the APSP INTERVENTION TYPE file (#9009032.3) in global ^APSPQA(32.3,
 ;
 ;   *****************PLEASE REVIEW FOLLOWING STATEMENT*********************************
 ; BEFORE GO LIVE, THE WEB SERVER AND WEB SERVICE DETAILS FOR PSS PGX-HDR
 ; NEED TO BE ESTABLISHED.  WHAT URLS WILL PRODUCTION SITES CONNECT TO?  NOT TEST SERVERS WHICH IS WHAT
 ; IS PRESENTLY BEING PERFORMED BELOW
 ;
EN ; main
 N PSSLN,HDRERROR,XMSUB
 S (PSSLN,HDRERROR)=0
 K ^TMP("PSS262PO",$J)
 D HDRWS
 D APSP
 D MENUS
 D MENUSA
 D URL
 I HDRERROR D REPORT("PSS PGX-HDR SERVICE","HDRERROR",.PSSLN) S XMSUB="PSS*1*262 Installation has Issues"
 I 'HDRERROR D REPORT("Web Service definitions completed for PSS PGX-HDR SERVICE.","COMPLETE",.PSSLN) S XMSUB="PSS*1*262 Installation has completed."
 D MAIL(XMSUB)
 Q
 ;
HDRWS ; add the HDR web service, the HDR web server, and register
 N WEBSERVICEIEN,WEBSERVERIEN,PSSSERVX S PSSSERVX=0
 D BMES^XPDUTL(""),BMES^XPDUTL("Adding the new HDR server and HDR web service for MOCHA PGx:")
 S WEBSERVICEIEN=$$WEBSERVICE("PSS PGX-HDR SERVICE","cds-wsclient/cds-service","/isAlive")
 I 'WEBSERVICEIEN S HDRERROR=1 D REPORT("PSS PGX-HDR SERVICE has not been created","CREATE",.PSSLN)
 S WEBSERVERIEN=$$WEBSERVER("PSS PGX-HDR SERVER",443,"hdrcluho.hdr.vaec.domain.ext","TRUE","encrypt_only_tlsv12",443)
 I 'WEBSERVERIEN S HDRERROR=1 D REPORT("PSS PGX-HDR SERVER has not been created","CREATE",.PSSLN) Q
 I PSSSERVX D SVR
 I '$$ENABLEWS(WEBSERVERIEN,"PSS PGX-HDR SERVICE") S HDRERROR=1 D REPORT("PSS PGX-HDR SERVICE could not get enabled due to technical problems.","ENABLE",.PSSLN) Q
 I '$$TESTWS(WEBSERVERIEN,"PSS PGX-HDR SERVICE",.PSSLN) D REPORT("PSS PGX-HDR SERVICE is not available.","CONNECT",.PSSLN)
 Q
 ;
SVR ;Update server 
 N DR,DA,DIE,X,Y,DTOUT
 S DA=WEBSERVERIEN,DIE=18.12,DR=".04////"_"hdrcluho.hdr.vaec.domain.ext" D ^DIE
 I $$GET1^DIQ(18.12,WEBSERVERIEN,.04)'="hdrcluho.hdr.vaec.domain.ext" D REPORT("Invalid IP for PSS PGX-HDR SERVER","CREATE",.PSSLN) Q
 Q
 ;
WEBSERVICE(PSSFLD01,PSSFLD200,PSSFLD201) ; add the new HDR web service to WEB SERVICE file (18.02)
 ; input:
 ; PSSFLD01 - name of the web service
 ; PSSFLD200 - CONTEXT ROOT of the web service
 ; PSSFLD201 - AVAILABILITY RESOURCE of the web service
 ; output:
 ; returns the ien of the newly created entry or if not created, then 0 is returned to indicate an error in registering
 I $$FIND1^DIC(18.02,,"BX",PSSFLD01) D BMES^XPDUTL(" - The web service "_PSSFLD01_" is already defined.") Q 1
 ;register the web service (creates a new entry in file 18.02)
 D REGREST^XOBWLIB(PSSFLD01,PSSFLD200,PSSFLD201) ; REGREST^XOBWLIB handles all messaging during post-install
 Q $$FIND1^DIC(18.02,,"BX",PSSFLD01)
 ;
WEBSERVER(PSSFLD01,PSSFLD03,PSSFLD04,PSSFLD301,PSSFLD302,PSSFLD303) ; add the HDR web server to the WEB SERVER (#18.12) file
 N SERVERIEN
 S SERVERIEN=$$FIND1^DIC(18.12,,"BX",PSSFLD01) I SERVERIEN S PSSSERVX=1 D BMES^XPDUTL(" - The web server "_$G(PSSFLD01)_" is already defined.") Q SERVERIEN
 N FDA,IENROOT,PSSERR
 S FDA(18.12,"+1,",.01)=$G(PSSFLD01)       ; NAME
 S FDA(18.12,"+1,",.03)=$G(PSSFLD03)       ; PORT
 S FDA(18.12,"+1,",.04)=$G(PSSFLD04)       ; SERVER ADDRESS
 S FDA(18.12,"+1,",.06)="ENABLED"          ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,"+1,",.07)=5                  ; DEFAULT HTTP TIMEOUT
 S FDA(18.12,"+1,",1.01)="NO"              ; LOGIN REQUIRED
 S FDA(18.12,"+1,",3.01)=$G(PSSFLD301)     ; SSL ENABLED
 S FDA(18.12,"+1,",3.02)=$G(PSSFLD302)     ; SSL CONFIGURATION
 S FDA(18.12,"+1,",3.03)=$G(PSSFLD303)     ; SSL PORT
 D UPDATE^DIE("E","FDA","IENROOT","PSSERR")
 I $D(PSSERR) S SERVERIEN=0
 E  S SERVERIEN=IENROOT(1)
 Q SERVERIEN
 ;
ENABLEWS(SERVERIEN,TEXT) ; enable the web service
 ;Output - 1 OR 0
 ; 1 = successfully enabled
 ; 0 = ERROR occurred during filing
 N IENROOT,PSSERR,FDA
 S FDA(18.121,"?+1,"_SERVERIEN_",",.01)=TEXT      ; WEB SERVICE
 S FDA(18.121,"?+1,"_SERVERIEN_",",.06)="ENABLED"  ; STATUS 1-ENABLED / 0-DISABLED
 D UPDATE^DIE("E","FDA","IENROOT","PSSERR")
 I $D(PSSERR) S IENROOT(1)=0
 Q IENROOT(1)
 ;
TESTWS(WSDA,SERVICE,LINE) ; -- test web services availability
 D BMES^XPDUTL(""),BMES^XPDUTL("Testing the Web Service availability for "_SERVICE)
 N PSSSRVR,PSSX,PSSDOTS,PSSI,PSSXX,ERROR,AVAIL,RESULTS
 S (AVAIL,ERROR)=0
 S RESULTS=1
 S PSSSRVR=##class(xobw.WebServer).%OpenId(WSDA)
 S PSSDOTS=1 ; -- write dots during check processing
 S PSSX=PSSSRVR.checkWebServicesAvailability(PSSDOTS)
 I PSSX]"",PSSX.Count()>0 D
 . F PSSI=1:1:PSSX.Count() S PSSXX=PSSX.GetAt(PSSI) Q:PSSI=""  D
 . . S LINE=LINE+1
 . . I PSSXX["ERROR" S ERROR=1
 . . I PSSXX["PGX_ORDER_CHECKS is available" S AVAIL=1,^TMP("PSS262PO",$J,LINE)=$E(PSSXX,3,) D BMES^XPDUTL(" - "_$E(PSSXX,3,))
 . . I PSSXX["PSS PGX-HDR SERVICE is available" S AVAIL=1,^TMP("PSS262PO",$J,LINE)=$E(PSSXX,3,) D BMES^XPDUTL(" - "_$E(PSSXX,3,))
 I (ERROR)!('AVAIL) S RESULTS=0
 Q RESULTS
 ;
APSP ; add intervention type entries to file 9009032.3
 N X,PSSTYPE
 D BMES^XPDUTL(""),BMES^XPDUTL("Adding the new intervention type entries to the APSP INTERVENTION TYPE"),BMES^XPDUTL(" (#9009032.3) file:")
 F X=1:1:2 S PSSTYPE=$P($T(APSPTXT+X),";",2) D
 . I $$FIND1^DIC(9009032.3,"","X",PSSTYPE,"B") D BMES^XPDUTL(" - "_PSSTYPE_" intervention type already exists.") Q
 . D BMES^XPDUTL("Adding '"_PSSTYPE_"' Intervention Type")
 . D ADDIT(PSSTYPE)
 . I '$$FIND1^DIC(9009032.3,"","X",PSSTYPE,"B") D REPORT("Cannot create '"_PSSTYPE_"' Intervention Type.","CREATE",.PSSLN) Q
 . D BMES^XPDUTL(" - Intervention Type '"_PSSTYPE_"' successfully added.")
 Q
 ;
MENUS ; Restructure menus
 N PSSMENU,PSSMENUQ,PSSMENUR,PSSMENUA,PSSMENUC
 S PSSMENUQ=0
 D BMES^XPDUTL(""),BMES^XPDUTL("Restructuring the PSS menus:")
 S PSSMENU=$$LKOPT^XPDMENU("PSS MGR") I 'PSSMENU D  Q
 .D REPORT("Cannot find PSS MGR Menu option.","CREATE",.PSSLN) Q
 I $$FIND1^DIC(19.01,","_PSSMENU_",","X","PSS CHECK DRUG INTERACTION","B") D
 .S PSSMENUR=$$DELETE^XPDMENU("PSS MGR","PSS CHECK DRUG INTERACTION")
 .I PSSMENUR D BMES^XPDUTL(" - PSS CHECK DRUG INTERACTION removed from PSS MGR....") Q
 .D REPORT("Unable to remove PSS CHECK DRUG INTERACTION from PSS MGR ....","CREATE",.PSSLN)
 S PSSMENUC=0 F PSSMENUA="PSS CHECK DRUG INTERACTION","PSS CHECK PGX INTERACTION","PSS ORDER CHECK CHANGES","PSS REPORT LOCAL INTERACTIONS" D
 .S PSSMENUC=PSSMENUC+1
 .S PSSMENUR=$$ADD^XPDMENU("PSS ORDER CHECK MANAGEMENT",PSSMENUA,,PSSMENUC)
 .I PSSMENUR D BMES^XPDUTL(" - "_PSSMENUA_" added to the PSS ORDER CHECK MANAGEMENT option.") Q
 .D REPORT("Unable to add "_PSSMENUA_" to the PSS ORDER CHECK MANAGEMENT option.","CREATE",.PSSLN)
 Q
 ;
MENUSA ; Restructure menus
 N PSSMENA,PSSMENB
 F PSSMENA="PSO USER1","PSO MANAGER","PSJU MGR","PSJI MGR" D
 .S PSSMENB=$$ADD^XPDMENU(PSSMENA,"PSS CHECK PGX INTERACTION")
 .I PSSMENB D BMES^XPDUTL(" - PSS CHECK PGX INTERACTION added to the "_PSSMENA_" Menu option.") Q
 .D REPORT("Unable to add PSS CHECK PGX INTERACTION added to the "_PSSMENA_" Menu option.","CREATE",.PSSLN)
 Q
 ;
URL ; Add PGx URL to Pharmacy System File
 I '$D(^PS(59.7,1)) D REPORT("Pharmacy System (#59.7) File entry not found.","CREATE",.PSSLN)
 S $P(^PS(59.7,1,"PGX"),"^")="https://bit.ly/VA-PGx"
 Q
 ;
ADDIT(PSSTYPE) ; Add the new intervention type
 N PSSFDA,PSSERR
 S PSSFDA(9009032.3,"+1,",.01)=PSSTYPE
 D UPDATE^DIE("","PSSFDA",,"PSSERR")
 Q
 ;
APSPTXT ;  the 2 new intervention types added to the APSP INTERVENTION file
 ;PHARMACOGENOMIC HIGH ORDER CHECK
 ;PHARMACOGENOMIC MEDIUM ORDER CHECK
 Q
 ;
MAIL(XMSUB) ;Send mail message
 N X,XMTEXT,XMY,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ,XMDUN
 S XMDUZ="PSS*1*262 Install"
 S XMTEXT="^TMP(""PSS262PO"",$J,"
 S XMY("G.PSS ORDER CHECKS")=""
 S XMY(DUZ)=""
 N DIFROM D ^XMD
 Q
 ;
REPORT(TEXT,ACTION,LINE) ; report activity during installation including error conditions
 ; Input -
 ; TEXT -  text to report to end-user
 ; ACTION - what processing occurred
 ; LINE - line number for the mail message passed in by reference
 D:ACTION="CREATE" 1
 D:ACTION="HDRERROR" 2
 D:ACTION="COMPLETE" 3
 D:ACTION="CONNECT" 4
 D:ACTION="ENABLE" 4
 Q
 ;
1 D BMES^XPDUTL("    - "_TEXT),BMES^XPDUTL("        Please contact product support.")
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)="   - "_TEXT
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)="         Please log a SNOW Ticket and refer to this message."
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)=""
 Q
 ;
2 D BMES^XPDUTL("********************************************************************************")
 D BMES^XPDUTL(" ** Due to error(s) "_TEXT_" definition is not complete. **")
 D BMES^XPDUTL("********************************************************************************")
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)=""
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)="** Due to error(s), "_TEXT_" definition is not complete. **"
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)=""
 Q
 ;
3 D BMES^XPDUTL(""),BMES^XPDUTL(TEXT),BMES^XPDUTL("")
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)=""
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)=TEXT
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)=""
 Q
 ;
4 D BMES^XPDUTL("    - "_TEXT),BMES^XPDUTL("         Please contact product support.")
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)="   - "_TEXT
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)="         Please log a SNOW ticket and refer to this message."
 S LINE=LINE+1
 S ^TMP("PSS262PO",$J,LINE)=""
 Q
