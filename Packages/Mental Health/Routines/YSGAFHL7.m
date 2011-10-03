YSGAFHL7 ;ALB/SCK-HL7 MENTAL HEALTH ROUTINES ;8/10/98
 ;;5.01;MENTAL HEALTH;**43,81**;Dec 30, 1994
 ;
 Q
EN(DFN,EVNTYP,EVNTDT,OBXINFO,EVNTINFO) ; Main entry point Mental Health ADT message builder
 ;
 ; Input
 ;     DFN - Pointer to entry in PATIENT file (#2) to build message for
 ;     EVNTYP   - HL7 ADT event to build message for (Defaults to A08)
 ;                Currently only A08 supported
 ;     EVNTDT   - Date/Time event occurred in FIleMAn format
 ;     OBXINFO  - Array containing the Observation information
 ;                OBXINFO(seq number)=Field value
 ;     EVNTINFO - Array containing further event information needed
 ;                when building HL7 segments/message.  Defaults to
 ;                ^TMP("YSGAF",$J,"EVNTINFO")
 ;                 Current subscripts include:
 ;                   EVNTINFO("REASON",X) = Reason Code
 ;                   EVNTINFO("SERVER PROTOCOL")= Server Protocol
 ;
 ; Output : Message ID - ADT=Axx message ID
 ;          ErrorCode^ErrorText - Error generating ADT-Axx message
 ;
 ;
 ;; Check Input
 S DFN=+$G(DFN)
 Q:('$D(^DPT(DFN,0))) "-1^Could not find entry in PATIENT file"
 S EVNTYP=$G(EVNTYP)
 S:(EVNTYP="") EVNTYP="A08"
 S EVNTDT=+$G(EVNTDT)
 S:('EVNTDT) EVNTDT=$$NOW^XLFDT
 Q:($O(@OBXINFO@(""))="") "-1^There was no Observation data to send"
 S EVNTINFO=$G(EVNTINFO)
 S:(EVNTINFO="") EVNTINFO="^TMP(""YSGAF"","_$J_",""EVNTINFO"")"
 ;
 N GLOREF,YSOK,RETURN
 ;; Check for supported event
 Q:("A08"'[EVNTYP) "-1^Event type not supported"
 ; 
 ;; Initialize transmission global
 S GLOREF="^TMP(""HLS"","_$J_")"
 K @GLOREF
 ;
 ;; Load EVNTINFO array
 S @EVNTINFO@("DFN")=DFN
 S @EVNTINFO@("EVENT")=EVNTYP
 S @EVNTINFO@("DATE")=EVNTDT
 ;
 ;; Build and send ADT-Axx message
 S RETURN=$$BLDMSG(DFN,EVNTYP,EVNTDT,OBXINFO,EVNTINFO,GLOREF)
 I (+RETURN>0) D
 . S RETURN=$$SNDMSG(EVNTYP,EVNTINFO)
 ;
 D CLRVAR
 Q $G(RETURN)
 ;
CLRVAR ; Common point for clearing variables used
 K @GLOREF,@EVNTINFO@("DFN"),@EVNTINFO@("EVENT"),@EVNTINFO@("DATE")
 Q
 ;
BLDMSG(DFN,EVNTYP,EVNTDT,OBXINFO,EVNTINFO,XMITARRY) ;
 ;
 N HLEID,HL,HLFS,HLECH,HLQ
 N VAFSTR,LASTLINE,LINESADD
 ;
 K HL
 S XMITARRY=$G(XMITARRY)
 S:(XMITARRY="") XMITARRY="^TMP(""HLS"","_$J_")"
 ;
 ;; Check for server protocol
 Q:$G(@EVNTINFO@("SERVER PROTOCOL"))']"" "-1^Server Protocol not defined"
 I $G(@EVNTINFO@("SERVER PROTOCOL"))]"" D
 . D INIT^HLFNC2(@EVNTINFO@("SERVER PROTOCOL"),.HL)
 Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 ;
 ;; Build EVN segment
 N VAFEVN,VAFSTR
 S VAFSTR="1,2,4"
 S VAFEVN=$$EN^VAFHLEVN(EVNTYP,EVNTDT,VAFSTR,HL("Q"),HL("FS"))
 S $P(VAFEVN,HL("FS"),2)=EVNTYP
 S $P(VAFEVN,HL("FS"),4)=$S($G(@EVNTINFO@("REASON"))]"":$G(@EVNTINFO@("REASON")),1:HL("Q"))
 ;; Add EVN segment to transmission array
 S LASTLINE=1+$G(LASTLINE)
 S @XMITARRY@(LASTLINE)=VAFEVN
 ;
 ;; Build PID segment
 N VAFPID
 S VAFSTR="1,2,3,4,5,6,7,8,10N,11,12,13,14,16,17,19,22"
 S VAFPID=$$EN^VAFHLPID(DFN,VAFSTR)
 S LASTLINE=1+$G(LASTLINE),LINESADD=1+$G(LINESADD)+$O(VAFPID(""),-1)
 M @XMITARRY@(LASTLINE)=VAFPID
 ;
 ;; Build OBX segment
 N VAFOBX,OBX1
 S VAFSTR="1,2,3,4,5,11,14,16"
 ;
 ;; Set Observation Identifier if not already set
 S @OBXINFO@(3)=$G(@OBXINFO@(3))
 S:(@OBXINFO@(3)="") @OBXINFO@(3)="GAF~Global Assessment of Function~AXIS 5"
 ;; Set Observation Result status to default if not passed in
 S @OBXINFO@(11)=$G(@OBXINFO@(11))
 S:(@OBXINFO@(11)="") @OBXINFO@(11)="F"
 ;
 ;; Set Value type to defualt if not passed in
 S @OBXINFO@(2)=$G(@OBXINFO@(2))
 S:(@OBXINFO@(2)="") @OBXINFO@(2)="ST"
 ;
 M OBX1=@OBXINFO
 S VAFOBX=$$EN^VAFHLOBX(.OBX1,,VAFSTR)
 S LASTLINE=1+$G(LASTLINE),LINESADD=1+$G(LINESADD)+$O(VAFOBX(""),-1)
 M @XMITARRY@(LASTLINE)=VAFOBX
 ;
 Q LASTLINE_"^"_LINESADD
 ;
SNDMSG(EVNTYP,EVNTINFO,XMITARRY) ; Send ADT HL7 message
 ;
 N ARRY4HL7,KILLARRY,HL,HLP,HLRESLT
 S XMITARRY=$G(XMITARRY)
 S:(XMITARRY="") XMITARRY="^TMP(""HLS"","_$J_")"
 Q:($O(@XMITARRY@(""))="") "-1^Can not send empty message"
 ;
 K HL
 S ARRY4HL7="^TMP(""HLS"","_$J_")"
 ;
 ;; If server is not specified then quit with error
 Q:$G(@EVNTINFO@("SERVER PROTOCOL"))']"" "-1^Server Protocol not defined"
 ;
 ;; Initialize HL7 variables
 I $G(@EVNTINFO@("SERVER PROTOCOL"))]"" D
 . D INIT^HLFNC2(@EVNTINFO@("SERVER PROTOCOL"),.HL)
 Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 ;
 ;; Check if XMITARRY is ^TMP("HLS",$J)
 S KILLARRY=0
 I (XMITARRY'=ARRY4HL7) D
 . ;;Make sure '$J' wasn't used
 . Q:(XMITARRY="TMP(""HLS"",$J)")
 . K @ARRY4HL7
 . M @ARRY4HL7=@XMITARRY
 . S KILLARRY=1
 ;
 ;; Broadcast message
 D GENERATE^HLMA(@EVNTINFO@("SERVER PROTOCOL"),"GM",1,.HLRESLT,"",.HLP)
 S:('HLRESLT) HLRESLT=$P(HLRESLT,"^",2,3)
 ;
 ;; Delete ^TMP("HLS",$J) if XMITARRY was different
 K:(KILLARRY) @ARRY4HL7
 ;
 Q $G(HLRESLT)
