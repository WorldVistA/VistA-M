IBAECP ;WOIFO/AAT-LTC SINGLE PATIENT PROFILE ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**171,176,199**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 S:'$D(DTIME) DTIME=300 D HOME^%ZIS
 ;
 ;
 N IBQUIT,POP
 F  S IBQUIT=0 D  Q:IBQUIT
 . N IBDFN,IBCLK,IBDT1,IBDT2,%DT,X,Y,DIC,IBOFD,IBOEV
 . W !
 . S IBDFN=$$ASKPAT() I IBDFN=-1 S IBQUIT=1 Q
 . ; Enter required clock (if more than one)
 . S IBCLK=$$ASKCLK(IBDFN) I IBCLK<1 Q  S IBQUIT=1
 . ; Ask about beginning and ending date and perform action
 . ; No default valies provided
 . ; W !,"The report is not available at the patch IB*2.0*171" Q
 . D DATE I IBDT1<0 Q  S IBQUIT=1 Q  ;Enter date range (defaults are begin/end of the clock)
 . D ASKOFD I IBOFD<0 Q  S IBQUIT=1 Q  ;Option - print free days
 . D ASKOEV I IBOEV<0 Q  S IBQUIT=1 Q  ;Option - print event history
 . D ASKDEV
 Q
 ;
ASKDEV ; Ask about output device and print the report (or run task)
 N %ZIS
 S %ZIS="QM"
 W ! D ^%ZIS Q:POP  ; Quit and ask for patient again. Otherwise Set IBSTOP=1
 ; If it was queued
 I $D(IO("Q")) D RUNTASK Q
 U IO D REPORT^IBAECP1 ; Generate report directly
 D ^%ZISC ; Close the device
 Q
 ;
 ;
RUNTASK ; Start Taskman job
 N ZTRTN,ZTSK,IBVAR,ZTSAVE,ZTDESC
 S ZTRTN="REPORT^IBAECP1",ZTDESC="LTC SINGLE PATIENT BILLING PROFILE"
 F IBVAR="IBDFN","IBCLK","IBDT1","IBDT2","IBOFD","IBOEV" S ZTSAVE(IBVAR)=""
 D ^%ZTLOAD
 K IO("Q")
 D HOME^%ZIS W !
 Q
 ;
 ; User's interface for LTC Billing Clock
 ; If the user has only one clock - doesn't ask, only shows brief info. 
 ; Parameters: 
 ;  IBDFN - patient IEN
 ;  IBSHOW - if 1, the list of clocks will be printed
 ; Returns: LTC Clock IEN (or -1, if canceled, or 0, if the user doesn't has any clocks)
ASKCLK(IBDFN,IBSHOW) N IBDT,IBDT2,IBX,IBZ,IBCNT,IBCL,DIRUT,Y,DIR,IBI,IBY,IBCLK
 I '$D(^IBA(351.81,"AE",IBDFN)) D  Q 0 ; No data for the patient
 . W !,"The user doesn't have LTC Billing Clock created"
 ; Collect all data in IBCL array IBCL(DATE)=IEN,IBCL=<Number of clocks>
 S IBCL=0
 S IBCLK=0,IBDT=0 F  S IBDT=$O(^IBA(351.81,"AE",IBDFN,IBDT)) Q:'IBDT  D
 . S IBX=0 F  S IBX=$O(^IBA(351.81,"AE",IBDFN,IBDT,IBX)) Q:'IBX  D
 .. S IBCL(IBDT)=IBX
 .. S IBCL=IBCL+1
 ;
 ; If there is only one clock - no need to ask, just show
 I IBCL=1 S IBCLK=IBCL($O(IBCL(""))) D LSTCLK W ! Q IBCLK
 K Y
 F  D  Q:$D(DIRUT)  Q:$D(IBCL(Y))  W " ??"
 . ;Choose one
 . I $D(Y)!($G(IBSHOW)) W ! D LSTCLK W ! ; Bad enter - list options
 . K DIR,DIRUT
 . S DIR(0)="FE"
 . S DIR("A")="Choose LTC BILLING CLOCK (1-"_IBCL_")"
 . S DIR("B")=$$FMTE^XLFDT(+$O(IBCL(""),-1),"1D")
 . S DIR("?")="Enter date of the required LTC BILLING CLOCK. Enter '??' for clocks list."
 . S DIR("??")="^D LSTCLK^IBAECP"
 . D ^DIR Q:$D(DIRUT)
 . ; User may enter just number
 . I Y=+Y,Y>0,Y'>IBCL D  I IBY S Y=IBY Q
 .. S IBY="" F IBI=1:1:Y S IBY=$O(IBCL(IBY)) Q:IBY=""
 . S %DT="" D ^%DT ; Convert external to internal format
 I $D(DIRUT) Q -1
 W " (",$$FMTE^XLFDT(Y),")"
 Q IBCL(Y)
 ;
 ; Ask begin/end dates, with default values
 ; Input:  IBCLK - LTC Clock IEN
 ; Output: IBDT1,IBDT2 - begin/end dates
DATE N %DT,Y,IBDT,IBNOW
DATAGN ;Loop entry point
 S (IBDT1,IBDT2)=-1
 ; Get beginning date
 S IBDT=$P($G(^IBA(351.81,IBCLK,0)),U,3)
 S IBDT1=$$ASKDT("Start with DATE: ",IBDT)
 I IBDT1<1 Q
 ; Get ending date
 S IBDT=$P($G(^IBA(351.81,IBCLK,0)),U,4)
 S IBNOW=$$NOW()
 I 'IBDT S IBDT=IBNOW
 E  I IBDT>IBNOW S IBDT=IBNOW
 S IBDT2=$$ASKDT("Go to DATE: ",IBDT)
 I IBDT2<1 S IBDT1=-1 Q
 I IBDT2<IBDT1 W !,"Ending date must follow start date!",! G DATAGN
 Q
 ;
 ;Returns today's date in FM format
NOW() N %,%H,%I,X
 D NOW^%DTC
 Q X
 ;
 ; Ask - print free days or not?
 ; Input: none
 ; Output: IBOFD (bool) IBOFD=-1 if cancelled
ASKOFD ; Default - YES
 N DIR,Y,DUOUT
 S DIR(0)="Y",DIR("A")="Include DAYS NOT SUBJECT TO LTC COPAY on this report",DIR("B")="YES"
 D ^DIR
 S IBOFD=$S($G(DUOUT)!$G(DUOUT)!(Y="^"):-1,1:Y)
 Q
 ; Ask - print LTC events or not?
 ; Input: none
 ; Output: IBOEV (bool) IBOEV=-1 if cancelled
ASKOEV ; Default - YES
 N DIR,Y,DUOUT
 S DIR(0)="Y",DIR("A")="Include LTC EVENTS on this report",DIR("B")="YES"
 D ^DIR
 S IBOEV=$S($G(DUOUT)!$G(DTOUT)!(Y="^"):-1,1:Y)
 Q
 ; Double question mark action - for the "enter clock" dialog
 ; Input:
 ;   IBCL=<Number of clocks>
 ;   IBCL(<Clock date>)=<Clock IEN> local array - list of clocks
 ;   IBDFN= IEN of the patient
LSTCLK N IBZ,IBDT,IBCNT,IBDT2
 W !,$P(^DPT(IBDFN,0),U)," has the following LTC Copay Clock",$S(IBCL>1:"s",1:""),!
 S IBCNT=0
 S IBDT=0 F  S IBDT=$O(IBCL(IBDT)) Q:'IBDT  D
 . S IBX=IBCL(IBDT)
 . S IBZ=^IBA(351.81,IBX,0),IBCNT=IBCNT+1
 . W !?10,IBCNT,?15,$$FMTE^XLFDT(IBDT)
 . S IBDT2=$P(IBZ,U,4)
 . I IBDT2 W ?28," - ",$$FMTE^XLFDT(IBDT2)
 . W ?48,$$EXTERNAL^DILFD(351.81,.05,"",$P(IBZ,"^",5))
 Q
 ;
 ; Input: prompt, default value (FM format)
 ; Output: date (FM) or -1, if cancelled
ASKDT(IBPRMT,IBDFLT) ;Date input
 N DIR,Y,Y0,X,DIROUT,DIRUT
 I $G(IBPRMT)'="" S DIR("A")=IBPRMT
 I $G(IBDFLT)'="" S DIR("B")=$$FMTE^XLFDT(IBDFLT,"1D")
 S DIR(0)="DA"
 D ^DIR I $D(DIRUT) Q -1
 W " (",$$FMTE^XLFDT(Y),")"
 Q Y
 ;
 ;Enter PATIENT NAME (LTC Patients, having a clock only!)
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
 . S DIR("??")="^D ASKPATQQ^IBAECP"
 . D ^DIR Q:$D(DIRUT)
 . S X=Y
 . I X?3N1"-"2N1"-"4N.3A S X=$TR(X,"-","") ; Remove dashes from SSN
 . S DIC="^DPT(",DIC(0)="QME"
 . S DIC("S")="I $D(^IBA(351.81,""AE"",Y))"
 . S DIC("W")="D WRTPAT^IBAECP(+Y)"
 . N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 . D ^DIC Q:Y<1  ; Patient code
 . S Y=+$G(Y)
 . ;W "  " D WRTPAT(Y)
 I $D(DIRUT) Q -1
 Q +Y
 ;
ASKPATQQ N DIC,X,Y,IBDFN,IBI,DIR,DIRUT,DIROUT,DTOUT,DUOUT,IBCNT
 D ASKPHD
 S IBI=7,IBCNT=0
 ;S DIC="^DPT",DIC(0)="F",X="??" D ^DIC
 S IBDFN=0 F  S IBDFN=$O(^IBA(351.81,"AE",IBDFN)) Q:'IBDFN  D  Q:$D(DIRUT)
 . W ! S IBI=IBI+1
 . I IBI>IOSL S DIR(0)="E" D ^DIR W ! Q:$D(DIRUT)  W ! S IBI=3 ; D ASKPHD S IBI=4
 . ; S IBCNT=IBCNT+1
 . ; W $J(IBCNT,4)," ",?6
 . D WRTPAT(IBDFN)
 Q
 ;
ASKPHD ;Header
 N IBI
 W !,"Choose an LTC Patient:",!
 Q
 ;W !," LTC PATIENT NAME",?30,"BIRTH DATE",?45,"SSN",?55,"STATUS",?68,"CLK DATE"
 ;W ! F IBI=1:1:80 W "-"
 ;Q
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
