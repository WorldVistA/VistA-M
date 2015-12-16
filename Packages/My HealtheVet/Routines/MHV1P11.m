MHV1P11 ;KUM - My HealtheVet Install Utility Routine ; [1/15/13 15:01pm]
 ;;1.0;My HealtheVet;**11**;Aug 23, 2005;Build 61
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
 D LOG^MHVUL2(XPDNM,"PRE-INIT END","S","TRACE")
 Q
 ;
POST ; Post-init routine
 N ERR
 D LOG^MHVUL2(XPDNM,"POST-INIT BEGIN","S","TRACE")
 ;
 D QRYDSS
 D QRYPROC
 D QRYECLS
 D QRYPPRB
 D QRYDIAG
 D QRYFILE
 D RSPQ13
 D RSPQ11
 D RSPP03
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
QRYDSS ; Setup for DSS Units query
 ; Setup MHV REQUEST TYPE 
 ;
 D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - SMDSSUNITS   ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SMDSSUNITS"
 S FIELDS("NUMBER")=44
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMDSSUnitsByProviderAndClinic"
 S FIELDS("EXECUTE")="SPDSS~MHVXWLC"
 S FIELDS("BUILDER")="MHV7B1K"
 S FIELDS("DESCRIPTION",1)="QBP^Q13 query for DSS Units information."
 S FIELDS("DESCRIPTION",2)="Specify Provider DUZ and Associated Clinic."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
QRYPROC ; Setup for ECS Procedures query
 ; Setup MHV REQUEST TYPE 
 ;
 D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - SMECSPROCS   ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SMECSPROCS"
 S FIELDS("NUMBER")=45
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMECSProcedures"
 S FIELDS("EXECUTE")="SPECS~MHVXWLC"
 S FIELDS("BUILDER")="MHV7B1L"
 S FIELDS("DESCRIPTION",1)="QBP^Q13 query for ECS Procedures information."
 S FIELDS("DESCRIPTION",2)="Specify DSS Unit IEN and Location IEN."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
QRYECLS ; Setup for Patient Eligibility and Classificaiton query
 ; Setup MHV REQUEST TYPE 
 ;
 D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - SMPATIENTECLASS   ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SMPATIENTECLASS"
 S FIELDS("NUMBER")=46
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMPatientEClass"
 S FIELDS("EXECUTE")="PECLASS~MHVXWLC"
 S FIELDS("BUILDER")="ZEL~MHV7B1M"
 S FIELDS("DESCRIPTION",1)="QBP^Q11 query for Patient Eligibility and Classificaiton."
 S FIELDS("DESCRIPTION",2)="Specify Patient ICN and DSS Unit IEN."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
QRYPPRB ; Setup for Patient Problems query
 ; Setup MHV REQUEST TYPE 
 ;
 D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - SMPATIENTPROBLEMS   ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SMPATIENTPROBLEMS"
 S FIELDS("NUMBER")=47
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMPatientProblems"
 S FIELDS("EXECUTE")="SMPPRB~MHVXWLC"
 S FIELDS("BUILDER")="DG1~MHV7B1N"
 S FIELDS("DESCRIPTION",1)="QBP^Q11 query for Patient Problems."
 S FIELDS("DESCRIPTION",2)="Specify Patient ICN and DSS Unit IEN."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
QRYDIAG ; Setup for Diagnoses query
 ; Setup MHV REQUEST TYPE 
 ;
 D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - SMDIAGNOSES  ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SMDIAGNOSES"
 S FIELDS("NUMBER")=48
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMDiagnoses"
 S FIELDS("EXECUTE")="SMDIAG~MHVXWLC"
 S FIELDS("BUILDER")="DG1~MHV7B1O"
 S FIELDS("DESCRIPTION",1)="QBP^Q11 query for Diagnoses information."
 S FIELDS("DESCRIPTION",2)="Specify Search String."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ; 
QRYFILE ; Setup for Workload Credit Filer
 ; Setup MHV REQUEST TYPE 
 ;
 D BMES^XPDUTL("    Creating Entry in MHV REQUEST TYPE File - SMFILER  ")
 N FIELDS,ERR
 S ERR=""
 S FIELDS("REQUEST TYPE")="SMFILER"
 S FIELDS("NUMBER")=49
 S FIELDS("BLOCK")=0
 S FIELDS("REALTIME")=1
 S FIELDS("DATATYPE")="SMFiler"
 S FIELDS("EXECUTE")="SMFILE~MHVXWLC"
 S FIELDS("BUILDER")="ERR~MHV7B1P"
 S FIELDS("DESCRIPTION",1)="DFT^P03 query for WLC Filer."
 S FIELDS("DESCRIPTION",2)="Specify String with all data required for WLC Filer."
 S FIELDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FIELDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FIELDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
RSPQ13 ; Set up RESPONSE MAP FOR SMDSSUNITS, SMECSPROCS
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
RSPQ11 ; Set up RESPONSE MAP FOR SMPATIENTECLASS, SMPATIENTPROBLEMS, SMDIAGNOSES
 D BMES^XPDUTL("    Creating Entry in MHV RESPONSE MAP - MHVSM QBP-Q11 Subscriber    ")
 N FLDS,ERR
 K FLDS
 S ERR=""
 S FLDS("SUBSCRIBER")="MHVSM QBP-Q11 Subscriber"
 S FLDS("PROTOCOL")="MHVSM RSP-K11 Event Driver"
 S FLDS("BUILDER")="RSPK11~MHV7B9"
 S FLDS("SEGMENT")="PID"
 D LOG^MHVUL2("UPDATE RESPONSE MAP",.FLDS,"M","DEBUG")
 D UPDMAP^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
 ;
RSPP03 ; Set up RESPONSE MAP FOR SMFILER
 D BMES^XPDUTL("    Creating Entry in MHV RESPONSE MAP - MHVSM DFT-P03 Subscriber    ")
 N FLDS,ERR
 K FLDS
 S ERR=""
 S FLDS("SUBSCRIBER")="MHVSM DFT-P03 Subscriber"
 S FLDS("PROTOCOL")="MHVSM ACK-P03 Event Driver"
 S FLDS("BUILDER")="ACKP03~MHV7B10"
 S FLDS("SEGMENT")="ERR"
 D LOG^MHVUL2("UPDATE RESPONSE MAP",.FLDS,"M","DEBUG")
 D UPDMAP^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
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
CHKLERR(MHVCLNM) ; Print messages in case of Institution or Division missing
 D LOG^MHVUL2("INSTITUTION-DIVISION MISSING",$G(MHVCLNM),"S","ERROR")
 I MHVC=0  D
 .D BMES^XPDUTL("     *** Please check the following Secure Messaging Clinics that the")
 .D MES^XPDUTL("     *** Institution field and Division field have valid values")
 S MHVC=MHVC+1
 D MES^XPDUTL("     "_$G(MHVCLNM))
 Q
SCIEN(SCN) ;Get stop code IEN
 N SCIEN
 I SCN="" Q ""
 S SCIEN=$O(^DIC(40.7,"C",SCN,0))
 I $G(SCIEN)="" Q ""
 Q SCIEN
 ;
