ZTMON2 ;SEA/RDS-TaskMan: Option, ZTMON, Part 1 (Main Loop) ;2/19/08  13:36
 ;;8.0;KERNEL;**446**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ENV ;Main Entry Point For Taskman Status Monitor
 S U="^"
 N %,%H,X,Y,Z,ZT,ZT1,ZT2,ZT3,ZT4,ZTC,ZTCO,ZTD,ZTENV,ZTH,ZTR,ZTUCI,ZTX,ZTY
 D HOME^%ZIS
 X ^%ZOSF("UCI") S ZTUCI=Y W @IOF
 ;
RUN ;Evaluate RUN-Node
 W @IOF,!,"Checking Taskman."
 S ZTH=$H,ZTR=$G(^%ZTSCH("RUN"))
 I ZTR>0 S ZTD=$$DIFF^%ZTM(ZTH,ZTR,0)
 S ZTY=$S(ZTR="":0,ZTD>15:0,1:1)
 W ?20,"Current $H=",ZTH,"  (",$$HTE^%ZTLOAD7(ZTH),")"
 W !,?22,"RUN NODE=",$S(ZTR]"":ZTR,1:"<Undefined>") I ZTR]"" W "  (",$$HTE^%ZTLOAD7(ZTR),")"
 W !,"Taskman is ",$S(ZTY:"current.",ZTR]"":"late by "_(ZTD-15)_" seconds."_$C(7),$D(^%ZTSCH("STATUS")):"shutting down.",1:"not running."_$C(7))
 ;
STATUS ;Evaluate Status List
 K ZTC S ZT="",ZTH=$$H3^%ZTM($H)
 L +^%ZTSCH("LOAD"):0 E  W !,"Did not get a LOCK on ^%ZTSCH(""LOAD"")"
 F  S ZT=$O(^%ZTSCH("LOADA",ZT)) Q:ZT=""  S ZTC=^(ZT),ZTC($P(ZTC,U,4))=ZTC
 L -^%ZTSCH("LOAD")
 W !,"Checking the Status List:",!," Taskman $J  status",?22,"time",?33,"weight node"
 S ZT1="" F ZT=0:1 S ZT1=$O(^%ZTSCH("STATUS",ZT1)) Q:ZT1=""  S %=^(ZT1) D
 . W !?2,ZT1 W ?13,$P(%,U,2),?22,$$STIME($P(%,U)) W:$D(ZTC(ZT1)) ?32," ",$J($P(ZTC(ZT1),U,2),4) W ?39," ",$P(%,U,3)
 . Q
 I 'ZT W !?5,"The Status List is ",$S(ZTY:"temporarily ",1:""),"empty."
 ;
SCHQ ;Evaluate Schedule List
 W !!,"Checking the Schedule List:"
 S ZT1=$O(^%ZTSCH(0)),ZTH=$$H3^%ZTM($H)
 D OVERDUE(ZT1)
 S ZT1=0,ZTCO=0,ZTC=0
 F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  D
 . L +^%ZTSCH(ZT1):0 W:'$T !,?5,"^%ZTSCH(",ZT1,") is locked" L -^%ZTSCH(ZT1)
 . F ZT2=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  S ZTC=ZTC+1 I $$DIFF^%ZTM(ZTH,ZT1,1)>0 S ZTCO=ZTCO+1
 W !?5,"Taskman has ",$S('ZTC:"no",1:ZTC)," task",$S(ZTC'=1:"s",1:"")," scheduled."
 I ZTC=1 W !?5,"It is ",$S('ZTCO:"not ",1:""),"overdue."
 I ZTC>1 W !?5,$S('ZTCO:"None",ZTCO=ZTC&(ZTCO=2):"Both",ZTCO=ZTC:"All",1:ZTCO)," of them ",$S(ZTCO=1:"is",1:"are")," overdue." W:ZTCO>10 *7
 ;
CONT ;Continued
 D JOB,SUB
 G DONE
 ;
OVERDUE(X1) ;Write how overdue the oldest task is
 N ZTH S ZTH=$$H3^%ZTM($H)
 I X1>0,X1<ZTH S ZTH=ZTH-X1 W:ZTH>10 "  Overdue by ",ZTH
 Q
 ;
JOB ;Evaluate Job List
 W !!,"Checking the Job List:"
 S ZT1=$O(^%ZTSCH("JOB",0)) D OVERDUE(ZT1)
 L +^%ZTSCH("JOBQ"):0 I '$T D
 . W !,"  Did not get the 'JOBQ' lock."
 . Q
 S ZTC=0,ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2=0 Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:'ZT2  S ZTC=ZTC+1
 W !?5,"There ",$S(ZTC=0:"are no tasks",ZTC=1:"is 1 task",1:"are "_ZTC_" tasks")," waiting for ",$S(ZTC'=1:"partitions.",1:"a partition.") W:ZTC>20 $C(7)
 L -^%ZTSCH("JOBQ")
 ;
C ;Evaluate Cross CPU list
 S ZT1=""
 F  S ZT1=$O(^%ZTSCH("C",ZT1)) Q:ZT1=""  S ZTC=+$G(^(ZT1)) D
 . S ZTCO=0,ZT2=""
 . F  S ZT2=$O(^%ZTSCH("C",ZT1,ZT2)),ZT3=0 Q:ZT2=""  F  S ZT3=$O(^%ZTSCH("C",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTCO=ZTCO+1
 . W !?5,"For ",ZT1," there ",$S(ZTCO=1:"is ",1:"are "),ZTCO," tasks.  "
 . W $S(ZTC>8:"Not responding",$$OOS^%ZTM(ZT1):"Out Of Service",'$D(^%ZIS(14.7,"B",ZT1)):"Not defined",1:"")
 . Q
TASK ;Evaluate Task List
 W !!,"Checking the Task List:"
 S ZTC=0 F ZT1=0:0 S ZT1=$O(^%ZTSCH("TASK",ZT1)) Q:'ZT1  S ZTC=ZTC+1
 W !?5,"There ",$S(ZTC=0:"are no tasks",ZTC=1:"is 1 task",1:"are "_ZTC_" tasks")," currently running."
 Q
 ;
SUB ;Look for idle submanagers
 N %,%N,ZT1,ZT2,ZT3,ZT4,ZT5
 W !!,"Sub-manager wait detail:"
 S %N="",ZT3=$$H3($H)
 F  S %N=$O(^%ZTSCH("SUB",%N)) Q:%N=""  D
 . W !,"Node: ",%N
 . L +^%ZTSCH("SUB",%N):3 W:'$T !,"Did not get the ^%ZTSCH(""SUB"",",%N,") lock."
 . S %=0,ZT1=0,ZT4=$G(^%ZTSCH("LOADA",%N))
 . ;W "  Weight: ",$P(ZT4,U,2)
 . F  S ZT1=$O(^%ZTSCH("SUB",%N,ZT1)) Q:ZT1'>0  D
 . . W !,?5,"Job: ",ZT1
 . . L +^%ZTSCH("SUBLK",%N,ZT1):1 I $T D  Q
 . . . L -^%ZTSCH("SUBLK",%N,ZT1) Q:'$D(^%ZTSCH("SUB",%N,ZT1))
 . . . K ^%ZTSCH("SUB",%N,ZT1)
 . . . W " Didn't hold the lock, Removed from table."
 . . . Q
 . . S ZT5=$G(^(ZT1)),ZT2=$$H3($P(ZT5,U)),ZT3=$$H3($H),ZT5=$P(ZT5,U,2,4)
 . . I (ZT2+30)<ZT3 W " Last timestamp >30 sec old, Removed." K ^%ZTSCH("SUB",%N,ZT1) Q
 . . S %=%+1 W " ",ZT2-ZT3," ",$S($L(ZT5):" Status: "_ZT5,1:" Looks good.")
 . S ^%ZTSCH("SUB",%N)=%
 . W !?5,"On node ",%N," there ",$S('%:"are no",%=1:"is  1",1:"are "_$J(%,2))," free Sub-Manager(s)."
 . W " ",$S(+ZT4:"Wait",1:"Run")
 . I $G(^%ZTSCH("SUB",%N,0))>5 W !?10,"SUB-MANAGERS ARE NOT STARTING."
 . L -^%ZTSCH("SUB",%N)
 . Q
 Q
 ;
DONE ;Prompt to Quit Or Continue
 W !!,"Enter monitor action: UPDATE// "
 R ZTR:$S($D(DTIME)#2:DTIME,1:60) S:ZTR="" ZTR="U"
 I "Ee"[$E(ZTR) Q:$$CALL("LIST^XUTMKE")  G DONE
 I "Ss"[$E(ZTR) W @IOF X ^%ZOSF("SS") G DONE
 I "Pp"[$E(ZTR) W @IOF D PARAMS^ZTMCHK G DONE
 I "Ll"[$E(ZTR) W !! D LIST G DONE
 I "Dd"[$E(ZTR) K ^%ZTSCH("UPDATE"),^%ZTSCH("STATUS") W !!,"OK" H 2
 I ZTR="^"!(ZTR="@") Q
 I ZTR'["?" G RUN^ZTMON2
 I ZTR="??" Q:$$CALL("SELECT^XUTMONH")  G RUN^ZTMON2
 W !!?5,"Enter <RETURN> to update the monitor screen."
 W !?5,"Enter ^ to exit the monitor."
 W !?5,"Enter E to inspect the TaskMan Error file."
 W !?5,"Enter L to see task's in JOB pending status"
 W !?5,"Enter P to see Taskman parameters"
 W !?5,"Enter S to see a system status listing."
 W !?5,"Enter D to cause Taskman to ReRead it parameters."
 W !?5,"Enter ? to see this message."
 W !?5,"Enter ?? to inspect the tasks in the monitor's lists."
 G DONE
 ;
H3(%) ;Convert $H to seconds.
 Q 86400*%+$P(%,",",2)
 ;
CALL(RTN) ;Check for called routine
 N DUOUT
 I $D(^DIC(19,0))[0 W !,"In the wrong account." Q 0
 D @RTN Q $D(DUOUT)
 ;
LIST ;Check for tasks in stat 3.
 N ZT1,ZT2
 S ZT1=0
 F  S ZT1=$O(^%ZTSK(ZT1)) Q:'ZT1  I 3=+$G(^%ZTSK(ZT1,.1),0) D
 . D EN^XUTMTP(ZT1)
 W "Done",!
 Q
 ;
STIME(%H) ;Status time
 I +$H=+%H Q "T@"_$P($$HTE^%ZTLOAD7(%H),"@",2)
 Q "T-"_($H-%H)_"@"_$P($$HTE^%ZTLOAD7(%H),"@",2)
