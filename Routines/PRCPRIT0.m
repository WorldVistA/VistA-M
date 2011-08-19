PRCPRIT0 ;WISC/RFJ-display item                                     ; 10/19/06 9:02am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,INVPT,ITEMDA,ODIFLAG
 S INVPT=PRCP("I") I $O(^PRCP(445,PRCP("I"),2,0))="" G ITEM
 W !!,"Enter the DISTRIBUTION POINT to select an item from the distribution point, or",!,"Enter <RETURN> to select an item from the ",PRCP("IN")," inventory point."
 S %=$$TO^PRCPUDPT(PRCP("I")) Q:%["^"  I % S INVPT=%
ITEM S ODIFLAG="P"
 I PRCP("DPTYPE")="W" D
 .I %=0 S ODIFLAG="W"
 F  W ! S ITEMDA=$$ITEM^PRCPUITM(INVPT,0,"","") Q:'ITEMDA  D
 .   S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   .   S ZTDESC="Display Item Report",ZTRTN="DQ^PRCPRIT1"
 .   .   S ZTSAVE("PRCP*")="",ZTSAVE("ITEMDA")="",ZTSAVE("INVPT")="",ZTSAVE("ZTREQ")="@",ZTSAVE("O*")=""
 .   W !!,"<*> please wait <*>"
 .   D DQ^PRCPRIT1
 Q
