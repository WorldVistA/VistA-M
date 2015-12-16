MHV7B1K ;KUM - HL7 message builder RTB^K13 DSS Units ; 9/9/14 3:06pm
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
 S RDF(1)=6
 S RDF(2,1,1)="Location IEN",RDF(2,1,2)="NM",RDF(2,1,3)=10
 S RDF(2,2,1)="Location Name",RDF(2,2,2)="NM",RDF(2,2,3)=20
 S RDF(2,3,1)="DSSUNIT IEN",RDF(2,3,2)="NM",RDF(2,3,3)=10
 S RDF(2,4,1)="DSSUNIT Name",RDF(2,4,2)="ST",RDF(2,4,3)=50
 S RDF(2,5,1)="Inactive Flag",RDF(2,5,2)="ST",RDF(2,5,3)=1
 S RDF(2,6,1)="Send To PCE Flag",RDF(2,6,2)="ST",RDF(2,6,3)=1
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
 D LOG^MHVUL2("MHV7B1K","BEGIN RDT","S","TRACE")
 F I=1:1 Q:'$D(@DATAROOT@(I))  D
 . S APP=@DATAROOT@(I)
 . S RDT(0)="RDT"
 . S RDT(1)=$P(APP,"^")                         ;Location IEN
 . S RDT(2)=$$ESCAPE^MHV7U($P(APP,"^",2),.HL)   ;Location Name 
 . S RDT(3)=$$ESCAPE^MHV7U($P(APP,"^",3),.HL)   ;DSS Unit IEN
 . S RDT(4)=$$ESCAPE^MHV7U($P(APP,"^",4),.HL)   ;DSS Unit Name
 . S RDT(5)=$$ESCAPE^MHV7U($P(APP,"^",5),.HL)   ;Inactive Flag
 . S RDT(6)=$$ESCAPE^MHV7U($P(APP,"^",6),.HL)   ;Send to PCE Flag 
 . S CNT=CNT+1
 . S @MSGROOT@(CNT)=$$BLDSEG^MHV7U(.RDT,.HL)
 . S LEN=LEN+$L(@MSGROOT@(CNT))
 . Q
 D LOG^MHVUL2("MHV7B1K","END RDT","S","TRACE")
 Q
 ;
