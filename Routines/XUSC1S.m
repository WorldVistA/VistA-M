XUSC1S ;ISCSF/RWF - Interface to Server services. ;10/09/2002  16:59
 ;;8.0;KERNEL;**283**;Jul 10, 1995
 Q
 ;XUSC is used to pass data around.
 ; 5224 is the standard VA port for the Services Server.
LISTEN ;only for OpenM
 S $ETRAP="D ^%ZTER H"
 D LISTEN^%ZISTCPS(5500,"ONT^XUSC1S")
 Q
DSM ;Test listener
 S IO=% O IO:(SHARE) U IO ;Setup TCP port
 S IO(0)="_NLA0:" O IO(0) ;Setup null device
 D SVR
 Q
MSM ;Entry point from MSERVER
 S IO=56,IO(0)=46 O 46 ;Null device
 D SVR C IO
 Q
ONT ;Cache/OpenM
 S IO=$I,IO(0)="//./nul" O IO(0)
 D SVR
 Q
 ;
SVR ;Entry point when we have a connect
 ;See that IO=TCP device, and IO(0) is Null device and Open.
 N XUSC11,XUSCER,XUSCEXIT,XUSCCMD,XUSCDAT,ZTQUEUED D SETUP
 N $ESTACK,$ETRAP S $ETRAP="D ^%ZTER H"
 K ^XUTL("XQ",$J) S ^XUTL("XQ",$J,0)=$$NOW^XLFDT
 F  D CREAD Q:XUSCEXIT  D  Q:XUSCEXIT
 . I XUSCCMD="" S XUSC11("TCNT")=$G(XUSC11("TCNT"))+1 S:$$STOP!(XUSC11("TCNT")>10) XUSCEXIT=1 Q
 . I XUSCCMD'?4A D SEND("500 Bad CMD: "_$E(XUSCCMD,1,20)) Q
 . I $T(@XUSCCMD)="" D SEND("500 ") Q
 . S XUSC11("TCNT")=0
 . D @XUSCCMD I $G(XUSCER) D TRACE("ERROR: "_XUSCER)
 . Q
 S:XUSCEXIT IO("C")=1
 I '$G(XUSCDBUG) K ^TMP("XUSCI",$J),^TMP("XUSCO",$J) ;Clean up
 D TRACE("Exit")
 Q
HELO ;Process HELO
 S XUSC11("SITE")=$P(XUSCDAT," ")
 ;Do any check on who is sending
 D SEND("220 "_$$KSP^XUPARAM("WHERE")_" Ready for "_XUSCDAT)
 Q
 ;
NOOP ;
 D SEND("250 OK")
 Q
 ;
DATA ;Process DATA
 ; The DATA cmd can pass some parameters as well, this could be passed
 ; to the processing routine also.
 N XUSCRTN,P,I,DUZ S DUZ=0,DUZ(0)="@"
 D TRACE("Get Data")
 S (XUSCRTN,XUSC11("DATA"))=XUSCDAT K @XUSCIN,@XUSCOUT
 D DATA^XUSC1S1(XUSCIN,.XUSC11)
 S P="" F I=1:1 Q:'$D(XUSC11("P"_I))  S P=P_"P"_I_"="_XUSC11("P"_I)_", "
 D TRACE("PARAM "_P)
 ;Use the Null Device
 U IO(0)
 ;Now call soneone to process the data
 ;I XUSC11("P1")="SERVER" D SERVER^XUSC1S2
 I XUSC11("P1")="PING" M @XUSCOUT=@XUSCIN
 U IO ;Back to the TCP device
 Q
TURN ;Turn and send responce
 D SEND("220 OK")
 D SDATA^XUSC1S1(XUSCOUT,XUSC11("P1"))
 D CREAD,TRACE("Data Sent ") ;Look for 220 ok
 Q
QUIT ;Process QUIT
 D TRACE("QUIT")
 S XUSCMSG="",XUSCEXIT=1
 Q
 ;
CREAD ;Read a string
 N $ETRAP S $ETRAP="S $EC="""" G CREX"
 N I S (Y,XUSCDAT,XUSCCMD)="",XUSCER=0
 F I=0:1:255 R X#1:XUSCTIME S:'$T XUSCER=1 D TRACE("Char "_$A(X)) Q:X=$C(10)!XUSCER  S Y=Y_X
 S Y=$TR(Y,$C(13,10)),XUSCCMD=$P(Y," "),XUSCDAT=$P(Y," ",2,99)
 D TRACE("Cmd Read "_Y)
 Q
CREX S XUSCEXIT=1,XUSCER="1 Error"
 D TRACE("CREAD error: "_$$EC^%ZOSV_" Y="_Y)
 Q
 ;
SEND(MSG) ;Send a cmd MSG
 N $ETRAP S $ETRAP="S $EC="""" D CREX"
 D TRACE("Cmd Send "_MSG)
 W MSG,$C(13,10),!
 Q
 ;
SETUP ;Setup needed variables
 K IO("C") S (XUSCER,XUSCEXIT)=0,XUSCTIME=345,ZTQUEUED=.5 ;**** CHANGE BACK
 S XUSCTRC="S: ",XUSC11("P1")="TEXT"
 S XUSCIN=$NA(^TMP("XUSCI",$J)),XUSCOUT=$NA(^TMP("XUSCO",$J))
 S XUSCDBUG=$$GET^XPAR("SYS","XUSC1 DEBUG",,"Q")
 D TRACE(-1),TRACE("Server Setup")
 Q
STOP(%) ;Should the server stop.
 I $G(%)=1 S ^TMP("XUSC1","STOP")=1 Q
 I $G(%)=-1 K ^TMP("XUSC1","STOP") Q
 I $D(^TMP("XUSC1","STOP")) Q 1
 Q 0
 ;
TRACE(S1) ;
 N H,%
 I S1=-1 K ^TMP("XUSC1",$J) Q
 Q:'$G(XUSCDBUG)
 S H=$P($H,",",2),H=(H\3600)_":"_(H#3600\60)_":"_(H#60)_" "
 L +^TMP("XUSC1",$J)
 S %=$G(^TMP("XUSC1",$J,0))+1,^(0)=%,^(%)=H_$G(XUSCTRC)_S1
 L -^TMP("XUSC1",$J)
 Q
 ;
