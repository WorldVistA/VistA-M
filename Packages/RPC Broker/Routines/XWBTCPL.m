XWBTCPL ;SLC/KCM - Listener for TCP connects ;12/09/2004  07:33
 ;;1.1;RPC BROKER;**1,7,9,15,16,35**;Mar 28, 1997
 ;ISC-SF/EG - DHCP Broker
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
 ; p*35 Moved reads and writes to XWBRW
 ;
EN(XWBTSKT) ; -- accept clients and start the individual message handler
 N $ETRAP,$ESTACK S $ETRAP="D ^%ZTER J EN^XWBTCPL($G(XWBTSKT)) HALT"
 N RETRY,X,XWBVER,XWBVOL,LEN,MSG,XWBOS,DONE,DSMTCP,NATIP,XWBRBUF
 N XWBTIME
 S U="^",RETRY="START"
 X ^%ZOSF("UCI") S XWBVOL=$P(Y,",",2) ;(*p7,p9*)
 IF $G(XWBTSKT)="" S XWBTSKT=9000 ; default service port
 S XWBTDEV=XWBTSKT
 ;
 Q:'$$SEMAPHOR(XWBTSKT,"LOCK")  ; -- quit if job is already running
 ;
 S XWBDEBUG=$$GET^XPAR("SYS","XWBDEBUG") ;(*p35)
 I XWBDEBUG D LOGSTART^XWBDLOG("XWBTCPL") ;(*p35)
 D UPDTREC(XWBTSKT,3) ;updt RPC BROKER SITE PARAMETER record as RUNNING
 D MARKER^XWBTCP(XWBTSKT,-1) ;Clear marker
 ;
 D SETNM^%ZOSV($E("RPCB_Port:"_XWBTSKT,1,15)) ;change process name
 ;
RESTART ;
 H 5 ;Hibernate so caller can clear (*p16,*p35)
 N $ESTACK S $ETRAP="D ETRAP^XWBTCPL"
 S DONE=0,X=0,XWBTIME=5,XWBTIME(1)=5
 S XWBOS=$S(^%ZOSF("OS")["DSM":"DSM",^("OS")["OpenM":"OpenM",^("OS")["GT.M":"GTM",^("OS")["MSM":"MSM",1:"")
 S XWBT("BF")=$S(XWBOS="GT.M":"#",1:"!") ;(*p35)
 ;
 S %T=0 ;Check for Open success (*p35)
 ;DSM
 I XWBOS="DSM" O XWBTSKT:TCPCHAN:5 S %T=$T ;Open listener
 ;Cache, Terminator = $C(4)512 buffers, queue = 10
 I XWBOS="OpenM" S XWBTDEV="|TCP|"_XWBTSKT O XWBTDEV:(:XWBTSKT:"A":$C(4):512:512:10):5 S %T=$T ;(*p35)
 ;GT.M (*p35)
 I XWBOS="GTM" D
 . S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""")
 . S XWBTDEV="SKD$"_$J,XWBTSKT=XWBTSKT
 . O XWBTDEV:(ZLISTEN=XWBTSKT_":TCP":NODELIMITER:ATTACH="listener"):5:"SOCKET" S %T=$T Q:'%T
 . U XWBTDEV S XWBTDEV("LISTENER")=$KEY
 . W /LISTEN(1)
 . U XWBTDEV S XWBTDEV("STATUS")=$KEY
 . Q
 ;Check if got device Open
 I '%T D LOG^XWBDLOG("Open "_XWBTSKT_" Fail") Q  ;(*p35)
 ;
 I XWBDEBUG D LOG^XWBDLOG("Port Open: "_XWBTSKT)
 F  D  Q:DONE
 . S DONE=0
 . ; -- listen for connect & get the initial message from the client
 . I XWBOS="DSM" U XWBTSKT S XWBTIME=60 ;Will wait at read
 . I XWBOS="MSM" S XWBTDEV=56 O 56 U 56::"TCP" W /SOCKET("",XWBTSKT)
 . I XWBOS="OpenM" U XWBTDEV R *X ;Cache will wait here for connection
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
 . ;========================MAIN LOOP=======================
 . ;(*p35) change to use MSG, MSG1 and MSG2
 . S (MSG,MSG1,MSG2,XWBRBUF)=""
 . ;F XCNT=0:0 R MSG1#1:XWBTIME Q:$T  I '$T S XCNT=XCNT+1 Q:XCNT>5
 . F XCNT=0:0 S MSG1=$$BREAD^XWBRW(1,XWBTIME,1) Q:$L(MSG1)  S XCNT=XCNT+1 Q:XCNT>5
 . Q:XCNT>5
 . I MSG1'="{" D RELEASE(0) Q  ;Not the right start so Close.
 . S MSG1=MSG1_$$BREAD^XWBRW(4,,1) IF (MSG1'="{XWB}") D RELEASE(0) Q
 . S MSG1=MSG1_$$BREAD^XWBRW(6)
 . I $E(MSG1,11)="|" D
 . . S VL=$$BREAD^XWBRW(1),VL=$A(VL)
 . . S XWBVER=$$BREAD^XWBRW(VL)
 . . S LEN=$$BREAD^XWBRW(5)
 . . S MSG=$$BREAD^XWBRW(+LEN)
 . E  S X=$E(MSG1,11),LEN=$E(MSG1,6,10)-1,MSG2=$$BREAD^XWBRW(LEN),MSG=X_MSG2,XWBVER=0
 . ; -- msg should be:  action^client IP^client port^token
 . I XWBDEBUG D LOG^XWBDLOG("Hdr:"_MSG1_" Msg:"_MSG) ;(*p35)
 . ;
 . ; -- if the action is TCPconnect (usual case)
 . I $P(MSG,"^")="TCPconnect" D
 . . N DZ,%T S DZ="",%T=0,RETRY=$S($G(RETRY)>1:RETRY-1,1:0) ;(*p7*)
 . . ;Get the peer and use that IP, Allow use thru a NAT box.
 . . S NATIP=$$GETPEER^%ZOSV I $L(NATIP) S $P(MSG,"^",2)=NATIP ;(*p35)
 . . I '$$NEWJOB D QSND("reject") Q  ;(*p7,*p35)
 . . I XWBDEBUG>1 D LOG^XWBDLOG("JOB: "_MSG)
 . . ;Job a Server, X should be null
 . . J EN^XWBTCPC($P(MSG,"^",2),$P(MSG,"^",3),$P(DZ,"^"),XWBVER,$P(MSG,"^",4))::5 S %T=$T
 . . I %T D QSND("accept") ;(*p35)
 . . I '%T  D QSND("reject") ;(*p35)
 . ;
 . ; -- if the action is TCPdebug (when msg handler run interactively)
 . I $P(MSG,"^")="TCPdebug" D QSND("accept") ;(*p35)
 . ;
 . ; -- if the action is TCPshutdown, this listener will quit if the
 . ;    stop flag has been set.  This request comes from an M process.
 . I $P(MSG,"^")="TCPshutdown" S DONE=1 D QSND^XWBRW("ack")
 . D RELEASE(0) ;Now release the connection. (*p7*)
 . Q
 ; -- loop end
 ;
 S %=$$SEMAPHOR(XWBTSKT,"UNLOCK") ; destroy 'running flag'
 D LOG^XWBDLOG("Exit")
 D UPDTREC(XWBTSKT,6) ;updt RPC BROKER SITE PARAMETER record as STOPPED
 S $ETRAP="" ;(*p35) Turn off error trap
 IF XWBOS="DSM" C XWBTSKT ;Do Close last in case it gets an error
 Q
 ;
QSND(STR) ;Write output (*p35)
 D QSND^XWBRW(STR),LOG^XWBDLOG(STR)
 Q
 ;
ETRAP ; -- on trapped error, send error info to client
 N XWBERC,XWBERR S $ETRAP="D ^%ZTER J EN^XWBTCPL($G(XWBTSKT)) HALT"
 S XWBERC=$$EC^%ZOSV,XWBERR=$C(24)_"M  ERROR="_XWBERC_$C(13,10)_"LAST REF="_$$LGR^%ZOSV
 D ^%ZTER ;Record error and clear $ECODE
 D LOG^XWBDLOG("Error: "_$E(XWBERC,1,200))
 S RETRY=$G(RETRY)+1 H 3+(RETRY\5) ;(*p7*) Slow down but never stop
 ;Halt if DSM DUPNAME
 I XWBERC["F-DUPLNAM" D  HALT
 . S %=$$SEMAPHOR(XWBTSKT,"UNLOCK") ; destroy 'running flag'
 . D UPDTREC(XWBTSKT,6) ;updt RPC BROKER SITE PARAMETER record as STOPPED
 . Q
 S XWBDEBUG=$G(XWBDEBUG)
 ;Set new trap
 S $ETRAP="Q:($ESTACK&'$QUIT)  Q:$ESTACK -9 S $ECODE="""" G RESTART^XWBTCPL"
 ;
 I (XWBERC["READ")!(XWBERC["WRITE")!(XWBERC["SYSTEM-F") G ETRAPX
 IF XWBOS="DSM" D
 . I $D(XWBTLEN),XWBTLEN,XWBERC'["SYSTEM-F" D QSND(XWBERR) ;(p35)
 IF XWBOS="OpenM",XWBERC'["<WRITE>" D QSND(XWBERR) ;(*p7,35*)
 IF XWBOS="MSM" D QSND(XWBERR) ;(*p7,35*)
ETRAPX D RELEASE(1) ;Now close the connection. (*p7*)
 I XWBOS="DSM" H 15 ;Wait for device to close 
 S $ECODE=",U1," Q  ;Pass error up to pop stack.
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
 . W *-2 ;Release the socket
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
 N X,Y,XQVOL,XUVOL
 S X=$O(^XTV(8989.3,1,4,"B",XWBVOL,0)),XUVOL=$S(X>0:^XTV(8989.3,1,4,X,0),1:"ROU^y^1"),XQVOL=XWBVOL
 S X=$$INHIBIT^XUSRB ;Returns 1 if new logons are inhibited.
 Q 'X
