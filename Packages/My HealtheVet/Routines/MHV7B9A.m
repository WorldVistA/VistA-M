MHV7B9A ;WAS/DLF/KUM - HL7 message builder secure messaging ; 9/25/08 4:08pm
 ;;1.0;My HealtheVet;**6,10,29**;July 10, 2017;Build 73
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
PTREL(MSGROOT,DATAROOT,CNT,LEN,HL)      ;Build ORG, STF, and AIP segments
 D ORG(MSGROOT,DATAROOT,.CNT,.LEN,.HL)
 S DATAROOT=$P(DATAROOT,",",1,3)
 S DATAROOT=$TR(DATAROOT,")","")_","_"""PROVIDERS"""_")"
 D STF(MSGROOT,DATAROOT,.CNT,.LEN,.HL)
 D AIP(MSGROOT,DATAROOT,.CNT,.LEN,.HL)
 Q
PID(MSGROOT,DATAROOT,CNT,LEN,HL) ;Build PID segments for user data
 ;
 ; Walks data in DATAROOT to populate MSGROOT with PID segments
 ; sequentially numbered starting at CNT
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 N I,USR,PID,NMARR,PNAME
 D LOG^MHVUL2("MHV7B9A","BEGIN PID","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S USR=@DATAROOT@(I)
 . S PID(0)="PID"
 . ; IEN+ICN+SSN
 . S PID(3,1,1)=$P(USR,"^")
 . S PID(3,2,1)=$P(USR,"^",4)
 . S PID(3,3,1)=$P(USR,"^",5)
 . S PNAME=$P(USR,"^",3)
 . D FMTNAME^MHV7BU(PNAME,.NMARR,.HL,"XPN")
 . S PID(5,1,1)=NMARR(1)
 . S PID(5,1,2)=NMARR(2)
 . S PID(5,1,3)=NMARR(3)  ;Name in HL7 Format
 . D LOG^MHVUL2("MHV7B9A",PNAME,"S","TRACE")
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.PID,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B9A","END PID","S","TRACE")
 Q
STF(MSGROOT,DATAROOT,CNT,LEN,HL) ;Build STF segments for provider data
 ;
 ; Walks data in DATAROOT to populate MSGROOT with STF segments
 ; sequentially numbered starting at CNT
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 N I,USR,STF,NMARR,PNAME
 N J,DIV,DIVS
 D LOG^MHVUL2("MHV7B9A","BEGIN STF","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S USR=@DATAROOT@(I)
 . S STF(0)="STF"
 . S STF(2)=$P(USR,"^",1)            ;IEN
 . S PNAME=$P(USR,"^",2)             ;Provider name
 . ;JAZZ#409966-Fix Names with Space in SM queries;and more User Fields
 . ;D FMTNAME^MHV7BU(PNAME,.NMARR,.HL,"XPN")- CHANGE THE CALL TO the HL7 formatting API
 . D FMTNAME3^MHV7BU(STF(2),200,.NMARR,.HL,"XPN")
 . ;-----------------------------------------------------------------------------------
 . ;USR=USRIEN_U_USRNAME_U_PRV_U_PRVCLS_U_PROVSPEC_U_REQSIG_U_PPHONE_U_SSECTION_U_TTITLE
 . ;
 . ;     (1)       (2)     (3)    (4)       (5)       (6)       (7)        (8)      (9)
 . ;_U_NETWKID   PERSCLS_U_PCEFDT_U_PCEXDT_U_PROVDIVS*
 . ;     (10)     (11)      (12)     (13)       (14) . ; * Multiples;
 . ;-----------------------------------------------------------------------------------
 . S STF(3,1,1)=$G(NMARR(1)) ;Last (Family)Name in HL7 Format
 . S STF(3,1,2)=$G(NMARR(2)) ;Given(First)Name in HL7 Format
 . S STF(3,1,3)=$G(NMARR(3)) ;Middle Name in HL7 Format
 . S STF(3,1,4)=$G(NMARR(4)) ;Name Suffix in HL7 Format - ;JAZZ#409966
 . S STF(3,1,5)=$G(NMARR(5)) ;Name Prefix in HL7 Format - ;JAZZ#409966
 . S STF(3,1,6)=$G(NMARR(6)) ;Degree in HL7 Format - ;JAZZ#409966 
 . S STF(3,1,9,4)=$P(USR,"^",10) ;NETWKID - StaffName.namecontext.alternateidentifie;JAZZ#409966
 . S STF(4,1)=$P(USR,"^",3) ;Staff type 1 -IF PROVIDER KEY exists='PROVIDER'-JAZZ#409966
 . S STF(4,3)=$P(USR,"^",6) ;Staff type 3 -REQSIG-JAZZ#409966
 . S STF(7)=+$$ACTIVE^XUSER($P(USR,"^",1)) ;Active/Inactive Flag-(lb)-JAZZ#409966
 . ;S STF(8)=$P(USR,"^",8) ;Section/Department
 . S STF(8,1)=$P(USR,"^",8) ;Section/Department-use 1st piece -JAZZ#409966
 . S STF(8,2)=$P(USR,"^",5) ;Staff type 2-PROVSPEC -JAZZ#409966
 . S STF(8,5)=$P(USR,"^",11) ;JobClass- PERSCLS-Current active- JAZZ#409966
 . S DIV="",DIVS=$P(USR,"^",14) ;DIVISIONS -JAZZ#409966 
 . I $G(DIVS)'="" F J=1:1 Q:$P(DIVS,"_",J)=""  D 
 . . S STF(9,J,2)=$P($P(DIVS,"_",J),"~",1) ;HospitalService - DIVISONS
 . . S STF(9,J,5)=$P($P(DIVS,"_",J),"~",2) ;HospitalService - DIVISONS-Default=yes/no/null 
 . S STF(10)=$P(USR,"^",7) ;Office Phone
 . S STF(12)="",STF(13)=""
 . ;InstitutionActivationDate -PCEFDT
 . I +($P(USR,"^",12))>0 S STF(12)=$$FMTHL7^MHV7BU($P(USR,"^",12))
 . ;InstitutionInactivationDate -PCEXDT
 . I +($P(USR,"^",13))>0 S STF(13)=$$FMTHL7^MHV7BU($P(USR,"^",13))
 . S STF(18)=$P(USR,"^",9) ;Job Title -JAZZ#409966
 . S STF(20,2)=$P(USR,"^",4) ;EmploymentStatusCode -PRVCLS-JAZZ#409966
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.STF,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B9A","END STF","S","TRACE")
 Q
AIP(MSGROOT,DATAROOT,CNT,LEN,HL)  ;Build AIP segments for team
 ;
 ; Walks data in DATAROOT to populate MSGROOT with AIP segments
 ; sequentially numbered starting at CNT
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 N I,USR,AIP
 S DATAROOT=$P(DATAROOT,",",1,3)
 S DATAROOT=$TR(DATAROOT,")","")_","_"""TEAMS"""_")"
 D LOG^MHVUL2("MHV7B9A","BEGIN AIP","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S USR=@DATAROOT@(I)
 . S AIP(0)="AIP"
 . S AIP(3)=$P(USR,"^",1)                                ;IEN
 . S AIP(5)=$$ESCAPE^MHV7U($P(USR,"^",2),.HL)            ;TEAM NAME
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.AIP,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B9A","END AIP","S","TRACE")
 Q
ORG(MSGROOT,DATAROOT,CNT,LEN,HL) ;Build ORG segments for clinics
 ;
 ; Walks data in DATAROOT to populate MSGROOT with ORG segments
 ; sequentially numbered starting at CNT
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 N I,USR,ORG
 D LOG^MHVUL2("MHV7B9A","BEGIN ORG","S","TRACE")
 S DATAROOT=$P(DATAROOT,",",1,3)
 S DATAROOT=$TR(DATAROOT,")","")_","_"""CLINICS"""_")"
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S USR=@DATAROOT@(I)
 . S ORG(0)="ORG"
 . S ORG(2,1,1)=$P(USR,"^",1)
 . S ORG(2,1,2)=$$ESCAPE^MHV7U($P(USR,"^",2),.HL)
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.ORG,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B9A","END ORG","S","TRACE")
 Q
SMORG(MSGROOT,DATAROOT,CNT,LEN,HL) ;Build ORG segments for clinics
 ;
 ; Walks data in DATAROOT to populate MSGROOT with ORG segments
 ; sequentially numbered starting at CNT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 N I,USR,ORG
 D LOG^MHVUL2("MHV7B9A","BEGIN ORG","S","TRACE")
 S DATAROOT=$P(DATAROOT,",",1,3)
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S USR=@DATAROOT@(I)
 . S ORG(0)="ORG"
 . S ORG(2,1,1)=$P(USR,"^",1)
 . S ORG(2,1,2)=$$ESCAPE^MHV7U($P(USR,"^",2),.HL)
 . I $P($G(USR),"^",3)'="" S ORG(3,1,1)=$$ESCAPE^MHV7U($P(USR,"^",3),.HL)
 . I $P($G(USR),"^",4)'="" S ORG(3,1,2)=$$ESCAPE^MHV7U($P(USR,"^",4),.HL)
 . I $P($G(USR),"^",5)'="" S ORG(3,1,5)=$$ESCAPE^MHV7U($P(USR,"^",5),.HL)
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.ORG,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B9A","END ORG","S","TRACE")
 Q
PRA(MSGROOT,DATAROOT,CNT,LEN,HL)    ;Build PRA segments for providers
 ;
 ; Walks data in DATAROOT to populate MSGROOT with PRA segments
 ; sequentially numbered starting at CNT
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;  DATAROOT - Root of array to hold extract data
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 N I,USR,PRA
 D LOG^MHVUL2("MHV7B9A","BEGIN PRA","S","TRACE")
 S DATAROOT=$P(DATAROOT,",",1,3)
 S DATAROOT=$TR(DATAROOT,")","")_","_"""PROVIDERS"""_")"
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S USR=@DATAROOT@(I)
 . S PRA(0)="PRA"
 . S PRA(2,1,1)=$P(USR,"^",1)   ;IEN
 . S PRA(2,1,2)=$P(USR,"^",2)   ;NAME
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.PRA,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B9A","END PRA","S","TRACE")
 Q
