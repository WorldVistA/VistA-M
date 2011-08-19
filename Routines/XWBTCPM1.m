XWBTCPM1 ;ISF/RWF - Support for XWBTCPM ;05/20/2004  10:14
 ;;1.1;RPC BROKER;**35**;Mar 28, 1997
 Q
ZISTCP(XWBTSKT) ;Start ZISTCPS listener
 ;
 N XWBENV,XWBVOL,Y
 D GETENV^%ZOSV S XWBENV=Y,XWBVOL=$P(Y,"^",2)
 Q:'$$SEMAPHOR^XWBTCPL(XWBTSKT,"LOCK")  ;quit if job is already running
 D UPDTREC^XWBTCPL(XWBTSKT,3) ;updt RPC BROKER SITE PARAMETER record as RUNNING
 D MARKER^XWBTCP(XWBTSKT,-1) ;Clear marker
 ;
 D LISTEN^%ZISTCPS(XWBTSKT,"NT^XWBTCPM","D STAT^XWBTCPM1("_XWBTSKT_")")
 ;
 S %=$$SEMAPHOR^XWBTCPL(XWBTSKT,"UNLOCK") ; destroy 'running flag'
 D UPDTREC^XWBTCPL(XWBTSKT,6) ;updt RPC BROKER SITE PARAMETER record as STOPPED
 Q
 ;
OLD ;Call the old style broker
 ;XWBRBUF setup in XWBTCPM
 N XWBTCNT
 S XWBTCNT=0
 D READCONN ;Get the rest of the connect msg
 ; -- msg should be:  action^client IP^client port^token
 I $P(MSG,"^")="TCPconnect" D
 . N DZ,%T,NATIP S DZ="",%T=0
 . ;Get the peer and use that IP, Allow use thru a NAT box.
 . S NATIP=$$GETPEER^%ZOSV S:'$L(NATIP) NATIP=$P(MSG,"^",2)
 . I NATIP'=$P(MSG,"^",2) S $P(MSG,"^",2)=NATIP
 . I '$$NEWJOB^XWBTCPM D LOG("No New Jobs"),QSND("reject") Q
 . ;Keep the current job & Device.
 . ;just call the old server code. Uses a extra socket.
 . D QSND("accept"),LOG("accept")
 . D EN^XWBTCPC($P(MSG,"^",2),$P(MSG,"^",3),$P(DZ,"^"),XWBVER,$P(MSG,"^",4))
 Q
 ;
READCONN ;Read the rest of the connect message
 N CON,VL,LEN,MSG2
 S CON=$$BREAD(6,XWBTIME) I CON="" S CON="Timeout" D LOG(CON) Q
 I $E(CON,6)="|" D
 . S VL=$$BREAD(1),VL=$A(VL)
 . S XWBVER=$$BREAD(VL)
 . S LEN=$$BREAD(5)
 . S MSG=$$BREAD(+LEN)
 E  S X=$E(CON,6),LEN=$E(CON,1,5)-1,MSG2=$$BREAD(LEN),MSG=X_MSG2,XWBVER=0
 D LOG("Connect: "_MSG)
 Q
 ;
BREAD(L,TO) ;Buffer read
 S XWBTIME(1)=$G(TO,5)
 Q $$BREAD^XWBRW(L)
 ;
QSND(H) ;Quick send
 D QSND^XWBRW(H)
 Q
LOG(H) ;
 D:$G(XWBDEBUG) LOG^XWBDLOG(H)
 Q
 ;
NODE(P) ;Get Listener node, XWBENV must be set first
 N X,Y,BV
 I '$D(XWBENV) D GETENV^%ZOSV S XWBENV=Y
 S BV=$P(XWBENV,"^",4)
 S IX1=$O(^%ZIS(14.7,"B",BV,0)) I IX1'>0 Q "Box-Vol 1"
 S IX1=$O(^XWB(8994.1,1,7,"B",IX1,0)) I IX1'>0 Q "Box-Vol 2"
 S IX2=$O(^XWB(8994.1,1,7,IX1,1,"B",P,0)) I IX2'>0 Q "Port"
 S X=$G(^XWB(8994.1,1,7,IX1,1,IX2,0))
 Q X
 ;
STAT(P) ;Check if should stop.
 ;Called from ZRULE in %ZISTCPS
 N X
 S X=$$NODE(P)
 S ZISQUIT=($P(X,"^",2)>3) ;Status Stop
 Q
