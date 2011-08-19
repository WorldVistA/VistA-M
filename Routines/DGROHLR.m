DGROHLR ;DJH/AMA - ROM HL7 RECEIVE DRIVERS ; 7/9/09 4:16pm
 ;;5.3;Registration;**533,572,754**;Aug 13, 1993;Build 46
 ;
RCV ;Receive all message types and route to message specific receiver
 ;
 ;This procedure is the main driver entry point for receiving all
 ;message types (ACK, QRY and ORF) for Register Once Messaging.
 ;
 ;All procedures and functions assume that all VistA HL7 environment
 ;variables are properly initialized and will produce a fatal error if
 ;they are missing.
 ;
 ;The received message is copied to a temporary work global for
 ;processing.  The message type is determined from the MSH segment and
 ;a receive processing procedure specific to the message type is called.
 ;(Ex. ORF~R01 message calls procedure: RCVORF).  The specific receive
 ;processing procedure calls a message specific parse procedure to
 ;validate the message data and return data arrays for storage.  If no
 ;parse errors are reported during validation, then the data arrays are
 ;stored by the receive processing procedure.  Control, along with any
 ;parse validation errors, is then passed to the message specific send
 ;processing procedures to build and transmit the acknowledgment and
 ;query results messages.
 ;
 ;  The message specific procedures are as follows:
 ;
 ;  Message   Receive Procedure   Parse Procedure    Send Procedure
 ;  -------   -----------------   ----------------    --------------
 ;                                                   SNDACK^DGROHLS
 ;  ACK~R01   RCVACK^DGROHLR      PARSACK^DGROHLU4   N/A
 ;  QRY~R02   RCVQRY^DGROHLR      PARSQRY^DGROHLQ3   SNDORF^DGROHLS
 ;  ORF~R01   RCVORF^DGROHLR      PARSORF^DGROHLQ3   N/A
 ;
 N DGCNT,DGMSGTYP,DGSEG,DGSEGCNT,DGWRK
 ;
 S DGWRK=$NA(^TMP("DGROHL7",$J))
 K @DGWRK
 ;
 ;load work global with segments
 F DGSEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S DGCNT=0
 . S @DGWRK@(DGSEGCNT,DGCNT)=HLNODE
 . F  S DGCNT=$O(HLNODE(DGCNT)) Q:'DGCNT  D
 . . S @DGWRK@(DGSEGCNT,DGCNT)=HLNODE(DGCNT)
 ;
 ;get message type from "MSH"
 I $$NXTSEG^DGROHLUT(DGWRK,0,HL("FS"),.DGSEG),$G(DGSEG("TYPE"))="MSH" D
 . S DGMSGTYP=$P(DGSEG(9),$E(HL("ECH"),1),1)
 . ;HLMTIENS is only required by RCVORU and RCVQRY, thus $GET
 . I DGMSGTYP="" S (DGMSGTYP,HL("MTN"))="ORF",HLMTIENS=HLMTIEN
 . I DGMSGTYP=HL("MTN") D @("RCV"_DGMSGTYP_"(DGWRK,$G(HLMTIENS),.HL)")
 ;
 ;cleanup
 K @DGWRK
 Q
 ;
RCVACK(DGWRK,DGMIEN,DGHL) ;Receive ACK Message Types (ACK~R01)
 ;
 ;  Input:
 ;    DGWRK - name of work global containing segments
 ;   DGMIEN - IEN of message entry in file #773
 ;     DGHL - HL environment array
 ;
 ;  Output:
 ;    none
 ;
 N DGACK   ;ACK data array
 N DGERR   ;error array
 N DGLIEN  ;HL7 transmission log IEN
 N DGROL   ;HL7 transmssion log data array
 ;
 S ACKCODE=0
 D PARSACK^DGROHLU4(DGWRK,.DGHL,.DGACK,.DGERR)
 I $G(DGACK("ACKCODE"))'="AA" S ACKCODE=1
 Q
 ;
RCVQRY(DGWRK,DGMIEN,DGHL) ;Receive QRY Message Types (QRY~R02)
 ;
 ;  Input:
 ;    DGWRK - name of work global containing segments
 ;   DGMIEN - IEN of message entry in file #773
 ;     DGHL - HL environment array
 ;
 ;  Output:
 ;    none
 ;
 N DGDFN,DGQRY,DGQRYERR,DGSEGERR
 ;
 D PARSQRY^DGROHLQ3(DGWRK,.DGHL,.DGQRY,.DGSEGERR)
 S DGDFN=$$GETDFN^DGROUT2(DGQRY("ICN"),DGQRY("DOB"),DGQRY("SSN"))
 I DGDFN'>0 D
 . S DGQRYERR="NM"
 . ;
 . ;THE ICN FROM THE MPI DOES NOT MATCH A PATIENT, SO NOTIFY THE MPI
 . D MPIMAIL^DGROMAIL(.DGQRY)
 . ;
 D SNDORF^DGROHLS(.DGQRY,DGMIEN,.DGHL,DGDFN,.DGSEGERR,.DGQRYERR)
 Q
 ;
RCVORF(DGWRK,DGMIEN,DGHL) ;Receive ORF Message Types (ORF~R01)
 ;
 ;  Input:
 ;    DGWRK - name of work global containing segments, ^TMP("DGROHL7",$J)
 ;   DGMIEN - IEN of message entry in file #773
 ;     DGHL - HL environment array
 ;
 ;  Output:
 ;    none
 ;
 N DGDATA    ;patient data array to upload
 N DGERR     ;parse error array
 N DGORF     ;ORF data array
 ;
 S DGDATA=$NA(^TMP("DGROFDA",$J)) K @DGDATA
 D PARSORF^DGROHLQ3(DGWRK,.DGHL,.DGORF,.DGERR,.DGDATA)
 ;
 I $D(DGROVRCK) DO
 . S:('$D(DGORF("PATCH"))) DGROVRCK=0
 . I ($D(DGORF("PATCH"))),(+DGORF("PATCH")'=572) S DGROVRCK=0
 ;
 ;* QUIT conditions
 Q:'$D(DGORF)
 Q:(+$G(DGORF("DFN"))'>0)
 Q:'$D(^DPT(DGORF("DFN"),0))
 Q:('$D(DGORF("PATCH")))
 ;Q:(+DGORF("PATCH")'=572)
 ;
 S DFN=DGORF("DFN")
 ;
 ;Get DFN at Last Site Treated
 S LSTDFN=+$O(@DGDATA@(2,""))
 ;CHECK BUSINESS RULES
 D AO^DGRODEBR(DGDATA,DFN,LSTDFN)    ;AGENT ORANGE EXPOSURE
 D IR^DGRODEBR(DGDATA,DFN,LSTDFN)    ;RADIATION EXPOSURE
 D DOD^DGRODEBR(DGDATA,DFN,LSTDFN)   ;DATE OF DEATH
 D TA^DGRODEBR(DGDATA,LSTDFN)        ;TEMPORARY ADDRESS
 D SP^DGRODEBR(DGDATA,DFN,LSTDFN)    ;SENSITIVE PATIENT
 D CA^DGRODEBR(DGDATA,LSTDFN)        ;CONFIDENTIAL ADDRESS
 D SWA^DGRODEBR(DGDATA,DFN,LSTDFN)   ;SOUTHWEST ASIA CONDITIONS
 D INC^DGRODEBR(DGDATA,DFN,LSTDFN)   ;RULED INCOMPETENT
 D INE^DGRODEBR(DGDATA,DFN,LSTDFN)   ;INELIGIBLE
 D RDOC^DGRODEBR(DGDATA,DFN,LSTDFN)  ;RECENT DATE(S) OF CARE
 ;
 ;File the data
 D CONVFDA^DGROHLR1(DFN,DGDATA)
 ;CLEAN UP
 K @DGDATA
 Q
