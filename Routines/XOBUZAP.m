XOBUZAP ;; mjk/alb - Terminate Jobs Utility ; 08/4/2005  13:00
 ;;1.6;Foundations;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ----------------------- Main Entry Points -----------------------
 ;
EN(XOBSEL) ; -- Interactive and main entry point for XOBU TERMINATE JOBS tool
 ;
 ; Input: XOBSEL array that specifies selection criteria
 ;           XOBSEL("ROUTINE")=<routine name>
 ;           XOBSEL("STATE")=<job state#> (see STATE tag for list of states)
 ;           XOBSEL("TITLE")=optional title text to be used by ListManager (upper right of LM screen)
 ;           XOBSEL("VISTA INFO REF")=optional reference to array or global containing "CLIENT IP" and "DUZ" nodes
 ;           
 ; -- verify job selection critera
 IF '$$VERSEL(.XOBSEL) DO  GOTO ENQ
 . WRITE !,"Job selection criteria not specified correctly or is missing!"
 ;
 ; -- start 'Terminate Jobs Utility'
 DO EN^VALM("XOBU TERMINATE JOBS UTILITY")
ENQ ;
 QUIT
 ;
ZAP(XOBSEL) ; -- Non-interactive entry point for XOBU TERMINATE JOBS tool
 ;                  API terminates all jobs that job selection criteria
 ;                  
 ;  Input: XOBSEL array that specifies selection criteria (See above EN tag for information)
 ;
 ; Return: Count of how many jobs terminated OR
 ;         -1 if MUMPS implementation is not Cache
 ;         -2 if XOBSEL arrary is not passed in or is invalid.
 ;            
 NEW XOBJOBS,XOBPID,XOBCNS,XOBCNT
 ; -- check if this is a Cache implementation
 IF '$$CACHE() SET XOBCNT=-1 GOTO ZAPQ
 ;
 ; -- verify job selection critera
 IF '$$VERSEL(.XOBSEL) SET XOBCNT=-2 GOTO ZAPQ
 ;
 DO GETJOBS(.XOBJOBS)
 SET XOBCNS=$$CURNS()
 SET XOBCNT=0
 SET XOBPID=""
 FOR  SET XOBPID=$ORDER(XOBJOBS(XOBPID)) QUIT:XOBPID=""  DO
 . IF $$CHECK(.XOBSEL,XOBPID,XOBCNS) DO
 . . SET XOBRES=$$TERMJOB(XOBPID)
 . . IF XOBRES=1 SET XOBCNT=XOBCNT+1
ZAPQ ;
 QUIT XOBCNT
 ;
 ; ----------------------- Listman Related Code -----------------------
 ;
HDR ; -- header code
 SET VALMHDR(1)="    "_IOUON_"Job Selection Criteria"_IOUOFF_" (matches: "_+$GET(VALMCNT)_")"
 SET VALMHDR(2)="     Box-Volume Pair: "_IOINHI_$$BOXVOL()_IOINORM
 SET VALMHDR(3)="   Current Namespace: "_IOINHI_$$CURNS()_IOINORM
 SET VALMHDR(4)="             Routine: "_IOINHI_$GET(XOBSEL("ROUTINE"),"Unknown")_IOINORM
 SET VALMHDR(5)="           Job State: "_IOINHI_$PIECE($$GETSTATE^XOBUZAP0(+$GET(XOBSEL("STATE"),";;;Unknown")),";",4)_IOINORM
 QUIT
 ;
INIT ; -- init variables and list array
 IF $DATA(XOBSEL("TITLE")) SET VALM("TITLE")=XOBSEL("TITLE")
 DO BUILD
 SET VALMSG=$$CPMSG()
 QUIT
 ;
BUILD ; -- build list based on job selection criteria (XOBSEL)
 NEW XOBJOBS,XOBPID,XOBCNS
 DO KILL
 DO KILL^VALM10()
 IF '$$CACHE() DO  GOTO BUILDQ
 . DO SET^VALM10(1,"",1)
 . DO SET^VALM10(2,"",2)
 . DO SET^VALM10(3,"   'Terminate' actions not supported for the current M implementation ["_$$MUMPS()_"].",3)
 . SET VALMCNT=3
 SET XOBCNS=$$CURNS()
 DO GETJOBS(.XOBJOBS)
 SET VALMCNT=0
 SET XOBPID=""
 FOR  SET XOBPID=$ORDER(XOBJOBS(XOBPID)) QUIT:XOBPID=""  DO
 . IF $$CHECK(.XOBSEL,XOBPID,XOBCNS) DO
 . . NEW XOBJINFO
 . . DO JOBINFO(XOBPID,.XOBJINFO,.XOBSEL)
 . . SET VALMCNT=VALMCNT+1
 . . SET X=""
 . . SET X=$$SETFLD^VALM1($JUSTIFY(VALMCNT,4),X,"ENTRY")
 . . SET X=$$SETFLD^VALM1(XOBPID,X,"PID")
 . . SET X=$$SETFLD^VALM1($EXTRACT($GET(XOBJINFO("DEVICE"))_":"_$GET(XOBJINFO("CLIENT IP")),1,34),X,"DEVICE")
 . . SET X=$$SETFLD^VALM1($EXTRACT("User="_$SELECT($GET(XOBJINFO("CONNECTOR USER")):"*",1:"")_$GET(XOBJINFO("VISTA USER NAME")),1,30),X,"COMMENT")
 . . DO SET^VALM10(VALMCNT,X,VALMCNT)
 . . SET ^TMP("XOB TERMINATE JOBS","IDX",$JOB,VALMCNT,VALMCNT)=XOBPID
 ;
BUILDQ ;
 QUIT
 ;
KILL ; -- kill off list location
 KILL ^TMP("XOB TERMINATE JOBS",$JOB)
 KILL ^TMP("XOB TERMINATE JOBS","IDX",$JOB)
 QUIT
 ;
HELP ; -- help code
 SET X="?" DO DISP^XQORM1 WRITE !!
 QUIT
 ;
EXIT ; -- exit code
 QUIT
 ;
EXPND ; -- expand code
 QUIT
 ;
MSG ; -- set default message
 SET VALMSG="Use RE (Refresh) to display only alive jobs "
 QUIT
 ;
CPMSG() ; -- connection proxy user message
 QUIT "* Connector Proxy User"
 ;
REFRESH ; -- refresh display
 ; -- Protocol: XOBU TERMINATE JOBS REFRESH
 DO BUILD
 SET VALMSG=$$CPMSG()
 KILL VALMHDR
 SET VALMBCK="R"
 QUIT
 ;
SS ; -- display M os system status
 ; -- Protocol: XOBU TERMINATE SYSTEM STATUS
 DO FULL^VALM1
 IF $DATA(^%ZOSF("SS")) DO
 . XECUTE ^%ZOSF("SS")
 ELSE  DO
 . WRITE !,"Error: ^%ZOSF(""SS"") node is not defined."
 DO PAUSE^VALM1
 DO REFRESH
 QUIT
 ;
TERMALL ; -- terminate all pid/job
 ; -- Protocol: XOBU TERMINATE ALL JOBS
 IF '$$ASK() GOTO TERMALLQ
 NEW XOBI,XOBPID
 SET XOBI=""
 FOR  SET XOBI=$ORDER(^TMP("XOB TERMINATE JOBS","IDX",$JOB,XOBI)) QUIT:XOBI=""  DO
 . SET XOBPID=$GET(^TMP("XOB TERMINATE JOBS","IDX",$JOB,XOBI,XOBI))
 . DO TERMONE(XOBPID,XOBI)
 DO MSG
TERMALLQ ;
 SET VALMBCK=""
 QUIT
 ;
TERMPID ; -- terminate pid/job
 ; -- Protocol: XOBU TERMINATE A JOB 
 NEW XOBI,VALMY,XOBPID,XOBRES
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF XOBI>0 DO
 . NEW XOBPID
 . SET XOBPID=$GET(^TMP("XOB TERMINATE JOBS","IDX",$JOB,XOBI,XOBI))
 . ; -- highlight entire line
 . DO SELECT^VALM10(XOBI,1)
 . IF XOBPID="<terminated>" DO  QUIT
 . . WRITE !,"Job has already been terminated!" DO PAUSE^VALM1
 . ;
 . IF $$ASK() DO
 . . DO TERMONE(XOBPID,XOBI),MSG
 . ELSE  DO
 . . ; -- unhighlight entire line
 . . DO SELECT^VALM10(XOBI,0)
 SET VALMBCK=""
 QUIT
 ;
TERMONE(XOBPID,XOBI) ; -- zap one pid and update display
 NEW XOBRES
 ; -- quit if already terminated
 IF XOBPID="<terminated>" QUIT
 ; -- make sure criteris is still met
 IF '$$CHECK(.XOBSEL,XOBPID,$$CURNS()) DO  QUIT
 . ; -- insert warning comment into display line
 . DO FLDTEXT^VALM10(XOBI,"COMMENT","Criteria not met!")
 . ; -- highlight entire line
 . DO SELECT^VALM10(XOBI,1)
 ; -- terminate job
 SET XOBRES=$$TERMJOB(XOBPID)
 ; -- insert comment into display line
 DO FLDTEXT^VALM10(XOBI,"COMMENT",$EXTRACT($$RESULT(XOBRES),1,25))
 ; -- highlight entire line
 DO SELECT^VALM10(XOBI,1)
 ; -- remove PID so it can't be terminated again
 SET ^TMP("XOB TERMINATE JOBS","IDX",$JOB,XOBI,XOBI)="<terminated>"
 QUIT
 ;
ASK(PROMPT) ; -- ask if user is sure
 NEW DIR,Y
 SET DIR("A")=$GET(PROMPT,"Are you sure")
 SET DIR("B")="NO",DIR(0)="Y"
 DO ^DIR
 QUIT +$GET(Y)
 ;
RESULT(RESULT) ; -- return result text
 ; -- Note: Code number conversions found in RESJOB routine in %SYS namespace
 IF RESULT=1 QUIT "Process terminated"
 IF RESULT=-1 QUIT "Process not responding"
 IF RESULT=-2 QUIT "Process died, not responding"
 IF RESULT=-3 QUIT "Process already died"
 QUIT RESULT_" --> unknown result type"
 ;
 ; ---------- Code used by Interactive and Non-Interactive Entry Points ----------
 ;
VERSEL(XOBSEL) ; -- every job selection criteria
 NEW XOBOK
 IF $GET(XOBSEL("ROUTINE"))=""!($GET(XOBSEL("STATE"))="") SET XOBOK=0 GOTO VERSELQ
 SET XOBOK=1
VERSELQ ;
 QUIT XOBOK
 ;
GETJOBS(XOBJOBS) ; -- build XOBJOBS()=pid information
 NEW XOBPID,XOBCNT
 SET XOBPID="",XOBCNT=0
 FOR  SET XOBPID=$ORDER(^$JOB(XOBPID)) QUIT:XOBPID=""  DO
 . SET XOBCNT=XOBCNT+1,XOBJOBS(XOBPID)=""
 QUIT
 ;
CHECK(XOBSEL,XOBPID,XOBNS) ; -- check job info against selection criteria
 ; -- use if 1) in correct namespace [XOBNS],
 ;           2) in correct routine [XOBSEL("ROUTINE")] and
 ;           3) in correct process state [XOBSEL("STATE")]
 NEW XOBJINFO
 DO JOBINFO(XOBPID,.XOBJINFO,.XOBSEL)
 IF XOBJINFO("NAMESPACE")=XOBNS,XOBJINFO("ROUTINE")=$GET(XOBSEL("ROUTINE")),XOBJINFO("STATE")=$GET(XOBSEL("STATE")) QUIT 1
 QUIT 0
 ;
JOBINFO(XOBPID,XOBJINFO,XOBSEL) ; -- get PID info
 ; -- In future (Cache v5+) use instance proprties of %SYSTEM.Process
 SET XOBJINFO("STATE")=+$ZUTIL(67,4,XOBPID)
 SET XOBJINFO("ROUTINE")=$ZUTIL(67,5,XOBPID)
 SET XOBJINFO("NAMESPACE")=$ZUTIL(67,6,XOBPID)
 SET XOBJINFO("DEVICE")=$ZUTIL(67,7,XOBPID)
 SET XOBJINFO("OS USERNAME")=$ZUTIL(67,11,XOBPID) ; currently not used
 ;
 ; -- get VistA Info is available
 IF $GET(XOBSEL("VISTA INFO REF"))]"" DO
 . NEW XOBY,XOBREF
 . SET XOBREF=$$GETREF^XOBUZAP0(XOBSEL("VISTA INFO REF"),XOBPID)
 . ;
 . SET XOBJINFO("VISTA DUZ")=+$$GETDUZ^XOBUZAP0(XOBREF)
 . SET XOBY=$PIECE($GET(^VA(200,XOBJINFO("VISTA DUZ"),0)),U)
 . SET XOBJINFO("VISTA USER NAME")=$SELECT(XOBY]"":XOBY,1:"<unknown>")
 . SET XOBJINFO("CONNECTOR USER")=$$CPCHK^XUSAP(XOBJINFO("VISTA DUZ"))
 . ;
 . SET XOBY=$$GETIP^XOBUZAP0(XOBREF)
 . SET XOBJINFO("CLIENT IP")=$SELECT(XOBY]"":XOBY,1:"<unknown>")
 QUIT
 ;
TERMJOB(XOBPID) ; -- terminate pid/job
 ; -- In future (Cache v5+) use instance method %SYSTEM.Process.Terminate()
 ;QUIT 1  ; -- used for testing
 QUIT $ZUTIL(4,XOBPID)
 ;
BOXVOL() ; -- cpu volume pair
 NEW Y DO GETENV^%ZOSV
 QUIT $P(Y,U,4)
 ;
CURNS() ; -- get current namespace
 QUIT $ZUTIL(5)
 ;
MUMPS() ; -- get MUMPS implementation
 QUIT $SELECT(^%ZOSF("OS")["OpenM":"OpenM",^("OS")["DSM":"DSM",^("OS")["UNIX":"UNIX",^("OS")["MSM":"MSM",1:"")
 ;
CACHE() ; -- is this a Cache implementation
 QUIT $$MUMPS()["OpenM"
 ;
