MPIFRTC ;ALB/JRP-GET ICN FROM MPI USING REAL TIME CONNECTION ;21-JAN-1997
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1**;30 Apr 99
 ;
GETICN(DFN) ;Get ICN from MPI using real time connection
 ;
 ;Input  : DFN - Pointer to entry in PATIENT file (#2)
 ;Output : ICN = Success
 ;         -1^Reason = Failure
 ;
 ;Check input
 S DFN=+$G(DFN)
 Q:('$D(^DPT(DFN,0))) "-1^Did not pass valid DFN"
 ;Declare variables
 N DPTZERO,CREATED,USER,INFOARR,MSG2MPI,MSG2DHCP,TMP,ICN
 S MSG2MPI="^TMP(""MPIFRTC"","_$J_",""MSG2MPI"")"
 S MSG2DHCP="^TMP(""MPIFRTC"","_$J_",""MSG2DHCP"")"
 S INFOARR="^TMP(""MPIFRTC"","_$J_",""INFOARR"")"
 K @MSG2MPI,@MSG2DHCP,@INFOARR
 ;Determine user that created patient and date/time patient was created
 S DPTZERO=$G(^DPT(DFN,0))
 S USER=+$P(DPTZERO,"^",15)
 S:('USER) USER=+$G(DUZ)
 S CREATED=+$P(DPTZERO,"^",16)
 S:('CREATED) CREATED=$$NOW^XLFDT()
 ;Set up extra info array for message builder
 ; - Event reason code (EVN segment, seq #4)
 S @INFOARR@("REASON",1)=94
 ; - Operator (EVN segment, seq #5)
 S @INFOARR@("USER")=$P($G(^VA(200,USER,0)),"^",1)
 ;Build MSH segment for ADT-A28 HL7 message
 D BLDMSH("A28","MPI","200M",MSG2MPI,1)
 ;Build rest of ADT-A28 HL7 message
 S TMP=$$BLDMSG^VAFCMSG1(DFN,"A28",CREATED,INFOARR,MSG2MPI,2)
 ;need to remove local ICN from PID segment
 S $P(@MSG2MPI@(3),"^",3)="",$P(@MSG2MPI@(3),"^",4)=""
 ;Send ADT-A28 HL7 message to MPI using real time connection
 S TMP=$$EN^HLCSAC("MPIVA DIR",MSG2MPI,MSG2DHCP)
 Q:(TMP<0) TMP
 ;Process ADT-A31 HL7 message returned by MPI (contains ICN assignment)
 S ICN=$$PROCESS^MPIFA31I(MSG2DHCP)
 ;Done - Clean up and return ICN
EX K @MSG2MPI,@MSG2DHCP,@INFOARR
 Q ICN
 ;
BLDMSH(EVNTHL7,RCVAPP,RCVFAC,ARRAY,LINE) ;Build MSH segment for ADT
 ; HL7 message
 ;
 ;Input  : EVNTHL7 - HL7 ADT event to build MSH segment for A28
 ;                   (Defaults to A28)
 ;         RCVAPP - Text to use as RECEIVING APPLICATION (seq #5)
 ;         RCVFAC - Text to use as RECEIVING FACILITY (seq #6)
 ;         ARRAY - Array to store MSH segment in (full global reference)
 ;                 (Defaults to ^TMP("MPIFRTC",$J,"MSH"))
 ;         LINE - Line number in ARRAY to store MSH segment in
 ;                Can not be zero or negative number (defaults to 1)
 ;Output : None
 ;         ARRAY() will be in the following format
 ;           ARRAY(LINE) = MSH segment
 ;           ARRAY(LINE,1) = First continuation node
 ;           ARRAY(LINE,n) = Nth continuation node
 ;Notes  : ARRAY(LINE) will be initialized (KILLed) on input
 ;       : ARRAY(LINE) will not be defined on bad input
 ;       : SENDING APPLICATION (seq #3) and SENDING FACILITY (seq #4)
 ;         are based on the application attached to the PIMS ADT-xxx
 ;         HL7 Server Protocol
 ;
 ;Check input
 S EVNTHL7=$G(EVNTHL7)
 S:(EVNTHL7="") EVNTHL7="A28"
 S RCVAPP=$G(RCVAPP)
 S RCVFAC=$G(RCVFAC)
 S ARRAY=$G(ARRAY)
 S:(ARRAY="") ARRAY="^TMP(""MPIFRTC"","_$J_",""MSH"")"
 S LINE=+$G(LINE)
 S:(LINE<1) LINE=1
 ;Declare variables
 N HLEID,HL,TMPMSHAR
 ;Inintialize output array
 K @ARRAY@(LINE)
 ;Get pointer to ADT-xxx HL7 Server Protocol
 S HLEID=$$GETSRVR^VAFCMSG5(EVNTHL7)
 ;Initialize HL7 variables
 D INIT^HLFNC2(HLEID,.HL)
 ;Build MSH segment for ADT-xxx HL7 message
 D MSH^HLFNC2(.HL,"",.TMPMSHAR)
 ;Manually set RECEIVING APPLICATION (seq #5)
 S $P(TMPMSHAR,HL("FS"),5)=RCVAPP
 ;Manually set RECEIVING FACILITY (seq #6)
 S $P(TMPMSHAR,HL("FS"),6)=RCVFAC
 ;Move MSH segment into output array
 S @ARRAY@(LINE)=TMPMSHAR
 S HL=0
 F  S HL=+$O(MSH(HL)) Q:('HL)  S @ARRAY@(LINE,HL)=TMPMSHAR(HL)
 ;Done
 Q
