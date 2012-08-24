IBCEMSR2  ;BI/ALB - non-MRA PRODUCTIVITY REPORT ;02/14/11
 ;;2.0;INTEGRATED BILLING;**447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN  ; Main Routine Entry Point
 N IBQ,IBDIV,IBBDT,IBEDT,IBSUM,IBSCR,IBPAGE,POP
 S IBPAGE=0
 N IBLTMPH        ; Report Header Information
 N IBLTMP         ; Data Collection Array
 W !!,"Report requires 132 Columns"
 S IBQ=0          ; quit flag
 ; Prompts to the user:
 D DIV Q:IBQ      ; Division(s)
 D SUM Q:IBQ      ; Summary or Full Report
 D DTR Q:IBQ      ; From-To date range
 D DEVICE Q:IBQ   ; Print to device
 K ^TMP($J,"IBCEMSR2") ; Clear the temporary accumulator
 D RUN Q:IBQ      ; Run Report
 K ^TMP($J,"IBCEMSR2") ; Clear the temporary accumulator
 Q
 ;
DIV  ; Collect Division(s)
 N DIC,DIR,DIRUT,X,Y
 W ! S DIR("B")="ALL",DIR("A")="Run this report for All divisions or Selected Divisions: "
 S DIR(0)="SA^ALL:All divisions;S:Selected divisions" D ^DIR
 I $D(DIRUT) S IBQ=1 Q
 S IBDIV=Y Q:Y="ALL"
 ; Collect divisions
 F  D  Q:Y'>0
 . W ! S DIC("A")="Division: ",DIC=40.8,DIC(0)="AEQM" D ^DIC
 . I $D(DIRUT) S IBQ=1 Q
 . I Y'>0 Q
 . S IBDIV(+Y)=""
 I $O(IBDIV(""))=""  S IBQ=1 Q  ; None selected
 Q
 ;
DTR  ; Get Date Range
 N %DT,Y,X,IBIDT              ; Local subroutine variables.
 S IBBDT=$$FMADD^XLFDT(DT,-7) ; Earliest date set in stack for global routine use.
 S IBEDT=DT                   ; Latest date set in stack for global routine use.
 ;
 ; Don't allow the user to go back earlier than patch install date.
 S X=$$INSTALDT^XPDUTL("IB*2.0*447",.IBIDT)
 I X=0 W !!,"This report can't be run before installing patch IB*2.0*447.",! S IBQ=1 Q
 S IBIDT=$P($S(X:$O(IBIDT("")),1:DT),".",1)
 I IBBDT<IBIDT S IBBDT=IBIDT
DTR1  ; Return for invalid "Earliest EOB Receipt Date"
 S %DT="AEX"
 S %DT("A")="Earliest EOB Receipt Date:  "
 S %DT("B")=$$FMTE^XLFDT(IBBDT)
 W ! D ^%DT K %DT
 I Y<0 S IBQ=1 Q
 I +Y<IBIDT D  G DTR1
 . W !!,"The Earliest EOB Receipt Date can't be before ",$$FMTE^XLFDT(IBIDT),!
 I +Y>DT D  G DTR1
 . W !!,"Future Dates are not allowed.",!
 S IBBDT=+Y
DTR2  ; Return for invalid "Latest EOB Receipt Date"
 S %DT="AEX"
 S %DT("A")="Latest EOB Receipt Date: "
 S %DT("B")=$$FMTE^XLFDT(DT)
 D ^%DT K %DT
 I Y<0 S IBQ=1 Q
 S IBEDT=+Y
 I IBEDT<IBBDT D  G DTR2
 . W !!,"The Latest EOB Receipt Date can't be before ",$$FMTE^XLFDT(IBBDT),!
 I +Y>DT D  G DTR2
 . W !!,"Future Dates are not allowed.",!
 W !!
 Q
 ;
SUM  ; Ask if printing a Summary or Full report.
 N DIR,DIRUT,X,Y
 W ! S DIR("B")="Summary",DIR("A")="Print a Summary or a Full report? "
 S DIR(0)="SA^S:Summary;F:Full" D ^DIR
 I $D(DIRUT) S IBQ=1 Q
 S IBSUM=Y
 Q
 ;
DEVICE  ; Request Device Information
 N %ZIS,IOP,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 K IO("Q")
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S IBQ=1 Q
 S IBSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S IBQ=1
 . S ZTRTN="RUN^IBCEMSR2"
 . S ZTIO=ION
 . S ZTSAVE("IB*")=""
 . S ZTDESC="IB NON-MRA PRODUCTIVITY REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q
 ;
RUN  ; Run Report
 U IO
 D COLLECT        ; Collect the data in Local Array "IBLTMP"
 D REPORT
 I 'IBSCR W !,@IOF
 D ^%ZISC
 Q
 ;
COLLECT  ; Collect Information, Scan through the EOB Cross Reference
 ; Input: IBDIV, IBBDT, IBEDT
 N IBDT,IBEOB,IBZ,MRAUSR,DIVCNT,IBX
 S IBX=0 F DIVCNT=0:1 S IBX=$O(IBDIV(IBX)) Q:'IBX  ; Count the requested Divisions
 S IBLTMPH("ALLDIV")="DIVISION TOTALS"
 I IBDIV="ALL" S IBLTMPH("ALLDIV")="ALL DIVISION TOTALS"
 I DIVCNT>1 S IBLTMPH("ALLDIV")="ALL SELECTED DIVISION TOTALS"
 ;
 S IBDT=IBBDT-.000001
 ; Use new Entry date x-ref: EOBTYP=0 ^IBM(361.1,"AEDT",EOBTYP,ENTRY DT,IEN)=""
 F  S IBDT=$O(^IBM(361.1,"AEDT",0,IBDT)) Q:'IBDT  D
 . I IBDT<IBBDT Q
 . I (IBDT\1)>IBEDT Q
 . S IBEOB=0 F  S IBEOB=$O(^IBM(361.1,"AEDT",0,IBDT,IBEOB)) Q:'IBEOB  D
 .. D COLLECT1
 Q
 ;
COLLECT1  ; Collect Information, Get Data for specific EOB and BILL/CLAIM
 N IBIFN,IBFLDS,IBX
 N IBOE                       ; Dict 361.1 EXPLANATION OF BENEFITS field data.
 N IBOB                       ; Dict 399 BILL/CLAIMS field data current claim.
 N IBOBS                      ; Dict 399 BILL/CLAIMS field data Secondary Claim.
 N IBOBT                      ; Dict 399 BILL/CLAIMS field data Tertiary Claim.
 ; Initial Testing
 ; Get all the EOB Data
 ; FIELD  .01 POINTER TO BILL/CLAIMS FILE (#399)
 ; FIELD  .13 CLAIM STATUS, 1-PROCESSED, 2-DENIED, 3-PENDED, 4-REVERSAL, 5-OTHER
 ; FIELD  .15 INSURANCE SEQUENCE, 1-PRIMARY, 2-SECONDARY, 3-TERTIARY
 ; FIELD  .16 REVIEW STATUS, 0-NOT REVIEWED, 1-REVIEW IN PROCESS, 1.5-COB PROCESSED, NOT AUTHORIZED,
 ;                           2-ACCEPTED-INTERIM EOB, 3-ACCEPTED-COMPLETE EOB, 4-REJECTED, 9-CLAIM CANCELLED
 ; FIELD 2.04 TOTAL SUBMITTED CHARGES
 D IBOBJ(361.1,IBEOB,".01;.13;.15;.16;2.04",.IBOE)  ; Load EOB Data.
 ;
 ; Quit if an associated bill number doesn't exist
 S IBIFN=IBOE(.01) I IBIFN="" Q
 ;
 ; Get all the BILL/CLAIMS Data
 ; FIELD .13 STATUS, 0-CLOSED, 1-ENTERED/NOT REVIEWED, 2-REQUEST MRA, 3-AUTHORIZED,
 ;                   4-PRNT/TX, 5-**NOT USED**, 7-CANCELLED
 ; FIELD .19 FORM TYPE, POINTER TO BILL FORM TYPE FILE (#353), 2-CMS1500, 3-UB4
 ; FIELD .21 CURRENT BILL PAYER SEQUENCE, P-PRIMARY, S-SECONDARY, T-TERTIARY, A-PATIENT
 ; FIELD .22 DEFAULT DIVISION, POINTER TO MEDICAL CENTER DIVISION FILE (#40.8)
 ; FIELD .27 BILL CHARGE TYPE, 1-INSTITUTIONAL, 2-PROFESSIONAL
 ; FIELD  7  MRA REQUESTED DATE
 ; FIELD  8  MRA REQUESTOR, POINTER TO NEW PERSON FILE (#200)
 ; FIELD 21  LAST ELECTRONIC EXTRACT DATE
 ; FIELD 27  FORCE CLAIM TO PRINT
 ; FIELD 35  AUTO PROCESS, 1-WORKLIST, 2-LOCAL PRINT, 3-EDI, 4-NO LONGER ON WORK LIST
 ; FIELD 38  REMOVED FROM WORKLIST, RM-REMOVED, PC-PROCESS COB, CL-CLONE, CA-CANCELLED, CR-CORRECTED
 ; FIELD 125 PRIMARY BILL #
 ; FIELD 126 SECONDARY BILL #
 ; FIELD 127 TERTIARY BILL #
 ; FIELD 201 TOTAL CHARGES
 ; FIELD 218 PRIMARY PRIOR PAYMENT
 ; FIELD 219 SECONDARY PRIOR PAYMENT
 D IBOBJ(399,IBIFN,".13;.19;.21;.22;.27;7;8;21;27;35;38;125;126;127;201;218;219;302;303",.IBOB)  ; Load BILL/CLAIMS Data.
 I IBOB(126) D IBOBJ(399,IBOB(126),".13;.19;.21;.22;.27;7;8;21;27;35;38;125;126;127;201;218;219;302;303",.IBOBS)  ; Load Secondary BILL/CLAIMS Data.
 I IBOB(127) D IBOBJ(399,IBOB(127),".13;.19;.21;.22;.27;7;8;21;27;35;38;125;126;127;201;218;219;302;303",.IBOBT)  ; Load Tertiary BILL/CLAIMS Data.
 ;
 ; Quit if this bill contains a MRA date.
 ; I IBOB(7) Q  Removed to allow secondary Non-MRA EOBs.
 ;
 ; Quit if this Insurance Company WNR for this sequence
 I $$WNRBILL^IBEFUNC(IBIFN,IBOE(.15)) Q
 ;
 ; Quit if this BILL/CLAIM isn't a 2-CMS-1500 or 3-UB-04
 I IBOB(.19)'=2,IBOB(.19)'=3 Q
 ;
 ; Quit if this BILL/CLAIM isn't from a selected Division
 I IBDIV'="ALL",'$D(IBDIV(+IBOB(.22))) Q
 ;
 D COLLECT2^IBCEMSR3  ; Accumulate information for the Detailed Report
 D COLLECT3^IBCEMSR3  ; Accumulate information for the Summary Report
 D CALCPCT^IBCEMSR5   ; Calculate the Summary Report Percentages
 Q
 ;
REPORT  ; IF REQUESTED DO DETAIL REPORT, ALWAYS DO SUMMARY REPORT
 N IBLNUMB,IBLTEXT,IBCLERK,IBDIV2
 ; Do the Full report if requested.
 I IBSUM="F" D
 . D HDR
 . S IBDIV2="DIVISION"
 . W !,"DIVISION: ","*** ",IBLTMPH("ALLDIV")," ***",! D CHKP Q:IBQ
 . F IBLNUMB=2:1  S IBLTEXT=$T(FFORM+IBLNUMB^IBCEMSR4) Q:$P(IBLTEXT,";;",2)="END"  Q:IBQ  D PARSE
 . S IBDIV2=0 F  S IBDIV2=$O(IBLTMP(IBDIV2)) Q:+IBDIV2=0  Q:IBQ  D
 .. W !,"DIVISION: ",$$GET1^DIQ(40.8,IBDIV2_",",.01),! D CHKP Q:IBQ
 .. F IBLNUMB=2:1  S IBLTEXT=$T(FFORM+IBLNUMB^IBCEMSR4) Q:$P(IBLTEXT,";;",2)="END"  Q:IBQ  D PARSE
 ; Do the Summary report if requested.
 I IBSUM="S" D
 . D HDR
 . W !,"SUMMARY",! D CHKP Q:IBQ
 . S IBDIV2="DIVISION"
 . W "DIVISION: ","*** ",IBLTMPH("ALLDIV")," ***",! D CHKP Q:IBQ
 . F IBLNUMB=2:1  S IBLTEXT=$T(SFORM+IBLNUMB^IBCEMSR4) Q:$P(IBLTEXT,";;",2)="END"  Q:IBQ  D PARSE
 . S IBDIV2=0 F  S IBDIV2=$O(IBLTMP(IBDIV2)) Q:+IBDIV2=0  Q:IBQ  D
 .. W !,"DIVISION: ",$$GET1^DIQ(40.8,IBDIV2_",",.01),! D CHKP Q:IBQ
 .. F IBLNUMB=2:1  S IBLTEXT=$T(SFORM+IBLNUMB^IBCEMSR4) Q:$P(IBLTEXT,";;",2)="END"  Q:IBQ  D PARSE
 Q
 ;
HDR  ; Report header
 N IBI
 S IBPAGE=IBPAGE+1
 W @IOF,"Non-MRA Productivity Report for period covering "_$$FMTE^XLFDT(IBBDT)_" thru "_$$FMTE^XLFDT(IBEDT),"   ",?100,$$FMTE^XLFDT(DT),"   Page ",IBPAGE
 W ! F IBI=1:1:$S($G(IOM):IOM,1:130) W "-"
 W !
 Q
 ;
CHKP  ; Check for End Of Page
 I $Y>(IOSL-4) D:IBSCR  Q:IBQ  D HDR
 . N X,Y,DTOUT,DUOUT,DIRUT,DIR
 . U IO(0) S DIR(0)="E" D ^DIR S:$D(DIRUT) IBQ=2
 . U IO
 Q
 ;
PARSE  ; USE TEXT INFORMATION FROM FFORM & SFORM TO PRODUCE THE REPORT
 N IBACCUM
 S IBACCUM=$$TRIM^XLFSTR($P(IBLTEXT,";",4))
 S:IBACCUM="" IBACCUM="SKIP"
 S IBLTEXT=$P(IBLTEXT,";",5)
 W ?($P(IBLTEXT,U,1)),$$TRIM^XLFSTR($P(IBLTEXT,U,2))
 W:$$TRIM^XLFSTR($P(IBLTEXT,U,5))="" ?($P(IBLTEXT,U,3)),$J($G(IBLTMP(IBDIV2,IBACCUM,3)),$P(IBLTEXT,U,4))
 W:$$TRIM^XLFSTR($P(IBLTEXT,U,5))'="" ?($P(IBLTEXT,U,3)),$J($G(IBLTMP(IBDIV2,IBACCUM,3)),$P(IBLTEXT,U,4),$P(IBLTEXT,U,5))
 W ?($P(IBLTEXT,U,6)),$$TRIM^XLFSTR($P(IBLTEXT,U,7))
 W:$$TRIM^XLFSTR($P(IBLTEXT,U,10))="" ?($P(IBLTEXT,U,8)),$J($G(IBLTMP(IBDIV2,IBACCUM,2)),$P(IBLTEXT,U,9)),!
 W:$$TRIM^XLFSTR($P(IBLTEXT,U,10))'="" ?($P(IBLTEXT,U,8)),$J($G(IBLTMP(IBDIV2,IBACCUM,2)),$P(IBLTEXT,U,9),$P(IBLTEXT,U,10)),!
 D CHKP Q:IBQ
 Q
 ;
IBOBJ(IBDICT,IBIEN,IBFLDS,IBARRY)  ; LOAD DATA ARRAY
 N IBTMPARR,IBX K IBARRY
 D GETS^DIQ(IBDICT,IBIEN_",",IBFLDS,"I","IBTMPARR")
 S IBX="" F  S IBX=$O(IBTMPARR(IBDICT,IBIEN_",",IBX)) Q:IBX=""  D
 . S IBARRY(IBX)=IBTMPARR(IBDICT,IBIEN_",",IBX,"I")
 Q
 ;
IBDOC  ; Print accumulater list to screen
 N IBLNUMB,IBLTEXT
 W !,"Detail Form Accumulators",!
 W "-------------------------",!
 F IBLNUMB=2:1  S IBLTEXT=$T(FFORM+IBLNUMB^IBCEMSR4) Q:$P(IBLTEXT,";;",2)="END"  D
 . W $P(IBLTEXT,";",4),?10,$$TRIM^XLFSTR($P(IBLTEXT,U,2)),!
 W !,"Summary Form Accumulators",!
 W "-------------------------",!
 F IBLNUMB=2:1  S IBLTEXT=$T(SFORM+IBLNUMB^IBCEMSR4) Q:$P(IBLTEXT,";;",2)="END"  D
 . W $P(IBLTEXT,";",4),?10,$$TRIM^XLFSTR($P(IBLTEXT,U,2)),!
 Q
