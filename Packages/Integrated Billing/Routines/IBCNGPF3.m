IBCNGPF3 ;ALB/CJS - LIST GRP. PLANS W/O ANNUAL BENEFITS (PRINT) ;21-JAN-15
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Print the report.
 ;  Required Input:  Global print array ^TMP($J,"IBGP"
 ;                   local variables IBABY, IBOUT
 ; 
EN N IBC,IBHDT,IBI,IBP,IBPAG,IBPD,IBQUIT,%,ZTQUEUED,ZTREQ
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S (IBI,IBQUIT,IBPAG)=0
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 S IBABY=$E($$FMTE^XLFDT(IBABY,"7D"),1,4)
 ;
 ;Excel header
 I IBOUT="E" D PHDL
 ;
 ; ^TMP($J,"IBGP",Counter)=ins. co. name^addr^city, st  zip^phone^precert phone^reimburse?^type of coverage
 ;  ^TMP($J,"IBGP",Counter,Plan IEN)=group name^group number^act/inact^last edited by^plan type
 F  S IBI=$O(^TMP($J,"IBGP",IBI)) Q:'IBI  S IBC=$G(^(IBI)) D:IBOUT="R" COMP D  Q:IBQUIT
 .S IBP=0 F  S IBP=$O(^TMP($J,"IBGP",IBI,IBP)) Q:'IBP  S IBPD=$G(^(IBP)) D  Q:IBQUIT
 ..I IBOUT="E" W !,IBC_U_IBPD Q
 ..I $Y>(IOSL-8) D PAUSE Q:IBQUIT  D COMP
 ..D PLAN
 ;
 I 'IBQUIT D PAUSE
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBC,IBHDT,IBI,IBP,IBPAG,IBPD,IBQUIT,^TMP($J,"IBGP")
 Q
 ;
 ;
COMP ; Print Company header
 I IBPAG D PAUSE
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"LIST OF GROUP PLANS BY INSURANCE COMPANY WITHOUT ANNUAL BENEFITS"
 W ?IOM-34,IBHDT,?IOM-10,"Page: ",IBPAG
 W !,"Benefit Year Selected: ",IBABY
 W !,$TR($J(" ",IOM)," ","-")
 ;
 ; - sub-header
 W !,"INSURANCE COMPANY NAME: ",$P(IBC,"^"),?61,"PHONE: ",$P(IBC,"^",4)
 W !?24,$P(IBC,"^",2),?61,"PRECERT PHONE: ",$P(IBC,"^",5)
 W !?24,$P(IBC,"^",3)
 W !!,"REIMBURSE",?20,"TYPE OF COVERAGE",?40,"GROUP NAME",?62,"GROUP NUMBER",?81,"ACTIVE/INACTIVE",?98,"LAST PERSON TO EDIT",?119,"TYPE OF PLAN"
 Q
 ;
PLAN ; Print plan information.
 W !!,$E($P(IBC,U,6),1,18),?20,$E($P(IBC,U,7),1,18),?40,$P(IBPD,U),?62,$P(IBPD,U,2),?81,$P(IBPD,U,3),?98,$E($P(IBPD,U,4),1,19),?119,$E($P(IBPD,U,5),1,13)
 Q
 ;
PAUSE ; Pause for screen output.
 N IBJJ,DIR
 Q:$E(IOST,1,2)'["C-"
 ;F IBJJ=$Y:1:(IOSL-8) W !   ; IB*2.0*528 - CJS - Fix scrolling problem
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT,IBJJ
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 S X="Insurance Company Name^Street Address^City, ST  Zip^Phone^Precertification Phone^Reimburse?^Type of Coverage^"
 S X=X_"Group Name^Group Number^Active/Inactive^Last Person to Edit^Type of Plan"
 W X
 K X
 Q
