DGPFHLR ;ALB/RPM - PRF HL7 RECEIVE DRIVERS ; 8/14/06 12:01pm
 ;;5.3;Registration;**425,650,951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
RCV ;Receive all message types and route to message specific receiver
 ;
 ;This procedure is the main driver entry point for receiving all
 ;message types (ORU, ACK, QRY and ORF) for patient record flag
 ;assignment sharing.
 ;
 ;All procedures and functions assume that all VistA HL7 environment
 ;variables are properly initialized and will produce a fatal error if
 ;they are missing.
 ;
 ;The received message is copied to a temporary work global for
 ;processing.  The message type is determined from the MSH segment and
 ;a receive processing procedure specific to the message type is called.
 ;(Ex. ORU~R01 message calls procedure: RCVORU).  The specific receive
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
 ;  ORU~R01   RCVORU^DGPFHLR      PARSORU^DGPFHLU    SNDACK^DGPFHLS
 ;  ACK~R01   RCVACK^DGPFHLR      PARSACK^DGPFHLU4   N/A
 ;  QRY~R02   RCVQRY^DGPFHLR      PARSQRY^DGPFHLQ3   SNDORF^DGPFHLS
 ;  ORF~R04   RCVORF^DGPFHLR      PARSORF^DGPFHLQ3   N/A
 ;
 N DGCNT
 N DGMSGTYP
 N DGSEG
 N DGSEGCNT
 N DGWRK
 ;
 S DGWRK=$NA(^TMP("DGPFHL7",$J))
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
 I $$NXTSEG^DGPFHLUT(DGWRK,0,HL("FS"),.DGSEG),$G(DGSEG("TYPE"))="MSH" D
 . S DGMSGTYP=$P(DGSEG(9),$E(HL("ECH"),1),1)
 . ;HLMTIENS is only required by RCVORU and RCVQRY, thus $GET
 . I DGMSGTYP=HL("MTN") D @("RCV"_DGMSGTYP_"(DGWRK,$G(HLMTIENS),.HL)")
 ;
 ;cleanup
 K @DGWRK
 Q
 ;
RCVORU(DGWRK,DGMIEN,DGHL) ;Receive ORU Message Types (ORU~R01)
 ;
 ;  Input:
 ;    DGWRK - name of work global containing segments
 ;   DGMIEN - IEN of message entry in file #773
 ;     DGHL - HL environment array
 ;
 ;  Output:
 ;    none
 ;
 N DGORU
 N DGSEGERR
 N DGSTOERR   ;store error array
 N DGACKTYP
 ;
 S DGORU=$NA(^TMP("DGPF",$J))
 K @DGORU
 D PARSORU^DGPFHLU(DGWRK,.DGHL,DGORU,.DGSEGERR)
 ;
 I '$D(DGSEGERR),$$STOORU(DGORU,.DGSTOERR) D
 . S DGACKTYP="AA"
 E  D
 . S DGACKTYP="AE"
 ;
 D SNDACK^DGPFHLS(DGACKTYP,DGMIEN,.DGHL,.DGSEGERR,.DGSTOERR)
 ;
 ;cleanup
 K @DGORU
 Q
 ;
STOORU(DGORU,DGERR) ;store ORU data array
 ;
 ;  Input:
 ;    DGORU - parsed ORU segment data array
 ;    
 ;  Output:
 ;   Function value - 1 on success; 0 on failure
 ;            DGERR - defined on failure
 ;    
 N DGADT     ;assignment date
 N DGCNT     ;count of assignment histories sent
 N DGPFA     ;assignment data array
 N DGPFAH    ;assignment history data array
 N DGSINGLE  ;flag to indicate a single history update
 N CURASGN,DBRSCNT,DBRSNUM,LASTDT,RES,STOFLG
 ;
 ;
 S DGPFA("SNDFAC")=$G(@DGORU@("SNDFAC"))
 S DGPFA("DFN")=$G(@DGORU@("DFN"))
 S DGPFA("FLAG")=$G(@DGORU@("FLAG"))
 ;
 ;init STATUS as a placeholder, $$STATUS^DGPFUT sets value in loop
 S DGPFA("STATUS")=""
 S DGPFA("OWNER")=$G(@DGORU@("OWNER"))
 S DGPFA("ORIGSITE")=$G(@DGORU@("ORIGSITE"))
 M DGPFA("NARR")=@DGORU@("NARR")
 ; DBRS data
 S DBRSCNT=0,DBRSNUM="" F  S DBRSNUM=$O(@DGORU@("DBRS",DBRSNUM)) Q:DBRSNUM=""  D
 .S DBRSCNT=DBRSCNT+1
 .S DGPFA("DBRS#",DBRSCNT)=DBRSNUM
 .S DGPFA("DBRS OTHER",DBRSCNT)=$G(@DGORU@("DBRS",DBRSNUM,"OTHER"))
 .S DGPFA("DBRS DATE",DBRSCNT)=$G(@DGORU@("DBRS",DBRSNUM,"DATE"))
 .S DGPFA("DBRS ACTION",DBRSCNT)=$G(@DGORU@("DBRS",DBRSNUM,"ACTION"))
 .S DGPFA("DBRS SITE",DBRSCNT)=$G(@DGORU@("DBRS",DBRSNUM,"SITE"))
 .Q
 ;count number of assignment histories sent
 S (DGADT,DGCNT)=0
 F  S DGADT=$O(@DGORU@(DGADT)) Q:'DGADT  S DGCNT=DGCNT+1
 S DGSINGLE=$S(DGCNT>1:0,1:1)
 S DGADT=0
 S LASTDT=+$O(@DGORU@(9999999.999999),-1) ; date of last history record
 ;
 ;process only the last history action when assignment already exists
 S CURASGN=$$FNDASGN^DGPFAA(DGPFA("DFN"),DGPFA("FLAG"))
 I 'DGSINGLE,CURASGN S DGADT=LASTDT,DGSINGLE=1
 ;
 F  S DGADT=$O(@DGORU@(DGADT)) Q:'DGADT  D  Q:$D(DGERR)
 .N DGPFAH   ;assignment history data array
 .;
 .S DGPFAH("ASSIGNDT")=DGADT
 .S DGPFAH("ACTION")=$G(@DGORU@(DGADT,"ACTION"))
 .S DGPFAH("ENTERBY")=.5  ;POSTMASTER
 .S DGPFAH("APPRVBY")=.5  ;POSTMASTER
 .M DGPFAH("COMMENT")=@DGORU@(DGADT,"COMMENT")
 .S DGPFAH("ORIGFAC")=$G(@DGORU@(DGADT,"ORIGFAC"))
 .; DBRS data
 .S DBRSCNT=0,DBRSNUM="" F  S DBRSNUM=$O(@DGORU@("DBRS",DBRSNUM)) Q:DBRSNUM=""  D
 ..S DBRSCNT=DBRSCNT+1
 ..S DGPFAH("DBRS",DBRSCNT)=DBRSNUM_U_$G(@DGORU@("DBRS",DBRSNUM,"OTHER"))_U_$G(@DGORU@("DBRS",DBRSNUM,"DATE"))
 ..I $G(@DGORU@("DBRS",DBRSNUM,"ACTION"))="U" D
 ...S RES=$$FIND1^DIC(26.131,","_CURASGN_",","X",DBRSNUM)
 ...S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_$S(RES:"E",1:"A")
 ...Q
 ..I $G(@DGORU@("DBRS",DBRSNUM,"ACTION"))="D" S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_"D"
 ..S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_$G(@DGORU@("DBRS",DBRSNUM,"SITE"))
 ..Q
 .; calculate the assignment STATUS from the ACTION
 .S DGPFA("STATUS")=$$STATUS^DGPFUT(DGPFAH("ACTION"))
 .; calculate new review date if this is ownership transfer
 .; if action = "continue" and current owner on file is different from owner in HL7 message, then it's an ownership transfer
 .I DGPFAH("ACTION")=2,$$GET1^DIQ(26.13,CURASGN_",",.04,"I")'=DGPFA("OWNER") D
 ..; if local site or division is the new owner, set review date
 ..I DGPFA("OWNER")=$P($$SITE^VASITE(),U)!$$ISDIV^DGPFUT(DGPFA("OWNER")) D
 ...S DGPFA("REVIEWDT")=$$GETRDT^DGPFAA3($P(DGPFA("FLAG"),U),DGPFAH("ASSIGNDT"))
 ...Q
 ..Q
 .; find out if we want to overwrite existing DBRS data
 .S STOFLG="" I DGADT=LASTDT,"^2^4^5^7^8^"[(U_DGPFAH("ACTION")_U) S STOFLG="D"
 .;validate before filing for single updates and new assignments
 .I DGSINGLE!(DGPFAH("ACTION")=1) S RES=$$STOHL7^DGPFAA3(.DGPFA,.DGPFAH,"DGERR",STOFLG) Q
 .;otherwise, just file it
 .S RES=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGERR,STOFLG)
 .Q
 ;convert dialog to dialog code
 I $D(DGERR) S DGERR=$G(DGERR("DIERR",1))
 ;
 Q '$D(DGERR)
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
 ;
 D PARSACK^DGPFHLU4(DGWRK,.DGHL,.DGACK,.DGERR)
 S DGLIEN=$$FNDLOG^DGPFHLL(26.17,$G(DGACK("MSGID")))
 Q:'DGLIEN
 ;
 I $G(DGACK("ACKCODE"))="AA" D
 . D STOSTAT^DGPFHLL(26.17,DGLIEN,"A",.DGERR)
 E  D
 . ;update transmission log status (REJECTED) and process error
 . D STOSTAT^DGPFHLL(26.17,DGLIEN,"RJ",.DGERR)
 . D PROCERR^DGPFHLU5(DGLIEN,.DGACK,.DGERR)
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
 N DGDFN
 N DGDFNERR
 N DGQRY
 N DGQRYERR
 N DGSEGERR
 ;
 D PARSQRY^DGPFHLQ3(DGWRK,.DGHL,.DGQRY,.DGSEGERR)
 S DGDFN=$$GETDFN^DGPFUT2(DGQRY("ICN"),"DGDFNERR")
 I DGDFN'>0,$G(DGDFNERR("DIERR",1))]"" D
 . S DGQRYERR=DGDFNERR("DIERR",1)
 D SNDORF^DGPFHLS(.DGQRY,DGMIEN,.DGHL,DGDFN,.DGSEGERR,.DGQRYERR)
 Q
 ;
RCVORF(DGWRK,DGMIEN,DGHL) ;Receive ORF Message Types (ORF~R04)
 ;
 ;  Input:
 ;    DGWRK - name of work global containing segments
 ;   DGMIEN - IEN of message entry in file #773
 ;     DGHL - HL environment array
 ;
 ;  Output:
 ;    none
 ;
 N DGDFN   ;pointer to PATIENT (#2) file
 N DGLIEN  ;HL7 query log IEN
 N DGORF   ;ORF data array root
 N DGERR   ;parser error array
 N DGSTAT  ;query log status
 ;
 S DGORF=$NA(^TMP("DGPF",$J))
 K @DGORF
 D PARSORF^DGPFHLQ4(DGWRK,.DGHL,DGORF,.DGERR)
 S DGDFN=+$$GETDFN^MPIF001($G(@DGORF@("ICN")))
 ;
 ;successful query
 I $G(@DGORF@("ACKCODE"))="AA" D
 . S DGSTAT=$S(+$O(@DGORF@(0))>0:"A",1:"AN")
 . ;
 . ;REJECT when filer fails; otherwise mark event as COMPLETE
 . I '$$STOORF(DGDFN,DGORF) D
 . . S DGSTAT="RJ"
 . . S DGERR($O(DGERR(""),-1)+1)=261120  ;Unable to file
 . E  D STOEVNT^DGPFHLL1(DGDFN,"C")
 ;
 ;failed query
 I $G(@DGORF@("ACKCODE"))'="AA" S DGSTAT="RJ"
 ;
 ;find and update query log status
 S DGLIEN=$$FNDLOG^DGPFHLL(26.19,$G(@DGORF@("MSGID")))
 I DGLIEN D STOSTAT^DGPFHLL(26.19,DGLIEN,DGSTAT,.DGERR)
 ;
 ;purge PRF HL7 QUERY LOG when status is COMPLETE
 I $$GETSTAT^DGPFHLL1(DGDFN)="C" D PRGQLOG^DGPFHLL($$FNDEVNT^DGPFHLL1(DGDFN))
 ;
 ;cleanup
 K @DGORF
 Q
 ;
STOORF(DGDFN,DGORF,DGERR) ;store ORF data
 ;
 ;  Input:
 ;    DGDFN - pointer to patient in PATIENT (#2) file
 ;    DGORF - parsed ORF segments data array
 ;
 ;  Output:
 ;   Function value - 1 on success; 0 on failure
 ;    DGERR - defined on failure
 ;
 N DGADT     ;activity date ("ASSIGNDT")
 N DGPFA     ;assignment data array
 N DGPFAH    ;assignment history data array
 N DGSET     ;set id to represent a single PRF assignment
 N CURASGN,DBRSCNT,DBRSNUM,RES
 ;
 S DGSET=0 F  S DGSET=$O(@DGORF@(DGSET)) Q:'DGSET  D
 .N DGPFA   ;assignment data array
 .;
 .S DGPFA("DFN")=DGDFN
 .S DGPFA("FLAG")=$G(@DGORF@(DGSET,"FLAG"))
 .Q:DGPFA("FLAG")']""
 .;prevent overwriting existing assignments
 .S CURASGN=$$FNDASGN^DGPFAA(DGPFA("DFN"),DGPFA("FLAG")) Q:CURASGN
 .;init STATUS as a placeholder, $$STATUS^DGPFUT sets value in loop
 .S DGPFA("STATUS")=""
 .S DGPFA("OWNER")=$G(@DGORF@(DGSET,"OWNER"))
 .S DGPFA("ORIGSITE")=$G(@DGORF@(DGSET,"ORIGSITE"))
 .M DGPFA("NARR")=@DGORF@(DGSET,"NARR")
 .; DBRS data
 .S DBRSCNT=0,DBRSNUM="" F  S DBRSNUM=$O(@DGORF@(DGSET,"DBRS",DBRSNUM)) Q:DBRSNUM=""  D
 ..S DBRSCNT=DBRSCNT+1
 ..S DGPFA("DBRS#",DBRSCNT)=DBRSNUM
 ..S DGPFA("DBRS OTHER",DBRSCNT)=$G(@DGORF@(DGSET,"DBRS",DBRSNUM,"OTHER"))
 ..S DGPFA("DBRS DATE",DBRSCNT)=$G(@DGORF@(DGSET,"DBRS",DBRSNUM,"DATE"))
 ..S DGPFA("DBRS ACTION",DBRSCNT)=$G(@DGORF@(DGSET,"DBRS",DBRSNUM,"ACTION"))
 ..S DGPFA("DBRS SITE",DBRSCNT)=$G(@DGORF@(DGSET,"DBRS",DBRSNUM,"SITE"))
 ..Q
 .S DGADT=0  ;each DGADT represents a single PRF history action
 .F  S DGADT=$O(@DGORF@(DGSET,DGADT)) Q:'DGADT  D  Q:$D(DGERR)
 ..N DGPFAH   ;assignment history data array
 ..;
 ..S DGPFAH("ASSIGNDT")=DGADT
 ..S DGPFAH("ACTION")=$G(@DGORF@(DGSET,DGADT,"ACTION"))
 ..S DGPFAH("ENTERBY")=.5  ;POSTMASTER
 ..S DGPFAH("APPRVBY")=.5  ;POSTMASTER
 ..M DGPFAH("COMMENT")=@DGORF@(DGSET,DGADT,"COMMENT")
 ..S DGPFAH("ORIGFAC")=$G(@DGORF@(DGSET,DGADT,"ORIGFAC"))
 ..; DBRS data
 ..S DBRSCNT=0,DBRSNUM="" F  S DBRSNUM=$O(@DGORF@(DGSET,"DBRS",DBRSNUM)) Q:DBRSNUM=""  D
 ...S DBRSCNT=DBRSCNT+1
 ...S DGPFAH("DBRS",DBRSCNT)=DBRSNUM_U_$G(@DGORF@(DGSET,"DBRS",DBRSNUM,"OTHER"))
 ...S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_$G(@DGORF@(DGSET,"DBRS",DBRSNUM,"DATE"))
 ...I $G(@DGORF@(DGSET,"DBRS",DBRSNUM,"ACTION"))="D" S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_"D" Q
 ...S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_"A"
 ...S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_$G(@DGORF@(DGSET,"DBRS",DBRSNUM,"SITE"))
 ...Q
 ..;calculate the assignment STATUS from the ACTION
 ..S DGPFA("STATUS")=$$STATUS^DGPFUT(DGPFAH("ACTION"))
 ..S RES=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGERR,"")
 ..Q
 .Q
 Q '$D(DGERR)
