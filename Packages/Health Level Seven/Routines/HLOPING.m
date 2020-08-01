HLOPING ;alb/cjm HLO PING UTILITY;Apr 03, 2020@14:49
 ;;1.6;HEALTH LEVEL SEVEN;**147,155,158,10001**;Oct 13, 1995;Build 3
 ; Original code in the public domain by Dept of Veterans Affairs.
 ; Changes **10001** by Sam Habiel (c) 2020.
 ; Changes indicated inline.
 ; Licensed under Apache 2.0.
 ;
 ;
PING ;
 I '$G(DUZ) W !,"Your DUZ must be set!" Q
 N LINK,CONF,HLCSTATE,PORT,LINK,HLODONE
 S HLODONE=0
 ; *10001*
 N CACHE,GTM
 S CACHE=^%ZOSF("OS")["OpenM"
 S GTM=^%ZOSF("OS")["GT.M"
 I 'CACHE,'GTM D  Q
 .W !!,"   Sorry, this tool can only be used under Cache or GT.M",!!
 ; *10001*
 ;
 W !,"What HL Logical Link do you want to test?"
 S LINK=$$ASKLINK^HLOUSR
 Q:LINK=""
 I $$NOPING(LINK) W !,"That link does not allowing PINGING!" D PAUSE^VALM1 Q
 S PORT=$$ASKPORT(LINK)
 Q:'PORT
 L +^HLB("QUEUE","OUT",LINK_":"_PORT,"HLOPING"_$J):1
 D STOPQUE^HLOQUE("OUT","HLOPING"_$J)
 D BREAKS
 D CHECKAPP
 I $$ADDMSG(LINK) D
 .; ZB /INTERRUPT:NORMAL ;disable CTRL-C breaks ; 10001 don't need this
 .S WORK("QUEUE")="HLOPING"_$J,WORK("LINK")=LINK_":"_PORT
 .D DOWORK^HLOCLNT(.WORK)
 .D:$G(HLCSTATE("CONNECTED")) CLOSE^HLOT(.HLCSTATE)
 .;
 .U $PRINCIPAL
 D PURGE(LINK_":"_PORT)
 D CBREAK ; *10001*
 L -^HLB("QUEUE","OUT",LINK_":"_PORT,"HLOPING"_$J)
 D STARTQUE^HLOQUE("OUT","HLOPING"_$J)
 Q
 ;
SBREAK(EP,ACTION) ; *10001*
 I ^%ZOSF("OS")["OpenM" ZB @EP:"N":1:ACTION
 I ^%ZOSF("OS")["GT.M"  ZB @(EP_":"""_$$CONVQQ^DILIBF(ACTION)_"""")
 QUIT
 ;
CBREAK ; Clear Breaks *10001*
 I ^%ZOSF("OS")["OpenM" ZB /CLEAR
 I ^%ZOSF("OS")["GT.M"  ZB -*
 QUIT
 ;
NOPING(LINK) ;
 N IEN,RETURN
 S RETURN=1
 S IEN=$O(^HLCS(870,"B",LINK,0))
 I IEN S RETURN=$P($G(^HLCS(870,IEN,0)),"^",24)
 Q RETURN
 ;
ASKPORT(LINK) ;
 N IEN,NODE,HLOPORT,HL7PORT,DIR,X,Y
 S IEN=$O(^HLCS(870,"B",LINK,0))
 Q:'IEN ""
 S NODE=$G(^HLCS(870,IEN,400))
 S HLOPORT=$P(NODE,"^",8)
 S:'HLOPORT HLOPORT=$S($P($G(^HLD(779.1,1,0)),"^",3)="P":5001,1:5026)
 S HL7PORT=$P(NODE,"^",2)
 S:'HL7PORT HL7PORT=$S($P($G(^HLD(779.1,1,0)),"^",3)="P":5000,1:5025)
 W !,"Do you want to PING the port used by HLO or the one used by HL7 1.6?"
 S DIR(0)="S^1:HLO     --> Port #"_HLOPORT_";2:HL7 1.6 --> Port #"_HL7PORT
 S DIR("B")=1
 D ^DIR
 Q:'X ""
 Q:$D(DUOUT) ""
 Q:X=1 HLOPORT
 Q:X=2 HL7PORT
 Q ""
ADDMSG(LINK) ;
 N PARMS,MSG,SEG,ERROR
 S PARMS("MESSAGE TYPE")="ZZZ"
 S PARMS("EVENT")="ZZZ"
 I '$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERROR) W !,"ERROR",ERROR Q 0
 D SET^HLOAPI(.SEG,"NTE",0)
 D SET^HLOAPI(.SEG,"This is a PING message to test connectivity. Sender DUZ: "_$G(DUZ),1)
 I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) W !,"ERROR",ERROR Q 0
 S PARMS("SENDING APPLICATION")="HLO PING CLIENT",WHOTO("RECEIVING APPLICATION")="HLO PING SERVER",WHOTO("FACILITY LINK NAME")=LINK
 S PARMS("ACCEPT ACK TYPE")="AL"
 S PARMS("APP ACK TYPE")="NE"
 S PARMS("QUEUE")="HLOPING"_$J
 I '$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR) W !,"There is a problem in the setup!",!,ERROR Q 0
 Q 1
 ;
PURGE(LINK) ;
 N IEN
 S IEN=0
 F  S IEN=$O(^HLB("QUEUE","OUT",LINK,"HLOPING"_$J,IEN)) Q:'IEN  D DEQUE^HLOQUE(LINK,"HLOPING"_$J,"OUT",IEN),SETPURGE^HLOUSR7(IEN)
 Q
 ;
BREAKS ; *10001* refactored to not use ZB but call SBREAK
 D CBREAK
 D SBREAK("SEND^HLOAPI1","S HLMSTATE(""STATUS"",""PORT"")="_PORT)
 D SBREAK("CHECKWHO^HLOASUB1","S WHO(""PORT"")="_PORT)
 D SBREAK("ZB25^HLOASUB1","D ZB25^HLOPING")
 ;set break in $$STOPPED^HLOQUE to circumvent shutdown of the queue
 D SBREAK("ZB0^HLOQUE","S RET=0")
 ;set break in $$IFSHUT^HLOTLNK to circumvent shutdown of the link
 D SBREAK("ZB0^HLOTLNK","S RET=0")
 ;set break at ZB1 in client ($$CONNECT)
 ;
 D SBREAK("ZB1^HLOCLNT1","D WRITE^HLOPING(""Trying to connect..."")")
 ;
 ;set break at ZB2 in client (end of $$CONNECT)
 D SBREAK("ZB2^HLOCLNT1","D ZB2^HLOPING")
 ;
 ;set break at ZB6 in client (start of $$TRANSMIT^HLOCLNT1)
 D SBREAK("ZB6^HLOCLNT1","D WRITE^HLOPING(""Sending PING ..."")")
 ;set break at ZB7 in client (end of $$TRANSMIT^HLOCLNT1)
 D SBREAK("ZB7^HLOCLNT1","D WRITE^HLOPING(""PING sent!"")")
 ;set break at ZB8 in client (start of $$READACK^HLOCLNT1)
 D SBREAK("ZB8^HLOCLNT1","D WRITE^HLOPING(""Reading acknowledgment...."")")
 ;set break at ZB9 in client (end of $$READACK^HLOCLNT1)
 ;
 D SBREAK("ZB9^HLOCLNT1","D ZB9^HLOPING")
 ;
 ;set break at ZB4 in client (FOR loop on the outgoing queue)
 D SBREAK("ZB4^HLOCLNT","S SUCCESS=0 I 'HLODONE S (SUCCESS,HLODONE)=1")
 ;
 ;set status to SU so that the PING doesn't appear on the error report
 D SBREAK("ZB22^HLOCLNT","S $P(UPDATE,""^"",3)=""SU"",$P(UPDATE,""^"",4)=1")
 ;
 D SBREAK("ZB24^HLOCLNT1","D ZB24^HLOPING")
 D SBREAK("ZB27^HLOT","D ZB27^HLOPING")
 ;
 ;set break at ZB3 in client (ERROR TRAP)
 D SBREAK("ZB3^HLOCLNT","D ZB3^HLOPING")
 Q
 ;
CHECKAPP ;
 I '$O(^HLD(779.2,"C","HLO PING CLIENT",0)) D
 .N DATA,ERROR
 .S DATA(.01)="HLO PING CLIENT"
 .D ADD^HLOASUB1(779.2,,.DATA)
 Q
WRITE(MSG) ;
 N OLD
 S OLD=$IO
 U $PRINCIPAL
 W !,MSG
 U OLD
 Q
ZB2 ;
 D WRITE($S('HLCSTATE("CONNECTED"):"Unable to Connect!",1:"Connected!"))
 ;!!!!!!!!!!!!
 ;F I=1:1:15 H 1
 Q
ZB3 ;
 N CON,MSG
 I ^%ZOSF("OS")["OpenM" S CON=($ZA\8192#2) ; *10001*
 I ^%ZOSF("OS")["GT.M"  S CON=$KEY["ESTABLISHED" ; *10001*
 S MSG="Error encountered, $ECODE="_$ECODE
 D WRITE(MSG)
 S MSG=$S(CON:"           TCP connection still active",1:"          TCP connection was dropped")
 D WRITE(MSG)
 D ^%ZTER
 Q
ZB9 ;
 I $G(SUCCESS) D
 .D WRITE("Acknowledgment received!")
 E  D
 .D WRITE("Acknowledgment NOT returned!")
 ;!!!!!!!!!!!!
 ;H 50
 Q
ZB24 ;
 S HLCSTATE("LINK","SHUTDOWN")=0
 Q
ZB25 ;
 I '$L(PARMS("RECEIVING FACILITY",2)),'PARMS("RECEIVING FACILITY",1) S PARMS("RECEIVING FACILITY",2)="REMOTE FACILITY TO PING"
 Q
 ;
ZB27 ;
 Q:'$G(HLCSTATE("LOCK FAILED"))
 D WRITE("Remote server is single threaded and is locked by another process!")
 Q
