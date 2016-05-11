IBCOC1 ;ALB/NLR - NEW, NOT VERIFIED INS. ENTRIES ;24-NOV-93
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% ;
 N POP,ZTQUEUED,ZTREQ
 ; -- fileman print of new, not verified insurance entries
 ;
 W !!,"Print List of New, Not Verified Insurance Entries"
 ;
 ; Report or Excel format
 S IBOUT=$$OUT G:IBOUT="" END
 I IBOUT="E" G EXCEL
 ;
 W !!,"You will need a 132 column printer for this report!",!!
 ;
 S DIC="^DPT(",FLDS="[IBNOTVER]",BY="[IBNOTVER1]"
 D ASK G:$G(IBQ)=1 END
 S DHD="REPORT OF NEW, NOT VERIFIED INSURANCE ENTRIES FROM: "_FR(1)_" TO: "_TO(1)
 D EN1^DIP,ASK^IBCOMC2
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
END K DIC,FLDS,BY,FR,TO,IBOUT,IBQ,DHD
 Q
ASK ;
 N IBBDT,IBEDT
 D DATE^IBOUTL
 I (IBBDT<1)!(IBEDT<1) S IBQ=1
 S FR=",,"_IBBDT_",?",TO=",,"_IBEDT_",?"
 S FR(1)=$$DAT1^IBOUTL(IBBDT),TO(1)=$$DAT1^IBOUTL(IBEDT)
 Q
 ;
OUT() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) Q ""
 Q Y
 ;
EXCEL ;
 ; Ask for Date Entered range
 N IBBDT,IBEDT,IBRF,IBRL,IBQUIT
 S IBQUIT=0
 D DATE^IBOUTL
 I (IBBDT<1)!(IBEDT<1) G XLQUIT
 ;
 D NR G:IBQUIT XLQUIT
 ;
 W !! D QUE
 ;
XLQUIT ;
 K IBBDT,IBEDT,IBRF,IBRL,IBOUT,IBQUIT
 Q
 ;
NR ; Ask Name Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
NRR S DIR(0)="FO",DIR("B")="FIRST",DIR("A")="      START WITH NAME"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="FIRST" Y="A" S IBRF=Y
 S DIR(0)="FO",DIR("B")="LAST",DIR("A")="      GO TO NAME"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="LAST" Y="zzzzzz" S IBRL=Y
 I $G(IBRL)']$G(IBRF) W !!,?5,"* The Go to Patient Name must follow after the Start with Name. *",! G NRR
 Q
 ;
QUE ; Ask Device for Excel Output
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .S ZTRTN="COMPXL^IBCOC1",ZTSAVE("IBRF")="",ZTSAVE("IBRL")=""
 .S ZTSAVE("IBBDT")="",ZTSAVE("IBEDT")=""
 .S ZTDESC="IB - List New not Verified Policies"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 D COMPXL
 ;
QUEQ ; Exit clean-up
 W ! D ^%ZISC K IBBDT,IBEDT,IBOUT,IBRF,IBRL,VA,VAERR,VADM,VAPA,^TMP("IBCOC1",$J)
 Q
 ;
COMPXL ; Compile Excel data
 ; Input variables:
 ; IBRF  - Required.  Name Range Start value
 ; IBRL  - Required.  Name Range Go To value
 ; IBBDT - Required.  Begining Entered Date Range
 ; IBEDT - Required.  Ending Entered Date Range
 ;
 N IBC,IBCDA,IBCDA0,IBCDA1,IBSSN,IBINS,IBSUBID,IBENDT,IBENUSR,DFN,VA,VADM,VAERR,VAPA
 K ^TMP("IBCOC1",$J)
 S IBC=0 F  S IBC=$O(^DPT("AB",IBC)) Q:'IBC  D
 .S DFN=0 F  S DFN=$O(^DPT("AB",IBC,DFN)) Q:'DFN  D
 ..K VA,VADM,VAERR,VAPA
 ..D DEM^VADPT,ADD^VADPT
 ..;
 ..;  I Pt. name out of range quit
 ..S VADM(1)=$P($G(VADM(1)),U,1) I VADM(1)="" Q
 ..I VADM(1)]IBRL Q
 ..I IBRF]VADM(1) Q
 ..;
 ..S IBCDA=0 F  S IBCDA=$O(^DPT("AB",IBC,DFN,IBCDA)) Q:'IBCDA  D
 ...S IBCDA0=$$ZND^IBCNS1(DFN,IBCDA)  ;516 - baa
 ...;
 ...;  I Verification Date populated quit
 ...S IBCDA1=$G(^DPT(DFN,.312,IBCDA,1))
 ...I $P(IBCDA1,U,3) Q
 ...;
 ...;  I Entered Date out of range quit
 ...I +$P(IBCDA1,U)>IBEDT Q
 ...I +$P(IBCDA1,U)<IBBDT Q
 ...;
 ...;  Get data fields
 ...S IBSSN=$$GET1^DIQ(2,DFN,.09)
 ...S IBINS=$$GET1^DIQ(2.312,IBCDA_","_DFN_",",.01)
 ...S IBSUBID=$$GET1^DIQ(2.312,IBCDA_","_DFN_",",7.02)
 ...S IBENUSR=$$GET1^DIQ(2.312,IBCDA_","_DFN_",",1.02)
 ...S IBENDT=$$FMTE^XLFDT($P(IBCDA1,U),1)
 ...;
 ...;  Set global array
 ...S ^TMP("IBCOC1",$J,VADM(1),IBCDA)=VADM(1)_U_IBSSN_U_IBINS_U_IBSUBID_U_IBENUSR_U_IBENDT
 ;
 W "PATIENT^PATIENT ID^INSURANCE CO^SUBSCRIBER ID^WHO ENTERED^DATE ENTERED"
 I '$D(^TMP("IBCOC1",$J)) W !!,"** NO RECORDS FOUND **" D ASK^IBCOMC2 Q
 D WRT,ASK^IBCOMC2
 ;
 Q
 ;
WRT ; Print Excel data
 N IBPAT,IBINSTYP
 S (IBPAT,IBINSTYP)=""
 F  S IBPAT=$O(^TMP("IBCOC1",$J,IBPAT)) Q:IBPAT=""  D
 .F  S IBINSTYP=$O(^TMP("IBCOC1",$J,IBPAT,IBINSTYP)) Q:'IBINSTYP  W !,^TMP("IBCOC1",$J,IBPAT,IBINSTYP)
 Q
