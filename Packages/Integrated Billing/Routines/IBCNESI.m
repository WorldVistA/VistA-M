IBCNESI ;ALB/TAZ - Potential Medicare COB Prompts ;15-JAN-2013
 ;;2.0;INTEGRATED BILLING;**497**;21-MAR-94;Build 120
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;PRIMARY ENTRY POINT
 N IBSDT,IBEDT,IBCOMP,IBREP,IBSORT,IBERD
 ;
 S IBERD=$P($O(^IBCN(365,"AD","")),".",1)
 W !,"The earliest date in the IIV RESPONSE file is "_$$FMTE^XLFDT(IBERD),!!
Q1 ; Question 1 - Begin Search Date
 N X,Y,DIRUT
 S DIR(0)="DA^"_IBERD_":DT:EX"
 S DIR("A")="Select Earliest Report Date: ",DIR("B")="TODAY-7"
 S DIR("?",1)="   Please enter a valid date for which an eIV Response"
 S DIR("?",2)="   would have been received (earliest date is "_$$FMTE^XLFDT(IBERD)_")."
 S DIR("?")="   Future dates are not allowed."
 D ^DIR K DIR
 I $D(DIRUT) G ENQ
 S IBSDT=+Y
 ;
Q2 ; Question 2 - End Search Date
 S DIR(0)="DA^"_IBSDT_":DT:EX"
 S DIR("A")="Select Latest Report Date ",DIR("B")="TODAY"
 S DIR("?",1)="   Please enter a valid date for which an eIV Response"
 S DIR("?",2)="   would have been received.  This date must not precede"
 S DIR("?")="   the Start Date.  Future dates are not allowed."
 D ^DIR K DIR
 I $D(DIRUT) G ENQ
 S IBEDT=+Y
 ;
Q3 ;Question 3 - Sort Criteria
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:Chronological Order;2:Reverse Chronological Order"
 S DIR("A")="Sort Report By: "
 S DIR("B")="Chronological Order"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y<0) G ENQ
 S IBSORT=$S(Y=2:"-1",1:"+1")
 ;
Q4 ;
 S DIR(0)="SA^R:Report;S:Screen List"
 S DIR("A")="Do you want a (R)eport or a (S)creen List format?: "
 S DIR("B")="Screen List"
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G ENQ
 S IBREP=Y
 ;
 I IBREP="S" S IBCOMP=0 D LIST^IBCNESI1 G ENQ
 ;
Q5 ; Include completed entries
 W !!,"1) Display COMPLETED entries, but do not display any comments"
 W !,"2) Display COMPLETED entries along with any associated comments"
 W !!,"3) Display non-COMPLETED entries, but do not display any comments"
 W !,"4) Display non-COMPLETED entries along with any associated comments",!
 S DIR("A")="Which report type do you want? "
 S DIR(0)="SA^1:Display COMPLETED entries, but do not display any comments;2:Display COMPLETED entries along with any associated comments"
 S DIR(0)=DIR(0)_";3:Display non-COMPLETED entries, but do not display any comments;4:Display non-COMPLETED entries along with any associated comments"
 S DIR("B")=1
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G ENQ
 S IBCOMP=Y
 ;
Q6 ; Select device
 F  S IBACT=0 D DEVSEL(.IBACT) Q:IBACT
 I IBACT=99 G ENQ
 U IO
 D LIST^IBCNESI1
 ;
ENQ ;
 Q
 ;
DEVSEL(IBACT) ;
 N DIR,POP,X,Y,ZTRTN,ZTSAVE,ZTDESC,IBOK,%ZIS
 W !!,"You will need a 132 column printer for this report!"
 S %ZIS="QM" D ^%ZIS I POP S IBACT=99 G DEVSELQ
 I $G(IOM),IOM<132 S IBOK=1 D  I 'IBOK S IBACT=0 G DEVSELQ
 . S DIR(0)="YA",DIR("A",1)="This report requires output to a 132 column device."
 . S DIR("A",2)="The device you have chosen is only set for "_IOM_"."
 . S DIR("A")="Are you sure you want to continue?: ",DIR("B")="No"
 . W ! D ^DIR K DIR
 . I Y'=1 S IBOK=0 W !
 I $D(IO("Q")) D  S IBACT=99 G DEVSELQ
 . K IO("Q")
 . S ZTRTN="LIST^IBCNESI",ZTSAVE("IBCRIT(")="",ZTSAVE("IB*")="",ZTSAVE("^TMP(""IB_POT_COB_RPT"",$J)")="",ZTDESC="IBCNE - Potential COB Report"
 . D ^%ZTLOAD K ZTSK D HOME^%ZIS
 S IBACT=1
DEVSELQ ;
 Q
 ;
