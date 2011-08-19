VAFCMSG1 ;ALB/JRP-ADT/R MESSAGE BUILDING ; 22 Jan 2002 10:31 AM
 ;;5.3;Registration;**91,149,494**;Aug 13, 1993
 ;
BLDMSG(DFN,EVNTHL7,EVNTDATE,EVNTINFO,XMITARRY,INSRTPNT) ;Entry point
 ; for building HL7 ADT messages for a given patient
 ;
 ;Input  : DFN - Pointer to entry in PATIENT file (#2) to build
 ;               message for
 ;         EVNTHL7 - HL7 ADT event to build message for (Defaults to A08)
 ;                   Currently supported event types:
 ;                     A04, A08, A28
 ;         EVNTDATE - Date/time event occurred in FileMan format
 ;                  - Defaults to current date/time (NOW)
 ;         EVNTINFO - Array containing further event information needed
 ;                    when building HL7 segments/message.  Use and
 ;                    subscripting of array is determined by segment
 ;                    and/or message being built.
 ;                  - Defaults to ^TMP("VAFCMSG",$J,"EVNTINFO")
 ;                    Current subscripts include:
 ;                      EVNTINFO("DFN") = Pointer to PATIENT file (#2)
 ;                      EVNTINFO("EVENT") = Event type
 ;                      EVNTINFO("DATE") = Event date/time
 ;                      EVNTINFO("PIVOT") = Pointer to ADT/HL7 PIVOT
 ;                                          file (#391.71)
 ;                      EVNTINFO("REASON",X) = Event reason codes
 ;                      EVNTINFO("USER") = User associated with the event
 ;         XMITARRY - Array to build message into (full global reference)
 ;                  - Defaults to ^TMP("HLS",$J)
 ;         INSRTPNT - Line to begin inserting message text at
 ;                  - Defaults to 1 (can not be zero or less)
 ;Output : LastLine^TotalLine = ADT-Axx message was build
 ;             LastLine = Last line number in message
 ;             TotalLine = Number of lines in message
 ;                         (this total includes continuation lines)
 ;           XMITARRY will be in format compatible with HL7 package
 ;           XMITARRY(N) = Line N of message
 ;           XMITARRY(N,M) = Continuation number M of line N
 ;        -1^ErrorText = Error generating ADT-Axx message
 ;Notes  : It is the responsibility of the calling program to
 ;         initialize XMITARRY
 ;
 ;Check input
 S DFN=+$G(DFN)
 Q:('$D(^DPT(DFN,0))) "-1^Could not find entry in PATIENT file"
 S EVNTHL7=$G(EVNTHL7)
 S:(EVNTHL7="") EVNTHL7="A08"
 S EVNTDATE=+$G(EVNTDATE)
 S:('EVNTDATE) EVNTDATE=$$NOW^VAFCMSG5()
 S EVNTINFO=$G(EVNTINFO)
 S:(EVNTINFO="") EVNTINFO="^TMP(""VAFCMSG"","_$J_",""EVNTINFO"")"
 S XMITARRY=$G(XMITARRY)
 S:(XMITARRY="") XMITARRY="^TMP(""HLS"","_$J_")"
 S INSRTPNT=+$G(INSRTPNT)
 S:(INSRTPNT<1) INSRTPNT=1
 ;Declare variables
 N HLEID,HL,HLFS,HLECH,HLQ
 N VAFSTR,LASTLINE,LINESADD,SEGARRY
 N SEGORDR,SEGNAME,LINETAG,OK,TMP
 S SEGARRY="^TMP(""VAFC SEGMENTS"","_$J_")"
 K @SEGARRY
 ;Check for supported event
 S OK=0
 F TMP="A04","A08","A28" I TMP=EVNTHL7 S OK=1 Q
 Q:('OK) "-1^Event type not supported"
 ;
 K HL
 I $G(@EVNTINFO@("SERVER PROTOCOL"))]"" DO
 . D INIT^HLFNC2(@EVNTINFO@("SERVER PROTOCOL"),.HL)
 ;or Get pointer to HL7 Server Protocol
 E  DO  Q:'HLEID "-1^Server Protocol not found"
 .S HLEID=$$GETSRVR^VAFCMSG5(EVNTHL7)
 .Q:('HLEID)
 .;Initialize HL7 variables
 .D INIT^HLFNC2(HLEID,.HL)
 Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 ;
 ;Get list of segments
 N SEGERR
 D SEGMENTS^VAFCMSG4(EVNTHL7,SEGARRY)
 Q:('$O(@SEGARRY@(0))) "-1^Unable to determine list of segments to transmit"
 ;Loop through list of segments
 S LASTLINE=INSRTPNT-1
 S LINESADD=0
 S SEGORDR=0
 F  S SEGORDR=+$O(@SEGARRY@(SEGORDR)) Q:('SEGORDR)  D  Q:$G(SEGERR)
 .S SEGNAME=""
 .F  S SEGNAME=$O(@SEGARRY@(SEGORDR,SEGNAME)) Q:(SEGNAME="")  D
 ..;Build segment
 ..S VAFSTR=$G(@SEGARRY@(SEGORDR,SEGNAME))
 ..S LINETAG=$G(@SEGARRY@(SEGNAME,"BLD"))
 ..I (LINETAG'="") X LINETAG
 ..;Copy segment into HL7 message
 ..S LINETAG=$G(@SEGARRY@(SEGNAME,"CPY"))
 ..I (LINETAG'="") X LINETAG
 ..;Delete variables used by segment builder
 ..S LINETAG=$G(@SEGARRY@(SEGNAME,"DEL"))
 ..I (LINETAG'="") X LINETAG
 ;S ^TMP("HLS",$J,11)="ZFF"_HL("FS")_2_HL("FS")_$P($G(^VAT(391.71,+$G(PIVOTPTR),2)),U)
 ;Clean up and quit
 K @SEGARRY
 I $G(SEGERR) Q SEGERR
 Q LASTLINE_"^"_LINESADD
