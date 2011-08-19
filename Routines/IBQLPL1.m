IBQLPL1 ;LEB/MRY - PATIENTS QUALIFY/MISSING INFO LIST ; 24-MAR-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**1**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
START ; -- loop thru discharges in Claims Tracking
 S IBDDT=IBBDT-.01
 F  S IBDDT=$O(^IBT(356,"ADIS",IBDDT)) Q:'IBDDT!(IBDDT>IBEDT)  D
 .S IBTRN="" F  S IBTRN=$O(^IBT(356,"ADIS",IBDDT,IBTRN)) Q:'IBTRN  D
 ..I '$D(^IBT(356.1,"C",IBTRN))!'$G(^IBT(356,IBTRN,0)) Q
 ..;
 ..S IBQUIT=0 D CLAIMS^IBQL356 Q:IBQUIT
 ..S IB(1.06)=$S(IB(1.06)="L":"ZL",IB(1.06)="":"AA",1:IB(1.06))
 ..;
 ..I IBRPT="Q" D QUALIFY
 ..I IBRPT="M" D MISSING
 I $$STOP Q
 Q
 ;
QUALIFY ; --list patients to be included in Rollup
 S DFN=$P(IBTRND,"^",2),X=$G(^DPT(DFN,0))
 S IBNAM=$P(X,"^"),SSN=$P(X,"^",9) S:SSN ^TMP("IBQLPL",$J,IB(1.06),IBDDT,SSN)=IBNAM
 Q
 ;
 ;
MISSING ; -- list patients with missing data
 ;
 ; -- send message if missing adm diagnosis, enroll code, adm
 F IBFLD=.04,.05,.09 D ERR I IBERR'="" S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),IBFLD)=IBERR
 ; -- check for (.0001) fundemental completion errors
 I $P(IBTRND,"^",18)'=1 D
 .S IBERR="EVENT TYPE NOT OF INPATIENT ADMISSION (#"_IB(.01)_")"
 .S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),.0001)=IBERR
 I $P(IBTRND,"^",20)'=1 D
 .S IBERR="CLAIMS TRACKING ENTRY IS INACTIVE (#"_IB(.01)_")"
 .S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),.0002)=IBERR
 ;
ORDER ; -- check (.001) procedure ordering errors, arrange in DAY order.
 S IBTRV=0
 D ORDCHK^IBQLPL3
 Q:IB001
 S IBDAY=0
 F  S IBDAY=$O(IBORDER(IBDAY)) Q:'IBDAY  D
 .S IBTRV=IBORDER(IBDAY)
 .I IBDAY=1 D ADMIT
 .I IBDAY>1 D STAY
 I $O(^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),0)) S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03))=IBNAM
 Q
 ;
ADMIT ; get Admission Review infomation into IB(array)
 D ADMIT^IBQL356 Q:IBQUIT
 ; -- send message if no treating specialty, service
 F IBFLD=.12,1.07 D ERR I IBERR'="" S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),IBFLD)=IBERR
 ; -- send message if si,is, reasons are not answered
 I IB(1.01)="",IB(1.02)="",IB(1.03)="" F IBFLD=1.01,1.02,1.03 D ERR I IBERR'="" S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),IBFLD)=IBERR
 ; -- check for (.0001) fundemetally completion errors
 I $P(IBTRVD,"^",21)'=10 D
 .S IBERR="Admission Stay not COMPLETE (#"_IB(.01)_")"
 .S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),.0004)=IBERR
 S IBPIS=IB(1.02)
 Q
 ; 
STAY ; get Stay Review information into IB(array)
 D STAY^IBQL356 Q:IBQUIT
 F IBFLD=13.07,13.08 D ERR I IBERR'="" S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),(IB(13.01)+IBFLD))=IBERR
 I IB(13.02)="",IB(13.06)="" F IBFLD=13.02,13.06 D ERR I IBERR'="" S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),(IB(13.01)+IBFLD))=IBERR
 ; -- check for (.0001) fundementally completion errors
 I $P(IBTRVD,"^",21)'=10 D
 .S IBERR="STAY DAY "_IB(13.01)_" NOT COMPLETE (#"_IB(.01)_")"
 .S ^TMP("IBQLPL",$J,IB(1.06),IBDDT,IB(.03),(IB(13.01)+.0004))=IBERR
 Q
 ;
ERR ; -- return missing message
 S IBERR=""
 I IB(IBFLD)="" S IBERR="MISSING "_IBD(IBFLD) S:IBFLD>13 IBERR=IBERR_" DAY "_IB(13.01) S IBERR=IBERR_" (#"_IB(.01)_")"
 Q
ERR1 ; -- return error message that entry EVENT TYPE is not Inpatient status.
 S IBERR="EVENT TYPE not of INPATIENT ADMISSION (#"_IB(.01)_")"
 Q
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPAG) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
