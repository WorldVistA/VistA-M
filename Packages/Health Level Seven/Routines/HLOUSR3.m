HLOUSR3 ;ALB/CJM/RBN -ListManager Screen for viewing messages(continued);12 JUN 1997 10:00 am ;03/26/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,134,138,139,147,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN ; Main entry point.
 N HLPARMS
 D FULL^VALM1
 I '$$ASK(.HLPARMS) S VALMBCK="R" Q
 D WAIT^DICD
 D EN^VALM("HLO MESSAGE SEARCH")
 Q
SEARCH ; Find a message.
 N I,APP,START,END,DIR,MSG,EVENT,TIME
 D EXIT
 S I=""
 F  S I=$O(HLPARMS(I)) Q:I=""  S @I=HLPARMS(I)
 K HLPARMS
 S (VALMCNT,I)=0
 S TIME=START
 F  S TIME=$O(^HLB("SEARCH",DIR,TIME)) Q:'TIME  Q:TIME>END  Q:VALMCNT>MAX  D
 .N SAPP S SAPP=""
 .S:APP'="" SAPP=$O(^HLB("SEARCH",DIR,TIME,APP),-1)
 .F  S SAPP=$O(^HLB("SEARCH",DIR,TIME,SAPP)) Q:SAPP=""  Q:$E(SAPP,1,$L(APP))]APP  Q:VALMCNT>MAX  D:$E(SAPP,1,$L(APP))=APP
 ..N SMSG S SMSG=""
 ..S:MSG'="" SMSG=$O(^HLB("SEARCH",DIR,TIME,SAPP,MSG),-1)
 ..F  S SMSG=$O(^HLB("SEARCH",DIR,TIME,SAPP,SMSG)) Q:SMSG=""  Q:$E(SMSG,1,$L(MSG))]MSG  Q:VALMCNT>MAX  D:$E(SMSG,1,$L(MSG))=MSG
 ...N SEVENT S SEVENT=""
 ...S:EVENT'="" SEVENT=$O(^HLB("SEARCH",DIR,TIME,SAPP,SMSG,EVENT),-1)
 ...F  S SEVENT=$O(^HLB("SEARCH",DIR,TIME,SAPP,SMSG,SEVENT)) Q:SEVENT=""  Q:$E(SEVENT,1,$L(EVENT))]EVENT  Q:VALMCNT>MAX  D:$E(SEVENT,1,$L(EVENT))=EVENT
 ....N IEN
 ....S IEN=""
 ....F  S IEN=$O(^HLB("SEARCH",DIR,TIME,SAPP,SMSG,SEVENT,IEN)) Q:IEN=""  Q:VALMCNT>MAX  D ADDTO(DIR,TIME,SAPP,SMSG,SEVENT,IEN)
 ;
 ;
END ; Return to List Manager.
 S VALMBCK="R"
 ;
 Q
ADDTO(DIR,TIME,APP,MSG,EVENT,IEN) ; Add message to queue.
 N HDR,FS,LOC,MSGID
 S MSGID=$S($P(IEN,"^",2):$P($G(^HLB(+IEN,3,$P(IEN,"^",2),0)),"^",2),1:$P($G(^HLB(IEN,0)),"^",1))
 S HDR=$G(^HLB(+IEN,1))
 S FS=$E(HDR,4)
 I FS'="" D
 .I DIR="IN" S LOC=$P(HDR,FS,4)
 .I DIR'="IN" S LOC=$P(HDR,FS,6)
 E  S LOC=""
 S @VALMAR@($$I,0)=$$LJ(MSGID,25)_$$LJ(APP,30)_" "_MSG_"~"_EVENT
 D CNTRL^VALM10(VALMCNT,1,25,IOINHI,IOINORM)
 S @VALMAR@($$I,0)="     "_$$LJ($$FMTE^XLFDT(TIME,2),20)_$$LJ(LOC,60)
 S @VALMAR@($$I,0)=""
 Q
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR(STRING,LEN)
 ;
I() ;
 S VALMCNT=VALMCNT+1
 Q VALMCNT
 ;
ASK(PARMS) ; Ask for parameter values.
 N SUB
 F SUB="START","END","EVENT","APP","MSG","DIR" S PARMS(SUB)=""
 S PARMS("START")=$$ASKBEGIN^HLOUSR2()
 Q:'PARMS("START") 0
 S PARMS("END")=$$ASKEND^HLOUSR2(PARMS("START"))
 Q:'PARMS("END") 0
 S PARMS("APP")=$$ASKAPP()
 Q:PARMS("APP")=-1 0
 S PARMS("MSG")=$$ASKMSG()
 Q:PARMS("MSG")=-1 0
 S PARMS("EVENT")=$$ASKEVENT()
 Q:PARMS("EVENT")=-1 0
 S PARMS("DIR")=$$ASKDIR()
 Q:PARMS("DIR")=-1 0
 ;** P139 START CJM
 S PARMS("DIR")=$S(PARMS("DIR")="I":"IN",PARMS("DIR")="i":"IN",1:"OUT")
 ;** P139 END CJM
 S PARMS("MAX")=$$ASKMAX()
 Q:'(PARMS("MAX")>-1) 0
 Q 1
 ;
ASKMAX() ; Ask for the maximum number of messages.
 N DIR
 S DIR(0)="N^1:30000:0"
 S DIR("A")="Maximum List Size"
 S DIR("B")=1000
 S DIR("?",1)="In case a large number of messages meet your search criteria, what are the"
 S DIR("?")="maximum number of messages to display? (30,000 maximum)"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q 3*(X-1)
ASKAPP() ; Ask for application name.
 N DIR
 S DIR(0)="FO^0:60"
 S DIR("A")="Application"
 S DIR("?",1)="Enter the name of the application, or '^' to exit."
 S DIR("?")="You can enter just the first part of the name."
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q X
ASKMSG() ;
 N DIR
 S DIR(0)="FO^0:3"
 S DIR("A")="HL7 Message Type"
 S DIR("?",1)="Enter the 3 character message type (e.g. MFN, ADT), or '^' to exit."
 S DIR("?")="You can enter just the first character or two."
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q X
ASKEVENT() ; Ask for event.
 N DIR
 S DIR(0)="FO^0:3"
 S DIR("A")="HL7 Event"
 S DIR("?",1)="Enter the 3 character event type, or '^' to exit."
 S DIR("?")="You can enter just the first character or two."
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q X
ASKDIR() ; Ask message direction
 N DIR
 S DIR(0)="S^I:INCOMING;O:OUTGOING"
 S DIR("A")="Incoming or Outgoing"
 S DIR("?",1)="Are you searching for an incoming message or an outgoing message?"
 S DIR("?")="You can enter '^' to exit"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q X
HDR ; Set the List Manager header
 S VALMHDR(1)="MsgID                    Application                    MsgType"
 Q
HLP ;
 Q
EXIT ; Clean up and exit back to List Manager
 D CLEAN^VALM10
 D CLEAR^VALM1
 S VALMBCK="R"
 Q
 ;
SETPURGE ; Set a message up for purging.
 N MSG,DIR
 S VALMBCK="R"
 Q:'$G(MSGIEN)
 Q:'$$GETMSG^HLOMSG(+MSGIEN,.MSG)
 I MSG("STATUS")="",'MSG("STATUS","PURGE") W !,"Can not set purge yet!" D PAUSE^VALM1 Q
 S DIR(0)="D^"_DT_":"_$$FMADD^XLFDT(DT,+45)_":E"
 S DIR("A")="When should the message be purged?"
 D ^DIR
 D:Y SETPURGE^HLOUSR7(+MSGIEN,Y),DISPLAY^HLOUSR1
 Q
SCREEN() ;  Screen for message purge status.
 N TRUE
 S TRUE=1
 I $P($G(X),"^",3)="SET PURGE" D  Q TRUE
 .N MSG
 .I '$G(MSGIEN) S TRUE=0 Q
 .I '$$GETMSG^HLOMSG(+MSGIEN,.MSG) S TRUE=0 Q
 .I MSG("STATUS")="",'MSG("STATUS","PURGE") S TRUE=0
 S:'TRUE VALMBCK="R"
 Q TRUE
 ;;**Start Patch HL*1.6.138 **
 ;;The following three subroutines have been added for HL*1.6*138 - RBN
 ;;
RESEND ; If outbound message has been sent, resends it.
 N CONF
 D OWNSKEY^XUSRB(.CONF,"HLOMGR",DUZ)
 I CONF(0)'=1 D  Q
 . W !,"**** You are not authorized to use this option ****" D PAUSE^VALM1 Q
 ;Q:$$VERIFY^HLOQUE1()=-1
 N MSG,DIR,ERROR,FLG,OLDIEN,SYS
 S OLDIEN=MSGIEN
 I $G(OPT1DIS) D  K OPT1DIS Q
 . W !,"Sorry that option is not available for this message." D PAUSE^VALM1 Q
 S VALMBCK="R"
 Q:'$G(MSGIEN)
 Q:'$$GETMSG^HLOMSG(+MSGIEN,.MSG)
 I MSG("DIRECTION")'="OUT" W !,"Message is not an outbound message" D PAUSE^VALM1 Q
 I MSG("STATUS")="",'MSG("DT/TM") W !,"Message has not been sent!" D PAUSE^VALM1 Q
 Q:'$$ASKYESNO^HLOUSR2("Are you SURE you want to resend MsgID: "_MSG("ID"),"NO")
 S MSGIEN=$$RESEND^HLOAPI3(+MSGIEN,.ERROR)
 I $G(ERROR) W ERROR D PAUSE^VALM1 Q
 W !,"The message has been copied to MsgID ",MSGIEN," which will be displayed next"
 I $$ASKYESNO^HLOUSR2("Do you want the original message purged?","NO") D
 . D SYSPARMS^HLOSITE(.SYS)
 . S HLOPURDT=$$FMADD^XLFDT($$NOW^XLFDT,SYS("ERROR PURGE"))
 . S FLG=$$SETPURGE^HLOUSR7(OLDIEN,HLOPURDT)
 S FLG=$$GETMSG^HLOMSG(+MSGIEN,.MSG)
 D DISPLAY^HLOUSR1
 Q
 ;
REPROC ; If inbound message has been processed, reprocesses it.
 N CONF
 D FULL^VALM1
 D OWNSKEY^XUSRB(.CONF,"HLOMGR",DUZ)
 I CONF(0)'=1 D  Q
 . W !,"**** You are not authorized to use this option ****" D PAUSE^VALM1 Q
 ;Q:$$VERIFY^HLOQUE1()=-1
 N MSG,DIR,ERROR,SYSPARM
 I $G(OPT2DIS) D  K OPT2DIS Q
 . W !,"Sorry that option is not available for this message." D PAUSE^VALM1 Q
 S VALMBCK="R"
 Q:'$G(MSGIEN)
 Q:'$$GETMSG^HLOMSG(+MSGIEN,.MSG)
 I MSG("DIRECTION")'="IN" W !,"Message is not an inbound message" D PAUSE^VALM1 Q
 I MSG("STATUS")="",'MSG("STATUS","APP HANDOFF") W !,"Message has not been processed" D PAUSE^VALM1 Q
 Q:'$$ASKYESNO^HLOUSR2("Are you SURE you want to reprocess MsgID: "_MSG("ID"),"NO")
 I '$$PROCNOW^HLOAPI3(+MSGIEN,"",.ERROR) W ERROR D PAUSE^VALM1 Q
 W !,"Done!  The message has been reprocessed by the application."
 S DIR(0)="D^"_DT_":"_$$FMADD^XLFDT(DT,+45)_":E"
 I '$$ASKYESNO^HLOUSR2("Do you want to purge the message?","NO") D
 . D SYSPARMS^HLOSITE(.SYSPARM)
 . S HLOPURDT=$$FMADD^XLFDT($$NOW^XLFDT,SYSPARM("ERROR PURGE"))
 . S FLG=$$SETPURGE^HLOUSR7(MSGIEN,HLOPURDT)
 Q
 ;
MSGPREP ; Enable or disable menu options
 N MSG,FDA,ERR
 D GETMSG^HLOMSG(MSGIEN,.MSG)
 I 'MSG("DT/TM") D            ; Message has not been sent/processed
 .  S (OPT1DIS,OPT2DIS)=1
 I MSG("DIRECTION")="OUT" D   ; Msg outbound and sent ; disable MP
 .  S OPT2DIS=1
 I MSG("DIRECTION")="IN" D    ; Msg inbound and sent ; disable MR
 .  S OPT1DIS=1
 S VALMBCK="R"
 Q
 ;;**End Patch HL*1.6*138 **
 ;
