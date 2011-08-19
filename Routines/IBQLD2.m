IBQLD2 ;LEB/MRY - PATIENT DOWNLOAD TO SPREADSHEET ; 17-MAY-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**2**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I '$D(DT) D DT^DICRW
DATE W ! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 S X1=IBEDT,X2=IBBDT D ^%DTC I X>365 W !,"<<< please report 1 years of information only. >>>" G DATE
 S (IBQUIT,IBPAG)=0
 S DIR(0)="SA^S:Services;T:Treating Specialties;P:Providers",DIR("A")="Download Services, Treating Specialties, or Providers? [S/T/P]: "
 W ! D ^DIR G:$D(DUOUT)!($D(DTOUT)) END K DIR
 S IBTY=Y G:IBTY="P" PHY^IBQLD3
 I IBTY="S" S DIR(0)="SA^A:All Services;I:Individual Services",DIR("A")="Download ALL or INDIVIDUAL Services? [A/I]: "
 I IBTY="T" S DIR(0)="SA^A:All Treating Specialties;I:Individual Treating Specialties",DIR("A")="Download ALL or INDIVIDUAL Treating Specialties? [A/I]: "
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
 W !!,"Set your Device settings to '0;255;9999'"
 W ! D ^%ZIS G:POP END
 S DIR(0)="FO",DIR("A")="Initiate File Capture Procedure and Press Return" D ^DIR I $D(DTOUT) G END
 W !,"Working...",!
 U IO
 ;
START ;
 K ^TMP("IBQLD2",$J) S IBDDT=IBBDT-.01,IBLVH=0
 F  S IBDDT=$O(^IBQ(538,"ADIS",IBDDT)) Q:'IBDDT!(IBDDT>IBEDT)  D
 .S IBTRN="" F  S IBTRN=$O(^IBQ(538,"ADIS",IBDDT,IBTRN)) Q:'IBTRN  D DATA
 ;
 D PRINT^IBQLD2A
END ; -- Clean up
 W ! K ^TMP("IBQLD2",$J),IB,IBDDT,IBBDT,IBEDT,IBTRN,IBTRND,IBTS,IBTY,IBTEXT,IBDATA,IBHDR,IBQUIT,IBPAG,IBREA,IBLV,IBLVH,I,N,X
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
DATA ;
ADMIT ; -- get Admission Review info.
 S IBLV=0 D ADMIT^IBQL538
 S IBSVC=IB(1.07),IBTS=IB(.12) S:IBTY="S" IBTS=999 S:IBSVC="" IBSVC="UNK"
 I IBTY1="I" G:IBTY="S"&('$D(IBSVC(IBSVC))) STAY G:IBTY="T"&('$D(IBTS(IBTS))) STAY
 S IBDATA=IB(.09)_"^"_IB(.04)_"^"_IB(.05)_"^"_IB(.06)_"^"_IB(.07)_"^"_IB(.08)_"^"_IB("ACUTE ADMISSION")_"^"_$S('IB("ACUTE ADMISSION"):1,1:"")_"^"_IB(1.03)
 S ^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03))=IBDATA
 S ^("LOS")=$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),"LOS"))+1
 I IB("ACUTE ADMISSION") S ^("S-AC")=$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),"S-AC"))+1
 E  S ^("S-NAC")=$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),"S-NAC"))+1
STAY ; -- get Stay Review info.
 S IBTRV=0 F  S IBTRV=$O(^IBQ(538,IBTRN,13,IBTRV)) Q:'IBTRV  D
 .D STAY^IBQL538
 .S IBSVC=IB(13.08),IBTS=IB(13.07) S:IBTY="S" IBTS=999 S:IBSVC="" IBSVC="UNK"
 .I IBTY1="I" Q:IBTY="S"&('$D(IBSVC(IBSVC)))  Q:IBTY="T"&('$D(IBTS(IBTS)))
 .I '$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03))) D
 ..S IBDATA=IB(.09)_"^"_IB(.04)_"^"_IB(.05)_"^"_IB(.06)_"^"_IB(.07)_"^"_IB(.08)_"^"_"^"_"^"
 ..S ^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03))=IBDATA
 .F I=1:1:3 S REA=$P(IB(13.06)," ",I) Q:'REA  D
 ..I '$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),+REA)) S IBLV=IBLV+1
 ..S ^(+REA)=$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),+REA))+1
 .S ^("LOS")=$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),"LOS"))+1
 .I IB("ACUTE STAY") S ^("S-AC")=$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),"S-AC"))+1
 .E  S ^("S-NAC")=$G(^TMP("IBQLD2",$J,IBSVC,IBTS,IB(.1),IB(.03),"S-NAC"))+1
 .I IBLV>IBLVH S IBLVH=IBLV
 Q
