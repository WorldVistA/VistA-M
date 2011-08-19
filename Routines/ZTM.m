%ZTM ;SEA/RDS-TaskMan: Manager, Part 1 (Main Loop) ;10/02/08  09:00
 ;;8.0;KERNEL;**24,36,64,67,118,127,136,275,355,446**;JUL 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;%ZTCHK is set to 1 @ top of SCHQ, set to 0 if sent a task to SM
LOOP ;Taskman's Main Loop
 S %ZTRUN=1,%ZTCHK=1
 F %ZTLOOP=0:1 S %ZTLOOP=%ZTLOOP#16 D CHECK,SCHQ,IDLE:%ZTCHK
 S %ZTFALL="" G LOOP
 ;
CHECK ;LOOP--Check Status And Update Loop Data
 ;Do CHECK if sent a new job or %ZTLOOP=0.
 Q:%ZTLOOP&$G(%ZTCHK)
 I $D(^%ZTSCH("STOP","MGR",%ZTPAIR)) G HALT^%ZTM0
 S ^%ZTSCH("RUN")=$H,ZTPAIR="",%ZTIME=$$H3($H)
 I $D(^%ZTSCH("WAIT","MGR"))#2 D STATUS("WAIT","Taskman Waiting") H 5 G CHECK
 ;
 I '$D(^%ZTSCH("UPDATE",$J)) D UPDATE^%ZTM5
 I %ZTVLI D STATUS("PAUSE","Logons Inhibited") H 60 G CHECK ;Set in %ZTM5
 I @%ZTNLG D INHIBIT^%ZTM5(1),STATUS("PAUSE","No Signons Allowed") H 60 G CHECK
 I $G(^%ZIS(14.5,"LOGON",%ZTVOL)) D INHIBIT^%ZTM5(0) ;Check field
 I $D(ZTREQUIR)#2 D STATUS("PAUSE","Required link to "_ZTREQUIR_" is down.") H 60 D REQUIR^%ZTM5 G CHECK
 ;
 I $D(^%ZTSCH("LINK"))#2,$$DIFF($H,^("LINK"))>900 D LINK^%ZTM3
 ;Job Limit check done in NEWJOB. p446
 ;
 I $L(%ZTPFLG("BAL")) D  I ZTOVERLD G CHECK
 . S ZTOVERLD=0
 . Q:%ZTPFLG("LBT")>%ZTIME  ;Running, Not time to recheck
 . S %ZTPFLG("LBT")=%ZTIME+%ZTPFLG("BI") ;Next time to check.
 . D BALANCE^%ZTM6 Q:'ZTOVERLD
 . D STATUS("BALANCE","Load Balance Wait.")
 . ;Start submanagers for C list work
 . I $D(^%ZTSCH("C",%ZTPAIR))>9 D NEWJOB(%ZTUCI,%ZTVOL,"")
 . N T F T=1:2:%ZTPFLG("BI") H 2 Q:$$STOPWT^%ZTM6()  ;p446 Wait, Check if leave early
 . Q
 ;
 I %ZTRUN D STATUS("RUN","Main Loop")
 I '%ZTRUN D
 . D STATUS("RUN","Taskman Job Limit Reached"),CHECK^%ZTM6
 . S %ZTPFLG("JLC")=(%ZTPFLG("JLC")+1)#3
 . I '%ZTPFLG("JLC") S %ZTRUN=%ZTVMJ>$$ACTJ^%ZOSV ;ReCheck for job limit p446
 Q
 ;
STATUS(ST,MSG) ;Record TM status
 N F
 ;p446 Only update status every 5 seconds, unless MSG has changed.
 S F=(MSG'=$G(%ZTPFLG("StatusM")))
 I $G(%ZTPFLG("Status"))>%ZTIME,'$G(F) Q
 S ^%ZTSCH("STATUS",$J)=$H_"^"_ST_"^"_$G(%ZTPAIR)_"^"_MSG
 S %ZTPFLG("Status")=%ZTIME+5,%ZTPFLG("StatusM")=MSG
 Q
 ;
TLOCK(M) ;Lock/unlock the SCHQ node
 I M>0 L +^%ZTSCH("SCHQ"):%ZTLKTM Q $T
 L -^%ZTSCH("SCHQ") Q
 ;
SCHQ ;LOOP--Check Schedule List
 S %ZTIME=$$H3($H),ZTDTH=0,ZTSK=0,%ZTCHK=1,IO=""
 I '$$TLOCK(1) Q  ;Lock and Sync %ZTSCH
S1 S ZTDTH=$O(^%ZTSCH(ZTDTH)),ZTSK=0 I (ZTDTH>%ZTIME)!('ZTDTH)!(ZTDTH'?1.N) D TLOCK(-1) Q
 I +ZTDTH<0 K ^%ZTSCH(ZTDTH) G S1
S2 S ZTSK=$O(^%ZTSCH(ZTDTH,ZTSK)) I ZTSK="" G S1
 S ZTST=$G(^%ZTSCH(ZTDTH,ZTSK))
 ;Get task lock then release SCHQ lock
 L +^%ZTSK(ZTSK):0 G S2:'$T
 K ^%ZTSCH(ZTDTH,ZTSK) D TLOCK(-1)
 I $D(^%ZTSK(ZTSK,0))[0 D TSKSTAT("I") L -^%ZTSK(ZTSK) Q  ;p446
 I $L($P($G(^%ZTSK(ZTSK,.1)),U,10)) D TSKSTAT("D","Stopped") L -^%ZTSK(ZTSK) Q  ;p446
 D ^%ZTM1
 I %ZTREJCT L -^%ZTSK(ZTSK) Q  ;p446, Need to get SCHQ lock again.
 ;Count tasks
 S %ZTMON(%ZTMON)=$G(%ZTMON(%ZTMON))+1
 ;
SEND ;Send Task To Submanager
 S %ZTCHK=0,ZTPAIR=""
 I ZTDVOL'=%ZTVOL D XLINK^%ZTM2 G:'ZTJOBIT SCHX
 ;Clear before job cmd
 L +^%ZTSCH("JOBQ"):99
 I (ZTYPE'="C")&(%ZTNODE[ZTNODE) D
 . D TSKSTAT(3,"Placed on JOB List")
 . S ^%ZTSCH("JOB",ZTDTH,ZTSK)=IO ;No other lock on JOB
 E  D
 . D TSKSTAT("M","Placed on C List")
 . S ZTPAIR=ZTDVOL_$S($L(ZTNODE):":"_ZTNODE,1:"")
 . S ^%ZTSCH("C",ZTPAIR,ZTDTH,ZTSK)=IO
 ;
 L -^%ZTSK(ZTSK),-^%ZTSCH("JOBQ")
 ;Check if need new sub-manager.
 I (ZTYPE="C")!$$NEWSUB,'$$OOS(ZTPAIR) D NEWJOB(ZTUCI,ZTDVOL,ZTNODE)
SCHX ;Clear all locks
 L  K ZTREP
 Q
 ;
IDLE ;LOOP--DEV Node Maintenance; Backup JOB Commands
 N R,C,T
 I %ZTMON("NEXT")'>%ZTIME D MON ;See if time to update %ZTMON
 S (ZTREC,ZTCVOL)="" H 1 ;This is the main hang
 I $D(^%ZTSCH("STOP","MGR",%ZTPAIR)) Q
 ;job off a new submanager if MIN count < # SUBs
 I $$NEWSUB D NEWJOB(%ZTUCI,%ZTVOL,"")
 ;Job off a new submanagers if the JOB list is long.
 S R=$NA(^%ZTSCH("JOB")),C=0,T=15
 F  S R=$Q(@R),C=C+1 Q:R'["JOB"  I C>T D NEWJOB(%ZTUCI,%ZTVOL,"") Q  ;Just start one at a time ;p446
 ;Other Idle work.
 L +^%ZTSCH("IDLE",%ZTPAIR):%ZTLKTM Q:'$T  D IDLE1 L -^%ZTSCH("IDLE",%ZTPAIR)
 Q
 ;
IDLE1 ;only proceed with idle work if 60 seconds since last check
 I $$DIFF(%ZTIME,^%ZTSCH("IDLE"),1)<60 Q
 S ^%ZTSCH("IDLE")=%ZTIME ;Set new time.
 I %ZTPFLG("XUSCNT") D TOUCH^XUSCNT
 D I1,I2 X "JOB DETACH^%ZTM"
 Q
 ;
I1 ;clear out old DEV nodes
 N X,%ZTIO S %ZTIO=""
 F  S %ZTIO=$O(^%ZTSCH("DEV",%ZTIO)) Q:%ZTIO=""  L +^%ZTSCH("DEV",%ZTIO):0 I $T D  L -^%ZTSCH("DEV",%ZTIO)
 . S X=$G(^%ZTSCH("DEV",%ZTIO)) Q:'$L(X)
 . I $$DIFF(%ZTIME,X,1)>120 K ^%ZTSCH("DEV",%ZTIO)
 . Q
 Q
 ;
I2 ;job new submanagers cross-volume for each unfinished C list
 I $D(^%ZTSCH("C")) D
 . N Y,ZTUCI,ZTVOL,ZTNODE,$ETRAP,$ESTACK S $ET="S $EC="""" D ERCL^%ZTM2"
 . S ZTVOL="" F  S ZTVOL=$O(^%ZTSCH("C",ZTVOL)) Q:ZTVOL=""  D
 .. I $O(^%ZTSCH("C",ZTVOL,0))="" Q
 .. S ZTNODE="",ZTDVOL=ZTVOL S:ZTDVOL[":" ZTNODE=$P(ZTDVOL,":",2),ZTDVOL=$P(ZTDVOL,":")
 .. S X=$G(^%ZTSCH("C",ZTVOL))
 .. I $D(^%ZTSCH("LINK",ZTDVOL))!(X>9)!$$OOS(ZTVOL) Q
 .. S ^%ZTSCH("C",ZTVOL)=X+1
 .. S ZTUCI=$O(^%ZIS(14.6,"AV",ZTDVOL,""))
 .. D NEWJOB(ZTUCI,ZTDVOL,ZTNODE)
 .. Q
 . Q
 Q
 ;
MON ;Set Next %ZTMON each Hour
 I %ZTMON("DAY")<+$H D DAY^%ZTM5
 S %ZTMON=$P($H,",",2)\3600,%ZTMON(%ZTMON)=0
 S %ZTMON("NEXT")=($H*86400)+(%ZTMON+1*3600)
 D HOUR^%ZTM5
 Q
 ;
NEWJOB(ZTUCI,ZTDVOL,ZTNODE) ;Start a new Job
 S %ZTRUN=%ZTVMJ>$$ACTJ^%ZOSV ;Check for job limit p446
 ;At the job limit if $ZTRUN=0
 I '%ZTRUN D STATUS("RUN","Taskman Job Limit Reached") Q
 S ZTUCI=$G(ZTUCI),ZTDVOL=$G(ZTDVOL),ZTNODE=$G(ZTNODE)
 X %ZTJOB H %ZTSLO ;If job doesn't work, will catch next time.
 Q
 ;
DIFF(N,O,T) ;Diff in sec.
 Q:$G(T) N-O ;For new seconds times
 Q N-O*86400-$P(O,",",2)+$P(N,",",2)
 ;
OOS(BV) ;Check if Box-Volume is Out Of Service, Return 1 if OOS.
 Q:BV="" 0 N %
 S %=$O(^%ZIS(14.7,"B",BV,0)),%=$G(^%ZIS(14.7,+%,0))
 Q:%="" 1 Q $P(%,U,11)=1
 ;
H3(%) ;Convert $H to seconds.
 Q 86400*%+$P(%,",",2)
 ;
H0(%) ;Covert from seconds to $H
 Q (%\86400)_","_(%#86400)
 ;
SUBOK() ;Check if sub's are starting, return 1 if OK
 N T L +^%ZTSCH("SUB",%ZTPAIR):0 S T=$T
 S ^%ZTSCH("SUB",%ZTPAIR,0)=($G(^%ZTSCH("SUB",%ZTPAIR,0))+1)_"^"_$H
 I T L -^%ZTSCH("SUB",%ZTPAIR)
 Q ^%ZTSCH("SUB",%ZTPAIR,0)<10
 ;
NEWSUB() ;See if we need a new submanager
 N SUBS,T
 L +^%ZTSCH("SUB",%ZTPAIR):0 S T=$T ;Sync ^%ZTSCH("SUB",%ZTPAIR)
 S SUBS=^%ZTSCH("SUB",%ZTPAIR)
 I T L -^%ZTSCH("SUB",%ZTPAIR)
 Q SUBS<%ZTPFLG("MINSUB")
 ;
TSKSTAT(CODE,MSG) ; Update task's status
 S $P(^%ZTSK(ZTSK,.1),U,1,4)=$G(CODE)_U_$H_U_$G(MSG)_U_$J
 Q
 ;
DETACH ;Do slow work in background job
 D PARAMS^%ZTM5 S $ET="D ^%ZTER"
 D I5,I6
 Q
 ;
I5 ;Clean up %ZTSCH
 S ZTDTH="0,0" F  S ZTDTH=$O(^%ZTSCH(ZTDTH)) Q:ZTDTH'[","  D
 . L +^%ZTSCH("SCHQ"):%ZTLKTM Q:'$T  ;Keep others out while cleaning
 . N ZTSK,X
 . S ZTSK=$O(^%ZTSCH(ZTDTH,0)) I ZTSK>0 S X=^(ZTSK),^%ZTSCH($$H3(ZTDTH),ZTSK)=X K ^%ZTSCH(ZTDTH,ZTSK)
 . L -^%ZTSCH("SCHQ")
 . Q
 Q
 ;
I6 ;Check on persistent jobs, Locks can take time, Called from %ZTM0 at start.
 S ZTSK=0 F  S ZTSK=$O(^%ZTSCH("TASK",ZTSK)) Q:ZTSK'>0  D:$D(^%ZTSCH("TASK",ZTSK,"P"))
 . L +^%ZTSCH("TASK",ZTSK):%ZTLKTM E  Q  ;Still running
 . D:$D(^%ZTSCH("TASK",ZTSK,"P")) REQP^%ZTLOAD3(ZTSK) ;START NEW TASK.
 . K ^%ZTSCH("TASK",ZTSK)
 . L -^%ZTSCH("TASK",ZTSK)
 . Q
 K %ZTVS
 Q
 ;
