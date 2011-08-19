HLOPING ;alb/cjm HLO PING UTILITY - 10/4/94 1pm ;01/27/2010
 ;;1.6;HEALTH LEVEL SEVEN;**147**;Oct 13, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
PING ;
 I '$G(DUZ) W !,"Your DUZ must be set!" Q
 N LINK,CONF,HLCSTATE,PORT,LINK,HLODONE
 S HLODONE=0
 I $P($$VERSION^%ZOSV(1),"/",1)'["Cache" D  Q
 .W !!,"   Sorry, this tool can only be used under Cache",!!
 W !,"What HL Logical Link do you want to test?"
 S LINK=$$ASKLINK^HLOUSR
 Q:LINK=""
 S PORT=$$ASKPORT(LINK)
 Q:'PORT
 L +^HLB("QUEUE","OUT",LINK_":"_PORT,"HLOPING"_$J):1
 D STOPQUE^HLOQUE("OUT","HLOPING"_$J)
 D BREAKS
 D CHECKAPP
 I $$ADDMSG(LINK) D
 .ZB /INTERRUPT:NORMAL ;disable CTRL-C breaks
 .S WORK("QUEUE")="HLOPING"_$J,WORK("LINK")=LINK_":"_PORT
 .D DOWORK^HLOCLNT(.WORK)
 .D:$G(HLCSTATE("CONNECTED")) CLOSE^HLOT(.HLCSTATE)
 .;
 .U $PRINCIPAL
 D PURGE(LINK_":"_PORT)
 ZB /CLEAR
 L -^HLB("QUEUE","OUT",LINK_":"_PORT,"HLOPING"_$J)
 D STARTQUE^HLOQUE("OUT","HLOPING"_$J)
 Q
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
 D SET^HLOAPI(.SEG,"This is a PING message to test connectivity.",1)
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
 F  S IEN=$O(^HLB("QUEUE","OUT",LINK,"HLOPING"_$J,IEN)) Q:'IEN  D DEQUE^HLOQUE(LINK,"HLOPING"_$J,"OUT",IEN),SETPURGE^HLOAPI3(IEN)
 Q
 ;
BREAKS ;
 ZB /CLEAR
 ;
 ZB SEND^HLOAPI1:"N":1:"S HLMSTATE(""STATUS"",""PORT"")="_PORT
 ZB CHECKWHO^HLOASUB1:"N":1:"S WHO(""PORT"")="_PORT
 ZB ZB25^HLOASUB1:"N":1:"D ZB25^HLOPING"
 ;set break in $$STOPPED^HLOQUE to circumvent shutdown of the queue
 ZB ZB0^HLOQUE:"N":1:"S RET=0"
 ;set break in $$IFSHUT^HLOTLNK to circumvent shutdown of the link
 ZB ZB0^HLOTLNK:"N":1:"S RET=0"
 ;set break at ZB1 in client ($$CONNECT)
 ZB ZB1^HLOCLNT1:"N":1:"D WRITE^HLOPING(""Trying to connect..."")"
 ;set break at ZB2 in client (end of $$CONNECT)
 ZB ZB2^HLOCLNT1:"N":1:"D ZB2^HLOPING"
 ;
 ;set break at ZB6 in client (start of $$TRANSMIT^HLOCLNT1)
 ZB ZB6^HLOCLNT1:"N":1:"D WRITE^HLOPING(""Sending PING ..."")"
 ;set break at ZB7 in client (end of $$TRANSMIT^HLOCLNT1)
 ZB ZB7^HLOCLNT1:"N":1:"D WRITE^HLOPING(""PING sent!"")"
 ;set break at ZB8 in client (start of $$READACK^HLOCLNT1)
 ZB ZB8^HLOCLNT1:"N":1:"D WRITE^HLOPING(""Reading acknowledgment...."")"
 ;set break at ZB9 in client (end of $$READACK^HLOCLNT1)
 ZB ZB9^HLOCLNT1:"N":1:"D ZB9^HLOPING"
 ;
 ;set break at ZB4 in client (FOR loop on the outgoing queue)
 ZB ZB4^HLOCLNT:"N":1:"S SUCCESS=0 I 'HLODONE S (SUCCESS,HLODONE)=1"
 ;
 ;set status to SU so that the PING doesn't appear on the error report
 ZB ZB22^HLOCLNT:"N":1:"S $P(UPDATE,""^"",3)=""SU"",$P(UPDATE,""^"",4)=1"
 ;
 ZB ZB24^HLOCLNT1:"N":1:"D ZB24^HLOPING"
 ;set break at ZB3 in client (ERROR TRAP)
 ZB ZB3^HLOCLNT:"N":1:"D ZB3^HLOPING"
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
 Q
ZB3 ;
 N CON,MSG
 S CON=($ZA\8192#2)
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
 Q
ZB24 ;
 S HLCSTATE("LINK","SHUTDOWN")=0
 Q
ZB25 ;
 I '$L(PARMS("RECEIVING FACILITY",2)),'PARMS("RECEIVING FACILITY",1) S PARMS("RECEIVING FACILITY",2)="REMOTE FACILITY TO PING"
 Q
