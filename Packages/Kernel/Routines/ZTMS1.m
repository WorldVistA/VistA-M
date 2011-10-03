%ZTMS1 ;SEA/RDS-TaskMan: Submanager, (Loop & Get Task) ;10/07/08  15:46
 ;;8.0;KERNEL;**36,49,104,118,127,136,275,446**;JUL 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;Use ZTLKTM for Lock timeout. p446
SUBMGR ;START--outer submanager loop
 D GETTASK G:ZTSK'>0 QUIT^%ZTMS ;task locked
 S STATUS="Run Task "_ZTSK
 D PROCESS^%ZTMS2 G:$D(ZTQUIT) QUIT^%ZTMS
 S STATUS="Idle"
 G SUBMGR
 ;
GETTASK ;SUBMGR--retain the partition; check Waiting Lists every 1 seconds
 D SUB(1) S ZTSK=0
 ;
 F ZRT=0:0 D  Q:$$EXIT  S %=$S($O(^%ZTSCH("JOB",0))>0:1,1:$$FIRST()),ZRT=ZRT+% H % ;Space out the SM loop
 . I $D(^%ZTSCH("WAIT","SUB")) S STATUS="Wait Node" H 5 Q  ;Wait
 . S %ZTIME=$$H3($H),ZTSK=0 I $D(^%ZTSCH("STOP","SUB",ZTPAIR)) Q
 . D C Q:ZTSK!(ZTYPE="C")  ;Do directed work before check for balance
 . ;If more than xx tasks in JOB Queue don't balance wait. p446
 . I $$BALANCE S ZRT=ZRT-.9,STATUS="Balance Wait" I $$JCNT(ZTPFLG("BalLimit")) Q  ;Wait for balance, Slow ZRT rise.
 . D JOB,IOQ:'ZTSK ;Look for work
 . Q
 D SUB(-1) ;Adjust counter
 Q
 ;
EXIT() ;GETTASK--decide whether to exit retention loop
 I ZTSK,$D(^%ZTSCH("NO-OPTION")),$P(^%ZTSK(ZTSK,0),"^",1,2)="ZTSK^XQ1" D
 . D SCHTM^%ZTMS2(ZTDTH+60) S ZTSK=0
 . Q
 I ZTSK G YES
 I $D(^%ZTSCH("STOP","SUB",ZTPAIR)) G YES
 I ZTPFLG("RT")>ZRT G NO ;Retention time check
 I $$SUB(0)>ZTPFLG("MIN") G YES ;Let extras go
NO ;Don't exit, Update status node
 L +^%ZTSCH("SUB",ZTPFLG("HOME"),$J):10 ;p446
 S ^%ZTSCH("SUB",ZTPFLG("HOME"),$J)=$H_"^"_$G(STATUS)_"^"_$G(STATUS("Bal")) ;Keep our node current
 I ZTPFLG("XUSCNT") D SETLOCK^XUSCNT($NA(^%ZTSCH("SUBLK",ZTPFLG("HOME"),$J)))
 L -^%ZTSCH("SUB",ZTPFLG("HOME"),$J) ;p446
 Q 0
 ;
YES ;EXIT--Yes ;p446
 Q 1
 ;
C ;GETTASK--On C type volume sets, get tasks from Cross-Volume Job List
 S STATUS="C List",ZTSK=0
 I $O(^%ZTSCH("C",ZTPAIR,0))="" Q
 L +^%ZTSCH("C",ZTPAIR):ZTLKTM I '$T S STATUS="No C Lock" Q
 S ZTDTH="",^%ZTSCH("C",ZTPAIR)=0
 F  S ZTDTH=$O(^%ZTSCH("C",ZTPAIR,ZTDTH)),ZTSK=0 Q:ZTDTH=""  D  Q:ZTSK
 . F  S ZTSK=$O(^%ZTSCH("C",ZTPAIR,ZTDTH,ZTSK)),ZX=0 Q:ZTSK=""  D  Q:ZX
 .. I $D(^%ZTSK(ZTSK,0))[0!'ZTSK D  Q
 ... I ZTSK'=0,$D(^%ZTSK(ZTSK)) D TSKSTAT("I")
 ... K ^%ZTSCH("C",ZTPAIR,ZTDTH,ZTSK) S ZTSK=0
 ... Q
 .. L +^%ZTSK(ZTSK):0 Q:'$T
 .. S %ZTIO=^%ZTSCH("C",ZTPAIR,ZTDTH,ZTSK),ZTQUEUED=.5
 .. I %ZTIO]"" S ZTDEVN=1
 .. K ^%ZTSCH("C",ZTPAIR,ZTDTH,ZTSK)
 .. S ZX=1
 .. Q
 . Q
 L -^%ZTSCH("C",ZTPAIR) ;If ZTSK>0 then ^%ZTSK(ztsk) is locked.
 Q
 ;
BALANCE() ;GETTASK--check load balance, and wait while Manager waits
 Q:ZTPAIR="" 0
 S STATUS("Bal")=0
 ;Try and Lock so we are synced. If can't get Lock run. ;p446
 L +^%ZTSCH("LOADA"):0
 I $T S STATUS("Bal")=+$G(^%ZTSCH("LOADA",ZTPAIR)) L -^%ZTSCH("LOADA")
 I STATUS("Bal") H 1 ;Added set var & Hang. p446
 Q STATUS("Bal")
 ;
JOB ;GETTASK--search Partition Waiting List
 S ZTSK=0,ZTDTH=0,ZTQUEUED=0,STATUS="JOB Q"
 L +^%ZTSCH("JOBQ"):ZTLKTM I '$T S STATUS="No JOBQ Lock" Q
J2 S ZTDTH=$O(^%ZTSCH("JOB",ZTDTH)),ZTSK=0 I ZTDTH="" L -^%ZTSCH("JOBQ") Q
J3 S ZTSK=$O(^%ZTSCH("JOB",ZTDTH,ZTSK)),ZTQUEUED=0 I ZTSK'>0 G J2
 L +^%ZTSK(ZTSK):0 I '$T S STATUS="No ZTSK Lock" G J3 ;p446 Back to 0
 I $D(^%ZTSCH("JOB",ZTDTH,ZTSK))[0 L -^%ZTSK(ZTSK) S STATUS="JOB cleared" G J3
 I $D(^%ZTSK(ZTSK,0))[0 D BADTASK L -^%ZTSK(ZTSK) G J3
 S %ZTIO=^%ZTSCH("JOB",ZTDTH,ZTSK),ZTQUEUED=.5,STATUS="Work Task "_ZTSK
 K ^%ZTSCH("JOB",ZTDTH,ZTSK)
 L -^%ZTSCH("JOBQ") ;Now can release JOBQ
 ;try and only pick up work for this node.
 S ZTREC=$G(^%ZTSK(ZTSK,0)),%=$P(ZTREC,U,14) I %[":",%'[ZTNODE D  ;p446
 . L +^%ZTSCH("C",%):99 ;p446
 . S ^%ZTSCH("C",%,ZTDTH,ZTSK)=%ZTIO
 . L -^%ZTSCH("C",%),-^%ZTSK(ZTSK) ;p446
 . S ZTSK=0,%ZTIO="" ;p446
 . Q
 I %ZTIO'="" S ZTDEVN=1
 ;On exit we have ^%ZTSK(ZTSK) Locked if ZTSK>0.
 Q
 ;
BADTASK ;JOB--unschedule tasks with bad numbers or incomplete records
 S %ZTIO=^%ZTSCH("JOB",ZTDTH,ZTSK) I %ZTIO]"" S ZTDEVN=1
 I ZTSK'=0,$D(^%ZTSK(ZTSK)) D TSKSTAT("I",3)
 K ^%ZTSCH("JOB",ZTDTH,ZTSK)
 S ZTQUEUED=0
 I %ZTIO]"" D DEVLK(-1,%ZTIO)
 Q
 ;
IOQ ;GETTASK--search Device Waiting List, Lock IO then DEV.
 S ZTSK=0 I '$D(^%ZTSCH("IO")) Q
 ;Lock to just to get last scan
 L +^%ZTSCH("IO"):ZTLKTM I '$T S STATUS="No IO Lock" Q
 S ZTI=$G(^%ZTSCH("IO")),ZTH=%ZTIME,%ZTIO=$P(ZTI,"^",2)
 I $$I1() S ^%ZTSCH("IO")=ZTH_"^"_%ZTIO ;See if need to update
 L -^%ZTSCH("IO") ;Update p446
 Q
 ;
I1() ;Keep 2 sec apart
 N ZTDEVOK,X1
 I $$PDIFF(%ZTIME,+ZTI,1)'>1 Q 0 ;
I2 S %ZTIO=$O(^%ZTSCH("IO",%ZTIO)),ZTDTH="" I %ZTIO="" G IOX
 I $D(^%ZTSCH("IO",%ZTIO))<9 G I2
 S IOT=^%ZTSCH("IO",%ZTIO)
 I IOT'["RES" G I2:'$$DEVLK(1,%ZTIO) ;lock device if not Resource.
 I '$D(^%ZTSCH("DEVTRY",%ZTIO)) S ^%ZTSCH("DEVTRY",%ZTIO)=%ZTIME ;Set problem device check
 S X=%ZTIO,X1=IOT,ZTDEVOK=X D DEVOK^%ZOSV I Y D DEVLK(-1,%ZTIO) G I2
I3 S ZTDTH=$O(^%ZTSCH("IO",%ZTIO,ZTDTH)),ZTSK=0 I ZTDTH="" D DEVLK(-1,%ZTIO) G I2
I5 S ZTSK=$O(^%ZTSCH("IO",%ZTIO,ZTDTH,ZTSK)) I ZTSK'>0 G I3
 L +^%ZTSK(ZTSK):0 G I5:('$T)
 S ZTQUEUED=.5 D DQ^%ZTM4 I $G(^%ZTSK(ZTSK,0))="" L -^%ZTSK(ZTSK) G I5
 S ZTH=%ZTIME-20 ;Leave ^%ZTSCH("DEV",io) locked, Released in %ZTMS2
IOX ;
 Q 1
 ;
DEVLK(X,ZIO,TO) ;1=Lock/-1=unlock the ^%ZTSCH("DEV",ZIO) node.
 I X<0 L -^%ZTSCH("DEV",ZIO) Q
 L +^%ZTSCH("DEV",ZIO):+$G(TO,ZTLKTM) I '$T Q 0
 Q 1
 ;
SUB(X) ;Inc/Dec SUB or return SUB count
 N % L +^%ZTSCH("SUB",ZTPFLG("HOME")):5
 S %=+$G(^%ZTSCH("SUB",ZTPFLG("HOME"))) S:%<1 %=0
 I X>0 D
 . L +^%ZTSCH("SUBLK",ZTPFLG("HOME"),$J):5 ;p446
 . S ^%ZTSCH("SUB",ZTPFLG("HOME"))=%+1,^%ZTSCH("SUB",ZTPFLG("HOME"),$J)=$H_"^"_$G(STATUS)
 . Q
 I X<0 D
 . S ^%ZTSCH("SUB",ZTPFLG("HOME"))=$S(%>0:%-1,1:0) K ^%ZTSCH("SUB",ZTPFLG("HOME"),$J)
 . L -^%ZTSCH("SUBLK",ZTPFLG("HOME"),$J) ;p446
 . Q
 L -^%ZTSCH("SUB",ZTPFLG("HOME"))
 Q:X=0 % Q
 ;
JCNT(MAXWAIT) ;See if less that MaxWait tasks in JOB list p446
 N Z2,Z3 S Z3=$NA(^%ZTSCH("JOB"))
 F Z2=1:1:MAXWAIT+1 S Z3=$Q(@Z3) Q:Z3'["JOB"
 Q (MAXWAIT>Z2)
 ;
PDIFF(N,O,T) ;Positive Diff
 Q $TR($$DIFF(N,O,$G(T)),"-")
 ;
DIFF(N,O,T) ;Diff in sec.
 Q:$G(T) N-O ;For new seconds times
 Q N-O*86400-$P(O,",",2)+$P(N,",",2)
 ;
TSKSTAT(CODE,MSG) ;Update task's status
 S $P(^%ZTSK(ZTSK,.1),U,1,4)=$G(CODE)_U_$H_U_$G(MSG)_U_$J
 Q
 ;
H3(%) ;Convert $H to seconds.
 Q 86400*%+$P(%,",",2)
H0(%) ;Covert from seconds to $H
 Q (%\86400)_","_(%#86400)
 ;
FIRST() ;See if SM with lowest $J
 I $O(^%ZTSCH("SUB",ZTPFLG("HOME"),0))=$J Q 1
 Q 2
