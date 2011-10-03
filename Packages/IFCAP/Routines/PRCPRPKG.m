PRCPRPKG ;WISC/RFJ-packaging discrepancy report                     ;04 Oct 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "WP"'[PRCP("DPTYPE") W !,"THIS PROGRAM CAN ONLY BE USED BY THE WAREHOUSE OR PRIMARY INVENTORY POINTS." Q
 N WHSESRCE,X,Y
 S WHSESRCE=$O(^PRC(440,"AC","S",0)) I 'WHSESRCE W !!,"YOU DO NOT HAVE A VENDOR (FILE #440) ENTERED AS A SUPPLY WAREHOUSE.",! Q
 ;  get selected item list
 D ITEMSEL^PRCPURS4
 I '$O(^TMP($J,"PRCPURS4",0)),'$D(PRCPALLI) Q
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Packaging Discrepancy Report",ZTRTN="DQ^PRCPRPKG"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,""PRCPURS4"",")="",ZTSAVE("WHSESRCE")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue comes here
 ;  find errors
 D PROCESS^PRCPRPK1
 ;  print errors
 D PRINT^PRCPRPK2
Q K ^TMP($J,"PRCPURS4"),^TMP($J,"PRCPRPKG") D ^%ZISC
 Q
