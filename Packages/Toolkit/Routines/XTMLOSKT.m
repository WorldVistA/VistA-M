XTMLOSKT ;SLC/KCM;2017-07-25  10:39 AM;06/07/08  17:02
 ;;2.4;LOG4M;;Jul 25, 2017;Build 3
 ;
 ; Includes some public domain code written by Kevin Muldrum
 ; This code is currently not used.
 ;
 ; This routine is the background process that listens for client
 ; requests to connect to M.  When a request is received, This
 ; procedure will job a routine to handle the requests of the client.
 ;
 ; This job may be started in the background with:  D STRT^XWBTCP(PORT)
 ;
 ; When running, this job may be stopped with:      D STOP^XWBTCP(PORT)
 ;
 ; Where port is the known service port to listen for connections
 ;
EN(XWBTSKT) ; -- accept clients and start the individual message handler
 ;N $ETRAP,$ESTACK S $ETRAP="D ^%ZTER J EN^XTMLOSKT($G(XWBTSKT)) HALT"
 N RETRY,X,XWBVER,XWBVOL,LEN,MSG,XWBOS,DONE,DSMTCP,NATIP
 S U="^",RETRY="START"
 X ^%ZOSF("UCI") S XWBVOL=$P(Y,",",2) ;(*p7,p9*)
 IF $G(XWBTSKT)="" S XWBTSKT=9400 ; default service port
 S XWBTDEV=XWBTSKT
 ;
 Q:'$$SEMAPHOR(XWBTSKT,"LOCK")  ; -- quit if job is already running
 ;
 S XWBDEBUG=$$GET^XPAR("SYS","XWBDEBUG")
 I XWBDEBUG D LOGSTART^XWBDLOG("XTMLOSKT")
 D UPDTREC(XWBTSKT,3) ;updt RPC BROKER SITE PARAMETER record as RUNNING
 D MARKER^XWBTCP(XWBTSKT,-1) ;Clear marker
 ;
 H 2 ;Hibernate so caller can clear (*p16)
 D SETNM^%ZOSV($E("XTML_Port:"_XWBTSKT,1,15)) ;change process name
 S ^TMP("XTMLOSKT","$J",$J)=""
 ;
RESTART ;
 N $ESTACK S $ETRAP="D ETRAP^XTMLOSKT"
 S DONE=0,X=0
 S XWBOS=$S(^%ZOSF("OS")["DSM":"DSM",^("OS")["OpenM":"OpenM",^("OS")["GT.M":"GTM",^("OS")["MSM":"MSM",1:"")
 ;
 S %T=0,IOF="!" ;Check for Open success (*p35)
 I XWBOS="DSM" O XWBTSKT:TCPCHAN:5 S %T=$T ;Open listener
 I XWBOS="OpenM" S XWBTDEV="|TCP|"_XWBTSKT O XWBTDEV:(:XWBTSKT:"AT"::512:512:10):5 S %T=$T ;512 buffers, queue = 10 (*p35)
 I XWBOS="GTM" D
 . S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""")
 . S XWBTDEV="SKD$"_$J,XWBTSKT=XWBTSKT,IOF="#"
 . O XWBTDEV:(ZLISTEN=XWBTSKT_":TCP":ATTACH="listener"):5:"SOCKET" ;S %T=$T Q:'%T
 . U XWBTDEV S XWBTDEV("LISTENER")=$KEY
 . W /LISTEN(1)
 . U XWBTDEV S XWBTDEV("STATUS")=$KEY
 . Q
 ;
 I XWBDEBUG D LOG^XWBTCPC("Port Open: "_XWBTSKT)
 F  D  Q:DONE
 . ; -- listen for connect & get the initial message from the client
 . I XWBOS="DSM" U XWBTSKT
 . I XWBOS="MSM" S XWBTDEV=56 O 56 U 56::"TCP" W /SOCKET("",XWBTSKT)
 . I XWBOS="OpenM" U XWBTDEV R *X
 . I XWBOS="GTM" D
 . . K XWBTDEV("SOCKET")
 . . F  D  Q:$D(XWBTDEV("SOCKET"))
 . . . ;Wait for connection, $KEY will be "CONNECT|socket_handle|remote_ipaddress"
 . . . U XWBTDEV W /WAIT(10) S XWBTDEV("KEY")=$KEY
 . . . I XWBTDEV("KEY")="" Q
 . . . S XWBTDEV("SOCKET")=$P(XWBTDEV("KEY"),"|",2)
 . . . S (XWBTDEV("IP"),IO("GTM-IP"))=$P(XWBTDEV("KEY"),"|",3)
 . . . U XWBTDEV:(SOCKET=XWBTDEV("SOCKET"):WIDTH=512:NOWRAP:EXCEPTION="GOTO ETRAP")
 . . . Q
 . . Q
 . I $D(^TMP("XTMLOSKT","DATA",XWBTSKT)) D
 . . U XWBTSKT
 . . D FLUSH
 . . N I,X S JOB="" F  Q:DONE  S JOB=$O(^TMP("XTMLOSKT","DATA",XWBTSKT,JOB)) Q:JOB=""  F I=0:0 S I=$O(^TMP("XTMLOSKT","DATA",XWBTSKT,JOB,I)) Q:I'>0  D
 . . . S X=^TMP("XTMLOSKT","DATA",XWBTSKT,JOB,I) K ^(I) D
 . . . . N $ETRAP,$ESTACK S $ETRAP="D IGNOR^XTMLOSKT"
 . . . . W X,$C(13,10),@IOF I $D(^TMP("XTMLOSKT","STOP",XWBTSKT)) S DONE=1 K ^(XWBTSKT)
 . . . Q
 . . Q
 . H 1
 . I $D(^TMP("XTMLOSKT","STOP",XWBTSKT)) S DONE=1 K ^(XWBTSKT)
 . Q
 ; -- loop end
 ;
 S %=$$SEMAPHOR(XWBTSKT,"UNLOCK") ; destroy 'running flag'
 D UPDTREC(XWBTSKT,6) ;updt RPC BROKER SITE PARAMETER record as STOPPED
 IF XWBOS="DSM" C XWBTSKT ;Do Close last in case it gets an error
 Q
IGNOR ;
 S IGNOR=$G(IGNOR)+1
 ; S ^TMP("XTMLOSKT","IGNOR",IGNOR)=$H
 S $ET="",$EC=""
 Q
 ;
 ;
ETRAP ; -- on trapped error, send error info to client
 N XWBERC,XWBERR ;S $ETRAP="D ^%ZTER J EN^XTMLOSKT($G(XWBTSKT)) HALT"
 S XWBERC=$$EC^%ZOSV,XWBERR=$C(24)_"M  ERROR="_XWBERC_$C(13,10)_"LAST REF="_$$LGR^%ZOSV_$C(4)
 S ECOUNT=$G(ECOUNT)+1
 S ^TMP("XTMLOSKT","ETRAP",ECOUNT,$H)=XWBERR
 I (XWBERC["WRITE")!(XWBERC["READ") S $ECODE="" Q  ;
 D ^%ZTER ;Record error and clear $ECODE
 I XWBERC["F-DUPLNAM" D  HALT
 . S %=$$SEMAPHOR(XWBTSKT,"UNLOCK") ; destroy 'running flag'
 . D UPDTREC(XWBTSKT,6) ;updt RPC BROKER SITE PARAMETER record as STOPPED
 . Q
 Q
 ;
FLUSH ;Flush the input buffer
 F  R X:0 Q:'$T
 Q
 ;
RELEASE(%) ;Now release the connection. (*p7*)
 ;Parameter is zero to Release, one to Close
 I XWBOS="DSM" D  Q  ;(*p35)
 . I $G(%) C XWBTSKT Q
 . U XWBTSKT:DISCONNECT ; release this socket
 I XWBOS="OpenM" D  Q  ;(*p35)
 . I $G(%) C XWBTDEV Q
 . W *-3,*-2 ;Send any data and release the socket
 I XWBOS="GTM" D  Q  ;(*p35)
 . I $G(%) C XWBTDEV Q
 . C XWBTDEV:(SOCKET=XWBTDEV("SOCKET")) ;release the socket
 I XWBOS="MSM" C 56
 Q
 ;
UPDTREC(XWBTSKT,STATE,XWBENV) ; -- update STATUS field and ^%ZIS X-ref of the
 ;RPC BROKER SITE PARAMETER file
 ;XWBTSKT: listener port
 N C,XWBOXIEN,XWBPOIEN,XWBFDA
 S C=",",U="^"
 I $G(XWBENV)'="" S Y=XWBENV
 E  D GETENV^%ZOSV ;get Y=UCI^VOL^NODE^BOXLOOKUP of current system
 ;I STATE=3 S ^%ZIS(8994.171,"RPCB Listener",$P(Y,U,2),$P(Y,U),$P(Y,U,4),XWBTSKT)=$J
 ;I STATE=6 K ^%ZIS(8994.171,"RPCB Listener",$P(Y,U,2),$P(Y,U),$P(Y,U,4),XWBTSKT)
 ;
 S XWBOXIEN=$$FIND1^DIC(8994.17,",1,","",$P(Y,U,4)) ;find rec for box
 S XWBPOIEN=$$FIND1^DIC(8994.171,C_XWBOXIEN_",1,","",XWBTSKT)
 D:XWBPOIEN>0  ;update STATUS field if entry was found
 . D FDA^DILF(8994.171,XWBPOIEN_C_XWBOXIEN_C_1_C,1,"R",STATE,"XWBFDA")
 . D FILE^DIE("","XWBFDA")
 Q
 ;
 ;
SEMAPHOR(XWBTSKT,XWBACT) ;Lock/Unlock listener semaphore
 ;XWBTSKT: listener port, XWBACT: "LOCK" | "UNLOCK" action to perform
 ;if LOCK is requested, it will be attempted with 1 sec timeout and if
 ;lock was obtained RESULT will be 1, otherwise it will be 0.  For
 ;unlock RESULT will always be 1.
 N RESULT
 S U="^",RESULT=1
 D GETENV^%ZOSV ;get Y=UCI^VOL^NODE^BOXLOOKUP of current system
 I XWBACT="LOCK" D
 . L +^%ZIS(8994.171,"RPCB Listener",$P(Y,U,2),$P(Y,U),$P(Y,U,4),XWBTSKT):1
 . S RESULT=$T
 E  L -^%ZIS(8994.171,"RPCB Listener",$P(Y,U,2),$P(Y,U),$P(Y,U,4),XWBTSKT)
 Q RESULT
 ;
NEWJOB() ;Check if OK to start a new job, Return 1 if OK, 0 if not OK.
 N X,Y,J
 S X=$O(^XTV(8989.3,1,4,"B",XWBVOL,0)),J=$S(X>0:^XTV(8989.3,1,4,X,0),1:"ROU^y^1")
 I $D(^%ZOSF("ACTJ")) X ^("ACTJ") I $P(J,U,3),($P(J,U,3)'>Y) Q 0
 Q 1
 ;
START(PORT) ;
 J EN^XTMLOSKT(PORT)
 Q
 ;
STOP(PORT) ;
 S ^TMP("XTMLOSKT","STOP",PORT)=""
 Q
 ;
SETDATA(STR,PORT,COUNT) ;
 S PORT=$G(PORT,8025),OLDCOUNT=$G(COUNT,$G(OLDCOUNT))+1
 S ^TMP("XTMLOSKT","DATA",PORT,$J,OLDCOUNT)=STR
 Q
 ;
