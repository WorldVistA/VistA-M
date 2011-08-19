IBJDI5 ;ALB/CPM - INSURANCE POLICIES NOT VERIFIED ; 18-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,98,100,118,123**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
 W !!,"This report provides a number of the insurance policies which were"
 W !,"entered into the system within a given timeframe, but were never verified.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD I IBRPT["^" G ENQ
 ;
 ; - Select print/not print verified policies/totals.
 S DIR(0)="YO"
 S DIR("A",1)="Do you want to print a "_$S(IBRPT="D":"separate report for",1:"total number of")_" policies that were verified"
 S DIR("A")="  over a year ago"
 S DIR("B")="NO" D ^DIR K DIR S IBVER=Y I IBVER["^" G ENQ
 ;
 I IBRPT="D" W !!,"You will need a 132 column printer for this report!"
 E  W !!,"This report only requires an 80 column printer."
 ;
 W !!,"Note: This report may take a while to run."
 W !?6,"You should queue this report to run after normal business hours.",!
 ;
 ; - Select a device.
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDI5",ZTDESC="IB - INSURANCE POLICIES NOT VERIFIED"
 .F I="IBBDT","IBEDT","IBRPT","IBVER" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(5,1) ; Change extract status.
 ;
 N IBQUERY
 K IB,^TMP("IBJDI51",$J),^TMP("IBJDI52",$J)
 S (IB("NOT"),IB("TOT"),IB("VER"),IBQ)=0 S:IBVER IB("VERO")=0
 ;
 ; - Find inpatients treated within the user-specified date range.
 S IBD=IBBDT-.01 F  S IBD=$O(^DGPM("ATT3",IBD)) Q:'IBD!(IBD\1>IBEDT)  D  Q:IBQ
 .S IBPM=0 F  S IBPM=$O(^DGPM("ATT3",IBD,IBPM)) Q:'IBPM  D  Q:IBQ
 ..I IBPM#100=0 S IBQ=$$STOP^IBOUTL("Insurance Policies Not Verified") Q:IBQ
 ..S IBPMD=$G(^DGPM(IBPM,0)) Q:'IBPMD
 ..S DFN=+$P(IBPMD,U,3) Q:'DFN
 ..;
 ..; - Process patient.
 ..I '$D(^TMP("IBJDI51",$J,DFN)) D PROC(DFN,"*",IBD)
 ;
 I IBQ G ENQ
 ;
 ; - Find outpatients treated within the user-specified date range.
 D CLOSE^IBSDU(.IBQUERY)
 D OUTPT^IBJDI21("",IBBDT,IBEDT,"S:IBQ SDSTOP=1 I 'IBQ,$$ENCHK^IBJDI5(Y0) D ENC^IBJDI5(Y0)","Insurance Policies Not Verified",.IBQ,"IBJDI51",.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY)
 ;
 I IBQ G ENQ
 ;
 ; - Find data required for the report.
 S IBC=0 F  S IBC=$O(^TMP("IBJDI51",$J,IBC)) Q:'IBC  D  Q:IBQ
 .I IBC#100=0 S IBQ=$$STOP^IBOUTL("Insurance Policies Not Verified") Q:IBQ
 .;
 .; - Get the patient's active insurance policies.
 .K IBINS S IBC1=$G(^TMP("IBJDI51",$J,IBC))
 .D ALL^IBCNS1(IBC,"IBINS",1,+IBC1) Q:'$D(IBINS)
 .S IBC2=0 F  S IBC2=$O(IBINS(IBC2)) Q:'IBC2  D
 ..;
 ..; - Make sure the insurance company reimburses VA.
 ..S IBC3=$G(^DIC(36,+$G(IBINS(IBC2,0)),0))
 ..Q:$P(IBC3,U)=""  Q:$P(IBC3,U,2)="N"
 ..;
 ..S IBCDFND=$G(IBINS(IBC2,1))
 ..;
 ..S IB("TOT")=IB("TOT")+1 ; Count all.
 ..;
 ..; - Check if policy is verified, verified over a year, or neither.
 ..S IBVFLG=0
 ..I $P(IBCDFND,U,3) D  Q:'IBVFLG
 ...S IB("VER")=IB("VER")+1 Q:'IBVER
 ...S X1=DT,X2=$P(IBCDFND,U,3) D ^%DTC
 ...I X>365 S IB("VERO")=IB("VERO")+1,IBVFLG=1
 ..E  S IB("NOT")=IB("NOT")+1
 ..;
 ..; - Build line for detailed report.
 ..I IBRPT="D" D
 ...S IBDOD=$S(+$G(^DPT(IBC,.35)):$$DAT2^IBOUTL(+$G(^(.35))\1),1:"")
 ...S X=$G(^DPT(IBC,0)),IBEBY=$P(IBCDFND,U,2)
 ...S IBVDTE=$S(IBVFLG:$P(IBCDFND,U,3),1:"")
 ...S IBVBY=$S(IBVFLG:$P(IBCDFND,U,4),1:"")
 ...S ^TMP("IBJDI52",$J,IBVFLG,$P(X,U)_$P(IBC1,U,2)_"@@"_$P(X,U,9)_"@@"_IBDOD_"@@"_IBC,IBC2)=$P(IBC3,U)_U_IBEBY_U_$S(+IBCDFND>0:+IBCDFND\1,1:"")_U_IBVBY_U_$S(+IBVDTE>0:IBVDTE\1,1:"")
 ;
 I IBQ G ENQ
 ;
 I $G(IBXTRACT) D E^IBJDE(5,0) G ENQ ; Extract summary data.
 ;
 ; - Print the reports.
 S (IBPAG,IBQ)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 I IBRPT="D" D DET
 I 'IBQ D SUM
 ;
 I 'IBQ D PAUSE
 ;
ENQ K ^TMP("IBJDI51",$J),^TMP("IBJDI52",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBQ,IBBDT,IBEDT,IBRPT,IBD,IBDN,IBPH,IBPM,IBINS,IBPMD,IBPAG,IBRUN,%
 K IBEBY,IBVBY,IBVDTE,IBDOD,IBPER,IBC,IBC1,IBC2,IBC3,IBCDFN,IBVER,IBVFLG
 K IBCDFND,IBX,IBX1,IBX2,IBX3,DFN,POP,X,X1,X2,Y,ZTDESC,ZTRTN,ZTSAVE,%ZIS
 Q
 ;
ENC(IBOED) ; - Encounter extract for outpatient loop.
 ; Input: IBOED = Outpatient encounter in file #409.68
 ;
 D PROC(+$P(IBOED,U,2),"",+IBOED) ; Process patient.
 Q
 ;
PROC(DFN,IBIPC,IBDTE) ; - Process each specific patient.
 ;  Input:   DFN = Pointer to the patient in file #2
 ;         IBIPC = Inpatient treatment marker
 ;                 ("*"=Had inpat. treatment, null=No inpat. treatment)
 ;         IBDTE = Patient's checkout or discharge date
 ;
 I $$TESTP^IBJDI1(DFN) Q  ;       Test patient.
 D ELIG^VADPT I 'VAEL(4) G PRCQ ; Patient is not a vet.
 ;
 ; - Set patient index.
 S ^TMP("IBJDI51",$J,DFN)=IBDTE\1_U_IBIPC
 ;
PRCQ K VA,VAERR,VAEL
 Q
 ;
ENCHK(IBOED) ; - Check outpatient's encounter record.
 ;  Input: IBOED = Outpatient encounter in file #409.68
 ; Output:     1 = OK for processing
 ;             0 = Not OK for processing
 ;
 N X,X1 S Y=0 I '$G(IBOED) G ENCKQ
 ;
 ; - Check if encounter was a registration/cancellation without exam.  
 S X=+$P(IBOED,U,2)
 S X1=+$P($G(^DPT(X,"DIS",+$O(^DPT("ADIS",+IBOED,X,0)),0)),U,7)
 I $D(^DIC(37,"B","CANCEL WITHOUT EXAM",X1)) G ENCKQ
 I $D(^DIC(37,"B","NO CARE OR TREATMENT REQUIRED",X1)) G ENCKQ
 ;
 I "^1^4^7^"[("^"_+$P(IBOED,U,10)_"^") G ENCKQ ; C&P/collat/emply visit.
 I $P(IBOED,U,12)'=2 G ENCKQ ;                   Not checked out.
 ;
 S Y=1
ENCKQ Q Y
 ;
DET ; - Print the detailed report.
 I '$D(^TMP("IBJDI52",$J,0)) S IBX=0 D HDET W !,"All policies within the selected date range have been verified." D PAUSE
 S IBX="" F  S IBX=$O(^TMP("IBJDI52",$J,IBX)) Q:IBX=""  D  Q:IBQ
 .D HDET Q:IBQ
 .S IBX1="" F  S IBX1=$O(^TMP("IBJDI52",$J,IBX,IBX1)) Q:IBX1=""  D  Q:IBQ
 ..I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDET Q:IBQ
 ..W $P(IBX1,"@@"),?33,$$SSN($P(IBX1,"@@",2)),?47,$P(IBX1,"@@",3)
 ..S IBX2=0 F  S IBX2=$O(^TMP("IBJDI52",$J,IBX,IBX1,IBX2)) Q:'IBX2  S IBX3=^(IBX2) D
 ...I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDET Q:IBQ
 ...W ?62,$P(IBX3,U),?94,$E($P($G(^VA(200,+$P(IBX3,U,2),0)),U),1,24)
 ...W ?120,$$DAT2^IBOUTL($P(IBX3,U,3)),!
 ...I IBX W ?94,$E($P($G(^VA(200,+$P(IBX3,U,4),0)),U),1,24),?120,$$DAT2^IBOUTL($P(IBX3,U,5)),!
 .;
 .I 'IBQ D PAUSE
 ;
 I '$D(^TMP("IBJDI52",$J,1)),IBVER S IBX=1 D HDET W !,"All policies within the selected date range have been verified less than a year ago." D PAUSE
 Q
 ;
HDET ; - Write the detail report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !,"Insurance Policies ",$S(IBX:"Verified Over a Year Ago",1:"Not Verified"),?80,"Run Date: ",IBRUN,?123,"Page: ",IBPAG
 W !,"For Patients treated for the period "_$$DAT1^IBOUTL(IBBDT)_" to "_$$DAT1^IBOUTL(IBEDT)_"  ('*' = Had inpatient care)"
 I IBX W !?94,"Policy Entered By         Date Entered"
 W !,"Patient",?33,"SSN",?47,"Date of Death"
 W ?62,"Insurance Company",?94,"Policy ",$S(IBX:"Verified",1:"Entered")," By",?120,"Date ",$S(IBX:"Verif'd",1:"Entered")
 W !,$$DASH(132),!!
 S IBQ=$$STOP^IBOUTL("Insurance Policies Not Verified")
 Q
 ;
SUM ; - Print the summary report.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !!?$S(IBVER:14,1:24),"INSURANCE POLICIES NOT VERIFIED",$S(IBVER:"/VERIFIED OVER 1 YEAR",1:"")
 W !?32,"SUMMARY REPORT",!!?17,"For Patients treated from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?24,"Run Date: ",IBRUN,!?24,$$DASH(31),!!
 ;
 S IBPER=$S('IB("TOT"):0,1:$J(IB("VER")/IB("TOT")*100,0,2))
 W ?24,"Number of Patients Treated:",?53,$J(IB("TOT"),5)
 W !?23,"Number of Policies Verified:",?53,$J(IB("VER"),5),?62,"(",IBPER,"%)"
 I IBVER W !?7,"Number of Policies Verified Over a Year Ago:",?53,$J(IB("VERO"),5),?62,"(",$S('IB("VERO"):0,1:$J(IB("VERO")/IB("TOT")*100,0,2)),"%)"
 W !?19,"Number of Policies Not Verified:",?53,$J(IB("NOT"),5),?62,"(",$S('IB("TOT"):0,1:$J(100-IBPER,0,2)),"%)"
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
SSN(X) ; - Format the SSN.
 Q $S(X]"":$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),1:"")
