PRCPRALS ;WISC/RFJ/DST-automatic level setter                           ;28 Dec 93
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,%DT,%I,DIR,GROUPALL,PRCPALLI,PRCPDNSL,PRCPFITM,PRCPFLAG,PRCPFSET,PRCPPESL,PRCPPORP,PRCPPSRP,PRCPSTDT,PRCPTDAY,X,X1,X2,XH,XP,Y
 N ODIS  ; for On-Demand Item display selection
 K X S X(1)="The Automatic Level Setter will calculate and reset the Normal Stock Level, Emergency Stock Level, Standard Reorder Point, and Optional Reorder Point for selected items or items in selected group categories."
 D DISPLAY^PRCPUX2(40,79,.X)
 S DIR(0)="S^1:ITEM;2:GROUP CATEGORY",DIR("A")="Select Items BY",DIR("B")="ITEM" D ^DIR K DIR I Y'=1,Y'=2 Q
 S PRCPFITM=$S(Y=1:1,1:0)
 ;  select items by group
 I 'PRCPFITM D  I $G(PRCPFLAG) D Q Q
 .   K X S X(1)="Select the Group Categories to display" D DISPLAY^PRCPUX2(2,40,.X)
 .   D GROUPSEL^PRCPURS1(PRCP("I"))
 .   I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) S PRCPFLAG=1 Q
 .   W !,"NOTE:  The report will",$S('$G(GROUPALL):" NOT",1:"")," include items not stored in a group category."
 ;  select individual items
 I PRCPFITM=1 D ITEMSEL^PRCPURS4 I '$O(^TMP($J,"PRCPURS4",0)),'$D(PRCPALLI) D Q Q
 W !
 ; Prompt for On-Demand Item selection, if not warehouse
 I PRCP("DPTYPE")'="W",('$D(^TMP($J,"PRCPURS4"))) S ODIS=$$ODIPROM^PRCPUX2(0)
 I PRCP("DPTYPE")'="W",('$D(^TMP($J,"PRCPURS4"))),('+$G(ODIS)) D Q Q
 ;
 K X S X(1)="The average daily usage will be calculated from the selected date to the current date." D DISPLAY^PRCPUX2(1,40,.X)
 S X1=DT,X2=-120 D C^%DTC S (X,Y)=$E(X,1,5)_"00" D DD^%DT
 S %DT="AEP",%DT("A")="Start Usage Average with Date (Month Year): ",%DT("B")=Y,%DT(0)=-X D ^%DT K %DT I Y<0 D Q Q
 S PRCPSTDT=$E(Y,1,5),Y=PRCPSTDT_"00" D DD^%DT W !?5,"*** STARTING WITH MO-YR: ",Y," ***"
 S X1=DT,X2=PRCPSTDT_"01" D ^%DTC S PRCPTDAY=X W !?5,"*** TOTAL DAYS: ",PRCPTDAY," ***"
 ;
 K X S X(1)="The normal stock level will be calculated by multiplying the average daily usage by the number of days." D DISPLAY^PRCPUX2(1,40,.X)
 S DIR(0)="N^1:240",DIR("A")="Enter number of days to be on hand for Normal Stock Level"
 S DIR("?",1)="The Normal Stock Level will be set equal to this number multiplied",DIR("?")="by the average usage."
 S DIR("B")=30 D ^DIR K DIR I 'Y D Q Q
 S PRCPDNSL=Y
 ;
 K X S X(1)="The emergency stock level will be calculated by multiplying the average daily usage by this percentage." D DISPLAY^PRCPUX2(1,40,.X)
 S DIR(0)="N^1:100",DIR("A")="Enter the percentage of usage for Emergency Stock Level"
 S DIR("?",1)="The Emergency Stock Level will be set equal to this percentage multiplied",DIR("?")="by the average usage."
 S DIR("B")=20 D ^DIR K DIR I 'Y D Q Q
 S PRCPPESL=Y
 ;
 K X S X(1)="The standard reorder point will be calculated by multiplying the average daily usage by this percentage." D DISPLAY^PRCPUX2(1,40,.X)
 S DIR(0)="N^"_PRCPPESL_":100",DIR("A")="Enter the percentage of usage for Standard Reorder Point"
 S DIR("?",1)="The Standard Reorder Point will be set equal to this percentage multiplied",DIR("?")="by the average usage."
 S DIR("B")=$S(PRCPPESL>50:PRCPPESL,1:50) D ^DIR K DIR I 'Y D Q Q
 S PRCPPSRP=Y
 ;
 K X S X(1)="The optional reorder point will be calculated by multiplying the average daily usage by this percentage." D DISPLAY^PRCPUX2(1,40,.X)
 S DIR(0)="N^"_PRCPPSRP_":100",DIR("A")="Enter the percentage of usage for Optional Reorder Point"
 S DIR("?",1)="The Optional Reorder Point will be set equal to this percentage multiplied",DIR("?")="by the average usage."
 S DIR("B")=$S(PRCPPSRP>75:PRCPPSRP,1:75) D ^DIR K DIR I 'Y D Q Q
 S PRCPPORP=Y
 ;
 I $$KEY^PRCPUREP("PRCP"_$TR(PRCP("DPTYPE"),"WSP","W2")_" MGRKEY",DUZ) D  I %<1 D Q Q
 .   S XP="Do you want to update the levels in the database",XH="Enter 'YES' to update the levels in the database based on my calculations",XH(1)="Enter 'NO' to print estimated levels, '^' to exit."
 .   W ! S %=$$YN^PRCPUYN(2)
 .   I %=1 S PRCPFSET=1
 I '$G(PRCPFSET) W !!,"I will print the current levels versus the estimated levels."
 I $G(PRCPFSET) D
 .   K X S X(1)="WARNING -- Check the changes I make carefully.  Errors in the database can drastically mess up automatic level setting.  As you debug your database I am going to become a trusted friend,"
 .   S X(2)="but always keep an eye on what I am doing because I do not have the common sense that you do."
 .   D DISPLAY^PRCPUX2(5,75,.X)
 ;
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Automatic Level Setter",ZTRTN="DQ^PRCPRALS"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("GROUPALL")="",ZTSAVE("ODIS")="",ZTSAVE("^TMP($J,""PRCPURS1"",")="",ZTSAVE("^TMP($J,""PRCPURS4"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 D PRINT^PRCPRAL1
Q D ^%ZISC K ^TMP($J,"PRCPURS4"),^TMP($J,"PRCPRALS"),^TMP($J,"PRCPURS1")
 Q
