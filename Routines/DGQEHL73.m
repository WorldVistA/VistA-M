DGQEHL73 ;ALB/JFP - VIC HL7 Message Builder (A08); 09/01/96
 ;;5.3;REGISTRATION;**73,120,148**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BLDA08(XMITPTR,HL,MID,XMITARRY,INSRTPNT) ;
 ; -- Build either a batch or single HL7 A08 message for VIC
 ;
 ;Input  : XMITPTR - Pointer to entry in PATIENT file (#2)
 ;         HL - Array containing HL7 variables - pass by reference
 ;              (This is the output of the call to INIT^HLFNC2())
 ;         MID - Message Control ID to use in batch MSH segment
 ;         XMITARRY - Array to store HL7 message in (full global ref)
 ;                    (Defaults to ^TMP("HLS",$J))
 ;         INSRTPNT - Line to begin inserting message text at
 ;                    (Defaults to 1)
 ;Output : LINES - Number of lines in message (success)
 ;           XMITARRY(N) = Line N of HL7 message
 ;           XMITARRY(N,M) = Continuation number M of line N
 ;         -1^Error - Unable to build message / bad input
 ;
 ;Notes  1. It is the responsibility of the calling program to
 ;          initialize (i.e. KILL) XMITARRY
 ;       2. If MID is defined in the parameter list, a batch MSH segment
 ;          will be built.  Otherwise a HL7 v1.6 will build the MSH
 ;          segment.
 ;
 ; -- Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^DPT(XMITPTR,0))) "-1^Did not pass valid pointer to PATIENT file"
 Q:($O(HL(""))="") "-1^Did not pass variables required to interact with the HL7 package"
 S MID=$G(MID)
 S XMITARRY=$G(XMITARRY)
 S:(XMITARRY="") XMITARRY="^TMP(""HLS"","_$J_")"
 S INSRTPNT=$G(INSRTPNT)
 S:(INSRTPNT="") INSRTPNT=1
 ; -- Declare variables
 N LINESADD,CURLINE,RESULT,ERROR,VAFSTR
 N VAFEVN,VAFPID,VAFPV1,VAFZEL,VAFZSP,VAFZPD
 ;
 S LINESADD=0
 S CURLINE=INSRTPNT
 S ERROR=0
 ; -- Build MSH segment for BATCH transmission, otherwise skip
 I (MID'="") D
 .; -- Build MSH segment
 .K RESULT D MSH^HLFNC2(.HL,MID,.RESULT)
 .; -- Check for results of call
 .I (RESULT="") S ERROR="-1^Unable to create MSH segment for a batch transmission" Q
 .; -- Copy MSH segment into HL7 message
 .S @XMITARRY@(CURLINE)=RESULT
 .; -- Increment number of lines added
 .S LINESADD=LINESADD+1
 ; -- Error building MSH segment - done
 Q:(ERROR) ERROR
 ; -- Build Segments associated with an A08 Message
 ;
 ; -- -- Build EVN
 S VAFEVN=$$EVN^VAFHLEVN("A08","")
 S CURLINE=CURLINE+1
 S LINESADD=LINESADD+1
 S @HL7XMIT@(CURLINE)=VAFEVN
 ; -- -- Build PID
 S VAFSTR="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19"
 S VAFPID=$$EN^VAFHLPID(XMITPTR,VAFSTR)
 S CURLINE=CURLINE+1
 S LINESADD=LINESADD+1
 S @HL7XMIT@(CURLINE)=VAFPID
 ; -- -- Build PV1 (note: this is a null segment)
 S VAFPV1="PV1^1"
 S CURLINE=CURLINE+1
 S LINESADD=LINESADD+1
 S @HL7XMIT@(CURLINE)=VAFPV1
 ; -- -- Build ZEL
 S VAFSTR="1,2,3,4,5,6,7,8,9,10,11,12,13"
 S VAFZEL=$$EN^VAFHLZEL(XMITPTR,VAFSTR,1)
 S CURLINE=CURLINE+1
 S LINESADD=LINESADD+1
 ; -- The Datacards side of interface is hard coded, to the number of
 ;    fields specified in the original interface specification.  If
 ;    fields are added to the segment definition, it causes the VIC
 ;    machine error. This code corrects the problem by truncating the
 ;    results of the national call after the 14th piece.
 S VAFZEL=$P(VAFZEL,HLFS,1,14)
 S @HL7XMIT@(CURLINE)=VAFZEL
 ; -- -- Build ZSP
 S VAFZSP=$$EN^VAFHLZSP(XMITPTR)
 S LINESADD=LINESADD+1
 S CURLINE=CURLINE+1
 ; -- The Datacards side of interface is hard coded, to the number of
 ;    fields specified in the original interface specification.  If
 ;    fields are added to the segment definition, it causes the VIC
 ;    machine error. This code corrects the problem by truncating the
 ;    results of the national call after the 5th piece.
 S VAFZSP=$P(VAFZSP,HLFS,1,5)
 S @HL7XMIT@(CURLINE)=VAFZSP
 ;
 ; -- -- Build ZPD
 S VAFSTR="1,17"
 S VAFZPD=$$EN^VAFHLZPD(XMITPTR,VAFSTR)
 S LINESADD=LINESADD+1
 S CURLINE=CURLINE+1
 ; -- Change POW indicator in piece 17 from Y/N to 1/0
 ;    to work with the DataCard interface.
 S $P(VAFZPD,"^",18)=$S($P(VAFZPD,"^",18)="Y":1,1:0)
 ; -- The Datacards side of interface is hard coded, to the number of
 ;    fields specified in the original interface specification.  If
 ;    fields are added to the segment definition, it causes the VIC
 ;    machine error. This code corrects the problem by truncating the
 ;    results of the national call after the 18th piece.
 S VAFZPD=$P(VAFZPD,HLFS,1,18)
 S @HL7XMIT@(CURLINE)=VAFZPD
 ;
 Q LINESADD
END ; -- End of code
 ;
