IVMUPUR ;ALB/CPM - PURGE IVM TRANSMISSION RECORDS ; 22-MAY-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Queue job to purge IVM Transmissions from file #301.6
 ;
 I $$NODUZ() G ENQ
 ;
 S IVMPYR=1699+$E(DT,1,3)
 ;
 W !!,"This option is used to purge data from the IVM TRANSMISSIONS (#301.6) file."
 W !,"Entries in this file will only be purged for corresponding case records"
 W !,"in the IVM PATIENT (#301.5) file which have been closed."
 ;
 W !!,"You will purge transmission records for an entire income year's worth of cases."
 W !,"However, you must select an income year prior to the year which corresponds"
 W !,"to the current year's Means Tests.  Since this year's Means Tests are based"
 W !,"on ",IVMPYR," income, you must select an income year prior to ",IVMPYR,".",!!
 ;
SEL ; - select an income year prior to that which current MT's are based
 S %DT("A")="Select the Income Year for which to purge transmissions: "
 S %DT(0)=2860000,%DT="AE" D ^%DT K %DT G:$D(DTOUT)!(Y<0) ENQ
 I $E(Y,1,3)+1700'<IVMPYR W !!,"Invalid year entered.  Enter a year prior to ",IVMPYR,".",! G SEL
 S IVMYR=$E(Y,1,3)_"0000"
 ;
 ; - okay to task off the job?
 I $$OKAY D TASK
 ;
ENQ K IVMPYR,IVMYR
 Q
 ;
 ;
NODUZ() ; Check for the existence of DUZ
 ;         Input:   NONE
 ;         Output:  0  --  has DUZ,  1  --  no DUZ
 N Y
 I '$G(DUZ) S Y=1 W !!,"Your DUZ code must be defined in order to use this option.",!
 Q +$G(Y)
 ;
OKAY() ; Okay to queue this job?
 ;         Input:   NONE
 ;         Output:  0  --  No, not okay,  1  --  Yes, okay to continue
 N DIR,DIRUT,DUOUT,DTOUT,Y
 S DIR(0)="Y",DIR("A")="Is it okay to queue this job"
 S DIR("?",1)="Enter:  'Y'  if you wish to task off this job, or"
 S DIR("?")="        'N' or '^'  to quit this option." W ! D ^DIR
 Q $S($D(DIRUT)!($D(DUOUT))!($D(DTOUT)):0,1:Y)
 ;
TASK ; Task off the job.
 S ZTRTN="DQ^IVMUPUR",ZTSAVE("IVMYR")="",ZTIO=""
 S ZTDESC="IVM - PURGE IVM TRANSMISSION RECORDS"
 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 K ZTSK
 Q
 ;
 ;
 ;
DQ ; Tasked entry point to purge transmission data.
 ;  Input:  IVMYR  --  Income year for which to purge data
 ;
 S (IVMCNTT,IVMCNTV,IVMCNTP)=0
 D NOW^%DTC S IVMSTART=%
 ;
 ; - do the purge and collect statistics
 S DFN="" F  S DFN=$O(^IVM(301.5,"AYR",IVMYR,DFN)) Q:'DFN  D
 .S IVMDA=0 F  S IVMDA=$O(^IVM(301.5,"AYR",IVMYR,DFN,IVMDA)) Q:'IVMDA  D
 ..S IVMCNTT=IVMCNTT+1
 ..Q:'$P($G(^IVM(301.5,IVMDA,0)),"^",4)  ; case is still active
 ..S IVMCNTV=IVMCNTV+1
 ..;
 ..; - delete all transmissions for the closed case
 ..S IVMTR=0 F  S IVMTR=$O(^IVM(301.6,"B",IVMDA,IVMTR)) Q:'IVMTR  D
 ...S IVMCNTP=IVMCNTP+1
 ...S DIK="^IVM(301.6,",DA=IVMTR D ^DIK
 ;
 D NOW^%DTC S IVMEND=%
 ;
 ; - send a mail message with the results
 S XMSUB="COMPLETED PURGE OF IVM TRANSMISSION RECORDS"
 S XMDUZ="INCOME VERIFICATION MATCH PACKAGE"
 S XMTEXT="IVMTXT("
 S XMY(DUZ)=""
 ;
 S IVMTXT(1)="The purge of data from the IVM TRANSMISSIONS (#301.6) file has completed."
 S IVMTXT(2)=" "
 S IVMTXT(3)="  Job Start Date/Time: "_$$DAT2^IVMUFNC4(IVMSTART)
 S IVMTXT(4)="    Job End Date/Time: "_$$DAT2^IVMUFNC4(IVMEND)
 S IVMTXT(5)=" "
 S IVMTXT(6)=" "
 S IVMTXT(7)="                                   Income Year: "_($E(IVMYR,1,3)+1700)
 S IVMTXT(8)=" "
 S IVMTXT(9)="     Total number of case file records checked: "_IVMCNTT
 S IVMTXT(10)="           Number of closed case records found: "_IVMCNTV
 S IVMTXT(11)="    Number of IVM TRANSMISSION records deleted: "_IVMCNTP
 ;
 ; - deliver and quit
 D ^XMD
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K DA,DFN,DIK,IVMSTART,IVMEND,IVMYR,IVMDA,IVMTR,IVMTXT,IVMCNTT,IVMCNTP,IVMCNTV
 K XMSUB,XMDUZ,XMY,XMTEXT
 Q
