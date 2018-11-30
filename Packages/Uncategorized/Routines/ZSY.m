ZSY ;ISF/RWF,VEN/SMH - GT.M/VA system status display ;2018-06-06  1:27 PM
 ;;8.0;KERNEL;**349,10001,10002**;Jul 10, 1995;Build 26
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Original Routine of unknown provenance -- was in unreleased VA patch XU*8.0*349 and thus perhaps in the public domain.
 ; Rewritten by KS Bhaskar and Sam Habiel 2005-2015
 ; Sam: JOBEXAM, WORK, USHOW, UNIX, UNIXLSOF, INTRPT, INTRPTALL, HALTALL, ZJOBff
 ; Bhaskar provided pipe implementations of various commands.
 ;GT.M/VA %SY utility - status display
 ;
EN ; [Public] Main Entry Point
 ;From the top just show by PID
 N MODE
 L +^XUTL("XUSYS","COMMAND"):1 I '$T G LW
 S MODE=0 D WORK(MODE)
 Q
 ;
QUERY ; [Public] Alternate Entry Point
 N MODE,X
 L +^XUTL("XUSYS","COMMAND"):1 I '$T G LW
 S X=$$ASK W ! I X=-1 L -^XUTL("XUSYS","COMMAND") Q
 S MODE=+X D WORK(MODE)
 Q
 ;
TMMGR ; [Public] Show only taskman manager tasks
 N MODE
 L +^XUTL("XUSYS","COMMAND"):1 I '$T G LW
 N FILTER S FILTER("%ZTM")="",FILTER("%ZTM0")=""
 S MODE=0 D WORK(MODE,.FILTER)
 QUIT
 ;
TMSUB ; [Public] Show only taskman submanager tasks
 N MODE
 L +^XUTL("XUSYS","COMMAND"):1 I '$T G LW
 N FILTER S FILTER("%ZTMS1")=""
 S MODE=0 D WORK(MODE,.FILTER)
 QUIT
 ;
ASK() ;Ask sort item
 ; ZEXCEPT: %utAnswer
 I $D(%utAnswer) Q %utAnswer
 N RES,X,GROUP
 S RES=0,GROUP=2
 W !,"1 pid",!,"2 cpu time"
 F  R !,"1// ",X:600 S:X="" X=1 Q:X["^"  Q:(X>0)&(X<3)  W " not valid"
 Q:X["^" -1
 S X=X-1,RES=(X#GROUP)_"~"_(X\GROUP)
 Q RES
 ;
 ;
JOBEXAM(%ZPOS) ; [Public; Called by ^ZU]
 ; Preserve old state for process
 N OLDIO S OLDIO=$IO
 N %reference S %reference=$REFERENCE
 K ^XUTL("XUSYS",$J,"JE")
 ;
 ; Halt the Job if requested - no need to do other work
 I $G(^XUTL("XUSYS",$J,"CMD"))="HALT" D H2^XUSCLEAN G HALT^ZU
 ;
 ;
 ; Save these
 S ^XUTL("XUSYS",$J,0)=$H
 S ^XUTL("XUSYS",$J,"JE","INTERRUPT")=$G(%ZPOS)
 S ^XUTL("XUSYS",$J,"JE","ZMODE")=$ZMODE ; SMH - INTERACTIVE or OTHER
 I %ZPOS'["GTM$DMOD" S ^XUTL("XUSYS",$J,"JE","codeline")=$T(@%ZPOS)
 I $G(DUZ) S ^XUTL("XUSYS",$J,"JE","UNAME")=$P($G(^VA(200,DUZ,0)),"^")
 E           S ^XUTL("XUSYS",$J,"JE","UNAME")=$G(^XUTL("XUSYS",$J,"NM"))
 ;
 ;
 ; Default System Status.
 ; S -> Stack
 ; D -> Devices
 ; G -> Global Stats
 ; L -> Locks
 I '$D(^XUTL("XUSYS",$J,"CMD")) ZSHOW "SGDL":^XUTL("XUSYS",$J,"JE") ; Default case -- most of the time this is what happens.
 ;
 ; Examine the Job
 ; ZSHOW "*" is "BDGILRV"
 ; B is break points
 ; D is Devices
 ; G are global stats
 ; I is ISVs
 ; L is Locks
 ; R is Routines with Hash (similar to S)
 ; V is Variables
 ; ZSHOW "*" does not include:
 ; A -> Autorelink information
 ; C -> External programs that are loaded (presumable with D &)
 ; S -> Stack (use R instead)
 I $G(^XUTL("XUSYS",$J,"CMD"))="EXAM"!($P($G(^("CMD")),U)="DEBUG") ZSHOW "*":^XUTL("XUSYS",$J,"JE")
 ;
 ; ^XUTL("XUSYS",8563,"JE","G",0)="GLD:*,REG:*,SET:25610,KIL:593,GET:12284,...
 ; Just grab the default region only. Decreases the stats as a side effect from this utility
 N GLOSTAT
 N I F I=0:0 S I=$O(^XUTL("XUSYS",$J,"JE","G",I)) Q:'I  I ^(I)[$ZGLD,^(I)["DEFAULT" S GLOSTAT=^(I)
 I GLOSTAT]"" N I F I=1:1:$L(GLOSTAT,",") D
 . N EACHSTAT S EACHSTAT=$P(GLOSTAT,",",I)
 . N SUB,OBJ S SUB=$P(EACHSTAT,":"),OBJ=$P(EACHSTAT,":",2)
 . S ^XUTL("XUSYS",$J,"JE","GSTAT",SUB)=OBJ
 ;
 ; Capture IO statistics for this process
 ; ZEXCEPT: READONLY,REWIND
 I $ZV["Linux" D
 . N F S F="/proc/"_$J_"/io"
 . O F:(READONLY:REWIND):0 E  Q
 . U F
 . N DONE S DONE=0 ; $ZEOF doesn't seem to work (https://github.com/YottaDB/YottaDB/issues/120)
 . N X F  R X:0 U F D  Q:DONE
 .. I X["read_bytes"  S ^XUTL("XUSYS",$J,"JE","RBYTE")=$P(X,": ",2)
 .. I X["write_bytes" S ^XUTL("XUSYS",$J,"JE","WBYTE")=$P(X,": ",2) S DONE=1
 . U OLDIO C F
 ;
 ; Capture String Pool Stats: Full size - Freed Data
 ; spstat 2nd piece is the actual size--but that fluctuates wildly
 ; I use the full size allocated (defaults at 0.10 MB) - the size freed.
 n spstat s spstat=$view("spsize")
 ;
 S ^XUTL("XUSYS",$J,"JE","SPOOL")=spstat
 S ^XUTL("XUSYS",$J,"JE","HEAP_MEM")=$p(spstat,",",1)-$p(spstat,",",3)
 ;
 ; Done. We can tell others we are ready
 SET ^XUTL("XUSYS",$J,"JE","COMPLETE")=1
 ;
 ; TODO: IMPLEMENT DEBUG
 I $P($G(^XUTL("XUSYS",$J,"CMD")),U)="DEBUG" QUIT  ; **NOT IMPLEMENTED**
 ;
 ; Restore old IO and $R
 U OLDIO
 I %reference
 Q 1
 ;
WORK(MODE,FILTER) ; [Private] Main driver, Will release lock
 ; int MODE
 ; FILTER ref
 N USERS,GROUP,PROCID
 N TNAME,I,SORT,TAB
 N $ES,$ET
 n %PS,RTN,%OS,DONE
 ;
 ;Save $ZINTERRUPT, set new one
 N OLDINT
 S OLDINT=$ZINTERRUPT,$ZINTERRUPT="I $$JOBEXAM^ZU($ZPOSITION) S DONE=1"
 ;
 ;Clear old data
 S ^XUTL("XUSYS","COMMAND")="Status"
 ;
 S I=0 F  S I=$O(^XUTL("XUSYS",I)) Q:'I  K ^XUTL("XUSYS",I,"CMD"),^("JE")
 ;
 ; Counts; Turn on Ctrl-C.
 ; ZEXCEPT: CTRAP,NOESCAPE,NOFILTER
 N USERS S USERS=0
 U $P:(CTRAP=$C(3):NOESCAPE:NOFILTER)
 ;
 ;Go get the data
 D UNIX(MODE,.USERS,.SORT)
 ;
 ;Now show the results
 I USERS D
 . D HEADER(.TAB),USHOW(.TAB,.SORT,.FILTER)
 . W !!,"Total ",USERS," user",$S(USERS>1:"s.",1:"."),!
 . Q
 E  W !,"No current GT.M users.",!
 ;
 ;
EXIT ;
 L -^XUTL("XUSYS","COMMAND") ;Release lock and let others in
 I $L($G(OLDINT)) S $ZINTERRUPT=OLDINT
 U $P:CTRAP=""
 Q
 ;
ERR ;
 U $P W !,$P($ZS,",",2,99),!
 D EXIT
 Q
 ;
LW ;Lock wait
 W !,"Someone else is running the System status now."
 Q
 ;
HEADER(TAB) ;Display Header
 ; ZEXCEPT: AB
 W #
 S IOM=+$$AUTOMARG
 W !,"GT.M System Status users on ",$$DATETIME($H)
 W:IOM>80 " - (stats reflect accessing DEFAULT region ONLY except *)"
 S TAB(0)=0,TAB(1)=6,TAB(2)=14,TAB(3)=18,TAB(4)=27,TAB(5)=46,TAB(6)=66
 S TAB(7)=75,TAB(8)=85,TAB(9)=100,TAB(10)=110,TAB(11)=115,TAB(12)=123
 S TAB(13)=130,TAB(14)=141,TAB(15)=150
 U 0:FILTER="ESCAPE"
 W !
 D EACHHEADER("PID",TAB(0))
 D EACHHEADER("PName",TAB(1))
 D EACHHEADER("Device",TAB(2))
 D EACHHEADER("Routine",TAB(4))
 D EACHHEADER("Name",TAB(5))
 D EACHHEADER("CPU Time",TAB(6))
 I IOM>80 D
 . D EACHHEADER("OP/READ",TAB(7))
 . D EACHHEADER("NTR/NTW",TAB(8))
 . D EACHHEADER("NR0123",TAB(9))
 . D EACHHEADER("#L",TAB(10))
 . D EACHHEADER("%LSUCC",TAB(11))
 . D EACHHEADER("%CFAIL",TAB(12))
 I IOM>130 D
 . D EACHHEADER("R MB*",TAB(13))
 . D EACHHEADER("W MB*",TAB(14))
 . D EACHHEADER("SP MB*",TAB(15))
 Q
EACHHEADER(H,TAB) ; [Internal]
 ; ZEXCEPT: AB
 N BOLD S BOLD=$C(27,91,49,109)
 N RESET S RESET=$C(27,91,109)
 W ?TAB,BOLD,H,RESET
 QUIT
USHOW(TAB,SORT,FILTER) ;Display job info, sorted by pid
 ; ZEXCEPT: AB
 N SI,I
 S SI=""
 F  S SI=$ORDER(SORT(SI)) Q:SI=""  F I=1:1:SORT(SI) D
 . N X,TNAME,PROCID,PROCNAME,CTIME,PS,PID,PLACE
 . S X=SORT(SI,I)
 . S PID=$P(X,"~",8)
 . S PLACE=$G(^XUTL("XUSYS",PID,"JE","INTERRUPT"))
 . ; Debug
 . ; I $D(^XUTL("XUSYS",PID)) ZWRITE ^(PID,*)
 . ; debug
 . N RTNNAME S RTNNAME=$P(PLACE,"^",2)
 . I $D(FILTER)=10 Q:$$FILTROUT(.FILTER,RTNNAME,PID)
 . N DEV D DEV(.DEV,PID)
 . S TNAME=$$DEVSEL(.DEV),PROCID=$P(X,"~",1) ; TNAME is Terminal Name, i.e. the device.
 . S PROCNAME=$P(X,"~",5),CTIME=$P(X,"~",6)
 . I $G(^XUTL("XUSYS",PID,"JE","ZMODE"))="OTHER" S TNAME="BG-"_TNAME
 . N UNAME S UNAME=$G(^XUTL("XUSYS",PID,"JE","UNAME"))
 . W !,PROCID,?TAB(1),PROCNAME,?TAB(2),TNAME,?TAB(4),PLACE,?TAB(5),UNAME,?TAB(6),$J(CTIME,6)
 . I IOM>80 D
 .. I '$D(^XUTL("XUSYS",PID,"JE","GSTAT","DRD")) W ?TAB(7),"PROCESS NOT RESPONDING" QUIT
 .. N DRD,DTA,GET,ORD,ZPR,QRY
 .. S DRD=^XUTL("XUSYS",PID,"JE","GSTAT","DRD"),DTA=^("DTA"),GET=^("GET"),ORD=^("ORD"),ZPR=^("ZPR"),QRY=^("QRY")
 .. N opPerRead
 .. i DRD=0 s opPerRead=0
 .. e  S opPerRead=(DTA+GET+ORD+ZPR+QRY)/DRD
 .. W ?TAB(7),$J(opPerRead,"",2)
 .. N NTR,NTW S NTR=^XUTL("XUSYS",PID,"JE","GSTAT","NTR"),NTW=^("NTW") ; **NAKED**
 .. I NTR>9999 S NTR=$J(NTR/1024,"",0)_"k",NTW=$J(NTW/1024,"",0)_"k"
 .. W ?TAB(8),NTR,"/",NTW
 .. W ?TAB(9),^XUTL("XUSYS",PID,"JE","GSTAT","NR0"),"/",^("NR1"),"/",^("NR2"),"/",^("NR3")
 .. ; ^XUTL("XUSYS",14295,"JE","L",1)="LOCK ^XUTL(""XUSYS"",""COMMAND"") LEVEL=2"
 .. N numLocks s numLocks=0
 .. N I F I=0:0 S I=$O(^XUTL("XUSYS",PID,"JE","L",I)) Q:'I  N S S S=^(I) D  ; **NAKED**
 ... N levelLocation S levelLocation=$find(S,"LEVEL=")
 ... n level s level=+$E(S,levelLocation,999)
 ... s numLocks=numLocks+level
 .. W ?TAB(10),numLocks
 .. N LKS,LKF S LKS=^XUTL("XUSYS",PID,"JE","GSTAT","LKS"),LKF=^("LKF")
 .. N lockSuccess
 .. I LKS+LKF'=0 S lockSuccess=LKS/(LKS+LKF)
 .. e  s lockSuccess=0
 .. W ?TAB(11)
 .. i (LKS+LKF)<100 W LKS,"/",LKS+LKF
 .. e  w $J(lockSuccess*100,"",2)_"%"
 .. N CFT,CAT S CFT=$g(^XUTL("XUSYS",PID,"JE","GSTAT","CFT")),CAT=$g(^("CAT"))
 .. N critAcqFailure
 .. I CFT+CAT'=0 S critAcqFailure=CFT/(CFT+CAT)
 .. e  s critAcqFailure=0
 .. W ?TAB(12)
 .. i (CFT+CAT)<100 W CFT,"/",CFT+CAT
 .. e  w $J(critAcqFailure*100,"",2)_"%"
 . I IOM>130 D
 .. W ?TAB(13),$J($G(^XUTL("XUSYS",PID,"JE","RBYTE"))/(1024*1024),"",2)
 .. W ?TAB(14),$J($G(^XUTL("XUSYS",PID,"JE","WBYTE"))/(1024*1024),"",2)
 .. W ?TAB(15),$J($G(^XUTL("XUSYS",PID,"JE","HEAP_MEM"))/(1024*1024),"",2)
 . ;
 . ; Device print - Extract Info
 . ; F DI=0:0 S DI=$O(DEV(DI)) Q:'DI  D
 . ; W DEV(DI)
 . ;I $O(DEV("")) D
 .;. W !
 .;. I IOM>130 W " " F DI=0:0 S DI=$O(DEV(DI)) Q:'DI
 .;. E  W DEV(DI)  
 .;.. W:$E(DEV(DI))=" " !
 .;.. W ?TAB(1),DEV(DI)
 Q
 ;
FILTROUT(FILTER,RTNNAME,PID) ; [Private] Should this item be filtered out?
 I RTNNAME="" QUIT 1  ; yes, filter out processes that didn't respond
 ; ^XUTL("XUSYS",24754,"JE","S",1)="JOBEXAM+22^ZSY"
 ; ^XUTL("XUSYS",24754,"JE","S",2)="JOBEXAM+2^ZU"
 ; ^XUTL("XUSYS",24754,"JE","S",3)="GETTASK+3^%ZTMS1    ($ZINTERRUPT) "
 ; ^XUTL("XUSYS",24754,"JE","S",4)="SUBMGR+1^%ZTMS1"
 n found s found=0
 N I F I=1:1 Q:'$D(^XUTL("XUSYS",PID,"JE","S",I))  do  q:found
 . i ^XUTL("XUSYS",PID,"JE","S",I)["Call-In" quit
 . i ^XUTL("XUSYS",PID,"JE","S",I)["GTM$DMOD" quit
 . n rtnName s rtnName=$p(^XUTL("XUSYS",PID,"JE","S",I),"^",2)
 . i rtnName[" " s rtnName=$p(rtnName," ")
 . n each s each=""
 . f  s each=$o(FILTER(each)) q:each=""  do  q:found
 .. i $d(FILTER(rtnName)) s found=1
 ;
 ; If we find it, we don't want to filter it out.
 QUIT 'found
 ;
DEV(DEV,PID) ; [Private] Device Processing
 ; Input: Global ^XUTL("XUSYS",PID,"JE","D"), PID
 ; Output: .DEV
 ; Device processing
 ; First pass, normalize output into single lines
 N DEVCNT,X
 S DEVCNT=0
 N DI F DI=1:1 Q:'$D(^XUTL("XUSYS",PID,"JE","D",DI))  S X=^(DI) D
 . I X["CLOSED" QUIT  ; Don't print closed devices
 . I PID=$J,$E(X,1,2)="ps" QUIT  ; Don't print our ps device
 . I $E(X)'=" " S DEVCNT=DEVCNT+1,DEV(DEVCNT)=X
 . E  S DEV(DEVCNT)=DEV(DEVCNT)_" "_$$TRIM(X)
 ;
 ; Second Pass, identify Devices
 S DEVCNT="" F  S DEVCNT=$O(DEV(DEVCNT)) Q:DEVCNT=""  D
 . S X=DEV(DEVCNT)
 . N UPX S UPX=$ZCO(X,"U")
 . I $E(X)=0 S DEV("4JOB")="0"
 . I $P(X," ")["/dev/" S DEV("3TERM")=$P(X," ")
 . I $P(X," ")["/",$P(X," ")'["/dev/" S DEV("1FILE")=$P(X," ")
 . I UPX["SOCKET",UPX["SERVER" S DEV("2SOCK")=+$P(UPX,"PORT=",2)
 QUIT
 ;
DEVSEL(DEV) ; [Private] Select Device to Print
 N DEVTYP S DEVTYP=$O(DEV(" "))
 Q:DEVTYP="" ""
 I DEVTYP="4JOB" Q "0"
 I DEVTYP="2SOCK" Q "S"_DEV(DEVTYP)
 I DEVTYP="3TERM" Q DEV(DEVTYP)
 I DEVTYP="1FILE" Q DEV(DEVTYP)
 Q "ERROR"
 ;
TRIM(STR) ; [Private] Trim spaces
 Q $$FUNC^%TRIM(STR)
 ;
DATETIME(HOROLOG) ;
 Q $ZDATE(HOROLOG,"DD-MON-YY 24:60:SS")
 ;
UNIX(MODE,USERS,SORT) ;PUG/TOAD,FIS/KSB,VEN/SMH - Kernel System Status Report for GT.M
 N %I,U,$ET,$ES
 S $ET="D UERR^ZSY"
 S %I=$I,U="^"
 n procs
 D INTRPTALL(.procs)
 H .205 ; 200ms for TCP Read processes; 5ms b/c I am nice.
 n procgrps
 n done s done=0
 n j s j=1
 n i s i=0 f  s i=$o(procs(i)) q:'i  d
 . s procgrps(j)=$g(procgrps(j))_procs(i)_" "
 . i $l(procgrps(j))>220 s j=j+1 ; Max GT.M pipe len is 255
 f j=1:1 q:'$d(procgrps(j))  d
 . N %LINE,%TEXT,CMD
 . I $ZV["Linux" S CMD="ps o pid,tty,stat,time,cmd -p"_procgrps(j)
 . I $ZV["Darwin" S CMD="ps o pid,tty,stat,time,args -p"_procgrps(j)
 . I $ZV["CYGWIN" S CMD="for p in "_procgrps(j)_"; do ps -p $p; done | awk '{print $1"" ""$5"" n/a ""$7"" ""$8"" n/a ""}'"
 . ; ZEXCEPT: COMMAND,READONLY,SHELL
 . O "ps":(SHELL="/bin/sh":COMMAND=CMD:READONLY)::"PIPE" U "ps"
 . F  R %TEXT Q:$ZEO  D
 .. S %LINE=$$VPE(%TEXT," ",U) ; parse each line of the ps output
 .. Q:$P(%LINE,U)="PID"  ; header line
 .. D JOBSET(%LINE,MODE,.USERS,.SORT)
 . U %I C "ps"
 Q
 ;
UERR ;Linux Error
 N ZE S ZE=$ZS,$EC="" U $P
 ZSHOW "*"
 Q  ;halt
 ;
JOBSET(%LINE,MODE,USERS,SORT) ;Get data from a Linux job
 N %J
 N UNAME,PS,TNAME,CTIME
 S (UNAME,PS,TNAME,CTIME)=""
 N %J,PID,PROCID S (%J,PID,PROCID)=$P(%LINE,U)
 S TNAME=$P(%LINE,U,2) S:TNAME="?" TNAME="" ; TTY, ? if none
 S PS=$P(%LINE,U,3) ; process STATE
 S CTIME=$P(%LINE,U,4) ;cpu time
 N PROCNAME S PROCNAME=$P(%LINE,U,5) ; process name
 I PROCNAME["/" S PROCNAME=$P(PROCNAME,"/",$L(PROCNAME,"/")) ; get actual image name if path
 I $D(^XUTL("XUSYS",%J)) S UNAME=$G(^XUTL("XUSYS",%J,"NM"))
 E  S UNAME="unknown"
 N SI S SI=$S(MODE=0:PID,MODE=1:CTIME,1:PID)
 N I S I=$GET(SORT(SI))+1
 S SORT(SI)=I
 S SORT(SI,I)=PROCID_"~"_UNAME_"~"_PS_"~"_TNAME_"~"_PROCNAME_"~"_CTIME_"~"_""_"~"_PID
 S USERS=USERS+1
 Q
 ;
VPE(%OLDSTR,%OLDDEL,%NEWDEL) ; $PIECE extract based on variable length delimiter
 N %LEN,%PIECE,%NEWSTR
 S %OLDDEL=$G(%OLDDEL) I %OLDDEL="" S %OLDDEL=" "
 S %LEN=$L(%OLDDEL)
 ; each %OLDDEL-sized chunk of %OLDSTR that might be delimiter
 S %NEWDEL=$G(%NEWDEL) I %NEWDEL="" S %NEWDEL="^"
 ; each piece of the old string
 S %NEWSTR="" ; new reformatted string to retun
 F  Q:%OLDSTR=""  D
 . S %PIECE=$P(%OLDSTR,%OLDDEL)
 . S $P(%OLDSTR,%OLDDEL)=""
 . S %NEWSTR=%NEWSTR_$S(%NEWSTR="":"",1:%NEWDEL)_%PIECE
 . F  Q:%OLDDEL'=$E(%OLDSTR,1,%LEN)  S $E(%OLDSTR,1,%LEN)=""
 Q %NEWSTR
 ;
 ; Sam's entry points
UNIXLSOF(procs) ; [Public] - Get all processes accessing THIS database (only!)
 ; (return) .procs(n)=unix process number
 ; ZEXCEPT: shell,parse
 n %cmd s %cmd="lsof -t "_$view("gvfile","DEFAULT")
 i $ZV["CYGWIN" s %cmd="ps -a | grep mumps | grep -v grep | awk '{print $1}'"
 n oldio s oldio=$IO
 o "lsof":(shell="/bin/bash":command=%cmd:parse)::"pipe"
 u "lsof"
 n i f i=1:1 q:$ZEOF  r procs(i):1  i procs(i)="" k procs(i)
 u oldio c "lsof"
 n cnt s cnt=0
 n i f i=0:0 s i=$o(procs(i)) q:'i  i $i(cnt)
 quit:$Q cnt quit
 ;
INTRPT(%J) ; [Public] Send mupip interrupt (currently SIGUSR1)
 N SIGUSR1
 I $ZV["Linux" S SIGUSR1=10
 I $ZV["Darwin" S SIGUSR1=30
 I $ZV["CYGWIN" S SIGUSR1=30
 N % S %=$ZSIGPROC(%J,SIGUSR1)
 QUIT
 ;
INTRPTALL(procs) ; [Public] Send mupip interrupt to every single database process
 N SIGUSR1
 I $ZV["Linux" S SIGUSR1=10
 I $ZV["Darwin" S SIGUSR1=30
 I $ZV["CYGWIN" S SIGUSR1=30
 ; Collect processes
 D UNIXLSOF(.procs)
 ; Signal all processes
 N i,% s i=0 f  s i=$o(procs(i)) q:'i  S %=$ZSIGPROC(procs(i),SIGUSR1)
 QUIT
 ;
HALTALL ; [Public] Gracefully halt all jobs accessing current database
 ; Calls ^XUSCLEAN then HALT^ZU
 ;Clear old data
 S ^XUTL("XUSYS","COMMAND")="Status"
 N I F I=0:0 S I=$O(^XUTL("XUSYS",I)) Q:'I  K ^XUTL("XUSYS",I,"JE"),^("INTERUPT")
 ;
 ; Get jobs accessing this database
 n procs d UNIXLSOF(.procs)
 ;
 ; Tell them to stop
 n i f i=1:1 q:'$d(procs(i))  s ^XUTL("XUSYS",procs(i),"CMD")="HALT"
 K ^XUTL("XUSYS",$J,"CMD")  ; but not us
 ;
 ; Sayonara
 N J F J=0:0 S J=$O(^XUTL("XUSYS",J)) Q:'J  D INTRPT(J)
 ;
 ; Wait; Long hang for TCP jobs that can't receive interrupts for .2 seconds
 H .25
 ;
 ; Check that they are all dead. If not, kill it "softly".
 ; Need to do this for node and java processes that won't respond normally.
 N J F J=0:0 S J=$O(^XUTL("XUSYS",J)) Q:'J  I $zgetjpi(J,"isprocalive"),J'=$J D KILL(J)
 ;
 quit
 ;
HALTONE(%J) ; [Public] Halt a single process
 S ^XUTL("XUSYS",%J,"CMD")="HALT"
 D INTRPT(%J)
 H .25 ; Long hang for TCP jobs that can't receive interrupts
 I $zgetjpi(%J,"isprocalive") D KILL(%J)
 QUIT
 ;
KILL(%J) ; [Private] Kill %J
 ; ZEXCEPT: shell
 n %cmd s %cmd="kill "_%J
 o "kill":(shell="/bin/sh":command=%cmd)::"pipe" u "kill" c "kill"
 quit
 ;
ZJOB(PID) G JOBVIEWZ ; [Public, Interactive] Examine a specific job -- written by OSEHRA/SMH
EXAMJOB(PID) G JOBVIEWZ ;
VIEWJOB(PID) G JOBVIEWZ ;
JOBVIEW(PID) G JOBVIEWZ ;
JOBVIEWZ ;
 ; ZEXCEPT: CTRAP,NOESCAPE,NOFILTER,PID
 U $P:(CTRAP=$C(3):NOESCAPE:NOFILTER)
 I $G(PID) D JOBVIEWZ2(PID) QUIT
 D ^ZSY
 N X,DONE
 S DONE=0
 ; Nasty read loop. I hate read loops
 F  D  Q:DONE
 . R !,"Enter a job number to examine (^ to quit): ",X:$G(DTIME,300)
 . E  S DONE=1 QUIT
 . I X="^" S DONE=1 QUIT
 . I X="" D ^ZSY QUIT
 . I X["?" D ^ZSY QUIT
 . ;
 . D JOBVIEWZ2(X)
 . D ^ZSY
 QUIT
 ;
JOBVIEWZ2(X) ; [Private] View Job Information
 I X'?1.N W !,"Not a valid job number." Q
 I '$zgetjpi(X,"isprocalive") W !,"This process does not exist" Q
 ;
 N EXAMREAD
 N DONEONE S DONEONE=0
 F  D  Q:DONEONE  ; This is an inner read loop to refresh a process.
 . N % S %=$$EXAMINEJOBBYPID(X)
 . I %'=0 W !,"The job didn't respond to examination for 305 ms. You may try again." S DONEONE=1 QUIT
 . D PRINTEXAMDATA(X,$G(EXAMREAD))
 . W "Enter to Refersh, V for variables, I for ISVs, K to kill",!
 . W "L to load variables into your ST and quit, ^ to go back: ",!
 . W "D to debug (broken), Z to zshow all data for debugging."
 . R EXAMREAD:$G(DTIME,300)
 . E  S DONEONE=1
 . I EXAMREAD="^" S DONEONE=1
 . I $TR(EXAMREAD,"k","K")="K" D HALTONE(X) S DONEONE=1
 QUIT
 ;
EXAMINEJOBBYPID(%J) ; [$$, Public, Silent] Examine Job by PID; Non-zero output failure
 Q:'$ZGETJPI(%J,"isprocalive") -1
 K ^XUTL("XUSYS",%J,"CMD"),^("JE")
 S ^XUTL("XUSYS",%J,"CMD")="EXAM"
 D INTRPT(%J)
 N I F I=1:1:5 H .001 Q:$G(^XUTL("XUSYS",%J,"JE","COMPLETE"))
 I '$G(^XUTL("XUSYS",%J,"JE","COMPLETE")) H .2
 I '$G(^XUTL("XUSYS",%J,"JE","COMPLETE")) H .2
 I '$G(^XUTL("XUSYS",%J,"JE","COMPLETE")) Q -1
 QUIT 0
 ;
PRINTEXAMDATA(%J,FLAG) ; [Private] Print the exam data
 ; ^XUTL("XUSYS",8563,"JE","INTERRUPT")="GETTASK+3^%ZTMS1"
 ; ^XUTL("XUSYS",8563,"JE","G",0)="GLD:*,REG:*,SET:25610,KIL:593,GET:12284,...
 ; ^XUTL("XUSYS",8563,"JE","ZMODE")="OTHER"
 N ZSY M ZSY=^XUTL("XUSYS",%J)
 ;
 N BOLD S BOLD=$C(27,91,49,109)
 N RESET S RESET=$C(27,91,109)
 N UNDER S UNDER=$C(27,91,52,109)
 N DIM S DIM=$$AUTOMARG()
 ;
 ; Debug
 I $TR(FLAG,"d","D")="D" D DEBUG(%J)
 ;
 ; Show all data
 I $TR(FLAG,"z","Z")="Z" ZWRITE ZSY QUIT
 ;
 ; List Variables?
 I $TR(FLAG,"v","V")="V" D  QUIT
 . W !!,BOLD,"Variables: ",RESET,!
 . N V F V=0:0 S V=$O(ZSY("JE","V",V)) Q:'V  W ZSY("JE","V",V),!
 ;
 ; Load Variables into my Symbol Table?
 ; ZGOTO pops the stack and drops you to direct mode ($ZLEVEL is 2 to exit one above direct mode)
 I $TR(FLAG,"l","L")="L" D  ZGOTO 2:LOADST
 . K ^TMP("ZSY",$J)
 . M ^TMP("ZSY",$J)=ZSY("JE","V")
 ;
 ; List ISVs?
 I $TR(FLAG,"i","I")="I" D  QUIT
 . W !!,BOLD,"ISVs: ",RESET,!
 . N I F I=0:0 S I=$O(ZSY("JE","I",I)) Q:'I  W ZSY("JE","I",I),!
 ;
 ; Normal Display: Job Info, Stack, Locks, Devices
 W #
 W UNDER,"JOB INFORMATION FOR "_%J," (",$ZDATE(ZSY(0),"YYYY-MON-DD 24:60:SS"),")",RESET,!
 W BOLD,"AT: ",RESET,ZSY("JE","INTERRUPT"),": ",$G(ZSY("JE","codeline")),!!
 ;
 N CNT S CNT=1
 W BOLD,"Stack: ",RESET,!
 ; Stack is funny -- print just to $ZINTERRUPT
 N S F S=$O(ZSY("JE","R"," "),-1):-1:1 Q:ZSY("JE","R",S)["$ZINTERRUPT"  D
 . N PLACE S PLACE=$P(ZSY("JE","R",S),":")
 . I $E(PLACE)=" " QUIT  ; GTM adds an extra level sometimes for display -- messes me up
 . W CNT,". "
 . I PLACE'["GTM$DMOD" W PLACE,?40,$T(@PLACE)
 . W !
 . S CNT=CNT+1
 W CNT,". ",ZSY("JE","INTERRUPT"),":",?40,$G(ZSY("JE","codeline")),!
 ;
 W !
 W BOLD,"Locks: ",RESET,!
 N L F L=0:0 S L=$O(ZSY("JE","L",L)) Q:'L  W ZSY("JE","L",L),!
 ;
 W !
 W BOLD,"Devices: ",RESET,!
 N D F D=0:0 S D=$O(ZSY("JE","D",D)) Q:'D  W ZSY("JE","D",D),!
 ;
 W !
 W BOLD,"Breakpoints: ",RESET,!
 N B F B=0:0 S B=$O(ZSY("JE","B",B)) Q:'B  W ZSY("JE","B",B),!
 ;
 W !
 W BOLD,"Global Stats for default region: ",RESET,!
 N G S G=""
 N SLOTS S SLOTS=+DIM\15
 N SLOT S SLOT=0
 F  S G=$O(ZSY("JE","GSTAT",G)) Q:G=""  D
 . I G="GLD" QUIT
 . N V S V=ZSY("JE","GSTAT",G)
 . I V>9999 S V=$J(V/1024,"",0)_"k"
 . I V>9999,V["k" S V=$J(V/1024,"",0)_"m"
 . W ?(SLOT*15),G,": ",V," "
 . S SLOT=SLOT+1
 . I SLOT+1>SLOTS S SLOT=0 W !
 W !!
 ;
 W BOLD,"String Pool (size,currently used,freed): ",RESET,ZSY("JE","SPOOL"),!!
 QUIT
 ;
LOADST ; [Private] Load the symbol table into the current process
 KILL
 N V F V=0:0 S V=$O(^TMP("ZSY",$J,V)) Q:'V  S @^(V)
 K ^TMP("ZSY",$J)
 QUIT
 ;
DEBUG(%J) ; [Private] Debugging logic
 Q:'$ZGETJPI(%J,"isprocalive") -1
 K ^XUTL("XUSYS",%J,"CMD"),^("JE")
 S ^XUTL("XUSYS",%J,"CMD")="DEBUG"
 D INTRPT(%J)
 N I F I=1:1:5 H .001 Q:$G(^XUTL("XUSYS",%J,"JE","COMPLETE"))
 I '$G(^XUTL("XUSYS",%J,"JE","COMPLETE")) H .2
 I '$G(^XUTL("XUSYS",%J,"JE","COMPLETE")) H .1
 I '$G(^XUTL("XUSYS",%J,"JE","COMPLETE")) Q -1
 N ZSY M ZSY=^XUTL("XUSYS",%J)
 ;
 N BOLD S BOLD=$C(27,91,49,109)
 N RESET S RESET=$C(27,91,109)
 N UNDER S UNDER=$C(27,91,52,109)
 N DIM S DIM=$$AUTOMARG()
 ;
 ; Normal Display: Job Info, Stack, Locks, Devices
 W #
 W UNDER,"JOB INFORMATION FOR "_%J," (",$ZDATE(ZSY(0),"YYYY-MON-DD 24:60:SS"),")",RESET,!
 W BOLD,"AT: ",RESET,ZSY("JE","INTERRUPT"),": ",ZSY("JE","codeline"),!!
 ;
 N CNT S CNT=1
 W BOLD,"Stack: ",RESET,!
 ; Stack is funny -- print just to $ZINTERRUPT
 N S F S=$O(ZSY("JE","R"," "),-1):-1:1 Q:ZSY("JE","R",S)["$ZINTERRUPT"  D
 . N PLACE S PLACE=$P(ZSY("JE","R",S),":")
 . I $E(PLACE)=" " QUIT  ; GTM adds an extra level sometimes for display -- messes me up
 . W CNT,". "
 . I PLACE'["GTM$DMOD" W PLACE,?40,$T(@PLACE)
 . W !
 . S CNT=CNT+1
 W CNT,". ",ZSY("JE","INTERRUPT"),":",?40,ZSY("JE","codeline"),!
 ;
 W !
 W BOLD,"Locks: ",RESET,!
 N L F L=0:0 S L=$O(ZSY("JE","L",L)) Q:'L  W ZSY("JE","L",L),!
 ;
 W !
 W BOLD,"Devices: ",RESET,!
 N D F D=0:0 S D=$O(ZSY("JE","D",D)) Q:'D  W ZSY("JE","D",D),!
 W !
 W BOLD,"Breakpoints: ",RESET,!
 N B F B=0:0 S B=$O(ZSY("JE","B",B)) Q:'B  W ZSY("JE","B",B),!
 ;
 n x r "press key to continue",x
 QUIT
 ;
AUTOMARG() ;RETURNS IOM^IOSL IF IT CAN and resets terminal to those dimensions; GT.M
 ; ZEXCEPT: APC,TERM,NOECHO,WIDTH
 I $PRINCIPAL'["/dev/" quit:$Q "" quit
 U $PRINCIPAL:(WIDTH=0)
 N %I,%T,ESC,DIM S %I=$I,%T=$T D
 . ; resize terminal to match actual dimensions
 . S ESC=$C(27)
 . U $P:(TERM="R":NOECHO)
 . W ESC,"7",ESC,"[r",ESC,"[999;999H",ESC,"[6n"
 . R DIM:1 E  Q
 . W ESC,"8"
 . I DIM?.APC U $P:(TERM="":ECHO) Q
 . I $L($G(DIM)) S DIM=+$P(DIM,";",2)_"^"_+$P(DIM,"[",2)
 . U $P:(TERM="":ECHO:WIDTH=+$P(DIM,";",2):LENGTH=+$P(DIM,"[",2))
 ; restore state
 U %I I %T
 ; Extra just for ^ZJOB - don't wrap
 U $PRINCIPAL:(WIDTH=0)
 Q:$Q $S($G(DIM):DIM,1:"") Q
