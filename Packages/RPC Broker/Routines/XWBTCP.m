XWBTCP ;ISC-SF/EG - Control TCP listener ;07/08/2004  16:11
 ;;1.1;RPC BROKER;**1,9,35**;Mar 28, 1997
 ;
EN ; -- entry point for interactive use
 N X1,X2,XWBTDBG,XWBIP
 S XWBIP=""
 S:$G(IO("IP"))]"" XWBIP=IO("IP")
 W !,"Enter client address: "_XWBIP_"//" R X1:300 Q:'$T  Q:X1="^"
 W !,"   Enter client port: " R X2:300 Q:'$T  Q:X2="^"
 W ! S XWBTDBG=""
 IF X1="" S X1=XWBIP
 IF $L(X1),$L(X2) D EN^XWBTCPC(X1,X2,"","1.08")
 Q
 ;
STATSCRN(XWBNEW) ;Port STATUS field screen
 ;DA: FileMan DA array.  See STATCHG tag bellow for detailed descr.
 ;XWBCUR: Current value of STATUS field
 ;XWBNEW: New/requested value of STATUS field
 ;        The domain for XWBCUR and XWBNEW is the same as for the
 ;        ACTION variable, described at STATCHG tag bellow.
 N C,XWBCUR,RESULT
 S C=","
 S XWBCUR=$$GET1^DIQ(8994.171,DA_C_DA(1)_C_DA(2)_C,"STATUS","I")
 S RESULT=0
 I XWBCUR=3,XWBNEW=4 S RESULT=1 ;if stopping a running listener
 I XWBCUR=6,XWBNEW=1 S RESULT=1 ;if starting a stopped listener
 ;    the next two cases are most usefull whenever some error occurs
 ;    and the STATUS field is stuck in STARTING or RUNNING state
 I XWBCUR=2,XWBNEW=3 S RESULT=1 ;change to RUNNING if it's starting
 I XWBCUR=5,XWBNEW=6 S RESULT=1 ;change to STOPPED if it's stopping
 Q RESULT
 ;
 ;
STATCHG(DA,ACTION) ;STATUS field X-ref SET logic
 ;DA: FileMan DA array
 ;  DA    =IEN of the port
 ;  DA(1) =IEN of the BOX-VOLUME
 ;  DA(2) =IEN of site/domain
 ;ACTION: Requested value for the STATUS field.  Possible values are:
 ;  1 = START, 2 = STARTING, 3 = RUNNING,
 ;  4 = STOP,  5 = STOPPING, 6 = STOPPED
 N C,ZTCPU,TYPE,XWBPORT,XWBFDA
 S C=","
 ;
 I ACTION=1!(ACTION=4) D
 . S ZTCPU=$$GET1^DIQ(8994.17,DA(1)_C_DA(2)_C,"BOX-VOLUME PAIR")
 . S XWBPORT=$$GET1^DIQ(8994.171,DA_C_DA(1)_C_DA(2)_C,"PORT")
 . S TYPE=$$GET1^DIQ(8994.171,DA_C_DA(1)_C_DA(2)_C,"TYPE OF LISTENER","I")
 . ;UCI is no longer derived from the file, but comes from current
 . ;environment.  The reason for that is it makes no sense to start
 . ;a listener in a UCI where ^XWB can't be reached to change status.
 . D GETENV^%ZOSV
 . S ZTUCI=$P(Y,U),ZTIO="",ZTREQ="@",ZTDTH=$H ;run it ASAP
 . I ACTION=1 D    ; -- START listener
 . . S ZTDESC="RPC Broker Listener START on "_ZTUCI_"-"_ZTCPU_", port "_XWBPORT
 . . S ZTRTN=$S(TYPE=1:"ZISTCP^XWBTCPM1("_XWBPORT_")",1:"EN^XWBTCPL("_XWBPORT_")")
 . E  D            ; -- STOP listener
 . . S ZTDESC="RPC Broker Listener STOP on "_ZTUCI_"-"_ZTCPU_", port "_XWBPORT
 . . S ZTRTN="STOP^XWBTCP("_XWBPORT_")"
 . D EN^DDIOL("Task: "_ZTDESC,"","!?10") ;inform user
 . D ^%ZTLOAD      ; queue it
 . D EN^DDIOL("has been queued as task "_ZTSK,"","!?10") ;inform user
 . ; --  change STATUS from START to STARTING or from STOP to STOPPING
 . D FDA^DILF(8994.171,DA_C_DA(1)_C_DA(2)_C,1,"R",ACTION+1,"XWBFDA")
 . D FILE^DIE("K","XWBFDA")
 Q
 ;
 ;
STRT(XWBTSKT) ;start TCP Listener.  Interactive entry point
 N IP,REF,Y,%
 S U="^" D HOME^%ZIS
 W "Start TCP Listener...",!
 X ^%ZOSF("UCI") S REF=Y
 S IP="0.0.0.0" ;get server IP at some point
 IF $G(XWBTSKT)="" S XWBTSKT=9000 ;default service port is 9000
 ;
 ; -- see if 'running flag' for listener is set
 I '$$SEMAPHOR^XWBTCPL(XWBTSKT,"LOCK") W "TCP Listener on port "_XWBTSKT_" appears to be running already.",! Q
 S %=$$SEMAPHOR^XWBTCPL(XWBTSKT,"UNLOCK")
 ;
 D MARKER(XWBTSKT,1) ;record problem marker
 ; -- start the listener
 J EN^XWBTCPL(XWBTSKT)::5 ;Used in place of TaskMan, Need to start on any node.
 I '$T W "Unable to run TCP Listener in background.",! Q
 F %=1:1:5 D  Q:%=0
 . W "Checking if TCP Listener has started...",!
 . H 3
 . S:'$$MARKER(XWBTSKT,0) %=0
 I $$MARKER(XWBTSKT,0) D
 . W !,"TCP Listener could not be started!",!
 . W "Check if port "_XWBTSKT_" is busy on this CPU.",!
 . D MARKER(XWBTSKT,-1) ;clear marker
 E  W "TCP Listener started successfully."
 Q
 ;
MARKER(PORT,MODE) ;Set/Test/Clear Problem Marker, Mode=0 is a function
 N IP,Y,%,REF X ^%ZOSF("UCI") S REF=Y,IP="0.0.0.0",%=0
 L +^XWB(IP,REF,XWBTSKT,"PROBLEM MARKER")
 I MODE=1 S ^XWB(IP,REF,XWBTSKT,"PROBLEM MARKER")=1
 I MODE=0 S:$D(^XWB(IP,REF,XWBTSKT,"PROBLEM MARKER")) %=1
 I MODE=-1 K ^XWB(IP,REF,XWBTSKT,"PROBLEM MARKER")
 L -^XWB(IP,REF,XWBTSKT,"PROBLEM MARKER")
 Q:MODE=0 % Q
 ;
STRTALL ;XWB LISTENER STARTER option entry point
 ;here all listener entries in RPC Broker Site Parameters file that
 ;have CONTROLLED BY LISTENER STARTER set to 1/Yes will be started.
 N E,LSTN,LSTNID,LSTNIENS,PORTID,XWBSCR,XWBDA
 ;XWBDA: Namespaced FileMan DA array
 ;  XWBDA    =IEN of the port
 ;  XWBDA(1) =IEN of the BOX-VOLUME
 ;  XWBDA(2) =IEN of site/domain
 S E=""
 S XWBDA(2)=1 ;hard set IEN of site/domain
 ; -- screen out RUNNING (STATUS=3) listeners and those that aren't controlled by XWB LISTENER STARTER option.
 S XWBSCR="I $P(^(0),U,2)'=3,$P(^(0),U,4)"
 ; -- get top level listners box-volume
 D LIST^DIC(8994.17,",1,",E,E,E,E,E,E,E,E,$NA(LSTN("LSTNR")))
 S LSTNID=""
 F  S LSTNID=$O(LSTN("LSTNR","DILIST",1,LSTNID)) Q:LSTNID=""  D
 . S XWBDA(1)=LSTN("LSTNR","DILIST",2,LSTNID) ;IEN of each listener
 . S LSTNIENS=","_XWBDA(1)_","_XWBDA(2)_","
 . D LIST^DIC(8994.171,LSTNIENS,E,"P",E,E,E,E,XWBSCR,E,$NA(LSTN("PORT")))
 . S PORTID=0
 . F  S PORTID=$O(LSTN("PORT","DILIST",PORTID)) Q:PORTID=""  D
 . . S XWBDA=$P(LSTN("PORT","DILIST",PORTID,0),U,1)
 . . D STATCHG(.XWBDA,1) ;use STATUS field X-ref SET logic to queue up start of a listener
 Q
 ;
STOPALL ;XWB LISTENER STOP ALL entry point
 ;here all listener entries in RPC Broker Site Parameters file that
 ;have CONTROLLED BY LISTENER STARTER set to 1/Yes will be stopped.
 N E,LSTN,LSTNID,LSTNIENS,PORTID,XWBSCR,XWBDA
 ;XWBDA: Namespaced FileMan DA array
 ;  XWBDA    =IEN of the port
 ;  XWBDA(1) =IEN of the BOX-VOLUME
 ;  XWBDA(2) =IEN of site/domain
 S E=""
 S XWBDA(2)=1 ;hard set IEN of site/domain
 ; -- screen out STOPPED (STATUS=3) listeners and those that aren't controlled by XWB LISTENER STARTER option.
 S XWBSCR="I $P(^(0),U,2)'=6,$P(^(0),U,4)"
 ; -- get top level listners box-volume
 D LIST^DIC(8994.17,",1,",E,E,E,E,E,E,E,E,$NA(LSTN("LSTNR")))
 S LSTNID=""
 F  S LSTNID=$O(LSTN("LSTNR","DILIST",1,LSTNID)) Q:LSTNID=""  D
 . S XWBDA(1)=LSTN("LSTNR","DILIST",2,LSTNID) ;IEN of each listener
 . S LSTNIENS=","_XWBDA(1)_","_XWBDA(2)_","
 . D LIST^DIC(8994.171,LSTNIENS,E,"P",E,E,E,E,XWBSCR,E,$NA(LSTN("PORT")))
 . S PORTID=0
 . F  S PORTID=$O(LSTN("PORT","DILIST",PORTID)) Q:PORTID=""  D
 . . S XWBDA=$P(LSTN("PORT","DILIST",PORTID,0),U,1)
 . . D STATCHG(.XWBDA,4) ;use STATUS field X-ref SET logic to queue up stop of a listener
 Q
 ;
RESTART ;Stop and then Start all listeners.
 D STOPALL H 15 D STRTALL
 Q
 ;
STOP(XWBTSKT) ;stop TCP Listener.  Interactive and TaskMan entry point
 N IP,REF,X,DEV,XWBOS,XWBIP,XWBENV
 S U="^" D HOME^%ZIS,GETENV^%ZOSV S XWBENV=Y
 D EN^DDIOL("Stop TCP Listener...")
 X ^%ZOSF("UCI") S REF=Y
 S IP="0.0.0.0" ;get server IP
 IF $G(XWBTSKT)="" S XWBTSKT=9000 ;default service port is 9000
 ;
 S XWBOS=$S(^%ZOSF("OS")["DSM":"DSM",^("OS")["MSM":"MSM",^("OS")["OpenM":"OpenM",1:"") ;RWF
 ;
 ; -- make sure the listener is running
 I $$SEMAPHOR^XWBTCPL(XWBTSKT,"LOCK") D  Q
 . S %=$$SEMAPHOR^XWBTCPL(XWBTSKT,"UNLOCK")
 . D EN^DDIOL("TCP Listener does not appear to be running.")
 ;
 S X=$$NODE^XWBTCPM1(XWBTSKT) ;Get node
 I $P(X,"^",3)=1 D  Q
 . D EN^DDIOL("New listener should stop on its own")
 ;
 ; -- send the shutdown message to the TCP Listener process
 ;    using loopback address
 S XWBIP="127.0.0.1"
 D CALL^%ZISTCP("127.0.0.1",XWBTSKT) I POP D  Q
 . S %=$$SEMAPHOR^XWBTCPL(XWBTSKT,"UNLOCK")
 . D EN^DDIOL("TCP Listener does not appear to be running.")
 U IO
 ;
 S X=$T(+2),X=$P(X,";;",2),X=$P(X,";")
 IF X="" S X=0
 S X=$C($L(X))_X
 W "{XWB}00020|"_X_"00011TCPshutdown",!
 R X:5
 D CLOSE^%ZISTCP
 IF X["ack" D EN^DDIOL("TCP Listener has been shutdown.")
 ELSE  D EN^DDIOL("Shutdown Failed!")
 Q
 ;
DEBUG ;Edit the debug parameter
 W !!
 D EDITPAR^XPAREDIT("XWBDEBUG")
 W !!
 Q
