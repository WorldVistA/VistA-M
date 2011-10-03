IBDFFV ;ALB/CMR - AICS FORM VALIDATION ; NOV 22,1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**51**;APR 24, 1997
 ;
 ; -- displays Form Definition values for validation
 ;
 W !,?4,"** This option is OUT OF ORDER **" QUIT   ;Code set Versioning
 ;
 N IBDFL,X,Y,I,POP,CALL
 W !!,"AICS Form Validation Report",!!
 S IBDFL=0 ;flag
 D SORT G:IBDFL EXIT
 D DEVICE G:IBDFL EXIT
DQ ; -- entry point from task man
 N IBDFL
 K ^TMP($J,"IBFV"),^TMP($J,"IBDF","UC")
 S IBDFL=0
 D ^IBDFFV1
 I '$D(^TMP($J,"IBFV")) U IO W $C(7),!,"No forms found!" G EXIT
 D ^IBDFFV2 G EXIT:$G(IBDFOUT)
 I $D(^TMP($J,"IBDF","UC")) D
 .N SORT,FORM,CLIN,HEADER
 .S SORT=$O(^TMP($J,"IBDF","UC","")) Q:SORT']""
 .D HDR
 .I SORT="F" S FORM="" F  S FORM=$O(^TMP($J,"IBDF","UC",SORT,FORM)) Q:FORM']""!($G(IBDFOUT))  D PG(2) Q:$G(IBDFOUT)  W !?5,FORM
 .I SORT="C" S CLIN="" F  S CLIN=$O(^TMP($J,"IBDF","UC",SORT,CLIN)) Q:CLIN']""!($G(IBDFOUT))  D PG(5) Q:$G(IBDFOUT)  W !!,"CLINIC:  ",CLIN D
 ..S FORM="" F  S FORM=$O(^TMP($J,"IBDF","UC",SORT,CLIN,FORM)) Q:FORM']""!($G(IBDFOUT))  D PG(2) Q:$G(IBDFOUT)  W !?5,FORM
 .I SORT="D"!(SORT="G") S HEADER="" F  S HEADER=$O(^TMP($J,"IBDF","UC",SORT,HEADER)) Q:HEADER']""!($G(IBDFOUT))  D PG(7) Q:$G(IBDFOUT)  W !!,$S(SORT="G":"GROUP",1:"DIVISION"),":  ",HEADER D
 ..S CLIN="" F  S CLIN=$O(^TMP($J,"IBDF","UC",SORT,HEADER,CLIN)) Q:CLIN']""!($G(IBDFOUT))  D PG(5) Q:$G(IBDFOUT)  W !!?5,"CLINIC:  ",CLIN D
 ...S FORM="" F  S FORM=$O(^TMP($J,"IBDF","UC",SORT,HEADER,CLIN,FORM)) Q:FORM']""!($G(IBDFOUT))  D PG(2) Q:$G(IBDFOUT)  W !?10,FORM
EXIT ; -- Clean up and quit
 K ^TMP($J,"IBDF","UC"),^TMP($J,"IBFV")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K ZTSK,ZTDESC,ZTSAVE,ZTRTN,VAUTF,VAUTG,VAUTC,VAUTD,SORT,IBDFOUT
 Q
SORT ; -- determine sort criteria
 S DIR(0)="S^1:FORM;2:CLINIC;3:GROUP;4:DIVISION",DIR("A")="Validate forms by" D ^DIR K DIR
 I $D(DIRUT) S IBDFL=1 Q
 S SORT=Y_U_Y(0),CALL=$S(Y=2:"CLIN",Y=4:"DIV",1:Y(0))
 ; -- gather selections for sort chosen
 D @CALL^IBDFUTL
 Q
DEVICE ; -- ask device
 S %ZIS="MQ" D ^%ZIS I POP S IBDLF=1 Q
 I $D(IO("Q")) S ZTRTN="DQ^IBDFFV",ZTDESC="AICS - Form Validation Report",ZTSAVE("VA*")="",ZTSAVE("SORT")="" D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled") D HOME^%ZIS S IBDFL=1 Q
 U IO
 Q
PG(LEN) ; -- check page length
 ; -- LEN equal to length to check for (optional)...will default
 I '$D(LEN) S LEN=2
 Q:$Y+LEN<IOSL
 I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR,DIRUT,DUOUT,DTOUT I 'Y S IBDFOUT=1 Q
 W @IOF
HDR ; -- write out uncompiled forms header
 W !,$$CJ^XLFSTR("ENCOUNTER FORM VALIDATION",IOM)
 W !,$$CJ^XLFSTR("REPORT OF UNCOMPILED FORMS",IOM)
 W !!!,"Validation can only be performed on compiled forms.  To compile a form,",!,"you simply print it."
 W !!!,"The following forms were found to be uncompiled:"
 Q
