DGMSTHL7 ;ALB/SCK - Military Sexual Trauma HL7 Message builder ;8 Jan 99
 ;;5.3;Registration;**195**;Aug 13, 1993
 Q
 ;
EVENT(DFN,DGEVNT,DGRSLT) ; Entry point to initiate HL7 ADT message for a MST status event
 ; Input
 ;     DFN    - IEN of patient in the PATIENT File, #2
 ;     DGEVNT - Event type, currently only A08 supported, Optional
 ;              Default is A08
 ;     DGRSLT - Location of results from event trigger
 ;
 ; Output
 ;     DGRSLT= results of event action
 ;
 N EVNTDT,EVNTINFO
 ;
 S DFN=$G(DFN)
 I 'DFN S @DGRSLT="-1^Invalid DFN" Q
 ;
 S DGEVNT=$G(DGEVNT)
 S:'(DGEVNT]"") DGEVNT="A08"
 I DGEVNT'["A08" S @DGRSLT="-1^Event type not supported" Q
 ;
 S DGRSLT=$G(DGRSLT)
 Q:'(DGRSLT]"")
 ;
 N GLOREF
 S GLOREF="^TMP(""HLS"","_$J_")"
 K @GLOREF
 ;
 S EVNTINFO("DFN")=DFN
 S EVNTINFO("EVENT")="A08"
 S EVNTINFO("DATE")=$$NOW^XLFDT
 S EVNTINFO("SERVER")="DGMST A08 SERVER"
 ;
 S @DGRSLT=$$BLDMSG(.EVNTINFO,GLOREF)
 I (+@DGRSLT>0) D
 . S @DGRSLT=$$SENDMSG(.EVNTINFO,GLOREF)
 Q
 ;
BLDMSG(EVNTINFO,XMTARRY) ;
 ;  Input
 ;     EVNTINFO - Array of event information
 ;         ("DATE")    - Event date
 ;         ("DFN")     - IEN of patient in PATIENT File (#2)
 ;         ("EVENT")   - HL7 message event
 ;         ("SERVER")  - HL7 Server protocol
 ;
 ;     XMTARRY - Location to place HL7 message array, Optional
 ;               Default is ^TMP("HLS",$J)
 ;
 ;  Output
 ;     XMTARRY - HL7 Message
 ;
 N HLEID,HL,HLFS,HLECH,HLQ,LASTLINE,VAFSTR,LINESADD,HLP
 ;
 S XMTARRY=$G(XMTARRY)
 S:(XMTARRY="") XMTARRY="^TMP(""HLS"","_$J_")"
 ;
 Q:$G(EVNTINFO("SERVER"))']"" "-1^Server protocol not defined"
 I $G(EVNTINFO("SERVER"))]"" D
 . D INIT^HLFNC2(EVNTINFO("SERVER"),.HL)
 Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 ;
 ;; Build EVN segment
 N VAFEVN,VAFSTR
 S VAFSTR="1,2,"
 S VAFEVN=$$EN^VAFHLEVN(EVNTINFO("EVENT"),EVNTINFO("DATE"),VAFSTR,HL("Q"),HL("FS"))
 S $P(VAFEVN,HL("FS"),2)=EVNTINFO("EVENT")
 S LASTLINE=1+$G(LASTLINE)
 S @XMTARRY@(LASTLINE)=VAFEVN
 ;
 ;; Build PID segment
 N VAFPID
 S VAFSTR="1,2,3,4,5,6,7,8,10,11,12,13,14,16,17,19,"
 S VAFPID=$$EN^VAFHLPID(EVNTINFO("DFN"),VAFSTR)
 S LASTLINE=1+$G(LASTLINE),LINESADD=1+$G(LINESADD)+$O(VAFPID(""),-1)
 M @XMTARRY@(LASTLINE)=VAFPID
 ;
 ;; Build ZEL segment, include only the MST status and status change date
 N VAFZEL
 S VAFSTR="1,23,24,"
 S VAFZEL=$$EN^VAFHLZEL(EVNTINFO("DFN"),VAFSTR)
 S LASTLINE=1+$G(LASTLINE)
 M @XMTARRY@(LASTLINE)=VAFZEL
 ;
 Q LASTLINE_U_LINESADD
 ;
SENDMSG(EVNTINFO,XMTARRY) ;  Send ADT HL7 message
 ;  Input
 ;    EVNTINFO
 ;    XMTARRY
 ;
 ;  Output
 ;
 ;
 N ARRY4HL7,KILLARRY,HL,HLRESLT
 S XMTARRY=$G(XMTARRY)
 S:'(XMTARRY]"") XMTARRY="^TMP(""HLS"","_$J_")"
 Q:($O(@XMTARRY@(""))="") "-1^Can not send empty message"
 ;
 K HL
 S ARRY4HL7="^TMP(""HLS"","_$J_")"
 ;
 ;; If server not specified, then quit with error
 Q:$G(EVNTINFO("SERVER"))']"" "-1^Server protocol not defined"
 ;
 ;; Initialize HL7 variables
 I $G(EVNTINFO("SERVER"))]"" D
 . D INIT^HLFNC2(EVNTINFO("SERVER"),.HL)
 Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 ;
 ;; Check if XMTARRY is ^TMP("HLS",$J)
 S KILLARRY=0
 I (XMTARRY'=ARRY4HL7) D
 . ;; make sure '$J' wasn't used
 . Q:(XMTARRY="TMP(""HLS"",$J")
 . K @ARRY4HL7
 . M @ARRY4HL7=@XMTARRY
 . S KILLARRY=1
 ;
 ;; Broadcast message
 D GENERATE^HLMA(EVNTINFO("SERVER"),"GM",1,.HLRESLT,"",.HLP)
 S:('HLRESLT) HLRESLT=$P(HLRESLT,"^",2,3)
 ;
 ;; Delete ^TMP("HLS",$J) if XMTARRY was different
 K:(KILLARRY) @ARRY4HL7
 ;
 Q $G(HLRESLT)
