SCDXACK ;ALB/JRP - HL7 BATCH ACKNOWLEDGEMENT HANDLER;26-APR-1996 ; 21 Apr 2000  1:01 PM
 ;;5.3;Scheduling;**44,121,128,215**;AUG 13, 1993
 ;
ACKZ00 ;Process batch acknowledgements from National Patient Care Database
 ;
 ;Input  : All variables set by the HL7 package
 ;Output : None
 ;Notes  : The batch acknowledgement received is an exception based
 ;         acknowledgement - this allows for a complete acceptance or
 ;         rejection of an entire batch message.
 ;
 ;         If the batch acknowledgement is a batch acceptance, than
 ;         the batch message will only contain acknowledgements for
 ;         messages that were rejected.  All other messages contained
 ;         in the sent batch message are assumed to be accepted.
 ;
 ;         If the batch acknowledgement is a batch rejection, than
 ;         the batch message will only contain acknowledgements for
 ;         messages that were accepted.  All other messages contained
 ;         in the sent batch message are assumed to be rejected.
 ;
 ;Declare variables
 N %,%H,%I,X,ACKDATE,BATCHID,MSGID,XMITPTR,XMITARRY,ACKCODE,SDCT
 N MSGTYPE,EVNTTYPE,FLDSEP,CMPNTSEP,REPTNSEP,ERRCODES,ERROR,ERRNUM,ERRCNT
 S XMITARRY="^TMP(""AMB-CARE"","_$J_",""BID"")"
 K @XMITARRY
 ;Remember date/time acknowledgement was received
 S ACKDATE=$$NOW^XLFDT()
 ;Get field & component seperators
 S FLDSEP=HL("FS")
 S CMPNTSEP=$E(HL("ECH"),1)
 S REPTNSEP=$E(HL("ECH"),2)
 ;Get acknowledgement code
 S ACKCODE=$P(HLMSA,FLDSEP,2)
 ;Get rejection reason
 S ERROR=$P(HLMSA,FLDSEP,4)
 ;Default to acceptance
 S:(ACKCODE="") ACKCODE="AA"
 ;Only file APPLICATION ACKNOWLEDGEMENT
 Q:($E(ACKCODE,1)'="A")
 ;Translate acknowledgement code to Accept, Reject, Error
 S ACKCODE=$E(ACKCODE,2)
 ;Get batch control ID
 S BATCHID=$P(HLMSA,FLDSEP,3)
 ;Do implied acceptance/rejection for entries in ACRP Transmission
 ; History file (#409.77)
 D ACKBID^SCDXFU12(BATCHID,ACKDATE,ACKCODE)
 ;Get list of all entries in Transmitted Outpatient Encounter file
 ; (#409.73) that were contained in batch being acknowledged
 D PTRS4BID^SCDXFU02(BATCHID,XMITARRY)
 ;Loop through list of entries - do implied acceptance/rejection
 S XMITPTR=""
 F  S XMITPTR=+$O(@XMITARRY@(XMITPTR)) Q:('XMITPTR)  D
 .;Mark entry as accepted/rejected by National Patient Care Database
 .D ACKDATA^SCDXFU03(XMITPTR,ACKDATE,ACKCODE)
 .;Store error code if rejected by National Patient Care Database
 .I (ACKCODE'="A") S X=$$CRTERR^SCDXFU02(XMITPTR,ERROR,1)
 ;Loop through batch acknowledgement - do explicite acceptance/rejection
 F  X HLNEXT D  Q:(HLQUIT'>0)
 .;Skip to next message header (MSH)
 .Q:($E(HLNODE,1,3)'="MSH")
 .;Get field & component seperators
 .S FLDSEP=$E(HLNODE,4)
 .S CMPNTSEP=$E(HLNODE,5)
 .;Get message and event types
 .S X=$P(HLNODE,FLDSEP,9)
 .S MSGTYPE=$P(X,CMPNTSEP,1)
 .S EVNTTYPE=$P(X,CMPNTSEP,2)
 .;Only process message types ACK-A08 and ACK-A23
 .Q:(MSGTYPE'="ACK")
 .Q:((EVNTTYPE'="A08")&(EVNTTYPE'="A23"))
 .;Skip to message acknowledgement (MSA)
 .F  X HLNEXT Q:((HLQUIT'>0)!($E(HLNODE,1,3)="MSA"))
 .;Didn't find MSA - quit
 .Q:($E(HLNODE,1,3)'="MSA")
 .;Get acknowledgement code
 .S ACKCODE=$P(HLNODE,FLDSEP,2)
 .;Only file APPLICATION ACKNOWLEDGEMENT codes
 .Q:($E(ACKCODE,1)'="A")
 .;Translate acknowledgement code to Accept, Reject, Error
 .S ACKCODE=$E(ACKCODE,2)
 .;Get message ID being acknowledged
 .S MSGID=$P(HLNODE,FLDSEP,3)
 .;Get error codes
 .S ERRCODES=$P(HLNODE,FLDSEP,4)
 .;Do explicite acceptance/rejection for entry in ACRP Transmission
 .; History file (#409.77)
 .D ACKMID^SCDXFU12(MSGID,ACKDATE,ACKCODE)
 .;Find entry in Transmitted Outpatient Encounter file
 .S XMITPTR=$$PTR4MID^SCDXFU02(MSGID)
 .;Didn't find message control ID
 .Q:('XMITPTR)
 .;Store acknowledgement code
 .D ACKDATA^SCDXFU03(XMITPTR,ACKDATE,ACKCODE)
 .;Parse list of reported error codes
 .S ERRCNT=$L(ERRCODES,REPTNSEP),SDCT=0
 .F ERRNUM=1:1:ERRCNT D
 ..;Get error code
 ..S ERROR=$P(ERRCODES,REPTNSEP,ERRNUM)
 ..;Store error code
 ..Q:(ERROR="")
 ..S X=$$CRTERR^SCDXFU02(XMITPTR,ERROR,1),SDCT=SDCT+1
 .;If rejected, insure that at least one error code gets filed
 .I ACKCODE'="A",'SDCT S ERROR=999,X=$$CRTERR^SCDXFU02(XMITPTR,ERROR,1)
 ;Clean up
 K @XMITARRY
 ;Done
 Q
