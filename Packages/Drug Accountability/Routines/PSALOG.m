PSALOG ;BIR/LTL,JMB-Unposted Procurement History ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine gets the user specifications to print the Unposted
 ;Procurement History report for a specific month, the Item Total report,
 ;and High Dollar report. It calls PSALOG0 and PSALOG1.
 ;
 ;Get month
 D DT^DICRW S %DT="AEP",%DT("A")="Select month: ",%DT("B")="T-1M"
 D ^%DT S PSAYRMO=$E(Y,1,5)*100,PSAMO=$E(PSAYRMO,4,5) G:Y<0 EXIT
 X ^DD("DD") S PSAMOYR=$E(Y,1,3)_" '"_$E(PSAYRMO,2,3)
 ;
 S DIR(0)="Y",DIR("A")="Print item totals",DIR("B")="Yes",DIR("?",1)="Enter yes to print a report of the items ordered during the selected month.",DIR("?")="Enter no if you do not want to print the report."
 S DIR("??")="^D HELPTOT^PSALOG" W ! D ^DIR K DIR G:$G(DIRUT) EXIT S PSATOTAL=Y
 ;
 S DIR(0)="Y",DIR("A")="Print a high dollar items report",DIR("B")="Yes",DIR("?",1)="Enter yes to print a list of purchased items that cost a high",DIR("?")="dollar amount. Enter no if you do not want to print the report."
 S DIR("??")="^D HELPHIGH^PSALOG" W ! D ^DIR K DIR G:$G(DIRUT) EXIT G:'Y DEVICE S PSAHIGH=Y
 ;
 S DIR(0)="N",DIR("A")="Enter the lowest dollar amount to print $",DIR("B")=1000,DIR("?",1)="Enter the lowest dollar amount to be printed.",DIR("?")="Do not enter the dollar sign($).",DIR("??")="^D HELPLOW^PSALOG"
 W ! D ^DIR K DIR G:$G(DIRUT) EXIT S:Y PSALOW=Y
 ;
DEVICE W ! K IO("Q") S %ZIS="Q" D ^%ZIS
 I POP W !,"No device selected or report printed!" G EXIT
 I $D(IO("Q")) S ZTRTN="QUE^PSALOG",ZTDESC="Drug Accountability - Unposted Pharmacy Procurement Reports",ZTSAVE("PSA*")="" D ^%ZTLOAD
 I  G:$D(ZTSK) EXIT I '$D(ZTSK) W !,"The report was not sent to the printer." G EXIT
QUE ;Calls routines to print the 3 reports.
 U IO K ^TMP("PSA",$J),^TMP("PSAB",$J),^TMP("PSAC",$J)
 S PSASTART=1
 D ^PSALOG0 G:PSAOUT EXIT
 I $G(PSATOTAL) D ^PSALOG1 G:PSAOUT EXIT
 D:$G(PSAHIGH) ^PSALOG1H
EXIT W:$G(PSASTART) @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K IO("Q"),^TMP("PSA",$J),^TMP("PSAB",$J),^TMP("PSAC",$J)
 K %DT,%ZIS,DIR,DIRUT,PSAC,PSACP,PSADATE,PSADLN,PSADT,PSAFCP,PSAHIGH,PSAIEN,PSAINVO,PSAITEM,PSAKK,PSALOW,PSAMO,PSAMORE,PSAMOYR,PSAN0,PSAN1,PSAOUT,PSAPG
 K PSAQTYO,PSAQTYP,PSARPDT,PSASLN,PSASTART,PSATMP,PSATOT,PSATOTAL,PSATOTO,PSATOTP,PSATOTR,PSATQTYO,PSAUNIT,PSAYRMO,PSASS,X,X2,X3,Y,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE
 Q
HELPTOT ;Extended help for "Print item totals?"
 W !!,"Enter yes to print a report of the items purchased during the selected",!,"month. The report contains the total dollar amount per item per purchase"
 W !,"order. The report lists the purchase order number, date ordered quantity,",!,"ordered, quantity received, dollar amount per dispensed unit, dispensed"
 W !,"unit, total order cost, and total cost of items received."
 W !!,"Enter no if you do not want to print the report."
 Q
HELPHIGH ;Extended help for "Print a high dollar items report?"
 W !!,"Enter yes to choose a cut-off dollar amount and print the report.",!,"The report lists the items from highest to lowest dollar amounts."
 Q
HELPLOW ;Extended help for "Enter the lowest dollar amount to print $"
 W !!,"Enter the lowest dollar amount paid for an order of an item. The",!,"dollar amount is the total amount paid for the item on a purchase order."
 W !,"For example, if a drug cost $500 per unit and 3 units were ordered, the",!,"total dollar amount is $1500. In order to print this item on the report,",!,"the lowest dollar amount to print must be $1500 or less."
 Q
