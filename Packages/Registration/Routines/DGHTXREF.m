DGHTXREF ;ALB/JRC - Home Telehealth HL7 Message Monitoring Routine ;10 January 2005 ; 9/12/06 2:02pm
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
 ;This routine is called to set or remove cross references on
 ;file Home Telehealth Patient file (#391.31)
 ;
SETXREF(MSGID,SET,TYPE) ;Logic for "HTHNOACK" cross references of
 ; HOME TELEHEALTH PATIENT file (#391.31)
 ;
 ;Input  : MSGID - HL7 Message ID
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference
 ;         TYPE - If 1, set triggered by tasked job
 ;                If 0, set triggered by manual process
 ;                      demands special processing
 ;         OLDMSGID - If there is an old message id
 ;                    xref needs to be removed.
 ;
 ;Output : None
 ;
 ;Check input
 Q:'$G(MSGID)!'$G(SET)
 ;Check hl7 message, if status=3 make sure no xref exist and quit
 I +$$MSGSTAT^HLUTIL(MSGID)=3 D KILLXREF(MSGID) Q
 ;Declare variables
 N RECORD,TRANS,NODE0,TNODE,EVNTDATE,ACKCODE,CNT
 ;Set date and count if exist
 S EVNTDATE=$G(DGDATE),CNT=$S($G(DGCOUNT)'="":DGCOUNT+1,1:0)
 ;Get ien and sien of hth patient record and set nodes
 S RECORD=$O(^DGHT(391.31,"D",MSGID,0)) Q:'RECORD
 S TRANS=$O(^DGHT(391.31,"D",MSGID,RECORD,0)) Q:'TRANS
 S NODE0=$G(^DGHT(391.31,RECORD,0)),TNODE=$G(^("TRAN",TRANS,0))
 ;Check HTH file (#391.31) for  AA, if so kill xref and quit
 I ($P(TNODE,U,6)'="")!($P(TNODE,U,7)'="") D KILLXREF(MSGID) Q
 ;Get event date/time
 S EVNTDATE=$S(TYPE=1:DGDATE,TYPE=0:$P(TNODE,U,1),1:"")
 ;No event date/time - don't set x-ref
 Q:('EVNTDATE)
 ;Kill old xref if exist, then set the new xref
 D KILLXREF(MSGID)
 S ^DGHT(391.31,"HTHNOACK",MSGID,RECORD,TRANS)=CNT_U_EVNTDATE
 Q
 ;
KILLXREF(MSGID) ;Kill x-ref
 K ^DGHT(391.31,"HTHNOACK",MSGID)
 Q
