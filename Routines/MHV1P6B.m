MHV1P6B ;WAS/DLF - My HealtheVet Install Utility Routine ; 9/25/08 4:07pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;
 ;
 Q
 ;
QRYSETUP  ;
 D USERS,PCPROV,PTCL,PTTM,PTPROV,TEAM,CLINICS,PTREL
 Q
USERS ; Set up user query
 N FLDS,ERR
 S ERR=""
 S FLDS("REQUEST TYPE")="USERS"
 S FLDS("NUMBER")=26
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("BUILDER")="STF~MHV7B9A"
 S FLDS("DATATYPE")="SMUsers"
 S FLDS("EXECUTE")="USERS~MHVXUSR"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for user information."
 S FLDS("DESCRIPTION",2)="Specify user by Name or leave blank for all"
 S FLDS("DESCRIPTION",3)="users.  Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable the Users Query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","USERS","S","TRACE")
 D TOGGLE^MHVU2("USERS","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 Q
PCPROV ; Set up the PCMM providers query
 N FLDS,ERR
 S ERR=""
 K FLDS
 S FLDS("REQUEST TYPE")="PCMM PROVIDERS"
 S FLDS("NUMBER")=27
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("BUILDER")="STF~MHV7B9A"
 S FLDS("DATATYPE")="SMPCMMProviders"
 S FLDS("EXECUTE")="CMMPRV~MHVXPRV"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for provider information."
 S FLDS("DESCRIPTION",2)="Specify provider by Name or leave blank for"
 S FLDS("DESCRIPTION",3)="all providers."
 S FLDS("DESCRIPTION",4)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable the PCMM Providers query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","PCMM PROVIDERS","S","TRACE")
 D TOGGLE^MHVU2("PCMM PROVIDERS","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 Q
PTCL ; Set up patients for Clinic
 N FLDS,ERR
 S ERR=""
 K FLDS
 S FLDS("REQUEST TYPE")="PCMM PATIENTS FOR CLINIC"
 S FLDS("NUMBER")=28
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("BUILDER")="PID~MHV7B9A"
 S FLDS("DATATYPE")="SMPCMMPatientsForClinic"
 S FLDS("EXECUTE")="PATCL~MHVXPAT"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for user information."
 S FLDS("DESCRIPTION",2)="Specify Clinic IEN"
 S FLDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable patients for clinic query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","PCMM PATIENTS FOR CLINIC","S","TRACE")
 D TOGGLE^MHVU2("PCMM PATIENTS FOR CLINIC","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
PTTM ; Set up Patients for team query
 N FLDS,ERR
 S ERR=""
 K FLDS
 S FLDS("REQUEST TYPE")="PCMM PATIENTS FOR TEAM"
 S FLDS("NUMBER")=29
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("BUILDER")="PID~MHV7B9A"
 S FLDS("DATATYPE")="SMPCMMPatientsForTeam"
 S FLDS("EXECUTE")="PATTM~MHVXPAT"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for user information."
 S FLDS("DESCRIPTION",2)="Specify team IEN.  Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable Patients for team query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","PCMM PATIENTS FOR TEAM","S","TRACE")
 D TOGGLE^MHVU2("PCMM PATIENTS FOR TEAM","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 Q
PTPROV ; Set up patients for provider query
 N FLDS,ERR
 S ERR=""
 K FLDS
 S FLDS("REQUEST TYPE")="PCMM PATIENTS FOR PROVIDER"
 S FLDS("NUMBER")=30
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("BUILDER")="PID~MHV7B9A"
 S FLDS("DATATYPE")="SMPCMMPatientsForProvider"
 S FLDS("EXECUTE")="PTPCMP~MHVXPAT"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for user information."
 S FLDS("DESCRIPTION",2)="Specify provider IEN"
 S FLDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable Patients for Provider Query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","PCMM PATIENTS FOR PROVIDER","S","TRACE")
 D TOGGLE^MHVU2("PCMM PATIENTS FOR PROVIDER","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 Q
TEAM ; Set up team query
 ;
 N FLDS,ERR
 S ERR=""
 K FLDS
 S FLDS("REQUEST TYPE")="TEAM"
 S FLDS("NUMBER")=31
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("DATATYPE")="SMTeam"
 S FLDS("BUILDER")="AIP~MHV7B9A"
 S FLDS("EXECUTE")="TEAM~MHVXTM"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for team information."
 S FLDS("DESCRIPTION",2)="Specify team name or leave blank for all."
 S FLDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable Team query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","TEAM","S","TRACE")
 D TOGGLE^MHVU2("TEAM","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
CLINICS ; Set up clinics query
 N FLDS,ERR
 S ERR=""
 K FLDS
 S FLDS("REQUEST TYPE")="CLINICS"
 S FLDS("NUMBER")=32
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("BUILDER")="ORG~MHV7B9A"
 S FLDS("DATATYPE")="SMClinics"
 S FLDS("EXECUTE")="CLIN~MHVXCLN"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for clinic information."
 S FLDS("DESCRIPTION",2)="Specify clinic name of leave blank for all."
 S FLDS("DESCRIPTION",3)="Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable CLinics Query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","CLINICS","S","TRACE")
 D TOGGLE^MHVU2("CLINICS","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
PTREL ; Set up patient relationships query
 N FLDS,ERR
 S ERR=""
 K FLDS
 S FLDS("REQUEST TYPE")="PATIENT RELATIONSHIPS"
 S FLDS("NUMBER")=33
 S FLDS("BLOCK")=1
 S FLDS("REALTIME")=1
 S FLDS("BUILDER")="PTREL~MHV7B9A"
 S FLDS("DATATYPE")="SMPatientRelationships"
 S FLDS("EXECUTE")="PTREL~MHVXPAT"
 S FLDS("DESCRIPTION",1)="QBP^Q13 query for patient information."
 S FLDS("DESCRIPTION",2)="Specify patient IEN.  Returns Provider"
 S FLDS("DESCRIPTION",3)="Team and Clinic information for a date"
 S FLDS("DESCRIPTION",4)="range.  Developed for Secure Messaging."
 D LOG^MHVUL2("UPDATE REQUEST TYPE",.FLDS,"M","DEBUG")
 D UPDREQ^MHVU2(.FLDS,1,.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("UPDATE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 ;
 ; Enable Patient Relationships Query
 ;
 S ERR=""
 D LOG^MHVUL2("ENABLE","PATIENT RELATIONSHIPS","S","TRACE")
 D TOGGLE^MHVU2("PATIENT RELATIONSHIPS","ENABLE",.ERR)
 I ERR'="" D
 . D LOG^MHVUL2("ENABLE FAILED",ERR,"S","ERROR")
 . D BMES^XPDUTL("     *** An Error occurred during installation.")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 Q
