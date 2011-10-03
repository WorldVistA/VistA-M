%ZTM6 ;SEA/RDS-TaskMan: Manager, Part 8 (Load Balancing) ;07/01/08  15:46
 ;;8.0;KERNEL;**23,118,127,136,355,446**;JUL 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BALANCE ;CHECK^%ZTM--determine whether cpu should wait for balance
 ;Return ZTOVERLD =1 if need to wait, 0 to run
 ;The TM with the largest value sets ^%ZTSCH("LOAD")=who^value^when p446
 ;If your value is greater or equal then you run.
 ;If your value is less you wait unless you set LOAD then you run.
 ;Tell sub-managers by setting ^%ZTSCH("LOADA",%ZTPAIR)=run^value^time^$J
 ;Use %ZTLKTM for lock timeout
 S ZTOVERLD=0 ;p446 Default
 TSTART
 L +^%ZTSCH("LOAD"):(%ZTLKTM+1) E  TROLLBACK  Q  ;p446 Keep working if can't get lock
 N X,ZTIME,ZTLEFT,ZTPREV
 N $ES,$ET S $ET="Q:$ES>0  D ERR^%ZTM6"
 S ZTOVERLD=0,ZTPREV=+$P($G(^%ZTSCH("LOAD")),"^",2),ZTIME=$$H3($H)
 S @("ZTLEFT="_%ZTPFLG("BAL"))
 S ZTIME=$$H3($H),ZTOVERLD=$$COMPARE(%ZTPAIR,ZTLEFT,ZTPREV)
 ;If we are RUNNING have other submanagers wait
 I 'ZTOVERLD D
 . S X="" F  S X=$O(^%ZTSCH("LOADA",X)) Q:X=""  S $P(^(X),"^")=1 ;Have others wait
 . S ^%ZTSCH("LOAD")=%ZTPAIR_"^"_ZTLEFT_"^"_ZTIME
 ;Now set a value that is used by our %ZTMS to run/wait also
 S ^%ZTSCH("LOADA",%ZTPAIR)=ZTOVERLD_"^"_ZTLEFT_"^"_ZTIME_"^"_$J
 L -^%ZTSCH("LOAD")
 TCOMMIT
 Q
 ;
STOPWT() ;See if we should stop Balance wait, Called from %ZTM.
 L +^%ZTSCH("LOAD"):%ZTLKTM Q:'$T 1 ;Run if can't get lock
 N I,J S I="",J=1
 F  S I=$O(^%ZTSCH("LOADA",I)) Q:I=""  I '^(I) S J=0
 L -^%ZTSCH("LOAD")
 Q J ;Return: 1 stop waiting, 0 keep waiting. (Someone is in run state)
 ;
CHECK ;Called when job limit reached.
 ;If not doing balancing, remove node and quit
 N I,J,K
 I %ZTPFLG("BAL")="" K ^%ZTSCH("LOADA",%ZTPAIR) Q
 L +^%ZTSCH("LOAD"):%ZTLKTM Q:'$T  ;Get it next time
 ;If at job limit see if sub-managers should run
 S I=$P($G(^%ZTSCH("LOAD")),"^",2),J=$P($G(^%ZTSCH("LOADA",%ZTPAIR)),"^",2)
 S K=(J<I),$P(^%ZTSCH("LOADA",%ZTPAIR),"^",1)=K
 L -^%ZTSCH("LOAD")
 Q
 ;
COMPARE(ID,ZTLEFT,ZTPREV) ;
 ;BALANCE--compare our cpu capacity left to that of previous checker
 ;input:  cpu name, cpu capacity left, cpu capacity of previous checker
 ;output: whether current cpu should wait, 0=run, 1=wait
 N X
 I ZTLEFT'<ZTPREV Q 0
 S X=^%ZTSCH("LOAD")
 I $P(X,"^",3)+(%ZTPFLG("BI")+5)<ZTIME Q 0
 Q $P(X,"^")'[ID
 ;
ERR ;Clean up if error
 S %ZTPFLG("EBAL")=1+$G(%ZTPFLG("EBAL")),ZTOVERLD=0
 I $G(%ZTPFLG("EBAL"))>10 D ^%ZTER S %ZTPFLG("BAL")="" ;Only stop after 10 errors ;p446
 S $EC=""
 ;TROLLBACK
 L -^%ZTSCH("LOAD")
 Q
 ;
H3(%) ;Convert $H to seconds
 Q 86400*%+$P(%,",",2)
 ;
VXD(BIAS) ;--algorithm for VAX DSM
 ;Capacity Left=Available Jobs + BIAS
 Q $$AVJ^%ZOSV()+$G(BIAS)
 ;
MSM4() ;Use MSMv4 LAT calcuation
 N MAXJOB,CURJOB
 X "S MAXJOB=$V($V(3,-5),-3,0),CURJOB=$V(168,-4,2)"
 Q MAXJOB-CURJOB*255\MAXJOB
 ;
CACHE1(BIAS) ;Use available jobs
 N CUR,MAX
 Q $$AVJ^%ZOSV()+$G(BIAS)
 ;
CACHE2(%COM,%LOG) ;Cache, Pull metric data
 N TMP,$ET
 S $ETRAP="S $ECODE="""" Q ZTPREV"
 S %LOG=$G(%LOG,"VISTA$METRIC")
 I $L($G(%COM)) S TMP=$ZF(-1,%COM)
 Q $ZF("TRNLNM",%LOG)
 ;
RNDRBN() ;Round Robin
 ;value^node^time
 N R,R2
 L +^%ZTSCH("RNDRBN"):$G(%ZTLKTM,1)
 S R=$G(^%ZTSCH("RNDRBN"))
 I $P(R,U,2)=%ZTPAIR S R2=+R G RX
 I ZTIME<$P(R,U,3) S R2=R-1 G RX
 S R2=R+2#512,^%ZTSCH("RNDRBN")=R2_U_%ZTPAIR_U_(ZTIME+%ZTPFLG("BI"))
RX L -^%ZTSCH("RNDRBN")
 Q R2
