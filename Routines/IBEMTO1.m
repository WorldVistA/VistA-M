IBEMTO1 ;ALB/CPM-LIST MT CHARGES AWAITING NEW COPAY RATE;10-AUG-93
 ;;2.0;INTEGRATED BILLING;**183**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; List Means Test charges on hold, awaiting the new copay rate.
 ;
 ; - quit if there are no charges on hold awaiting the new rate
 I '$D(^IB("AC",20)) W !!,"There are no charges on hold awaiting the entry of the new copay rate." G ENQ
 ;
 ; - select a device
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBEMTO1",ZTDESC="LIST MT CHARGES ON HOLD AWAITING NEW COPAY RATE"
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; Tasked entry point.
 ;
 ; - compile data
 D ENQ1 S IBN=0 F  S IBN=$O(^IB("AC",20,IBN)) Q:'IBN  D
 .S IBND=$G(^IB(IBN,0)),DFN=+$P(IBND,"^",2) Q:'DFN
 .S IBPT=$$PT^IBEFUNC(DFN)
 .S ^TMP("IBEMTO1",$J,$P(IBPT,"^")_"@"_$P(IBPT,"^",3)_"@"_DFN,IBN)=""
 ;
 S (IBPAG,IBQ)=0 D HDR
 ; - print message if there are no charges
 I '$D(^TMP("IBEMTO1",$J)) W !!,"There are no charges on hold awaiting the new copay rate." D PAUSE^IBEMTF2 G ENQ
 ;
 ; - print charges
 S IBNAM="" F  S IBNAM=$O(^TMP("IBEMTO1",$J,IBNAM)) Q:IBNAM=""  D  Q:IBQ
 .I $Y>(IOSL-3) D PAUSE^IBEMTF2 Q:IBQ  D HDR
 .W !,$P(IBNAM,"@"),"  (",$P(IBNAM,"@",2),")"
 .S (IBF,IBN)=0 F  S IBN=$O(^TMP("IBEMTO1",$J,IBNAM,IBN)) Q:'IBN  D  Q:IBQ
 ..I IBF,$Y>(IOSL-3) D PAUSE^IBEMTF2 Q:IBQ  D HDR
 ..S IBND=$G(^IB(IBN,0))
 ..W:IBF ! W ?41,$$DAT1^IBOUTL($P(IBND,"^",14)),?61,$$FORMAT(+$P(IBND,"^",7),10)
 ..S IBF=1
 ;
 ; - end-of-report pause
 D:'IBQ PAUSE^IBEMTF2
 ;
ENQ I '$D(ZTQUEUED) D ^%ZISC
 K DFN,IBF,IBN,IBNAM,IBND,IBPT,IBQ,IBPAG
ENQ1 K ^TMP("IBEMTO1",$J)
 Q
 ;
HDR ; Generate a report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W ?14,"LIST OF ALL COPAYMENT/PER DIEM CHARGES 'ON HOLD'"
 W !?18,"AWAITING ENTRY OF THE NEW RATE",?64,"Page: ",IBPAG
 W !?60,"Run Date: ",$$DAT1^IBOUTL(DT)
 W !,$$DASH(),!,"PATIENT NAME (ID)",?41,"BILL FROM",?64,"CHARGE",!,$$DASH()
 Q
 ;
DASH() ; Return a dashed line.
 Q $TR($J("",80)," ","-")
 ;
 ; Number format
FORMAT(IBNUM,IBDIG,IBFRM) ;
 N X,X1,X2,X3
 S X=IBNUM,X2=$G(IBFRM,"2$"),X3=IBDIG
 D COMMA^%DTC
 Q X
 ;
BULL ; Post results of background billing run in a bulletin.
 K IBT
 S XMTEXT="IBT("
 S XMSUB="BILLING OF MEANS TEST CHARGES AWAITING NEW COPAY RATE"
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S IBT(1)="The job to automatically bill Means Test Outpatient copayment charges"
 S IBT(2)="which were on hold, awaiting the new copayment rate, has just completed."
 S IBT(3)=" "
 S IBT(4)="          Job Start Time: "_$P(IBSTART,"@")_" at "_$P(IBSTART,"@",2)
 S IBT(5)="            Job End Time: "_$P(IBEND,"@")_" at "_$P(IBEND,"@",2)
 S IBT(6)=" "
 S IBT(7)="Number of charges billed: "_IBCNT
 S IBT(8)=$S($D(^IB("AC",20)):"Please Note!  There are still similar charges which remain on hold.",1:"There are no longer any charges awaiting the new copay rate which are on hold.")
 S XMY(DUZ)=""
 D ^XMD
 Q
