MHV7B1 ;WAS/GPM - HL7 message builder RTB^K13 ; [1/7/08 10:45pm]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
RTBK13(MSGROOT,QRY,ERR,DATAROOT,LEN,HL) ; Build query response
 ;
 ;  Populates the array pointed to by MSGROOT with an RTB^K13 query
 ; response message by calling the appropriate segment builders based
 ; on the type of response ACK/Data or NAK.  Extracted data pointed to
 ; by DATAROOT, errors, hit counts, and query information are used to
 ; build the segments.
 ; An error number in ERR^4 indicates a NAK is needed.
 ; DATAROOT being null indicates a dataless ACK (testing purposes).
 ;  Multiple types of RDF/RDT are supported based on the type of
 ; data in the response.  The appropriate domain specific builder is
 ; called based on QRY("BUILDER").  Note that this is a different
 ; routine than the XMT("BUILDER").
 ;
 ;  Input:
 ;     MSGROOT - Global root of message
 ;         QRY - Query parameters
 ;             QRY("BUILDER") - Domain specific builder routine
 ;             QRY("MID") - original message control ID
 ;         ERR - Caret delimited error string
 ;               segment^sequence^field^code^ACK type^error text
 ;    DATAROOT - Global root of data array
 ;          HL - HL7 package array variable
 ;
 ;  Output: RTB^K13 message in MSGROOT
 ;         LEN - Length of formatted message
 ;
 N CNT,RDT,HIT,EXTIME
 D LOG^MHVUL2("RTB-K13 BUILDER","BEGIN","S","TRACE")
 ;
 S HIT=0,EXTIME=""
 I DATAROOT'="" D
 . S HIT=+$P($G(@DATAROOT),"^",1)
 . S EXTIME=$P($G(@DATAROOT),"^",2)
 . Q
 S HIT=HIT_"^"_HIT_"^0"
 ;
 K @MSGROOT
 S CNT=1,@MSGROOT@(CNT)=$$MSA^MHV7BUS($G(QRY("MID")),ERR,.HL),LEN=$L(@MSGROOT@(CNT))
 I $P(ERR,"^",4) S CNT=CNT+1,HIT="0^0^0",@MSGROOT@(CNT)=$$ERR^MHV7BUS(ERR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QAK^MHV7BUS(.QRY,ERR,HIT,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QPD^MHV7BUS(.QRY,EXTIME,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 I '$P(ERR,"^",4) D
 . D @("RDF^"_QRY("BUILDER")_"(MSGROOT,.CNT,.LEN,.HL)")
 . Q:DATAROOT=""
 . Q:HIT<1
 . D @("RDT^"_QRY("BUILDER")_"(MSGROOT,DATAROOT,.CNT,.LEN,.HL)")
 . Q
 ;
 D LOG^MHVUL2("RTB-K13 BUILDER","END","S","TRACE")
 Q
 ;
