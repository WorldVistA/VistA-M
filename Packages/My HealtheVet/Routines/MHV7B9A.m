MHV7B9A ;WAS/DLF - HL7 message builder secure messaging ; 9/25/08 4:08pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
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
 D LOG^MHVUL2("MHV7B9A","BEGIN STF","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S USR=@DATAROOT@(I)
 . S STF(0)="STF"
 . S STF(2)=$P(USR,"^",1)                       ;IEN
 . S PNAME=$P(USR,"^",2)                       ;Provider name
 . D FMTNAME^MHV7BU(PNAME,.NMARR,.HL,"XPN")
 . S STF(3,1,1)=NMARR(1)
 . S STF(3,1,2)=NMARR(2)
 . S STF(3,1,3)=NMARR(3)  ;Name in HL7 Format
 . S STF(18)=$P(USR,"^",3)                      ;Staff type
 . S STF(8)=$P(USR,"^",8)                       ;Section/Department
 . S STF(10)=$P(USR,"^",7)                      ;Office Phone
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
