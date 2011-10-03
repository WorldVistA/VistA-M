SDPPRT ;ALB/CAW - Patient Profile - Print ;10/15/93
 ;;5.3;Scheduling;**6,19,41,140,132**;AUG 13, 1993
 ;
EN ;Print entire patient profile
 ;
 D ENS^%ZISS
 D DIR G:SDERR ENQ
 W !!,$$LINE("Device Selection")
 S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D PRINT G ENQ
 S Y=$$QUE
ENQ D:'$D(ZTQUEUED) ^%ZISC
 K SDERR,SDTYP S VALMBCK="R" Q
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 N X K ZTSK,IO("Q")
 S ZTDESC="Patient Profile",ZTRTN="PRINT^SDPPRT"
 F X="DFN","SDACT","SDBD","SDBEG","SDED","SDEND","SDTYP","SDTYP(","SDPRINT","SDRANGE" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
 ;
PRINT ;Print actual patient profile
 U IO N SDWHERE,SDALL,SDGO K ^TMP("SD",$J),^TMP("SDAPT",$J),^TMP("SDENR",$J),^TMP("SDPP",$J),^TMP("SDPPALL",$J)
 S (SDPAGE,SDTYP)=0,SDGO=1 D INIT1^SDPP,INIT^SDPPALL
 S (SDALL,SDWHERE)=0 I '$$HDR G PRINTQ
 F  S SDWHERE=$O(^TMP("SDPP",$J,SDWHERE)) Q:'SDWHERE  S:($Y+6>IOSL) SDGO=$$HDR G:'SDGO PRINTQ W !,^TMP("SDPP",$J,SDWHERE,0)
 F  S SDALL=$O(^TMP("SDPPALL",$J,SDALL)) Q:'SDALL  S:($Y+6>IOSL) SDGO=$$HDR G:'SDGO PRINTQ W !,^TMP("SDPPALL",$J,SDALL,0)
PRINTQ K ^TMP("SDPP",$J),^TMP("SDPPALL",$J) S SDLN=0 D:'$D(ZTQUEUED) INIT1^SDPP
 I SDGO,SDPAGE,$E(IOST,1,2)="C-" D PAUSE^VALM1 Q
 Q
LINE(STR) ; -- print line
 ;  input: STR := text to insert
 ; output: none
 ; return: text to use
 ;
 N X
 S:STR]"" STR=" "_STR_" "
 S $P(X,"_",(IOM/2)-($L(STR)/2))=""
 Q X_STR_X
 ;
DIR ;Ask what they want printed
 N SDYN S SDPRINT=1,SDERR=0
 I $O(^DPT(DFN,"S",SDBD)) D  I SDERR G DIRQ
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to print appointments",DIR("?")="Enter 'NO' if you do not want the appointments, otherwise enter 'YES'."
 .D ^DIR K DIR I $D(DIRUT) S SDERR=1 Q
 .I Y S SDTYP(2)=""
 IF $$EXOE^SDOE(DFN,SDBD,SDED) D  I SDERR G DIRQ
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to print add/edits",DIR("?")="Enter 'NO' if you do not want the add/edits, otherwise enter 'YES'."
 .D ^DIR K DIR I $D(DIRUT) S SDERR=1 Q
 .I Y S SDTYP(1)=""
 I $D(^DPT(DFN,"DE")) D  I SDERR G DIRQ
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to print enrollments",DIR("?")="Enter 'NO' if you do not want the enrollments, otherwise enter 'YES'."
 .D ^DIR K DIR I $D(DIRUT) S SDERR=1 Q
 .I Y S SDTYP(4)="",SDACT=0
 I $D(^DPT(DFN,"DIS")),$S('SDRANGE:1,+$O(^("DIS",9999999-(SDED+.9)))&($O(^(9999999-(SDED+.9)))<(9999999-(SDBD-.1))):1,1:0) D  I SDERR G DIRQ
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to print dispositions",DIR("?")="Enter 'NO' if you do not want the dispositions, otherwise enter 'YES'."
 .D ^DIR K DIR I $D(DIRUT) S SDERR=1 Q
 .I Y S SDTYP(3)=""
 S SDYN=$$LST^DGMTU(DFN) I SDYN D  I SDERR G DIRQ
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to print means test",DIR("?")="Enter 'NO' if you do not want the means test, otherwise enter 'YES'."
 .D ^DIR K DIR I $D(DIRUT) S SDERR=1 Q
 .I Y S SDTYP(5)=""
 ;adding team information - chris mckee 2/6/96
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to print team information",DIR("?")="Enter 'NO' if you do not want the team information, otherwise enter 'YES'."
 D ^DIR K DIR I $D(DIRUT) S SDERR=1 Q
 I Y S SDTYP(7)="",GBL="^TMP(""SDPP"","_$J_")"
DIRQ Q
 ;
HDR() ; -- print header
 ;  return: continue processing [ 1|yes   0|no ]
 ;
 N Y
 I SDPAGE,$E(IOST,1,2)="C-" D PAUSE^VALM1 G:'Y HDRQ
 S SDPAGE=SDPAGE+1 D PID^VADPT6
 W @IOF,*13,"PATIENT PROFILE: ",$P(^DPT(DFN,0),U)_" ("_VA("BID")_")",?45,$S($D(^DPT(DFN,.1)):"Ward: "_^(.1),1:"Outpatient"),?70,"Page: ",SDPAGE
 ;
 W !,"Dates: ",$S(SDBD:$TR($$FMTE^XLFDT(SDBD,"5DF")," ","0"),1:"All"),$S(SDED'=9999999:" to "_$TR($$FMTE^XLFDT(SDED,"5DF")," ","0"),1:" Dates")
 W ?45,"Report Date: ",$P($$NOW^VALM1,":",1,2)
 W !,SDASH S Y=1
HDRQ Q Y
