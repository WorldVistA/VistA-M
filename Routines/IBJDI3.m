IBJDI3 ;ALB/CPM - NO EMPLOYER LISTING ; 17-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,91,98,100,118,123**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
 W !!,"This report provides a measure of the number of veteran patients who"
 W !,"have been identified as being employed, but have no employer on file.",!
 ;
DATE D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 ; - Sort by division?
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D DHLP^IBJDI3"
 S DIR("A")="Do you wish to sort this report by division" W !
 D ^DIR S IBSORT=+Y I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G ENQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 I IBSORT D PSDR^IBODIV G:Y<0 ENQ ; Select division(s).
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD I IBRPT["^" G ENQ
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
 .S ZTRTN="DQ^IBJDI3",ZTDESC="IB - NO EMPLOYER LISTING"
 .F I="IB*","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued. The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 I $G(IBXTRACT) D E^IBJDE(3,1) ; Change extract status.
 ;
 N IBQUERY,IBQUERY1
 K IB,^TMP("IBJDI31",$J),^TMP("IBJDI32",$J)
 S IBC="DEC^NO^OK^TOT",IBQ=0
 I IBSORT D  G INP
 .S I=0 F  S I=$S(VAUTD:$O(^DG(40.8,I)),1:$O(VAUTD(I))) Q:'I  D
 ..S J=$P($G(^DG(40.8,I,0)),U) F K=1:1:4 S IB(J,$P(IBC,U,K))=0
 S IBDIV="ALL" F I=1:1:4 S IB("ALL",$P(IBC,U,I))=0
 ;
INP ; - Find inpatients treated within the user-specified date range.
 S IBD=IBBDT-.01 F  S IBD=$O(^DGPM("ATT3",IBD)) Q:'IBD!(IBD\1>IBEDT)  D  Q:IBQ
 .S IBPM=0 F  S IBPM=$O(^DGPM("ATT3",IBD,IBPM)) Q:'IBPM  D  Q:IBQ
 ..I IBPM#100=0 S IBQ=$$STOP^IBOUTL("No Employer Listing") Q:IBQ
 ..S IBPMD=$G(^DGPM(IBPM,0)) Q:'IBPMD  S DFN=+$P(IBPMD,U,3) Q:'DFN
 ..I IBSORT S IBDIV=$$DIV^IBJDI21(1,+$P(IBPMD,U,6)) Q:'$D(IB(IBDIV))
 ..;
 ..; - Process patient.
 ..I '$D(^TMP("IBJDI31",$J,DFN)) D PROC(DFN,"*",.IBQUERY)
 ;
 D CLOSE^IBSDU(.IBQUERY) I IBQ G ENQ
 ;
 ; - Find outpatients treated within the user-specified date range.
 D OUTPT^IBJDI21("",IBBDT,IBEDT,"S:IBQ SDSTOP=1 I 'IBQ,$$ENCHK^IBJDI5(Y0) D ENC^IBJDI3(Y0,.IBQUERY1)","No Employer Listing",.IBQ,"IBJDI31",.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY),CLOSE^IBSDU(.IBQUERY1) I IBQ G ENQ
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D  G ENQ
 .F X="DEC","NO","OK","TOT" S IB(X)=$G(IB("ALL",X))
 .D E^IBJDE(3,0)
 ;
 ; - Print the reports.
 S (IBQ,IBPAG)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 S IBDIV="" F  S IBDIV=$O(IB(IBDIV)) Q:IBDIV=""  D  Q:IBQ
 . D:IBRPT="D" DET I 'IBQ D SUM,PAUSE
 ;
ENQ K ^TMP("IBJDI31",$J),^TMP("IBJDI32",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBQ,IBBDT,IBEDT,IBRPT,IBC,IBD,IBDN,IBPAG,IBRUN,IBX,IBPER,IBEMP
 K IBDIV,IBDOD,IBSORT,IBLT,IBDT,IBES,IBDTF,IBPAT,IBXX,IBOE,IBOED,IBPM,IBPMD
 K VAUTD,DFN,POP,I,J,K,X,X1,X2,Y,%,%ZIS,ZTDESC,ZTRTN,ZTSAVE
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 Q
 ;
ENC(IBOED,IBQUERY1) ; - Encounter extract.
 ; IBQUERY1 = the # of the QUERY to use to do the extract.
 ; Pre-set variables IB array, IBSORT also required.
 ;
 S DFN=+$P(IBOED,U,2) I 'DFN Q
 I IBSORT S IBDIV=$$DIV^IBJDI21(0,+$P(IBOED,U,11)) Q:'$D(IB(IBDIV))
 D PROC(DFN,"",.IBQUERY1) ; Process patient.
 Q
 ;
PROC(DFN,IBIPC,IBQUERY) ; - Process each specific patient.
 ; Input:     DFN = Pointer to the patient in file #2
 ;          IBIPC = Inpatient treatment marker
 ;                  ("*"=Had inpat. treatment, null=No inpat. treatment)
 ;        IBQUERY = The # of the QUERY OBJECT to be used to extract
 ;                  outpatient visits.  Be sure to close the query object
 ;                  when done
 ;
 ; Pre-set variables IB array, IBBDT, IBEDT, IBDIV, IBSORT are required.
 ;
 I $$TESTP^IBJDI1(DFN) Q  ;     Test patient.
 D ELIG^VADPT G:'VAEL(4) PRCQ ; Patient is not a vet.
 ;
 ; - Check if patient is deceased; get date of death.
 S IBDOD=$S(+$G(^DPT(DFN,.35)):^(.35)\1,1:"")
 I IBDOD S IB(IBDIV,"DEC")=IB(IBDIV,"DEC")+1
 ;
 ; - Set patient index and 'total patients' accumulator.
 S ^TMP("IBJDI31",$J,DFN)="",IB(IBDIV,"TOT")=IB(IBDIV,"TOT")+1
 ;
 S IBDN=$G(^DPT(DFN,0)),IBEMP=$G(^(.311)),IBES=$P(IBEMP,U,15)
 ;
 ; - Empl. status is null/unknown, employed (full/part), or retired
 ;   AND no employer is specified.
 I $P(IBEMP,U)="",(IBES=""!("^1^2^5^9^"[("^"_IBES_"^"))) D  G PRCQ
 .S IB(IBDIV,"NO")=IB(IBDIV,"NO")+1 I IBRPT="D" D SET(.IBQUERY)
 S IB(IBDIV,"OK")=IB(IBDIV,"OK")+1
 ;
PRCQ K VA,VAERR,VAEL
 Q
 ;
SET(IBQUERY) ; - Set up detailed information for pts to appear on the report.
 ; Input: IBQUERY = The # of the QUERY OBJECT to be used to extract
 ;                  outpatient visits
 ;
 ; Pre-set variable IBDIV is reqiured.
 ;
 ; - Find last treatment date (LTD).
 S (IBDT,IBLT)=0 F  S IBDT=$O(^DGPM("ATID3",DFN,IBDT)) Q:+IBDT=0  D
 .S IBDTF=9999999.9999999-IBDT\1
 .S:IBDTF>IBLT IBLT=IBDTF Q:IBDTF<IBBDT!(IBDTF>IBEDT)
 ;
 ; - Look through outpatient encounters.
 D OUTPT^IBJDI21(DFN,IBBDT,IBEDT,"S IBOED=Y0,IBDT=+IBOED,IBDTF=IBDT\1 S:IBDTF>IBLT IBLT=IBDTF","","","",.IBQUERY)
 ;
 ; - If current inpatient, set LTD to today.
 I $G(^DPT(DFN,.105)) S IBLT=DT
 ;
SETC S ^TMP("IBJDI32",$J,IBDIV,$P(IBDN,U)_IBIPC_"@@"_DFN)=$P(IBDN,U,9)_U_IBES_U_IBLT_U_IBDOD
 Q
 ;
DIV(X) ; - Return division name.
 Q $P($G(^DG(40.8,X,0)),U)
 ;
DET ; - Print the detailed report.
 D HDET Q:IBQ
 I '$D(^TMP("IBJDI32",$J,IBDIV)) W !!,"There were no patients treated in this date range missing an employer." G DETQ
 ;
 S IBXX="" F  S IBXX=$O(^TMP("IBJDI32",$J,IBDIV,IBXX)) Q:IBXX=""  S IBX=^(IBXX) D  Q:IBQ
 .I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDET Q:IBQ
 .W !,$P(IBXX,"@@"),?34,$$SSN($P(IBX,U))
 .S X=$$EXPAND^IBJD(2,.31115,$P(IBX,U,2)) W ?50,$S(X="":"UNANSWERED",1:X)
 .W ?72,$$DAT2^IBOUTL($P(IBX,U,3)),?90,$$DAT2^IBOUTL($P(IBX,U,4))
 ;
DETQ I 'IBQ D PAUSE
 Q
 ;
HDET ; - Write the detail report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W "No Employer Listing",$S(IBDIV'="ALL":" for "_IBDIV,1:""),?80,"Run Date: ",IBRUN,?123,"Page: ",IBPAG
 W !,"Patients without an employer treated in the period ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)," ('*' = Had inpatient care)"
 W !,"Patient",?34,"SSN",?50,"Employment Status",?72,"Last Trmt Date",?90,"Date of Death"
 W !,$$DASH(132),!
 S IBQ=$$STOP^IBOUTL("No Employer Listing")
 Q
 ;
SUM ; - Print the summary report.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !!?30,"NO EMPLOYER LISTING",?71,"Page: ",IBPAG,!
 I IBDIV'="ALL" W ?(61-$L(IBDIV))\2,"SUMMARY REPORT for ",IBDIV
 E  W ?33,"SUMMARY REPORT"
 W !!?19,"Patients treated from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?24,"Run Date: ",IBRUN,!?17,$$DASH(45),!!
 ;
 S IBPER=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"NO")/IB(IBDIV,"TOT")*100),0,2)
 W ?24,"Number of Patients Treated:",?53,$J(IB(IBDIV,"TOT"),5)
 W !?23,"Number of Deceased Patients:",?53,$J(IB(IBDIV,"DEC"),5),?62,"(",$J($S('IB(IBDIV,"DEC"):0,1:IB(IBDIV,"DEC")/IB(IBDIV,"TOT")*100),0,2),"%)"
 W !?3,"Number of Patients Employed without an Employer:",?53,$J(IB(IBDIV,"NO"),5),$S(IB(IBDIV,"NO"):"*",1:""),?62,"(",IBPER,"%)"
 W !," Number of Patients Unemployed or with an Employer:",?53,$J(IB(IBDIV,"OK"),5),?62,"(",$J($S('IBPER:0,1:100-IBPER),0,2),"%)"
 I IB(IBDIV,"NO") D
 .W !!!!!?2,"*This is the total number of veterans who have no employer on file, but"
 .W !,?3,"have an employment status of Full-Time, Part-Time, Retired, Unknown or",!?3,"null."
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
DHLP ; - 'Sort by division' prompt.
 W !!,"Select: '<CR>' to print the trend report without regard to"
 W !?15,"division"
 W !?11,"'Y' to select those divisions for which a separate"
 W !?15,"trend report should be created",!?11,"'^' to quit"
 Q
