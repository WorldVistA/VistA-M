IBTRHLI ;ALB/JWS - Receive and store 278 Response message ;05-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; This is the entry point for receiving a 278 Response Message
 ; Starting point - put message into a TMP global
 N EVENT,HLFS,IBPRTCL,SEGMT,TAG,CNT,SEGCNT,HLNODE
 ; EXPECTS HLMTIEN=entry in file 772 ^HL(772) HL7 MESSAGE TEXT
 ; ALSO HLNEXT = "D HLNEXT^HLCSUTL"
 ; ALSO HLQUIT = "" OR 0
 ; ALSO HLNODE is = data string of HL7 segment, set in HLNEXT^HLCSUTL
 K ^TMP($J,"IBTRHLI")
 F SEGCNT=1:1 X HLNEXT Q:'HLQUIT  D
 . S CNT=0
 . S ^TMP($J,"IBTRHLI",SEGCNT,CNT)=HLNODE
 . I SEGCNT=1 S SEGMT=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 .. S ^TMP($J,"IBTRHLI",SEGCNT,CNT)=HLNODE(CNT)
 .. I SEGCNT=1 S SEGMT=$G(SEGMT)_HLNODE(CNT)
 . Q 
 S HLFS=$E(SEGMT,4)
 S EVENT=$P(SEGMT,HLFS,9),IBPRTCL=""
 ;  Determine which protocol to use
 ;  The event type determines protocol
 I EVENT="RPA^I08" S TAG="RSP",IBPRTCL="IBTR HCSR IN"
 I IBPRTCL="" G XIT
 ;  Initialize the HL7 variables
 D INIT^HLFNC2(IBPRTCL,.HL)
 ;  Call the event tag
 D @TAG
 ;
XIT ;
 K ^TMP($J,"IBTRHLI"),HL,HLNEXT,HLNODE,HLQUIT
 Q
 ;
RSP ;  Response Processing
 D EN^IBTRHLI1
 K ^TMP($J,"IBTRHLI"),HL,HLNEXT,HLNODE,HLQUIT
 Q
 ;
TEST ;
 S $ET="D ^%ZTER"
 R !,"HLMTIEN= ",HLMTIEN:120 Q:HLMTIEN=""
 S HLQUIT=0
 S HLNEXT="D HLNEXT^HLCSUTL"
 G EN
