IBOMTC1 ;ALB/CPM-BILLING ACTIVITY LIST (CON'T) ; 09-JAN-92
 ;;2.0;INTEGRATED BILLING;**145,176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOMTC-2" D T0^%ZOSV ;start rt clock
 ; Select charges from file #350.
 K ^TMP($J,"IBPHT")
 S DFN="" F  S DFN=$O(^IB("AFDT",DFN)) Q:'DFN  S IBHEART=$$PH(DFN) D:'$G(IBPURPHT)!($G(IBPURPHT)&(IBHEART))
 . S EVDT=-(IBEDT+.99) F  S EVDT=$O(^IB("AFDT",DFN,EVDT)) Q:'EVDT  D
 ..  S EVDA=0 F  S EVDA=$O(^IB("AFDT",DFN,EVDT,EVDA)) Q:'EVDA  D
 ...   S IBDA=0 F IBCNT=1:1 S IBDA=$O(^IB("AF",EVDA,IBDA)) Q:'IBDA  D
 ....    Q:'$D(^IB(IBDA,0))  S IBD0=^(0)
 ....    Q:$P(IBD0,"^",8)["ADMISSION"
 ....    I $P(IBD0,"^",15)<IBBDT!($P(IBD0,"^",14)>IBEDT) Q
 ....    S NAM=$P($G(^DPT(DFN,0)),"^") S:NAM="" NAM="UNKNOWN"
 ....    S ^TMP($J,"IBOMTC",NAM_"@@"_DFN,+$P(IBD0,"^",14),IBDA)=""
 ....    I IBHEART S ^TMP($J,"IBPHT",NAM_"@@"_DFN)=""
 ;
 ; Print report.
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 S IBLINE="",$P(IBLINE,"-",IOM+1)="",(IBPAG,IBQUIT)=0 D HDR G:IBQUIT END
 I '$D(^TMP($J,"IBOMTC")) S IBX=$S($G(IBPURPHT):"Purple Heart Recipients",1:"Bills") W !!,"There are no "_IBX_" for this date range." G END
 ;
 S NAM="" F  S NAM=$O(^TMP($J,"IBOMTC",NAM)) Q:NAM=""  D  Q:IBQUIT
 . S IBPT=$$PT^IBEFUNC($P(NAM,"@@",2))
 . I $Y>(IOSL-5) D PHT,PAUSE^IBOUTL Q:IBQUIT  D HDR Q:IBQUIT
 . W !,$S($D(^TMP($J,"IBPHT",NAM)):"*",1:" ")_$E($P(IBPT,"^"),1,9),?11,$P(IBPT,"^",3)
 . S IBDT="" F  S IBDT=$O(^TMP($J,"IBOMTC",NAM,IBDT)) Q:'IBDT  D  Q:IBQUIT
 ..  S IBDA="" F  S IBDA=$O(^TMP($J,"IBOMTC",NAM,IBDT,IBDA)) Q:'IBDA  D  Q:IBQUIT
 ...  I $Y>(IOSL-4) D PHT,PAUSE^IBOUTL Q:IBQUIT  D HDR Q:IBQUIT  W !,$S($D(^TMP($J,"IBPHT",NAM)):"*",1:" ")_$E($P(IBPT,"^"),1,9),?11,$P(IBPT,"^",3)
 ...  S IBD0=$G(^IB(+IBDA,0)) Q:'IBD0
 ...  S X=$P($P($G(^IBE(350.1,+$P(IBD0,"^",3),0)),"^")," ",2,99)
 ...  W ?17,$E($P(X," ",1,$L(X," ")-1),1,16)
 ...  W ?35,$E($P($G(^IBE(350.21,+$P(IBD0,"^",5),0)),"^",2),1,11)
 ...  W ?47,$$DAT1^IBOUTL($P(IBD0,"^",14)),?57,$$DAT1^IBOUTL($P(IBD0,"^",15))
 ...  W ?66,$J($P(IBD0,"^",6),3)
 ...  S X=$P(IBD0,"^",7),X2="2$",X3=10 D COMMA^%DTC W ?70,X,!
 ;
 ; - close device and quit
END D:'IBQUIT PHT,PAUSE^IBOUTL K ^TMP($J,"IBOMTC"),^TMP($J,"IBPHT")
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTC1" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K NAM,DFN,EVDA,EVDT,IBD0,IBDA,IBDT,IBJ,IBQUIT,IBLINE,IBHDT,IBHEART,IBN,IBPAG,IBPT,IBCNT,X,X2,X3
 D ^%ZISC Q
 ;
 ;
HDR ; Print header.
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1 W !,IBDESC,?IOM-35,IBHDT,?IOM-9,"Page: ",IBPAG
 I $G(IBPURPHT)  W !,"  * This report is being generated for Purple Heart Patients only *"
 W !,"Charges from ",$$DAT1^IBOUTL(IBBDT)," through ",$$DAT1^IBOUTL(IBEDT)
 W !,"PATIENT/ID",?17,"DESCRIPTION",?35,"STATUS",?49,"FROM",?60,"TO",?66,"UNITS",?72,"CHARGE"
 W !,IBLINE
 S IBQUIT=$$STOP^IBOUTL("Billing Activity List")
 Q
PHT ;ADDS the footnote of * Purple Heart Recipient to the report.
 W !,?10,"*  Purple Heart Recipient"
 Q
 ;
 ;
PH(DFN) ;Call to find out if a patient is a Purple Heart recipient.
 ;    DFN - patient's DFN
 ;
 ;    Output - 1 means PH Indicator is "Yes"
 ;             0 means PH Indicator is not "yes" (either "no" or null)
 I '$D(^DPT(+$G(DFN),0)) Q 0
 N IBPHT,VASV,VAERR
 D SVC^VADPT
 S IBPHT=$P($G(VASV(9,1)),"^",1)
 I IBPHT'=3 S IBPHT=0
 Q IBPHT
