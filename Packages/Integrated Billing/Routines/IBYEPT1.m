IBYEPT1 ;ALB/CPM - PATCH IB*2*40 POST INIT (CON'T) ; 22-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**40**; 21-MAR-94
 ;
EN ; Entry point to queue 'Name of Insured' clean up job.
 ;
 W !!,">>> I need to queue a job to clean up the 'Name of Insured' fields in"
 W !,"    the PATIENT (#2) and BILL/CLAIMS (#399) files...",!
 ;
 ; - queue the job
 S ZTRTN="DQ^IBYEPT1",ZTIO="",ZTDESC="IB - CORRECT 'NAME OF INSURED' VALUES"
 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"")
 W:$D(ZTSK) !,"Please note that you will receive a mail message when this job has completed."
 K X,Y,DIRUT,DUOUT,DTOUR,DIROUT,ZTSK
 Q
 ;
 ;
 ;
DQ ; Queued entry point to start the job.
 ;
 D NOW^%DTC S IBBDT=%
 ;
 S (IBCPOL,IBCBILL)=0
 ;
 ; - fix policies in file #2
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S IBCDFN=0 F  S IBCDFN=$O(^DPT(DFN,.312,IBCDFN)) Q:'IBCDFN  S IBNI=$P($G(^(IBCDFN,0)),"^",17) I IBNI?1"`"1.N D
 .S IBNAM=$$NAME(IBNI,DFN) Q:IBNAM<0
 .S $P(^DPT(DFN,.312,IBCDFN,0),"^",17)=IBNAM,IBCPOL=IBCPOL+1
 ;
 ; - fix patient's bills in file #399
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,IBIFN)) Q:'IBIFN  D
 .F IBNOD="I1","I2","I3" S IBNI=$P($G(^DGCR(399,IBIFN,IBNOD)),"^",17) I IBNI?1"`"1.N D
 ..S IBNAM=$$NAME(IBNI,+$P($G(^DGCR(399,IBIFN,0)),"^",2)) Q:IBNAM<0
 ..S $P(^DGCR(399,IBIFN,IBNOD),"^",17)=IBNAM,IBCBILL=IBCBILL+1
 ;
 D NOW^%DTC S IBEDT=%
 ;
 D MAIL
 ;
 K IBBDT,IBEDT,DFN,IBCDFN,IBNI,IBNAM,IBCPOL,IBCBILL,IBIFN,IBNOD
 Q
 ;
 ;
NAME(IBNI,DFN) ; Find the name associated with the ien for Name of Insured.
 ;  Input:  IBNI  --  Value of the Name of Insured stored in the policy
 ;           DFN  --  Pointer to the patient in file #2
 ;
 N NAME
 I $E(IBNI,2,99)=DFN S NAME=$P($G(^DPT(DFN,0)),"^") G NAMEQ
 N DIC,DFN,DGSENFLG,X S DGSENFLG=1
 S X=IBNI,DIC="^DPT(",DIC(0)="Z" D ^DIC S NAME=$S(Y<0:-1,1:$P($G(^DPT(+Y,0)),"^"))
NAMEQ Q NAME
 ;
 ;
MAIL ; Send the bulletin
 S XMSUB="Job Completion - Correct 'Name of Insured' Fields"
 S XMDUZ="INTEGRATED BILLING",XMTEXT="IBT(",XMY(DUZ)=""
 ;
 K IBT
 S IBT(1)="The job to correct the 'Name of Insured' fields in files #2 and #399"
 S IBT(2)="has completed."
 S IBT(3)=" "
 S Y=IBBDT D D^DIQ S IBT(4)="Job Start Time: "_Y
 S Y=IBEDT D D^DIQ S IBT(5)="  Job End Time: "_Y
 S IBT(6)=" "
 S IBT(7)="Number of policies corrected in file #2: "_IBCPOL
 S IBT(8)=" Number of bills corrected in file #399: "_IBCBILL
 ;
 D ^XMD
 K IBT,XMSUB,XMTEXT,XMDUZ,XMY,Y
 Q
