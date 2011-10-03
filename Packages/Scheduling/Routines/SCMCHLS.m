SCMCHLS ;BPOI/DJB - PCMM HL7 Segment Utils;12/13/99
 ;;5.3;Scheduling;**177,210,212,293,515,524**;08/13/93;Build 29
 ;
 ;Ref rtn: SCDXMSG1
 ;
 ;--> Build HL7 segments
BLDEVN ;Build EVN segment
 S VAFEVN=$$EN^VAFHLEVN(EVNTHL7,EVNTDATE,VAFSTR,HL("Q"),HL("FS"))
 Q
BLDPID ;Build PID segment
 ;S VAFPID=$$EN^VAFHLPID(DFN,VAFSTR)
 S VAFPID=$$EN^VAFCPID(DFN,VAFSTR) ;Use CIRN version
 D SETMAR^SCMSVUT0(.VAFPID,HL("Q"),HL("FS"))
 Q
BLDZPC ;Build ZPC segment
 ;djb/bp Patch 210. Sequentially number multiple ZPC segments.
 ;new code begin
 S SCSEQ=$G(SCSEQ)+1 ;Increment ZPC sequence number.
 ; S VAFZPC=$$ZPC^SCMCHLZ("",ID,DATA,SCSEQ)
 S VAFZPC=$$ZPC^SCMCHLZ("",.ID,.DATA,SCSEQ)
 ;new code end
 ;old code begin
 ;S VAFZPC=$$ZPC^SCMCHLZ("",ID,DATA)
 ;old code end
 Q
 ;
 ;--> Copy HL7 segments into HL7 message
CPYEVN ;Copy EVN segment
 ;Add 1 as 3rd subscript so number of subscripts matches ZPC segment
 M @XMITARRY@(SUB,SEGNAME,1)=VAFEVN
 Q
CPYPID ;Copy PID segment
 ;Add 1 as 3rd subscript so number of subscripts matches ZPC segment
 M @XMITARRY@(SUB,SEGNAME,1)=VAFPID
 Q
CPYZPC ;Copy ZPC segment
 ; PATCH 515 DLL USE ORIG TRIG 
 ; old code = M @XMITARRY@($P(ID,"-",1),"ZPC",ID)=VAFZPC
 M @XMITARRY@(SUB,"ZPC",ID)=VAFZPC  ; og/sd/524
 Q
 ;
 ;--> Delete HL7 segment variables
DELEVN ;Delete EVN variable
 KILL VAFEVN
 Q
DELPID ;Delete PID variable
 KILL VAFPID
 Q
DELZPC ;Delete ZPC variable
 KILL VAFZPC
 Q
 ;
SEGMENTS(EVNTTYPE,SEGARRY) ;Build list of HL7 segments for a given event type
 ;
 ; Input: EVNTTYPE - Event type to build list for A08 & A23 are the
 ;                   only types currently supported.
 ;                   Default=A08
 ;         SEGARRY - Array to place output in (full global reference)
 ;                   Defaul=^TMP("SCMC SEGMENTS",$J)
 ;Output: SEGARRY(Seq,Name)=Fields
 ;             Seq - Sequence number to order segments as they should
 ;                   be placed in the HL7 message.
 ;            Name - Name of HL7 segment.
 ;          Fields - List of fields used by PCMM. VAFSTR would be set
 ;                   to this value.
 ;  Note: MSH segment is not included
 ;
 ;Check input
 S EVNTTYPE=$G(EVNTTYPE)
 S:(EVNTTYPE'="A23") EVNTTYPE="A08"
 S SEGARRY=$G(SEGARRY)
 S:(SEGARRY="") SEGARRY="^TMP(""SCMC SEGMENTS"","_$J_")"
 ;
 ;Segments used by A08
 S @SEGARRY@(1,"EVN")="1,2"
 S @SEGARRY@(2,"PID")="1,2,3,4,5,6,7,8,10N,11,12,13,14,16,17,19,22"
 S @SEGARRY@(3,"ZPC")="1,2,3,4,5,6,8" ;bp/ar and alb/rpm Patch 212
 Q
 ;
UNWIND(XMITARRY,INSRTPNT) ;Remove all data that was put into transmit array.
 ;
 ; Input: XMITARRY - Array containing HL7 message (full global ref).
 ;                   Default=^TMP("HLS",$J).
 ;        INSRTPNT - Where to begin deletion from.
 ;                   Default=1
 ;Output: None
 ;
 ;Check input
 S:$G(XMITARRY)="" XMITARRY="^TMP(""HLS"","_$J_")"
 S:$G(INSRTPNT)="" INSRTPNT=1
 ;
 ;Remove insertion point from array
 KILL @XMITARRY@(INSRTPNT)
 ;Remove everything from insertion point to end of array
 F  S INSRTPNT=$O(@XMITARRY@(INSRTPNT)) Q:INSRTPNT=""  KILL @XMITARRY@(INSRTPNT)
 ;Done
 Q
COUNT(VALER) ;counts the number of errored encounters found.
 ;
 ; Input: VALER - Array containing error messages.
 ;Output: Number of errors
 ;
 NEW VAR,CNT
 S CNT=0
 S VAR=""
 F  S VAR=$O(@VALER@(VAR)) Q:VAR']""  S CNT=CNT+1
 Q CNT
