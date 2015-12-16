MHV7B1P ;KUM - HL7 message builder ACK^P03 WLC Filer ; 1/11/15 3:06pm
 ;;1.0;My HealtheVet;**11**;Aug 23, 2005;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
ERR(MSGROOT,DATAROOT,CNT,LEN,HL) ;  Build ERR segment for Workload Credit Filer Results data
 ;
 ; Walks data in DATAROOT to populate MSGROOT with RDT segments
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
 ; POPULATE SEQUENCE NUMBER
 N I,APP,ERR
 D LOG^MHVUL2("MHV7B1P","BEGIN ERR","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S APP=@DATAROOT@(I)
 . S ERR(0)="ERR"
 . S ERR(4,1,4)=$$ESCAPE^MHV7U($P(APP,"^",5),.HL) ;Visit IEN
 . S ERR(4,1,1)=$$ESCAPE^MHV7U($P(APP,"^",1),.HL) ;Success/Failure Flag 
 . S ERR(4,1,2)=$$ESCAPE^MHV7U($P(APP,"^",2),.HL) ;Success/Failure Message
 . S ERR(4,1,3)=$$ESCAPE^MHV7U($P(APP,"^",4),.HL) ;Workload IEN
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.ERR,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B1P","END ERR","S","TRACE")
 Q
 ;
