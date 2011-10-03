PRCPRODA ;WOIFO/VAC-On-Demand Audit Activity Report ; 2/22/07 9:05am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
PRIMARY ;This routine displays the audit information on On-Demand Items updates
 N X,Y,GROUPALL,SRT,GROUP,ITEMFLG,PERS1,PERSNAM,TIMFLG,GR,GROUPYES
 N ITEMSEL,DATESTRT,DATEEND,GRPFLG,DESCR,NOW,ORDER,PRCPFLAG,X1,X2
 N POP,ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE
 K ^TMP($J,"PRCPRODA")
 S DATESTRT=1,DATEEND=9999999
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 K X S X(1)="The On-Demand Audit Report will print the audit trail for items in Primary and/or Secondary Inventory that are either designated as ODI or were designated as ODI but are not now."
 D DISPLAY^PRCPUX2(2,79,.X)
 ; Prompt for All or single item
 K X S X(1)="Select specific items to display."
 D DISPLAY^PRCPUX2(2,40,.X)
 S ITEMSEL=$$SINGIT^PRCPUX2(PRCP("I"))
 I ITEMSEL="^" Q
 ; set up ^TMP is single item selected, skip remaining prompts
 I ITEMSEL'="" D  G BEGIN
 .S ORDER=ITEMSEL
 .S GRPFLG=$P($G(^PRCP(445,PRCP("I"),1,ITEMSEL,0)),"^",21)
 .I GRPFLG="" S GRPFLG=0
 .S DESCR=$$DESCR^PRCPUX1(PRCP("I"),ITEMSEL)
 .S:DESCR="" DESCR=" "
 .S I=0 F  S I=$O(^PRCP(445,PRCP("I"),1,ITEMSEL,10,I)) Q:+I=0  D
 ..S TIMFLG=($G(^PRCP(445,PRCP("I"),1,ITEMSEL,10,I,0))*(-1))
 ..S ^TMP($J,"PRCPRODA",GRPFLG,PRCP("I"),ORDER,TIMFLG)=ITEMSEL_"^"_DESCR_"^"_$G(^PRCP(445,PRCP("I"),1,ITEMSEL,10,I,0))
 W !
 K X S X(1)="Select the date range which should be used for displaying the usage."
 D DISPLAY^PRCPUX2(2,40,.X)
 ;Select a date range to print
 D DATESEL^PRCPURS2("") I '$G(DATEEND) D Q Q
 S X1=DATEEND,X2=DATESTRT D ^%DTC
 W !,"-- TOTAL NUMBER OF DAYS: ",X+1,!
 K X S X(1)=""
 K X S X(1)="Select the Group categories to display." D DISPLAY^PRCPUX2(2,40,.X)
 D GROUPSEL^PRCPURS1(PRCP("I"))
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) W !,"*** NO GROUP CATEGORIES SELECTED !" D Q Q
 W !,"NOTE:  The report will",$S('$G(GROUPALL):" NOT",1:""),"  include items not stored in a group category."
DESC ; Ask user for Item#/Description sort preference
 S SRT=$$SRTPRMP^PRCPUX2(0)
 Q:SRT=0
 I (+SRT<1)!(SRT>2) G DESC
 ;
BEGIN S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD,HOME^%ZIS K IO("Q"),ZTSK Q
 .  S ZTDESC="ON-DEMAND AUDIT REPORT",ZTRTN="DQ^PRCPRODA"
 .  S ZTSAVE("PRCP*")="",ZTSAVE("GROUP*")="",ZTSAVE("^TMP($J,""PRCPURS1"",")="",ZTSAVE("ZTREQ")="@",ZTSAVE("S*")=""
 .  S ZTSAVE("DATE*")="",ZTSAVE("ITEM*")=""
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N X,Y,%,ITEMDA,D,CTR,DESCR,ORDER,I,PAGE,SCREEN
 N PRCPFLAG,GRPDESC,DIST,DAT,DATE0,DATE1,DATE2
 I ITEMSEL'="" G REPORT
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) I D'="" D
 .; If no audit trail quit
 .I $G(^PRCP(445,PRCP("I"),1,ITEMDA,10,0))="" Q
 .S DESCR=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA) S:DESCR="" DESCR=" "
 .; Determine the Group
 .S GROUP=+$P(D,"^",21),GRPFLG=GROUP
 .S GROUPYES="NO"
 .I $G(GROUPALL)=1 S GROUPYES="YES"
 .I $G(GROUPALL)="" D
 ..S GR="" F  S GR=$O(^TMP($J,"PRCPURS1","YES",GR)) Q:GR=""  D
 ...I GR=GRPFLG S GROUPYES="YES"
 .Q:GROUPYES="NO"
 .I SRT=1 S ORDER=DESCR
 .I SRT=2 S ORDER=ITEMDA
 .S I=0 F  S I=$O(^PRCP(445,PRCP("I"),1,ITEMDA,10,I)) Q:+I=0  D
 . . S TIMFLG=+$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,10,I,0)),".",1)
 . . Q:TIMFLG<DATESTRT
 . . Q:TIMFLG>DATEEND
 . . S TIMFLG=TIMFLG*(-1)
 . . S ^TMP($J,"PRCPRODA",GRPFLG,PRCP("I"),ORDER,TIMFLG)=ITEMDA_"^"_DESCR_"^"_$G(^PRCP(445,PRCP("I"),1,ITEMDA,10,I,0))
 ;
REPORT ; Print Report
 D NOW^%DTC S Y=% D DD^%DT S NOW=$P(Y,"@",1),PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 ;
 S GROUP="" F  S GROUP=$O(^TMP($J,"PRCPRODA",GROUP)) Q:GROUP=""  D  Q:$D(PRCPFLAG)
 . I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINIATED BY USER >>>" Q
 .I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .I GROUP=0 S GRPDESC="<<NONE>>"
 .I GROUP'=0 D
 .. S GRPDESC=$$GROUPNM^PRCPEGRP(GROUP)
 .. S GRPDESC=$E(GRPDESC,1,20)_" (#"_GROUP_")"
 . W !?7,"GROUP:  ",GRPDESC,!
 . S DIST="" F  S DIST=$O(^TMP($J,"PRCPRODA",GROUP,DIST)) Q:DIST=""  D  Q:$D(PRCPFLAG)
 .. S ORDER="" F  S ORDER=$O(^TMP($J,"PRCPRODA",GROUP,DIST,ORDER)) Q:ORDER=""  D  Q:$D(PRCPFLAG)
 ... S ITEMFLG=""
 ... S TIMFLG="" F  S TIMFLG=$O(^TMP($J,"PRCPRODA",GROUP,DIST,ORDER,TIMFLG)) Q:TIMFLG=""  D  Q:$D(PRCPFLAG)
 .... S ITEMDA=$G(^TMP($J,"PRCPRODA",GROUP,DIST,ORDER,TIMFLG)) Q:ITEMDA=""
 .... I ITEMFLG="" D  Q:$D(PRCPFLAG)
 ..... I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 ..... W !,$P(ITEMDA,"^",1),?9,$P(ITEMDA,"^",2) S ITEMFLG="X"
 ....S DATE0=$P(ITEMDA,"^",3),DATE1=$P($$FMTE^XLFDT(DATE0,2),"@",1),DATE2=$P($$FMTE^XLFDT(DATE0,3),"@",2)
 ....S PERS1=$P(ITEMDA,"^",4),PERSNAM=$P(^VA(200,PERS1,20),"^",2)
 ....I $Y>(IOSL-5) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 ....W !,?9,$P(ITEMDA,"^",6),?12,DATE1,?21,DATE2,?32,$E(PERSNAM,1,15),?49,$E($P(ITEMDA,"^",5),1,30)
 ... W !
 .. W !
 I '$G(PRCPFLAG) D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRODA"),^TMP($J,"PRCPURS1")
 Q
H ;PRINT HEADING
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W "ON-DEMAND AUDIT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !,"IM#",?9,"DESCRIPTION"
 W !,?32,"INVENTORY POINT"
 W !,?3,"SETTING",?12,"DATE/TIME",?38,"USER",?49,"REASON"
 W !,%,!
 Q
