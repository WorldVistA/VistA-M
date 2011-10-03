HLOSTRAC ;;OIFO-OAK/RBN/CJM ;02/22/2011
 ;;1.6;HEALTH LEVEL SEVEN;**146,147,153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;; HLO SERVER TRACE Tool
 ;; *** For troubleshooting HLO server issues ***
 ;;     The HLO server runs in the foreground and writes trace
 ;;     statements to the screen.
 ;; 
TRACE    ;
 N CONF,HLOTRACE
 S HLOTRACE("COUNT")=0
 S HLOTRACE("ERRORS")=0
 I '$G(DUZ) W !,"Your DUZ must be set!" Q
 D OWNSKEY^XUSRB(.CONF,"XUPROG",DUZ)
 I 'CONF(0) D  Q
 . W !!,"   Sorry, you are not authorized to use this tool.",!!
 I $P($$VERSION^%ZOSV(1),"/",1)'["Cache" D  Q
 . W !!,"   Sorry, this tool can only be used under Cache",!!
 N IEN,LINK,PORT
 S IEN=+$O(^HLD(779.1,0))
 D:IEN
 .S LINK=$P($G(^HLD(779.1,IEN,0)),"^",10)
 .S LINK=$P($G(^HLCS(870,LINK,0)),"^")
 S:'$L($G(LINK)) LINK="HLO DEFAULT LISTENER"
 W !,"What port do you want to listen on while in server trace mode?"
 W !,"The port must be free. If a server already has it opened then the"
 W !,"server needs to be stopped before starting in server trace mode."
 S PORT=$$ASKPORT^HLOUSRA(LINK)
 Q:'PORT
 D SETBREAKS
 ;
 ZB ZB999^HLOSRVR:"N":1:"S LINK(""PORT"")=PORT,LINK(""SERVER"")=""1^S"",LINK(""LLP"")=""TCP"""
 ;
 W !!,"Starting the server, hit the CTRL-C key to stop the server...",!!
READ D
 .N $ETRAP,$ESTACK
 .S $ETRAP="G ERROR^HLOSTRAC"
 .D SERVER^HLOSRVR(LINK)
 .U $PRINCIPAL
 .W !,"DONE!"
 ZB /CLEAR
 Q
 ;
SETBREAKS ;
 ZB /CLEAR
 ZB /INTERRUPT:NORMAL
 ;
 ;!!!! for debuggng only
 ;ZB ERROR^HLOSTRAC
 ;!!!!!!
 ;
 ;
 ;report errors
 ZB ZB1^HLOSRVR:"N":1:"S $ETRAP=""G ZB3^HLOSTRAC"""
 ;
 ;allow Server Trace tool to run even if HLO is shut down
 ZB ZB25^HLOPROC:"N":1:"S RET=0"
 ZB READMSG^HLOSRVR1:"N":1:"D READMSG^HLOSTRAC"
 ZB PARSEHDR^HLOPRS:"N":1:"D PARSEHDR^HLOSTRAC"
 ZB DUP^HLOSRVR1:"N":1:"D DUP^HLOSTRAC"
 ZB CLOSE^HLOT:"N":1:"D CLOSE^HLOSTRAC"
 ;set break ZB10 in the client(start of $$READHDR^HLOT)
 ZB ZB10^HLOT:"N":1:"D ZB10^HLOSTRAC"
 ;set break ZB11 in the client(end of $$READHDR^HLOT)
 ZB ZB11^HLOT:"N":1:"D ZB11^HLOSTRAC"
 ;set break ZB12 in the client(start of $$READSEG^HLOT)
 ZB ZB12^HLOT:"N":1:"D ZB12^HLOSTRAC"
 ;set break ZB13 in the client(end of $$READSEG^HLOT)
 ZB ZB13^HLOT:"N":1:"D ZB13^HLOSTRAC"
 ;set break ZB14 in the client(start of $$WRITESEG^HLOT)
 ZB ZB14^HLOT:"N":1:"D ZB14^HLOSTRAC"
 ;set break ZB15 in the client(end of $$WRITESEG^HLOT)
 ZB ZB15^HLOT:"N":1:"D ZB15^HLOSTRAC"
 ;set break ZB16 in the client(start of $$WRITEHDR^HLOT)
 ZB ZB16^HLOT:"N":1:"D ZB16^HLOSTRAC"
 ;set break ZB17 in the client(end of $$WRITEHDR^HLOT)
 ZB ZB17^HLOT:"N":1:"D ZB17^HLOSTRAC"
 ;set break ZB18 in the client(start of $$ENDMSG^HLOT)
 ZB ZB18^HLOT:"N":1:"D ZB18^HLOSTRAC"
 ;set break ZB19 in the server(end of $$ENDMSG^HLOT)
 ZB ZB19^HLOT:"N":1:"D ZB19^HLOSTRAC"
 ZB ZB25^HLOTCP:"N":1:"D ZB25^HLOSTRAC"
 ZB ZB26^HLOTCP:"N":1:"D ZB26^HLOSTRAC"
 ;
 ZB ZB27^HLOTCP:"N":1:"D ZB27^HLOSTRAC"
 ;
 ZB ZB28^HLOTCP:"N":1:"D ZB28^HLOSTRAC"
 ;set break ZB29 in the server(after parsing the message header)
 ZB ZB29^HLOSRVR1:"N":1:"D ZB29^HLOSTRAC"
 ;set break ZB30 in the server(afterchecking if duplicate)
 ZB ZB30^HLOSRVR1:"N":1:"D ZB30^HLOSTRAC"
 ZB ZB31^HLOTCP:"N":1:"D WRITE^HLOTRACE(""Beginning READ over TCP..."")"
 ZB ZB32^HLOTCP:"N":1:"D ZB32^HLOTRACE"
 Q
 ;
WRITE(MSG) ;
 N OLD
 S OLD=$IO
 U $PRINCIPAL
 W !,?5,"Time: ",$$NOW^XLFDT,"   ",MSG
 U OLD
 Q
WRITE2(MSG,VALUE) ;
 N OLD,I
 S OLD=$IO
 U $PRINCIPAL
 W !,?5,"Time: ",$$NOW^XLFDT,"   ",MSG
 S I=0
 W:$O(VALUE(0)) !
 F  S I=$O(VALUE(I)) Q:'I  W VALUE(I)
 U OLD
 Q
WRITE3(MSG) ;
 N OLD
 S OLD=$IO
 U $PRINCIPAL
 W !,MSG
 U OLD
 Q
READMSG ;
 ;
 S HLOTRACE("COUNT")=HLOTRACE("COUNT")+1
 S HLOTRACE("ERRORS")=0
 I HLOTRACE("COUNT")>10 D
 .N OLD,SEND
 .S OLD=$IO
 .U $PRINCIPAL
 .W !
 .S SEND=$$ASKYESNO^HLOUSR2("Do you want to trace more message transmissions","NO")
 .I 'SEND S $ECODE=",UHLOSTOP,"
 .U OLD
 W !
 D WRITE3^HLOSTRAC("Beginning to read next message...")
 Q
PARSEHDR ;
 D WRITE^HLOSTRAC("Parsing the message header...")
 Q
DUP ;
 D WRITE^HLOSTRAC("Checking if duplicate message...")
 Q
CLOSE ;
 D WRITE^HLOSTRAC("Closing the port...")
 Q
 ;
ERROR ;
 I ($ECODE["EDITED") Q:$QUIT "" Q
 I ($ECODE["ZINTERRUPT") Q:$QUIT "" Q
 D WRITE^HLOSTRAC("*** ERROR *** : "_$ECODE)
 S HLOTRACE("ERRORS")=HLOTRACE("ERRORS")+1
 I HLOTRACE("ERRORS")>5 Q:$QUIT "" Q
 S $ECODE=""
 G READ^HLOSTRAC
 Q:$QUIT "" Q
 Q
ZB10 ;
 D WRITE^HLOSTRAC("Getting message header...")
 Q
ZB11 I $D(HDR) D WRITE2^HLOSTRAC(" Header follows...",.HDR)
 D WRITE^HLOSTRAC($S(SUCCESS:"Got the header!",1:"**** FAILED TO COMPLETE *****"))
 Q
ZB12 ;
 D WRITE^HLOSTRAC("Getting next segment...")
 Q
ZB13 I $D(SEG) D WRITE2^HLOSTRAC(" Segment follows...",.SEG)
 D WRITE^HLOSTRAC($S(RETURN:"Got the segment!",$G(HLCSTATE("MESSAGE ENDED")):"No more segments!",1:"**** FAILED TO COMPLETE *****"))
 Q
ZB14 ;
 D WRITE2^HLOSTRAC("Writing next segment...",.SEG)
 Q
ZB15 D WRITE^HLOSTRAC($S(RETURN:"Completed!",1:"**** FAILED TO COMPLETE *****"))
 Q
ZB16 ;
 D WRITE3^HLOSTRAC("Beginning to write the commit acknowledgment...")
 D WRITE2^HLOSTRAC("Writing header segment...",.HDR)
 Q
ZB17 D WRITE^HLOSTRAC($S(SUCCESS:"Completed!",1:"**** FAILED TO COMPLETE *****"))
 Q
ZB18 ;
 D WRITE^HLOSTRAC("Writing message terminators and flushing buffer...")
 Q
ZB19 D WRITE^HLOSTRAC($S(RETURN:"Completed!",1:"**** FAILED TO COMPLETE *****"))
 Q
ZB25 D WRITE^HLOSTRAC("Opening the port...")
 Q
ZB26 D WRITE^HLOSTRAC("Waiting for remote client to connect...")
 Q
ZB27 D WRITE^HLOSTRAC("Remote client connected...")
 Q
ZB28 D:'$G(HLCSTATE("CONNECTED")) WRITE^HLOSTRAC("**** UNABLE TO OPEN PORT *****")
 Q
ZB29 D WRITE3^HLOSTRAC("*** THE MESSAGE HEADER COULD NOT BE PARSED   ***")
 Q
ZB30 D WRITE3^HLOSTRAC("*** THE MESSAGE IS A DUPLICATE AND WILL BE DISCARDED   ***")
 D WRITE3^HLOSTRAC("*** THE ORIGINAL COMMIT ACKNOWLEDMENT WILL BE RETURNED ***")
 Q
 ;
ZB3 ;
 S $ETRAP="Q:$QUIT """" Q"
 D END^HLOSRVR
 N CON,MSG
 S CON=($ZA\8192#2)
 S MSG="Error encountered, $ECODE="_$ECODE
 D WRITE^HLOTRACE(MSG)
 S MSG=$S(CON:"           TCP connection still active",1:"          TCP connection was dropped")
 D WRITE3^HLOTRACE(MSG)
 I ($ECODE["EDITED") Q:$QUIT "" Q
 I ($ECODE["READ")!($ECODE["NOTOPEN")!($ECODE["DEVNOTOPN")!($ECODE["WRITE")!($ECODE["OPENERR") D
 .;
 E  D
 .D ^%ZTER
 Q
ZB32 D:('$G(RETURN)) WRITE^HLOTRACE("**** FAILED ****")
 D:$G(RETURN) WRITE3^HLOTRACE("")
 D:$G(RETURN) WRITE3^HLOTRACE($G(BUF))
 Q
