IBCOMN1 ;ALB/CMS - PATIENTS NO COVERAGE VERIFIED REPORT (CON'T);10-09-98
 ;;2.0;INTEGRATED BILLING;**103,528,602,743**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
BEG ; Entry to run Patients w/no Coverage Verification Report
 ; Input variables:
 ; IBAIB - Required.    How to sort
 ;         1= Patient Name Range      2= Terminal Digit Range
 ;
 ; IBRF  - Required.  Name or Terminal Digit Range Start value
 ; IBRL  - Required.  Name or Terminal Digit Range Go to value
 ; IBBDT - Required.  Begining Verification Date Range
 ; IBEDT - Required.  Ending Verification Date Range
 ; IBOUT - Required.  Output format
 ;         "R"= report format        "E"= Excel format
 ;
 N DFN,IBDT,IBGP,IBI,IBQUIT,IBPAGE,IBTMP,IBTD,IBX,VA,VADM,VAERR,X,Y
 ;
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 K ^TMP("IBCOMN",$J) S IBPAGE=0,IBQUIT=0
 S IBDT=IBBDT F  S IBDT=$O(^IBA(354,"AVDT",IBDT)) Q:('IBDT)!(IBDT>IBEDT)  D
 .S DFN=0 F  S DFN=$O(^IBA(354,"AVDT",IBDT,DFN)) Q:'DFN  D
 ..K VA,VADM,VAERR,VAPA
 ..D DEM^VADPT,ADD^VADPT
 ..;
 ..;  I Pt. name out of range quit
 ..S VADM(1)=$P($G(VADM(1)),U,1) I VADM(1)="" Q
 ..I IBAIB=1,VADM(1)]IBRL Q
 ..I IBAIB=1,IBRF]VADM(1) Q
 ..;
 ..;  I Terminal Digit out of range quit
 ..I IBAIB=2 S IBTD=$$TERMDG^IBCONS2(DFN) I (+IBTD>IBRL)!(IBRF>+IBTD) Q
 ..;
 ..; Fix subscript error if terminal digit is null
 ..I IBAIB=2,IBTD="" S IBTD=" "
 ..;
 ..;   set data line, set global * if deceased
 ..;S IBTMP=PT NAME^SSN^AGE^DOB^HOME PHONE^VERIFICATION NO COV
 ..S IBTMP=$S($G(VADM(6)):"*",1:"")_VADM(1)_U_$P($P(VADM(2),U,2),"-",3)_U_+VADM(4)_U_$$FMTE^XLFDT(VADM(3),"5ZD")_U_$P(VAPA(8),U,1)_U_$$FMTE^XLFDT(IBDT,"5ZD")
 ..S ^TMP("IBCOMN",$J,$S(IBAIB=2:IBTD,1:VADM(1)),DFN)=IBTMP
 ..;
 ;
 I '$D(^TMP("IBCOMN",$J)) D HD W !!,"** NO RECORDS FOUND **" D ASK G QUEQ
 D HD,WRT
 ;
QUEQ ; Exit clean-UP
 W ! D ^%ZISC K IBTMP,IBAIB,IBOUT,IBRF,IBRL,VA,VAERR,VADM,VAPA,^TMP("IBCOMN",$J)
 Q
 ;
HD ;Write Heading
 S IBPAGE=IBPAGE+1
 ; IB*602/HN ; Add report headers to Excel Spreadsheets 
 I IBOUT="E" D  W:($E(IOST,1,2)["C-") ! W "Patient Name^SSN^Age^DOB^Phone^Verified" Q
 .W !,"Patients w/No Coverage Verification Date Report^"_$$FMTE^XLFDT($$NOW^XLFDT,"Z")
 .W !,"Verification Date Range: "_$$FMTE^XLFDT(IBBDT,"Z")_" to "_$$FMTE^XLFDT(IBEDT,"Z")
 .W !," Sorted by: "_$S(IBAIB=1:"Patient Name",1:"Terminal Digit")_" Range: "_$S(IBRF="":"FIRST",1:IBRF)_" to "_$S(IBRL="zzzzzz":"LAST",1:IBRL)
 .W !,"(* - Patient Deceased)"
 ; IB*602/HN end 
 I IBOUT="E" W:($E(IOST,1,2)["C-") ! W "Patient Name^SSN^Age^DOB^Phone^Verified" Q
 W @IOF,!,"Patients w/No Coverage Verification Date Report",?50,$$FMTE^XLFDT($$NOW^XLFDT,"Z"),?70," Page ",IBPAGE
 W !,?5,"Verification Date Range: "_$$FMTE^XLFDT(IBBDT,"Z")_" to "_$$FMTE^XLFDT(IBEDT,"Z")
 ;IB*743/TAZ - Modified Check of IBRF
 ;W !,?5,"  Sorted by: "_$S(IBAIB=1:"Patient Name",1:"Terminal Digit")_"  Range: "_$S(IBRF="A":"FIRST",1:IBRF)_" to "_$S(IBRL="zzzzzz":"LAST",1:IBRL)
 W !,?5,"  Sorted by: "_$S(IBAIB=1:"Patient Name",1:"Terminal Digit")_"  Range: "_$S(IBRF="":"FIRST",1:IBRF)_" to "_$S(IBRL="zzzzzz":"LAST",1:IBRL)
 W !,?20,"(*  - Patient Deceased)"
 W !,"Patient Name",?31,"SSN",?38,"Age",?43,"DOB",?55,"Phone",?70,"Verified"
 W ! F IBX=1:1:79 W "="
 Q
 ;
WRT ;Write data lines
 N IBA,IBDFN,IBPT,X,Y S IBQUIT=0
 S IBA="" F  S IBA=$O(^TMP("IBCOMN",$J,IBA)) Q:(IBA="")!(IBQUIT=1)  D
 .S IBDFN=0 F  S IBDFN=$O(^TMP("IBCOMN",$J,IBA,IBDFN)) Q:('IBDFN)!(IBQUIT=1)  D
 ..S IBPT=$G(^TMP("IBCOMN",$J,IBA,IBDFN))
 ..;
 ..I ($Y+5)>IOSL,(IBOUT="R") D  I IBQUIT=1 Q
 ...D ASK I IBQUIT=1 Q
 ...D HD
 ..;
 ..; Excel Output
 ..I IBOUT="E" W !,$P(IBPT,U,1)_U_$E($P(IBPT,U,1),1,1)_$P(IBPT,U,2)_U_$P(IBPT,U,3,6) Q
 ..; Report Output
 ..W !,$E($P(IBPT,U,1),1,30),?31,$E($P(IBPT,U,1),1,1),$P(IBPT,U,2),?38,$J($P(IBPT,U,3),3),?43,$P(IBPT,U,4),?55,$E($P(IBPT,U,5),1,15),?70,$P(IBPT,U,6)
 ..;
 I 'IBQUIT D ASK
 Q
 ;
ASK ; Ask to Continue with display
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBQUIT=1
 Q
