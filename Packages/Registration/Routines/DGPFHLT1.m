DGPFHLT1 ;SHRPE/YMG - PRF HL7 QBP/RSP PROCESSING ; 05/02/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This is the main driver for processing QBP^Q11 (PRF flag transfer request) messages.
 ;
 Q
 ;
EN ; entry point
 ; DATAARY array has the following structure:
 ;    DATAARY("ACTIVE") = 1 if PRF flag is active, 0 otherwise
 ;    DATAARY("REVBY")  = name of the person reviewing the request
 ;    DATAARY("REVDUZ") = DUZ of the person reviewing the request
 ;    DATAARY("REVDTM") = Date/time of the review
 ;    DATAARY("REVRES") = Result of the review
 ;       "A" for approval
 ;       "D" for denial/rejection
 ;    DATAARY("REVCMT") = review comment/reason
 ;    DATAARY("DFN")    = patient DFN
 ;    DATAARY("FLAG")   = PRF flag ien in file 26.15
 ;    DATAARY("ICN")    = patient ICN
 ;    DATAARY("MSGID")  = HL7 message Id
 ;    DATAARY("QOK")    = flag for QAK segment in RSP^K11 message
 ;       1 if  patient + PRF flag data has been found and retrieved
 ;       0 otherwise
 ;    DATAARY("REQBY")  = requester name
 ;    DATAARY("REQDTM") = request date/time
 ;    DATAARY("REQCMT") = request comment/reason
 ;    DATAARY("REQID")  = query id
 ;    DATAARY("SENDTO") = file 4  ien of facility we're sending HL7 message to
 ;    DATAARY("SFIEN")  = ien of sending facility in file 4
 ;    DATAARY("SFNAME") = formatted name of sending facility
 ;    DATAARY("ORIGOWN")= file 4 ien of flag's original owner
 ;
 N HLCMP,HLECH,HLFS,HLREP,HLSCMP ; HL7 variables
 N CNT,DATAARY,DGERR,DGFDA,DGIEN,DGPFA,DGPFAH,DIERR,FLAGNM,MSGTYPE,SEGCNT,SEGNM,SEGSTR,SNDDIV,SNDFAC
 ;
 S HLFS=HL("FS"),HLECH=HL("ECH"),HLCMP=$E(HLECH),HLREP=$E(HL("ECH"),2),HLSCMP=$E(HL("ECH"),4)
 K ^TMP("DGPFHLT1",$J)
 ; load segments into ^TMP global
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S CNT=0,^TMP("DGPFHLT1",$J,SEGCNT,CNT)=HLNODE
 .F  S CNT=$O(HLNODE(CNT)) Q:'CNT  S ^TMP("DGPFHLT1",$J,SEGCNT,CNT)=HLNODE(CNT)
 .Q
 ; check message type
 S SEGSTR=$G(^TMP("DGPFHLT1",$J,1,0))
 ; if ACK, just bail out
 I $P(SEGSTR,HLFS)="MSH",$P($P(SEGSTR,HLFS,9),HLCMP)="ACK" K ^TMP("DGPFHLT1",$J) Q
 ; if RSP^K11 call DGPFHLT3 and bail out
 I $P(SEGSTR,HLFS)="MSH",$P($P(SEGSTR,HLFS,9),HLCMP)="RSP" D EN^DGPFHLT3 Q
 ;
 S (SNDDIV,SNDFAC,FLAGNM)=""
 ; parse the message
 S SEGCNT="" F  S SEGCNT=$O(^TMP("DGPFHLT1",$J,SEGCNT)) Q:SEGCNT=""  D
 .S SEGSTR=$G(^TMP("DGPFHLT1",$J,SEGCNT,0))
 .S SEGNM=$P(SEGSTR,HLFS)
 .I SEGNM="MSH" D
 ..; parse MSH segment
 ..S SNDFAC=$P($P(SEGSTR,HLFS,4),HLCMP) ; sending facility (station #)
 ..S DATAARY("MSGID")=$P(SEGSTR,HLFS,10)
 ..Q
 .I SEGNM="QPD" D
 ..; parse QPD segment
 ..S DATAARY("REQID")=$P(SEGSTR,HLFS,3)
 ..S DATAARY("ICN")=$P(SEGSTR,HLFS,4)
 ..S FLAGNM=$$DECHL7^DGPFHLUT($P(SEGSTR,HLFS,5))    ; PRF flag name
 ..Q
 .I SEGNM="NTE" D
 ..; parse NTE segment
 ..S DATAARY("REQCMT")=$$DECHL7^DGPFHLUT($P(SEGSTR,HLFS,4))
 ..S DATAARY("REQBY")=$$FMNAME^HLFNC($P($P(SEGSTR,HLFS,6),HLCMP,1,5),HLECH)
 ..S DATAARY("REQBY")=$$DECHL7^DGPFHLUT(DATAARY("REQBY")) ; requester's name
 ..S SNDDIV=$P($P($P(SEGSTR,HLFS,6),HLCMP,14),HLSCMP,2) ; sending division (station #)
 ..S DATAARY("REQDTM")=$$FMDATE^HLFNC($P(SEGSTR,HLFS,7))
 ..Q
 .Q
 ; make sure that we got all necessary pieces of data
 S DATAARY("QOK")=0,DGERR=$$CHK()
 ; determine if flag is active
 S DATAARY("ACTIVE")=$S($P($G(DGPFA("STATUS")),U)=1:1,1:0)
 I 'DATAARY("ACTIVE") D
 .N DIERR,DGHERR
 .S DATAARY("REVBY")="DGPRF,INTERFACE"
 .S DATAARY("REVDUZ")=+$$FIND1^DIC(200,"","X",DATAARY("REVBY"),,,"DGHERR")
 .I 'DATAARY("REVDUZ") S DGERR="Receiver tried to use invalid reviewer name."
 .I 'DGERR S DATAARY("REVDTM")=$$NOW^XLFDT(),DATAARY("REVRES")="A"
 .Q
 ; send ACK message
 D SEND^DGPFHLT4(DATAARY("MSGID"),DGERR)
 ; if everything checked out, file a log entry
 I DGERR="" S DGERR=$$UPDLOG(.DATAARY)
 I DGERR="" D
 .; change status of previous requests with "PENDING" status to "NO RESPONSE"
 .D NORESP(DATAARY("DFN"),DATAARY("FLAG"),2)
 .; if flag is active, send Mailman notification
 .I DATAARY("ACTIVE") D TREQMSG^DGPFHLTM(.DATAARY,.DGPFA,1)
 .;if flag is inactive, activate it and transfer ownership to the requester
 .I 'DATAARY("ACTIVE") D
 ..S DATAARY("ORIGOWN")=$P($G(DGPFA("OWNER")),U)
 ..S DGERR=$$UPDASGN(1,DGIEN,.DATAARY,.DGPFA)
 ..S DATAARY("SENDTO")=$P($$PARENT^DGPFUT1(DATAARY("SFIEN")),U)
 ..I DATAARY("SENDTO")=0 S DATAARY("SENDTO")=DATAARY("SFIEN")
 ..; send response message (RSP^K11)
 ..D SEND^DGPFHLT2(DGERR,.DATAARY)
 ..Q
 .Q
 I DGERR'="" D
 .; Send Mailman notification
 .S ERTXT(1)="Error while processing QBP^Q11 HL7 message with message Id "_$G(DATAARY("MSGID"))_"."
 .S ERTXT(4)="Error description: "_DGERR
 .D TERRMSG^DGPFHLTM($G(DATAARY("MSGID")),.ERTXT)
 .Q
 K ^TMP("DGPFHLT1",$J)
 Q
 ;
CHK() ; Check data in incoming message
 ; Called from EN tag, relies on (and sets) some variables defined in there
 ; Returns "" if there are no problems, or error message otherwise
 ;
 N DGTFL,FCLTY,OWNER,DIERR,DGHERR
 I $G(DATAARY("MSGID"))="" Q "Missing message Id in MSH segment."
 I SNDDIV="" Q "Missing sending facility in NTE segment."
 I $G(DATAARY("REQID"))="" Q "Missing query Id in QPD segment."
 S DATAARY("DFN")=+$$GETDFN^MPIF001($G(DATAARY("ICN")))
 I DATAARY("DFN")'>0 Q "Invalid or missing ICN in QPD segment."
 S DATAARY("SFIEN")=+$$IEN^XUAF4(SNDDIV)
 I DATAARY("SFIEN")'>0 Q "Invalid sending facility in NTE segment."
 D BLDTFL^DGPFUT2(DATAARY("DFN"),.DGTFL)
 I '$D(DGTFL(+$$IEN^XUAF4(SNDFAC))) Q "Sending facility in MSH segment is not on receiver's treating facility list."
 S DATAARY("SFNAME")="Station # "_SNDDIV_"("_$$NAME^XUAF4(DATAARY("SFIEN"))_")"
 S DATAARY("FLAG")=+$$FIND1^DIC(26.15,,"X",FLAGNM,,,"DGHERR")
 I DATAARY("FLAG")'>0 Q "Invalid or missing PRF flag name in QPD segment."
 S DGIEN=$$FNDASGN^DGPFAA(DATAARY("DFN"),DATAARY("FLAG")_";DGPF(26.15,") ; PRF assignment ien in file 26.13 
 I DGIEN'>0 Q "Receiver was unable to find corresponding PRF flag assignment."
 I '$$GETASGN^DGPFAA(DGIEN,.DGPFA,1) Q "Receiver was unable to retrieve corresponding PRF flag assignment."
 S DATAARY("QOK")=1
 S OWNER=$P($G(DGPFA("OWNER")),U)
 S FCLTY=$P($$SITE^VASITE(),U)
 I OWNER'=FCLTY,$P($$PARENT^DGPFUT1(OWNER),U)'=FCLTY Q "Receiver is not the owner of PRF flag in question."
 I $G(DATAARY("REQBY"))="" Q "Invalid or missing requester's name in NTE segment."
 I $G(DATAARY("REQDTM"))="" Q "Invalid or missing request date/time in NTE segment."
 Q ""
 ;
UPDLOG(DATA) ; file a log entry
 ; DATA - Array of values to file (see tag EN)
 ; Returns "" if there are no problems, or error message otherwise
 ; 
 N DGFDA,DIEERR,DIERR
 S DGFDA(26.22,"+1,",.01)=$G(DATA("REQDTM"))
 S DGFDA(26.22,"+1,",.02)=$G(DATA("REQBY"))
 S DGFDA(26.22,"+1,",.03)=$G(DATA("DFN"))
 S DGFDA(26.22,"+1,",.04)=$G(DATA("FLAG"))
 S DGFDA(26.22,"+1,",.05)=$S($G(DATA("ACTIVE"))=1:2,1:3)
 I $G(DATA("REVBY"))'="" D
 .S DGFDA(26.22,"+1,",.06)=DATA("REVBY")
 .S DGFDA(26.22,"+1,",.07)=$G(DATA("REVDTM"))
 .Q
 S DGFDA(26.22,"+1,",.08)=$G(DATA("REQID"))
 S DGFDA(26.22,"+1,",.09)=$G(DATA("MSGID"))
 S DGFDA(26.22,"+1,",.1)=$G(DATA("SFIEN"))
 S DGFDA(26.22,"+1,",2.01)=$G(DATA("REQCMT"))
 D UPDATE^DIE(,"DGFDA",,"DIEERR")
 I $D(DIEERR) Q $E("Log filer: "_$G(DIEERR("DIERR",1,"TEXT",1)),1,80)
 Q ""
 ;
UPDASGN(AFLG,DGIEN,DATA,DGPFA) ; update PRF assignment and assignment history
 ; AFLG - 1 if flag needs to be reactivated, 0 otherwise
 ; DGIEN - ien of PRF assignment record
 ; DATA - Array of values to work with (see tag EN)
 ; DGPFA - PRF assignment array
 ; Returns "" if there are no problems, or error message otherwise
 ;
 N DBRSCNT,DBRSDATA,DBRSNUM,RES,Z
 S RES=""
 S DGPFAH("APPRVBY")=$G(DATA("REVDUZ"))
 S DGPFAH("ASSIGNDT")=$G(DATA("REVDTM"))
 S DGPFAH("ENTERBY")=$G(DATA("REVDUZ"))
 S DGPFA("REVIEWDT")=""
 S DGPFA("STATUS")=1 ; flag status = Active
 S DGPFAH("COMMENT",1,0)="Ownership transfer request has been received for this flag."
 ; add DBRS data to DGPFAH array
 D GETDBRS^DGPFUT6(.DBRSDATA,DGIEN)
 S (DBRSCNT,DBRSNUM)=0 F  S DBRSNUM=$O(DBRSDATA(DBRSNUM)) Q:DBRSNUM=""  D
 .S DBRSCNT=DBRSCNT+1
 .S DGPFAH("DBRS",DBRSCNT)=DBRSNUM_U_$P($G(DBRSDATA(DBRSNUM,"OTHER")),U)_U_$P($G(DBRSDATA(DBRSNUM,"DATE")),U)
 .S DGPFAH("DBRS",DBRSCNT)=DGPFAH("DBRS",DBRSCNT)_U_"N"_U_$P($G(DBRSDATA(DBRSNUM,"SITE")),U)
 .Q
 ; reactivate flag if it's inactive
 I AFLG D
 .S DGPFAH("ACTION")=4               ; Action = Reactivate
 .S DGPFAH("COMMENT",2,0)="As a result, flag has been reactivated."
 .S Z=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,,"")
 .I $P(Z,U)'>0 S RES="Receiver was unable to update PRF assignment record." Q
 .I $P(Z,U,2)'>0 S RES="Receiver was unable to update PRF history record." Q
 .; send ORU HL7 message for reactivation
 .S:'$$SNDORU^DGPFHLS(DGIEN) RES="Receiver was unable to send HL7 message update (ORU message)."
 .Q
 I RES="" D
 .; change ownership
 .S DGPFAH("ACTION")=2               ; Action = Continue
 .S DGPFA("OWNER")=$G(DATA("SFIEN")) ; New owner site
 .S DGPFAH("COMMENT",2,0)="As a result, flag ownership has been transferred"
 .S DGPFAH("COMMENT",3,0)="to "_$G(DATA("SFNAME"))
 .H 1 S DGPFAH("ASSIGNDT")=$$NOW^XLFDT() ; ensure that date/time of this history record differs from the previous one (reactivation)
 .S Z=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,,"")
 .I $P(Z,U)'>0 S RES="Receiver was unable to update PRF assignment record." Q
 .I $P(Z,U,2)'>0 S RES="Receiver was unable to update PRF history record." Q
 .; send ORU HL7 message for ownership transfer
 .S:'$$SNDORU^DGPFHLS(DGIEN) RES="Receiver was unable to send HL7 message update (ORU message)."
 .Q
 Q RES
 ;
NORESP(DFN,FLAG,STATUS) ; set status of entries in file 26.22 to "NO RESPONSE"
 ; DFN - patient DFN
 ; FLAG - flag ien in file 26.15
 ; STATUS - current status of entries that should be flipped to "NO RESPONSE" (internal code)
 ;
 N DATE,DGFDA,DGHERR,DIERR,IEN
 I +DFN'>0 Q
 I +FLAG'>0 Q
 I +STATUS'>0 Q
 ; skip the latest entry
 S DATE=$O(^DGPF(26.22,"D",DFN,FLAG,STATUS,""),-1)
 ; loop backwards, starting from the second to last entry
 F  S DATE=$O(^DGPF(26.22,"D",DFN,FLAG,STATUS,DATE),-1) Q:DATE=""  D
 .S IEN=+$O(^DGPF(26.22,"D",DFN,FLAG,STATUS,DATE,""))
 .S DGFDA(26.22,IEN_",",.05)=6
 .D FILE^DIE(,"DGFDA","DGHERR") K DGFDA
 .Q
 Q
