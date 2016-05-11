IBCNERPC ;DAOU/RO - eIV PAYER LINK REPORT COMPILE ;AUG-2003
 ;;2.0;INTEGRATED BILLING;**184,252,271,416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification
 ;
 ; Input vars from IBCNERPB:
 ;  IBCNESPC("REP")=1 for Payer List report, 2 for Company List
 ;  IBCNESPC("PTYPE")=Payer type (1-no active ins linked, 2-at least 1 ins linked, 3-All Payers)
 ;  IBCNESPC("PSORT")=Primary Sort for Payer report
 ;  IBCNESPC("PDET")=Ins detail on payer report (1-include list of ins,2-do not list)
 ;
 ;  IBCNESPC("ITYPE")=Ins Company type (1-no payer link, 2-linked to payer, 3-All ins companies)
 ;  IBCNESPC("ISORT")=Primary Sort for Payer Insurance report
 ;  IBCNESPC("IMAT")=Partial matching Ins carriers
 ;  IBOUT ="R" for Report format or "E" for Excel format
 ;
 ; Output vars used by IBCNERPC:
 ;  
 ;   IBCNERTN="IBCNERPB"
 ;   SORT1=depends on sorting option chosen
 ;   SORT2=Payer Name (Report by Payer) or Ins Company Name (if report is Insurance)
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,CNT) 
 ;   CNT=Seq ct
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,CNT,1) 
 ;
 ; Must call at EN
 Q
 ;
EN(IBCNERTN,IBCNESPC) ; Entry
 ; Init
 N IBTYP,IBCT,IBCTX,IBI
 ;
 N IBDET,IBSRT,IBPY,IBVAID,IBPROF,IBINST,IBNAACT,IBLOACT,IBINS,IBINST,IBGRP
 N IBINSN,IBAPP,IBPYR,SORT1,SORT2,IBSRT,IBMAT,IBPPYR,IBREP,IBFLAGS,IBTRUST
 ;
 I '$D(ZTQUEUED),$G(IOST)["C-",IBOUT="R" W !!,"Compiling report data ..."
 ;
 ; Temp ct
 S IBCT=0
 ;
 ; Kill scratch globals
 K ^TMP($J,IBCNERTN)
 ;
 ;
 S IBREP=$G(IBCNESPC("REP"))
 S IBDET=$G(IBCNESPC("PDET"))
 S IBTYP=$G(IBCNESPC("PTYPE"))
 S IBSRT=$G(IBCNESPC("PSORT"))
 S IBPPYR=$G(IBCNESPC("PPYR"))
 ;
 ; Ins Report
 I IBREP=2 G INS
 ;
 ; Loop thru the eIV payer File (#365.12)
 S IBPY=0,SORT1=""
 F  S IBPY=$O(^IBE(365.12,IBPY)) Q:'IBPY  D  Q:$G(ZTSTOP)
 . I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ; Payer name from Payer File (#365.12)
 . S IBPYR=$P($G(^IBE(365.12,IBPY,0)),U) I IBSRT=1 S SORT1=IBPYR
 . S SORT2=IBPYR
 . I IBPYR=""!(IBPYR="~NO PAYER")!($$PYRAPP^IBCNEUT5("IIV",IBPY)="") Q
 . I IBPPYR'="",IBPY'=$P(IBPPYR,U) Q
 . ; get VA national ID
 . S IBVAID=$P($G(^IBE(365.12,IBPY,0)),U,2) I IBSRT=2 S SORT1=IBVAID
 . ; get the EDI numbers (professional and institutional)
 . S IBPROF=$P($G(^IBE(365.12,IBPY,0)),U,5)
 . S IBINST=$P($G(^IBE(365.12,IBPY,0)),U,6)
 . S IBAPP=$$PYRAPP^IBCNEUT5("IIV",IBPY),(IBNAACT,IBLOACT)=0,IBTRUST=""
 . S:IBAPP'="" IBNAACT=$P($G(^IBE(365.12,IBPY,1,IBAPP,0)),U,2)
 . S:IBAPP'="" IBLOACT=$P($G(^IBE(365.12,IBPY,1,IBAPP,0)),U,3)
 . I IBAPP'="" D GETFLAGS^IBCNERP8(IBPY,IBAPP,$G(^IBE(365.12,IBPY,0)),"","",.IBFLAGS) S IBTRUST=$S($P($G(IBFLAGS("FLAGS","T",IBPYR,1)),U,2)="ON":"YES",1:"NO")
 . ; if no sort value, use 0
 . I IBSRT=3 S SORT1=IBNAACT I SORT1="" S SORT1=0
 . I IBSRT=4 S SORT1=IBLOACT I SORT1="" S SORT1=0
 . I SORT1="" S SORT1=" "
 . ; if sorting by count and detail, need to figure count first else sort will not work
 . I IBSRT=5,IBTYP>1,IBDET=1 D  S SORT1=-IBCTX
 . . S IBCTX=0,IBINS="" F  S IBINS=$O(^DIC(36,"AC",IBPY,IBINS)) Q:IBINS=""  D
 . . . S IBINSN=$G(^DIC(36,IBINS,0)),IBINSN=$P(IBINSN,U) Q:IBINSN=""  S IBCTX=IBCTX+1
 . ; search for insurance carriers for this payer
 . S IBCT=0,IBINS="" F  S IBINS=$O(^DIC(36,"AC",IBPY,IBINS)) Q:IBINS=""  D
 . . S IBINSN=$G(^DIC(36,IBINS,0)),IBINSN=$P(IBINSN,U) Q:IBINSN=""
 . . S IBCT=IBCT+1 I IBTYP=1 Q
 . . ; save off address and EDI#'s for Insurance carrier
 . . I IBDET=1 S ^TMP($J,IBCNERTN,SORT1,SORT2,IBPY,IBINSN,IBINS)=$P($G(^DIC(36,IBINS,.11)),U,1,6)_U_$P($G(^DIC(36,IBINS,3)),U,2)_U_$P($G(^DIC(36,IBINS,3)),U,4)
 . I IBTYP=1,IBCT>0 Q
 . I IBTYP=2,IBCT=0 Q
 . ; use reverse sort for count
 . I IBSRT=5 S SORT1=-IBCT
 . S ^TMP($J,IBCNERTN,SORT1,SORT2,IBPY)=IBVAID_U_IBPROF_U_IBINST_U_IBNAACT_U_IBLOACT_U_IBCT_U_IBTRUST
 G EXIT
 ;
INS ;
 S IBTYP=$G(IBCNESPC("ITYPE"))
 S IBSRT=$G(IBCNESPC("ISORT"))
 S IBMAT=$G(IBCNESPC("IMAT"))
 ; Loop thru the Insurance company file
 S IBINS=0
 F  S IBINS=$O(^DIC(36,IBINS)) Q:'IBINS  D  Q:$G(ZTSTOP)
 . I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 . S (SORT1,IBPYR,IBNAACT,IBLOACT,IBPROF,IBINST,IBVAID,IBTRUST)=""
 . S IBINSN=$P($G(^DIC(36,IBINS,0)),U) I IBSRT=1 S SORT1=IBINSN
 . S SORT2=IBINSN
 . I IBINSN="" Q
 . I IBMAT'="",'$F($$UP^XLFSTR(IBINSN),$$UP^XLFSTR(IBMAT)) Q
 . ; get active group count
 . S (IBI,IBGRP)=0 F  S IBI=$O(^IBA(355.3,"B",IBINS,IBI)) Q:'IBI  I '$$GET1^DIQ(355.3,IBI,.11,"I") S IBGRP=IBGRP+1
 . ; get payer
 . S IBPY=$P($G(^DIC(36,IBINS,3)),U,10)
 . I IBTYP=1,IBPY'="" Q
 . I IBTYP=2,IBPY="" Q
 . I IBPY'="" D
 . . ; Payer name from Payer File (#365.12)
 . . S IBPYR=$P($G(^IBE(365.12,IBPY,0)),U) I IBSRT=2 S SORT1=IBPYR
 . . ; get VA national ID
 . . S IBVAID=$P($G(^IBE(365.12,IBPY,0)),U,2) I IBSRT=3 S SORT1=IBVAID
 . . S IBPROF=$P($G(^IBE(365.12,IBPY,0)),U,5)
 . . S IBINST=$P($G(^IBE(365.12,IBPY,0)),U,6)
 . . S IBAPP=$$PYRAPP^IBCNEUT5("IIV",IBPY),(IBNAACT,IBLOACT)=0
 . . S:IBAPP'="" IBNAACT=$P($G(^IBE(365.12,IBPY,1,IBAPP,0)),U,2)
 . . S:IBAPP'="" IBLOACT=$P($G(^IBE(365.12,IBPY,1,IBAPP,0)),U,3)
 . . I IBAPP'="" D GETFLAGS^IBCNERP8(IBPY,IBAPP,^IBE(365.12,IBPY,0),"","",.IBFLAGS) S IBTRUST=$S($P($G(IBFLAGS("FLAGS","T",IBPYR,1)),U,2)="ON":"YES",1:"NO")
 . . I IBSRT=4 S SORT1=IBNAACT I SORT1="" S SORT1=0
 . . I IBSRT=5 S SORT1=IBLOACT I SORT1="" S SORT1=0
 . I SORT1="" S SORT1=" "
 . S ^TMP($J,IBCNERTN,SORT1,SORT2,IBINS)=IBPYR_U_IBVAID_U_IBPROF_U_IBINST_U_IBNAACT_U_IBLOACT_U_IBCT_U_IBGRP_U_IBTRUST_U_$G(^DIC(36,IBINS,.11))_U_"~"_$G(^DIC(36,IBINS,3))
 ;
EXIT ;
 Q
 ; Lines moved from IBCNERPB
ITYPE ; Prompt to select Insurance Company type to include
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Unlinked insurance companies;2:Linked insurance companies;3:All insurance companies"
 S DIR("A")="Select type of insurance companies to display"
 S DIR("B")="3"
 S DIR("?",1)="  1 - Only insurance companies that are not currently linked to a payer"
 S DIR("?",2)="  2 - Only insurance companies that are currently linked to a payer"
 S DIR("?")="  3 - ALL insurance companies"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G ITYPEX
 S IBCNESPC("ITYPE")=Y
 ;
ITYPEX ; TYPE exit pt
 Q
ISORT ; Prompt to allow users to select primary sort
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Insurance Company Name;2:Payer Name;3:VA National Payer ID;4:Nationally Enabled Status;5:Locally Enabled Status"
 S DIR("A")="Select the primary sort field"
 S DIR("B")=1
 S DIR("?")="  Select the data field by which this report should be primarily sorted."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G ISORTX
 S IBCNESPC("ISORT")=Y
 ;
ISORTX ; SORT exit pt
 Q
IMAT ; Prompt to allow users to select partial Ins carrier to include
 N DIR,X,Y,DIRUT
 ;
 W !
 S DIR(0)="FO"
 S DIR("A")="Enter an insurance company search keyword (RETURN for ALL)"
 S DIR("B")=""
 S DIR("?",1)="     Enter a value to match insurance company names with."
 S DIR("?",2)="     Simply hit RETURN to select ALL or enter a keyword"
 S DIR("?",3)="     (ex. 'CIGNA' would return CIGNA, CIGNA HICN, NATIONAL CIGNA,"
 S DIR("?")="     REGION 1 CIGNA and any others with the term 'CIGNA' in it)"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) S Y="" S STOP=1 G IMATX
 S IBCNESPC("IMAT")=Y
 ;                                                                       
IMATX Q
 ;
OUT() ; Prompt to allow users to select output format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S STOP=1 Q ""
 Q Y
