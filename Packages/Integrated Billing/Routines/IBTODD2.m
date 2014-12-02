IBTODD2 ;ALB/AAS - CLAIMS TRACKING DENIED DAYS REPORT ; 13-JUN-95
 ;;2.0;INTEGRATED BILLING;**32,458**;21-MAR-94;Build 4
 ;
SUM ; -- Print summary report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"MCCR/UR DENIED DAYS Summary Report for Reviews Dated ",$$FMTE^XLFDT(IBBDT),$S(IBBDT'=IBEDT:" to "_$$FMTE^XLFDT(IBEDT),1:""),"  "
 W ?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 ;
 I $O(^TMP($J,"IBTODD",""))="" W !!,"No Denials Found in Date Range." G SUMQ
 ;
 I $O(IBCNT(""))'="" D
 .W !!,?35,"Number",?50,"Days",?65,"Amount",?80,"Days won"
 .W !,"Service",?35,"Denials",?50,"Denied",?65,"Denied",?80,"on Appeal"
 .W !,$TR($J(" ",IOM)," ","-")
 .;
 .S IBSERV="" F  S IBSERV=$O(IBCNT(IBSERV)) Q:IBSERV=""  D
 ..W !,$$EXPAND^IBTRE(42.4,3,IBSERV) I IBSERV="UNKNOWN" W IBSERV
 ..W ?32,$J($P(IBCNT(IBSERV),"^",3),8)
 ..W ?46,$J(+IBCNT(IBSERV),8)
 ..S X=$P(IBCNT(IBSERV),"^",2),X2="0$" D COMMA^%DTC W ?60,X
 ..W ?81,$J($P(IBCNT(IBSERV),"^",4),6)
 ..;S X=$P(IBCNT(IBSERV),"^",6),X2="0$" D COMMA^%DTC W ?95,X
 .;
 .W !?48,"--------",!,?48,$J(IBTOTL,6)
 ;
 I $O(IBCNTO(""))'="" D
 .W !!,?35,"Number",?65,"Amount",?91,"Appeals"
 .W !,"Service",?35,"Denials",?65,"Denied",?81,"Appealed",?91,"Approved"
 .W !,$TR($J(" ",IOM)," ","-")
 .;
 .S IBSERV="" F  S IBSERV=$O(IBCNTO(IBSERV)) Q:IBSERV=""  D
 ..W !,IBSERV
 ..W ?32,$J($P(IBCNTO(IBSERV),"^",3),8)
 ..S X=$P(IBCNTO(IBSERV),"^",2),X2="0$" D COMMA^%DTC W ?60,X
 ..W ?81,$J($P(IBCNTO(IBSERV),"^",4),6)
 ..W ?91,$J($P(IBCNTO(IBSERV),"^",5),6)
SUMQ ;
 Q
 ;
 ;
SUBH(Z) ; -- write sub header for report
 ;    input z = subheader data
 ;    requires ibsort = how report is sorted
 I IOSL<($Y+8) D HDR^IBTODD1 Q:IBQUIT
 N X,Y S X=""
 Q:IBSORT="P"  ; no sub header if sorting by patient
 Q:IBEVNTYP'=1  ; no sub header if not inpatient
 I IBSORT="S" S Y=$$EXPAND^IBTRE(42.4,3,IBI) S X="Service: "_$S(Y'="":Y,1:IBI)
 I IBSORT="A" S X="Attending: "_IBI
 I $L(X) W !!?15,X
 Q
 ;
SUBT ; -- write out sub totals, initialize variable
 I '$G(IBSUBT) G SUBTQ
 W !?54,"------",!,?54,$J(IBSUBT,6)
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
 ;
TYPE ; Ask for the Type of Care to include, IBSELECT defined on exit
 N IBPRT,IBEPS
 S IBPRT="Choose denials for which types of care to print:"
 S IBEPS(1)="INPATIENT",IBEPS(2)="OUTPATIENT",IBEPS(3)="PROSTHETICS",IBEPS(4)="PHARMACY",IBEPS(5)="ALL DENIALS"
 S IBSELECT=$$MLTP^IBJD(IBPRT,.IBEPS,1)
 Q
