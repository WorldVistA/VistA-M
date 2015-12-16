MHV7B1O ;KUM - HL7 message builder RSP^K11 Diagnoses Search Results List ; 10/30/14 3:06pm
 ;;1.0;My HealtheVet;**11**;Aug 23, 2005;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
DG1(MSGROOT,DATAROOT,CNT,LEN,HL) ;  Build DG1 segments for Diagnosis Search Results data
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
 N I,APP,DG1
 D LOG^MHVUL2("MHV7B1O","BEGIN DG1","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . M ^KUMDG4=@DATAROOT
 . I $P(@DATAROOT@(I),"^",2)=0 Q
 . S APP=@DATAROOT@(I)
 . S DG1(0)="DG1"
 . S DG1(1,1)=I
 . S DG1(3,1,4)=$$ESCAPE^MHV7U($P(APP,"^"),.HL)   ;Diagnosis Code IEN
 . S DG1(3,1,1)=$$ESCAPE^MHV7U($P(APP,"^",2),.HL) ;Diagnosis Code 
 . S DG1(3,1,2)=$$ESCAPE^MHV7U($P(APP,"^",3),.HL) ;Diagnosis Code Description
 . S DG1(3,1,3)=$$ESCAPE^MHV7U("I9",.HL)          ;ICD-9 Coding System
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.DG1,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B1O","END DG1","S","TRACE")
 Q
 ;
