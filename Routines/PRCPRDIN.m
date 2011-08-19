PRCPRDIN ;WISC/RFJ-due in report                                    ;04 Sep 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N B,PRCPSORT,X
 I PRCP("DPTYPE")="W" W !?2,"START WITH NSN: FIRST// @    <<-- ENTER '@' TO PRINT ITEMS WITHOUT A NSN" S BY="[PRCP SORT:NSN]"
 E  W !?2,"START WITH GROUP CATEGORY CODE: FIRST// @   <<-- ENTER '@' TO PRINT ITEMS",!?51,"WITHOUT A GROUP CATEGORY CODE" S BY="[PRCP SORT:GROUP]"
 S DIC="^PRCP(445,",L=0,FLDS="[PRCP REPORT:DUEIN]",DIS(0)="I D0=PRCP(""I"")",PRCPSORT="D SORT^PRCPRDIN",DIOEND="D END^PRCPUREP" D EN1^DIP
 Q
 ;
 ;
SORT ;sort lookup on duein
 I $$GETIN^PRCPUDUE(D0,D1)>0!($O(^PRCP(445,D0,1,D1,7,0))) S X=D1 Q
 S X=""
 Q
 ;
 ;
OUTST ;called from print template to display outstanding transactions
 N %,LI,P,PART,PO,PODATA,V,Y
 S PO=$P($G(^PRCS(410,D2,10)),"^",3),PODATA=$G(^PRC(442,+PO,0)) I PODATA'="" D  Q
 .   S V=$P($G(^PRC(442,+PO,1)),"^"),Y=$P(PODATA,"^",10) D DD^%DT W ?24,$P($P(PODATA,"^"),"-",2),?32,$E($P($G(^PRC(440,+V,0)),"^"),1,15),?48,"[#",V,"]"
 .   S PART="",LI=0 F  S LI=$O(^PRC(442,+PO,2,"AE",D1,LI)) Q:'LI  S %=0 F  S %=$O(^PRC(442,+PO,2,LI,3,%)) Q:'%  S P=+$P($G(^(%,0)),"^",4) I P,'+$P($G(^PRC(442,+PO,11,P,0)),"^",17) S PART=$S(PART="":"",1:PART_" ")_P
 .   S:PART'="" Y=PART W ?57,Y,?70
 S V=$P($G(^PRCS(410,D2,3)),"^",4),Y=$P($G(^PRCS(410,D2,9)),"^",2) D DD^%DT W ?24,$S($P(^PRCS(410,D2,0),"^",4)=5:"ISSUE",1:""),?32,$E($P($G(^PRC(440,+V,0)),"^"),1,15),?48,"[#",V,"]",?57,Y,?70
 Q
