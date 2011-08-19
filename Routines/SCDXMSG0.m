SCDXMSG0 ;ALB/JRP - AMB CARE MESSAGE BUILDER;07-MAY-1996 ; 23 Oct 98  1:47 PM
 ;;5.3;Scheduling;**44,59,66,162,387**;AUG 13, 1993
 ;
BUILDHL7(XMITPTR,HL,MID,XMITARRY,INSRTPNT,VALERR) ;Build an HL7 message for an
 ; entry in the TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         HL - Array containing HL7 variables - pass by reference
 ;              This is the output of the call to INIT^HLFNC2()
 ;         MID - Message Control ID to use in the MSH segment
 ;         XMITARRY - Array to store HL7 message in (full global ref)
 ;                    (Defaults to ^TMP("HLS",$J))
 ;         INSRTPNT - Line to begin inserting message text at
 ;                    (Defaults to 1)
 ;Output : LINES - Number of lines in message (success)
 ;           XMITARRY(N) = Line N of HL7 message
 ;           XMITARRY(N,M) = Continuation number M of line N
 ;         -1^Error - Unable to build message / bad input
 ;Notes  : It is the responsibility of the calling program to
 ;         initialize (i.e. KILL) XMITARRY
 ;       : The MSH segment will not be built if MID is not passed
 ;       : When retransmitting, an EDIT event will be used if the
 ;         OUTPATIENT ENCOUNTER field (#.02) has a value and a
 ;         DELETE event will be used if the DELETED OUTPATIENT
 ;         ENCOUNTER field (#.03) has a value
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) "-1^Did not pass valid pointer to Transmitted Outpatient Encounter file"
 Q:($O(HL(""))="") "-1^Did not pass variables required to interact with the HL7 package"
 S MID=$G(MID)
 S XMITARRY=$G(XMITARRY)
 S:(XMITARRY="") XMITARRY="^TMP(""HLS"","_$J_")"
 S INSRTPNT=$G(INSRTPNT)
 S:(INSRTPNT="") INSRTPNT=1
 ;Declare variables
 N ENCDT,NODE,DFN,XMITEVNT,ENCPTR,DELPTR,LINESADD,LINETAG,EVNTDATE
 N CURLINE,EVNTHL7,VAFARRY,ORIGMTN,ORIGETN,RESULT
 N ERROR,VERROR,SEGMENTS,SEGORDR,SEGNAME,XMITDATE,VAFSTR,ENCNDT
 ;Get zero node of Transmitted Outpatient Encounter
 S NODE=$G(^SD(409.73,XMITPTR,0))
 ;Get pointer to Outpatient Encounter file
 S ENCPTR=+$P(NODE,"^",2)
 ;Get pointer to Deleted Outpatient Encounter file
 S DELPTR=+$P(NODE,"^",3)
 ;Pointer to either type of encounter not found - done
 Q:(('ENCPTR)&('DELPTR)) "-1^Entry in Transmitted Outpatient Encounter file does not reference an encounter"
 ;Get transmission event
 S XMITEVNT=+$P(NODE,"^",5)
 ;Retransmitting - use EDIT event for Outpatient Encounters and
 ; DELETE event for Deleted Outpatient Encounter
 S:('XMITEVNT) XMITEVNT=$S(ENCPTR:2,1:3)
 ;Convert event type to HL7 event
 ; Using A08 for ADD & EDIT and A23 for DELETE
 S EVNTHL7="A23"
 S:(XMITEVNT'=3) EVNTHL7="A08"
 ;Get event date/time
 S EVNTDATE=+$P(NODE,"^",6)
 ;Determine patient and encounter date/time
 S DFN=0
 S (ENCDT,ENCNDT)=0
 ;Get data from Outpatient Encounter
 I (ENCPTR) D
 .S NODE=$G(^SCE(ENCPTR,0))
 .S DFN=+$P(NODE,"^",2)
 .S ENCDT=+$P($P(NODE,"^"),".")
 .S ENCNDT=+$P(NODE,"^")
 ;Get data from Deleted Outpatient Encounter
 I (DELPTR) D
 .S NODE=$G(^SD(409.74,DELPTR,1))
 .S DFN=+$P(NODE,"^",2)
 .S ENCDT=+$P($P(NODE,"^"),".")
 .S ENCNDT=+$P(NODE,"^")
 ;Unable to determine patient - done
 Q:('DFN) "-1^"_$S(DELPTR:"Deleted ",1:"")_"Outpatient Encounter did not refer to a patient"
 ;Couldn't determine encounter date/time - use today
 S:('$G(ENCDT)) ENCDT=DT
 ;Build MSH segment if MID was passed
 S LINESADD=0
 S CURLINE=INSRTPNT
 S ERROR=0
 I (MID'="") D
 .;Remember original message & event types (only applicable to batch)
 .S ORIGMTN=HL("MTN")
 .S ORIGETN=HL("ETN")
 .;Put in message & event types for actual message
 .S HL("MTN")="ADT"
 .S HL("ETN")=EVNTHL7
 .;Build MSH segment
 .K RESULT D MSH^HLFNC2(.HL,MID,.RESULT)
 .;Reset message & event types to original values
 .S HL("MTN")=ORIGMTN
 .S HL("ETN")=ORIGETN
 .;Error
 .I (RESULT="") S ERROR="-1^Unable to create MSH segment" Q
 .;Copy MSH segment into HL7 message
 .S @XMITARRY@(CURLINE)=RESULT
 .;Increment number of lines added
 .S LINESADD=LINESADD+1
 .;Check for continuation node
 .I ($D(RESULT(1))) D
 ..;Copy continuation into HL7 message
 ..S @XMITARRY@(CURLINE,1)=RESULT(1)
 ..;Increment number of lines added
 ..S LINESADD=LINESADD+1
 .;Increment current line number
 .S CURLINE=CURLINE+1
 ;Error building MSH segment - done
 Q:(ERROR) ERROR
 ;Get list of segments
 D SEGMENTS^SCDXMSG1(EVNTHL7,"SEGMENTS")
 ;Loop through list of segments
 S (VERROR,ERROR)=0
 S SEGORDR=0
 F  S SEGORDR=+$O(SEGMENTS(SEGORDR)) Q:('SEGORDR)  D  Q:(ERROR)
 .S SEGNAME=""
 .F  S SEGNAME=$O(SEGMENTS(SEGORDR,SEGNAME)) Q:(SEGNAME="")  D  Q:(ERROR)
 ..;Build segment
 ..S VAFSTR=SEGMENTS(SEGORDR,SEGNAME)
 ..S VAFARRY="^TMP(""SCDX-XMIT-BLD"","_$J_","""_SEGNAME_""")"
 ..S LINETAG="BLD"_SEGNAME S ERROR=0 D @LINETAG^SCDXMSG1
 ..;Error - delete segment & quit
 ..I (ERROR) S LINETAG="DEL"_SEGNAME D @LINETAG^SCDXMSG1 Q
 ..;Validate segment, if appropriate
 ..S LINETAG="VLD"_SEGNAME S ERROR=0 D:$$VSEG() @LINETAG^SCDXMSG1
 ..I ERROR S VERROR=ERROR
 ..;Copy segment into HL7 message
 ..I 'ERROR S LINETAG="CPY"_SEGNAME D @LINETAG^SCDXMSG1
 ..S ERROR=0
 ..;Delete segment
 ..S LINETAG="DEL"_SEGNAME D @LINETAG^SCDXMSG1
 ..;Increment current line number
 ..S CURLINE=CURLINE+1
 ;Error building segment - remove segments already put into HL7
 ; message & quit
 I (ERROR)!(VERROR) D UNWIND^SCDXMSG1(XMITARRY,INSRTPNT) Q $S(ERROR:ERROR,1:VERROR)
 ;Done
 Q LINESADD
 ;
VSEG() ;Determine if segment should be validated
 ;All segments for 'add' or 'edit' transactions
 ;Only PID and PV1 segments for 'delete' transactions
 I EVNTHL7="A08" Q 1
 I EVNTHL7="A23","PID^PV1"[SEGNAME Q 1
 Q 0
