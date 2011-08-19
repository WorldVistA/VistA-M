IBTODD2 ;ALB/AAS - CLAIMS TRACKING DENIED DAYS REPORT ; 13-JUN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**32**; 21-MAR-94
 ;
SUM ; -- Print summary report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"MCCR/UR DENIED DAYS Summary Report for Reviews Dated ",$$FMTE^XLFDT(IBBDT),$S(IBBDT'=IBEDT:" to "_$$FMTE^XLFDT(IBEDT),1:""),"  "
 W ?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !!,?35,"Number",?50,"Days",?65,"Amount",?80,"Days won",?100,"Maximum"
 W !,"Service",?35,"Denials",?50,"Denied",?65,"Denied",?80,"on Appeal",?100,"Billing Rate"
 W !,$TR($J(" ",IOM)," ","-")
 ;
 I $O(^TMP($J,"IBTODD",""))="" W !!,"No Denials Found in Date Range." G SUMQ
 ;
 S IBSERV="" F  S IBSERV=$O(IBCNT(IBSERV)) Q:IBSERV=""  D
 .W !,$$EXPAND^IBTRE(42.4,3,IBSERV)
 .W ?32,$J($P(IBCNT(IBSERV),"^",3),8)
 .W ?46,$J(+IBCNT(IBSERV),8)
 .S X=$P(IBCNT(IBSERV),"^",2),X2="0$" D COMMA^%DTC W ?60,X
 .W ?81,$J($P(IBCNT(IBSERV),"^",4),6)
 .S X=$P(IBCNT(IBSERV),"^",6),X2="0$" D COMMA^%DTC W ?95,X
 ;
 W !?48,"--------",!,?48,$J(IBTOTL,6)
SUMQ ;
 Q
 ;
 ;
SUBH(Z) ; -- write sub header for report
 ;    input z = subheader data
 ;    requires ibsort = how report is sorted
 I IOSL<($Y+8) D HDR^IBTODD1 Q:IBQUIT
 N X S X=""
 Q:IBSORT="P"  ; no sub header if sorting by patient
 I IBSORT="S" S X="Service: "_$$EXPAND^IBTRE(42.4,3,IBI)
 I IBSORT="A" S X="Attending: "_IBI
 I $L(X) W !!?15,X
 Q
 ;
SUBT ; -- write out sub totals, initialize variable
 I '$G(IBSUBT) G SUBTQ
 W !?64,"------",!,?64,$J(IBSUBT,6)
SUBTQ S IBSUBT=0
 Q
 ;
 ;
SORT ; Ask for sort criteria.
 W !!
 S DIR(0)="SOBA^P:PATIENT;A:ATTENDING;S:SERVICE"
 S DIR("A")="Print Report By [P]atient  [A]ttending  [S]ervice: "
 S DIR("B")="P"
 S DIR("?",1)="This report may be prepared by either Patient, Attending, or Service."
 S DIR("?",2)=""
 S DIR("?",3)=""
 S DIR("?",4)=""
 S DIR("?",5)=""
 S DIR("?",6)=""
 S DIR("?",7)=""
 S DIR("?",8)="  "
 S DIR("?")=""
 D ^DIR K DIR
 S IBSORT=Y I "PAS"'[Y!($D(DIRUT)) S IBSORT=-1
 Q
