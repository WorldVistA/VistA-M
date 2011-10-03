XOBUM ;; ld,mjk/alb - Foundations Manager ; 07/27/2002  13:00
 ;;1.6;Foundations;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point for XOBU FOUNDATIONS MAIN ListMan Template
 ; Option: XOBU SITE SETUP MENU on Operations Management menu [XUSITEMGR]
 ;
 DO EN^VALM("XOBU FOUNDATIONS MAIN")
 QUIT
 ;
HDR ; -- header code
 NEW Y,X
 SET Y=$GET(^XOB(18.01,1,0))
 SET VALMHDR(1)="                    <<<      VistALink Parameters     >>>"
 SET VALMHDR(2)=""
 SET X="    "
 SET X=X_"VistALink Version: "_$PIECE($TEXT(XOBUM+1),";",3)
 SET X=X_"    "
 SET X=X_"Heartbeat Rate: "_$PIECE(Y,U,2)
 SET X=X_"    "
 SET X=X_"Latency Delta: "_$PIECE(Y,U,3)
 SET VALMHDR(3)=X
 SET VALMHDR(4)=""
 SET VALMHDR(5)="                    <<< VistALink Listener Status Log >>>"
 QUIT
 ;
INIT ; -- init variables and list array
 DO CLEAR
 QUIT
 ;
BUILD ; -- init variables and list array
 NEW I,XOBI,XOB0,X,XOBDATA,XOBOS,XOBROOT,XOBTXT
 DO KILL
 ;
 SET VALMCNT=0
 SET XOBROOT=$NAME(XOBDATA("DILIST","ID"))
 DO LIST^DIC(18.04,"",".01;.02;.03;.04;.05;.06","","","","","","","",$NAME(XOBDATA))
 SET XOBI=0
 FOR  SET XOBI=$ORDER(@XOBROOT@(XOBI)) QUIT:'XOBI  DO
 . SET VALMCNT=VALMCNT+1
 . SET X=""
 . SET X=$$SETFLD^VALM1(VALMCNT,X,"ID")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.01)),X,"BOX")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.02)),X,"PORT")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.03)),X,"STATUS")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.05)),X,"DATE")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.06)),X,"CONFIG")
 . DO SET^VALM10(VALMCNT,X,VALMCNT)
 . SET ^TMP("XOB LISTENERS","IDX",$JOB,VALMCNT)=VALMCNT_"^"_+$GET(XOBDATA("DILIST",2,XOBI))
 ;
 QUIT:VALMCNT
 ;
 ;-- supported Kernel API to get OS version
 SET XOBOS=$$VERSION^%ZOSV(1)
 QUIT:XOBOS'["VMS"&(XOBOS'["DSM")
 SET XOBOS=$SELECT(XOBOS["VMS":"VMS",1:"DSM")
 ;
 ;-- display text for VistaLink TCPIP enabled (Cache/VMS or DSM)
 FOR I=1:1 SET XOBTXT=$PIECE($TEXT(@XOBOS+I),";;",2) QUIT:XOBTXT="$END$"  DO
 . SET VALMCNT=VALMCNT+1
 . DO SET^VALM10(VALMCNT,$$SETSTR^VALM1(XOBTXT,"",12,65))
 QUIT
 ;
HELP ; -- help code
 SET X="?" DO DISP^XQORM1 WRITE !!
 QUIT
 ;
EXIT ; -- exit code
 DO KILL
 QUIT
 ;
KILL ; -- kill off list location
 KILL ^TMP("XOB LISTENERS",$JOB)
 QUIT
 ;
EXPND ; -- expand code
 QUIT
 ;
START ; -- start a listener
 ; -- Protocol: XOBV LISTENER START
 NEW XOBOK
 DO FULL^VALM1
 IF $$START^XOBUM1() DO
 . SET VALMSG="Refresh to see 'RUNNING' status"
 ELSE  DO
 . DO PAUSE^VALM1
 DO REFRESH
 QUIT
 ;
BOX ; -- start this BOX-VOl default configuration
 ; -- Protocol: XOBV LISTENER BOX-VOL
 IF $$BOX^XOBUM1() SET VALMSG="Refresh to see 'RUNNING' status"
 DO REFRESH
 QUIT
 ;
STOP ; -- stop a listener
 ; -- Protocol: XOBV LISTENER STOP
 NEW Y,X,DATA,ENTRY,LOGDA,XOBOK
 DO FULL^VALM1
 DO EN^VALM2(XQORNOD(0),"S")
 SET ENTRY=+$ORDER(VALMY(""))
 IF 'ENTRY GOTO STOPQ
 ;
 SET DATA=$GET(^TMP("XOB LISTENERS","IDX",$JOB,ENTRY))
 DO SELECT^VALM10(+DATA,1)
 ;
 SET LOGDA=+$PIECE(DATA,U,2)
 SET XOBOK=$$STOP^XOBUM1(LOGDA)
 IF XOBOK SET VALMSG=">>> Listener may take up to 60 seconds to stop <<<"
 IF 'XOBOK DO ERROR(XOBOK)
 DO SELECT^VALM10(+DATA,0)
 ;
STOPQ ;
 DO REFRESH
 QUIT
 ;
PARMS ; -- maintain site parameters
 ; -- Protocol: XOBU SITE PARAMETERS
 NEW XOBOK
 DO FULL^VALM1
 SET XOBOK=$$PARMS^XOBUM1()
 IF 'XOBOK DO ERROR(XOBOK)
 ;
 ; -- Add users to VISTALINK PERSON file (#18.09)
 ; SET XOBOK=$$ADDPERS^XOBUM1()
 ; IF 'XOBOK DO ERROR(XOBOK)
 ;
 DO HDR
 DO REFRESH
 QUIT
 ;
CFG ; -- maintain listener configurations
 ; -- Protocol: XOBV LISTENER CONFIG
 NEW XOBOK
 DO FULL^VALM1
 SET XOBOK=$$CFG^XOBUM1()
 IF 'XOBOK DO ERROR(XOBOK)
 DO REFRESH
 QUIT
 ;
CP ; -- add connector proxy
 ; -- Protocol: XOBV LISTENER CONNECTOR PROXY
 NEW XOBOK
 DO FULL^VALM1
 SET XOBOK=$$CP^XOBUM1()
 IF 'XOBOK DO ERROR(XOBOK)
 DO REFRESH
 QUIT
 ;
CLEAR ; -- clean up log entries of non-listeners
 ; -- Protocol: XOBV LISTENER LOG CLEAR
 DO WAIT^DICD WRITE !
 DO CLEARLOG^XOBVTCP
 DO REFRESH
 QUIT
 ;
REFRESH ; -- refresh display
 ; -- Protocol: XOBU FOUNDATIONS MAIN REFRESH
 DO BUILD
 SET VALMBCK="R"
 QUIT
 ;
SS ; -- display M os system status
 ; -- Protocol: XOBU FOUNDATIONS SYSTEM STATUS
 DO FULL^VALM1
 IF $DATA(^%ZOSF("SS")) DO
 . XECUTE ^%ZOSF("SS")
 ELSE  DO
 . WRITE !,"Error: ^%ZOSF(""SS"") node is not defined."
 DO PAUSE^VALM1
 DO REFRESH
 QUIT
 ;
ERROR(XOBOK) ;
 WRITE !,$PIECE(XOBOK,U,2)
 DO PAUSE^VALM1
 QUIT
 ;
NOYET ; -- not yet available
 WRITE !!,"Action is under construction.",!
 DO PAUSE^VALM1
 SET VALMBCK="R"
 QUIT
 ;
VMS ; -- text for Cache/VMS TCPIP listener
 ;;
 ;;If this screen shows no running listener(s), it is likely that
 ;;the VistALink listener(s) for this system are managed by the
 ;;TCP/IP utility at the VMS system level and are already running.
 ;;
 ;;The following TCP/IP command will show the status of all
 ;;listener services with names starting with vlink:
 ;;      $ tcpip show service vlink*
 ;;Please contact IRM site staff for additional information
 ;;regarding the VistALink listener(s) such as port number(s).
 ;;$END$
DSM ; -- text for VMS/DSM TCPIP disclaimer
 ;;
 ;;This Foundations Manager screen cannot be used to manage
 ;;VistALink listeners under DSM.
 ;;
 ;;For DSM, use the VMS TCP/IP utility to manage VistALink
 ;;listeners. For example, the following TCP/IP command will
 ;;show the status of all listener services with names
 ;;starting with vlink:
 ;;
 ;;      $ tcpip show service vlink*
 ;;$END$
