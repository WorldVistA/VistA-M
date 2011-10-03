PRCPRCOM ;WISC/RFJ-comprehensive item list                          ;22 Jul 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,PRCPDOT,PRCPINV,PRCPFCP,X S PRCPINV=$$INVNAME^PRCPUX1(PRCP("I")),PRCPFCP=$$FCPDA^PRCPUX1(PRC("SITE"),PRCP("I"))
TOP ;called by 'print items for distribution point'
 I PRCP("DPTYPE")="W" W !?2,"START WITH NSN: FIRST// @    <<-- ENTER '@' TO PRINT ITEMS WITHOUT A NSN"
 E  W !?2,"START WITH GROUP CATEGORY CODE: FIRST// @   <<-- ENTER '@' TO PRINT ITEMS",!?51,"WITHOUT A GROUP CATEGORY CODE"
 S DIC="^PRCP(445,",L=0,FLDS="[PRCP REPORT:COMPREHENSIVE]",BY=".01,"_$S(PRCP("DPTYPE")'="W":"1,@.5,",1:"")_"1,@.01:5;""NSN"""
 S FR=PRCPINV_","_$S(PRCP("DPTYPE")'="W":"?,@",1:"?"),TO=PRCPINV_","_$S(PRCP("DPTYPE")'="W":"?,",1:"?"),DIOEND="D END^PRCPUREP" D EN1^DIP Q
 ;
DISTPT ;print items for distribution point
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,PRCPDOT,PRCPINV,X
 S %=+$$TO^PRCPUDPT(PRCP("I")) Q:'%  S PRCPINV=$$INVNAME^PRCPUX1(%)
 D TOP Q
