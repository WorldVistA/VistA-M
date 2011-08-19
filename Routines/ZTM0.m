%ZTM0 ;SEA/RDS-TaskMan: Manager, Part 2 (Begin) ;07/17/08  08:16
 ;;8.0;KERNEL;**42,36,67,88,118,127,136,175,275,355,446**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
START ;Entry Point--start Task Manager at system startup
 S $ETRAP="D ER^%ZTM5",^%ZTSCH("ER")="",U="^"
 L ^%ZTSCH:10 G:'$T RESTART ;Someone already running
 K ^%ZTSCH("DEV"),^("DEVOPEN"),^("LOAD"),^("LOADA"),^("STATUS"),^("STOP"),^("SUB"),^("UPDATE")
 S %ZTIME=$$H3^%ZTM($H)
 D STATUS^%ZTM("RUN","Startup") ;Move after kill p446
 S %ZTLKTM=5 ;Temp value for I6^%ZTM ;p446
 D I6^%ZTM ;Handle Persistent Jobs
 S ZTSK=0 F  S ZTSK=$O(^%ZTSCH("TASK",ZTSK)) Q:'ZTSK  D
 . D TSKSTAT^%ZTM1("E","Interrupted While Running")
 . K ^%ZTSCH("TASK",ZTSK)
 K ^%ZTSCH("TASK") ;Remove all p446
 D SETUP
 I "CFO"[%ZTYPE G BADTYPE ;Moved after SETUP p446
 S ^%ZTSCH("IDLE")=0,^%ZTSCH("SUB",%ZTPAIR)=0,^(%ZTPAIR,0)=0
 D STATUS^%ZTM("RUN","Startup Hang")
 H %ZTPFLG("TM-DELAY") ;Wait for system stability.
S1 ;
 D STATUS^%ZTM("RUN","Startup jobs")
 ;S %ZTLOOP=0,%ZTRUN=1 D CHECK^%ZTM ;Why? ;p446
 D STRTUP
 S ZTU="" F  S ZTU=$O(^%ZTSCH("C",ZTU)) Q:ZTU=""  S ^%ZTSCH("C",ZTU)=0 ;Reset VS counts in C list.
 K %ZTI,%ZTY,ZTIO,ZTO,ZTP,ZTSK,ZTU
 I %ZTPFLG("XUSCNT") D COUNT^XUSCNT(1)
 G ^%ZTM
 ;
RESTART ;Entry Point--restart Task Manager
 S $ETRAP="D ER^%ZTM5",^%ZTSCH("ER")="",U="^"
 K ^%ZTSCH("STATUS"),^("STOP")
 S %ZTIME=$$H3^%ZTM($H)
 D STATUS^%ZTM("RUN","Restart") ;Move after kill p446
 D SETUP
 I '$D(^%ZTSCH("IDLE")) S ^%ZTSCH("IDLE")=0
 I '$D(^%ZTSCH("SUB",%ZTPAIR)) S ^%ZTSCH("SUB",%ZTPAIR)=0
 I "CFO"[%ZTYPE G BADTYPE
 I %ZTPFLG("XUSCNT") D COUNT^XUSCNT(1)
 G ^%ZTM
 ;
 ;
SETUP ;Setup Task Manager's Environment
 N X,Y,Z,ZT
ST2 S ^%ZTSCH("RUN")=$H,%ZTPAIR="ROU"
 D STATUS^%ZTM("RUN","Setup")
 D ZOSF I Y]"" D STATUS^%ZTM("PAUSE","The following required ^%ZOSF nodes are undefined: "_Y_".") H 60 G ST2
 D UPDATE^%ZTM5 I $D(ZTREQUIR)#2 D STATUS^%ZTM("PAUSE","Required link to "_ZTREQUIR_" is down.") H 60 G ST2
 ;Clear the NOT Responding count
 S X="" F  S X=$O(^%ZTSCH("C",X)) Q:X=""  S ^%ZTSCH("C",X)=0
 D JOB,NOLOG^%ZOSV S %ZTNLG=Y,DTIME=1,DUZ=0,DUZ(0)="@"
 K Z D NAME K X,Y,Z,ZT
 Q
STRTUP ;Queue the entries from the STARTUP X-ref
 ;After talking with the DBA, All STARTUP jobs will have DUZ=.5
 N ZTU,ZTO,ZTSAVE,ZTRTN,DUZ
 S DUZ=.5,DUZ(0)="@"
 S ZTU="" F  S ZTU=$O(^%ZTSCH("STARTUP",ZTU)),ZTO="" Q:ZTU=""  F  S ZTO=$O(^%ZTSCH("STARTUP",ZTU,ZTO)) Q:ZTO=""  D
 . S ZTSAVE("XQY")=$P(ZTO,"Q",2) ;This must be set for %ZTLOAD
 . S ZTDTH=$H,ZTIO=$P(^%ZTSCH("STARTUP",ZTU,ZTO),"^",2),ZTRTN="ZTSK^XQ1",ZTSAVE($S(ZTO["Q":"XQSCH",1:"XQY"))=+ZTO,ZTUCI=$P(ZTU,","),ZTCPU=$P(ZTU,",",2)
 . D ^%ZTLOAD
 . Q
 Q
 ;
ZOSF ;SETUP--determine whether any required ^%ZOSF nodes are missing
 S Y=""
 F X="ACTJ","OS","PROD","UCI","UCICHECK","VOL" I $D(^%ZOSF(X))[0 S Y=Y_","_X
 S:$T(ACTJ^%ZOSV)="" Y=Y_",ACTJ^%ZOSV"
 I Y]"" S Y=$E(Y,2,$L(Y))
 Q
 ;
JOB ;SETUP--setup JOB command
 I %ZTOS["OpenM" D  Q
 . S:'$L(%ZTPFLG("DCL")) %ZTJOB="J ^%ZTMS::5"  ;"J ^%ZTMS:ZTUCI:5"
 . S:$L(%ZTPFLG("DCL")) %ZTJOB="D ^%ZTMDCL"
 . Q
 I %ZTOS["GT.M" S %ZTJOB="J GTM^%ZTMS::5",@("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""") Q
 I %ZTOS["VAX DSM" D  Q
 . S:'$L(%ZTPFLG("DCL")) %ZTJOB="J ^%ZTMS:(OPTION=""/UCI=""_$P(ZTUCI,"","")_""/VOL=""_ZTDVOL):5"
 . S:$L(%ZTPFLG("DCL")) %ZTJOB="D ^%ZTMDCL"
 . Q
 I %ZTOS["MSM" S %ZTJOB="J ^%ZTMS[ZTUCI,ZTDVOL]:%ZTSIZ:5" Q  ;Set Maxpartsiz
 I %ZTOS["DTM" S %ZTJOB="J ^%ZTMS:(NSPACE=ZTUCI)" Q
 S %ZTJOB="J ^%ZTMS::5"
 Q
 ;
NAME ;Give a name to process.
 N $ETRAP,ZQ S $ETRAP="S ZQ=0,$EC="""" Q"
 F Z=1:1:9 S X="Taskman "_%ZTVOL_" "_Z,ZQ=1 D SETENV^%ZOSV Q:ZQ
 Q
BADTYPE ;Taskman should not run on this type of node.
 K ^%ZTSCH("STATUS")
 S ^%ZTSCH("RUN")=%ZTPAIR_" is the wrong type in taskman site parameters."
 Q
 ;
HALT ;Cleanup and halt
 I %ZTPFLG("XUSCNT") D COUNT^XUSCNT(-1)
 K ^%ZTSCH("STATUS",$J),^%ZTSCH("RUN"),^%ZTSCH("UPDATE",$J)
 K ^%ZTSCH("LOADA",%ZTPAIR)
 X "HALT"
