IBJDI6 ;ALB/CPM - SC VETS W/ NSC EPISODES OF INPT CARE ; 18-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,83,98,100**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
 W !!,"This report provides a number of the NSC inpatient episodes for SC veterans"
 W !,"which have and have not been billed.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD I IBRPT["^" G ENQ
 ;
 W !!,"This report only requires an 80 column printer."
 ;
 W !!,"Note: This report may take a while to run."
 W !?6,"You should queue this report to run after normal business hours.",!
 ;
 ; - Select a device.
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDI6",ZTDESC="IB - SC VETS W/ NSC EPISODES"
 .F I="IBBDT","IBEDT","IBRPT" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(6,1) ; Change extract status.
 ;
 K IB,^TMP("IBJDI6",$J)
 S IBQ=0 F X="NSC","NSCB","NSCR","NSCU","SC","TOT" S IB(X)=0
 F X=0:1:3 S IB("NSCU",X)=0
 ;
 ; - Find data required for the report.
 S IBD=IBBDT-.01 F  S IBD=$O(^DGPM("ATT3",IBD)) Q:'IBD!(IBD\1>IBEDT)  D  Q:IBQ
 .S IBPM=0 F  S IBPM=$O(^DGPM("ATT3",IBD,IBPM)) Q:'IBPM  D  Q:IBQ
 ..I IBPM#100=0 S IBQ=$$STOP^IBOUTL("SC Vets w/NSC Episodes") Q:IBQ
 ..S IBPMD=$G(^DGPM(IBPM,0)) Q:'IBPMD
 ..S DFN=+$P(IBPMD,U,3) Q:'DFN
 ..I $$TESTP^IBJDI1(DFN) Q  ; Test patient.
 ..S IBDIS=+IBPMD\1
 ..;
 ..; - Patient must be insured, and SC.
 ..I '$$INSURED^IBCNS1(DFN,IBDIS) Q
 ..D ELIG^VADPT Q:'VAEL(3)
 ..;
 ..; - Set 'totals' accumulator.
 ..S IB("TOT")=IB("TOT")+1
 ..;
 ..; - See if associated PTF record has NSC movements.
 ..S IBADMD=$G(^DGPM(+$P(IBPMD,U,14),0))
 ..S IBPTF=+$P(IBADMD,U,16),IBSTAT=$P($G(^DGPT(IBPTF,0)),U,6)
 ..I '$$PTF(IBPTF) S IB("SC")=IB("SC")+1 Q
 ..S IB("NSC")=IB("NSC")+1
 ..;
 ..; - See if there is a claim for the NSC episode.
 ..S IBADM=+IBADMD\1
 ..I $$BILL(IBPTF,DFN,IBADM,IBDIS) S IB("NSCB")=IB("NSCB")+1 Q
 ..;
 ..; - Has episode been flagged as non-billable?
 ..S IBCT=$O(^IBT(356,"AD",+$P(IBPMD,U,14),0))
 ..I IBCT,$P($G(^IBT(356,IBCT,0)),U,19) S IB("NSCR")=IB("NSCR")+1 Q
 ..;
 ..S IB("NSCU")=IB("NSCU")+1
 ..S IB("NSCU",IBSTAT)=IB("NSCU",IBSTAT)+1
 ..I IBRPT="D" D
 ...S X=$G(^DPT(DFN,0))
 ...S ^TMP("IBJDI6",$J,$P(X,U)_"@@"_DFN)=$P(X,U,9)
 ...S ^TMP("IBJDI6",$J,$P(X,U)_"@@"_DFN,IBADM)=$S(IBSTAT=0:"OPEN",IBSTAT=1:"CLOSED",IBSTAT=2:"RELEASED",1:"TRANSMITTED")_U_IBDIS
 ;
 I IBQ G ENQ
 ;
 I $G(IBXTRACT) D E^IBJDE(6,0) G ENQ ; Extract summary data.
 ;
 ; - Print the reports.
 S (IBPAG,IBQ)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 I IBRPT="D" D DET
 I 'IBQ D SUM
 ;
 I 'IBQ D PAUSE
 ;
ENQ K ^TMP("IBJDI6",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBQ,IBBDT,IBEDT,IBRPT,IBD,IBDN,IBPAG,IBRUN,IBX,IBX1,IBX2
 K IBADM,IBDIS,IBCT,IBH,IBPER,IBPM,IBPMD,IBPMDT,IBPTF,IBSTAT,IBADMD
 K %,%ZIS,DFN,POP,VA,VAERR,VAEL,X,Y,ZTDESC,ZTRTN,ZTSAVE
 Q
 ;
DET ; - Print the detailed report.
 D HDET Q:IBQ
 I '$D(^TMP("IBJDI6",$J)) D  G DETQ
 .I IB("NSC") W !!,"All NSC episodes for SC veterans in the selected date range have been billed." Q
 .W !!,"There were no NSC episodes found in the selected date range."
 ;
 S IBX="" F  S IBX=$O(^TMP("IBJDI6",$J,IBX)) Q:IBX=""  S IBX1=^(IBX) D  Q:IBQ
 .S (IBH,IBADM)=0 F  S IBADM=$O(^TMP("IBJDI6",$J,IBX,IBADM)) Q:'IBADM  S IBX2=^(IBADM) D  Q:IBQ
 ..I $Y>(IOSL-2) D PAUSE Q:IBQ  D HDET Q:IBQ  S IBH=0
 ..W ! I 'IBH D PAT S IBH=1
 ..W ?46,$P(IBX2,U),?59,$$DAT1^IBOUTL(IBADM),?69,$$DAT1^IBOUTL($P(IBX2,U,2))
 ;
DETQ I 'IBQ D PAUSE
 Q
 ;
PAT ; - Write the patient information.
 W $P(IBX,"@@"),?32,$$SSN(IBX1)
 Q
 ;
HDET ; - Write the detail report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !,"Insured SC Vets w/ Unbilled NSC Care",?38,"Run Date: ",IBRUN,?70,"Page: ",IBPAG
 W !,"For Patients discharged in the period "_$$DAT1^IBOUTL(IBBDT)_" to "_$$DAT1^IBOUTL(IBEDT)
 W !,"Patient",?32,"SSN",?46,"PTF Status",?59,"Adm Date",?69,"Disc Date"
 W !,$$DASH(80)
 S IBQ=$$STOP^IBOUTL("SC Vets w/NSC Episodes")
 Q
 ;
SUM ; - Print the summary report.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !!?13,"INSURED SC VETERANS W/ UNBILLED NSC INPATIENT EPISODES"
 W !?33,"SUMMARY REPORT"
 W !!?16,"For Patients discharged from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?24,"Run Date: ",IBRUN,!?24,$$DASH(31),!!
 ;
 S IBPER(1)=$S('IB("TOT"):0,1:$J(IB("SC")/IB("TOT")*100,0,2))
 S IBPER(2)=$S('IB("NSC"):0,1:$J(IB("NSCB")/IB("NSC")*100,0,2))
 S IBPER(3)=$S('IB("NSC"):0,1:$J(IB("NSCR")/IB("NSC")*100,0,2))
 W ?9,"Number of Discharges of Insured SC Veterans:",?54,$J(IB("TOT"),4)
 W !?5,"Discharges Which were totally Service-Connected:",?54,$J(IB("SC"),4),?62,"(",IBPER(1),"%)"
 W !,"Discharges Which included Non-Service Connected Care:",?54,$J(IB("NSC"),4),?62,"(",$J($S('IB("TOT"):0,1:100-IBPER(1)),0,2),"%)"
 W !?10,"Number of NSC Discharges Which were Billed:",?54,$J(IB("NSCB"),4),?62,"(",IBPER(2),"%)"
 W !?4,"Number of NSC Discharges Flagged as Non-Billable:",?54,$J(IB("NSCR"),4),?62,"(",IBPER(3),"%)"
 W !?19,"Number of Unbilled NSC Discharges:",?54,$J(IB("NSCU"),4),?62,"(",$J($S('IB("NSC"):0,1:100-IBPER(2)-IBPER(3)),0,2),"%)",!?54,"----"
 F X=0:1:3 D
 .I X=0 W !,"Unbilled NSC Discharges w/ PTF Status of"
 .W ?41,$S(X=0:"Open",X=1:"Closed",X=2:"Released",1:"Transmitted"),":",?54,$J(IB("NSCU",X),4),?62,"(",$J($S('IB("NSCU",X):0,1:IB("NSCU",X)/IB("NSCU")*100),0,2),"%)",!
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
 ;
PTF(IBPTF) ; - Does the PTF record have an NSC-related movement?
 ;  Input: IBPTF = Pointer to the PTF record in file #45
 ; Output: IBNSC = 1 (NSC movement) or 0 (No NSC movement)
 ;
 N IBNSC,X,Y
 S (IBNSC,X)=0
 I '$G(IBPTF) G PTFQ
 ;
 ; - Check PTF movements for a movement not related to SC care.
 F  S X=$O(^DGPT(IBPTF,"M",X)) Q:'X  S Y=$P($G(^(X,0)),U,18) I Y'=1 S IBNSC=1 Q
 ;
PTFQ Q IBNSC
 ;
BILL(IBPTF,DFN,IBADM,IBDIS) ; - Has this episode of care been billed?
 ;  Input: IBPTF = Pointer to the PTF record in file #45
 ;           DFN = Pointer to the patient in file #2
 ;         IBADM = Episode admission date
 ;         IBDIS = Episode discharge date
 ; Output:  BILL = 1 (Episode has been billed)
 ;                 0 (Episode has not been billed)
 ;
 N BILL,X,X1,XU,Y
 S BILL=0
 ;
 ; - See if there is a claim based on the PTF record.
 I $G(IBPTF) D  G:BILL BILLQ
 .S X=0 F  S X=$O(^DGCR(399,"APTF",IBPTF,X)) Q:'X  S Y=$P($G(^DGCR(399,X,0)),U,13) I Y,Y<7 S BILL=1 Q
 ;
 ; - Check other inpatient bills for care provided in the adm/dis period.
 S X=0 F  S X=$O(^DGCR(399,"C",+$G(DFN),X)) Q:'X  D  Q:BILL
 .S X1=$G(^DGCR(399,X,0)),XU=$G(^("U")) Q:X1=""
 .I $P(X1,U,5)>2 Q  ;                     Outpatient care.
 .I $P(X1,U,13)=7 Q  ;                    Bill is cancelled.
 .I +XU\1<IBADM!($P(XU,U,2)\1>IBEDT) Q  ; Care outside of range.
 .S BILL=1
 ;
BILLQ Q BILL
