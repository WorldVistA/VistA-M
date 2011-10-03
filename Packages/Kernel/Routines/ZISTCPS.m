%ZISTCPS ;ISF/RWF - DEVICE HANDLER TCP/IP SERVER CALLS ;06/20/2005  09:11
 ;;8.0;KERNEL;**78,118,127,225,275,388**;Jul 10, 1995
 Q
 ;
CLOSE ;Close and reset
 G CLOSE^%ZISTCP
 Q
 ;
 ;In ZRULE, set ZISQUIT=1 to quit
LISTEN(SOCK,RTN,ZRULE) ;Listen on socket, start routine
 N %A,ZISOS,X,NIO,EXIT
 N $ES,$ET S $ETRAP="D OPNERR^%ZISTCPS"
 S ZISOS=^%ZOSF("OS"),ZRULE=$G(ZRULE)
 S POP=1
 D GETENV^%ZOSV S U="^",XUENV=Y,XQVOL=$P(Y,U,2)
 S POP=1 D LONT:ZISOS["OpenM",LGTM:ZISOS["GT.M"
 I 'POP C NIO ;Close port
 Q
 ;
 ;
LONT ;Open port in Accept mode with standard terminators.
 N %ZA,NEWCHAR
 S NIO="|TCP|"_SOCK,EXIT=0
 ;(adr:sock:term:ibuf:obuf:queue)
 O NIO:(:SOCK:"AT"::512:512:10):30 Q:'$T  S POP=0 U NIO
 ;Wait on read for a connect
LONT2 F  U NIO R *NEWCHAR:30 S EXIT=$$EXIT Q:$T!EXIT
 I EXIT C NIO Q
 ;JOB params (:Concurrent Server bit:principal input:principal output)
 J CHILDONT^%ZISTCPS(NIO,RTN):(:16::):10 S %ZA=$ZA
 I %ZA\8196#2=1 W *-2 ;Job failed to clear bit
 G LONT2
 ;
CHILDONT(IO,RTN) ;Child process for OpenM
 S $ETRAP="D ^%ZTER L  HALT",IO=$ZU(53)
 U IO:(::"-M") ;Work like DSM
 S NEWJOB=$$NEWOK
 I 'NEWJOB W "421 Service temporarily down.",$C(13,10),!
 I NEWJOB K NEWJOB D VAR,@RTN
 HALT
 ;
VAR ;Setup IO variables
 S IO(0)=IO,IO(1,IO)="",POP=0
 S IOT="TCP",IOST="P-TCP",IOST(0)=0
 S IOF=$$FLUSHCHR^%ZISTCP
 S ^XUTL("XQ",$J,0)=$$DT^XLFDT
 Q
NEWOK() ;Is it OK to start a new process
 I $G(^%ZIS(14.5,"LOGON",^%ZOSF("VOL"))) Q 0
 I $$AVJ^%ZOSV()<3 Q 0
 Q 1
OPNERR ;
 S POP=1,EXIT=1,IO("ERROR")=$ECODE,$ECODE=""
 Q
EXIT() ;See if time to exit
 I $$S^%ZTLOAD Q 1
 N ZISQUIT S ZISQUIT=0
 I $L(ZRULE) X ZRULE I $G(ZISQUIT) Q 1
 Q 0
 ;
LGTM ;GT.M multi thread server
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
LG2 S %A=0,EXIT=0 F  D  Q:%A!EXIT
 . W /WAIT(30) ;Wait for connect
 . I $P($KEY,"|",1)="CONNECT" S NIO("ZISTCP",2)=$KEY,%A=1
 . S EXIT=$$EXIT
 . Q
 I EXIT C NIO Q
 ;
 S NIO("SOCK")=$P($G(NIO("ZISTCP",2)),"|",2)
 D LOG("Got connection on "_NIO("SOCK"))
 I '$$NEWOK D  G LG2
 . U NIO:(SOCKET=NIO("SOCK")) W "421 Service temporarily down.",$C(13,10),#
 . C NIO:(SOCKET=NIO("SOCK")) K NIO("ZISTCP",2)
 . Q
 ;Close the main socket
 C NIO:(SOCKET="listener")
 ;Start a new listener
 J LISTEN^%ZISTCPS(SOCK,RTN,ZRULE)
 ;Use the new socket
 ;U NIO:(SOCKET=NIO("SOCK"):WIDTH=512:NOWRAP:IOERROR="TRAP")
 U NIO:(SOCKET=NIO("SOCK"):WIDTH=512:NOWRAP)
 ;Run the job
 D GTMLNCH(NIO,RTN)
 S POP=0
 Q
 ;
GTMLNCH(IO,RTN) ;Run gt.m job for this conncetion.
 N NIO,SOCK,ZISOS,EXIT,XQVOL,$ETRAP
 S U="^",$ETRAP="D ^%ZTER L  HALT"
 S IO(0)=IO,IO(1,IO)=""
 D VAR,@RTN
 Q $D(IO("C")) ;Use IO("C") to quit server
 ;
LOG(MSG) ;LOG STATUS
 N CNT
 S CNT=$G(^TMP("ZISTCP",$J))+1,^TMP("ZISTCP",$J)=CNT,^($J,CNT)=MSG
 Q
 ;
