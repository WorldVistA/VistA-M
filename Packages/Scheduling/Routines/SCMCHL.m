SCMCHL ;BP/DJB - PCMM HL7 Main Calling Point ; 16 Dec 2002  11:14 AM
 ;;5.3;Scheduling;**177,204,224,272,367**;AUG 13, 1993
 ;
 ;Reference routine: SCDXMSG
MAIN(MODE,XMITARRY,VARPTR,WORK) ;Main entry point to generate Primary Care HL7
 ;messages to NPCD in Austin. Loop thru PCMM HL7 EVENT file (#404.48)
 ;and generate HL7 message for each appropriate event.
 ;
 ;Input:
 ;  MODE     - Mode of operation.
 ;              1: Generate mode - Generate HL7 messages. (Default).
 ;              2: Review mode   - HL7 segments will be built in array
 ;                                 XMITARRY and may be reviewed. HL7
 ;                                 messages WILL NOT be generated, and
 ;                                 processed events will not be
 ;                                 removed from the transmit xref in
 ;                                 PCMM HL7 EVENT file.
 ;  XMITARRY - Array to store HL7 segments (full global ref).
 ;             Default=^TMP("PCMM","HL7",$J)
 ;   VARPTR  - For testing purposes, you may pass in an EVENT POINTER
 ;             value. This value will be used rather than $ORDERing
 ;             thru "AACXMIT" xref in PCMM HL7 EVENT file.
 ;             Examples:
 ;                "2290;SCPT(404.43," (Patient Team Position Assign)
 ;                "725;SCTM(404.52,"  (Position Assign History)
 ;                "1;SCTM(404.53,"    (Preceptor Assign History)
 ;   Work Optional if present
 ;Output: None
 ;
 ;Prevent multiple runs processing at the same time.
 I $G(VARPTR)'="",$D(^XTMP("SCMCHL")) D  Q
 .W !,"HL7 Transmission in progress, no testing allowed!",!
 I $D(^XTMP("SCMCHL")) D  Q
 .W !,"HL7 Transmission in progress, please try again later.",!
 S ^XTMP("SCMCHL",0)=DT_"^"_DT
 ;
 NEW ERRCNT,IEN,MSG,MSGCNT,RESULT
 NEW SCEVIEN,SCFAC
 NEW HL,HLECH,HLEID,HLFS,HLQ,HLP,XMITERR
 ;
 ;Initialize variables - set global locations
 S:$G(MODE)'=2 MODE=1 ;Default mode = "Generate"
 S:$G(XMITARRY)="" XMITARRY="^TMP(""PCMM"",""HL7"","_$J_")" ;Segments
 S XMITERR="^TMP(""PCMM"",""ERR"","_$J_")" ;Errors
 S MSGCNT=0
 ;
 ;Get pointer to sending event
 S HLEID=$$HLEID()
 I 'HLEID D  Q
 . S MSG="Unable to initialize HL7 variables - protocol not found"
 . D ERRBULL^SCMCHLM(MSG)
 ;
 ;Initialize HL7 variables
 D INIT^HLFNC2(HLEID,.HL)
 I $O(HL(""))="" D  Q
 . D ERRBULL^SCMCHLM($P(HL,"^",2))
 ;
 ;Get faciltiy number
 S SCFAC=+$P($$SITE^VASITE(),"^",3)
 ;
 ;User passed in an EVENT POINTER value
 I $G(VARPTR)]"" D MANUAL Q
 ;
LOOP ;Loop thru EVENT POINTER xref and send message for each unique one.
 ;alb/rpm Patch 224
 ;The SCLIMIT counter allows sites to limit the number of HL7 messages
 ;processed at any one time.  The next EVENT POINTER in the queue will
 ;not be processed if SCLIMIT is exceeded.  SCLIMIT is not an absolute
 ;limit, since a single EVENT POINTER can generate multiple HL7
 ;messages.
 ;Sites can modify SCLIMIT by editing the HL7 TRANSMIT LIMIT field of
 ;the PCMM PARAMETER file.
 ;
 NEW SCLIMIT,WORK,VARPTR
 S SCLIMIT=$P($G(^SCTM(404.44,1,1)),U,5) ;Limit # of msgs processed
 S:'SCLIMIT SCLIMIT=2500 ;Default to 2500 msgs
 S VARPTR=""
 F  S VARPTR=$O(^SCPT(404.48,"AACXMIT",VARPTR)) Q:VARPTR=""!(SCLIMIT<1)  D
 . KILL @XMITARRY ;Initialize array
 . ;
 . ;Preserve the Event IEN. Used to process a deletion.
 . F SCEVIEN=0:0 S SCEVIEN=$O(^SCPT(404.48,"AACXMIT",VARPTR,SCEVIEN)) Q:'SCEVIEN  D
 .. ;
 .. ;Build segment array
 .. K SCFUT
 .. S WORK=+$P($G(^SCPT(404.48,SCEVIEN,0)),U,8)
 .. I WORK N HLEID S HLEID=$$HLEIDW() S RESULT=$$BUILD^SCMCHLP(VARPTR,.HL,.XMITARRY,SCEVIEN)
 .. I 'WORK S RESULT=$$BUILD^SCMCHLB(VARPTR,.HL,.XMITARRY)
 .. I +RESULT<0 D  Q  ;Error occurred when building segment array
 .. . S @XMITERR@(VARPTR)=$P(RESULT,"^",2)
 .. ;
 .. ;If in Review mode, display info and Quit.
 .. I MODE=2 D  Q  ;
 .. . W !,VARPTR_"  "_$S('$D(@XMITARRY):"No ",1:"")_"Data Found"
 .. ;
 .. ;If no segments built, turn off transmission flag and Quit.
 .. I '$D(@XMITARRY) D:'$G(SCFUT) FLAG(VARPTR,SCEVIEN) Q
 .. ;
 .. ;Generate message.
 .. ;
 .. Q:'$$GENERATE^SCMCHLG()  ;^SCMCHLG Increments MSGCNT
 .. D:'$G(SCFUT) FLAG(VARPTR,SCEVIEN) ;Turn off transmission flag
 .. K @XMITARRY  ;clean up variables
 . ;
 . Q
 ;
 I '$D(ZTQUEUED) W !,MSGCNT," messages sent."
 ;
 ;Send completion bulletin and clean up arrays.
 I MODE=1 D  ;Don't do this if in DISPLAY mode.
 . S ERRCNT=$$COUNT^SCMCHLS(XMITERR)
 . D CMPLBULL^SCMCHLM(MSGCNT,ERRCNT,XMITERR)
 . KILL @XMITARRY,@XMITERR
 . K ^XTMP("SCMCHL")
 ;
 Q:SCLIMIT<1
 ;
 ;alb/rpm;Patch 224;Transmit "M"arked messages from Transmission Log
 D EN^SCMCHLRR(.SCLIMIT)
 Q:SCLIMIT<1
 ;
 ;alb/rpm;Patch224;Transmit messages with overdue ACKnowledgment
 D AUTO^SCMCHLRR(.SCLIMIT)
 Q
 ;
MANUAL ;User passed in a specific variable pointer value. This value will
 ;be used rather than $ORDERing thru "AACXMIT" xref.
 ;
 NEW SCMANUAL
 S SCMANUAL=1 ;Indicates variable pointer was manually entered.
 ;             A delete cannot be processed.
 ;
 ;Initialize array
 KILL @XMITARRY
 ;
 ;Build segment array
 I $G(WORK) N HLEID S HLEID=$$HLEIDW() S RESULT=$$BUILD^SCMCHLP(VARPTR,.HL,.XMITARRY)
 I '$G(WORK) S RESULT=$$BUILD^SCMCHLB(VARPTR,.HL,.XMITARRY)
 I +RESULT<0 D  Q  ;Error occurred when building segment array
 . S @XMITERR@(VARPTR)=$P(RESULT,"^",2)
 W !,VARPTR_"  "_$S('$D(@XMITARRY):"No ",1:"")_"Data Found",!
 ;
 ;Generate message - FOR TESTING PURPOSES ONLY!
 S RESULT=$$GENERATE^SCMCHLG()
 K ^XTMP("SCMCHL")
 Q
 ;
FLAG(VARPTR,SCEVIEN) ;Turn off transmission flag. This removes event from "AACXMIT"
 ;xref in PCMM HL7 EVENT file.
 ;Input:
 ;   VARPTR - Internal value of EVENT POINTER field
 ;
 Q:$G(VARPTR)']""
 I $G(SCEVIEN) D TRANSMIT^SCMCHLE(SCEVIEN,0) Q
 NEW IEN
 S IEN=0
 F  S IEN=$O(^SCPT(404.48,"AACXMIT",VARPTR,IEN)) Q:'IEN  D  ;
 . D TRANSMIT^SCMCHLE(IEN,0)
 Q
 ;
HLEIDW() ;Return workload sending event
 Q +$O(^ORD(101,"B","SCMC SEND SERVER WORKLOAD",0))
HLEID() ;Return pointer to sending event
 I $G(WORK) Q $$HLEIDW()
 Q +$O(^ORD(101,"B","PCMM SEND SERVER FOR ADT-A08",0))
 Q
