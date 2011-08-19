IBJDI41 ;ALB/CPM - PATIENTS WITH UNIDENTIFIED INSURANCE (CONT'D) ; 17-DEC-96
 ;;2.0;INTEGRATED BILLING;**98,100,118**;21-MAR-94
 ;
EN ; - Entry point from IBJDI4.
 ;
 ; - Find inpatients treated within the user-specified date range.
 S IBD=IBBDT-.01 F  S IBD=$O(^DGPM("ATT3",IBD)) Q:'IBD!(IBD\1>IBEDT)  D  Q:IBQ
 .S IBPM=0 F  S IBPM=$O(^DGPM("ATT3",IBD,IBPM)) Q:'IBPM  D  Q:IBQ
 ..I IBPM#100=0 S IBQ=$$STOP^IBOUTL("Patients with Unidentified Insurance Report") Q:IBQ
 ..S IBPMD=$G(^DGPM(IBPM,0)) I 'IBPMD Q
 ..I IBSORT S IBDIV=$$DIV^IBJDI21(1,+$P(IBPMD,U,6)) Q:'$D(IB(IBDIV))
 ..S DFN=+$P(IBPMD,U,3) Q:'DFN
 ..;
 ..; - Process patient.
 ..I '$D(^TMP("IBJDI41",$J,DFN)) D PROC(DFN,IBD\1,"*")
 ;
 I IBQ G ENQ
 ;
 ; - Find outpatients treated within the user-specified date range.
 D CLOSE^IBSDU(.IBQUERY)
 D OUTPT^IBJDI21("",IBBDT,IBEDT,"S:IBQ SDSTOP=1 I 'IBQ,$$ENCHK^IBJDI5(Y0) D ENC^IBJDI41(Y0)","Patients with Unidentified Insurance Report",.IBQ,"IBJDI41",.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY)
 ;
 I IBQ G ENQ
 ;
 I IBRPT'="D" G PRT
 ;
 ; - Find data required for the report.
 S DFN=0 F  S DFN=$O(^TMP("IBJDI41",$J,DFN)) Q:'DFN  S IBX=^(DFN) D  Q:IBQ
 .I IBSEL=0,$P(IBX,U,4)'="*" Q
 .I DFN#100=0 S IBQ=$$STOP^IBOUTL("Patients with Unidentified Insurance Report") Q:IBQ
 .;
 .; - Set patient eligibilities for report.
 .D ELIG^VADPT S IBELIG=+$G(VAEL(1))_";"
 .I +IBELIG>0 S X=0 F  S X=$O(VAEL(1,X)) Q:'X  S IBELIG=IBELIG_X_";"
 .;
 .; - Set up detailed information to appear on the report.
 .S IBDN=$G(^DPT(DFN,0)),IBPAT=$P(IBDN,U)_$P(IBX,U,2)
 .S IBPH=$P($G(^DPT(DFN,.13)),U,1,2),IBSEL1=$P(IBX,U,3)
 .S IBDOD=$S(+$G(^DPT(DFN,.35)):$$DAT1^IBOUTL(+$G(^(.35))\1),1:"")
 .F X=1:1 S X1=$P(IBSEL1,",",X) Q:X1=""  D
 ..S ^TMP("IBJDI42",$J,$P(IBX,U),X1,IBPAT_"@@"_DFN)=$P(IBDN,U,9)_U_$P(IBPH,U)_U_$P(IBPH,U,2)_U_$S(+IBELIG>0:IBELIG,1:"")_U_$P(IBX,U,4)_U_IBDOD_U_$S(IBRMK:$P(IBDN,U,10),1:"")
 .;
 .K VA,VAEL,VAERR
 ;
 I IBQ G ENQ
 ;
PRT ; - Print the reports.
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D  G ENQ
 .F X="BILL","DEC","HMO","IND","MEDC","MEDG","NO","NULL","TOT","UNK","YES" S IB(X)=$G(IB("ALL",X))
 .D E^IBJDE(4,0)
 ;
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 S IBDIV="" F  S IBDIV=$O(IB(IBDIV)) Q:IBDIV=""  D  Q:IBQ
 .I IBRPT="D" D DET
 .I 'IBQ D SUM,PAUSE
 ;
ENQ Q
 ;
ENC(IBOED) ; - Encounter extract for all patients loop.
 ; Input: IBOED = Outpatient encounter in file #409.68
 ; Pre-set variables IB array, IBSORT also required.
 ;
 I IBSORT S IBDIV=$$DIV^IBJDI21(0,+$P(IBOED,U,11)) Q:'$D(IB(IBDIV))
 D PROC(+$P(IBOED,U,2),+IBOED\1,"") ; Process patient.
 Q
 ;
PROC(DFN,IBINDT,IBIPC) ; - Process each specific patient.
 ; Input:    DFN = Pointer to the patient in file #2
 ;        IBINDT = Encounter or discharge date
 ;         IBIPC = Inpatient treatment marker
 ;                 ("*"=Had inpat. treatment, null=No inpat. treatment)
 ;
 ; Pre-set variables IB array, IBDIV, IBRPT, IBSEL also required.
 ;
 I $$TESTP^IBJDI1(DFN) Q  ;      Test patient.
 D ELIG^VADPT I 'VAEL(4) G PRCQ ; Patient is not a vet.
 ;
 ; - Find 'Covered by Insurance' indicator and set flags.
 S IBINSC="",IBSEL1=$S(IBSEL=0:"0,",1:""),IBX=$P($G(^DPT(DFN,.31)),U,11)
 I IBX="Y"!(IBX="N") D
 .I IBX="Y" D
 ..S IB(IBDIV,"YES")=IB(IBDIV,"YES")+1 S:IBSEL[1 IBSEL1=IBSEL1_"1,"
 .E  S IB(IBDIV,"NO")=IB(IBDIV,"NO")+1 S:IBSEL[7 IBSEL1=IBSEL1_"7,"
 .;
 .S (IBOUTP,IBWNR)=1 D ^IBCNS Q:'IBINS  F X=0:1:4 S IBFL(X)=0
 .S X=0 F  S X=$O(IBDD(X)) Q:'X  D
 ..I IBRPT="D",IBSEL'=0 S IBINSC=IBINSC_X_";"
 ..I $P($G(^DIC(36,X,0)),U,2)'="N",'IBFL(0) D
 ...S IB(IBDIV,"BILL")=IB(IBDIV,"BILL")+1,IBFL(0)=1
 ...I IBSEL[2 S IBSEL1=IBSEL1_"2,"
 ..S IBTYP=$$TYPE^IBJDI4(IBDD(X))
 ..I IBTYP=1,'IBFL(1) D
 ...S IB(IBDIV,"HMO")=IB(IBDIV,"HMO")+1,IBFL(1)=1
 ...I IBSEL[3 S IBSEL1=IBSEL1_"3,"
 ..I IBTYP=2,'IBFL(2) D
 ...S IB(IBDIV,"MEDC")=IB(IBDIV,"MEDC")+1,IBFL(2)=1
 ...I IBSEL[4 S IBSEL1=IBSEL1_"4,"
 ..I IBTYP=3,'IBFL(3) D
 ...S IB(IBDIV,"MEDG")=IB(IBDIV,"MEDG")+1,IBFL(3)=1
 ...I IBSEL[5 S IBSEL1=IBSEL1_"5,"
 ..I IBTYP=4,'IBFL(4) D
 ...S IB(IBDIV,"IND")=IB(IBDIV,"IND")+1,IBFL(4)=1
 ...I IBSEL[6 S IBSEL1=IBSEL1_"6,"
 I IBX="U" D
 .S IB(IBDIV,"UNK")=IB(IBDIV,"UNK")+1 S:IBSEL[8 IBSEL1=IBSEL1_"8,"
 I IBX="" D
 .S IB(IBDIV,"NULL")=IB(IBDIV,"NULL")+1 S:IBSEL[9 IBSEL1=IBSEL1_"9,"
 I IBRPT="D",IBSEL=0,(IBX="U"!(IBX="")) S IBINSC="*"
 ;
 ; - Set patient index and 'total patients' accumulator.
 S ^TMP("IBJDI41",$J,DFN)=IBDIV_U_$S(IBRPT="D":IBIPC_U_IBSEL1_U_IBINSC,1:"")
 S IB(IBDIV,"TOT")=IB(IBDIV,"TOT")+1
 I +$G(^DPT(DFN,.35)) S IB(IBDIV,"DEC")=IB(IBDIV,"DEC")+1 ; Deceased.
 ;
PRCQ K IBDD,IBFL,IBINS,IBINSC,IBOUTP,IBTYP,IBWNR,IBX,VA,VAERR,VAEL,X
 Q
 ;
DIV(X) ; - Return division name.
 S Y=$P($G(^DG(40.8,X,0)),U) I Y="" S Y=0
 Q Y
 ;
DET ; - Print the detailed report.
 I IBSEL=0,'$D(^TMP("IBJDI42",$J,IBDIV,0)) S IBX=0 D HDET W !!,"There were no ",$$TITLE^IBJDI4(0)," during this period." G DETQ
 I IBSEL'=0 F X=1:1 S IBX=$P(IBSEL,",",X) Q:IBX=""  D
 .I '$D(^TMP("IBJDI42",$J,IBDIV,IBX)) S IBPAG=0 D HDET W !!,"There were no ",$$TITLE^IBJDI4(IBX)," during this period."
 ;
 S IBX="" F  S IBX=$O(^TMP("IBJDI42",$J,IBDIV,IBX)) Q:IBX=""  D  Q:IBQ
 .S IBPAG=0 D HDET Q:IBQ
 .S IBX1="" F  S IBX1=$O(^TMP("IBJDI42",$J,IBDIV,IBX,IBX1)) Q:IBX1=""  S IBX2=^(IBX1) D  Q:IBQ
 ..I $Y>(IOSL-3) D PAUSE Q:IBQ  D HDET Q:IBQ
 ..W $P(IBX1,"@@"),?27,$$SSN($P(IBX2,U)),?41,$E($P(IBX2,U,2),1,15),?58,$P(IBX2,U,3)
 ..S IBELIG=$P(IBX2,U,4) W ?80,$$ELIG(+IBELIG)
 ..S IBINSC=$P(IBX2,U,5) W ?102,$$INSC(+IBINSC),?124,$P(IBX2,U,6),!
 ..I IBRMK,$P(IBX2,U,7)]"" W ?2,"Remarks: ",$P(IBX2,U,7)
 ..I '$P(IBELIG,";",2),'$P(IBINSC,";",2),$P(IBX2,U,7)]"" W ! Q
 ..F X=2:1 Q:'$P(IBELIG,";",X)&('$P(IBINSC,";",X))  D
 ...W ?80,$$ELIG($P(IBELIG,";",X)),?102,$$INSC($P(IBINSC,";",X)),!
 ;
DETQ I 'IBQ D PAUSE
 Q
 ;
HDET ; - Write the detail report header.
 W @IOF,*13 S IBPAG=$G(IBPAG)+1
 W !,$$TITLE^IBJDI4(IBX),$S(IBDIV'="ALL":" for "_IBDIV,1:""),?80,"Run Date: ",IBRUN,?123,"Page: ",IBPAG
 W !,"Patients treated in the period "_$$DAT1^IBOUTL(IBBDT)_" to "_$$DAT1^IBOUTL(IBEDT),"   NOTE: *=Had inpatient care, +=Billable insurance"
 W !!?45,"Home",?62,"Work",?124,"Date of"
 W !,"Patient",?27,"SSN",?41,"Phone Number",?58,"Phone Number",?80,"Eligibility",?102,"Insurance",?125,"Death"
 W !,$$DASH(132),!!
 S IBQ=$$STOP^IBOUTL("Patients with Unidentified Insurance Report")
 Q
 ;
SUM ; - Print the summary report.
 W @IOF,*13 S IBPAG=$G(IBPAG)+1
 W !!?26,"PATIENT INSURANCE STATISTICS",!
 I IBDIV'="ALL" W ?(61-$L(IBDIV))\2,"SUMMARY REPORT for ",IBDIV
 E  W ?33,"SUMMARY REPORT"
 W !!?19,"Patients treated from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?24,"Run Date: ",IBRUN,!?20,$$DASH(40),!!
 ;
 S IBPER(1)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"YES")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(2)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"BILL")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(3)=$J($S('IB(IBDIV,"YES"):0,1:IB(IBDIV,"BILL")/IB(IBDIV,"YES")*100),0,2)
 S IBPER(4)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"HMO")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(5)=$J($S('IB(IBDIV,"YES"):0,1:IB(IBDIV,"HMO")/IB(IBDIV,"YES")*100),0,2)
 S IBPER(6)=$J($S('IB(IBDIV,"BILL"):0,1:IB(IBDIV,"HMO")/IB(IBDIV,"BILL")*100),0,2)
 S IBPER(7)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"MEDC")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(8)=$J($S('IB(IBDIV,"YES"):0,1:IB(IBDIV,"MEDC")/IB(IBDIV,"YES")*100),0,2)
 S IBPER(9)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"MEDG")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(10)=$J($S('IB(IBDIV,"YES"):0,1:IB(IBDIV,"MEDG")/IB(IBDIV,"YES")*100),0,2)
 S IBPER(11)=$J($S('IB(IBDIV,"BILL"):0,1:IB(IBDIV,"MEDG")/IB(IBDIV,"BILL")*100),0,2)
 S IBPER(12)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"IND")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(13)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"NO")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(14)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"UNK")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(15)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"NULL")/IB(IBDIV,"TOT")*100),0,2)
 S IBPER(16)=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"DEC")/IB(IBDIV,"TOT")*100),0,2)
 W ?22,"Number of Patients Treated:",?50,$J(IB(IBDIV,"TOT"),5)
 W !?9,"Number of Patients Covered by Insurance:",?50,$J(IB(IBDIV,"YES"),5)," (",IBPER(1),"%)"
 W !?3,"No. of Patients Covered by Billable Insurance:",?50,$J(IB(IBDIV,"BILL"),5)," (",IBPER(2),"%-",IBPER(3),"%)*"
 W !?12,"Number of Patients Covered by an HMO:",?50,$J(IB(IBDIV,"HMO"),5)," (",IBPER(4),"%-",IBPER(5),"%-",IBPER(6),"%)**"
 W !?10,"Number of Patients Covered by Medicare:",?50,$J(IB(IBDIV,"MEDC"),5)," (",IBPER(7),"%-",IBPER(8),"%)*"
 W !?11,"Number of Patients Covered by Medigap:",?50,$J(IB(IBDIV,"MEDG"),5)," (",IBPER(9),"%-",IBPER(10),"%-",IBPER(11),"%)**"
 W !?2,"No. of Patients Covered by an Indemnity Policy:",?50,$J(IB(IBDIV,"IND"),5)," (",IBPER(12),"%)"
 W !?5,"Number of Patients Not Covered by Insurance:",?50,$J(IB(IBDIV,"NO"),5)," (",IBPER(13),"%)"
 W !?7,"Number of Patients with Unknown Insurance:",?50,$J(IB(IBDIV,"UNK"),5)," (",IBPER(14),"%)"
 W !," No. of Patients w/Insurance Question Unanswered:",?50,$J(IB(IBDIV,"NULL"),5)," (",IBPER(15),"%)"
 W !?21,"Number of Deceased Patients:",?50,$J(IB(IBDIV,"DEC"),5)," (",IBPER(16),"%)"
 W !!," *(% from patients treated-% from patients with insurance)"
 W !,"**(% from patients treated-% from patients w/ins-% from patients w/billable ins)"
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
ELIG(X) ; - Return eligibility code name.
 Q $E($P($G(^DIC(8,+X,0)),U),1,20)
 ;
INSC(X) ; - Return insurance company.
 S X=$G(^DIC(36,+X,0))
 Q $E($P(X,U),1,20)_$S($P(X,U,2)["Y"!($P(X,U,2)["*"):"+",1:"")
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
