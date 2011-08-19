HLCSIN ;ALB/JRP - INCOMING FILER;01-MAY-95 ;03/07/2011
 ;;1.6;HEALTH LEVEL SEVEN;**2,30,14,19,62,109,115,122,140,145,153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
STARTIN ;Main entry point for incoming background filer
 ;Create/find entry denoting this filer in the INCOMING FILER TASK
 ; NUMBER multiple (field #20) of the HL COMMUNICATION SERVER PARAMETER
 ; file (#869.3)
 N HLFLG,HLEXIT,HLPTRFLR
 ;
 ; patch HL*1.6*122
 ;; N HLDUZ,DUZ  ; patch HL*1.6*122 TEST v2: DUZ code removed
 N HLDUZ
 S HLDUZ=+$G(DUZ)
 ;
 S HLPTRFLR=+$$CRTFLR^HLCSUTL1(ZTSK,"IN")
 ;Loop through Logical Links and check for incoming messages
 S HLEXIT=0
 ; patch HL*1.6*122 TEST v2: DUZ code removed
 ; patch HL*1.6*122, set DUZ for application proxy user
 ;; D PROXY^HLCSTCP4
 S HLPTRFLR("$J")=$J
 F  D  Q:HLEXIT
 . S HLFLG=0
 . D DEFACK(.HLPTRFLR,.HLFLG,.HLEXIT) Q:HLEXIT
 . D ACKNOW(.HLPTRFLR,.HLFLG,.HLEXIT) Q:HLEXIT
 . Q:HLFLG
 . I $$HDIFF^XLFDT($H,$G(HLPTRFLR("LASTDEL")),2)>3600 D  Q
 . . S HLPTRFLR("LASTDEL")=$H    ; maintain queue sizes
 . . D DELQUE(.HLPTRFLR,.HLEXIT) ; no more than once an hour.
 . ; patch HL*1.6*122
 . ; H 5
 . H 1
 . D CHKUPD(.HLPTRFLR,.HLEXIT) Q:HLEXIT
 S ZTSTOP=1 ;Asked to stop
 D DELFLR^HLCSUTL1(HLPTRFLR,"IN") ;Delete entry denoting this filer
 S ZTREQ="@"
 Q
DEFACK(HLPTRFLR,HLFLG,HLEXIT) ; Process TCP links with a deferred response
 N HLXX,HLD0,HLPCT
 S HLXX=0
 F  S HLXX=$O(^HLMA("AC","I",HLXX)) Q:'HLXX  D  Q:HLEXIT
 . ; HL*1.6*122, check the in-queue stop flag
 . Q:$P($G(^HLCS(870,HLXX,0)),"^",9)
 . D CHKUPD(.HLPTRFLR,.HLEXIT) Q:HLEXIT
 . ; patch HL*1.6*109: Does another filer have this?
 . ; L +^HLMA("AC","I",HLXX):0 Q:'$T
 . ; patch HL*1.6*140 - change the lock node, it conflicts with
 . ; lock defined in routine, HLCSREP.
 . ; L +^HLMA("AC","I",HLXX):2 Q:'$T  ; patch HL*1.6*122
 . L +^HLMA("IN-FILER","AC","I",HLXX):0 Q:'$T  ; patch HL*1.6*122
 . S HLD0=0,HLFLG=1
 . ; HL*1.6*109 changes in for loop below, and post-quit code placed
 . ; on following lines.
 . S HLPCT=0 ; Counter whether filer should stop every 100th entry.
 .;**109 - insure queue last processed at least 2 seconds ago
 . ; patch HL*1.6*140
 . ; I ($$HDIFF^XLFDT($H,$G(^XTMP("HL7-AC","I",HLXX)),2)<2) L -^HLMA("AC","I",HLXX) Q
 . I ($$HDIFF^XLFDT($H,$G(^XTMP("HL7-AC","I",HLXX)),2)<2) L -^HLMA("IN-FILER","AC","I",HLXX) Q
 . F  S HLD0=$O(^HLMA("AC","I",HLXX,HLD0)) Q:'HLD0!(HLEXIT)  D
 .. ; patch HL*1.6*122 start
 .. ; patch HL*1.6*122 TEST v2: DUZ code removed
 .. ; DUZ comparison/reset for application proxy user
 .. ;; D HLDUZ^HLCSTCP4
 .. D HLDUZ2^HLCSTCP4
 .. ; protect HLDUZ
 .. N HLDUZ
 .. S HLPCT=HLPCT+1
 .. I '(HLPCT#100) D CHKUPD(.HLPTRFLR,.HLEXIT) Q:HLEXIT
 .. ; L +^HLMA(HLD0):0 Q:'$T
 .. F  L +^HLMA(HLD0):30 Q:$T  H 1
 .. I '$$CHECKAC("I",HLXX,HLD0) L -^HLMA(HLD0) Q  ;-> Quit if not a valid AC xref
 .. D DEFACK^HLTP3(HLXX,HLD0)
 .. D DEQUE^HLCSREP(HLXX,"I",HLD0)
 .. L -^HLMA(HLD0)
 .. ; patch HL*1.6*145
 .. ; increment counter after message has been processed.
 .. D LLCNT^HLCSTCP(HLXX,2)
 . ; patch HL*1.6*122 end
 . ;**109 -add dt/tm stamp to time queue last processed
 . S ^XTMP("HL7-AC","I",HLXX)=$H
 . ;**109 -unlock the queue
 . ; patch HL*1.6*140
 . ; L -^HLMA("AC","I",HLXX)
 . L -^HLMA("IN-FILER","AC","I",HLXX)
 Q
 ;
CHECKAC(WAY,IEN870,IEN773) ; If AC xref shouldn't exist, kill it...
 ;
 ; Check status and if 3 (processed) kill XREF...
 I $P($G(^HLMA(+IEN773,"P")),U)=3 D  QUIT "" ;->
 .  D DEQUE^HLCSREP(IEN870,WAY,IEN773)
 ;
 ; Add other checks here in the future...
 ;
 Q 1
 ;
ACKNOW(HLPTRFLR,HLFLG,HLEXIT) ; Process Logical Link's IN-queue for received message
 N HLXX,HLD0,HLD1
 S HLXX=0
 F  S HLXX=$O(^HLCS(870,"AISTAT","P",HLXX)) Q:'HLXX  D  Q:HLEXIT
 . ; HL*1.6*122, check the in-queue stop flag
 . Q:$P($G(^HLCS(870,HLXX,0)),"^",9)
 . D CHKUPD(.HLPTRFLR,.HLEXIT) Q:HLEXIT
 . ; HL*1.6*109: Does another filer have this?
 . ; L +^HLCS(870,HLXX,"INFILER"):0 Q:'$T
 . L +^HLCS(870,HLXX,"INFILER"):2 Q:'$T  ; patch HL*1.6*122
 . F  D CHKUPD(.HLPTRFLR,.HLEXIT) Q:HLEXIT  S HLD0=$$DEQUEUE^HLCSQUE(HLXX,"IN") Q:+HLD0<0  D
 .. ;
 .. ; patch HL*1.6*122 start
 .. ; clean variables except Kernel related variables
 .. D
 ... ; protect variables defined in STARTIN^HLCSIN
 ... N HLFLG,HLEXIT,HLPTRFLR
 ... N HLDUZ
 ... ; protect variables defined in ACKNOW^HLCSIN
 ... N HLXX,HLD0,HLD1
 ... D KILL^XUSCLEAN
 .. ;
 .. ; patch HL*1.6*122 TEST v2: DUZ code removed
 .. ; DUZ comparison/reset for application proxy user
 .. ;; D HLDUZ^HLCSTCP4
 .. D HLDUZ2^HLCSTCP4
 .. ; protect HLDUZ
 .. N HLDUZ
 .. ;Make sure message is ready to be received
 .. S HLFLG=1
 .. S HLD1=$P(HLD0,"^",2)
 .. S HLD0=+HLD0 ; At this point, HLD0=HLXX
 .. I $P($G(^HLCS(870,HLD0,1,HLD1,0)),"^",3)'="A" D  Q
 ... D MONITOR^HLCSDR2("D",2,HLD0,HLD1,"IN") ;Set status to DONE
 .. D RECEIVE^HLMA0(HLD0,HLD1) ;Process received message
 .. D MONITOR^HLCSDR2("D",2,HLD0,HLD1,"IN") ;Set status to DONE
 . ; patch HL*1.6*122 end
 . I HLD0<0,$D(^HLCS(870,"AISTAT","P",HLXX)) D
 . . S HLD1=0 ; Make sure there aren't any loose xrefs hanging around.
 . . F  S HLD1=$O(^HLCS(870,"AISTAT","P",HLXX,HLD1)) Q:'HLD1  D
 . . . ;I '$D(^HLCS(870,HLXX,1,HLD1,0)) K ^HLCS(870,"AISTAT","P",HLXX,HLD1)
 . . . I $P($G(^HLCS(870,HLXX,1,HLD1,0)),U,2)'="P" K ^HLCS(870,"AISTAT","P",HLXX,HLD1)
 . L -^HLCS(870,HLXX,"INFILER")
 Q
DELQUE(HLPTRFLR,HLEXIT) ; Delete messages outside the 'queue size' window.
 N HLDIR,HLXX,HLFRONT
 S HLDIR=1,HLXX=0
 F  S HLXX=$O(^HLCS(870,HLXX)) Q:'HLXX  D  Q:HLEXIT
 . D CHKUPD(.HLPTRFLR,.HLEXIT) Q:HLEXIT
 . ; patch HL*1.6*122, comment out, no need to lock
 . ; L +^HLCS(870,HLXX,"IN QUEUE FRONT POINTER"):0 Q:'$T
 . S HLFRONT=$G(^HLCS(870,HLXX,"IN QUEUE FRONT POINTER"))
 . ; patch HL*1.6*122, comment out
 . ; L -^HLCS(870,HLXX,"IN QUEUE FRONT POINTER")
 . D DELETE^HLCSQUE1(HLXX,HLDIR,HLFRONT)
 Q
CHKUPD(HLPTRFLR,HLEXIT) ;
 Q:$$HDIFF^XLFDT($H,$G(HLPTRFLR("LASTUP")),2)<15
 D SETFLRDH^HLCSUTL1(HLPTRFLR,"IN") ; Update LAST KNOWN $H (field #.03) for filer
 S HLPTRFLR("LASTUP")=$H
 D CHK4STOP^HLCSUTL2(HLPTRFLR,"IN",.HLEXIT) Q:HLEXIT
 Q
