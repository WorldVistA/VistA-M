RGMTRUN ;BIR/CML,PTD-SCAN TASKMAN RUNNING HL7 TASKS ;07/12/00
 ;;1.0;CLINCAL INFO RESOURCE NETWORK;**25,20**;30 Apr 99
 ;
 ;Reference to ^%ZTSCH("TASK" supported by IA #3520
 ;Reference to EN^XUTMTP supported by IA #3521
 ;Setting ZT* and XU* variables supported by IA #3521
 ;
MAIN ;Entry point for device call
 W !!,"This option prints the currently running HL7 tasks."
 W !,"The right margin for this report is 80.",!
 S NOTRPC=1
 K ZTSAVE S ZTSAVE("NOTRPC")=""
 D EN^XUTMDEVQ("START^RGMTRUN","Print Running HL7 Task Data") I 'POP K NOTRPC Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 K NOTRPC
 Q
 ;
START ;Entry point for RPC call
 S $P(LN,"-",80)="",CNT=0,QFLG=0
 I $D(NOTRPC) W @IOF,!
 I '$D(NOTRPC) W "Running HL7 Tasks at "_$P($$SITE^VASITE(),"^",2)_":"
 I '$D(NOTRPC) D NOW^%DTC W !,"Date compiled: ",$$FMTE^XLFDT($E(%,1,12))
 ;
 S TASK=0 F  S TASK=$O(^%ZTSCH("TASK",TASK)) Q:'TASK  Q:QFLG  D
 .S ROU=$P(^%ZTSCH("TASK",TASK),"^",2)
 .I (ROU["HL")!(ROU["RG") D
 ..S CNT=CNT+1
 ..N ZTENV,ZTKEY,ZTFLAG,ZTNAME,XUTMUCI
 ..S ZTENV=1,ZTKEY=0,ZTFLAG=1,ZTNAME=$$GET1^DIQ(200,+DUZ_",",.01)
 ..X ^%ZOSF("UCI") S XUTMUCI=Y
 ..D EN^XUTMTP(TASK) W !,LN
 ..I $D(NOTRPC),CNT=5 W ! S DIR(0)="E" D ^DIR K DIR S CNT=0 S:'Y QFLG=1 I Y W @IOF
 ;
QUIT ;Kill variables and quit.
 I $D(NOTRPC) W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,CNT,LN,NOTRPC,QFLG,ROU,TASK,Y,ZTSK
 Q
 ;
 ;
TASK(RETURN) ;Remote HL7 task display
 N ARRAY
 S ARRAY="^TMP(""RGMTHFS"","_$J_")"
 D HFS^RGMTHFS("START^RGMTRUN")
 M RETURN=^TMP("RGMTHFS",$J)
 K ^TMP("RGMTHFS",$J)
 Q
 ;
