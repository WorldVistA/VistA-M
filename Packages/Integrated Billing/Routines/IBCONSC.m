IBCONSC ;ALB/MJB,SGD,AAS,RLW - NSC W/INSURANCE OUTPUT  ;06 JUN 88 13:51
 ;;2.0;INTEGRATED BILLING;**66,120**; 21-MAR-94
 ;
 ;
INP ; Entry point for Inpatient Admission report
 S IBINPT=1,IBSUB="AMV1" G EN1
 ;
INPDIS ; Entry point for Inpatient Discharge report
 S IBINPT=2,IBSUB="AMV3" G EN1
 ;
EN ; Entry point for Outpatient report
 S IBINPT=0,IBSUB=""
EN1 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBCONSC-1" D T0^%ZOSV ;start rt clock
 I '$D(DT) D DT^DICRW
 K ^TMP($J)
 ;
 D ^IBCONS4 I +$G(IBQUIT) G Q
 ;
DEV ; -- ask device
 W !!,*7,"*** Margin width of this output is 132 ***"
 W !,"*** This output should be queued ***"
 ;
 I +$G(IBINPT)=0,+$P($G(^IBE(350.9,1,6)),U,23) W !,"*** If queued, Outpatient Visits in Claims Tracking will be updated first ***"
 ;
 S %ZIS="QM" D ^%ZIS G:POP Q
 I $D(IO("Q")) K IO("Q") D  G Q
 .S ZTRTN="BEGIN^IBCONSC",ZTSAVE("IB*")="",ZTSAVE("VAUTD")="",ZTSAVE("VAUTD(")=""
 .S ZTDESC="IB - Patients with Insurance and "_$S('IBINPT:"Outpatient ",IBINPT=1:"Admissions",1:"Discharges")
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCONSC" D T1^%ZOSV ;stop rt clock
 ;
 ;
BEGIN ; Background job main entry point.  Set up the report header.
 ;***
 ;S XRTL=$ZU(0),XRTN="IBCONSC-2" D T0^%ZOSV ;start rt clock
 ;
 I $D(ZTQUEUED),+$G(IBINPT)=0,+$P($G(^IBE(350.9,1,6)),U,23) D UPCT ; update CT if parameter on, opt, queued
 ;
 S B="",IBL="",$P(IBL,"=",IOM)="",Y=IBBEG X ^DD("DD")
 S IBHD="*Veterans with Reimbursable Insurance and "_$S('IBINPT:"OUTPATIENT Appointments",1:"INPATIENT "_$S(IBINPT=2:"Discharges",1:"Admissions"))_" for the "
 S IBHD=IBHD_$S(IBBEG'=IBEND:"period covering ",1:"")_Y
 I IBBEG<IBEND S Y=IBEND X ^DD("DD") S IBHD=IBHD_" through "_Y
 K %DT S X="N",%DT="T" D ^%DT X ^DD("DD") S IBDATE=Y K %DT
 S IBTRKR=$G(^IBE(350.9,1,6)),IBQUIT=0
 ;
 ; Compile data for the report
 D @($S(IBINPT:"LOOP1",1:"LOOP2")_"^IBCONS2")
 G:IBQUIT Q
 ;
 ; Print the report
 S X=132 X ^%ZOSF("RM") D LOOP25^IBCONS1
 ;
Q ; Clean up variables and close the output device.
 W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K %,%DT,B,I,I1,II,J,K,L,M,N,X,X1,X2,Y,C,DFN,IBCNT,IBIFN,IBBILL,IBSELUBL,IBSELBNA,IBSELBIL,IBFORMFD
 K IBFLAG,IBI,IBDT,IBPAGE,IBL,IBHD,IBBEG1,IBBEG,IBEND,IBSTOP
 K IBTRKR,IBOE,IBSELRNB,IBADMVT,IBETYP,IBRMARK,IBQUIT,IBSELCDV,IBSELRNG,IBSELSR1,IBSELSR2,IBAUTH,IBPRTICR,IBPRTIEX
 K IBINPT,IBPGM,IBVAR,IBFLAG,IBNAME,IBAPPT,IBDC,IBDAT,IBDFN,IBSELTRM,IBQUIT,IBPRTRDS,IBPRTIPC,IBPRTIGC
 K POP,^TMP($J),IBDV,IBSUB,VAUTD,IBINDT,IBINS,IBDATE,IBFL,PTF,IBSC,IBMOV
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCONSC" D T1^%ZOSV ;stop rt clock
 Q
 ;
 ;
HDRDV N IBI,C Q:'$G(IBSELCDV)
 I VAUTD=1 S IBHDRDV=": All Divisions Combined" Q
 S IBHDRDV=" - Divisions Combined: ",C=""
 S IBI="" F  S IBI=$O(VAUTD(IBI)) Q:'IBI  S IBHDRDV=IBHDRDV_C_" "_VAUTD(IBI),C=","
 Q
 ;
UPCT ; Update Claims Tracking
 ; run the Claims Tracking opt tracker routine for same date range of report
 ; newed variables trying to keep the two jobs, report and CT update, from effecting each other except for date range
 ; Input:  IBBEG, IBEND
 ; Output: bulletin indicating how many entries checked and how many added
 ;
 N IBOE,IBOESTAT,IBOETYP,IBTSBDT,IBTSEDT,SDCNT,XMSUB,IBT,IBENCL,IBMESS,IBRMARK,IBANY,VAEL,VA,IBOEDATA,IBVSIT,DFN,X,Y,IBQUIT
 N VAUTD,IBINPT,IBSUB,IBSELUBL,IBSELBNA,IBSELBIL,IBSELRNB,IBSELCDV,IBSELTRM,IBSELRNG,IBPRTRDS,IBPRTIEX,IBPRTICR,IBPRTIPC,IBPRTIGC
 ;
 S IBTSBDT=IBBEG,IBTSEDT=IBEND
 ;
 N IBBEG,IBEND,IBTALK
 ;
 S IBTALK=1 D EN1^IBTRKR4
 Q
