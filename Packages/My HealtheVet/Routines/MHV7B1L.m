MHV7B1L ;KUM - HL7 message builder RTB^K13 DSS Units ; 9/19/14 3:06pm
 ;;1.0;My HealtheVet;**11**;Aug 23, 2005;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
RDF(MSGROOT,CNT,LEN,HL) ;  Build RDF segment for DSS Units data
 ;
 ;  Input:
 ;   MSGROOT - Root of array holding the message
 ;       CNT - Current message line counter
 ;       LEN - Current message length
 ;        HL - HL7 package array variable
 ;
 ;  Output:
 ;           - Populated message array
 ;           - Updated LEN and CNT
 ;
 N RDF
 S RDF(0)="RDF"
 S RDF(1)=4
 S RDF(2,1,1)="Procedure IEN",RDF(2,1,2)="ST",RDF(2,1,3)=30
 S RDF(2,2,1)="Procedure Code",RDF(2,2,2)="ST",RDF(2,2,3)=30
 S RDF(2,3,1)="Procedure Desc",RDF(2,3,2)="ST",RDF(2,3,3)=50
 S RDF(2,4,1)="Synonym",RDF(2,4,2)="ST",RDF(2,4,3)=50
 ;
 S CNT=CNT+1
 S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.RDF,.HL)
 S LEN=LEN+$L(@MSGROOT@(CNT))
 Q
 ;
RDT(MSGROOT,DATAROOT,CNT,LEN,HL) ;  Build RDT segments for DSSUnits data
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
 D LOG^MHVUL2("MHV7B1L","BEGIN RDT","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S APP=@DATAROOT@(I)
 . S RDT(0)="RDT"
 . S RDT(1)=$P(APP,"^")                         ;Procedure IEN
 . S RDT(2)=$$ESCAPE^MHV7U($P(APP,"^",3),.HL)   ;Procedure Code 
 . S RDT(3)=$$ESCAPE^MHV7U($P(APP,"^",2),.HL)   ;Procedure Desc
 . S RDT(4)=$$ESCAPE^MHV7U($P(APP,"^",4),.HL)   ;Synonym
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.RDT,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B1L","END RDT","S","TRACE")
 Q
 ;
