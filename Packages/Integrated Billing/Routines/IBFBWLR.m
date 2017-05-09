IBFBWLR ;ALB/PAW-NVC and Billing Worklist Worklist History Report ;30-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- Main entry point for NVC and Billing Worklist History Report
 N DFN,IBAUTH,IBC,IBDA,IBDB,IBDC,IBDL,IBDT,IBDTR,IBDT1,IBDT2,IBDTTM,IBDTTM1,IBDTTM2
 N IBDUZ,IBEVNT,IBHDT,IBI,IBPG,IBQUIT,IBRANGE,IBX,X,Y
 N ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSTOP,%ZIS,FIRST
 D PROMPT
 D PRINT
 D EXIT
 Q
 ;
PROMPT ; - Report prompts  
 ; Can be run by PATIENT or DATE RANGE
 S DIR(0)="S^P:Patient;D:Date Range"
 S DIR("A")="Report by Patient or Date Range"
 S DIR("B")="Date Range"
 S DIR("?",1)="Enter P to print the worklist history data for one patient."
 S DIR("?",2)="Enter D to print all worklist history data for a date range."
 S DIR("?")="Enter a code from the list."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S IBRANGE=$S(Y="D":1,1:0)
 ;
 I IBRANGE D  G:$D(DIRUT) EXIT
 . ; Ask dates
 . S DIR(0)="D^::EX",DIR("A")="From Date"
 . ; Default from date is first day of current month
 . S DIR("B")=$$FMTE^XLFDT($E(DT,1,5)_"01")
 . D ^DIR K DIR Q:$D(DIRUT)
 . S IBDT1=Y
 . I $G(IBDT1)="" Q
 . S DIR(0)="DA^"_IBDT1_"::EX",DIR("A")="To Date: "
 . ; Default to date is last day of specified month
 . S X=$E($$SCH^XLFDT("1M(L@1A)",IBDT1)\1,6,7)
 . S DIR("B")=$$FMTE^XLFDT($E(IBDT1,1,5)_X)
 . D ^DIR K DIR Q:$D(DIRUT)
 . S IBDT2=Y
 . I $G(IBDT2)="" Q
 ;
 ; If not date range then ask patient
 I 'IBRANGE D
 . S DIC(0)="AEQMN",DIC="^DPT(",FIRST=1
 . N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 . S DIC("A")=$S(FIRST:"Select Patient: ",1:"Select Another Patient: ")
 . D ^DIC
 . S DFN=$P(Y,U)
 I 'IBRANGE,$G(DFN)'>0 Q
 ;
 ; Ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^IBFBWLR",ZTDESC="NVC/Billing Worklist History"
 . F IBX="IBAAIN","IBDT*","IBRANGE" S ZTSAVE(IBX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 Q
 ;
PRINT ; Report data
 I '$D(IBRANGE) G EXIT
 I IBRANGE I $G(IBDT1)=""!($G(IBDT2)="") G EXIT
 I 'IBRANGE I $G(DFN)'>0 G EXIT
 S IBQUIT=0
 S IBPG=0 D NOW^%DTC S Y=% D DD^%DT S IBDTR=Y
 K IBDL S IBDL="",$P(IBDL,"-",IOM)=""
 ;
 ; Build page header text for selection criteria
 S:IBRANGE IBHDT(1)="  For "_$$FMTE^XLFDT(IBDT1)_" through "_$$FMTE^XLFDT(IBDT2)
 ;
 D HD
 ;
 ; Initialize Counter
 S IBC=0
 ;
 ; If by date range
 I IBRANGE D
 . S IBDT=IBDT1-.0000001
 . F  S IBDT=$O(^IBFB(360,"DT",IBDT)) Q:'IBDT!(IBDT>(IBDT2_".999999"))  D  Q:IBQUIT
 .. S IBDA="" F  S IBDA=$O(^IBFB(360,"DT",IBDT,IBDA)) Q:'IBDA  D  Q:IBQUIT
 ... S IBDB=""  F  S IBDB=$O(^IBFB(360,"DT",IBDT,IBDA,IBDB)) Q:'IBDB  D  Q:IBQUIT
 .... S IBDC=""  F  S IBDC=$O(^IBFB(360,"DT",IBDT,IBDA,IBDB,IBDC)) Q:'IBDC  D  Q:IBQUIT
 ..... S DFN=IBDA
 ..... D SETVARS
 ..... D PRINT1
 ;
 ; If by patient
 I 'IBRANGE D
 . S IBDA="" F  S IBDA=$O(^IBFB(360,"DFN",DFN,IBDA)) Q:'IBDA  D  Q:IBQUIT
 .. S IBDB=""  F  S IBDB=$O(^IBFB(360,"DFN",DFN,IBDA,IBDB)) Q:'IBDB  D  Q:IBQUIT
 ... S IBDC=""  F  S IBDC=$O(^IBFB(360,"DFN",DFN,IBDA,IBDB,IBDC)) Q:'IBDC  D  Q:IBQUIT
 .... D SETVARS
 .... D PRINT1
 ;
 I IBC=0 W !,"No worklist history entries found."
 ;
 I IBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 ;
 I 'IBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 Q
 ;
SETVARS ; Set variables
 S IBDTTM=$P($G(^IBFB(360,IBDB,4,IBDC,0)),U,1)
 S IBDTTM1=$P(IBDTTM,".",1)
 I IBDTTM1'="" S IBDTTM1=$$FDATE^VALM1(IBDTTM1)
 S Y=IBDTTM D DD^%DT S IBDTTM2=Y
 S IBDTTM2=$P($G(IBDTTM2),"@",2)
 S IBDTTM2=$P(IBDTTM2,":",1,2)
 S IBEVNT=$P($P($G(^IBFB(360,IBDB,4,IBDC,0)),U,2),"|")
 I IBEVNT["RUR-NextRevDt" S IBEVNT=$P(IBEVNT,"/",1,2)
 S IBDUZ=$P($G(^IBFB(360,IBDB,4,IBDC,0)),U,3)
 S IBAUTH=$P($G(^IBFB(360,IBDB,0)),U,3)
 Q
 ;
HD ; Page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 Q
 I $E(IOST,1,2)="C-",IBPG S DIR(0)="E" D ^DIR K DIR I 'Y S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!IBPG W @IOF
 S IBPG=IBPG+1
 W !,"NVC/Billing Worklist History "
 I IBRANGE W "by Date Range"
 E  W "by Patient"
 W ?49,IBDTR,?72,"page ",IBPG
 S IBI=0 F  S IBI=$O(IBHDT(IBI)) Q:'IBI  W !,IBHDT(IBI)
 W !!,"Date/Time",?15,"Patient",?38,"Auth",?43,"Event",?64,"User"
 W !,IBDL
 Q
 ;
PRINT1 ; Print one history record
 N IBCNT,IBRUR,IBRURT,IBRURTX
 S IBC=IBC+1
 I $Y+9>IOSL D HD Q:IBQUIT
 W !,IBDTTM1_"@"_IBDTTM2,?15,$E($$GET1^DIQ(2,DFN_",",.01),1,22),?38,IBAUTH,?43,$E(IBEVNT,1,20),?64,$E($$GET1^DIQ(200,IBDUZ_",",.01),1,15)
 I $P($P($G(^IBFB(360,IBDB,4,IBDC,0)),U,2),"|",2)'="" D
 . S IBRURT=""
 . S IBRUR=$P($P(^IBFB(360,IBDB,4,IBDC,0),U,2),"|",2)
 . S IBRURT=$S(IBRUR=1:"Pending Payer Action",IBRUR=2:"Addl Info Req - Refer to FR",IBRUR=3:"Auth Not Required - SC/SA",IBRUR=4:"Auth Not Required - Payer Contacted",1:"")
 . Q:IBRURT'=""
 . S IBRURT=$S(IBRUR=5:"Auth Not Required",IBRUR=6:"Auth Obtained",IBRUR=7:"Continued Stay Review",IBRUR=8:"Discharge Review Required",1:"")
 . Q:IBRURT'="" 
 . S IBRURT=$S(IBRUR=9:"Partial SC Stay - Auth Worked",IBRUR=10:"Partial Stay / Visit Approved",IBRUR=11:"Auth Denied",1:"")
 . Q:IBRURT'=""
 . S IBRURT=$S(IBRUR=12:"Auth Not Obtained / No ROI / Sent to FR",IBRUR=13:"EOC SC/SA",IBRUR=14:"EOC Non SC/SA",1:"")
 . Q:IBRURT'=""
 . S IBRURT=$S(IBRUR=15:"Need Addl Info - Refer to FR",IBRUR=16:"EOC Related to Legal",IBRUR=17:"EOC Not Related to Legal - No OHI",1:"")
 . Q:IBRURT'=""
 . S IBRURT=$S(IBRUR=18:"EOC Not Related to Legal - OHI SC/SA",IBRUR=19:"EOC Not Related to Legal - OHI Non SC/SA",1:"")
 I $G(IBRURT)'="" W !?4,"RUR:  ",IBRURT
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,J,POP,X,Y
 Q
