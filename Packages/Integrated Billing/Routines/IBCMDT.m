IBCMDT ;ALB/VD - INSURANCE PLANS MISSING DATA REPORT (DRIVER) ; 10-APR-15
 ;;2.0;INTEGRATED BILLING ;**549**; 10-APR-15;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB - Insurance Plans Missing Data Report.
 ;
 ;Input parameters: N/A
 ;
 ;Other relevant variables:
 ; ZTSAVED for queuing
 ;
 ; IBMDTSPC("FLTRS") n where n is the number of filters selected
 ; IBMDTSPC("IBAI")  0 = user selected insurance companies.
 ;                   1 = all insurance companies w/plans.
 ;
 ; IBMDTSPC("IBAPL") 0 = user selected plans (may be ALL for certain companies, some for other companies).
 ;                   1 = all plans for the insurance companies (all or selected).
 ;
 ; IBMDTSPC("IBGRN") 0 = ignore Missing Group Number filter.
 ;                   1 = include Missing Group Number filter.
 ;
 ; IBMDTSPC("IBPTY") 0 = ignore Missing Type of Plan filter.
 ;                   1 = include Missing Type of Plan filter.
 ;
 ; IBMDTSPC("IBTFT") 0 = ignore Missing Timely Filing Time Frame filter.
 ;                   1 = include Missing Timely Filing Time Frame filter.
 ;
 ; IBMDTSPC("IBEPT") 0 = ignore Missing Electronic Plan Type filter.
 ;                   1 = include Missing Electronic Plan Type filter.
 ;
 ; IBMDTSPC("IBCLM") 0 = ignore Missing Coverage Limitation filter.
 ;                   1 = include Missing Coverage Limitation filter.
 ;
 ; IBMDTSPC("IBBIN") 0 = ignore Missing BIN (Banking Identification Number) filter.
 ;                   1 = include Missing BIN (Banking Identification Number) filter.
 ;
 ; IBMDTSPC("IBPCN") 0 = ignore Missing PCN (Processor Control Number) filter.
 ;                   1 = include Missing PCN (Processor Control Number) filter.
 ; IBMDTSPC("IBNMSPC") = $J of the parent job (if queued)
 ;
EN ; Main Entry point.
 ; Initialize variables.
 N IBAI,IBMDTSPC,POP,STOP
 ;
C0 ; Start the Insurance Company Prompts.
 K IBMDTSPC,^TMP("IBCMDT",$J),^TMP($J,"IBSEL")
 S STOP=0,IBMDTSPC("IBNMSPC")=$J
 ;
 W @IOF
 W !!?5,"This report will generate a list of ACTIVE insurance companies"
 W !?5,"that are missing the data that you select to be reported upon.",!!
 ;
 ; Select Insurance Companies or All Insurance Companies w/Plans
C10 D SLAI^IBCMDT1 I STOP G:$$STOP EXIT G C0
 N IBQUIT S IBQUIT=0
 S IBAI=+$G(IBMDTSPC("IBAI"))
 D START
 I IBQUIT G EXIT
 I '$D(^TMP("IBCMDT",$J)) W !!,"No plans selected!" G EXIT
 ;
FILTERS ; Begin the Filtering Questions.
 ;
 N STOP
F0 ; Start of Filters.
 S (IBMDTSPC("FLTRS"),STOP)=0
 S IBMDTSPC("SUBHD")="Missing Data: "
 ; Filter on Missing Group Number
F10 D SLGRN^IBCMDT1
 I STOP G:$$STOP EXIT G C0
 I +IBMDTSPC("IBGRN") D
 . S IBMDTSPC("SUBHD")=IBMDTSPC("SUBHD")_"Group #"
 . S IBMDTSPC("FLTRS")=IBMDTSPC("FLTRS")+1
 ;
 ; Filter on Missing Type of Plan
F20 D SLPTY^IBCMDT1
 I STOP G:$$STOP EXIT G F10
 I +IBMDTSPC("IBPTY") D
 . S IBMDTSPC("SUBHD")=$G(IBMDTSPC("SUBHD"))_$S(+IBMDTSPC("FLTRS"):", ",1:"")_"Plan Type"
 . S IBMDTSPC("FLTRS")=IBMDTSPC("FLTRS")+1
 ;
 ; Filter on Missing Timely Filing Time Frame
F30 D SLTFT^IBCMDT1
 I STOP G:$$STOP EXIT G F20
 I +IBMDTSPC("IBTFT") D
 . S IBMDTSPC("SUBHD")=$G(IBMDTSPC("SUBHD"))_$S(+IBMDTSPC("FLTRS"):", ",1:"")_"FTF"
 . S IBMDTSPC("FLTRS")=IBMDTSPC("FLTRS")+1
 ;
 ; Filter on Missing Electronic Plan Type
F40 D SLEPT^IBCMDT1
 I STOP G:$$STOP EXIT G F30
 I +IBMDTSPC("IBEPT") D
 . S IBMDTSPC("SUBHD")=$G(IBMDTSPC("SUBHD"))_$S(+IBMDTSPC("FLTRS"):", ",1:"")_"Elec Plan"
 . S IBMDTSPC("FLTRS")=IBMDTSPC("FLTRS")+1
 ;
 ; Filter on Missing Coverage Limitations
F50 D SLCLM^IBCMDT1
 I STOP G:$$STOP EXIT G F40
 I +IBMDTSPC("IBCLM") S IBMDTSPC("FLTRS")=IBMDTSPC("FLTRS")+1
 ;
 ; Filter on Missing BIN (Banking Identification Number)
F60 D SLBIN^IBCMDT1
 I STOP G:$$STOP EXIT G F50
 I +IBMDTSPC("IBBIN") D
 . S IBMDTSPC("SUBHD")=$G(IBMDTSPC("SUBHD"))_$S(+IBMDTSPC("FLTRS"):", ",1:"")_"BIN"
 . S IBMDTSPC("FLTRS")=IBMDTSPC("FLTRS")+1
 ;
 ; Filter on Missing PCN (Processor Control Number)
F70 D SLPCN^IBCMDT1
 I STOP G:$$STOP EXIT G F60
 I +IBMDTSPC("IBPCN") D
 . S IBMDTSPC("SUBHD")=$G(IBMDTSPC("SUBHD"))_$S(+IBMDTSPC("FLTRS"):", ",1:"")_"PCN"
 . S IBMDTSPC("FLTRS")=IBMDTSPC("FLTRS")+1
 ;
 I '+IBMDTSPC("FLTRS") D  G:$D(DUOUT) EXIT G FILTERS
 . W !!,"** No Filters were selected **"   ; No Filters were selected so quit.
 . D PAUSE^VALM1
 I +IBMDTSPC("IBCLM") D
 . S IBMDTSPC("SUBHD")=$G(IBMDTSPC("SUBHD"))_$S((+IBMDTSPC("FLTRS")>1):", ",1:"")
 . S IBMDTSPC("SUBHD")=IBMDTSPC("SUBHD")_"Coverage Limitations"
 ;
F100 D DEVICE(.IBMDTSPC)
 I STOP G:$$STOP EXIT G F0
 G EXIT
 ;
EXIT ; Exit point
 Q
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Initialize Variables
 N DIR,DIRUT,X,Y
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)=" Enter YES to immediately exit out of this option."
 S DIR("?")=" Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
STOPX ; STOP Exit Point
 Q Y
 ;
START ; Gather the Insurance Companies and respective Plans
 I 'IBAI D GTSEL,GTPLNS G STARTQ
 D GTALL,GTPLNS
 G STARTQ
 ;
GTSEL ; Gather plans for all selected companies.
 N IBCNS,IBIC
 S (IBCT,IBQUIT)=0
 K ^TMP("IBCMDT",$J),^TMP($J,"IBSEL")
 ;
 ; Allow user selection of Insurance Companies, if required
 D EN^IBCNILK(1)  ; Only want Active Insurance Companies
 I '$D(^TMP("IBCNILKA",$J)) S IBQUIT=1 Q  ; No Insurance Companies selected
 S IBCNS=""
 F  S IBCNS=$O(^TMP("IBCNILKA",$J,IBCNS)) Q:IBCNS=""  D
 . ; Insurance Company Name
 . S IBIC=$E($$GET1^DIQ(36,IBCNS_",",.01),1,25)
 . S ^TMP("IBCMDT",$J,IBIC,IBCNS)=""
 K ^TMP("IBCNILKA",$J)
 Q
 ;
GTALL ; - gather all companies if required
 N IBCNS,IBIC1
 K ^TMP("IBCMDT",$J),^TMP($J,"IBSEL")
 S IBIC1=""
 F  S IBIC1=$O(^DIC(36,"B",IBIC1)) Q:IBIC1=""  D
 . S IBCNS=0
 . F  S IBCNS=$O(^DIC(36,"B",IBIC1,IBCNS)) Q:'IBCNS  D
 . . I +$$GET1^DIQ(36,IBCNS_",",.05,"I") Q  ; Inactive
 . . S ^TMP("IBCMDT",$J,$E(IBIC1,1,25),IBCNS)=""
 Q
 ;
GTPLNS ; - gather plans for selected companies
 N IBCNS,IBIC,IBP
 S IBIC=""
 F  S IBIC=$O(^TMP("IBCMDT",$J,IBIC)) Q:IBIC=""!IBQUIT  D
 . S IBCNS=""
 . F  S IBCNS=$O(^TMP("IBCMDT",$J,IBIC,IBCNS)) Q:IBCNS=""!(IBQUIT)  D
 . . S IBP=0
 . . F  S IBP=$O(^IBA(355.3,"B",+IBCNS,IBP)) Q:'IBP  D
 . . . S ^TMP("IBCMDT",$J,IBIC,IBCNS,IBP)=""   ; Set plans into the array.
 Q
 ;
STARTQ ;
 K IBCNS,IBIC,IBCT,IBP,IBSEL,^TMP($J,"IBSEL")
 Q
 ;
DEVICE(IBMDTSPC) ; Device Handler and possible TaskManager calls
 ; Input:   IBMDTSPC    - Array passed by reference of the report parameters
 ;                        See top of routine for a detailed explanation
 ;
 N I,POP,ZTDESC,ZTRTN,ZTSAVE
 W *7,!!!?14,"*** WARNING ***"
 W !?2,"This report may take a little while to compile!"
 W !!?2,"This report is 132 characters wide."
 W !?2,"Please choose an appropriate device.",!
 S ZTRTN="COMPILE^IBCMDT(.IBMDTSPC)"
 S ZTDESC="IB - INSURANCE PLANS MISSING DATA REPORT"
 S ZTSAVE("IBMDTSPC(")=""
 S ZTSAVE("^TMP(""IBCMDT"",$J,")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S STOP=1
DEVICEX ; DEVICE Exit Point
 Q
 ;
COMPILE(IBMDTSPC) ;
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input:   IBMDTSPC    - Array passed by reference of the report parameters
 ;                        See top of routine for a detailed explanation
 ;
 N FLTRS,IBAI,IBAPL,IBBIN,IBCLM,IBEPT,IBGRN,IBNMSPC,IBPCN,IBPTY,IBTFT,SUBHD
 S FLTRS=$G(IBMDTSPC("FLTRS"))
 S IBAI=$G(IBMDTSPC("IBAI"))
 S IBAPL=$G(IBMDTSPC("IBAPL"))
 S IBGRN=$G(IBMDTSPC("IBGRN"))
 S IBPTY=$G(IBMDTSPC("IBPTY"))
 S IBTFT=$G(IBMDTSPC("IBTFT"))
 S IBEPT=$G(IBMDTSPC("IBEPT"))
 S IBCLM=$G(IBMDTSPC("IBCLM"))
 S IBBIN=$G(IBMDTSPC("IBBIN"))
 S IBNMSPC=$G(IBMDTSPC("IBNMSPC"))
 S IBPCN=$G(IBMDTSPC("IBPCN"))
 S SUBHD=$G(IBMDTSPC("SUBHD"))
 ;
 ; Compile
 D EN^IBCMDT2
 ; Print
 D EN^IBCMDT3
 ;
COMPILX ; COMPILE Exit Point
 Q
