IBUCSP ;WOIFO/AAT-URGENT CARE SINGLE PATIENT PROFILE ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**663,671**;21-MAR-94;Build 13
 ;; Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
ENTER ; Entry point for the routine
 S:'$D(DTIME) DTIME=300 D HOME^%ZIS
 ;
 ;
 N IBQUIT,POP,IBDFN,IBCLK,IBDT1,IBDT2,IBNOW
 F  S IBQUIT=0 D  Q:IBQUIT
 . S IBDFN=$$ASKPAT() I IBDFN=-1 S IBQUIT=1 Q
 . ; Ask about beginning and ending date and perform action
 . ; No default valies provided
 . D DATE I IBDT1<0 Q  S IBQUIT=1 Q  ;Enter date range (defaults are begin/end of the clock)
 . D ASKDEV
 Q
 ;
ASKDEV ; Ask about output device and print the report (or run task)
 N %ZIS
 S %ZIS="QM"
 W ! D ^%ZIS Q:POP  ; Quit and ask for patient again. Otherwise Set IBSTOP=1
 ; If it was queued
 I $D(IO("Q")) D RUNTASK Q
 U IO D REPORT^IBUCSP1 ; Generate report directly
 D ^%ZISC ; Close the device
 Q
 ;
 ;
RUNTASK ; Start Taskman job
 N ZTRTN,ZTSK,IBVAR,ZTSAVE,ZTDESC
 S ZTRTN="REPORT^IBAECP1",ZTDESC="LTC SINGLE PATIENT BILLING PROFILE"
 F IBVAR="IBDFN","IBCLK","IBDT1","IBDT2" S ZTSAVE(IBVAR)=""
 D ^%ZTLOAD
 K IO("Q")
 D HOME^%ZIS W !
 Q
 ;
DATE N %DT,Y,IBDT,IBNOW
DATAGN ;Loop entry point
 S IBNOW=$$NOW^IBUCMM
 S (IBDT1,IBDT2)=-1
 ; Get beginning date
 S IBDT1=$$ASKDT("Start YEAR: ",2019)
 I IBDT1<1 Q
 ; Get ending date
 I '$G(IBDT) S IBDT=IBNOW
 E  I $G(IBDT)>IBNOW S IBDT=IBNOW
 S IBDT2=$$ASKDT("Go to YEAR: ",IBDT1)
 I IBDT2<1 S IBDT1=-1 Q
 I IBDT2<IBDT1 W !,"Ending date must follow start date!",! G DATAGN
 Q
 ;
ASKDT(IBPRMT,IBDFLT) ;Date input
 N DIR,Y,X,DIROUT,DIRUT
 I $G(IBPRMT)'="" S DIR("A")=IBPRMT
 S DIR("B")=IBDFLT
 S DIR(0)="F^4:4:K:X'?4N X"
 D ^DIR I $D(DIRUT) Q -1
 W " ",Y
 Q Y
 ;
 ;Enter PATIENT NAME
 ;Customized dialog (added more explanation on '??' input)
ASKPAT() N DIR,DIC,Y,X,IBDFN
 F  D  Q:$D(DIRUT)  Q:Y>0
 . S DIR("A")="Select PATIENT NAME"
 . S DIR(0)="FO"
 . S DIR("?")="Enter '??' to list all LTC Patients"
 . S DIR("?",1)="Enter a name of LTC Patient"
 . S DIR("?",2)="Answer with PATIENT NAME, or SOCIAL SECURITY NUMBER, or last 4 digits"
 . S DIR("?",3)="of SOCIAL SECURITY NUMBER, or first initial of last name with last"
 . S DIR("?",4)="4 digits of SOCIAL SECURITY NUMBER"
 . S DIR("?",5)=""
 . D ^DIR Q:$D(DIRUT)
 . S X=Y
 . I X?3N1"-"2N1"-"4N.3A S X=$TR(X,"-","") ; Remove dashes from SSN
 . S DIC="^DPT(",DIC(0)="QME"
 . N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 . D ^DIC Q:Y<1  ; Patient code
 . S Y=+$G(Y)
 . ;W "  " D WRTPAT(Y)
 I $D(DIRUT) Q -1
 Q +Y
 ;
WRTPAT(IBDFN) ; Write patient's data
 N IBZ,IBVET,IBSC
 S IBZ=$G(^DPT(IBDFN,0)) Q:IBZ="" ""
 S IBSC=($P($G(^DPT(IBDFN,3)),U)="Y")
 S IBVET=($P($G(^DPT(IBDFN,"VET")),U)="Y")
 W $P(IBZ,U)
 W " ",?30,$$FMTE^XLFDT($P($P(IBZ,U,3),"."),"5MZ")
 W " ",?42,$$SSN($$EXTERNAL^DILFD(2,.09,"",$P(IBZ,U,9)))
 W " ",?55,$S(IBVET:$S(IBSC:"S/C",1:"NSC")_" VETERAN",1:"")
 W " ",?68,$$FMTE^XLFDT($P($O(^IBA(351.81,"AE",IBDFN,""),-1),"."),"5MZ")
 Q
 ;
SSN(IBN) ;Format SSN Value
 I $L(+IBN)<7 Q IBN
 Q $E(IBN,1,3)_"-"_$E(IBN,4,5)_"-"_$E(IBN,6,255)
