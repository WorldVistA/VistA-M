IBPA ;ALB/CPM - ARCHIVE BILLING DATA ; 22-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Tasked job sorts search template entries by patient and date
 ; and writes each entry to the archive device.
 ;
 ;  Input:  IBD(file number) --  piece 1:  date through which to archive
 ;                               piece 2:  log entry if restarting
 ;                      IBOP --  2 (Archive Billing Data)
 ;                       DUZ --  user ID; retained by Taskman
 ;
 ;  Called by QUE^IBP
 ;
 ;
 ; Archive entries for each selected file. 
 S IBSTAT=$$LOG^IBPU(IBF)
 I 'IBSTAT S $P(IBD(IBF),"^",4)="Invalid File to Archive" G END
 I $P(IBD(IBF),"^",2) D DEL^IBPU1(IBF) F I=2.01,2.02,2.03 D UPD^IBPU1($P(IBD(IBF),"^",2),I,"/@")
 S IBLOG=$$LOGIEN^IBPU1(IBF),$P(IBD(IBF),"^",3)=IBLOG
 I 'IBLOG S $P(IBD(IBF),"^",4)="Unable to Retrieve Current Entry to Log File" G END
 S IBTMPL=$P($G(^IBE(350.6,IBLOG,0)),"^",2)
 I IBTMPL="" S $P(IBD(IBF),"^",4)="Log Entry has no Search Template" D UPD^IBPU1(IBLOG,.05,"/3") G END
 S IBTMDA=$O(^DIBT("B",IBTMPL,0))
 I 'IBTMDA S $P(IBD(IBF),"^",4)="Search Template Name is Invalid" D UPD^IBPU1(IBLOG,.05,"/3") G END
 I '$D(^DIBT(IBTMDA,1)) S $P(IBD(IBF),"^",4)="Search Template has no Entries to Archive" D UPD^IBPU1(IBLOG,.05,"/3") G END
 D UPD^IBPU1(IBLOG,2.01,"NOW") ; set start time of archive
 ; - sort all entries by patient and date
 S IBROOT=^DIC(IBF,0,"GL"),IBN=0
 F  S IBN=$O(^DIBT(IBTMDA,1,IBN)) Q:'IBN  S DFN=$P($G(@(IBROOT_IBN_",0)")),"^",2),DATE=$S(IBF=350:$P($G(@(IBROOT_IBN_",1)")),"^",2),1:$P($G(@(IBROOT_IBN_",0)")),"^",3)),^TMP($J,"IBPA",+DFN,+DATE,IBN)=""
 ; - write out the entries
 D WRITE K ^TMP($J,"IBPA")
 I 'IBCNT S $P(IBD(IBF),"^",4)="No Entries Archived" D DEL^IBPU1(IBF),UPD^IBPU1(IBLOG,.05,"/3") G END
 D UPD^IBPU1(IBLOG,.04,IBCNT) ; update log entry with count
 D UPD^IBPU1(IBLOG,2.02,"NOW") ; set end time of archive in log
END Q
 ;
 ;
WRITE ; Write out each entry.
 S (DFN,DATE,IBCNT,IBN,IBPAGE)=0,DIC=IBROOT,IBFNAME=$P($G(^DIC(IBF,0)),"^")
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL(%)
 S IBLINE="",$P(IBLINE,"-",IOM)="" D:IBF'=399 HDR
 F  S DFN=$O(^TMP($J,"IBPA",DFN)) Q:'DFN  F  S DATE=$O(^TMP($J,"IBPA",DFN,DATE)) Q:'DATE  F  S IBN=$O(^TMP($J,"IBPA",DFN,DATE,IBN)) Q:'IBN  D
 . I IBF=399 D HDR
 . I IBF'=399 S IBOFF=$S(IBF=350:9,1:11) D:$Y>(IOSL-IBOFF) HDR
 . S DA=IBN,IBCNT=IBCNT+1 D EN^DIQ
 Q
 ;
HDR ; Print a short header at the top of each page.
 S IBPAGE=IBPAGE+1
 W @IOF,"Archived "_IBFNAME,?(IOM-42),IBHDT,?(IOM-11),"Page: ",IBPAGE,!,IBLINE,!
 Q
