SCDXFU13 ;ALB/JRP - ACRP TRANSMISSION MANAGEMENT FILE UTILS;14-JUL-97
 ;;5.3;Scheduling;**128**;AUG 13, 1993
 ;
HST4XMIT(XMITPTR,ARRAY,FORMAT) ;Return transmission/acknowledgement history
 ; for entry in Transmitted Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file (#409.73)
 ;         ARRAY - Output array (full global reference)
 ;               - Defaults to ^TMP("SCDXFU13",$J,"HST4XMIT")
 ;         FORMAT - Flag denoting subscript for ARRAY
 ;                    0 = Subscript ARRAY by pointer to file (Default)
 ;                    1 = Subscript ARRAY by transmission date
 ;                    2 = Subscript ARRAY by acknowledgement date
 ;Output : X - Number of times entry was transmitted
 ;         Format 0: ARRAY(HistPtr) = XmitDT ^ AckDT ^ Code ^ Late
 ;         Format 1: ARRAY(XmitDT) = HistPtr ^ AckDT ^ Code ^ Late
 ;                   ARRAY(0 , HistPtr) = HistPtr ^ AckDT ^ Code ^ Late
 ;                     Used when XmitDT not on file
 ;         Format 2: ARRAY(AckDT) = XmitDT ^ HistPtr ^ Code ^ Late
 ;                   ARRAY(0 , HistPtr) = XmitDT ^ HistPtr ^ Code ^ Late
 ;                     Used when AckDT not on file
 ;           HistPtr = Pointer to ACRP Transmission History file
 ;           XmitDT = Date/time of transmission (FileMan)
 ;           AckDT = Date/time of acknowledgement (FileMan)
 ;           Code = Acknowledgement code received
 ;                     A = Accepted     R = Rejected     E = Error
 ;           Late = Transmission occur after workload close-out
 ;                     0 = No           1 = Yes          -1 = Error
 ;Notes  : It is the responsibility of the calling procedure to
 ;         initialize (i.e. KILL) the output array
 ;       : Zero (0) is used when a transmission date is not on file
 ;       : Zero (0) is used when an acknowledgement date is not on file
 ;       : NULL is used when an acknowledgement code is not on file
 ;       : Determinating if transmission occured after close-out is
 ;         based on the currently stored workload close-out dates
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 S ARRAY=$G(ARRAY)
 S:(ARRAY="") ARRAY=$NA(^TMP("SCDXFU13",$J,"HST4XMIT"))
 S FORMAT=+$G(FORMAT)
 S:((FORMAT<0)!(FORMAT>2)) FORMAT=0
 ;Declare variables
 N HISTPTR,XMITDATE,ACKDATE,ACKCODE,COUNT,NODE,LATE
 ;Find/count entries in history file
 S COUNT=0
 S HISTPTR=0
 F  S HISTPTR=+$O(^SD(409.77,"B",XMITPTR,HISTPTR)) Q:('HISTPTR)  D
 .;Bad x-ref entry (ignore)
 .Q:('$D(^SD(409.77,HISTPTR,0)))
 .;Increment counter
 .S COUNT=COUNT+1
 .;Get transmission date
 .S XMITDATE=+$G(^SD(409.77,HISTPTR,1))
 .;Get node containing acknowledgement data
 .S NODE=$G(^SD(409.77,HISTPTR,2))
 .;Get ack date
 .S ACKDATE=+$P(NODE,"^",1)
 .;Get ack code
 .S ACKCODE=$P(NODE,"^",2)
 .;Determine if transmitted after close-out
 .S LATE=+$$LATE^SCDXFU11(HISTPTR)
 .;Put into output array
 .I (FORMAT=1) D  Q
 ..S NODE=HISTPTR_"^"_ACKDATE_"^"_ACKCODE_"^"_LATE
 ..I ('XMITDATE) S @ARRAY@(0,HISTPTR)=NODE Q
 ..S @ARRAY@(XMITDATE)=NODE
 .I (FORMAT=2) D  Q
 ..S NODE=XMITDATE_"^"_HISTPTR_"^"_ACKCODE_"^"_LATE
 ..I ('ACKDATE) S @ARRAY@(0,HISTPTR)=NODE Q
 ..S @ARRAY@(ACKDATE)=NODE
 .S @ARRAY@(HISTPTR)=XMITDATE_"^"_ACKDATE_"^"_ACKCODE_"^"_LATE
 ;Done
 Q COUNT
 ;
HST4VID(VSITID,ARRAY,FORMAT) ;Return transmission/acknowledgement history
 ; for Unique Visit ID (field #20 of Outpatient Encounter file)
 ;
 ;Input  : VSITID - Unique Visit ID
 ;         ARRAY - Output array (full global reference)
 ;               - Defaults to ^TMP("SCDXFU13",$J,"HST4VID")
 ;         FORMAT - Flag denoting subscript for ARRAY
 ;                    0 = Subscript ARRAY by pointer to file (Default)
 ;                    1 = Subscript ARRAY by transmission date
 ;                    2 = Subscript ARRAY by acknowledgement date
 ;Output : X - Number of Unique Visit ID was transmitted
 ;         Format 0: ARRAY(HistPtr) = XmitDT ^ AckDT ^ Code ^ Late
 ;         Format 1: ARRAY(XmitDT) = HistPtr ^ AckDT ^ Code ^ Late
 ;                   ARRAY(0 , HistPtr) = HistPtr ^ AckDT ^ Code ^ Late
 ;                     Used when XmitDT not on file
 ;         Format 2: ARRAY(AckDT) = XmitDT ^ HistPtr ^ Code ^ Late
 ;                   ARRAY(0 , HistPtr) = XmitDT ^ HistPtr ^ Code ^ Late
 ;                     Used when AckDT not on file
 ;           HistPtr = Pointer to ACRP Transmission History file
 ;           XmitDT = Date/time of transmission (FileMan)
 ;           AckDT = Date/time of acknowledgement (FileMan)
 ;           Code = Acknowledgement code received
 ;                     A = Accepted     R = Rejected     E = Error
 ;           Late = Transmission occur after workload close-out
 ;                     0 = No           1 = Yes
 ;Notes  : It is the responsibility of the calling procedure to
 ;         initialize (i.e. KILL) the output array
 ;       : Zero (0) is used when a transmission date is not on file
 ;       : Zero (0) is used when an acknowledgement date is not on file
 ;       : NULL is used when an acknowledgement code is not on file
 ;       : Determinating if transmission occured after close-out is
 ;         based on the currently stored workload close-out dates
 ;
 ;Check input
 S VSITID=$G(VSITID)
 Q:(VSITID="") 0
 S ARRAY=$G(ARRAY)
 S:(ARRAY="") ARRAY=$NA(^TMP("SCDXFU13",$J,"HST4VID"))
 S FORMAT=+$G(FORMAT)
 S:((FORMAT<0)!(FORMAT>2)) FORMAT=0
 ;Declare variables
 N HISTPTR,XMITDATE,ACKDATE,ACKCODE,COUNT,NODE,LATE
 ;Find/count entries in history file
 S COUNT=0
 S HISTPTR=0
 F  S HISTPTR=+$O(^SD(409.77,"AVID",VSITID,HISTPTR)) Q:('HISTPTR)  D
 .;Bad x-ref entry (ignore)
 .Q:('$D(^SD(409.77,HISTPTR,0)))
 .;Increment counter
 .S COUNT=COUNT+1
 .;Get transmission date
 .S XMITDATE=+$G(^SD(409.77,HISTPTR,1))
 .;Get node containing acknowledgement data
 .S NODE=$G(^SD(409.77,HISTPTR,2))
 .;Get ack date
 .S ACKDATE=$P(NODE,"^",1)
 .;Get ack code
 .S ACKCODE=$P(NODE,"^",2)
 .;Determine if transmitted after close-out
 .S LATE=+$$LATE^SCDXFU11(HISTPTR)
 .;Put into output array
 .I (FORMAT=1) D  Q
 ..S NODE=HISTPTR_"^"_ACKDATE_"^"_ACKCODE_"^"_LATE
 ..I ('XMITDATE) S @ARRAY@(0,HISTPTR)=NODE Q
 ..S @ARRAY@(XMITDATE)=NODE
 .I (FORMAT=2) D  Q
 ..S NODE=XMITDATE_"^"_HISTPTR_"^"_ACKCODE_"^"_LATE
 ..I ('ACKDATE) S @ARRAY@(0,HISTPTR)=NODE Q
 ..S @ARRAY@(ACKDATE)=NODE
 .S @ARRAY@(HISTPTR)=XMITDATE_"^"_ACKDATE_"^"_ACKCODE_"^"_LATE
 ;Done
 Q COUNT
