IBPF ;ALB/CPM - FIND BILLING DATA TO ARCHIVE ; 20-APR-92
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Tasked job which builds search template for each selected Billing
 ; data file and populates with eligible records to archive.
 ;
 ;  Input:  IBD(file number) --  piece 1:  date through which to archive
 ;                               piece 2:  log entry if restarting
 ;                      IBOP --  1 (Find Billing Data to Archive)
 ;                       DUZ --  user ID; retained by Taskman
 ;
 ;  Called by QUE^IBP
 ;
 ;
 ; Perform search of all entries to be archived for each file.
 S IBSTAT=$$LOG^IBPU(IBF)
 I 'IBSTAT S $P(IBD(IBF),"^",4)="Invalid File to Archive" G END
 I $P(IBD(IBF),"^",2) D DEL^IBPU1(IBF),UPD^IBPU1($P(IBD(IBF),"^",2),.05,"/3")
 S IBLOG=$$LOGADD^IBPFU(IBF),$P(IBD(IBF),"^",3)=IBLOG
 I 'IBLOG S $P(IBD(IBF),"^",4)="Unable to Add Entry to Log File" G END
 S IBTMPL=$$TEMPL^IBPFU(IBF,IBLOG)
 I 'IBTMPL S $P(IBD(IBF),"^",4)="Unable to Create New Search Template" G END
 D UPD^IBPU1(IBLOG,1.01,"NOW") ; set start time of search
 S IBEDT=+IBD(IBF) ; set last valid date to select entry
 D @$S(IBF=350:"IB^IBPF1",IBF=351:"CLOCK",1:"BILL^IBPF1")
 I 'IBCNT S $P(IBD(IBF),"^",4)="No Entries Found to Archive" D DEL^IBPU1(IBF),UPD^IBPU1(IBLOG,.05,"/3") G END
 D UPD^IBPU1(IBLOG,.04,IBCNT) ; update log entry with count
 D UPD^IBPU1(IBLOG,1.02,"NOW") ; set end time of search in log
END Q
 ;
 ;
CLOCK ; Find Means Test billing clocks which may be purged.
 ;  Input:     IBTMPL  --  Search template to store entries
 ;              IBEDT  --  Last date for which a clock may be purged
 ;  Output:     IBCNT  --  number of records stored
 S X1=IBEDT,X2=-364 D C^%DTC S IBBDT=X
 ;
 ; - cancelled and closed clocks which 'end' on or before the
 ; - 'Purge End Date,' or 'start' on or before the 'Purge Start
 ; - Date' are eligible for archiving/purging.
 ;
 S (DFN,IBCLDA)=0,IBCNT=0
 F  S DFN=$O(^IBE(351,"AIVDT",DFN)) Q:'DFN  S IBDATE=-(IBEDT+.1) D
 . F  S IBDATE=$O(^IBE(351,"AIVDT",DFN,IBDATE)) Q:'IBDATE  D
 ..  F  S IBCLDA=$O(^IBE(351,"AIVDT",DFN,IBDATE,IBCLDA)) Q:'IBCLDA  D
 ...   S IBCLND=$G(^IBE(351,+IBCLDA,0)) I IBCLND="" D KILL Q
 ...   Q:$P(IBCLND,"^",4)=1  ; Clock is still active
 ...   I '$P(IBCLND,"^",10) Q:$P(IBCLND,"^",3)>IBBDT
 ...   E  Q:$P(IBCLND,"^",10)>IBEDT
 ...   S IBCNT=IBCNT+1,^DIBT(IBTMPL,1,IBCLDA)="" ; store in template
 ;
 ; - kill variables and quit.
 K IBDATE,DFN,IBCLDA,IBCLND,IBBDT,X,X1,X2
 Q
 ;
KILL ; Kill leftover cross-references for a missing entry.
 K ^IBE(351,IBCLDA,0),^(1)
 K ^IBE(351,"ACT",DFN,IBCLDA)
 K ^IBE(351,"AIVDT",DFN,DATE,IBCLDA)
 K ^IBE(351,"B",IBSITE_IBCLDA,IBCLDA)
 K ^IBE(351,"C",DFN,IBCLDA)
 Q
