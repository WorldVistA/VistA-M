MHV1P10 ;KUM - My HealtheVet Install Utility Routine ; [1/15/13 15:01pm]
 ;;1.0;My HealtheVet;**10**;Aug 23, 2005;Build 50
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10018 : UPDATE^DIE
 ;        10103 : $$FMTH^XLFDT
 ;              : $$HTFM^XLFDT
 ;              : $$NOW^XLFDT
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
 D QRYSMC
 D QRYTIU
 D RSPTIU
 D PRLSMS
 D PRLSME
 D PRLSMSR
 D PRLSMER
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
QRYSMC ; Setup for Clinics By Stop Code query
 ; Setup MHV REQUEST TYPE 
 ;
 D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - SMCLINICS   ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SMCLINICS"
 S FIELDS("NUMBER")=41
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMClinicsByStopCode"
 S FIELDS("EXECUTE")="SPCLIN~MHVXCLN"
 S FIELDS("BUILDER")="SMORG~MHV7B9A"
 S FIELDS("DESCRIPTION",1)="QBP^Q11 query for Clinic information."
 S FIELDS("DESCRIPTION",2)="Specify Clinic name or leave blank for all."
 S FIELDS("DESCRIPTION",3)="Specify Credit Stop Code, not null, 719 is expected."
 S FIELDS("DESCRIPTION",4)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
QRYTIU ; Setup for TIUTITLES Query
 ;
  D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - TIUTITLES    ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="TIUTITLES"
 S FIELDS("NUMBER")=42
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="TIUTitlesByDocumentClass"
 S FIELDS("EXECUTE")="EXTRACT~MHVXTIU"
 S FIELDS("BUILDER")="MHV7B1C"
 S FIELDS("DESCRIPTION",1)="QBP^Q13 query for TIU Titles information."
 S FIELDS("DESCRIPTION",2)="Specify Document Class Name, SECURE MESSAGING DOCUMENTS is expected."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
RSPTIU ; Set up RESPONSE MAP FOR TIUTITLES
 D BMES^XPDUTL("    Creating Entry in MHV RESPONSE MAP - MHVSM QBP-Q13 Subscriber    ")
 N FLDS,ERR
 K FLDS
 S ERR=""
 S FLDS("SUBSCRIBER")="MHVSM QBP-Q13 Subscriber"
 S FLDS("PROTOCOL")="MHVSM RTB-K13 Event Driver"
 S FLDS("BUILDER")="RTBK13~MHV7B1"
 S FLDS("SEGMENT")="RDT"
 D LOG^MHVUL2("UPDATE RESPONSE MAP",.FLDS,"M","DEBUG")
 D UPDMAP^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
 ;
PRLSMS ; Setup for PROTOCOLs
 D BMES^XPDUTL("    Creating Entry in PROTOCOL - MHVSM QBP-Q13 Subscriber    ")
 N NAME,IEN,FIELDS,ERR
 S ERR=""
 S NAME="MHVSM QBP-Q13 Subscriber"
 S IEN=$O(^ORD(101,"B",NAME,0))
 I IEN Q
 I 'IEN S IEN="+1"
 S IEN=IEN_","
 S FIELDS(101,IEN,.01)="MHVSM QBP-Q13 Subscriber"
 S FIELDS(101,IEN,44)="MHVSM QBP-Q13 Subscriber"
 S FIELDS(101,IEN,4)="subscriber"
 S FIELDS(101,IEN,99)=$$FMTH^XLFDT($$NOW^XLFDT())
 S FIELDS(101,IEN,770.4)="K13"
 S FIELDS(101,IEN,770.11)="RTB"
 S FIELDS(101,IEN,773.1)="YES"
 S FIELDS(101,IEN,773.3)="NO"
 S FIELDS(101,IEN,770.2)="MHV VISTA"
 S FIELDS(101,IEN,771)="D QBPQ13^MHV7R6"
 S FIELDS(101,IEN,773.2)="YES"
 ;S FIELDS(101,IEN,770.95)="2.4"
 D UPDATE^DIE("E","FIELDS","","ERR")
 I $D(ERR("DIERR")) D 
 . S ERR=$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
PRLSME ; Setup for PROTOCOLs
 D BMES^XPDUTL("    Creating Entry in PROTOCOL - MHVSM QBP-Q13 Event Driver    ")
 N NAME,IEN,FIELDS,ERR
 S ERR=""
 S NAME="MHVSM QBP-Q13 Event Driver"
 S IEN=$O(^ORD(101,"B",NAME,0))
 I IEN Q
 I 'IEN S IEN="+1"
 S IEN=IEN_","
 S FIELDS(101,IEN,.01)="MHVSM QBP-Q13 Event Driver"
 S FIELDS(101,IEN,44)="MHVSM QBP-Q13 Event Driver"
 S FIELDS(101,IEN,4)="event driver"
 S FIELDS(101,IEN,99)=$$FMTH^XLFDT($$NOW^XLFDT())
 S FIELDS(101,IEN,770.4)="Q13"
 S FIELDS(101,IEN,770.1)="MHV SM"
 S FIELDS(101,IEN,770.3)="QBP"
 S FIELDS(101,IEN,770.5)="QBP_Q13"
 S FIELDS(101,IEN,770.95)="2.4"
 S FIELDS(101.0775,"+2,"_IEN,.01)="MHVSM QBP-Q13 Subscriber"
 D UPDATE^DIE("E","FIELDS","","ERR")
 I $D(ERR("DIERR")) D 
 . S ERR=$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
PRLSMSR ; Setup for PROTOCOLs
 D BMES^XPDUTL("    Creating Entry in PROTOCOL - MHVSM RTB-K13 Subscriber    ")
 N NAME,IEN,FIELDS,ERR
 S ERR=""
 S NAME="MHVSM RTB-K13 Subscriber"
 S IEN=$O(^ORD(101,"B",NAME,0))
 I IEN Q
 I 'IEN S IEN="+1"
 S IEN=IEN_","
 S FIELDS(101,IEN,.01)="MHVSM RTB-K13 Subscriber"
 S FIELDS(101,IEN,44)="MHVSM RTB-K13 Subscriber"
 S FIELDS(101,IEN,4)="subscriber"
 S FIELDS(101,IEN,99)=$$FMTH^XLFDT($$NOW^XLFDT())
 S FIELDS(101,IEN,770.4)="K13"
 S FIELDS(101,IEN,770.11)="RTB"
 S FIELDS(101,IEN,773.1)="YES"
 S FIELDS(101,IEN,773.3)="NO"
 S FIELDS(101,IEN,770.2)="MHV SM"
 S FIELDS(101,IEN,770.7)="MHVVA"
 S FIELDS(101,IEN,773.2)="YES"
 D UPDATE^DIE("E","FIELDS","","ERR")
 I $D(ERR("DIERR")) D 
 . S ERR=$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
PRLSMER ; Setup for PROTOCOLs
 D BMES^XPDUTL("    Creating Entry in PROTOCOL - MHVSM RTB-K13 Event Driver    ")
 N NAME,IEN,FIELDS,ERR
 S ERR=""
 S NAME="MHVSM RTB-K13 Event Driver"
 S IEN=$O(^ORD(101,"B",NAME,0))
 I IEN Q
 I 'IEN S IEN="+1"
 S IEN=IEN_","
 S FIELDS(101,IEN,.01)="MHVSM RTB-K13 Event Driver"
 S FIELDS(101,IEN,44)="MHVSM RTB-K13 Event Driver"
 S FIELDS(101,IEN,4)="event driver"
 S FIELDS(101,IEN,99)=$$FMTH^XLFDT($$NOW^XLFDT())
 S FIELDS(101,IEN,770.4)="K13"
 S FIELDS(101,IEN,770.1)="MHV VISTA"
 S FIELDS(101,IEN,770.3)="RTB"
 S FIELDS(101,IEN,770.5)="RTB_K13"
 S FIELDS(101,IEN,770.8)="AL"
 S FIELDS(101,IEN,770.9)="NE"
 S FIELDS(101,IEN,770.95)="2.4"
 S FIELDS(101.0775,"+2,"_IEN,.01)="MHVSM RTB-K13 Subscriber"
 D UPDATE^DIE("E","FIELDS","","ERR")
 I $D(ERR("DIERR")) D 
 . S ERR=$G(ERR("DIERR",1,"TEXT",1))
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
