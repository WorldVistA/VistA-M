DG53P604 ;BAY/JAT - Patient File Updat; 6/7/04 7:13pm ; 8/7/04 7:51pm
 ;;5.3;Registration;**604**;Aug 13,1993
 ;
REPORT ;
 N X1,X2
 K ^XTMP("DG53P604",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P604",$J,0)=X_"^"_DT_"^Patient file iens w/decimals"
 I $$DEVICE() D ENTER
 Q
 ;
ENTER ;
 D READ
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
DEVICE() ;
 ;Description: allows the user to select a device.
 ;
 ;Output:
 ;  Function Value - Returns 0 if the user decides not to print or to
 ;       queue the report, 1 otherwise.
 ;
 N OK,IOP,POP,%ZIS
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 D:OK&$D(IO("Q"))
 .N ZTRTN,ZTDESC,ZTSKM,ZTREQ,ZTSTOP
 .S ZTRTN="ENTER^DG53P604",ZTDESC="Patient file iens w/decimals"
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
READ ;
 ;
 N DFN,COUNT,DGSSN,DGWHEN,DGDTCARE
 S (COUNT,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .; merged record
 .I $D(^DPT(DFN,-9)) Q
 .; in process of being merged
 .I $P($G(^DPT(DFN,0)),U)["MERGING INTO" Q
 .I DFN'["." Q
 .I $D(^DPT(DFN,0)) D
 ..S DGSSN=$P($G(^DPT(DFN,0)),U,9)
 ..S DGWHEN=$P($G(^DPT(DFN,0)),U,16)
 ..S DGDTCARE=$P($G(^DPT(DFN,1010.15)),U)
 ..S COUNT=COUNT+1
 ..S ^XTMP("DG53P604",$J,DFN)=DGSSN_"^"_DGWHEN_"^"_DGDTCARE
 ;
 D PRINT
 Q
 ;
PRINT ;
 U IO
 N DGDDT,DGQUIT,DGPG
 S DGDDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 S (DGQUIT,DGPG)=0
 D HEAD
 I '$G(COUNT) D  Q
 .W !!!,?20,"*** No records to report ***"
 W !!,"*** COUNT OF PATIENT RECORDS:",COUNT," ***",!!
 S DFN=0
 F  S DFN=$O(^XTMP("DG53P604",$J,DFN)) Q:'DFN  D  Q:DGQUIT
 .I $Y>(IOSL-4) D HEAD
 .S DGSSN=$P($G(^XTMP("DG53P604",$J,DFN)),U)
 .S DGWHEN=$P($G(^XTMP("DG53P604",$J,DFN)),U,2)
 .S DGWHEN=$$FMTE^XLFDT(DGWHEN,"D")
 .S DGDTCARE=$P($G(^XTMP("DG53P604",$J,DFN)),U,3)
 .S DGDTCARE=$$FMTE^XLFDT(DGDTCARE,"D")
 .W ?2,DFN,?20,DGSSN,?37,DGWHEN,?56,DGDTCARE,!
 ;
 I DGQUIT W:$D(ZTQUEUED) !!,"Report stopped at user's request" Q
 I $G(DGPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
HEAD ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQUIT)=1 Q
 I $G(DGPG)>0,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 Q:DGQUIT
 S DGPG=$G(DGPG)+1
 W @IOF,!,DGDDT,?15,"DG*5.3*604   Patient File iens w/decimals",?70,"Page:",$J(DGPG,5),! K X S $P(X,"-",81)="" W X,!
 W !
 W !,?2,"DFN",?23,"SSN",?37,"Date Record Created",?58,"Most Recent Care Date",!
 S $P(X,"-",81)="" W X,!
 Q
