%ZISTCP ;ISC-SF/RWF - DEVICE HANDLER TCP/IP CALLS ;06/23/2004  09:09
 ;;8.0;KERNEL;**36,34,59,69,118,225,275**;Jul 10, 1995
 Q
 ;
CALL(IP,SOCK,TO) ;Open a socket to the IP address <procedure>
 N %A,ZISOS,X,NIO
 S ZISOS=^%ZOSF("OS"),TO=$G(TO,30)
 N $ETRAP S $ETRAP="G OPNERR^%ZISTCP"
 S POP=1
 I IP'?1.3N1P1.3N1P1.3N1P1.3N S IP=$$ADDRESS^XLFNSLK(IP)  ;Lookup the name
 I IP'?1.3N1P1.3N1P1.3N1P1.3N Q  ;Not in the IP format
 I (SOCK<1)!(SOCK>65535) Q
 G CVXD:ZISOS["VAX",CONT:ZISOS["OpenM",CGTM:ZISOS["GT.M",CMSM:ZISOS["MSM"
 S POP=1
 Q
CVXD ;Open VAX DSM Socket
 S NIO=SOCK
 O NIO:(TCPCHAN,ADDRESS=IP):TO G:'$T NOOPN
 U NIO:NOECHO D VAR(NIO)
 Q
CMSM ;Open MSM Socket
 S NIO=56 O NIO::TO G:'$T NOOPN
 U NIO::"TCP" W /SOCKET(IP,SOCK) I $KEY="" C NIO G NOOPN
 D VAR(NIO)
 Q
CONT ;Open OpenM socket
 I $$VERSION^%ZOSV'<5 S %A=$ZUTIL(68,55,1)
 S NIO="|TCP|"_SOCK
 O NIO:(IP:SOCK:"-M"::512:512):TO G:'$T NOOPN ;Make work like DSM
 U NIO D VAR(NIO)
 Q
CGTM ;Open GT.M Socket
 S NIO="SCK$"_$P($H,",",2) ;Just needs to be unique for job
 O NIO:(CONNECT=IP_":"_SOCK_":TCP":ATTACH="client"):TO:"SOCKET"
 I '$T S POP=1 Q
 U NIO S NIO("KEY")=$KEY
 S NIO("SOCKET")=$P(NIO("KEY"),"|",2)
 I $P(NIO("KEY"),"|")'="ESTABLISHED" D LOG("** ="_NIO("KEY")_"= **") W 1/0 ; PROTOCOL ERROR
 ;U NIO:(SOCKET=NIO("SOCKET"):WIDTH=512:NOWRAP:IOERROR="TRAP":EXCEPT="G GTMERR^%ZISTCP")
 U NIO:(SOCKET=NIO("SOCKET"):WIDTH=512:NOWRAP:EXCEPT="G GTMERR^%ZISTCP")
 D VAR(NIO) S IOF="#" ;Set buffer flush
 Q
 ;
VAR(%IO) ;Setup IO variables
 S:'$D(IO(0)) IO(0)=$I
 S IO=%IO,IO(1,IO)=$G(IP),POP=0
 ;Set IOF to the normal buffer flush. W @IOF.
 S IOT="TCP",IOST="P-TCP",IOST(0)=0
 S IOF=$$FLUSHCHR
 Q
NOOPN ;Didn't make the conection
 S POP=1
 Q
OPNERR ;
 ;D ^%ZTER
 S POP=1
 D ERRCLR
 Q
UCXOPEN(NIO) ;This call only applies to SERVER jobs tied to UCX/VMS
 N $ETRAP,%ZISV,%ZISOS S $ETRAP="G OPNERR^%ZISTCP"
 S %ZISV=$$VERSION^%ZOSV,%ZISOS=^%ZOSF("OS"),POP=1
 I %ZISOS["DSM",%ZISV<7 O NIO:(SHARE):5 D:$T VAR(NIO)
 I %ZISOS["DSM",%ZISV'<7 S NIO="SYS$NET" O NIO:(TCPDEV):5 D:$T VAR(NIO)
 Q
 ;
CLOSE ;Close and reset
 N NIO,$ETRAP S $ETRAP="G CLOSEX^%ZISTCP"
 S NIO=IO,IO=$S($G(IO(0))]"":IO(0),1:$P)
 I NIO]"" C NIO K IO(1,NIO) S IO("CLOSE")=NIO
CLOSEX D HOME^%ZIS
 D ERRCLR
 Q
ERRCLR ;
 S:$ECODE]"" IO("LASTERR")=$G(IO("ERROR")),IO("ERROR")=$ECODE,$ECODE=""
 Q
 ;
FLUSHCHR() ;Return the value to write @ of to flush the TCP buffer
 N OS S OS=$P(^%ZOSF("OS"),"^")
 Q $S(OS["GT.M":"#",1:"!")
 ;
 ;In ZRULE, set ZISQUIT=1 to quit
LISTEN(SOCK,RTN,ZRULE) ;Listen on socket, run routine, single thread.
 N %A,ZISOS,X,NIO,EXIT,IOF,IP
 N $ES,$ET S $ET="D OPNERR^%ZISTCP"
 S ZISOS=^%ZOSF("OS"),ZRULE=$G(ZRULE)
 D GETENV^%ZOSV S U="^",XUENV=Y,XQVOL=$P(Y,U,2)
 S POP=1
 I $G(^%ZIS(14.5,"LOGON",XQVOL)) Q
LOOP S POP=1 D LVXD:ZISOS["DSM",LONT:ZISOS["OpenM",LGTM:ZISOS["GT.M",LMSM:ZISOS["MSM"
 I POP Q  ;Quit Server
 S EXIT=0,EXIT=$$LAUNCH(NIO,RTN)
 I $G(^%ZIS(14.5,"LOGON",XQVOL)) S EXIT=1
 I ZISOS["DSM" X "U NIO:DISCONNECT"
 E  C NIO ;
 Q:EXIT  ;Quit server, App set IO("C"), Logon inhibit.
 G LOOP
 ;
LMSM ;MSM
 ;For multi thread use MSM's MSERVER process.
 ;This is the listener for  TCP connects.
 S NIO=56 O NIO::30 Q:'$T  S POP=0
 U NIO::"TCP" W /SOCKET("",SOCK)
 S POP=$$EXIT
 Q
 ;
LONT ;Open port in Accept mode with standard terminators, standard buffers.
 N %ZA,%ZB
 S NIO="|TCP|"_SOCK,%A=0
 ;(adr:sock:term:ibuf:obuf:queue)
 O NIO:(:SOCK:"AT"::512:512:3):30 Q:'$T  S POP=0
 ;Wait on read for a connect
 U NIO F  D  Q:%A!POP
 . R *NEWCHAR:60 S %ZA=$ZA,%ZB=$ZB S:$T %A=1 Q:%A
 . S POP=$$EXIT
 I POP C NIO Q
 U NIO:(::"-M") ;Work like DSM
 Q
 ;
LVXD ;Open port and listen
 ;Use UCX for multiple listeners
 S NIO=SOCK O NIO:(TCPCHAN):30 Q:'$T  S POP=0
 U NIO ;Let application wait at the read for a connect.
 Q
 ;
LGTM ;GT.M single thread server
 N %A K ^TMP("ZISTCP",$J)
 S $ZINTERRUPT="I $$JOBEXAM^ZU($ZPOSITION)"
 S NIO="SCK$"_$S($J>86400:$J,1:84600+$J) ;Construct a dummy, but "unique" devicename for job
 D LOG("Open for Listen "_NIO)
 ;Open the device
 O NIO:(ZLISTEN=SOCK_":TCP":ATTACH="listener"):30:"SOCKET"
 I '$T D LOG("Can't Open Socket: "_SOCK) Q
 U NIO S NIO("ZISTCP",0)=$KEY D LOG("Have port.")
 ;Start Listening
 W /LISTEN(1) S NIO("ZISTCP",1)=$KEY D LOG("Start Listening. "_NIO("ZISTCP",1))
 ;Wait for connection
 S %A=0,POP=0 F  D  Q:%A!POP
 . W /WAIT(30) ;Wait for connect
 . I $P($KEY,"|",1)="CONNECT" S NIO("ZISTCP",2)=$KEY,%A=1
 . S POP=$$EXIT
 . Q
 I POP C NIO Q
 ;
 S NIO("SOCK")=$P($G(NIO("ZISTCP",2)),"|",2)
 D LOG("Got connection on "_NIO("SOCK"))
 ;Close the main socket
 C NIO:(SOCKET="listener")
 ;Use the new socket
 ;U NIO:(SOCKET=NIO("SOCK"):WIDTH=512:NOWRAP:IOERROR="TRAP":EXCEPT="G GTMERR^%ZISTCP")
 U NIO:(SOCKET=NIO("SOCK"):WIDTH=512:NOWRAP:EXCEPT="G GTMERR^%ZISTCP")
 S POP=0
 Q
 ;
GTMERR ;The use will set this as a place to go on a IO error
 S $ECODE=",U911,"
 Q
 ;
EXIT() ;See if time to exit
 I $$S^%ZTLOAD Q 1
 N ZISQUIT S ZISQUIT=0
 I $L(ZRULE) X ZRULE I $G(ZISQUIT) Q 1
 Q 0
 ;
LAUNCH(IO,RTN) ;Run job for this conncetion.
 N NIO,SOCK,EXIT,XQVOL
 D VAR(IO)
 S ^XUTL("XQ",$J,0)=$$DT^XLFDT
 D LOG("Run "_RTN)
 D @RTN
 D LOG("Return from call, Exit="_$D(IO("C")))
 Q $D(IO("C")) ;Use IO("C") to quit server
 ;
LOG(MSG) ;LOG STATUS
 N CNT
 S CNT=$G(^TMP("ZISTCP",$J))+1,^TMP("ZISTCP",$J)=CNT,^($J,CNT)=MSG
 Q
 ;
