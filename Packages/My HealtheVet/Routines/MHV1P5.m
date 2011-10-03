MHV1P5 ;WAS/GPM - My HealtheVet Install Utility Routine ; [4/29/08 11:49pm]
 ;;1.0;My HealtheVet;**5**;Aug 23, 2005;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;
ENV ;
 Q
 ;
PRE ; Pre-init routine
 ; Turn on MHV Application Logging, add a log entry for the start
 ; of the patch install.
 D LOGON
 D LOG^MHVUL2(XPDNM,"PRE-INIT","S","TRACE")
 Q
 ;
POST ; Post-init routine
 N ERR
 D LOG^MHVUL2(XPDNM,"POST-INIT BEGIN","S","TRACE")
 ;
 D BMES^XPDUTL("    Creating SECURE MESSAGING clinic")
 I '$$CLINIC(.ERR) D
 . I ERR="ENTRY EXISTS" D  Q
 . . D BMES^XPDUTL("    *** SECURE MESSAGING clinic exists")
 . . D MES^XPDUTL("     This may be because this patch has already been installed.")
 . . D MES^XPDUTL("     If this is the first installation of this patch,")
 . . D MES^XPDUTL("     Please log a remedy ticket.")
 . . Q
 . D BMES^XPDUTL("    *** Error creating SECURE MESSAGING clinic")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 D QRYSETUP
 ;
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
CLINIC(ERR) ; Set up HOSPITAL LOCATION entry (file #44)
 N CIEN,TIEN,IENS,FDA
 D LOG^MHVUL2("CREATE SM CLINIC","BEGIN","S","TRACE")
 K ERR
 S ERR=""
 ;
 S CIEN=$$FIND1^DIC(44,"","X","SECURE MESSAGING","B","","ERR")
 I CIEN D  Q 0
 . S ERR="ENTRY EXISTS"
 . D LOG^MHVUL2("CREATE SM CLINIC FAILED",ERR,"S","ERROR")
 . Q
 I $G(ERR("DIERR")) D  Q 0
 . S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("CREATE SM CLINIC FAILED",ERR,"S","ERROR")
 . Q
 ;
 S TIEN=$$FIND1^DIC(40.9,"","X","OTHER LOCATION","B","","ERR")
 I 'TIEN D  Q 0
 . I '$G(ERR("DIERR")) S ERR("DIERR",1,"TEXT",1)="NOT FOUND"
 . S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("CREATE SM CLINIC FAILED",ERR,"S","ERROR")
 . Q
 ;
 S IENS="+1,"
 S FDA(44,IENS,.01)="SECURE MESSAGING"
 S FDA(44,IENS,1)="SM"                    ;ABBREVIATION
 S FDA(44,IENS,2)="Z"                     ;TYPE - other location
 S FDA(44,IENS,2.1)=TIEN                  ;TYPE EXTENSION
 S FDA(44,IENS,3)=+$$SITE^VASITE          ;INSTITUTION
 S FDA(44,IENS,10)="Secure Messaging System" ; PHYSICAL LOCATION
 S FDA(44,IENS,2502)="Y"                  ;NON-COUNT CLINIC?
 S FDA(44,IENS,2504)="N"                  ;CLINIC MEETS AT FACILITY?
 D UPDATE^DIE("","FDA","","ERR")
 I $G(ERR("DIERR")) D  Q 0
 . S ERR=$G(ERR("DIERR",1))_"^"_$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("CREATE SM CLINIC FAILED",ERR,"S","ERROR")
 . Q
 ;
 D LOG^MHVUL2("CREATE SM CLINIC","SUCCESS","S","TRACE")
 Q 1
 ;
QRYSETUP ; Setup for demographics query
 ; Setup MHV REQUEST TYPE and MHV RESPONSE MAP
 ;
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SM-DEMOGRAPHICS"
 S FIELDS("NUMBER")=25
 S FIELDS("BLOCK")=1
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMDemographics"
 S FIELDS("EXECUTE")="EXTRACT~MHVXDEMS"
 S FIELDS("DESCRIPTION",1)="QRY^A19 query for patient demographics."
 S FIELDS("DESCRIPTION",2)="Specify patient by ICN, DFN, or SSN."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 K FIELDS
 S ERR=""
 S FIELDS("SUBSCRIBER")="MHVSM QRY-A19 Subscriber"
 S FIELDS("PROTOCOL")="MHVSM ADR-A19 Event Driver"
 S FIELDS("BUILDER")="ADRA19~MHV7B8"
 S FIELDS("SEGMENT")="PID"
 D LOG^MHVUL2("UPDATE RESPONSE MAP",.FIELDS,"M","DEBUG")
 D UPDMAP^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","SM-DEMOGRAPHICS","S","TRACE")
 D TOGGLE^MHVU2("SM-DEMOGRAPHICS","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
