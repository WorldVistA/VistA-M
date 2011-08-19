DGQEHLS ;ALB/RPM - VIC REPLACEMENT HL7 SEND DRIVER ; 10/13/05
 ;;5.3;Registration;**571,679**;Aug 13, 1993
 ;
 Q  ;no direct entry
 ;
SND(DGRIEN,DGERR) ;Send a single ORM orders message
 ; This function builds and transmits a General Order (ORM~O01)
 ; Message used to either release a hold on a Veteran ID Card (VIC)
 ; request or cancel the VIC request.
 ;
 ;  Input:
 ;    DGRIEN - pointer VIC REQUEST (#39.6) file
 ;
 ;  Output:
 ;    Function result - '1' on success; '0' on failure
 ;    DGERR - undefined on success; error message string on failure
 ;
 N DGHLEID   ;event protocol ID
 N DGHLRSLT  ;result from GENERATE API
 N DGREQ     ;VIC REQUEST data array
 N DGROOT    ;HL7 message text array name
 N DGRSLT    ;function result
 ;
 S DGROOT=$NA(^TMP("HLS",$J))
 K @DGROOT
 ;
 S DGRSLT=0
 ;
 I $G(DGRIEN)>0 D
 . ;
 . ;initialize HL7 environment
 . S DGHLEID=$$INIT^DGQEHLUT("DGQE VIC ORM/O01 EVENT",.DGHL)
 . I 'DGHLEID S DGERR="Unable to initialize HL7 environment"
 . Q:$D(DGERR)
 . ;
 . ;retrieve VIC REQUEST file record
 . I '$$GETREQ^DGQEREQ(DGRIEN,.DGREQ) D
 . . S DGERR="Unable to retrieve VIC REQUEST data"
 . Q:$D(DGERR)
 . ;
 . ;build ORM message
 . I '$$BLDORM(.DGREQ,DGROOT,.DGHL) D
 . . S DGERR="Unable to build ORM message text"
 . Q:$D(DGERR)
 . ;
 . ;transmit the message
 . D GENERATE^HLMA(DGHLEID,$S(DGROOT["^":"GM",1:"LM"),1,.DGHLRSLT)
 . I +$P(DGHLRSLT,U,2) S DGERR=$P(DGHLRSLT,U,2)
 . Q:$D(DGERR)
 . ;
 . ;set transmission log
 . D STOXMIT^DGQEHLL($P(DGHLRSLT,U),DGRIEN)
 . ;
 . ;clear transmission required flag
 . D XMITOFF^DGQEDD(DGRIEN)
 . ;
 . S DGRSLT=1
 ;
 K @DGROOT
 ;
 Q DGRSLT
 ;
BLDORM(DGREQ,DGROOT,DGHL) ;build segments for a single ORM message
 ;
 ;  Input:
 ;    DGREQ - (required) VIC REQUEST data array
 ;   DGROOT - (required) closed root array name to contain segments
 ;     DGHL - VistA HL7 environment array
 ;
 ;  Output:
 ;    Function value - "1" on sucess; "0" on failure
 ;
 N DGPTID    ;Patient ID field 3 of PID segment
 N DGRSLT    ;function result
 N DGSEG     ;segment counter
 N DGSEGSTR  ;formatted segment string
 N DGSTR     ;comma-delimited list of segment fields
 ;
 S DGRSLT=0
 S DGSEG=0
 I $D(DGREQ),$G(DGROOT)]"",$D(DGHL) D
 . Q:'$G(DGREQ("DFN"))
 . Q:'$D(^DPT(DGREQ("DFN")))
 . Q:$G(DGREQ("CARDID"))']""
 . ;
 . ;build PID segment
 . S DGSTR="1,2,3,5,7,19"  ;{3=ICN,5=NAME,7=DOB,19=SSN}
 . S DGSEGSTR=$$EN^VAFHLPID(DGREQ("DFN"),DGSTR,1,1)
 . Q:(DGSEGSTR="")
 . ;set Patient ID field 3 Check Digit component to null
 . S DGPTID=$P(DGSEGSTR,DGHL("FS"),4)
 . S $P(DGPTID,$E(DGHL("ECH")),2)=""
 . S $P(DGSEGSTR,DGHL("FS"),4)=DGPTID
 . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 . ;
 . ;build ORC segment
 . S DGSTR="1"
 . S DGSEGSTR=$$ORC^DGQEHLOR(.DGREQ,DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 . ;
 . ;build RQD segment
 . S DGSTR="1,3"
 . S DGSEGSTR=$$RQD^DGQEHLRQ(.DGREQ,DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 . ;
 . ;build NTE segment for POW and PH
 . S DGSTR="3"
 . S DGSEGSTR=$$NTE^DGQEHLNT(.DGREQ,DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGSEGSTR
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
