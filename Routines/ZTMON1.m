ZTMON1 ;SEA/RDS-TaskMan: Option, ZTMON, Part 2 (Main Loop) ;2/19/08  13:36
 ;;8.0;KERNEL;**36,118,127,275,446**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
MON D IO:MODE,JOB,SUB
 G DONE
 ;
IO ;Evaluate Waiting Lists
 N X,X1
 S ZT1=$$H3($H),ZT2=$G(^%ZTSCH("IO")),ZT=$$DIFF^%ZTMS1(ZT1,+ZT2,1)
 W !!,"Checking the IO Lists:" I $D(^%ZTSCH("IO"))>2 W:+ZT2 "  Last TM scan: ",ZT," sec, " W:$P(ZT2,"^",2)]"" "Last Dev: ",$P(ZT2,"^",2)
 S ZT1="",ZTT=0
I1 S ZT1=$O(^%ZTSCH("IO",ZT1)) I ZT1="" W:ZTT=0 !?5,"There are no tasks waiting for devices." Q
 I $D(^%ZTSCH("IO",ZT1))<9 G I1 ;Skip devices without tasks
 W !?5,"Device: ",ZT1 S Y=1 I ZT1'=$I S X=ZT1,X1=$G(^%ZTSCH("IO",ZT1)) D DEVOK^%ZOSV
 W $S(Y:" is not available,",$D(^%ZTSCH("DEV",ZT1)):" is allocated,",1:" is AVAILABLE,")
 S ZTC=0,ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTC=ZTC+1,ZTT=1
 W " with ",$S(ZTC=1:"one task",1:ZTC_" tasks")," waiting." W:ZTC>50 $C(7)
 G I1
 ;
JOB ;Evaluate Job List
 W !!,"Checking the Job List:"
 S ZTC=0,ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2=0 Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:'ZT2  S ZTC=ZTC+1
 W !?5,"There ",$S(ZTC=0:"are no tasks",ZTC=1:"is 1 task",1:"are "_ZTC_" tasks")," waiting for ",$S(ZTC'=1:"partitions.",1:"a partition.") W:ZTC>20 $C(7)
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
 N %N,ZT1,ZT2,ZT3,ZT4
 W !,"Checking Sub-Managers:"
 I $D(^%ZTSCH("WAIT","SUB")) W !?5,"Sub-Managers told to Wait."
 D SUBCHK^%ZTMS5(0)
 S %N=""
 F  S %N=$O(^%ZTSCH("SUB",%N)) Q:%N=""  D
 . S %=$G(^(%N)),ZT4=+$G(^%ZTSCH("LOADA",%N))
 . W !?5,"On node ",%N," there ",$S('%:"are no",%=1:"is  1",1:"are "_$J(%,2))," free Sub-Manager(s)."
 . W " Status: ",$S($D(^%ZTSCH("STOP","SUB",%N)):"Stop",ZT4:"BWait",1:"Run")
 . I $G(^%ZTSCH("SUB",%N,0))>5 W !?10,"SUB-MANAGERS ARE NOT STARTING."
 . Q
 Q
 ;
DONE ;Prompt to Quit Or Continue
 W !!,"Enter monitor action: UPDATE// "
 R ZTR:$S($D(DTIME)#2:DTIME,1:60) S:ZTR="" ZTR="U"
 I "Uu"[$E(ZTR) G MON^ZTMON
 I "Ee"[$E(ZTR) Q:$$CALL("LIST^XUTMKE")  G DONE
 I "Ss"[$E(ZTR) W @IOF X ^%ZOSF("SS") G DONE
 I "Pp"[$E(ZTR) W @IOF D PARAMS^ZTMCHK G DONE
 I "Rr"[$E(ZTR) W @IOF D RES G DONE
 I "Tt"[$E(ZTR) S MODE='MODE W !,"Mode set to ",$S(MODE:"normal",1:"short") G DONE
 I ZTR="^"!(ZTR="@") Q
 I ZTR'["?" G MON^ZTMON
 I ZTR="??" Q:$$CALL("SELECT^XUTMONH")  G MON^ZTMON
 W !!?5,"Enter <RETURN> to update the monitor screen."
 W !?5,"Enter ^ to exit the monitor."
 W !?5,"Enter E to inspect the TaskMan Error file."
 W !?5,"Enter P to see taskman parameters."
 W !?5,"Enter R to see busy Resource slots."
 W !?5,"Enter S to see a system status listing."
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
RES ;Check on resource devices
 N ZT1,ZT2,ZT3,ZTIM,X
 S ZT1=""
 F  S ZT1=$O(^%ZTSCH("IO",ZT1)) Q:ZT1=""  I ^%ZTSCH("IO",ZT1)="RES" D
 . ;Q:$D(^%ZTSCH("IO",ZT1))<9
 . S ZT2=$O(^%ZISL(3.54,"B",ZT1,0)),ZT3=0 Q:ZT2'>0
 . S X=$G(^%ZISL(3.54,ZT2,0))
 . W !,"Resource ",ZT1,"  Aval. Slots: ",$P(X,U,2)
 . F  S ZT3=$O(^%ZISL(3.54,ZT2,1,ZT3)) Q:ZT3'>0  D
 . . S X=^%ZISL(3.54,ZT2,1,ZT3,0),ZTIM=$P(X,U,5) I ZTIM]"",ZTIM'["," S ZTIM=$$H0^%ZTM(ZTIM)
 . . W !,?10,"Slot: ",$J(ZT3,2)," Job: ",$P(X,U,3)," Task: ",$P(X,U,4)
 . . W "  time: ",$$HDIFF^%ZTLOAD7($H,ZTIM,2)
 . . Q
 . Q
 Q
