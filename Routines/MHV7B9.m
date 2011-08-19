MHV7B9 ;WAS/DLF - HL7 message builder SECURE MESSAGING RSP^K11 ; 9/25/08 4:08pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
RSPK11(MSGROOT,QRY,ERR,DATAROOT,LEN,HL) ; Build query response
 ;
 ;  Populates the array pointed to by MSGROOT with an RSP^K11 query
 ; response message by calling the appropriate segment builders based
 ; on the type of response ACK/Data or NAK.  Extracted data pointed to
 ; by DATAROOT, errors, hit counts, and query information are used to
 ; build the segments.
 ; An error number in ERR^4 indicates a NAK is needed.
 ; DATAROOT being null indicates a dataless ACK (testing purposes).
 ;
 ;  Input:
 ;     MSGROOT - Global root of message
 ;         QRY - Query parameters
 ;             QRY("MID") - original message control ID
 ;         ERR - Caret delimited error string
 ;               segment^sequence^field^code^ACK type^error text
 ;    DATAROOT - Global root of data array
 ;          HL - HL7 package array variable
 ;
 ;  Output: RSP^K11 message in MSGROOT
 ;         LEN - Length of formatted message
 ;
 N CNT,HIT,EXTIME,MTYPE
 D LOG^MHVUL2("SM RSP-K11 BUILDER","BEGIN","S","TRACE")
 ;
 S HIT=0,EXTIME=""
 I DATAROOT'="" D
 . S HIT=+$P($G(@DATAROOT),"^",1)
 . S EXTIME=$P($G(@DATAROOT),"^",2)
 . Q
 S HIT=HIT_"^"_HIT_"^0"
 ;
 K @MSGROOT
 S CNT=1,@MSGROOT@(CNT)=$$MSA^MHV7BUS($G(QRY("MID")),ERR,.HL)
 S LEN=$L(@MSGROOT@(CNT))
 I $P(ERR,"^",4)  D
 .S CNT=CNT+1,HIT="0^0^0",@MSGROOT@(CNT)=$$ERR^MHV7BUS(ERR,.HL)
 .S LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QAK^MHV7BUS(.QRY,ERR,HIT,.HL)
 S LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QPD^MHV7BUS(.QRY,EXTIME,.HL)
 S LEN=LEN+$L(@MSGROOT@(CNT))
 ;
 I '$P(ERR,"^",4)  D
 .D @(QRY("BUILDER")_"(MSGROOT,DATAROOT,.CNT,.LEN,.HL)")
 ;
 D LOG^MHVUL2("SM RSP-K11 BUILDER","END","S","TRACE")
 Q
 ;
