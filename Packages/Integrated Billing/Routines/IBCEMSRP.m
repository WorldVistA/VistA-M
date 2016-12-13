IBCEMSRP ;ALB/VAD - IB PRINTED CLAIMS REPORT ;09-SEP-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; access to ^DG(40.8 allowed with DBIA#417
 ;
EN ;
 N IBQ,IBCOT,IBDIVS,IBBDT,IBEDT,IBSORT
 S IBQ=0 ; quit flag
 ; Prompts to the user:
 D COT Q:IBQ  ; (C)PAC or (T)RICARE/CHAMPVA
 D DIVS Q:IBQ  ; Division(s)
 D DTR Q:IBQ  ; From-To date range
 D SORTBY Q:IBQ  ; Sort By?
 W !!,"Report requires 132 Columns"
 D DEVICE Q:IBQ
 D RUN
 Q
 ;
COT N DIR,DIRUT,Y
 W ! S DIR(0)="SAO^C:(C)PAC;T:(T)RICARE/CHAMPVA"
 S DIR("A")="RUN for (C)PAC or (T)RICARE/CHAMPVA: ",DIR("B")="C" D ^DIR
 I $D(DIRUT) S IBQ=1 Q
 S IBCOT=Y
 Q
 ;
DIVS N DIC,DIR,DIRUT,Y,X,IBDIV,IBDVN
 W ! S DIR("B")="ALL",DIR("A")="Run this report for All divisions or Selected Divisions: "
 S DIR(0)="SA^ALL:All divisions;S:Selected divisions" D ^DIR
 I $D(DIRUT) S IBQ=1 Q
 ; if user selects all divisions, gather names and iens (DBIA#417)
 I X="ALL" S IBDIVS("ALL")=1 D  Q
 .S IBDIVS(0)="UNKNOWN"  ; older claims may not have a division
 .S IBDIV="" F  S IBDIV=$O(^DG(40.8,"B",IBDIV)) Q:IBDIV=""  D
 ..S IBDVN="" F  S IBDVN=$O(^DG(40.8,"B",IBDIV,IBDVN)) Q:'IBDVN  D
 ...S IBDIVS(+IBDVN)=IBDIV
 ; Collect divisions
 F  D  Q:Y'>0
 . W ! S DIC("A")="Division: ",DIC=40.8,DIC(0)="AEQM" D ^DIC
 . I $D(DIRUT) S IBQ=1 Q
 . I Y'>0 Q
 . S IBDIVS(+Y)=$P(Y,U,2)
 I '$D(IBDIVS)  S IBQ=1 Q  ; None selected
 Q
 ;
DTR ;date range
 N %DT,Y
 S IBBDT=DT-7,IBEDT=DT
 S %DT="AEX"
 S %DT("A")="Earliest Printed Date: ",%DT("B")="T-7"
 W ! D ^%DT K %DT
 I Y<0 S IBQ=1 Q
 S IBBDT=+Y
 S %DT="AEX"
 S %DT("A")="Latest Printed Date: ",%DT("B")="T"
 D ^%DT K %DT
 I Y<0 S IBQ=1 Q
 S IBEDT=+Y
 Q
 ;
SORTBY ;
 N DIR,DTOUT,DUOUT
 S DIR(0)="SBMA^I:Insurance Company;B:Authorizing Biller;R:Rate Type;F:Form Type;P:Type of Plan"
 S DIR("A")="Sort Report By: ",DIR("B")="Authorizing Biller"
 S DIR("?")=" ",DIR("?",1)="This determines the criteria by which the claims will"
 S DIR("?",2)="be displayed." D ^DIR K DIR
 Q:$D(DTOUT)!($D(DUOUT))
 S IBSORT=Y_U_$G(Y(0))
 Q
 ;
DEVICE ; Get the Output Device.
 N %ZIS,ZTRTN,ZTDESC,ZTSAVE,POP
 K IO("Q")
 S %ZIS="QM" W ! D ^%ZIS I POP S IBQ=1 Q
 ;
 I $D(IO("Q")) D  S IBQ=1 Q
 . S ZTRTN="RUN^IBCEMSRP",ZTDESC="IB PRINTED CLAIMS REPORT"
 . S ZTSAVE("IBBDT")="",ZTSAVE("IBEDT")="",ZTSAVE("IBCOT")="",ZTSAVE("IBSORT")="",ZTSAVE("IBDIVS(")=""
 . D ^%ZTLOAD
 . D HOME^%ZIS
 Q
 ;
RUN ; Begin the execution of the report.
 D SRCH^IBCEMSR6  ; Search, Sort and Store the data based upon the criteria that was entered by the user.
 U IO
 D REPORT^IBCEMSR7    ; Print the report from the formatted array.
 Q
 ;
