MHV7B1M ;KUM - HL7 message builder ACK^P03 Patient Eligibility and Classificaiton ; 10/30/14 3:06pm
 ;;1.0;My HealtheVet;**11**;Aug 23, 2005;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
ZEL(MSGROOT,DATAROOT,CNT,LEN,HL) ;  Build ZEL segments for Patient Eligibility and Classificaiton data
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
 N I,APP,RDT
 D LOG^MHVUL2("MHV7B1M","BEGIN ZEL","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S APP=@DATAROOT@(I)
 . S ZEL(0)="ZEL"
 . I I=1  D
 . . S ZEL(9)=$$ESCAPE^MHV7U($P(APP,"^",1),.HL)   ;Patient Status
 . . S ZEL(18)=$$ESCAPE^MHV7U($P(APP,"^",2),.HL)  ;Agent Orange
 . . S ZEL(19)=$$ESCAPE^MHV7U($P(APP,"^",3),.HL)  ;Ionizing Radiation
 . . S ZEL(31)=$$ESCAPE^MHV7U($P(APP,"^",4),.HL)  ;SC Condition 
 . . S ZEL(20)=$$ESCAPE^MHV7U($P(APP,"^",5),.HL)  ;Environmental Contamination
 . . S ZEL(23)=$$ESCAPE^MHV7U($P(APP,"^",6),.HL)  ;Military Sexual Truama
 . . S ZEL(42)=$$ESCAPE^MHV7U($P(APP,"^",7),.HL)  ;Head/Neck Cancer
 . . S ZEL(37)=$$ESCAPE^MHV7U($P(APP,"^",8),.HL)  ;Combat Veteran
 . . S ZEL(44)=$$ESCAPE^MHV7U($P($P(APP,"^",9),"~",1),.HL)  ;Project 112/SHAD
 . I I>1  D
 . . S ZEL(1)=$$ESCAPE^MHV7U($P(APP,"^",1),.HL)   ;Primary/Secondary Flag  
 . . S ZEL(3)=$$ESCAPE^MHV7U($P(APP,"^",2),.HL)   ;Eligibility Code IEN
 . . S ZEL(2)=$$ESCAPE^MHV7U($P(APP,"^",3),.HL)   ;Eligibility Description
 . . S CNT=CNT+1
 . . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.ZEL,.HL)
 . . S LEN=LEN+$L(@MSGROOT@(CNT))
 . . K ZEL
 . Q
 D LOG^MHVUL2("MHV7B1M","END ZEL","S","TRACE")
 Q
 ;
