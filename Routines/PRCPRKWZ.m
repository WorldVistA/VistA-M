PRCPRKWZ ;WISC/RFJ-items flagged 'kill when zero' report            ;22 Jul 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,PRCPINV,X W !?2,"START WITH NSN: FIRST// @    <<-- ENTER '@' TO PRINT ITEMS WITHOUT A NSN"
 S PRCPINV=$$INVNAME^PRCPUX1(PRCP("I")),DIC="^PRCP(445,",L=0,FLDS="[PRCP REPORT:NSN]",BY=".01,1,@.01:5;""NSN"",1,@17",FR=PRCPINV_",?,Y",TO=PRCPINV_",?,Y",DHD="KILL WHEN ZERO REPORT",DIOEND="D END^PRCPUREP" D EN1^DIP Q
