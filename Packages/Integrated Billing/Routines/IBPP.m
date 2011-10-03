IBPP ;ALB/CPM - PURGE BILLING DATA ; 22-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;**48**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Tasked job inverts search template entries and deletes them from
 ; the source file.
 ;
 ;  Input:  IBD(file number) --  piece 1:  date through which to archive
 ;                      IBOP --  3 (Purge Billing Data)
 ;                       DUZ --  user ID; retained by Taskman
 ;
 ;  Called by QUE^IBP
 ;
 ;
 ; Purge entries for each selected file. 
 I '$O(^IBE(356.8,"B","OTHER",0)) S $P(IBD(IBF),"^",4)="Error: Reason Not Billable of OTHER undefined, no bills purged" G END
 I '$O(^IBE(356.8,"B","BILL PURGED",0)) S $P(IBD(IBF),"^",4)="Error: Reason Not Billable of BILL PURGED undefined, no bills purged" G END
 ;
 S IBSTAT=$$LOG^IBPU(IBF)
 I 'IBSTAT S $P(IBD(IBF),"^",4)="Invalid File to Purge" G END
 S IBLOG=$$LOGIEN^IBPU1(IBF),$P(IBD(IBF),"^",3)=IBLOG
 I 'IBLOG S $P(IBD(IBF),"^",4)="Unable to Retrieve Current Entry to Log File" G END
 S IBTMPL=$P($G(^IBE(350.6,IBLOG,0)),"^",2)
 I IBTMPL="" S $P(IBD(IBF),"^",4)="Log Entry has no Search Template" D UPD^IBPU1(IBLOG,.05,"/3") G END
 S IBTMDA=$O(^DIBT("B",IBTMPL,0))
 I 'IBTMDA S $P(IBD(IBF),"^",4)="Search Template Name is Invalid" D UPD^IBPU1(IBLOG,.05,"/3") G END
 I '$D(^DIBT(IBTMDA,1)) S $P(IBD(IBF),"^",4)="Search Template has no Entries to Archive" D UPD^IBPU1(IBLOG,.05,"/3") G END
 D UPD^IBPU1(IBLOG,3.01,"NOW") ; set start time of purge
 ; - "invert" search template entries
 S IBN=0 F  S IBN=$O(^DIBT(IBTMDA,1,IBN)) Q:'IBN  S ^TMP($J,"IBPP",-IBN)=""
 ; - purge the entries
 S DIK=^DIC(IBF,0,"GL"),IBCNT=0,IBRCNO="" F  S IBRCNO=$O(^TMP($J,"IBPP",IBRCNO)) Q:IBRCNO=""  S (DA,IBN)=-IBRCNO,IBCNT=IBCNT+1 D:IBF=399 NEWV D ^DIK
 ;
 D RNB K ^TMP($J,"IBPP"),^TMP($J,"IBPPTRN")
 ;
 I 'IBCNT S $P(IBD(IBF),"^",4)="No Entries Purged" D DEL^IBPU1(IBF),UPD^IBPU1(IBLOG,.05,"/3") G END
 D UPD^IBPU1(IBLOG,.04,IBCNT) ; update log entry with count
 D UPD^IBPU1(IBLOG,3.02,"NOW") ; set end time of purge in log
 D UPD^IBPU1(IBLOG,.05,"/2") ; close out log entry
 D DEL^IBPU1(IBF) ; delete search template
END Q
NEWV ;
 N DA,DIE,DIK
 D ^IBPU2
 Q
RNB ; adds RNB (356,.19) of OTHER to all CT records that were on an archived bill but do not yet have a RNB
 ; this covers visits where the bill was canceled or the visit was removed from a bill
 ; all CT records that were actually billed on an archived bill should already have a RNB of BILL PURGED
 N IBTRN,IBX,DIE,DA,DR,DIC,IBRNB S IBRNB=$O(^IBE(356.8,"B","OTHER",0)) Q:'IBRNB
 S IBTRN=0 F  S IBTRN=$O(^TMP($J,"IBPPTRN",IBTRN)) Q:'IBTRN  D
 . S IBX=$G(^IBT(356,+IBTRN,0)) I +IBX,'$P(IBX,U,19) S DIE="^IBT(356,",DA=IBTRN,DR=".19////"_IBRNB D ^DIE
 Q
