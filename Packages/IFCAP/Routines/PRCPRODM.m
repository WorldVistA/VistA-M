PRCPRODM ;WOIFO/CC/VAC-On-Demand Conflict Report ; 2/21/07 11:22am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;*98 Created to identify items in Primary as ODI but not in Secondary
 Q
PRIM I $G(PRCP("DPTYPE"))="S" D PRIM^PRCPRODS Q
 N CHOICE,CTR,DATA2,DATA3,DISFLG,DISPT,DISTR,GROUP,GROUPALL,GROUPNM,I,IT,ITEM,ITEMNM,ITNAME,J
 N LST,MGRFLG,NOW,NOWDT,ODITEM,ODIUSER,ORD,PAGE,PRCPFLAG,PRI,PRIM,SCREEN,SEC,SECNAME,SRT,USER,X,Y,MAN,RECCNT,GR,GROUPYES
 N POP,ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE
 K ^TMP($J,"PRIM"),^TMP($J,"SEC"),^TMP($J,"COMB")
 S PAGE=1
 D NOW^%DTC S NOWDT=X,Y=% D DD^%DT S NOW=Y,SCREEN=$$SCRPAUSE^PRCPUREP
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 K X S X(1)="The On-Demand Conflict Report shows all items that are On-Demand in the Primary and Standard in the Secondary" D DISPLAY^PRCPUX2(40,79,.X)
 S CTR=$P($G(^PRCP(445,PRCP("I"),2,0)),"^",4)
 I +CTR=0 W !,"NO DISTRIBUTION POINTS EXIST FOR THIS PRIMARY" HANG 5 Q
 S DISTR=0 F I=1:1:CTR S DISTR=$O(^PRCP(445,PRCP("I"),2,DISTR)) Q:'DISTR!($G(PRCPFLAG))  D
 .S $P(DISPT(PRCP("I"),DISTR),"^",2)=$$INVNAME^PRCPUX1(DISTR)
QUEST0 ;
 K X S X(1)="Select the DISTRIBUTION POINTS to display" D DISPLAY^PRCPUX2(2,40,.X)
 D DISTRSEL^PRCPURS3(PRCP("I"))
QUEST1 ;
 S DISFLG=""
 I $D(^TMP($J,"PRCPURS3","YES"))=0 D FILL G QUEST3
 S X="" F  S X=$O(^TMP($J,"PRCPURS3","YES",X)) Q:X=""  D
 . S $P(DISPT(PRCP("I"),X),"^",1)="*"
QUEST3 ; Select Groups
 S DISTR=""
 F  S DISTR=$O(DISPT(PRCP("I"),DISTR)) Q:DISTR=""  D
 .I $P(DISPT(PRCP("I"),DISTR),"^",1)["*" S DISFLG="Y"
 I DISFLG="" W !,"No Distribution Points picked.  Try again." HANG 5 G QUEST0
 K X S X(1)="Select the Group Categories to display" D DISPLAY^PRCPUX2(2,40,.X)
 D GROUPSEL^PRCPURS1(PRCP("I"))
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) W !,"*** NO GROUP CATEGORIES SELECTED !" D Q Q
 W !,"NOTE:  The report will",$S('$G(GROUPALL):" NOT",1:"")," include items not stored in a group category."
QUEST4 ; Select Sort order
 K X S X(1)="Select the order in which you want the item information to appear." D DISPLAY^PRCPUX2(2,40,.X)
 S SRT=$$SRTPRMP^PRCPUX2(0)
 Q:SRT=0
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D ^%ZISC Q
 .   S ZTDESC="On-Demand Conflict Report",ZTRTN="REPORT^PRCPRODM"
 .   S ZTSAVE("S*")="",ZTSAVE("PRCP*")="",ZTSAVE("GR*")="",ZTSAVE("D*")="",ZTSAVE("P*")="",ZTSAVE("C*")="",ZTSAVE("I*")="",ZTSAVE("N*")=""
 .   S ZTSAVE("^TMP($J,""PRCPURS3"",")="",ZTSAVE("O*")="",ZTSAVE("U*")=""
 ;
QUEST5 W !!,"Please wait.  Report compiling and printing."
REPORT ;Now compile the data
 S PRI=PRCP("I")
 S PRIM(PRI)=$P(PRCP("PAR"),"^",1)
 S ITEM=0 F I=1:1 S ITEM=$O(^PRCP(445,PRI,1,ITEM)) Q:+ITEM=0  D
 .S ODITEM=$$ODITEM^PRCPUX2(PRI,ITEM)
 .I ODITEM'="Y" Q
 .S ^TMP($J,"PRIM",ITEM)=$$DESCR^PRCPUX1(PRI,ITEM)
 .S:^TMP($J,"PRIM",ITEM)="" ^TMP($J,"PRIM",ITEM)=" "
 ;Now get items in secondaries that match
 S DISTR=""  F I=1:1 S DISTR=$O(DISPT(PRI,DISTR)) Q:DISTR=""  D
 .Q:$P($G(DISPT(PRI,DISTR)),"^",1)'="*"
 .S ITEM=0 F J=1:1 S ITEM=$O(^TMP($J,"PRIM",ITEM)) Q:+ITEM=0  D
 ..Q:$G(^PRCP(445,DISTR,1,ITEM,0))=""
 ..S ODITEM=$$ODITEM^PRCPUX2(DISTR,ITEM)
 ..S MAN=$P($G(^PRCP(445,DISTR,1,ITEM,0)),"^",12)
 ..I PRI'=$P(MAN,";",1) Q
 ..I ODITEM="Y" Q
 ..S $P(^TMP($J,"SEC",DISTR,ITEM),"^",1)=^TMP($J,"PRIM",ITEM)
 ; Now put in order by group and sort sequence
 S DISTR="" F  S DISTR=$O(^TMP($J,"SEC",DISTR)) Q:DISTR=""  D
 .S ITEM="" F  S ITEM=$O(^TMP($J,"SEC",DISTR,ITEM)) Q:ITEM=""  D
 ..S DATA2=$G(^PRCP(445,PRI,1,ITEM,0))
 ..Q:DATA2=""
 ..S GROUP=+$P(DATA2,"^",21)
 ..;Determine if the item is in the group
 ..S GROUPYES="YES"
 ..I $G(GROUPALL)="" S GROUPYES="NO" D
 ...S GR="" F  S GR=$O(^TMP($J,"PRCPURS1","YES",GR)) Q:GR=""  D
 ....I GR=GROUP S GROUPYES="YES"
 ..Q:GROUPYES="NO"
 ..S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 ..I GROUPNM'="" S GROUP=$P(GROUPNM,":",2)
 ..I GROUPNM="" S GROUP=+GROUPNM
 ..S ITEMNM=$P($G(^TMP($J,"SEC",DISTR,ITEM)),"^",1)
 ..S ORD=ITEM
 ..I SRT=1 S ORD=ITEMNM
 ..S ^TMP($J,"COMB",PRI,DISTR,GROUP,ORD)=ITEM_"^"_ITEMNM
REP ;Now print the report
 S PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO
 S RECCNT=0
 S PRIM="" F  S PRIM=$O(^TMP($J,"COMB",PRIM)) Q:PRIM=""  D  Q:$D(PRCPFLAG)
 .S SEC="" F  S SEC=$O(^TMP($J,"COMB",PRIM,SEC)) Q:SEC=""  D  Q:$D(PRCPFLAG)
 ..D:PAGE>1&SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D HEAD
 ..S GROUP="" F  S GROUP=$O(^TMP($J,"COMB",PRIM,SEC,GROUP)) Q:GROUP=""  D  Q:$D(PRCPFLAG)
 ...I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D HEAD
 ...Q:$D(PRCPFLAG)
 ...I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !,?10,"<<<TASKMANAGER JOB TERMINATED BY USER >>>"
 ...W !,"GROUP: " I GROUP'=0 W GROUP,!
 ...I GROUP=0 W "<<NONE>>",!
 ...S ORD="" F  S ORD=$O(^TMP($J,"COMB",PRIM,SEC,GROUP,ORD)) Q:ORD=""  D  Q:$D(PRCPFLAG)
 ....S DATA3=$G(^TMP($J,"COMB",PRIM,SEC,GROUP,ORD))
 ....S IT=$P(DATA3,"^",1),ITNAME=$P(DATA3,"^",2)
 ....S RECCNT=RECCNT+1
 ....I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D HEAD
 ....Q:$D(PRCPFLAG)
 ....I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 ....Q:$D(PRCPFLAG)
 ....W ?1,IT,?11,ITNAME,!
 ...Q:$D(PRCPFLAG)
 ..Q:$D(PRCPFLAG)
 ..; Print authorized users
 ..I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D HEAD
 ..W !!,"AUTHORIZED ON-DEMAND USERS"
 ..W !,"--------------------------",!
 ..; I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D HEAD
 ..W PRIM(PRI),":"
 ..S USER=0 F  S USER=$O(^PRCP(445,PRI,4,USER)) Q:USER=""  D  Q:$D(PRCPFLAG)
 ...S MGRFLG=""
 ...I $G(^PRCP(445,PRI,9,0))'="" D
 ....S LST=$P($G(^PRCP(445,PRI,9,0)),"^",4)
 ....S ODIUSER=0 F  S ODIUSER=$O(^PRCP(445,PRI,9,ODIUSER)) Q:+ODIUSER=0  D  Q:$D(PRCPFLAG)
 .....I $G(^PRCP(445,PRI,9,ODIUSER,0))=USER D
 ......I $Y>(IOSL-5) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D HEAD
 ......W ?30,$E($$USER^PRCPUREP(USER),1,30),!
 ......Q:$D(PRCPFLAG)
 .....Q:$D(PRCPFLAG)
 ....Q:$D(PRCPFLAG)
 ...Q:$D(PRCPFLAG)
 ..Q:$D(PRCPFLAG)
 ..;Display secondary authorized users
 ..S SECNAME=$P($G(^PRCP(445,SEC,0)),"^",1)
 ..W !,$E(SECNAME,1,28),":"
 ..S USER=0 F  S USER=$O(^PRCP(445,SEC,4,USER)) Q:USER=""  D  Q:$D(PRCPFLAG)
 ...S MGRFLG=""
 ...I $G(^PRCP(445,SEC,9,0))'="" D
 ....S ODIUSER=0
 ....F  S ODIUSER=$O(^PRCP(445,SEC,9,ODIUSER)) Q:+ODIUSER=0  D  Q:$D(PRCPFLAG)
 .....I $G(^PRCP(445,SEC,9,ODIUSER,0))=USER D
 ......I $Y>(IOSL-5) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D HEAD
 ......W ?30,$E($$USER^PRCPUREP(USER),1,30),!
 ......Q:$D(PRCPFLAG)
 .....Q:$D(PRCPFLAG)
 ....Q:$D(PRCPFLAG)
 ...Q:$D(PRCPFLAG)
 ..Q:$D(PRCPFLAG)
 .Q:$D(PRCPFLAG)
 I RECCNT=0 D HEAD2 W !,?27,"*** NO CONFLICTS TO PRINT ***",!
 D END^PRCPUREP
 D Q Q
 ;
DISPL ; Display the information about the secondaries
 S DISTR="" F J=1:1  S DISTR=$O(DISPT(PRCP("I"),DISTR)) Q:DISTR=""  D
 . W !,?1,DISTR,?6,$P(DISPT(PRCP("I"),DISTR),"^",1),?8,$P(DISPT(PRCP("I"),DISTR),"^",2)
 Q
FILL S DISTR="" F I=1:1  S DISTR=$O(DISPT(PRCP("I"),DISTR)) Q:DISTR=""  S $P(DISPT(PRCP("I"),DISTR),"^",1)="*"
 Q
HEAD ;Display header information
 Q:$D(PRCPFLAG)
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 S SECNAME=$P($G(^PRCP(445,SEC,0)),"^",1)
 W !,"ON-DEMAND CONFLICTS IN: ",$E(SECNAME,1,24),?48,%
 W !,"PRIMARY INVENTORY POINT: ",PRIM(PRI)
 W !!,"IM#",?11,"DESCRIPTION"
 S %="",$P(%,"-",80)="" W !,%,!
 K PRCPFLAG
 Q
HEAD2 S %=NOW_" PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W !,"ON-DEMAND CONFLICT REPORT",?48,%
 W !,"PRIMARY INVENTORY POINT: ",PRIM(PRI)
 W !!,"IM#",?11,"DESCRIPTION"
 S %="",$P(%,"-",80)="" W !,%,!
 Q
Q D ^%ZISC K ^TMP($J,"PRIM"),^TMP($J,"SEC"),^TMP($J,"COMB")
 Q
