IBQLLD ;LEB/MRY - LOAD UMR FILE ; 31-MAR-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**2**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I '$D(IBRPT) Q
 ; --
 I '$D(DT) D DT^DICRW
 D PULL^IBQLPL
 I IBRPT="N" S IBDNLD="N" G START
 W !!,"Create Rollup File"
 ;W !,"The next National Rollup will be " S Y=IBBDT X ^DD("DD") W Y_" to " S Y=IBEDT X ^DD("DD") W Y
 I IBMSG'="" W !!,IBMSG,!,IBMSG1
 ;
DATE ; -- get date range
 W ! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 S X1=IBEDT,X2=IBBDT D ^%DTC I X>365 W !,"<<< please report 1 years of information only. >>>" G DATE
 ;
 S DIR(0)="SA^RD:RANDOM & DISEASE;L:LOCAL;A:ALL",DIR("A")="Random & Disease Cases, Local Cases or ALL Cases: ",DIR("B")="ALL" D ^DIR I $D(DUOUT)!($D(DTOUT)) G END
 S IBDNLD=Y
 F I="IBBDT","IBEDT","IBRPT","IBDNLD" S ZTSAVE(I)=""
 S ZTRTN="START^IBQLLD",ZTDESC="IBQ - LOCAL ROLLUP ",ZTIO=""
 D ^%ZTLOAD G END
 ;
START S IBDDT=IBBDT-.01,IBREC=0
 F  S IBDDT=$O(^IBT(356,"ADIS",IBDDT)) Q:'IBDDT!(IBDDT>IBEDT)  D
 .S IBTRN="" F  S IBTRN=$O(^IBT(356,"ADIS",IBDDT,IBTRN)) Q:'IBTRN  D
 ..I '$D(^IBT(356.1,"C",IBTRN))!'$G(^IBT(356,IBTRN,0)) Q
 ..D DATA
 ..Q
 .Q
 ;
 D TRANSMIT^IBQLLD1
 ;
END K IBDATA,X,I,DFN,DGPM,VAINDT,VAIN,IBRPT,IBFLD,IB,IBDDT,IBBDT,IBTRN,IBTRND,IBNAM,IBR,IBD,IBL,IBDNLD,IBHR,IBDAY,IBREC,IBORDER
 Q
 ;
DATA ;
 K IBDATA S IBQUIT=""
CLAIMS ; get Claims Tracking and misc. information into IB(array)
 D CLAIMS^IBQL356 Q:IBQUIT
 ; -- quit if missing entry id, site, ssn, adm diagnosis, enroll code,
 ; admission, rollup type
 F IBFLD=.01,.02,.03,.04,.05,.09,1.06 I IB(IBFLD)="" S IBQUIT=1 Q
 ; -- quit if EVENT TYPE not INPATIENT ADMISSION or INACTIVE.
 I $P(IBTRND,"^",18)'=1!($P(IBTRND,"^",20)'=1) S IBQUIT=1 Q
 Q:IBQUIT
 Q:IBDNLD="N"&(IB(1.06)="L")  Q:IBDNLD="L"&(IB(1.06)="N")  Q:IBDNLD="RD"&(IB(1.06)="L")
 ;
ORDER ; -- check procedure ordering errors, arrange in DAY order.
 S IBTRV=0
 D ORDCHK^IBQLLD2
 Q:IBQUIT
 S IBDAY=0
 F  S IBDAY=$O(IBORDER(IBDAY)) Q:'IBDAY  D  Q:IBQUIT
 .S IBTRV=IBORDER(IBDAY)
 .I IBDAY=1 D ADMIT
 .I IBDAY>1 D STAY
 ;
 ; -- quit if missing discharge date
 I IB(.1)="" S IBQUIT=1 Q
 ;
LOAD ; -- load data into ^ibq(538, file
 Q:IBQUIT  Q:'$D(IBDATA(0))  Q:'$D(IBDATA(1))
 D LOAD^IBQLLD1 S IBREC=IBREC+1
 Q
 ;
 ;
ADMIT ; get Admission Review information into IB(array)
 D ADMIT^IBQL356 Q:IBQUIT
 ; -- quit if missing treating specialty, service
 F IBFLD=.12,1.07 I IB(IBFLD)="" S IBQUIT=1 Q
 ; -- quit if missing si, is and reason from admission
 I IB(1.01)="",IB(1.02)="",IB(1.03)="" S IBQUIT=1 Q
 ; -- quit if not ACTIVE or not COMPLETE.
 I $P(IBTRVD,"^",21)'=10 S IBQUIT=1 Q
 S X="" F IBFLD=.01:.01:.13 S X=X_IBFLD_":"_IB(IBFLD)_"^"
 S IBDATA(0)=$P(X,"^",1,$L(X,"^")-1)
 S X="" F IBFLD=1.01:.01:1.07 S X=X_IBFLD_":"_IB(IBFLD)_"^"
 S IBDATA(1)=$P(X,"^",1,$L(X,"^")-1)
 S IBPIS=IB(1.02)
 Q
 ; 
STAY ;  get Stay Review information into IB(array)
 D STAY^IBQL356 Q:IBQUIT
 ; -- quit if missing 'is' AND missing 'reasons'
 I IB(13.02)="",IB(13.06)="" S IBQUIT=1 Q
 ; -- quit if missing Treating Specialty in continued stay
 I IB(13.07)="" S IBQUIT=1 Q
 ; -- quit if not ACTIVE or not COMPLETE.
 I $P(IBTRVD,"^",21)'=10 S IBQUIT=1 Q
 Q:IBQUIT
 S X="" F IBFLD=13.01,13.02,13.03,13.04,13.05,13.06,13.07,13.08 S X=X_(IBFLD-13)_":"_IB(IBFLD)_"^"
 S IBDATA(IB(13.01))=$P(X,"^",1,$L(X,"^")-1)
 Q
