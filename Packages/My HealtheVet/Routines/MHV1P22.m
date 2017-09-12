MHV1P22 ;LB - My HealtheVet Install Utility Routine ; [1/15/13 15:01pm]
 ;;1.0;My HealtheVet;**22**;Oct 16, 2015;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;              : $$INSTALDT^XPDUTL(): Return All Install Dates/Times
 ;        10018 : UPDATE^DIE
 ;        10103 : $$FMTH^XLFDT
 ;              : $$HTFM^XLFDT
 ;              : $$NOW^XLFDT
 ;        2067  : $$PKGPAT^XPDIP(): Update Patch History
 ;
ENV ;
 Q
 ;
PRE ; Pre-init routine
 ; Turn on MHV Application Logging, add a log entry for the start
 ; of the patch install.
 ;----------------------------------------------------------------------------
 ; Check if any SM Clinics are missing the Institution
 D LOGON
 D LOG^MHVUL2(XPDNM,"PRE-INIT","S","TRACE")
 S ERR=""
 S MHVC=0
 D LOG^MHVUL2("CHECK","INSTITUTION","S","TRACE")
 D CHKHLOC(.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("CHECK INSTITUTION",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket to check INSTITUTION and DIVISION in Hospital Location File.")
 . D BMES^XPDUTL("     This install will now abort.  Only attempt to re-install when ")
 . D MES^XPDUTL("     corrective action has been taken.")
 . S XPDABORT=2
 . Q
 ;----------------------------------------------------------------------------
 ; Defect 218690 -Fix for Patch MHV*1.0*11 Install
 ; Check if Patch MHV*1.0*11 has been installed in the PATCH INSTALL File
 D LOG^MHVUL2("CHECK","MHV*1.0*11 INSTALL","S","TRACE")
 N MHVP,RSLT,P11SEQ,P11DT,P11VER,P11USR,P11COM,P11IIEN,P11CDT,RET,MHVC,MHVPINST,MHVPKIEN
 S MHVP=0,ERR=""
 ;Check if Patch MHV*1.0*11 is in Patch History File
 S MHVPINST=$$PATCH^XPDUTL("MHV*1.0*11")
 I MHVPINST=1 D
 . D BMES^XPDUTL("    Patch MHV*1.0*11 SEQ#14 currently exists in MHV PATCH APPLICATION HISTORY.")
 . D MES^XPDUTL("     No update of Patch MHV*1.0*11 is necessary.")
 . D BMES^XPDUTL("    This install will now continue with the next steps.")
 ;
 I MHVPINST<1 D  ;Patch was not found in MHV PATCH APPLICATION HISTORY
 . S MHVP=$$INSTALDT^XPDUTL("MHV*1.0*11",.RSLT)     ;check the INSTALL history
 . I MHVP<1 S ERR="Patch MHV*1.0*11 SEQ #14 has never been installed" Q
 . S ERR=""
 . S MHVPKIEN=$$FIND1^DIC(9.4,"","BX","My HealtheVet","","","ERR")  ;get local MHV Package IEN
 . S ERR=$G(ERR("DIERR",1,"TEXT",1)) Q:$G(ERR)'=""
 . S P11VER="1.0"                                   ;patch version -fixed
 . S P11DT=$O(RSLT("@"),-1)                         ;get last install date
 . S RET="11 SEQ#14^"_P11DT             ;patch^date installed
 . S MHVP=$$PKGPAT^XPDIP(MHVPKIEN,P11VER,.RET)      ;Update Patch History File
 . I +$P($G(MHVP),"^",2)>0 D  Q
 . . D BMES^XPDUTL("     Patch MHV*1.0*11 SEQ#14 Install History Succesfully Updated")
 . ;This should never hapen? but just in case-err handling below:
 . I +$P($G(MHVP),"^",2)'>0 D  
 . . S ERR="Patch MHV*1.0*11 SEQ #14 Install History could not be updated"
 . . D BMES^XPDUTL("     "_ERR)
 . . D MES^XPDUTL("     Please log a Help Desk Incident ticket for this issue.")
 ;
 I ERR'="" D ERRSTAT(ERR)
 D LOG^MHVUL2(XPDNM,"PRE-INIT END","S","TRACE")
 Q
 ;
ERRSTAT(ERRCOM) ;
 D LOG^MHVUL2("CHECK MHV*1.0*11 SEQ#14 INSTALL",ERRCOM,"S","ERROR")
 D BMES^XPDUTL("     *** An Error occurred during installation.")
 D MES^XPDUTL("     Please Install the Released Patch MHV*1.0*11 SEQ#14 first.")
 D BMES^XPDUTL("    This install will now abort. Only attempt to re-install when ")
 D MES^XPDUTL("     corrective action has been taken.")
 S XPDABORT=2
 Q
 ;
POST ; Post-init routine
 N ERR
 D LOG^MHVUL2(XPDNM,"POST-INIT BEGIN","S","TRACE")
 D LOG^MHVUL2(XPDNM,"POST-INIT END","S","TRACE")
 D LOGOFF
 D RESET^MHVUL2
 Q
 ;
LOGON ; Turn on MHV application logging
 N UPDATE,SUCCESS
 D BMES^XPDUTL("     Turning on MHV Application Logging")
 S UPDATE("STATE")=1
 S UPDATE("DELETE")=$$HTFM^XLFDT($H+60)
 S UPDATE("LEVEL")="DEBUG"
 D LOGSET^MHVUL1(.SUCCESS,.UPDATE)
 Q
 ;
LOGOFF ; Turn off MHV application logging
 N SUCCESS
 D BMES^XPDUTL("     Turning off MHV Application Logging")
 D LOGOFF^MHVUL1(.SUCCESS)
 Q
 ;
CHKHLOC(ERR) ; Check Institution in Hospital Location File (#44)
 N MHVCSIEN,MHVCLIEN,MHVINST,MHVDIVN
 S MHVCSIEN=$$SCIEN(719)
 I $G(MHVCSIEN)="" S ERR="MHV SECURE MESSAGING Stop Code is not found in STOP CODE File" Q
 S MHVCLIEN=0
 F  S MHVCLIEN=$O(^SC("ACST",MHVCSIEN,MHVCLIEN)) Q:'MHVCLIEN  D
 .S MHVCLNM=$$GET1^DIQ(44,+MHVCLIEN,.01,"I")
 .I ($G(MHVCLNM)'="")&($$UP^XLFSTR($E(MHVCLNM,1,2))'="ZZ")  D
 ..S MHVINST=$$GET1^DIQ(44,+MHVCLIEN,3,"E")
 ..S MHVDIVN=$$GET1^DIQ(44,+MHVCLIEN,3.5,"E")
 ..I ($G(MHVINST)="")!($G(MHVDIVN)="")  D
 ...D CHKLERR(.MHVCLNM)
 ...S ERR="Missing Institution/Division field in Hospital Location File (#44)"
 ...Q
 Q
 ;
CHKLERR(MHVCLNM) ; Print messages in case of Institution or Division missing
 D LOG^MHVUL2("INSTITUTION-DIVISION MISSING",$G(MHVCLNM),"S","ERROR")
 I MHVC=0  D
 .D BMES^XPDUTL("     *** Please check the following Secure Messaging Clinics that the")
 .D MES^XPDUTL("     *** Institution field and Division field have valid values")
 S MHVC=MHVC+1
 D MES^XPDUTL("     "_$G(MHVCLNM))
 Q
 ;
SCIEN(SCN) ;Get stop code IEN
 N SCIEN
 I SCN="" Q ""
 S SCIEN=$O(^DIC(40.7,"C",SCN,0))
 I $G(SCIEN)="" Q ""
 Q SCIEN
 ;
