MHV7B2 ;WAS/GPM - HL7 message builder ORP^O10 ; [12/24/07 5:43pm]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
ORPO10(MSGROOT,REQ,ERR,DATAROOT,LEN,HL) ; Build refill request response
 ;
 ;  Populates the array pointed to by MSGROOT with an ORP^O10 order
 ; response message by calling the appropriate segment builders based
 ; on the type of response ACK or NAK.  Extracted data pointed to
 ; by DATAROOT, errors, and request parameters are used to build the
 ; segments.  An error number in ERR^4 indicates a NAK is needed.
 ;
 ;  Integration Agreements:
 ;         3065 : $$HLNAME^XLFNAME
 ;        10112 : $$SITE^VASITE
 ;
 ;  Input:
 ;     MSGROOT - Global root of message
 ;         REQ - Query parameters
 ;             REQ("TYPE") - Request type number
 ;             REQ("MID") - original message control ID
 ;         ERR - Caret delimited error string
 ;               segment^sequence^field^code^ACK type^error text
 ;    DATAROOT - Global root of data array
 ;          HL - HL7 package array variable
 ;
 ;  Output: ORP^O10 message in MSGROOT
 ;         LEN - Length of formatted message
 ;
 N CNT,HIT,I
 D LOG^MHVUL2("ORP-O10 BUILDER","BEGIN","S","TRACE")
 ;
 K @MSGROOT
 S CNT=1,@MSGROOT@(CNT)=$$MSA^MHV7BUS($G(REQ("MID")),ERR,.HL),LEN=$L(@MSGROOT@(CNT))
 I $P(ERR,"^",4) S CNT=CNT+1,@MSGROOT@(CNT)=$$ERR^MHV7BUS(ERR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$PID^MHV7BUS(.REQ,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 ;
 I '$P(ERR,"^",4),DATAROOT'="" D
 . F I=1:1 Q:'$D(@DATAROOT@(I))  D
 .. S CNT=CNT+1,@MSGROOT@(CNT)=$$ORC(@DATAROOT@(I),.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .. S CNT=CNT+1,@MSGROOT@(CNT)=$$RXE(@DATAROOT@(I),.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .. Q
 . Q
 ;
 D LOG^MHVUL2("ORP-O10 BUILDER","END","S","TRACE")
 Q
 ;
ORC(DATA,HL) ;build ORC segment
 N ORC,STATUS,CONTROL
 S STATUS=$P(DATA,"^",2)
 S CONTROL=$S(STATUS=1:"OK",1:"UA")
 S ORC(0)="ORC"
 S ORC(1)=CONTROL              ;order control
 S ORC(2)=$P(DATA,"^",3)       ;placer order number
 S ORC(3)=$P(DATA,"^",3)       ;filler order number
 Q $$BLDSEG^MHV7U(.ORC,.HL)
 ;
RXE(DATA,HL) ;build RXE segment
 N RXE,STATUS,CONTROL
 S STATUS=$P(DATA,"^",2)
 S CONTROL=$S(STATUS=1:"OK",1:"UA")
 S RXE(0)="RXE"
 S RXE(1,1,1,1)=1              ;order quantity
 S RXE(1,1,4,1)=$P(DATA,"^",4) ;order start time
 S RXE(2,1,1)=CONTROL          ;give code identifier
 S RXE(2,1,2)=STATUS           ;give code text
 S RXE(2,1,3)="HL70119"        ;give code system
 S RXE(3)=1                    ;give amount
 S RXE(5)="1 refill unit"      ;give units
 ;S RXE(7)=""                  ;division number
 S RXE(15)=$P(DATA,"^",1)      ;prescription number
 Q $$BLDSEG^MHV7U(.RXE,.HL)
 ;
