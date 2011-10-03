IBQLD4 ;LEB/MRY - ACUTE/NON-ACUTE REPORT ; 17-MAY-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I '$D(DT) D DT^DICRW
DATE W ! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 S X1=IBEDT,X2=IBBDT D ^%DTC I X>365 W !,"<<< please report 1 years of information only. >>>" G DATE
DIAG S DIR(0)="SA^A:All Admitting Diagnosis;I:Individual Admitting Diagnosis",DIR("A")="Display ALL or INDIVIDUAL Admitting Diagnosis? [A/I]: "
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR
 S IBTY=Y G:IBTY="A" DEV
 S DIR(0)="SA^R:Range;E:Exact Match",DIR("A")="Search by Range or Exact Match? [R/E]: "
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR
 S IBTY1=Y G:IBTY1="E" DIAGI
 S DIC="^ICD9(",DIC(0)="AMEQZ"
 S DIC("A")="Start with ADMITTING DIAGNOSIS: " D ^DIC G END:Y'>0 S DG1=Y(0,0),DG1=$E(DG1,1,$L(DG1)-1)_$C($A(DG1,$L(DG1))-1)_"zzzzzz"
F S DIC("A")="Go to ADMITTING DIAGNOSIS: " D ^DIC Q:Y'>0  S DG6=Y(0,0) I DG6']DG1 W !,"Must be after start code",! G F
 G DEV
DIAGI S DIR(0)="PO^80:AEQMZ",DIR("A")="Enter ADMITTING DIAGNOSIS"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR I X="" G:$O(IBDIAG(""))="" DIAGI G DEV
 S IBDIAG(Y(0,0))="" G DIAGI
DEV ; -- select device, run option
 W !!,"Set your Device settings to '0;255;9999'"
 W ! D ^%ZIS G:POP END
 S DIR(0)="FO",DIR("A")="Initiate File Capture Procedure and Press Return" D ^DIR I $D(DTOUT)!$D(DUOUT) G END
 W !,"Working...",!
 U IO
 ;
START ;
 K ^TMP("IBQLD4",$J) S IBDDT=IBBDT-.01,(IBPAG,IBQUIT,IBMCT)=0
 F  S IBDDT=$O(^IBQ(538,"ADIS",IBDDT)) Q:'IBDDT!(IBDDT>IBEDT)  D
 .S IBMONTH=$E(IBDDT,1,5) I '$D(IBMONTH(IBMONTH)) S IBMONTH(IBMONTH)="",IBMCT=IBMCT+1
 .S IBTRN="" F  S IBTRN=$O(^IBQ(538,"ADIS",IBDDT,IBTRN)) Q:'IBTRN  D DATA
 ;
 D PRINT^IBQLD4A
END ; -- Clean up
 W ! K ^TMP("IBQLD4",$J),IB,IBMONTH,IBDDT,IBBDT,IBEDT,IBTRN,IBTRND,IBTY,IBTY1,IBTEXT,IBDATA,IBHDR,IBQUIT,IBPAG,IBTRV,IBMONTH,MSTRING,IBREA,I,N,X,IBRES,IBCAT,IBMTH,IBMD,IBDIAG
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
DATA ;
 ; -- get Admission Review info.
 D ADMIT^IBQL538 S IBQUIT=""
 S IBDIAG=IB(.04),IBDIAG1=" "_IBDIAG Q:IBDIAG=""  I IBTY="I" D  Q:IBQUIT
 .I IBTY1="E",($D(IBDIAG(IBDIAG))) Q
 .I IBTY1="R",(IBDIAG]DG1)&(IBDIAG']DG6) Q
 .S IBQUIT=1
 ; -- count acute admissions
 I IB("ACUTE ADMISSION") D
 .S ^($E(IBDDT,1,5))=$G(^TMP("IBQLD4",$J,IBDIAG1,1,"CNTA",$E(IBDDT,1,5)))+1
 ; -- count non-acute admissions
 E  D
 .S ^($E(IBDDT,1,5))=$G(^TMP("IBQLD4",$J,IBDIAG1,1,"CNTN",$E(IBDDT,1,5)))+1
 .F I=1:1 S IBR=$P(IB(1.03)," ",I) Q:'IBR  S ^($E(IBDDT,1,5))=$G(^TMP("IBQLD4",$J,IBDIAG1,1,"REA",IBR,$E(IBDDT,1,5)))+1
 ; --continued stay days
 S IBTRV=0 F  S IBTRV=$O(^IBQ(538,IBTRN,13,IBTRV)) Q:'IBTRV  D
 .D STAY^IBQL538
 .I IB("ACUTE STAY") D 
 ..S ^($E(IBDDT,1,5))=$G(^TMP("IBQLD4",$J,IBDIAG1,2,"CNTA",$E(IBDDT,1,5)))+1
 .E  D
 ..S ^($E(IBDDT,1,5))=$G(^TMP("IBQLD4",$J,IBDIAG1,2,"CNTN",$E(IBDDT,1,5)))+1
 ..F I=1:1 S IBR=$P(IB(13.06)," ",I) Q:'IBR  S ^($E(IBDDT,1,5))=$G(^TMP("IBQLD4",$J,IBDIAG1,2,"REA",IBR,$E(IBDDT,1,5)))+1
 Q
