IBCNSOK ;ALB/AAS - Patient Insurance consistency checker ; 2/22/93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(DT) D DT^DICRW
 K ^TMP("IBCNS-ERR",$J)
 ;
 W !!,"Check Patient file Insurance Type Group Plan consistency"
 W !!,"I'm going to check the Insurance company for each patient policy with the",!,"Insurance company in the associated Group Plan file."
 W !!,"This will take a while, please queue this job to a device.  I'll print",!,"a report when I'm done.",!!
 ;
UP S IBUPDAT=0
 S DIR(0)="Y",DIR("A")="Update any Inconsistencies",DIR("B")="NO"
 S DIR("?")="Enter YES if you want any inconsistencies updated, enter NO if you just want the report."
 D ^DIR K DIR
 S IBUPDAT=+Y I $D(DIRUT) G END
 ;
DEV W !! S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") D  G END
 .S ZTRTN="DQ^IBCNSOK",ZTDESC="IB - v2 PATIENT FILE DOUBLE CHECK",ZTIO="",ZTSAVE("IB*")=""
 .W ! D ^%ZTLOAD D HOME^%ZIS
 .I $D(ZTSK) W !,"    Patient file update queued as task ",ZTSK K ZTSK Q
 ;
 D DQ G END
 Q
 ;
END K ^TMP("IBCNS-ERR",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K %ZIS,DIRUT,I,J,X,Y,DA,DR,DIC,DIE,DIR,IBCPOL,IBCOPOL2,IBCDFND,NODE,IBI,IBCNTI,IBCNTP,IBCNTPP,IBUPDT,IBCDFN
 Q
 ;
DQ ; -- entry point from task man
 U IO
 S IBQUIT=0
 D NOW^%DTC S IBSPDT=%
 I '$D(ZTQUEUED) D
 .W !!,"    I'll write a dot for each 100 entries"
 .W:IBUPDAT !,"    and a + for each entry updated"
 .W !,"    Start time: " S Y=IBSPDT D DT^DIQ
 N DFN,IBI,IBCPOL,IBCDFND,DA,DR,DIE,DIC,IBCNT,IBCNTP,IBCNTPP,IBCNTI,IBCDFN
 S (IBCNT,IBCNTP,IBCNTPP,IBCNTI,DFN)=0
 ;
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S IBCNT=IBCNT+1,IBCDFN=0 S:$O(^DPT(DFN,.312,IBCDFN)) IBCNTI=IBCNTI+1 F  S IBCDFN=$O(^DPT(DFN,.312,IBCDFN)) Q:'IBCDFN  D
 .I '$D(ZTQUEUED) W:'(IBCNTPP#100) "."
 .S IBCNTPP=IBCNTPP+1
 .S IBCDFND=$G(^DPT(DFN,.312,IBCDFN,0))
 .I IBCDFND="",$D(^DPT(DFN,.312,IBCDFN)) D ERR3
 .;
 .S IBCPOL=+$G(^IBA(355.3,+$P(IBCDFND,"^",18),0))
 .I '$P(IBCDFND,"^",18) D ERR1 Q  ; no group plan field
 .I +IBCPOL'=+IBCDFND D ERR2 Q  ;   ins. companies don't match
 .Q
 ;
 D REPORT G END
 Q
 ;
ERR1 ; -- no group plan pointer
 S NODE="IBCNS-ERR1" D FIX
 Q
 ;
ERR2 ; -- wrong insurance pointer
 S NODE="IBCNS-ERR2" D FIX
 Q
 ;
ERR3 ; -- dangle insurance node left
 S NODE="IBCNS-ERR3" D SET
 I IBUPDAT K ^DPT(DFN,.312,IBCDFN) W:'$D(ZTQUEUED) "+"
 Q
 ;
FIX ; -- reset pointer correctly
 S IBCPOL2=IBCPOL
 ;
 S IBCPOL=$$CHIP^IBCNSU(IBCDFND)
 Q:'IBCPOL
 Q:+IBCDFND'=+$G(^IBA(355.3,+IBCPOL,0))  ; patient ins. and policy must have same ins. company file.
 S DA=IBCDFN,DA(1)=DFN,DIE="^DPT("_DFN_",.312,"
 S DR="1.09////1;.18////"_IBCPOL
 D:IBUPDAT ^DIE K DA,DR,DIE,DIC W:'$D(ZTQUEUED) "+"
SET S ^TMP("IBCNS-ERR",$J,$P(^DPT(DFN,0),"^"),DFN,IBCDFN)=IBCPOL2_"^"_IBCPOL_"^"_NODE
 Q
 ;
REPORT ; -- Okay now tell us about the errors
 D NOW^%DTC S IBHDT=$$FMTE^XLFDT(%),IBPAG=0
 D HDR
 S NAME="",NODE="IBCNS-ERR"
 I '$D(^TMP(NODE,$J)) W !!,"No Errors Found!" Q
 F  S NAME=$O(^TMP(NODE,$J,NAME)) Q:NAME=""  D
 .S DFN=0 F  S DFN=$O(^TMP(NODE,$J,NAME,DFN)) Q:'DFN  D
 ..S IBCDFN=0 F  S IBCDFN=$O(^TMP(NODE,$J,NAME,DFN,IBCDFN)) Q:'IBCDFN  S IBDATA=^(IBCDFN) D ONE
 Q
 ;
ONE ; -- print one line
 D PID^VADPT
 W !,$E($P($G(^DPT(DFN,0)),"^"),1,16)_" ("_DFN_")"
 W ?25,VA("PID")
 S IBCDFND=$G(^DPT(DFN,.312,IBCDFN,0))
 W ?39,$E($P($G(^DIC(36,+IBCDFND,0)),"^"),1,25)
 S IBCPOLD=$G(^IBA(355.3,+IBDATA,0))
 I +IBCPOLD W ?68,$E($P(IBCPOLD,"^",4)_"("_$P($G(^DIC(36,+IBCPOLD,0)),"^"),1,33)_")"
 S IBCPOLD=$G(^IBA(355.3,$P(IBDATA,"^",2),0))
 I +IBCPOLD W ?105,$E($P(IBCPOLD,"^",4)_"("_$P($G(^DIC(36,+IBCPOLD,0)),"^"),1,20)_")"
 W ?127,$S($G(IBUPDAT):"YES",1:"NO")
 W !?5,"Error: ",$S($P(IBDATA,"^",3)="IBCNS-ERR1":"Policy is missing group Plan",$P(IBDATA,"^",3)="IBCNS-ERR3":"Dangling insurance node detected",1:"Group Plan is with different insurance company")
 Q
 ;
HDR ; -- Print header
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Patients with Incorrect Group Plans",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,"PATIENT",?25,"PATIENT ID",?39,"INSURANCE CO.",?68,"OLD PLAN",?105,"NEW PLAN",?127,"UPDATED"
 W !,$TR($J(" ",IOM)," ","-")
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 W !!,"....task stoped at user request" Q
 Q
