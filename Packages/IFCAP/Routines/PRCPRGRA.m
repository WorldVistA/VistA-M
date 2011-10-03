PRCPRGRA ;WISC/RFJ-graph using list manager                         ;09 Feb 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N BARCHART,ITEMDA,PRCPINPT,PRCPFAVG
 S PRCPINPT=PRCP("I")
 F  W !! S ITEMDA=$$ITEM^PRCPUITM(PRCP("I"),0,"","") Q:'ITEMDA  D
 .   S XP="Do you want a BAR CHART",XH="Enter YES to display a BARCHART, NO to display a LINE CHART"
 .   W ! S %=$$YN^PRCPUYN(1) I %<1 Q
 .   S BARCHART=$S(%=1:1,1:0)
 .   S XP="Do you want to include ZERO values when calculating the AVERAGE",XH="Enter YES to include ZERO values when calculating the AVERAGE, NO to calculate",XH(1)="average using values greater than zero."
 .   W ! S %=$$YN^PRCPUYN(1) I %<1 Q
 .   S PRCPFAVG=$S(%=1:1,1:0)
 .   D EN^VALM("PRCP GRAPH DATA")
 Q
 ;
 ;
HDR ;  build header
 S VALMHDR(1)="INVENTORY POINT: "_$$INVNAME^PRCPUX1(PRCPINPT)_"  * * * ITEM MASTER NUMBER: "_ITEMDA_" * * *"
 S VALMHDR(2)="  DESCRIPTION: "_$$DESCR^PRCPUX1(PRCPINPT,ITEMDA)_"    NSN: "_$$NSN^PRCPUX1(ITEMDA)
 Q
 ;
 ;
INIT ;  build array
 N DATA,DATE,X1,X2,YLINE
 S X1=DT,X2=-400 D C^%DTC S DATE=$E(X,1,5)
 F  S DATE=DATE+1 S:$E(DATE,4,5)=13 DATE=($E(DATE,1,3)+1)_"01" Q:DATE>$E(DT,1,5)  D
 .   S DATA(DATE)=+$P($G(^PRCP(445,PRCPINPT,1,ITEMDA,2,DATE,0)),"^",2)
 D GETGRAPH^PRCPRGRU("*** AMOUNT USED VERSUS MONTH-YR USED ***","AMOUNT USED","MONTH-YR","S Y=X D DD^%DT S X(1)=$E(X,2,3),X=$E(Y,1,3)",BARCHART,PRCPFAVG,.DATA)
 K ^TMP($J,"PRCPRGRA")
 F VALMCNT=1:1 Q:'$D(YLINE(VALMCNT))  S ^TMP($J,"PRCPRGRA",VALMCNT,0)=YLINE(VALMCNT)
 S VALMCNT=VALMCNT-1
 Q
 ;
 ;
EXIT ;  exit and clean up
 K ^TMP($J,"PRCPRGRA")
 Q
