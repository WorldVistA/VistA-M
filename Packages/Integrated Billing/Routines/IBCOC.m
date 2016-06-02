IBCOC ;ALB/AAS - INACTIVE INS. COMPANIES WITH PATIENTS ;04-NOV-93
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% ;
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC,POP,ZTQUEUED,ZTREQ
 ; -- fileman print in inactive ins. companies
 W !!,"Print List of Inactive Insurance Companies still listed as Insuring Patients"
 ;
 ; Report or Excel format
 S IBOUT=$$OUT G:IBOUT="" END
 I IBOUT="E" G EXCEL
 ;
 W !!,"You will need a 132 column printer for this report!",!!
 S DIC="^DIC(36,",FLDS="[IB INACTIVE INS CO]",BY="[IB INACTIVE INS CO]",FR="?,?",TO="?,?"
 S DIS(0)="I $D(^DPT(""AB"",D0))"
 D EN1^DIP,ASK^IBCOMC2
 W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
END K D,I,J,X,Y,IBCNT,IBOUT,DIC,FLDS,BY,TO,FR,DIS
 Q
 ;
CNT(D0) ; -- count number of entries
 N X,Y S X=0
 G:'$G(D0) CNTQ
 S Y=0 F  S Y=$O(^DPT("AB",D0,Y)) Q:'Y  S X=X+1
CNTQ Q X
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
 N IBRF,IBRL,IBQUIT
 S IBQUIT=0
 ;
 D NR G:IBQUIT XLQUIT
 ;
 W !! D QUE
 ;
XLQUIT ;
 K IBRF,IBRL,IBOUT,IBQUIT
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
 I $G(IBRL)']$G(IBRF) W !!,?5,"* The Go to Insurance Name must follow after the Start with Name. *",! G NRR
 Q
 ;
QUE ; Ask Device for Excel Output
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .S ZTRTN="COMPXL^IBCOC",ZTSAVE("IBRF")="",ZTSAVE("IBRL")=""
 .S ZTDESC="IB - List Inactive Ins. Co. Covering Patients"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 D COMPXL
 ;
QUEQ ; Exit clean-up
 W ! D ^%ZISC K IBOUT,IBRF,IBRL,VA,VAERR,VADM,VAPA,^TMP("IBCOC",$J)
 Q
 ;
COMPXL ; Compile Excel data
 ; Input variables:
 ; IBRF  - Required.  Name Range Start value
 ; IBRL  - Required.  Name Range Go To value
 ;
 N IBINS,IBINSNM,IBSTR,IBCTY,IBST,IBNUM
 K ^TMP("IBCOC",$J)
 ;
 S IBINSNM=""
 F  S IBINSNM=$O(^DIC(36,"B",IBINSNM)) Q:IBINSNM']""  D
 . ;
 . ; -- Ins. name out of range
 . I IBINSNM]IBRL!(IBRF]IBINSNM) Q
 . ;
 . S IBINS=$O(^DIC(36,"B",IBINSNM,0)) I '+IBINS Q
 . ;
 . ; -- Ins. not inactive
 . I '$$GET1^DIQ(36,IBINS,.05,"I") Q
 . ;
 . ;  Get data fields
 . S IBSTR=$$GET1^DIQ(36,IBINS,.111)
 . S IBCTY=$$GET1^DIQ(36,IBINS,.114)
 . S IBST=$$GET1^DIQ(36,IBINS,.115,"I"),IBST=$$GET1^DIQ(5,IBST,1)
 . S IBNUM=$$CNT(IBINS)
 . ;
 . ;  Set global array
 . S ^TMP("IBCOC",$J,IBINSNM)=IBINSNM_U_IBSTR_U_IBCTY_U_IBST_U_IBNUM
 ; 
 ;
 W "INSURANCE COMPANY^STREET^CITY^STATE^NUMBER PATIENTS"
 I '$D(^TMP("IBCOC",$J)) W !!,"** NO RECORDS FOUND **" D ASK^IBCOMC2 Q
 D WRT,ASK^IBCOMC2
 ;
 Q
 ;
WRT ; Print Excel data
 N IBINSNM
 S (IBINSNM)=""
 F  S IBINSNM=$O(^TMP("IBCOC",$J,IBINSNM)) Q:IBINSNM=""  W !,^TMP("IBCOC",$J,IBINSNM)
 Q
