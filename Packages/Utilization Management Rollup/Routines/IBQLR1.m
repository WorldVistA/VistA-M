IBQLR1 ;LEB/MRY - ACUTE/NON-ACUTE REPORT ; 17-MAY-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**2**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I '$D(DT) D DT^DICRW
DATE W ! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 S X1=IBEDT,X2=IBBDT D ^%DTC I X>365 W !,"<<< please report 1 years of information only. >>>" G DATE
 S DIR(0)="SA^S:Services;T:Treating Specialties;A:Admitting Diagnosis",DIR("A")="Display Services, Treating Specialties, or Admitting Diagnosis? [S/T/A]: "
 W ! D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR
 S IBTY=Y I IBTY="A" G DIAG^IBQLR4
 I IBTY="S" S DIR(0)="SA^A:All Services;I:Individual Services",DIR("A")="Display ALL or INDIVIDUAL Services? [A/I]: "
 I IBTY="T" S DIR(0)="SA^A:All Treating Specialties;I:Individual Treating Specialties",DIR("A")="Display ALL or INDIVIDUAL Treating Specialties? [A/I]: "
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR
 S IBTY1=Y G:IBTY1="A" DEV
 I IBTY="T" G TSI
SVCI S DIR(0)="42.4,3O",DIR("A")="Enter SERVICE"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR I X="" G:$O(IBSVC(""))="" SVCI G DEV
 S IBSVC(Y)=Y(0) G SVCI
TSI S DIR(0)="PO^45.7:AEQZ",DIR("A")="Enter TREATING SPECIALTY"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR I X="" G:$O(IBTS(""))="" TSI G DEV
 S IBTS(Y(0,0))="" G TSI
DEV ; -- select device, run option
 W ! S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) F I="IBTY","IBBDT","IBEDT","IBTS(","IBSVC(","IBTY1" S ZTSAVE(I)=""
 I $D(IO("Q")) S ZTRTN="START^IBQLR1",ZTDESC="UM - ACUTE REPORT" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 U IO
 ;
START ;
 K ^TMP("IBQLR1",$J) S IBDDT=IBBDT-.01,(IBPAG,IBQUIT,IBMCT)=0
 F  S IBDDT=$O(^IBQ(538,"ADIS",IBDDT)) Q:'IBDDT!(IBDDT>IBEDT)  D
 .S IBMONTH=$E(IBDDT,1,5) I '$D(IBMONTH(IBMONTH)) S IBMONTH(IBMONTH)="",IBMCT=IBMCT+1
 .S IBTRN="" F  S IBTRN=$O(^IBQ(538,"ADIS",IBDDT,IBTRN)) Q:'IBTRN  D DATA
 ;
 I $$STOP,$G(ZTSTOP) G END
 D PRINT^IBQLR1A
END ; -- Clean up
 W ! K ^TMP("IBQLR1",$J),IB,IBMONTH,IBDDT,IBBDT,IBEDT,IBTRN,IBTRND,IBTS,IBTY,IBTEXT,IBDATA,IBHDR,IBQUIT,IBPAG,IBTRV,IBMONTH,MSTRING,IBREA,I,N,X,IBRES,IBCAT,IBMTH,IBMD,IBSVC
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
DATA ;
ADMIT ; -- get Admission Review info.
 D ADMIT^IBQL538
 S IBSVC=IB(1.07),IBTS=IB(.12) S:IBTY="S" IBTS=999 S:IBSVC="" IBSVC="UNK"
 I IBTY1="I" G:IBTY="S"&('$D(IBSVC(IBSVC))) STAY G:IBTY="T"&('$D(IBTS(IBTS))) STAY
 ; -- count acute admissions
 I IB("ACUTE ADMISSION") D
 .S ^($E(IBDDT,1,5))=$G(^TMP("IBQLR1",$J,IBSVC,IBTS,1,"CNTA",$E(IBDDT,1,5)))+1
 ; -- count non-acute admissions
 E  D
 .S ^($E(IBDDT,1,5))=$G(^TMP("IBQLR1",$J,IBSVC,IBTS,1,"CNTN",$E(IBDDT,1,5)))+1
 .F I=1:1 S IBR=$P(IB(1.03)," ",I) Q:'IBR  S ^($E(IBDDT,1,5))=$G(^TMP("IBQLR1",$J,IBSVC,IBTS,1,"REA",IBR,$E(IBDDT,1,5)))+1
STAY ; --continued stay days
 S IBTRV=0 F  S IBTRV=$O(^IBQ(538,IBTRN,13,IBTRV)) Q:'IBTRV  D
 .D STAY^IBQL538
 .S IBSVC=IB(13.08),IBTS=IB(13.07) S:IBTY="S" IBTS=999 S:IBSVC="" IBSVC="UNK"
 .I IBTY1="I" Q:IBTY="S"&('$D(IBSVC(IBSVC)))  Q:IBTY="T"&('$D(IBTS(IBTS)))
 .I IB("ACUTE STAY") D 
 ..S ^($E(IBDDT,1,5))=$G(^TMP("IBQLR1",$J,IBSVC,IBTS,2,"CNTA",$E(IBDDT,1,5)))+1
 .E  D
 ..S ^($E(IBDDT,1,5))=$G(^TMP("IBQLR1",$J,IBSVC,IBTS,2,"CNTN",$E(IBDDT,1,5)))+1
 ..F I=1:1 S IBR=$P(IB(13.06)," ",I) Q:'IBR  S ^($E(IBDDT,1,5))=$G(^TMP("IBQLR1",$J,IBSVC,IBTS,2,"REA",IBR,$E(IBDDT,1,5)))+1
 Q
 ;
STOP() ; determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTEQ I $G(IBPAG) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
