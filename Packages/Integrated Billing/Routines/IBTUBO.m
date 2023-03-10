IBTUBO ;ALB/AAS - UNBILLED AMOUNTS - GENERATE UNBILLED REPORTS ;29-SEP-94
 ;;2.0;INTEGRATED BILLING;**19,31,32,91,123,159,192,235,248,155,516,547,608,665**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to 409.1 in ICR #4671
 ; Reference to 8 in ICR #427
 ;
% ; - Entry point for manual option.
 N IBBDT,IBCOMP,IBDET,IBEDT,IBOPT,IBPRT,IBTIMON,IBQUIT,IBSEL,IBSBD
 S (IBQUIT,IBSBD)=0 D:'$D(DT) DT^DICRW
 W !!,"Re-Generate Unbilled Amounts Report",!
 ;
 ; - Ask to re-compile Unbilled Amounts data.
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want to store Unbilled Amounts figures"
 S DIR("?",1)="Enter 'YES' if you wish to store the Unbilled Amounts summary"
 S DIR("?",2)="figures in your system for a specific month/year in the past."
 S DIR("?",3)="Once stored, these figures will be available for inquiry through"
 S DIR("?",4)="the View Unbilled Amounts option [IBT VIEW UNBILLED AMOUNTS]."
 S DIR("?",5)="These summary figures are normally calculated and stored"
 S DIR("?",6)="automatically by the system at the beginning of each month for"
 S DIR("?",7)="the previous month."
 S DIR("?",8)=" "
 S DIR("?",9)="If you enter 'NO', the Unbilled Amounts summary figures will"
 S DIR("?",10)="NOT be stored in your system, and the report may be run for"
 S DIR("?")="any date range."
 D ^DIR K DIR G:$D(DIRUT) END S IBCOMP=Y
 ;
 ; IB*2.0*516 - Added ability to sort by Division
 ;
 K ^TMP($J,"IBTUB"),^TMP($J,"IBTUB-DIV")
 I IBCOMP G RDATE
 ;
 ;IB*2.0*547/TAZ - Add prompt to search by division. If NO bypass all division selection.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Search by Division?"
 S DIR("?",1)=" This opt allows you to search for all unbilled amounts"
 S DIR("?",2)=" or to search for unbilled amounts in only one or more"
 S DIR("?",3)=" divisions."
 S DIR("?",4)=""
 S DIR("?",5)="Choose from:"
 S DIR("?",6)="      N  NO"
 S DIR("?")="      Y  YES"
 D ^DIR K DIR G:$D(DIRUT) END
 S IBSBD=Y I 'IBSBD G DIVX
 ;
DIV ; division
 W !!
 S DIR(0)="SA^A:All Divisions;S:Selected Divisions"
 S DIR("A")="Include All Divisions or Selected Divisions? "
 S DIR("B")="All"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT) Q  ;Timeout or User "^"
 I Y="A" G DIVX
 ;
 W !
 F  D  I IBQUIT S IBQUIT=IBQUIT-1 Q
 . S DIC=40.8,DIC(0)="AEMQ",DIC("A")="   Select Division: "
 . I $O(^TMP($J,"IBTUB-DIV","")) S DIC("A")="   Select Another Division: "
 . D ^DIC K DIC                ; lookup
 . I X="^^" S IBQUIT=2 Q       ; user entered ^^
 . I +Y'>0 S IBQUIT=1 Q        ; user is done
 . S ^TMP($J,"IBTUB-DIV",+Y)=$P(Y,U,2)
 . Q
 ;
 I IBQUIT G END  ;User "^" out of the selection
 ;
 I '$O(^TMP($J,"IBTUB-DIV","")) D  G DIV
 . W *7,!!?3,"No divisions have been selected.  Please try again."
 . Q
 ;
DIVX ; Exit Division selection.
 ;
 ;JRA;IB*2.0*608 Ask to Search by MCCF, Non-MCCF or Both - Start
 N ARTIEN,ARTYP,ELIG,ELIGIEN,LN,X  ;JRA;IB*2*665 Moved up from below and added LN
 ;
 ;JRA;IB*2*665 Set up array of non-MCCF Rate Types
 S ARTIEN="" F  S ARTIEN=$O(^IBE(350.9,1,28,"B",ARTIEN)) Q:'ARTIEN  D
 . S IBMCCF("RTYP",ARTIEN)=$$GET1^DIQ(399.3,ARTIEN_",",.01,"I")
 ;
 W !
 S DIR(0)="SA^M:MCCF;N:Non-MCCF (Outpatient Only);B:Both"
 S DIR("A")="Search by (M)CCF, (N)on-MCCF (Outpatient Only), or (B)oth? "
 S DIR("B")="M"
 S DIR("?",1)="Non-MCCF Eligibilities of Encounter are: 'CHAMPVA', 'INELIGIBLE',"
 S DIR("?",2)=" 'EMPLOYEE', 'TRICARE' and 'SHARING AGREEMENT'."
 S DIR("?",3)="Non-MCCF Appointment Types are: 'EMPLOYEE' and 'SHARING AGREEMENT'."
 ;S DIR("?",4)="Non-MCCF Rate Types are 'CHAMPVA REIMB. INS.', 'CHAMPVA',"  ;JRA;IB*2*665 ';'
 ;S DIR("?",5)=" 'TRICARE REIMB. INS.', 'TRICARE', 'INELIGIBLE' and 'INTERAGENCY'."  ;JRA;IB*2*665 ';'
 S DIR("?",4)="Non-MCCF Rate Types are:"  ;JRA;IB*2*665
 S ARTIEN="",LN=5 F  S ARTIEN=$O(IBMCCF("RTYP",ARTIEN)) Q:ARTIEN=""  D  ;JRA;IB*2*665
 . I $L($G(DIR("?",LN)))+($L(" '"_IBMCCF("RTYP",ARTIEN)_"',"))>80 S DIR("?",LN)=DIR("?",LN)_",",LN=LN+1  ;JRA;IB*2*665
 . S DIR("?",LN)=$S($G(DIR("?",LN))="":" '"_IBMCCF("RTYP",ARTIEN)_"'",1:DIR("?",LN)_", '"_IBMCCF("RTYP",ARTIEN)_"'")  ;JRA;IB*2*665
 S DIR("?",LN)=DIR("?",LN)_"."  ;JRA;IB*2*665
 S DIR("?")="All other Eligibilities/Types are MCCF."
 D ^DIR K DIR G:($D(DIROUT)!($D(DIRUT))) END
 S IBMCCF=Y
 ;Set up arrays of Non-MCCF Rate Types, Non-MCCF Appointment Types and Non-MCCF Eligibility of Encounter entries.
 ;N ARTIEN,ARTYP,ELIG,ELIGIEN,X  ;JRA;IB*2*665 ';'
 ;F ARTYP="INTERAGENCY","CHAMPVA REIMB. INS.","CHAMPVA","TRICARE REIMB. INS.","TRICARE","INELIGIBLE" D  ;Non-MCCF Rate Types  ;JRA;IB*2*665 ';'
 ;. S ARTIEN=$O(^DGCR(399.3,"B",ARTYP,"")) I +ARTIEN S IBMCCF("RTYP",ARTIEN)=""  ;JRA;IB*2*665 ';'
 F ARTYP="EMPLOYEE","SHARING AGREEMENT" D  ;Non-MCCF Appointment Types
 . ;DBIA4671 for following FIND^DIC
 . K ^TMP("DILIST",$J) D FIND^DIC(409.1,,"@;.01","X",ARTYP) I $D(^TMP("DILIST",$J,2))>1 D
 . . S X=0 F  S X=$O(^TMP("DILIST",$J,2,X)) Q:'X  S ARTIEN=^TMP("DILIST",$J,2,X) S:+ARTIEN IBMCCF("ATYP",ARTIEN)=""
 F ELIG="CHAMPVA","INELIGIBLE","EMPLOYEE","TRICARE","SHARING AGREEMENT" D  ;Non-MCCF "Eligibility of Encounter" Entries
 . ;DBIA427 for following FIND^DIC
 . K ^TMP("DILIST",$J) D FIND^DIC(8,,"@;.01","X",ELIG) I $D(^TMP("DILIST",$J,2))>1 D
 . . S X=0 F  S X=$O(^TMP("DILIST",$J,2,X)) Q:'X  S ELIGIEN=^TMP("DILIST",$J,2,X) S:+ELIGIEN IBMCCF("ELIG",ELIGIEN)=""
 ;JRA;IB*2.0*608 - End
 ;
 ; - Select date(s) to build report.
 W ! D DT1^IBTUBOU G:IBBDT="^" END
 ;
 ; - Select report(s).
 S IBPRT="Choose report type(s) to print:"
 ;S IBOPT(1)="INPATIENT UNBILLED"  ;JRA;IB*2.0*608 ';'
 ;S IBOPT(2)="OUTPATIENT UNBILLED"  ;JRA;IB*2.0*608 ';'
 ;S IBOPT(3)="PRESCRIPTION UNBILLED"  ;JRA;IB*2.0*608 ';'
 ;S IBOPT(4)="ALL OF THE ABOVE"  ;JRA;IB*2.0*608 ';'
 I $G(IBMCCF)="N" S IBOPT(1)="OUTPATIENT UNBILLED"  ;JRA;IB*2.0*608
 E  D  ;JRA;IB*2.0*608
 . S IBOPT(1)="INPATIENT UNBILLED"
 . S IBOPT(2)="OUTPATIENT UNBILLED"
 . S IBOPT(3)="PRESCRIPTION UNBILLED"
 . S IBOPT(4)="ALL OF THE ABOVE"
 ;S IBSEL=$$MLTP^IBJD(IBPRT,.IBOPT,1) I 'IBSEL G END  ;JRA;IB*2.0*608 ';'
 S IBSEL=$$MLTP^IBJD(IBPRT,.IBOPT,$S($G(IBMCCF)="N":"",1:1)) I 'IBSEL G END  ;JRA;IB*2.0*608
 ;JRA;IB*2.0*608 For Non-MCCF set IBSEL="2," since the value of IBSEL drives the computations and '2' is for Outpatient.
 ; Since "OUTPATIENT UNBILLED" is the only choice for Non-MCCF, IBSEL will be set to '1,' so need to reset to '2,'.
 S:$G(IBMCCF)="N" IBSEL="2,"  ;JRA;IB*2.0*608
 S $E(IBSEL,$L(IBSEL))=""
 ;
RDATE ; - Select re-compile date, if necessary.
 I IBCOMP D  G END:IBTIMON="^",DET
 . W ! D DT2("Unbilled Amounts") Q:IBTIMON="^"
 . W !!,"NOTE: Just a reminder that by entering the above month/year this"
 . W !,"      report will re-calculate and update the Unbilled Amounts"
 . W !,"      data on file in your system.",*7
 . ;
 . ; - Initialize variables
 . I IBTIMON<3030900 N X S X=$$M2^IBJDE(IBTIMON,11,11) D 
 .. S IBBDT=+X,IBEDT=$P(X,U,2)+.9,IBSEL="1,2,3"
 . I IBTIMON'<3030900 S IBBDT=$$M3^IBJDE($$LDATE^IBJDE(IBTIMON)+1),IBEDT=$$LDATE^IBJDE(IBTIMON)+.9,IBSEL="1,2,3"
 . D MSG W !
 ;
 S IBTIMON=IBEDT\100*100
 ;
DET ; - Ask to print detail report.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Print detail report with the Unbilled Amounts summary"
 S DIR("?",1)="Answer YES if you want a detailed listing of the patients"
 S DIR("?",2)="and events that are unbilled. Answer NO if you just want"
 S DIR("?")="the summary, or '^' to quit this option."
 D ^DIR K DIR G:$D(DIRUT) END S IBDET=Y G:'IBDET QUE
 ;
 ; Ask to include REQUEST MRA Status
 S DIR(0)="YA",DIR("A")="Do you want to include MRA claims?: ",DIR("B")="NO" W ! D ^DIR K DIR G:$D(DIRUT) END
 S IBINMRA=+Y
 ;
 ;IB*2.0*547/TAZ - Add prompt to sort by Patient or Divsion if Division Search was selected.
 I $G(IBSBD) D  G:$D(DIRUT) END
 . S DIR("A")="Sort by: ",DIR("B")="Patient Name" W !
 . S DIR(0)="SA^N:PATIENT NAME;D:DIVISION^S:X="""" X=""N"""
 . S DIR("?",1)=" This determines whether the unbilled amounts are displayed"
 . S DIR("?",2)=" in alphabetical order of patient name or in alphabetical "
 . S DIR("?")=" order of patient name within a division."
 . D ^DIR K DIR
 . S IBSBD=Y="D" ;IBSBD=0 - Sort by Patient Name, IBSBD=1, Sort by Patient Name within Division.
 ;
 ; - Select device to print.
 W !!,"This report takes a while to run, so you should queue it to run"
 W !,"after normal business hours."
 W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G END:POP,QUE:$D(IO("Q"))
 ;
 U IO G STR
 ;
QUE ; - Queue report/summary, if necessary.
 W ! I 'IBDET S ZTIO=""
 S ZTRTN="IBTUBOA",ZTSAVE("IB*")=""
 S ZTDESC="IB - Unbilled Amounts Report"
 D ^%ZTLOAD K IO("Q"),ZTSK
 D HOME^%ZIS G END
 ;
AUTO ; - Entry point for scheduled option.
 Q  ;;**NO LONGER USED**
 ;
DQ ; - Entry point for DM extract.
 ; - If AUTO PRINT UNBILLED LIST=yes and default report printer then
 ;   automatically requeue to device.
 I $P(^IBE(350.9,1,6),U,24) D  G END:'$G(IBXTRACT)
 . N X S X=$O(^IBE(353,"B","IB REPORTS",0))
 . S ZTIO=$P($G(^IBE(353,+X,0)),U,2) Q:ZTIO=""
 . S IBDET=1,IBXTRACT=0,ZTDTH=$H,ZTRTN="IBTUBOA",ZTSAVE("IB*")=""
 . S ZTDESC="IB - Unbilled Amounts Report" D ^%ZTLOAD
 . S IBDET=0,IBXTRACT=1
 . K ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 ;
STR D ^IBTUBOA ; Start report.
 ;
END K DIRUT,IBMCCF Q  ;JRA IB*2.0*608 Added IBMCCF
 ;
MSG ; - Compile message.
 W !!,"NOTE: After this report is run, the Unbilled Amounts totals for"
 W !?6,"the month of "_$$DAT2^IBOUTL(IBTIMON)_" will be updated."
 Q
 ;
DT2(STR) ; - Select re-compile date (returns variable IBTIMON).
 ; Input: STR - String that describe the type of data that will be 
 ;        re-compiled: "Unbilled Amounts", "Average Bill Amounts", etc...
 ;
 ; This code is very the same code as is in DT2^IBTUBOU... that is
 ; a utility routine, so code was copied and altered to accommodate
 ; EOAM changes. 
 N DIRUT,DT0,DT1,DT2,Y
 ; - AUG 1993 is the first month on file with Unbilled Amounts data
 S DT0=2930800,DT1=$$DAT2^IBOUTL(DT0)
 I $E(DT,6,7)'>$E($$LDATE^IBJDE(DT),6,7) S DT2=DT
 I $E(DT,6,7)>$E($$LDATE^IBJDE(DT),6,7) S DT2=DT+100 I $E(DT2,4,5)=13 S DT2=DT+8900
 S DT2=$$M1^IBJDE(DT2,1),DIR("B")=$$DAT2^IBOUTL(DT2)
 S DIR(0)="DA^"_$E(DT0,1,5)_"00:"_DT2_":AE^K:$E(Y,6,7)'=""00"" X"
 S DIR("A")="Re-compile "_$G(STR)_" through MONTH/YEAR: "
 S DIR("?",1)="Enter a past month/year (ex. Oct 2000).",DIR("?",2)=""
 S DIR("?",3)="NOTE: The earliest month/year that can be entered is "_DT1_", and"
 S DIR("?")="      it is NOT possible to enter the current or a future month/year."
 D ^DIR K DIR I $D(DIRUT) S IBTIMON="^" G DT2Q
 I $E(Y,6,7)'="00"!($E(Y,4,7)="0000") W "  ??" G DT2
 S IBTIMON=Y
 ;
DT2Q Q
