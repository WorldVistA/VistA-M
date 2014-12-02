MHV7B1C ;KUM - HL7 message builder RTB^K13 Titles ; 1/26/13 3:06pm
 ;;1.0;My HealtheVet;**10**;Aug 23, 2005;Build 50
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
RDF(MSGROOT,CNT,LEN,HL) ;  Build RDF segment for Titles data
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
 S RDF(2,1,1)="IEN",RDF(2,1,2)="NM",RDF(2,1,3)=30
 S RDF(2,2,1)="SEQNO",RDF(2,2,2)="NM",RDF(2,2,3)=6
 S RDF(2,3,1)="Title Name",RDF(2,3,2)="ST",RDF(2,3,3)=60
 S RDF(2,4,1)="Print Title Name",RDF(2,4,2)="ST",RDF(2,4,3)=60
 ;
 S CNT=CNT+1
 S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.RDF,.HL)
 S LEN=LEN+$L(@MSGROOT@(CNT))
 Q
 ;
RDT(MSGROOT,DATAROOT,CNT,LEN,HL) ;  Build RDT segments for Titles data
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
 D LOG^MHVUL2("MHV7B1C","BEGIN RDT","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S APP=@DATAROOT@(I)
 . S RDT(0)="RDT"
 . S RDT(1)=$P(APP,"^")                         ;IEN
 . S RDT(2)=$$ESCAPE^MHV7U($P(APP,"^",2),.HL)   ;Title Sequence 
 . S RDT(3)=$$ESCAPE^MHV7U($P(APP,"^",3),.HL)   ;Title Name
 . S RDT(4)=$$ESCAPE^MHV7U($P(APP,"^",4),.HL)   ;Print Title Name
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.RDT,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B1C","END RDT","S","TRACE")
 Q
 ;
