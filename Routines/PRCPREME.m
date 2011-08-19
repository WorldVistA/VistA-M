PRCPREME ;WISC/RFJ-emergency stock report                           ;25 Jul 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N PRCPSORT,PRCPDOT,X I PRCP("DPTYPE")="W" W !?2,"START WITH NSN: FIRST// @    <<-- ENTER '@' TO PRINT ITEMS WITHOUT A NSN" S BY="[PRCP SORT:NSN]"
 E  W !?2,"START WITH GROUP CATEGORY CODE: FIRST// @   <<-- ENTER '@' TO PRINT ITEMS",!?51,"WITHOUT A GROUP CATEGORY CODE" S BY="[PRCP SORT:GROUP]"
 S DIC="^PRCP(445,",L=0,FLDS="[PRCP REPORT:EMERGENCY]",DIS(0)="I D0=PRCP(""I"")",PRCPSORT="D SORT^PRCPREME",DIOEND="S:$P(^PRCP(445,PRCP(""I""),0),U,9)=""Y"" $P(^(0),U,9)="""" D END^PRCPUREP" D EN1^DIP Q
 ;
SORT ;sort lookup on emergency level
 S %=$G(^PRCP(445,D0,1,D1,0)) I $P(%,"^",26)'="Y",$P(%,"^",11)>0,$P(%,"^",11)'<$P(%,"^",7),$P(%,"^",9)>0 S X=D1 Q
 S X="" Q
 ;
OUTST ;called from print template to display outstanding transactions
 N %,PO,PODATA,V,Y S PO=$P($G(^PRCS(410,D2,10)),"^",3),PODATA=$G(^PRC(442,+PO,0)) I PODATA'="" D  Q
 .   S V=$P($G(^PRC(442,+PO,1)),"^"),Y=$P(PODATA,"^",10) D DD^%DT W ?24,$P($P(PODATA,"^"),"-",2),?32,$E($P($G(^PRC(440,+V,0)),"^"),1,15),?48,"[#",V,"]",?58,$J(Y,12),?69
 S V=$P($G(^PRCS(410,D2,3)),"^",4),Y=$P($G(^PRCS(410,D2,9)),"^",2) D DD^%DT W ?32,$E($P($G(^PRC(440,+V,0)),"^"),1,15),?48,"[#",V,"]",?58,$J(Y,12),?69
 Q
