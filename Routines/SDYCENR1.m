SDYCENR1 ;ALB/CAW - CLINIC ENROLLMENT ; 7/18/94
 ;;5.3;Scheduling;**21**;Aug 13, 1993
 ;
PRINT ;Print enrollment reports
 ;
 N SDPAT,SDCLIN,SDSOC S SDPAT=0
 S (SDPAGE,SDPAT)=0 D CHECK
 I '$D(^TMP("EN2",$J)) D CHECK,NO G PRINTQ
 F  S SDPAT=$O(^TMP("EN2",$J,SDPAT)) Q:SDPAT=""!(SDQUIT)  D
 .S SDSOC=0 F  S SDSOC=$O(^TMP("EN2",$J,SDPAT,SDSOC)) Q:'SDSOC!(SDQUIT)  D
 ..S SDCLIN=0
 ..F  S SDCLIN=$O(^TMP("EN2",$J,SDPAT,SDSOC,SDCLIN)) Q:SDCLIN=""!(SDQUIT)  D
 ...W !,$E(SDPAT,1,35),?37,SDSOC,?49,$E(SDCLIN,1,30)
 ...D CHECK Q:SDQUIT
PRINTQ K ^TMP("EN2",$J)
 Q
 ;
CHECK ; check to see if header should be printed
 I 'SDPAGE W @IOF D HDR Q
 I $E(IOST,1,2)="C-",($Y+6)>IOSL D PAUSE^VALM1 I 'Y S SDQUIT=1 Q
 I ($Y+6)>IOSL W @IOF D HDR
 Q
 ;
HDR ; Header
 ;
 U IO S SDPAGE=SDPAGE+1
 W !,"Patients with inactive enrollments and no Date of Discharge"
 W ?70,"Page: ",SDPAGE
 W !,"PATIENT",?37,"PATIENT ID",?49,"CLINIC",?70,$$FDATE^VALM1(DT),!,SDASH,!
 Q
NO ; No entries found
 ;
 W !,"No inactive enrollments with missing discharge dates found."
 Q
