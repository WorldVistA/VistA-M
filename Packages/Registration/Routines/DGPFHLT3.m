DGPFHLT3 ;SHRPE/YMG - PRF HL7 QBP/RSP PROCESSING ; 05/02/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This is the main driver for processing RSP^K11 (response to PRF flag transfer request) messages
 ;
 Q
 ;
EN ; entry point
 ; called from EN^DGPFHLT1, uses ^TMP("DGPFHLT1,$J") work global created there.
 ;
 N DGERR,DGFDA,DGFERR,ERTXT,IENS,LOGIEN,MAILARY,MAILPFA,MSGID,REQID,SEGCNT,SEGNM,SEGSTR,SNDFAC,STOP
 ;
 S STOP=0,DGERR=""
 ; parse the message
 S SEGCNT="" F  S SEGCNT=$O(^TMP("DGPFHLT1",$J,SEGCNT)) Q:SEGCNT=""  D  Q:STOP
 .S SEGSTR=$G(^TMP("DGPFHLT1",$J,SEGCNT,0))
 .S SEGNM=$P(SEGSTR,HLFS)
 .I SEGNM="MSH" D
 ..; parse MSH segment
 ..S SNDFAC=$P($P(SEGSTR,HLFS,4),HLCMP) ; sending facility (station #) for use in error messages
 ..S MSGID=$P(SEGSTR,HLFS,10) ; HL7 message Id
 ..Q
 .I SEGNM="QAK" D  Q:STOP
 ..; parse QAK segment
 ..S REQID=$P(SEGSTR,HLFS,2) ; query Id
 ..S LOGIEN=$$FNDLOG(REQID) I 'LOGIEN D  Q
 ...S DGERR="Unable to find log entry for query id "_REQID
 ...D SENDERR(MSGID,SNDFAC,"",DGERR)
 ...S STOP=1
 ...Q
 ..S IENS=LOGIEN_","
 ..I DGERR="",$P(SEGSTR,HLFS,3)'="OK" S DGERR="Receiver was unable to find corresponding PRF flag assignment."
 ..Q
 .I SEGNM="QPD" D
 ..; parse QPD segment
 ..S MAILARY("REVBY")=$$DECHL7^DGPFHLUT($P(SEGSTR,HLFS,6)) ; reviewer name
 ..S MAILARY("REVDTM")=$$FMDATE^HLFNC($P(SEGSTR,HLFS,7)) ; review date/time
 ..Q
 .I SEGNM="NTE" D
 ..; parse NTE segment
 ..S MAILARY("REVRES")=$P($P(SEGSTR,HLFS,4),HLREP) ; result of the review
 ..S MAILARY("REVCMT")=$$DECHL7^DGPFHLUT($P($P(SEGSTR,HLFS,4),HLREP,2)) ; review reason
 ..Q
 .Q
 S MAILARY("REVRES")=$G(MAILARY("REVRES"))
 I "^A^D^"'[(U_MAILARY("REVRES")_U),DGERR="" S DGERR="Invalid review status code received."
 ; send ACK message
 D SEND^DGPFHLT4(MSGID,DGERR)
 ; update log entry
 I $G(IENS) D UPDLOG(IENS,DGERR,.MAILARY,.DGFERR)
 I DGERR'=""!$D(DGFERR) D  G ENX
 .; Send Mailman notification for error
 .D:DGERR'="" SENDERR(MSGID,SNDFAC,"",DGERR)
 .D:$D(DGFERR) SENDERR(MSGID,SNDFAC,$G(DGFERR("DIERR",1)),$G(DGFERR("DIERR",1,"TEXT",1)))
 .Q
 ; finish setting up data structures for DGPFHLTM and send Mailman notification about response
 K DGFDA D GETS^DIQ(26.22,IENS,".01:.04;2.01",,"DGFDA")
 S MAILARY("REQDTM")=$G(DGFDA(26.22,IENS,.01))
 S MAILARY("REQBY")=$G(DGFDA(26.22,IENS,.02))
 S MAILARY("REQCMT")=$G(DGFDA(26.22,IENS,2.01))
 ; only set external values here for TREQMSG^DGPFHLTM, full DGPFA is not needed.
 S MAILPFA("DFN")=U_$G(DGFDA(26.22,IENS,.03))
 S MAILPFA("FLAG")=U_$G(DGFDA(26.22,IENS,.04))
 D TREQMSG^DGPFHLTM(.MAILARY,.MAILPFA,2)
 ; update "NO RESPONSE" entries with new review date/time
 D NORESPDT($$FIND1^DIC(2,,"X",$G(DGFDA(26.22,IENS,.03))),$$FIND1^DIC(26.15,,"X",$G(DGFDA(26.22,IENS,.04))),MAILARY("REVDTM"))
 ;
ENX ; exit point
 K ^TMP("DGPFHLT1",$J)
 Q
 ;
FNDLOG(REQID) ; find log entry (file 26.22) for a given query id
 ; REQID - query id to look for
 ; Returns ien in file 26.22 on success, 0 otherwise
 N RES
 S RES=0 I $G(REQID)'="" S RES=+$O(^DGPF(26.22,"C",REQID,""))
 Q RES
 ;
SENDERR(MSGID,SNDFAC,DGECODE,DGERR) ; send Mailman notification for an error
 N ERTXT
 S ERTXT(1)="Error while processing RSP^K11 HL7 message from station # "_$G(SNDFAC)_"."
 S ERTXT(3)="Error code: "_$S($G(DGECODE)="":"N/A",1:$G(DGECODE))
 S ERTXT(4)="Error description: "_$G(DGERR)
 D TERRMSG^DGPFHLTM(MSGID,.ERTXT)
 Q
 ;
UPDLOG(IENS,DGERR,DATA,DGFERR) ; update log entry in file 26.22
 ; only updates fields .05,.06,.07,and 1
 ;
 ; IENS - ien in file 26.22_","
 ; DGERR - error text to file into 26.22/1
 ; DATA - array of values to file (see tag EN^DGPFHLT1)
 ; DGFERR - array to return FM filing errors in
 ;
 ; returns filing errors in DGFERR, if any.
 ;
 N DGFDA
 S DGFDA(26.22,IENS,.05)=$S(DGERR'="":5,DATA("REVRES")="A":3,1:4)
 S DGFDA(26.22,IENS,.06)=$G(DATA("REVBY"))
 S DGFDA(26.22,IENS,.07)=$G(DATA("REVDTM"))
 S DGFDA(26.22,IENS,2.02)=$G(DATA("REVCMT"))
 S:DGERR'="" DGFDA(26.22,IENS,1)=DGERR
 D FILE^DIE(,"DGFDA","DGFERR")
 Q
 ;
NORESPDT(DFN,FLAG,RDT) ; update review date/time of "NO RESPONSE" entries in file 26.22
 ; DFN - patient DFN
 ; FLAG - flag ien in file 26.15
 ; RDT - review date/time to use in internal FM format
 ;
 N DATE,DGFDA,DIERR,IEN
 I +DFN'>0!(+FLAG'>0) Q
 ; loop through "NO RESPONSE" entries
 S DATE="" F  S DATE=$O(^DGPF(26.22,"D",DFN,FLAG,6,DATE)) Q:DATE=""  D
 .S IEN=+$O(^DGPF(26.22,"D",DFN,FLAG,6,DATE,""))
 .S DGFDA(26.22,IEN_",",.07)=RDT
 .D FILE^DIE(,"DGFDA","DIERR") K DGFDA
 .Q
 Q
