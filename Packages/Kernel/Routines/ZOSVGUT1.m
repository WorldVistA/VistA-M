ZOSVGUT1 ;KRM/CJE,VEN/SMH - GT.M Kernel unit tests ;2018-06-06  1:29 PM
 ;;8.0;KERNEL;**10001,10002**;Aug 28, 2013;Build 26
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel & Christopher Edwards 2014-2016.
 ;
 ; makes it easy to run tests simply by running this routine and
 ; insures that %ut will be run only where it is present
 ;
 I $T(EN^%ut)'="" D EN^%ut($T(+0),3,1)
 Q
 ;
STARTUP ;
 D DUZ^XUP(.5)
 QUIT
 ;
COV ; [Coverage of Unit Tests] Must use M-Unit 1.5 for this!
 N NMSPS
 S (NMSPS("%ZOSV*"),NMSPS("%ZISH"),NMSPS("ZTMGRSET"))=""
 S (NMSPS("XLFNSLK"),NMSPS("XLFIPV"),NMSPS("XUSHSH"),NMSPS("XQ82"))=""
 S (NMSPS("ZSY"))=""
 D COV^%ut(.NMSPS,"D ^"_$T(+0),1)
 QUIT
 ;
 ;
SETNM ; @TEST Set Environment Name
 D SETNM^%ZOSV("ZOSV UT for GT.M")
 QUIT
 ;
ZRO1 ; @TEST $ZROUTINES Parsing Single Object Multiple dirs
 N ZR S ZR="o(p r) /var/abc(/var/abc/r/) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"p/")
 QUIT
 ;
ZRO2 ; @TEST $ZROUTINES Parsing 2 Single Object Single dir
 N ZR S ZR="/var/abc(/var/abc/r/) o(p r) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/var/abc/r/")
 QUIT
 ;
ZRO3 ; @TEST $ZROUTINES Parsing Shared Object/Code dir
 N ZR S ZR="/abc/def /var/abc(/var/abc/r/) o(p r) $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/abc/def/")
 QUIT
 ;
ZRO4 ; @TEST $ZROUTINES Parsing Single Directory by itself
 N ZR S ZR="/home/osehra/r"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/r/")
 QUIT
 ;
ZRO5 ; @TEST $ZROUTINES Parsing Leading Space
 N ZR S ZR=" o(p r) /var/abc(/var/abc/r/) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"p/")
 QUIT
 ;
 ;
ZRO7 ; @TEST $ZROUTINES Shared Object Only
 N ZR S ZR="/home/osehra/lib/gtm/libgtmutil.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"")
 Q
 ;
ZRO8 ; @TEST $ZROUTINES No shared object
 N ZR S ZR="/home/osehra/r/V6.0-002_x86_64(/home/osehra/r) /home/osehra/lib/gtm"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/r/")
 Q
 ;
ZRO9 ; @TEST $ZROUTINES Shared Object First
 N ZR S ZR="/home/osehra/lib/gtm/libgtmutil.so /home/osehra/r/V6.0-002_x86_64(/home/osehra/r)"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/r/")
 Q
 ;
ZRO10 ; @TEST $ZROUTINES Shared Object First but multiple rtn dirs
 N ZR S ZR="/home/osehra/lib/gtm/libgtmutil.so /home/osehra/p/V6.0-002_x86_64(/home/osehra/p) /home/osehra/s/V6.0-002_x86_64(/home/osehra/s) /home/osehra/r/V6.0-002_x86_64(/home/osehra/r)"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/p/")
 Q
 ;
ZRO99 ; @TEST $$RTNDIR^%ZOSV Shouldn't be Empty
 N RTNDIR S RTNDIR=$$RTNDIR^%ZOSV
 D CHKTF^%ut(RTNDIR]"")
 QUIT
 ;
ACTJ ; @TEST Default path through ACTJ^ZOSV
 N ACTJ
 ; Run the algorithm
 S ACTJ=$$ACTJ^%ZOSV
 D CHKTF^%ut(ACTJ>0,"$$ACTJ^%ZOSV didn't return the correct value")
 Q
 ;
ACTJ0 ; @TEST Force ^XUTL("XUSYS","CNT") to 0 to force algorithm to run
 ; Force algorithm to run
 S ^XUTL("XUSYS","CNT")=0
 ; Run the algorithm
 N ACTJ S ACTJ=$$ACTJ^%ZOSV
 D CHKTF^%ut(ACTJ,"Active Jobs must not be zero")
 ;
 ; Run again, but this time we get the cached result
 N ACTJ2 S ACTJ2=$$ACTJ^%ZOSV
 D CHKEQ^%ut(ACTJ2,ACTJ,"$$ACTJ^%ZOSV is out of sync with jobs on file")
 ;
 ; Force algorithm to run
 S ^XUTL("XUSYS","CNT")=0
 ; Run the algorithm
 N ACTJ3 S ACTJ3=$$ACTJ^%ZOSV
 D CHKEQ^%ut(ACTJ2,ACTJ3,"$$ACTJ^%ZOSV is out of sync with jobs on file")
 ; 
 Q
 ;
AVJ ; @TEST Available Jobs
 D CHKTF^%ut($$AVJ^%ZOSV>0)
 QUIT
 ;
DEVOK ; @TEST Dev Okay
 N X,X1,Y
 S X="ORB NOTIFICATION RESOURCE",X1="RES" D DEVOK^%ZOSV
 D CHKTF^%ut(Y=0)
 S X="NULL" D DEVOK^%ZOSV
 D CHKTF^%ut(Y=0)
 QUIT
 ;
DEVOPN ; @TEST Show open devices
 N Y D DEVOPN^%ZOSV
 D CHKTF^%ut(Y'="")
 QUIT
 ;
GETPEER ; @TEST Get Peer
 N PEER S PEER=$$GETPEER^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
PRGMODE ; @TEST Prog Mode
 N % S %=$$PROGMODE^%ZOSV()
 D PRGMODE^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
JOBPAR ; @TEST Job Parameter -- Dummy; doesn't do anything useful.
 N X,Y S X=$J D JOBPAR^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
LOGRSRC ; @TEST Turn on Resource Logging
 ; KMPR package not ported to GT.M. Noop.
 D LOGRSRC^%ZOSV("TEST",1,"OPEN")
 QUIT
 ;
ORDER ; @TEST Order
 N X,Y
 S X="^TMP($J,"
 K ^TMP($J)
 S Y="%ut*"
 D ORDER^%ZOSV
 D CHKTF^%ut(^TMP($J,"%ut","CHK")) ; Must be a number
 QUIT
 ;
DOLRO ; @TEST Ensure symbol table is saved correctly
 N TEST,X
 ; Will check for this variable and value in the open root
 S TEST="TEST1"
 ; DOLRO reads the variable X to figure put where to save the symbol table to
 S X="^TMP(""ZZUTZOSV"","
 ; Save the symbol table
 D DOLRO^%ZOSV
 D CHKEQ^%ut(^TMP("ZZUTZOSV","TEST"),"TEST1","DOLRO^%ZSOV Didn't save the correct variable value")
 ; Debug
 ; ZWR ^TMP("ZZUTZOSV",*)
 ; Kill test variable
 K ^TMP("ZZUTZOSV")
 Q
 ;
TMTRAN ; @TEST Make sure that Taskman is running
 I '$$TM^%ZTLOAD() D FAIL^%ut("Can't run this test. Taskman isn't running.") QUIT
 ;
 N ZTSK D Q^XUTMTZ
 D CHKTF^%ut(ZTSK)
 N TOTALWAIT S TOTALWAIT=0
 F  Q:'$D(^%ZTSK(ZTSK))  H .05 S TOTALWAIT=TOTALWAIT+.05 Q:TOTALWAIT>3
 D CHKTF^%ut(TOTALWAIT<2,"Taskman didn't process task")
 QUIT
 ;
GETENV ; @TEST Test GETENV
 N Y D GETENV^%ZOSV
 D CHKEQ^%ut($L(Y,"^"),4)
 QUIT
 ;
OS ; @TEST OS
 D CHKEQ^%ut($$OS^%ZOSV(),"UNIX")
 QUIT
 ;
VERSION ; @TEST VERSION
 N V0 S V0=$$VERSION^%ZOSV(0)
 N OS S OS=$$VERSION^%ZOSV(1)
 D CHKTF^%ut(V0,"Must be positive")
 D CHKTF^%ut($L(V0,"-")=2,"Must be in xx.xxxx")
 D CHKTF^%ut(OS["nux"!(OS["nix")!(OS["BSD")!(OS["Darwin")!(OS["CYGWIN"))
 QUIT
 ;
SID ; @TEST System ID
 N SID S SID=$$SID^%ZOSV
 D CHKTF^%ut(SID[$ZGBLDIR)
 QUIT
 ;
UCI ; @TEST Get UCI/Vol
 N Y D UCI^%ZOSV
 D CHKTF^%ut(Y=^%ZOSF("PROD"))
 QUIT
UCICHECK ; @TEST Noop
 N % S %=$$UCICHECK^%ZOSV(88)
 D CHKEQ^%ut(88,%)
 QUIT
PARSIZ ; @TEST PARSIZE NOOP
 N X
 D PARSIZ^%ZOSV
 D SUCCEED^%ut
 QUIT
NOLOG ; @TEST NOLOG NOOP
 N Y
 D NOLOG^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
SHARELIC ; @TEST SHARELIC NOOP
 D SHARELIC^%ZOSV()
 D SUCCEED^%ut
 QUIT
 ;
PRIORITY ; @TEST PRIORITY NOOP
 D PRIORITY^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
PRIINQ ; @TEST PRIINQ() NOOP
 N % S %=$$PRIINQ^%ZOSV()
 D SUCCEED^%ut
 QUIT
 ;
BAUD ; @TEST BAUD NOOP
 N X D BAUD^%ZOSV
 D SUCCEED^%ut
 S X="UNKNOWN"
 QUIT
 ;
SETTRM ; @TEST Set Terminators
 N % S %=$$SETTRM^%ZOSV($C(10,13))
 D CHKEQ^%ut(%,1)
 X ^%ZOSF("TRMON") ; Reset terminators
 QUIT
 ;
LGR ; @TEST Last Global Reference
 S ^TMP($J)=""
 I ^TMP($J)
 N R S R=$$LGR^%ZOSV()
 D CHKEQ^%ut(R,$NA(^TMP($J)))
 K ^TMP($J)
 QUIT
 ;
EC ; @TEST $$EC
 N A,%
 N $ET S $ET="S A=$$EC^%ZOSV,$EC="""" G EC1"
 S %=1/0
EC1 ;
 D CHKTF^%ut(A["divide")
 QUIT
 ;
ZTMGRSET ; @TEST ZTMGRSET Renames Routines on GT.M
 ;ZEXCEPT: shell
 N %ZR,%Y,%YY
 N RTNFS S RTNFS="_ZTLOAD1.o"
 D SILENT^%RSEL("%ZTLOAD1","OBJ")
 N FILE S FILE=%ZR("%ZTLOAD1")_RTNFS
 S %Y=$$RETURN^%ZOSV("stat -c %X "_FILE)
 N ZTOS S ZTOS=$$OSNUM^ZTMGRSET()
 N SCR S SCR="I 0"
 N ZTMODE S ZTMODE=2
 N IOP S IOP="NULL" D ^%ZIS U IO
 D DOIT^ZTMGRSET
 D ^%ZISC
 D SILENT^%RSEL("%ZTLOAD1","OBJ")
 N FILE S FILE=%ZR("%ZTLOAD1")_RTNFS
 S %YY=$$RETURN^%ZOSV("stat -c %X "_FILE)
 D CHKTF^%ut(%YY'<%Y)
 ;
 ; Now that we know that it works, just run some of the other EPs to inc coverage
 N IOP S IOP="NULL" D ^%ZIS U IO
 D PATCH^ZTMGRSET(599) ; %ZIS
 ;
 N DTIME S DTIME=.001
 D NAME^ZTMGRSET
 D GLOBALS^ZTMGRSET
 D RUM^ZTMGRSET
 D ^%ZISC
 QUIT
 ;
ZHOROLOG ; @TEST $ZHOROLOG Functions
 Q:$$VERSION^%ZOSV<6.3
 N %ZH0,%ZH1,%ZH2
 D T0^%ZOSV
 D CHKTF^%ut(%ZH0)
 D CHKTF^%ut($L(%ZH0,",")=4)
 D T1^%ZOSV
 D CHKTF^%ut(%ZH1)
 D CHKTF^%ut($L(%ZH1,",")=4)
 D ZHDIF^%ZOSV
 D CHKTF^%ut(%ZH2<.001,"%ZH2 is "_%ZH2)
 QUIT
 ;
TEMP ; @TEST getting temp directory
 N TMP S TMP=$$TEMP^%ZOSV()
 N FN S FN=TMP_"/test.txt"
 O FN:newvesrion
 U FN
 W "TEST",!
 C FN:delete
 D SUCCEED^%ut
 QUIT
 ;
PASS ; @TEST PASTHRU and NOPASS
 D PASSALL^%ZOSV
 D NOPASS^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
NSLOOKUP ; @TEST Test DNS Utilities
 ; REVERSE DNS
 N % S %=$$HOST^XLFNSLK("208.67.220.220")
 D CHKTF^%ut(%["opendns")
 N % S %=$$HOST^XLFNSLK("2607:F8B0:400D:0C01:0000:0000:0000:0066")
 D CHKTF^%ut(%["1e100")
 N % S %=$$HOST^XLFNSLK("")
 D SUCCEED^%ut
 N % S %=$$HOST^XLFNSLK("93.184.216.34") ; example.com doesn't have reverse dns
 D CHKTF^%ut(%="")
 ;
 ; FORWARD DNS
 ; dig may fail with localhost lookup
 N IPV6 S IPV6=$$VERSION^XLFIPV
 I IPV6 D CHKTF^%ut($$ADDRESS^XLFNSLK("localhost")["0000:0000:0000:0000:0000:0000:0000:000") I 1
 E  D CHKTF^%ut(($$ADDRESS^XLFNSLK("localhost")["127.0.0.1")!($$ADDRESS^XLFNSLK("localhost")["0.0.0.0"))
 D CHKTF^%ut(($$ADDRESS^XLFNSLK("localhost","A")["127.0.0.1")!($$ADDRESS^XLFNSLK("localhost","A")["0.0.0.0"))
 D CHKTF^%ut($$ADDRESS^XLFNSLK("localhost","AAAA")["0000:0000:0000:0000:0000:0000:0000:000")
 QUIT
 ;
IPV6 ; @TEST Test GT.M support for IPV6
 I $ZV["CYGWIN" QUIT  ; We run Cygwin on IPv4 only as Cygwin doesn't support between the two as well as Linux
 D CHKEQ^%ut($$VERSION^XLFIPV(),1)
 QUIT
 ;
SSVNJOB ; @TEST Replacement for ^$JOB in XQ82
 ; ZEXCEPT: SSVNJOB,SSVNJOB1,ERR,IN
 L +SSVNJOB
 J SSVNJOB1:(IN="/dev/null":OUT="/dev/null":ERR="/dev/null")
 N CHILDPID S CHILDPID=$ZJOB
 L -SSVNJOB
 H .01 ; This must be big enough to let your computer start the job
 I $ZV["CYGWIN" H 1 ; Wish I knew why...
 I $ZV["arm" H 1 ; Arm chips too slow...
 L +SSVNJOB
 L
 D CHKTF^%ut($D(^TMP(CHILDPID)))
 S ^XUTL("XQ",$J)="" ; So that ^XQ82 won't kill our temp globals 
 D ^XQ82
 D CHKTF^%ut('$D(^TMP(CHILDPID)))
 QUIT
 ;
SSVNJOB1 ; [Private] Helper for SSVNJOB
 ; ZEXCEPT: SSVNJOB
 L +SSVNJOB
 K ^TMP($J)
 S ^TMP($J,"SAM")=1
 S ^TMP($J,"CHRISTOPHER")=2
 L -SSVNJOB
 QUIT
 ;
ZSY ; @TEST Run System Status
 ; ZEXCEPT: in,out,err
 N IOP S IOP="NULL" D ^%ZIS U IO
 D ^ZSY
 N %utAnswer s %utAnswer=2
 D QUERY^ZSY
 N nProcs s nProcs=$$UNIXLSOF^ZSY()
 D HALTALL^ZSY ; Kill all other processes
 i $zv["arm" h 5 ; Needed for Arm chips... not fast enough in the kill
 N nProcsAfter S nProcsAfter=$$UNIXLSOF^ZSY()
 D CHKTF^%ut(nProcs>nProcsAfter)
 D CHKTF^%ut(nProcsAfter=1)
 D ^ZTMB ; bring it back up.
 D LW^ZSY
 D ERR^ZSY
 D UERR^ZSY
 D SUCCEED^%ut
 D ^%ZISC
 QUIT
 ;
HALTONE ; @TEST Test HALTONE^ZSY entry point
 ; ZEXCEPT: TESTJOB,input,output,error
 J TESTJOB:(input="/dev/null":output="/dev/null":error="/dev/null")
 N %J S %J=$ZJOB
 D CHKTF^%ut($zgetjpi(%J,"isprocalive"))
 D HALTONE^ZSY(%J)
 H .01
 D CHKTF^%ut('$zgetjpi(%J,"isprocalive"))
 QUIT
 ;
TESTJOB ; [Private] Entry point for a test job to kill
 HANG 100
 QUIT
 ;
XTROU ;;
 ;;ZOSVGUT2
