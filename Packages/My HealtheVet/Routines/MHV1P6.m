MHV1P6 ;WAS/DLF - My HealtheVet Install Utility Routine ; 9/25/08 4:06pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10103 : $$HTFM^XLFDT
 ;
ENV ;
 Q
 ;
PRE ; turn on logging
 D LOGON
 D LOG^MHVUL2("MHV1P6","PRE-INIT","S","TRACE")
 Q
 ;
POST ; Post-init
 N ERR
 D LOG^MHVUL2("MHV1P6","POST-INIT BEGIN","S","TRACE")
 ;
 ; Set up the secure messaging Admin queries
 ;
 D QRYSETUP^MHV1P6B
 ;
 ; Add the HL7 protocols for Secure Messaging
 ;
 D HL7
 ;
 D LOG^MHVUL2("MHV1P6","POST-INIT END","S","TRACE")
 D LOGOFF
 D RESET^MHVUL2
 Q
 ;
LOGON ; Turn on logging
 N UPDATE,SUCCESS
 D BMES^XPDUTL("     Turning on MHV Application Logging")
 S UPDATE("STATE")=1
 S UPDATE("DELETE")=$$HTFM^XLFDT($H+60)
 S UPDATE("LEVEL")="DEBUG"
 D LOGSET^MHVUL1(.SUCCESS,.UPDATE)
 Q
 ;
LOGOFF ; Turn off logging
 N SUCCESS
 D BMES^XPDUTL("     Turning off MHV Application Logging")
 D LOGOFF^MHVUL1(.SUCCESS)
 Q
 ;
HL7 ; Set up HL7 protocols
 N FLDS,ERR
 K FLDS
 S ERR=""
 S FLDS("SUBSCRIBER")="MHVSM QBP-Q11 Subscriber"
 S FLDS("PROTOCOL")="MHVSM QBP-Q11 Event Driver"
 S FLDS("BUILDER")="RSPK11~MHV7B9"
 S FLDS("SEGMENT")="PID"
 D LOG^MHVUL2("UPDATE RESPONSE MAP",.FLDS,"M","DEBUG")
 D UPDMAP^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 Q
