ZTMON ;SEA/RDS-TaskMan: Option, ZTMON, Part 1 (Main Loop) ;3/21/07  14:36
 ;;8.0;KERNEL;**118,127,136,355,446**;Jul 10, 1995;Build 35
 ;
ENV ;Main Entry Point For Taskman Status Monitor
 D EN(1) ;Long mode
 Q
EN(MODE) ;
 D HOME^%ZIS N %,%H,X,Y,Z,ZT,ZT1,ZT2,ZT3,ZT4,ZTC,ZTCO,ZTD,ZTENV,ZTH,ZTR,ZTUCI,ZTX,ZTY
 S U="^" X ^%ZOSF("UCI") S ZTUCI=Y W @IOF
MON D RUN,STATUS,SCHQ
 ;Continued in ZTMON1
 G ^ZTMON1
 ;
EN2 ;A shorter monitor
 D EN(0)
 Q
 ;
RUN ;Evaluate RUN-Node
 W @IOF,!!,"Checking Taskman."
 S ZTH=$H,ZTR=$G(^%ZTSCH("RUN"))
 I ZTR]"" S ZTD=$$DIFF^%ZTM(ZTH,ZTR,0)
 S ZTY=$S(ZTR="":0,ZTD>20:0,1:1)
 W ?20,"Current $H=",ZTH,"  (",$$HTE^%ZTLOAD7(ZTH),")"
 W !,?22,"RUN NODE=",$S(ZTR]"":ZTR,1:"<Undefined>") I ZTR]"" W "  (",$$HTE^%ZTLOAD7(ZTR),")"
 W !,"Taskman is ",$S(ZTY:"current.",ZTR]"":"late by "_(ZTD-15)_" seconds."_$C(7),1:"")
 W:$D(^%ZTSCH("STOP")) " shutting down" W:'$D(^%ZTSCH("STATUS")) " not running."_$C(7) W "."
 Q
 ;
STATUS ;Evaluate Status List
 K X,ZTC S ZT="",ZTH=$$H3^%ZTM($H),ZT2=""
 ;Tell sub-managers by setting ^%ZTSCH("LOADA",%ZTPAIR)=run^value^time^$J
 M ZTC("S")=^%ZTSCH("STATUS"),ZTC("L")=^%ZTSCH("LOADA")
 F  S ZT=$O(ZTC("S",ZT)) Q:ZT=""  S X=ZTC("S",ZT) I $L($P(X,U,3)) S ZTC("D",$P(X,U,3),ZT)=ZT
 W !,"Checking the Status List:",!,"  Node",?14,"weight  status",?34,"time",?44," $J"
 S ZT=""
 F  S ZT=$O(ZTC("D",ZT)),ZT1="" Q:ZT=""  F  S ZT1=$O(ZTC("D",ZT,ZT1)) Q:ZT1=""  D
 . S %=ZTC("S",ZT1),ZT2=1
 . W !?1,ZT W ?15,$S($D(ZTC("L",ZT)):$J($P(ZTC("L",ZT),U,2),3),1:""),?22,$P(%,U,2),?31,$$STIME($P(%,U)) W ?44,ZT1,?54,$P(%,U,4)
 . Q
 I 'ZT2 W !?5,"The Status List is ",$S(ZTY:"temporarily ",1:""),"empty."
 Q
 ;
SCHQ ;Evaluate Schedule List
 N X,ZTL
 W !!,"Checking the Schedule List:"
 S ZT1=0,ZTCO=0,ZTC=0,ZTH=$$H3^%ZTM($H)
 S X=$O(^%ZTSCH(0)),ZTL=$$DIFF(ZTH,X,1)
 F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  D
 . F ZT2=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  S ZTC=ZTC+1 I $$DIFF(ZTH,ZT1,1)>0 S ZTCO=ZTCO+1
 W !?5,"Taskman has ",$S('ZTC:"no",1:ZTC)," task",$S(ZTC'=1:"s",1:"")," scheduled."
 I ZTC=1 W !?5,"It is ",$S('ZTCO:"not ",1:""),"overdue."
 I ZTC>1 W !?5,$S('ZTCO:"None",ZTCO=ZTC&(ZTCO=2):"Both",ZTCO=ZTC:"All",1:ZTCO)," of them ",$S(ZTCO=1:"is",1:"are")," overdue." W:ZTCO>10 *7
 I ZTC>0,ZTL>0 W "  First task is ",ZTL," seconds late."
 Q
 ;
DIFF(N,O,T) ;Diff in sec.
 Q:$G(T) N-O ;For new seconds times
 Q N-O*86400-$P(O,",",2)+$P(N,",",2)
 ;
STIME(%H) ;Status time
 I +$H=+%H Q "T@"_$P($$HTE^%ZTLOAD7(%H),"@",2)
 Q "T-"_($H-%H)_"@"_$P($$HTE^%ZTLOAD7(%H),"@",2)
