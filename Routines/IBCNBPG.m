IBCNBPG ;ALB/ARH-Ins Buffer: Option Purge stub entries ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PURGE ;
 N X,Y,DIR,DIRUT,DUOUT,IBX,IBDBDT
 ;
 W @IOF,!!,?29,"INSURANCE BUFFER PURGE",!
 W !!,?3,"This option will purge Buffer file records Processed before a given date."
 W !!,?3,"When a Buffer record is Processed a stub entry remains in the Buffer file"
 W !,?3,"for tracking and reporting purposes.  This option deletes all stub entries"
 W !,?3,"of Buffer records processed at least a year ago.  Once a record is purged,"
 W !,?3,"it can not be retrieved and will no longer be included in Buffer reports."
 W !,?3,"To maintain a record of the Buffer activity, consider printing the Buffer"
 W !,?3,"reports for the date range you are going to be purging.",!!
 ;
DATE ;
 S IBX=$$FMADD^XLFDT(DT,-365)
 S DIR("?",1)="All Buffer records that were Processed before the selected date will be deleted."
 S DIR("?",2)="A minimum of 1 year of Buffer records is maintained on line, therefore"
 S DIR("?",3)="the latest selectable date is 1 year ago.",DIR("?",4)=" "
 S DIR("?")="Enter a date on or before "_$$FMTE^XLFDT(IBX)_" or '^' to exit."
 S DIR("A")="Purge Buffer Records Processed Before",DIR("B")=$$FMTE^XLFDT(IBX)
 S DIR(0)="DO^:"_IBX_":EX" D ^DIR K DIR S IBDBDT=+Y I Y'?7N!(Y>IBX)!($D(DIRUT)) Q
 ;
 W !!
OK ;
 S DIR("?",1)="All Buffer records that were Processed before the selected date will be deleted.",DIR("?",2)=" "
 S DIR("?")="Enter Yes to continue the Purge.  Enter No to stop the process before deleting any Buffer records."
 S DIR("A")="Ok to Purge Buffer records Processed before "_$$FMTE^XLFDT(IBDBDT)
 S DIR(0)="YO" D ^DIR I Y'=1 Q
 ;
 ;
QUEUE ;
 S ZTDESC="Purge Insurance Buffer",ZTRTN="DELETE^IBCNBPG",ZTSAVE("IBDBDT")="",ZTIO="",ZTDTH=DT_".20" D ^%ZTLOAD
 I $D(ZTSK) W !!,"Purge of Insurance Buffer queued for this evening at 8:00pm."
 ;
 Q
 ;
DELETE ; delete all processed buffer entries older than a specified date, date must be 1 year or more ago
 ; QUEUED portion of PURGE OPTION
 N IBEDT,IBBUFDA,IBB0,IBSTAT,IBPDT,DA,DIK,X,Y
 ;
 I $G(IBDBDT)'?7N!($G(IBDBDT)'<$$FMADD^XLFDT(DT,-364)) Q
 ;
 S IBEDT=0 F  S IBEDT=$O(^IBA(355.33,"B",IBEDT)) Q:'IBEDT!(IBEDT>IBDBDT)  D
 . S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"B",IBEDT,IBBUFDA)) Q:'IBBUFDA  D
 .. S IBB0=^IBA(355.33,IBBUFDA,0)
 .. S IBSTAT=$P(IBB0,U,4) I IBSTAT'="A",IBSTAT'="R" Q
 .. S IBPDT=$P(IBB0,U,5) I IBPDT'<IBDBDT Q
 .. ;
 .. S DA=IBBUFDA,DIK="^IBA(355.33," D ^DIK K DIK,DA
 ;
 Q
