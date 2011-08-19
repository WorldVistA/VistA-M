DG53P629 ;BAY/JAT - Patient File reporting; 6/7/04 7:13pm ; 12/11/04 10:37pm
 ;;5.3;Registration;**629**;Aug 13,1993
 ;
REPORT ;
 N X1,X2
 K ^XTMP("DG53P629",$J)
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53P629",$J,0)=X_"^"_DT_"^Possible missing patients"
 I $$DEVICE() D ENTER
 Q
 ;
ENTER ;
 ;
 D READFILE
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
 .S ZTRTN="ENTER^DG53P629",ZTDESC="Report of possible missing patients"
 .D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS
 .S OK=0
 Q OK
 ;
READFILE ;
 N DFN,COUNT,DGDATE,DGSRCE,DGCITY,DGSTAT
 S (DFN,COUNT)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .; merged record
 .I $D(^DPT(DFN,-9)) Q
 .; in process of being merged
 .I $P($G(^DPT(DFN,0)),U)["MERGING INTO" Q
 .I $P($G(^DPT(DFN,.15)),U,3)!($P($G(^DPT(DFN,"INE")),U,7))!($P($G(^DPT(DFN,"INE")),U,8))!($P($G(^DPT(DFN,"INE")),U,7)) D
 ..S DGDATE=$P($G(^DPT(DFN,.15)),U,3)
 ..S DGSRCE=$P($G(^DPT(DFN,"INE")),U,7)
 ..S DGCITY=$P($G(^DPT(DFN,"INE")),U,8)
 ..S DGSTAT=$P($G(^DPT(DFN,"INE")),U,9)
 ..D STORE
 ;
 W !,"Nbr possible missing patients: "_COUNT
 D PRINT
 Q
 ;
STORE ;
 S COUNT=COUNT+1
 S ^XTMP("DG53P629",$J,DFN)=DGDATE_U_DGSRCE_U_DGCITY_U_DGSTAT
 Q
PRINT ;
 U IO
 N DGDDT,DGQUIT,DGPG,DGDATA,DGTEXT
 S DGDDT=$$FMTE^XLFDT($$NOW^XLFDT,"D")
 S (DGQUIT,DGPG)=0
 D HEAD
 I '$G(COUNT) D  Q
 .W !!!,?20,"*** No records to report ***"
 W !!,"*** COUNT OF POSSIBLE MISSING PATIENTS: ",COUNT," ***",!!
 S DFN=0
 F  S DFN=$O(^XTMP("DG53P629",$J,DFN)) Q:'DFN  D  Q:DGQUIT
 .I $Y>(IOSL-4) D HEAD
 .S DGDATA=$G(^XTMP("DG53P629",$J,DFN))
 .S DGDATE=$P(DGDATA,U),DGSRCE=$P(DGDATA,U,2),DGCITY=$P(DGDATA,U,3),DGSTAT=$P(DGDATA,U,4)
 .S Y=$P(DGDATE,".") D DD^%DT S DGDATE=Y
 .S DGSRCE=$S(DGSRCE=1:"VAMC",DGSRCE=2:"RO",DGSRCE=3:"RPC",1:"")
 .I DGSTAT>0 S DGSTAT=$P($G(^DIC(5,DGSTAT,0)),U)
 .W ?2,DFN,?13,DGDATE,?27,DGSRCE,?34,DGCITY,?53,DGSTAT,!
 .I '$D(^DPT(DFN,.16)) W ! Q
 .S DGTEXT=0
 .F  S DGTEXT=$O(^DPT(DFN,.16,DGTEXT)) Q:'DGTEXT  D
 ..W ?13,$G(^DPT(DFN,.16,DGTEXT,0)),!
 .W !
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
 W @IOF,!,DGDDT,?15,"DG*5.3*629 List of possible missing patients",?70,"Page:",$J(DGPG,5),! K X S $P(X,"-",81)="" W X,!
 W !
 W !,?2,"DFN",?13,"DATE",?26,"SOURCE",?34,"CITY",?53,"STATE",!!
 S $P(X,"-",81)="" W X,!
 Q
