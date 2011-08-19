DG53P593 ;BAY/JAT - Patient File Cleanup; 2/22/1999 ; 6/24/04 3:43pm
 ;;5.3;Registration;**593**;Aug 13,1993
 Q
 ;
CLEANUP ;This entry point will do the cleanup.
 ;
 N DGENSKIP
 S DGENSKIP=0
 W !,"This is a one-time cleanup of the Patient File."
 W !,"Certain records which were created in error will be deleted."
 N X1,X2
 K ^XTMP("DG53P593",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P593",$J,0)=X_"^"_DT_"^Patient File cleanup"
 I $$DEVICE() D ENTER
 Q
 ;
REPORT ;This entry point was provided for testing, so that before
 ;patient records are deleted the site can have a list of
 ;the DFN's that would be deleted.
 ; 
 ;Use this entry point to report on what the cleanup would do.
 ;No changes will be made to the database.
 ;
 N DGENSKIP
 S DGENSKIP=1
 W !,"This is a preliminary report by DFN of the Patient file"
 W !,"records which would be deleted by the cleanup."
 N X1,X2
 K ^XTMP("DG53P593",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P593",$J,0)=X_"^"_DT_"^Patient File cleanup"
 I $$DEVICE() D ENTER
 Q
 ;
ENTER ;
 ;
 D DELETE(DGENSKIP)
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
 .S ZTRTN="ENTER^DG53P593",ZTDESC=$S(DGENSKIP:"Report",1:"Cleanup")_" of Incomplete Patient Records"
 .S ZTSAVE("DGENSKIP")=""
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
DELETE(DGENSKIP) ;
 ;This will delete bogus patient records --
 ;
 ;Input: If DGENSKIP=1, the records will not be deleted, 
 ;just reported.
 ;
 N DFN,SUB,GOOD,COUNT,DGNAME,DGDEL,DGSORT,DGVAL,DGFDA,DGERR
 S (COUNT,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .; merged record
 .I $D(^DPT(DFN,-9)) Q
 .; in process of being merged
 .I $P($G(^DPT(DFN,0)),U)["MERGING INTO" Q
 .; usual good patient record
 .I $D(^DPT(DFN,0)) S DGNAME=$P($G(^DPT(DFN,0)),U) I DGNAME'="",$D(^DPT("B",DGNAME,DFN)) Q
 .; evaluate if record related to DG*5.3*578 
 .D EVAL578
 .; evaluate if record related to DG*5.3*222
 .S GOOD=0
 .S SUB=""
 .F  S SUB=$O(^DPT(DFN,SUB)) Q:SUB=""  D
 ..I (SUB'=.3),(SUB'=.38),(SUB'=.52) S GOOD=1 Q
 .I 'GOOD D DIKDEL Q
 .I DGDEL D DIKDEL
 ;
 D PRINT
 Q
 ;
EVAL578 ;
 S DGDEL=0
 N DGCNT,DGNODE,DGSSN,DGNEWIEN,DGMPI
 I '$D(^DPT(DFN,0)) Q
 S DGNODE=""
 S DGCNT=0
 F  S DGNODE=$O(^DPT(DFN,DGNODE)) Q:DGNODE=""  S DGCNT=DGCNT+1
 ; there must be minimal data, so skip if too many nodes
 Q:DGCNT>7
 I DGNAME="" S DGDEL=DGDEL+1
 I DGNAME'="",'$D(^DPT("B",DGNAME,DFN)) S DGDEL=DGDEL+1
 S DGSSN=$P($G(^DPT(DFN,0)),U,9)
 I DGSSN="" S DGDEL=DGDEL+1
 I DGSSN'="",'$D(^DPT("SSN",DGSSN,DFN)) S DGDEL=DGDEL+1 D
 .S DGNEWIEN=0
 .F  S DGNEWIEN=$O(^DPT("SSN",DGSSN,DGNEWIEN)) Q:'DGNEWIEN  I DGNEWIEN S DGDEL=DGDEL+1
 S DGMPI=$E($P($G(^DPT(DFN,"MPI")),U),1,3)
 I DGMPI="" S DGDEL=DGDEL+1
 ; checking if only local ICN
 I DGMPI=+$$SITE^VASITE() S DGDEL=DGDEL+1
 I DGDEL>1 Q
 S DGDEL=0
 Q
 ;
DIKDEL ;
 S COUNT=COUNT+1
 S DGSORT=$S('GOOD:2,1:1)
 S ^XTMP("DG53P593",$J,DGSORT,DFN)=$S(DGSORT=1:"Related to DG*5.3*578",1:"Related to DG*5.3*222")
 I 'DGENSKIP D
 .D DELEXE
 .I '$D(^DPT(DFN,0)) D  Q
 ..S DA=DFN,DIK="^DPT(" D ^DIK K DA,DIK
 .I $P($G(^DPT(DFN,0)),U)="" K ^DPT(DFN) Q
 .S DGVAL="@"
 .S DGFDA(2,DFN_",",.01)=DGVAL
 .D FILE^DIE("","DGFDA","DGERR")
 Q
 ;
DELEXE ; Delete exceptions on file for patient record being removed.
 S EXCT=""
 F  S EXCT=$O(^RGHL7(991.1,"ADFN",EXCT)) Q:EXCT=""  D
 . I $D(^RGHL7(991.1,"ADFN",EXCT,DFN)) D
 .. S IEN=0
 .. F  S IEN=$O(^RGHL7(991.1,"ADFN",EXCT,DFN,IEN)) Q:'IEN  D
 ... S IEN2=0
 ... F  S IEN2=$O(^RGHL7(991.1,"ADFN",EXCT,DFN,IEN,IEN2)) Q:'IEN2  D
  .... S NUM="" S NUM=$P(^RGHL7(991.1,IEN,1,0),"^",4)
  .... I NUM=1 D
  ..... L +^RGHL7(991.1,IEN):10
  ..... S DIK="^RGHL7(991.1,",DA=IEN
  ..... D ^DIK K DIK,DA
  ..... L -^RGHL7(991.1,IEN)
  .... E  I NUM>1 D DELE
 K EXCT,IEN,IEN2,NUM
 Q
DELE ; delete exception
 L +^RGHL7(991.1,IEN):10
 S DA(1)=IEN,DA=IEN2
 S DIK="^RGHL7(991.1,"_DA(1)_",1,"
 D ^DIK K DIK,DA
 L -^RGHL7(991.1,IEN)
 Q
PRINT ;
 U IO
 N DGDDT,DGQUIT,DGPG
 S DGDDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 S (DGQUIT,DGPG)=0
 D HEAD
 I '$G(COUNT) D  Q
 .W !!!,?20,"*** No records to report ***"
 W !!,"*** COUNT OF BAD PATIENT RECORDS"_$S(DGENSKIP:"",1:" DELETED")_": ",COUNT," ***",!!
 S DGSORT=0
 F  S DGSORT=$O(^XTMP("DG53P593",$J,DGSORT)) Q:'DGSORT  D  Q:DGQUIT
 .S DFN=0
 .F  S DFN=$O(^XTMP("DG53P593",$J,DGSORT,DFN)) Q:'DFN  D  Q:DGQUIT
 ..I $Y>(IOSL-4) D HEAD
 ..W ?2,DFN,?15,$G(^XTMP("DG53P593",$J,DGSORT,DFN)),!
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
 W @IOF,!,DGDDT,?15,"DG*5.3*593 Patient File Cleanup Utility",?70,"Page:",$J(DGPG,5),! K X S $P(X,"-",81)="" W X,!
 W !,?2,"DFN",?15,"Reason for Deletion",!
 S $P(X,"-",81)="" W X,!
 Q
