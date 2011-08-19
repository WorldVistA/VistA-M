PRCPBAL2 ;WISC/RFJ-autogenerate orders for secondaries uploaded     ;04 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
AUTOGEN ;  autogenerate secondaries
 K ^TMP($J,"PRCPBALMAG"),^TMP($J,"PRCPBAL3")
 S INVPT=0 F  S INVPT=$O(^TMP($J,"PRCPBALMU",INVPT)) Q:'INVPT  I $P($G(^PRCP(445,INVPT,0)),"^",3)="S",$P($G(^PRCP(445,INVPT,0)),"^",2)="Y" Q
 ;  no sceondaries uploaded
 I 'INVPT Q
 W !!,"AUTOGENERATING UPLOADED SECONDARIES..."
 I '$G(PRCP("I")) N PRCP S PRCP("DPTYPE")="P" K X S X(1)="Select the PRIMARY inventory point which will be used as the distribution point for the secondaries." W ! D DISPLAY^PRCPUX2(1,40,.X),^PRCPUSEL Q:'$G(PRCP("I"))
 S INVPT=0 F  S INVPT=$O(^TMP($J,"PRCPBALMU",INVPT)) Q:'INVPT  I $P($G(^PRCP(445,INVPT,0)),"^",3)="S",$P($G(^PRCP(445,INVPT,0)),"^",2)="Y",$D(^PRCP(445,PRCP("I"),2,INVPT)) S ^TMP($J,"PRCPBALMAG",INVPT)=""
 I '$O(^TMP($J,"PRCPBALMAG",0)) Q
 K X S X(1)="The following perpetual secondaries have been uploaded and are distribution points for "_$$INVNAME^PRCPUX1(PRCP("I"))_":" W ! D DISPLAY^PRCPUX2(5,75,.X)
 S INVPT=0 F  S INVPT=$O(^TMP($J,"PRCPBALMAG",INVPT)) Q:'INVPT  W !?10,$$INVNAME^PRCPUX1(INVPT)
 S XP="Do you want to start autogenerating distribution orders now",XH="Enter YES to start autogenerating orders for the secondaries, NO or ^ to exit."
 I $$YN^PRCPUYN(2)'=1 Q
 ;
 N PRCPFBAR,PRCPIO
 ;
 K X S X(1)="The normal reports showing the errors during autogeneration, items with vendors not selected, items not ordered, etc. will not be printed.  You have the option to print the report showing the items ordered."
 W ! D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Do you want to print the report showing the items ordered",XH="Enter YES to print the report showing the items ordered during autogeneration,",XH(1)="NO to skip printing the report, or ^ to exit."
 S %=$$YN^PRCPUYN(2) I %<1 Q
 I %=1 D  Q:'$D(PRCPIO)
 .   K X S X(1)="Select the DEVICE for printing the ordered items.  This report will be automatically queued to print for you." W ! D DISPLAY^PRCPUX2(5,75,.X)
 .   F  S %ZIS="NQ" D ^%ZIS Q:POP!(IO'=IO(0))  W !,"YOU CANNOT SELECT YOUR CURRENT DEVICE."
 .   I POP Q
 .   S PRCPIO=ION
 ;
 S INVPT=0 F  S INVPT=$O(^TMP($J,"PRCPBALMAG",INVPT)) Q:'INVPT  D
 .   ;  set prcpfbar flag to the primary to fill the order.  This
 .   ;  flag will be used to stop the printing of all autogeneration
 .   ;  reports
 .   S PRCPFBAR=PRCP("I")
 .   N PRCP
 .   D PARAM^PRCPUSEL(INVPT)
 .   W !!,"**** AUTOGENERATING FROM INVENTORY POINT: ",PRCP("IN")," ****"
 .   K ^TMP($J,"PRCPAG")
 .   ;  selected vendor
 .   S ^TMP($J,"PRCPAG","V",PRCPFBAR)=""
 .   D START^PRCPAGS1
 .   I $D(PRCPIO),$O(^TMP($J,"PRCPAG","OK",""))'="" D
 .   .   W !,"<<< Printing Items Ordered Report"
 .   .   S ZTDESC="Bar Code Upload Autogenerate",ZTRTN="ORDER^PRCPAGRO",ZTIO=PRCPIO,ZTDTH=$H,ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,")="",ZTSAVE("ZTREQ")="@"
 .   .   D ^%ZTLOAD K ZTSK
 .   K ^TMP($J,"PRCPAG")
 ;
 ;  if orders in ^tmp($j,"prcpbal3",orderda), ask to release
 I '$O(^TMP($J,"PRCPBAL3",0)) Q
 K X S X(1)="       F I N I S H E D   A U T O G E N E R A T I O N     " W ! D DISPLAY^PRCPUX2(1,79,.X)
 ;  show orders created
 K X S X(1)="The following is the list of the orders created showing the order number and secondary inventory point generating the order." W ! D DISPLAY^PRCPUX2(5,75,.X)
 S %=0 F  S %=$O(^TMP($J,"PRCPBAL3",%)) Q:'%  S X=$G(^PRCP(445.3,%,0)) I X'="" W !?5,"order number ",$J($P(X,"^"),5)," from secondary ",$$INVNAME^PRCPUX1($P(X,"^",3))
 K X S X(1)="You have the option to release all the orders which were just created by this barcode upload." W !! D DISPLAY^PRCPUX2(2,40,.X)
 S XP="Do you want to release all the orders created during the barcode upload",XH="Enter YES to release all the orders created, NO or ^ to exit."
 I $$YN^PRCPUYN(1)'=1 Q
 D RELEASE^PRCPBAL3
 ;
 ;  if orders in ^tmp($j,"prcpbal3",orderda), ask to print pick tickets
 I '$O(^TMP($J,"PRCPBAL3",0)) Q
 K X S X(1)="You have the option to print the picking tickets for all the orders just released." W !! D DISPLAY^PRCPUX2(2,40,.X)
 S XP="Do you want to print the picking ticket for the orders just released",XH="Enter YES to print the picking ticket for the orders just released, NO or ^ to exit."
 I $$YN^PRCPUYN(1)'=1 Q
 D PICKTICK^PRCPBAL3
 Q
