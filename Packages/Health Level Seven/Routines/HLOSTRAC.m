HLOSTRAC ;OIFO-OAK/RBN/CJM - Server Trace ;Apr 03, 2020@14:49
 ;;1.6;HEALTH LEVEL SEVEN;**146,147,153,10001**;Oct 13, 1995;Build 3
 ; Original code in the public domain by Dept of Veterans Affairs.
 ; Changes **10001** by Sam Habiel (c) 2020.
 ; Changes indicated inline.
 ; Licensed under Apache 2.0.
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
 ; *10001*
 N CACHE,GTM
 S CACHE=^%ZOSF("OS")["OpenM"
 S GTM=^%ZOSF("OS")["GT.M"
 I 'CACHE,'GTM D  Q
 .W !!,"   Sorry, this tool can only be used under Cache or GT.M",!!
 ; *10001*
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
 D SBREAK("ZB999^HLOSRVR","S LINK(""PORT"")=PORT,LINK(""SERVER"")=""1^S"",LINK(""LLP"")=""TCP""")
 ;
 W !!,"Starting the server, hit the CTRL-C key to stop the server...",!!
READ D
 .N $ETRAP,$ESTACK
 .S $ETRAP="G ERROR^HLOSTRAC"
 .D SERVER^HLOSRVR(LINK)
 .U $PRINCIPAL
 .W !,"DONE!"
 ; ZB /CLEAR ;*10001
 Q
 ;
SBREAK(EP,ACTION) ; *10001*
 I ^%ZOSF("OS")["OpenM" ZB @EP:"N":1:ACTION
 I ^%ZOSF("OS")["GT.M"  ZB @(EP_":"""_$$CONVQQ^DILIBF(ACTION)_"""")
 QUIT
 ;
 ;
SETBREAKS ;
 ; ZB /CLEAR ; *10001
 ; ZB /INTERRUPT:NORMAL ; *10001
 ;
 ;!!!! for debuggng only
 ;ZB ERROR^HLOSTRAC
 ;!!!!!!
 ;
 ;
 ;report errors
 D SBREAK("ZB1^HLOSRVR","S $ETRAP=""G ZB3^HLOSTRAC""")
 ;
 ;allow Server Trace tool to run even if HLO is shut down
 D SBREAK("ZB25^HLOPROC","S RET=0")
 D SBREAK("READMSG^HLOSRVR1","D READMSG^HLOSTRAC")
 D SBREAK("PARSEHDR^HLOPRS","D PARSEHDR^HLOSTRAC")
 D SBREAK("DUP^HLOSRVR1","D DUP^HLOSTRAC")
 D SBREAK("CLOSE^HLOT","D CLOSE^HLOSTRAC")
 ;set break ZB10 in the client(start of $$READHDR^HLOT)
 D SBREAK("ZB10^HLOT","D ZB10^HLOSTRAC")
 ;set break ZB11 in the client(end of $$READHDR^HLOT)
 D SBREAK("ZB11^HLOT","D ZB11^HLOSTRAC")
 ;set break ZB12 in the client(start of $$READSEG^HLOT)
 D SBREAK("ZB12^HLOT","D ZB12^HLOSTRAC")
 ;set break ZB13 in the client(end of $$READSEG^HLOT)
 D SBREAK("ZB13^HLOT","D ZB13^HLOSTRAC")
 ;set break ZB14 in the client(start of $$WRITESEG^HLOT)
 D SBREAK("ZB14^HLOT","D ZB14^HLOSTRAC")
 ;set break ZB15 in the client(end of $$WRITESEG^HLOT)
 D SBREAK("ZB15^HLOT","D ZB15^HLOSTRAC")
 ;set break ZB16 in the client(start of $$WRITEHDR^HLOT)
 D SBREAK("ZB16^HLOT","D ZB16^HLOSTRAC")
 ;set break ZB17 in the client(end of $$WRITEHDR^HLOT)
 D SBREAK("ZB17^HLOT","D ZB17^HLOSTRAC")
 ;set break ZB18 in the client(start of $$ENDMSG^HLOT)
 D SBREAK("ZB18^HLOT","D ZB18^HLOSTRAC")
 ;set break ZB19 in the server(end of $$ENDMSG^HLOT)
 D SBREAK("ZB19^HLOT","D ZB19^HLOSTRAC")
 D SBREAK("ZB25^HLOTCP","D ZB25^HLOSTRAC")
 D SBREAK("ZB26^HLOTCP","D ZB26^HLOSTRAC")
 ;
 D SBREAK("ZB27^HLOTCP","D ZB27^HLOSTRAC")
 ;
 D SBREAK("ZB28^HLOTCP","D ZB28^HLOSTRAC")
 ;set break ZB29 in the server(after parsing the message header)
 D SBREAK("ZB29^HLOSRVR1","D ZB29^HLOSTRAC")
 ;set break ZB30 in the server(afterchecking if duplicate)
 D SBREAK("ZB30^HLOSRVR1","D ZB30^HLOSTRAC")
 D SBREAK("ZB31^HLOTCP","D WRITE^HLOTRACE(""Beginning READ over TCP..."")")
 D SBREAK("ZB32^HLOTCP","D ZB32^HLOTRACE")
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
 I ($ECODE["Z150372498") Q:$QUIT "" Q  ; CTRL-C for GT.M
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
 I ^%ZOSF("OS")["OpenM" S CON=($ZA\8192#2)
 I ^%ZOSF("OS")["GT.M"  S CON=$KEY["ESTABLISHED"
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
