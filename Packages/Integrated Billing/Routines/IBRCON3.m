IBRCON3 ;ALB/RJS - TOP LEVEL ROUTINE FOR PASSING CONVERTED CHARGES - 4/28/92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBRCON3-1" D T0^%ZOSV ;start rt clock
 S DIR(0)="SAO^1:P;2:D"
 S DIR("A")="Pass converted charges by Patient or by Date (P/D): "
 S DIR("?",1)="Converted charges may be passed using Patient name or"
 S DIR("?",2)="Date selection criteria. If Patient is selected then"
 S DIR("?",3)="all billing actions with a status of 'Converted' will"
 S DIR("?",4)="be displayed. The user may then select which actions"
 S DIR("?",5)="will be passed to accounts receivable. If Date is"
 S DIR("?",6)="selected then all outpatient copay and fee service"
 S DIR("?",7)="billing actions that were created within the date"
 S DIR("?",8)="range selected (inclusive) and with a status of"
 S DIR("?")="'Converted' will be passed to accounts receivable."
 D ^DIR
 W !
 I Y=1 D ^IBRCON1 G END
 I Y=2 D ^IBRCON2 G END
END ;
 K DIR,Y
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBRCON3" D T1^%ZOSV ;stop rt clock
 Q
