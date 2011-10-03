DG53P600 ;BAY/JAT - Patient File Updat; 6/7/04 7:13pm ; 7/16/04 3:22pm
 ;;5.3;Registration;**600**;Aug 13,1993
 Q
 ;
CLEANUP ;This entry point will do the update.
 ;
 N DGENSKIP
 S DGENSKIP=0
 W !,"This is a one-time update of the Patient File."
 W !,"It will correct the TEST PATIENT INDICATOR flag."
 N X1,X2
 K ^XTMP("DG53P600",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P600",$J,0)=X_"^"_DT_"^Patient File update"
 I $$DEVICE() D ENTER
 Q
 ;
REPORT ;This entry point was provided for testing, so that before
 ;patient records are updated the site can have a list of
 ;the DFN's that would be affected.
 ; 
 ;Use this entry point to report on what the update would do.
 ;No changes will be made to the database.
 ;
 N DGENSKIP
 S DGENSKIP=1
 W !,"This is a preliminary report by DFN of the Patient file"
 W !,"records which would be affected by the update."
 N X1,X2
 K ^XTMP("DG53P600",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P600",$J,0)=X_"^"_DT_"^Patient File update"
 I $$DEVICE() D ENTER
 Q
 ;
ENTER ;
 ;
 D UPDATE(DGENSKIP)
 D:(DGENSKIP) ^%ZISC
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
 .S ZTRTN="ENTER^DG53P600",ZTDESC=$S(DGENSKIP:"Report",1:"Update")_" of Patient Records"
 .S ZTSAVE("DGENSKIP")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
UPDATE(DGENSKIP) ;
 ;This will update patient records --
 ;
 ;Input: If DGENSKIP=1, the records will not be updated,
 ;just reported.
 ;
 N DFN,COUNT,DGSSN,DGS,DGFLG,DGXREF,DGVAL,DGFDA,DGERR
 S (COUNT,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .; merged record
 .I $D(^DPT(DFN,-9)) Q
 .; in process of being merged
 .I $P($G(^DPT(DFN,0)),U)["MERGING INTO" Q
 .I $D(^DPT(DFN,0)) D
 ..S DGSSN=$P($G(^DPT(DFN,0)),U,9)
 ..Q:'DGSSN
 ..S DGS=$E(DGSSN,1,5)
 ..S DGS=$S(DGS="00000":0,1:1)
 ..S DGFLG=+$P($G(^DPT(DFN,0)),U,21)
 ..S DGXREF=$S('$D(^DPT("ATEST",DFN)):0,1:1)
 ..;quit if usual non-test patient
 ..I DGS,'DGFLG,'DGXREF Q
 ..;update 
 ..I DGS,DGFLG S DGVAL=0 D UPDR Q
 ..I DGS,DGXREF S DGVAL=0 D UPDR Q
 ..I 'DGS,'DGFLG S DGVAL=1 D UPDR Q
 ..I 'DGS,'DGXREF S DGVAL=1 D UPDR Q
 ;
 D PRINT
 Q
 ;
UPDR ;
 S COUNT=COUNT+1
 S DGFLG=$S(DGFLG:"YES",1:"NO")
 S DGXREF=$S(DGXREF:"YES",1:"NO")
 S ^XTMP("DG53P600",$J,DFN)=DGSSN_"^"_DGFLG_"^"_DGXREF
 I 'DGENSKIP D
 .S DGFDA(2,DFN_",",.6)=DGVAL
 .D FILE^DIE("S","DGFDA","DGERR")
 .I DGVAL=0 K ^DPT("ATEST",DFN)
 Q
PRINT ;
 U IO
 N DGDDT,DGQUIT,DGPG
 S DGDDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 S (DGQUIT,DGPG)=0
 D HEAD
 I '$G(COUNT) D  Q
 .W !!!,?20,"*** No records to report ***"
 W !!,"*** COUNT OF BAD PATIENT RECORDS"_$S(DGENSKIP:"",1:" UPDATED")_": ",COUNT," ***",!!
 S DFN=0
 F  S DFN=$O(^XTMP("DG53P600",$J,DFN)) Q:'DFN  D  Q:DGQUIT
 .I $Y>(IOSL-4) D HEAD
 .S DGSSN=$P($G(^XTMP("DG53P600",$J,DFN)),U)
 .S DGFLG=$P($G(^XTMP("DG53P600",$J,DFN)),U,2)
 .S DGXREF=$P($G(^XTMP("DG53P600",$J,DFN)),U,3)
 .W ?2,DFN,?15,DGSSN,?37,DGFLG,?56,DGXREF,!
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
 W @IOF,!,DGDDT,?15,"DG*5.3*600 Patient File Update Utility",?70,"Page:",$J(DGPG,5),! K X S $P(X,"-",81)="" W X,!
 W !
 W !,?2,"DFN",?15,"SSN",?26,"Test Patient Indicator",?50,"'ATEST' crossref",!
 S $P(X,"-",81)="" W X,!
 Q
