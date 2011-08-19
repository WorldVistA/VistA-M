VAFCMSG0 ;ALB/JRP-ADT/R MESSAGE BUILDING ;12-SEP-1996
 ;;5.3;Registration;**91,149**;Jun 06, 1996
 ;
BCSTADT(DFN,EVNTHL7,EVNTDATE,EVNTINFO) ;Entry point for transmitting HL7 ADT
 ; messages for a given patient
 ;
 ;Input  : DFN - Pointer to entry in PATIENT file (#2) to build
 ;               message for
 ;         EVNTHL7 - HL7 ADT event to build message for (Defaults to A08)
 ;                   Currently supported event type:
 ;                     A04, A08, A28
 ;         EVNTDATE - Date/time event occurred in FileMan format
 ;                  - Defaults to current date/time (NOW)
 ;         EVNTINFO - Array containing further event information needed
 ;                    when building HL7 segments/message.  Use and
 ;                    subscripting of array is determined by segment
 ;                    and/or message being built.
 ;                  - Defaults to ^TMP("VAFCMSG",$J,"EVNTINFO")
 ;                    Current subscripts include:
 ;                      EVNTINFO("PIVOT") = Pointer to ADT/HL7 PIVOT
 ;                                          file (#391.71)
 ;                      EVNTINFO("REASON",X) = Event reason codes
 ;                      EVNTINFO("USER") = User associated with the event
 ;Output : Message ID = ADT-Axx message built and transmitted
 ;         ErrorCode^ErrorText = Error generating ADT-Axx message
 ;Notes  : The global array ^TMP("HLS",$J) will be initialized (KILLed)
 ;       : The following information will be placed into and killed
 ;         from the event information array:
 ;           EVNTINFO("DFN") = Pointer to PATIENT file (#2)
 ;           EVNTINFO("EVENT") = Event type
 ;           EVNTINFO("DATE") = Event date/time
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
 ;Declare variables
 N TMP,GLOREF,OK,RETURN
 ;Initialize global location for building HL7 messages
 S GLOREF="^TMP(""HLS"","_$J_")"
 K @GLOREF
 ;Check for supported event
 S OK=0
 F TMP="A04","A08","A28" I TMP=EVNTHL7 S OK=1 Q
 Q:('OK) "-1^Event type not supported"
 ;Put patient, event type, and event date/time into info array
 S @EVNTINFO@("DFN")=DFN
 S @EVNTINFO@("EVENT")=EVNTHL7
 S @EVNTINFO@("DATE")=EVNTDATE
 ;Build ADT-Axx message
 S RETURN=$$BLDMSG^VAFCMSG1(DFN,EVNTHL7,EVNTDATE,EVNTINFO,GLOREF,1)
 ;Error
 I (RETURN<0) D  Q RETURN
 .K @GLOREF,@EVNTINFO@("DFN"),@EVNTINFO@("EVENT"),@EVNTINFO@("DATE")
 ;Broadcast ADT-Axx message
 S RETURN=$$SNDMSG^VAFCMSG2(EVNTHL7)
 ;If message id returned, stuff in pivot file
 I +RETURN>0 D MESSAGE^VAFCDD01(@EVNTINFO@("PIVOT"),+RETURN)
 ;Error
 I (RETURN<0) D  Q RETURN
 .K @GLOREF,@EVNTINFO@("DFN"),@EVNTINFO@("EVENT"),@EVNTINFO@("DATE")
 ;Done - Clean up and return output of $$SNDMSG()
 K @GLOREF,@EVNTINFO@("DFN"),@EVNTINFO@("EVENT"),@EVNTINFO@("DATE")
 Q RETURN
