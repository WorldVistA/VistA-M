HLCSOUT ;ALB/JRP/CJM - OUTGOING FILER;2/25/97 ;03/07/2011
 ;;1.6;HEALTH LEVEL SEVEN;**25,30,62,153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
STARTOUT ;Main entry point for outgoing background filer
 ;Create/find entry denoting this filer in the OUTGOING FILER TASK
 ; NUMBER multiple (field #30) of the HL COMMUNICATION SERVER PARAMETER
 ; file (#869.3)
 ;N TMP ; These vbls are not used!
 N HLPTRFLR,HLPTRLL,HLCSLOOP,HLEXIT,HLXX,HLNODE,HLOGLINK,HLPARENT
 N HLHDRBLD,HLERROR,HLHDR,HLD0,HLD1,HLST1
 S HLPTRFLR=+$$CRTFLR^HLCSUTL1(ZTSK,"OUT")
 ;Check if any outgoing messages are in the pending transmission queue
 ;
 S (HLPTRLL,HLCSLOOP,HLEXIT)=0
 F  S HLPTRLL=+$O(^HL(772,"A-XMIT-OUT",HLPTRLL)) D  Q:HLEXIT
 . D CHK4STOP^HLCSUTL2(HLPTRFLR,"OUT",.HLEXIT) Q:HLEXIT
 . ;Update LAST KNOWN $H (field #.03) for filer every 200th iteration
 . D:'(HLCSLOOP#200) SETFLRDH^HLCSUTL1(HLPTRFLR,"OUT")
 . ;Increment loop counter (reset to 0 when greater than 1000)
 . S HLCSLOOP=HLCSLOOP+1 S:HLCSLOOP>1000 HLCSLOOP=0
 . I 'HLPTRLL H 1 Q
 .;
 .;**P153 CJM START
 .L +^HLCS(870,HLPTRLL,"OUT","OUTFILER"):1
 .Q:'$T
 .D
 ..;**P153 END CJM
 ..;
 .. S HLXX=+$O(^HL(772,"A-XMIT-OUT",HLPTRLL,0)) ;Pending messages?
 .. I 'HLXX H 1 Q  ;No pending messages
 .. L +^HL(772,HLXX,0):1 I ('$T) H 1 Q  ;Lock main node of Message Text
 .. ;Make sure status hasn't changed
 .. I '$D(^HL(772,"AF",1,HLXX)) L -^HL(772,HLXX,0) Q
 .. ;Get Logical Link and parent message
 .. ; Set status to ERROR DURING TRANSMISSION if not present
 .. S HLNODE=^HL(772,HLXX,0)
 .. S HLOGLINK=$P(HLNODE,"^",11)
 .. I HLOGLINK'>0 D  Q
 .. . D STATUS^HLTF0(HLXX,4,"","Logical Link not available")
 .. . L -^HL(772,HLXX,0)
 .. S HLPARENT=$P(HLNODE,"^",8)
 .. I HLPARENT'>0!'$G(^HL(772,HLPARENT,0)) D  Q
 .. . D STATUS^HLTF0(HLXX,4,"","Parent Message not available")
 .. . L -^HL(772,HLXX,0)
 .. ;Build message header or batch header
 .. S HLHDRBLD=$P(^HL(772,HLPARENT,0),U,14)
 .. I "^B^M^F^"'[(U_HLHDRBLD_U) D  Q
 .. . D STATUS^HLTF0(HLXX,4,"","Message Type (field #772,14) Error")
 .. . L -^HL(772,HLXX,0)
 .. S HLERROR=""
 .. I HLHDRBLD="M" D HEADER^HLCSHDR(HLXX,.HLERROR)
 .. I HLHDRBLD'="M" D BHSHDR^HLCSHDR(HLXX) S:$E(HLHDR(1),1,2)="-1" HLERROR=$P(HLHDR(1),"^",2)
 .. ;If error set status ERROR DURING TRANSMISSION
 .. I $G(HLERROR)'="" D STATUS^HLTF0(HLXX,4) L -^HL(772,HLXX,0) Q
 .. S HLD0=$$ENQUEUE^HLCSQUE(HLOGLINK,"OUT")
 .. ;If error set status ERROR DURING TRANSMISSION
 .. I +HLD0<0 D STATUS^HLTF0(HLXX,4) L -^HL(772,HLXX,0) Q
 .. S HLD1=$P(HLD0,"^",2)
 .. S HLD0=+HLD0
 .. ;Move Message Header and Message Text to file 870
 .. D MERGEOUT^HLTF2(HLPARENT,HLD0,HLD1,"HLHDR")
 .. K HLHDR
 .. D MONITOR^HLCSDR2("P",2,HLD0,HLD1,"OUT") ;Status in queue to "PENDING"
 .. ;Determine status, default to "Awaiting Ack"
 .. S HLST1=$$FNDSTAT^HLUTIL3(HLXX) S:'HLST1 HLST1=2
 .. D STATUS^HLTF0(HLXX,HLST1) ;Update status
 .. L -^HL(772,HLXX,0) ;Unlock main node of Message Text
 .. ;Update LAST KNOWN $H (field #.03) for filer
 .. D SETFLRDH^HLCSUTL1(HLPTRFLR,"OUT")
 .;P153 START CJM
 .L -^HLCS(870,HLPTRLL,"OUT","OUTFILER")
 .;P153 END CJM
 S ZTSTOP=1 ;Asked to stop
 D DELFLR^HLCSUTL1(HLPTRFLR,"OUT") ;Delete entry denoting this filer
 S ZTREQ="@"
 Q
