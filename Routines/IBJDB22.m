IBJDB22 ;ALB/RB - REASONS NOT BILLABLE REPORT (PRINT) ;19-JUN-00
 ;;2.0;INTEGRATED BILLING;**123,159,399**;21-MAR-94;Build 8
 ;
EN ; - Entry point from IBJDB21.
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D EXTMO(.IB) G ENQ
 ;
 S (IBQ,ECNT,ETOT,SCNT,STOT)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 ;
 S IBDIV="" I 'IBSD S VAUTD(0)=""
 F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  D  I IBQ Q
 . F IBEP=1:1:4 I IBSEL[IBEP D  I IBQ Q
 . . D @($S(IBRPT="D":"DET",1:"SUM"))
 ;
 I IBQ G ENQ
 ;
 I 'IBQ,IBRPT="D" D
 . S IBDIV="" I 'IBSD S VAUTD(0)=""
 . F  S IBDIV=$O(VAUTD(IBDIV)) Q:IBDIV=""  D  I IBQ Q
 . . F IBEP=1:1:4 I IBSEL[IBEP D SUM I IBQ Q
 ;
ENQ K %,IB0,IBDH,IBDIV,IBEP,IBEPH,IBN,IBP,IBPAG,IBPT,IBQ,IBRT,IBRUN,IBSORT
 K IBT1,IBU,GTOT,ECNT,ETOT,SCNT,STOT
 Q
 ;
DET ; - Print detailed report.
 I '$D(^TMP("IBJDB2",$J,IBDIV,IBEP)) D  D PAUSE Q
 . D HDR Q:IBQ  W !!,"No entries for this episode.",!
 S IBT1=0,(IBSORT1,IBPT,IB0)=""
 F  S IBSORT1=$O(^TMP("IBJDB2",$J,IBDIV,IBEP,IBSORT1)) Q:IBSORT1=""  D  Q:IBQ
 . D HDR Q:IBQ
 . F  S IBPT=$O(^TMP("IBJDB2",$J,IBDIV,IBEP,IBSORT1,IBPT)) Q:IBPT=""  S IBP=$G(^(IBPT)) D  Q:IBQ
 . . I $Y>(IOSL-8) D PAUSE Q:IBQ  D HDR Q:IBQ
 . . D WPAT
 . . F  S IB0=$O(^TMP("IBJDB2",$J,IBDIV,IBEP,IBSORT1,IBPT,IB0)) Q:IB0=""  S IBN=$G(^(IB0)) D  Q:IBQ
 . . . I $Y>(IOSL-8) D PAUSE Q:IBQ  D HDR Q:IBQ  D WPAT
 . . . W ?45,$$DTE(+IBN),?55,$$DTE($P(IBN,U,2))
 . . . I $P(IBN,U,4)'="" W ?65,$$DTE($P(IBN,U,3)),?76,$E($P(IBN,U,4),1,19)
 . . . E  W ?65,$$DTE($P(IBN,U,2)) W ?76,"POSTMASTER"
 . . . S IBU=5 S:12[IBEP IBU=$S(IBSORT="R":6,1:IBU)
 . . . I 12[IBEP W ?97,$E($P(IBN,U,IBU),1,25),?124,$J($P(IBN,U,8),8,2),!
 . . . I 34[IBEP,+$P(IBN,U,11)>0 W ?99,$J($P(IBN,U,8),8,2) F X=2:1:$P($P(IBN,U,11),";",1)+1 W ?114,$P($P(IBN,U,11),";",X)_" "
 . . . I 34[IBEP,+$P(IBN,U,11)<0 W ?99,$J($P(IBN,U,8),8,2),!
 . . . I 34[IBEP,+$P(IBN,U,11)>0 W !
 . . . I $P(IBN,U,9)]"" W ?15,"Comments: ",$P(IBN,U,9) W:12'[IBEP !
 . . . I 12[IBEP,+$P(IBN,U,11)>0,$P(IBN,U,9)="" W ?27,"Related Bills: " F X=2:1:$P($P(IBN,U,11),";",1)+1 W ?41,$P($P(IBN,U,11),";",X)_" "
 . . . I 2[IBEP,$P(IBN,U,10)'="" W ?76,"Nx Adm:",?85,$P(IBN,U,10)
 . . . I 12[IBEP,+$P(IBN,U,11)>0,$P(IBN,U,9)'="" W !,?27,"Related Bills: " F X=2:1:$P($P(IBN,U,11),";",1)+1 W ?41,$P($P(IBN,U,11),";",X)_" "
 . . . I 12[IBEP W ?97,$E($P(IBN,U,$S("PR"[IBSORT:7,1:6)),1,25),!
 . . . S SCNT=SCNT+1,ECNT=ECNT+1
 . . . S STOT=STOT+$P(IBN,U,8),ETOT=ETOT+$P(IBN,U,8)
 . I 'IBQ D TOT2 I $O(^TMP("IBJDB2",$J,IBDIV,IBEP,IBSORT1))'="" D PAUSE Q
 I 'IBQ D TOT1,PAUSE
 ;
DETQ Q
 ;
EXTMO(IBSM) ; Extract/transmit data to DM Extract Module
 ; IBSM - Array containing the summary information
 ;
 N I,IB,IBI,IBJ,IBLST,IBR,IBRNB,IBSQ,IBTR,IBTP,IBZ,RNBC,RNBN
 ;
 F I=1:1 S RNBN=$P($T(RNB+I),";;",2,99) Q:RNBN=""  D
 . S RNBC=$O(^IBE(356.8,"B",RNBN,0)) Q:'RNBC
 . S IBTR(RNBC)=I
 ;
 S IBRNB="",IBLST=$O(^IBE(356.8,999),-1)*2
 F IBTP=1:1:4 D
 . F IBJ=1:1:IBLST,999,1000 S IB(IBTP,IBJ)=$S(IBJ#2:0,1:"0.00")
 . F  S IBRNB=$O(IBSM(0,IBTP,IBRNB)) Q:IBRNB=""  D
 . . I '$D(IBTR(IBRNB)) Q
 . . S IBSQ=$S(IBRNB<999:IBTR(IBRNB)*2-1,1:999)
 . . S IBZ=$G(IBSM(0,IBTP,IBRNB))
 . . S IB(IBTP,IBSQ)=+IBZ
 . . S IB(IBTP,IBSQ+1)=$FN(+$P(IBZ,"^",2),"",2)
 . F I=1:1:3 D E^IBJDE(21+(IBTP*3)+I,0)
 . K IB(IBTP)
 ;
 Q
 ;
SUM ; - Print summary line(s).
 I '$D(IB(IBDIV,IBEP)) D  D PAUSE Q
 . D SUMH W !!?14,"No statistics available."
 D SUMH Q:IBQ
 S IBRNB=0 F  S IBRNB=$O(IB(IBDIV,IBEP,IBRNB)) Q:'IBRNB  D  Q:IBQ
 . S IBN=IB(IBDIV,IBEP,IBRNB)
 . W !?14,$P($G(^IBE(356.8,IBRNB,0)),U),?48,$J(+IBN,5),?57,$J($P(IBN,U,2),9,2)
 . S $P(GTOT,U)=$P(GTOT,U)+IBN,$P(GTOT,U,2)=$P(GTOT,U,2)+$P(IBN,U,2)
 D SUMT
 ;
 Q
 ;
SUMH ; - Print summary header.
 I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1 W ?68,"Page: ",IBPAG
 S IBEPH="REASONS NOT BILLABLE SUMMARY/"_IBEPS(IBEP)
 W !!?(80-$L(IBEPH))\2,IBEPH
 I IBDIV D
 .S IBDH="Division: "_$P($G(^DG(40.8,IBDIV,0)),U)
 .W !?(80-$L(IBDH)\2),IBDH
 ;
 W !?22,"Period : from ",$$DTE(IBBDT)," thru ",$$DTE(IBEDT),!
 W !?24,"Run Date: ",IBRUN
 W !!?46,"No. of",?61,"Total",!?14,"RNB Category",?46,"Entries"
 W ?60,"Amount",!?14,$$DASH(52)
 S GTOT="0^0",IBQ=$$STOP^IBOUTL("Reasons Not Billable Summary")
 Q
 ;
SUMT ; - Print summary totals.
 W !?47,"-------------------"
 W !?33,"Grand Totals:",?47,$J(+GTOT,6),?56,$J($P(GTOT,U,2),10,2) D PAUSE
 Q
 ;
HDR ; - Write the detailed report header.
 I $E(IOST,1,2)="C-"!$G(IBPAG) W @IOF,*13
 S IBPAG=$G(IBPAG)+1 W "Reasons Not Billable (RNB) Report "
 W ?88,"Run Date: ",IBRUN,?123,"Page: ",$J(IBPAG,3)
 S X=IBE(IBEP)_" events by "
 I 1234[IBEP D
 . S X=X_$S(IBSORT="P":"provider",IBSORT="S":"specialty",1:"RNB category")
 . I $G(IBSORT1)'="" S X=X_" ("_IBSORT1_")"
 E  S X=X_"RNB category"
 S X=X_" from "_$$DTE(IBBDT)_" thru "_$$DTE(IBEDT)_" ("_IBD_")"
 I 12[IBEP D
 . I IBSORT'="R" D
 . . S X=X_" / "_$S(IBSRNB="S":"SPECIFIC",1:"ALL")_" REASONS NOT BILLABLE"
 . I IBSORT'="P" D
 . . S X=X_" / "_$S(IBSPRV="S":"SPECIFIC",1:"ALL")_" PROVIDERS"
 . I IBSORT'="S",IBEP=1 D
 . . S X=X_" / "_$S(IBSISP="S":"SPECIFIC",1:"ALL")_" SPECIALTIES"
 . I IBSORT'="S",IBEP=2 D
 . . S X=X_" / "_$S(IBSOSP="S":"SPECIFIC",1:"ALL")_" SPECIALTIES"
 F I=1:1 W !,$E(X,1,132) S X=$E(X,133,999) I X="" Q
 ;
 I IBDIV W !,"Division: ",$P($G(^DG(40.8,IBDIV,0)),U)
 W !!?26,"Last",?32,"Insurance",?45,"Episode   Date      Dte Last"
 I 12[IBEP W ?97,$S("PS"[IBSORT:"RNB Category",1:"Provider")
 W !,"Patient",?26,"4SSN",?32,"Carrier"
 W ?45,"Date      Entered   Edited     Last Edited By"
 I 12[IBEP W ?97,$S("PR"[IBSORT:"Specialty",1:"Provider")
 ;
 I 34[IBEP W ?101,"Amount",?114,"Related Bills",!,$$DASH(IOM),!
 E  W ?126,"Amount",!,$$DASH(IOM),!
 S IBQ=$$STOP^IBOUTL("Reasons Not Billable Report")
 Q
 ;
WPAT ; - Write patient data.
 W $P(IBPT,"@@"),?26,$P(IBPT,"@@",2),?32,$E($P(IBP,U),1,12)
 Q
 ;
TOT1 ; - Print episode totals.
 I 34[IBEP W !?97,"----------",!
 E  W !?122,"----------",!
 I 34[IBEP W ?55
 E  W ?80
 W "TOTAL FOR EPISODE - Count: ",$J(ECNT,5),"  Amount: ",$J(ETOT,10,2)
 S (ECNT,ETOT)=0
 Q
 ;
TOT2 ; - Print sub-totals.
 I 34[IBEP W ?98,"---------",!
 E  W ?123,"---------",!
 I 34[IBEP W ?60
 E  W ?85
 W "TOTAL EVENTS - Count:  ",$J(SCNT,4),"  Amount:  ",$J(STOT,9,2),!
 S (SCNT,STOT)=0
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
 ;
DTE(X) ; - Format the date.
 Q $S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 ;
RNB ; - Reasons Not Billable 
 ;;NOT INSURED
 ;;SC TREATMENT
 ;;AGENT ORANGE
 ;;IONIZING RADIATION
 ;;ENV. CONTAM.
 ;;SERVICE NOT COVERED
 ;;COVERAGE CANCELED
 ;;NEEDS SC DETERMINATION
 ;;NON-BILLABLE APPOINTMENT TYPE
 ;;INVALID PRESCRIPTION ENTRY
 ;;REFILL ON VISIT DATE
 ;;PRESCRIPTION DELETED
 ;;PRESCRIPTION NOT RELEASED
 ;;DRUG NOT BILLABLE
 ;;HMO POLICY
 ;;REFUSES TO SIGN RELEASE (ROI)
 ;;NON-BILLABLE STOP CODE
 ;;RESEARCH VISIT
 ;;BILL PURGED
 ;;NON-BILLABLE CLINIC
 ;;MILITARY SEXUAL TRAUMA
 ;;CREDENTIALING ISSUE
 ;;INSUFFICIENT DOCUMENTATION
 ;;NO DOCUMENTATION
 ;;NON-BILLABLE PROVIDER (RESID.)
 ;;NON-BILLABLE PROVIDER (OTHER)
 ;;OTHER COMPLIANCE
 ;;OUT OF NETWORK (PPO)
