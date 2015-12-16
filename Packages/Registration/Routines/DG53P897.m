DG53P897 ;BAY/JAT - Patient File Updat; 6/7/04 7:13pm ; 9/9/14 8:15am
 ;;5.3;Registration;**897**;Aug 13,1993;Build 10
 Q
 ;
CLEANUP ;This entry point will do the update.
 ;
 N DGENSKIP
 S DGENSKIP=0
 W !,"This is a one-time update of the Patient File."
 W !,"It will correct Race & Ethnicity records."
 N X1,X2
 K ^XTMP("DG53P897",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P897",$J,0)=X_"^"_DT_"^Patient File update"
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
 K ^XTMP("DG53P897",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P897",$J,0)=X_"^"_DT_"^Patient File update"
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
 .S ZTRTN="ENTER^DG53P897",ZTDESC=$S(DGENSKIP:"Report",1:"Update")_" of Patient Records"
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
 N DFN,COUNT,DGMULT,DGSAVE,DGDUPE,DGETHN,DGDATA,DGRACE,DGETHNIC,DGFDA,X,DINUM,DIC,DA,DGTEST
 S (COUNT,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .; merged record
 .I $D(^DPT(DFN,-9)) Q
 .; in process of being merged
 .I $P($G(^DPT(DFN,0)),U)["MERGING INTO" Q
 .I '$D(^DPT(DFN,0)) Q
 .I $P(^DPT(DFN,0),U)="" Q
 .; look for duplicates
 .S (DGMULT,DGSAVE,DGDUPE)=0
 .F  S DGMULT=$O(^DPT(DFN,.02,DGMULT)) Q:'DGMULT  D
 ..I DGSAVE=0 S DGSAVE=$P($G(^DPT(DFN,.02,DGMULT,0)),U) Q
 ..I DGSAVE=$P($G(^DPT(DFN,.02,DGMULT,0)),U) S DGDUPE=1 D UPDR S DGDUPE=0
 .S (DGMULT,DGSAVE,DGETHN)=0
 .F  S DGMULT=$O(^DPT(DFN,.06,DGMULT)) Q:'DGMULT  D
 ..I DGSAVE=0 S DGSAVE=$P($G(^DPT(DFN,.06,DGMULT,0)),U) Q
 ..I DGSAVE=$P($G(^DPT(DFN,.06,DGMULT,0)),U) S DGETHN=1 D UPDR S DGETHN=0
 .;look for no dinums
 .S (DGMULT,DGRACE,DGETHNIC)=0
 .F  S DGMULT=$O(^DPT(DFN,.02,DGMULT)) Q:'DGMULT  D
 ..S DGDATA=$G(^DPT(DFN,.02,DGMULT,0))
 ..S DGRACE=$P(DGDATA,U)
 ..I DGMULT'=DGRACE D UPDR
 .S (DGMULT,DGRACE,DGETHNIC)=0
 .F  S DGMULT=$O(^DPT(DFN,.06,DGMULT)) Q:'DGMULT  D
 ..S DGDATA=$G(^DPT(DFN,.06,DGMULT,0))
 ..S DGETHNIC=$P(DGDATA,U)
 ..I DGMULT'=DGETHNIC D UPDR
 ;
 D PRINT
 Q
 ;
UPDR ;
 I '$D(^XTMP("DG53P897",$J,DFN)) S COUNT=COUNT+1
 S DGTEXT=""
 I $D(^XTMP("DG53P897",$J,DFN)) S DGTEXT=$G(^XTMP("DG53P897",$J,DFN))
 S ^XTMP("DG53P897",$J,DFN)=$S(DGDUPE:"dupe race",DGETHN:"dupe ethnic",DGRACE:"race entry not dinumed",DGETHNIC:"ethnicity entry not dinumed",1:"unknown")_"^"_DGTEXT
 I 'DGENSKIP D
 .I DGDUPE D
 ..S DGFDA(2.02,DGMULT_","_DFN_",",.01)="@"
 ..D FILE^DIE(,"DGFDA",)
 .I DGETHN D
 ..S DGFDA(2.06,DGMULT_","_DFN_",",.01)="@"
 ..D FILE^DIE(,"DGFDA",)
 .I DGRACE D
 ..S DGFDA(2.02,DGMULT_","_DFN_",",.01)="@"
 ..D FILE^DIE(,"DGFDA",)
 ..S (X,DINUM)=DGRACE,DIC="^DPT(DFN,.02,",DA(1)=DFN,DIC(0)="L"
 ..K DO D FILE^DICN
 .I DGETHNIC D
 ..S DGFDA(2.06,DGMULT_","_DFN_",",.01)="@"
 ..D FILE^DIE(,"DGFDA",)
 ..S (X,DINUM)=DGETHNIC,DIC="^DPT(DFN,.06,",DA(1)=DFN,DIC(0)="L"
 ..K DO D FILE^DICN
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
 F  S DFN=$O(^XTMP("DG53P897",$J,DFN)) Q:'DFN  D  Q:DGQUIT
 .I $Y>(IOSL-4) D HEAD
 .W ?2,DFN,?15,$G(^XTMP("DG53P897",$J,DFN)),!
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
 W @IOF,!,DGDDT,?15,"DG*5.3*897 Patient File Update Utility",?70,"Page:",$J(DGPG,5),! K X S $P(X,"-",81)="" W X,!
 W !
 W !,?2,"DFN",?15,"Action to be taken",!
 S $P(X,"-",81)="" W X,!
 Q
