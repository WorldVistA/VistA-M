PRCPRUS2 ;WISC/VAC-usage increase,decrease usage report ; 11/29/06 2:04pm
V ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine is called from PRCPRUS1 and was modified to work only
 ;   with Primary and Secondary inventory points.  To call this
 ;   directly, first run ^PRCPUSEL to set location points
 N %,AVERAGE,CHANGE,COMDATA,COMDT,COMPARE,DATA,DATE,DEFAULT,DESCR,END,ENDDT,ITEMDA,LASTMO,MAXDT,MONTHS,NOW,NOWDT,PAGE,PERCENT,PRCPEND,PRCPFLAG,REPTYPE,SCREEN,START,STARTDT,TOTAL,X,Y,Z
 N DATA2,GROUP,GROUPALL,GROUPNM,ODIFLG,ORDER,SRT,TYPNUM,X1,X2
 D NOW^%DTC S NOWDT=X,Y=% D DD^%DT S NOW=Y,X1=$E(NOWDT,1,5)_"15",X2=-30 D C^%DTC S (LASTMO,Y)=$E(X,1,5)_"00" D DD^%DT S DEFAULT=Y
 S PRCPEND=$P("31^28^31^30^31^30^31^31^30^31^30^31","^",+$E(NOWDT,4,5))
 I PRCPEND=28 S Z=$E(NOWDT,1,3)+1700,PRCPEND=$S(Z#400=0:29,(Z#4=0&(Z#100'=0)):29,1:28)
 S MAXDT=$E(NOWDT,1,5)_PRCPEND,Y=($E(LASTMO,1,3)-1)_$E(LASTMO,4,5)_"00" D DD^%DT S START=Y
 S %DT="AEP",%DT("A")="Compare Usage to Date (Month Year): ",%DT("B")=DEFAULT,%DT(0)=-MAXDT W ! D ^%DT K %DT Q:Y<0  S COMDT=$E(Y,1,5)
START S %DT="AEP",%DT("A")="Start Comparison Usage with Date (Month Year): ",%DT("B")=START,%DT(0)=-MAXDT W ! D ^%DT K %DT Q:Y<0  S STARTDT=$E(Y,1,5)
 S %DT="AEP",%DT("A")="  End Comparison Usage with Date (Month Year): ",%DT("B")=DEFAULT,%DT(0)=-MAXDT D ^%DT K %DT Q:Y<0  S ENDDT=$E(Y,1,5)
 I ENDDT<STARTDT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE." G START
 S DIR(0)="N^1:1000",DIR("A")="Enter the percentage of change",DIR("?",1)="Enter a whole number change between 1 and 1000 which represents the percentage",DIR("?")="between the average (from start to end month) and the compare month."
 S DIR("B")=50 W ! D ^DIR K DIR Q:'+Y  S PERCENT=+Y
 S DIR(0)="S^D:Decrease in Usage;I:Increase in Usage",DIR("A")="Show Items with Increase or Decrease in Usage",DIR("B")="Decrease in Usage" W ! D ^DIR K DIR
 S REPTYPE=$S(Y="D":"DECREASE",1:"INCREASE"),SCREEN=$S(Y="D":"I COMDATA<AVERAGE",Y="I":"I COMDATA>AVERAGE",1:"") Q:SCREEN=""
 ; Insert prompt for Group
 K X S X(1)="Select the Group Categories to display" D DISPLAY^PRCPUX2(2,40,.X)
 D GROUPSEL^PRCPURS1(PRCP("I"))
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) W !,"*** NO GROUP CATEGORIES SELECTED !" D Q Q
 W !,"NOTE:  The report will",$S('$G(GROUPALL):" NOT",1:"")," include items not stored in a group category."
 ; Insert prompt for Standard, ODI or both
 S TYPNUM=$$ODIPROM^PRCPUX2(0)
 Q:TYPNUM=0
DESC ; Insert prompt for sort order by item number or name
 S SRT=$$SRTPRMP^PRCPUX2(0)
 Q:SRT=0
 I (+SRT<1)!(+SRT>2) G DESC
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Usage Demand Analysis Report",ZTRTN="DQ^PRCPRUS2"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("REPTYPE")="",ZTSAVE("S*")="",ZTSAVE("END*")="",ZTSAVE("NOW*")="",ZTSAVE("COMDT")="",ZTSAVE("PERCENT")="",ZTSAVE("REP")="",ZTSAVE("ZTREQ")="@",ZTSAVE("SCREEN")=""
 .   S ZTSAVE("GROUP*")="",ZTSAVE("^TMP($J,""PRCPURS1"",")="",ZTSAVE("TYP*")=""
 W !!,"<*> please wait <*>"
DQ ;queue comes here
 K ^TMP($J,"USAGE2") S X1=ENDDT_"00",X2=STARTDT_"00" D ^%DTC S MONTHS=(X+12)\30 S:'MONTHS MONTHS=1
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:+ITEMDA=0  D
 .   S DATA2=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)) Q:DATA2=""
 .   S GROUP=+$P(DATA2,"^",21)
 .   I 'GROUP,'$G(GROUPALL) Q
 .   I $G(GROUPALL),$D(^TMP($J,"PRCPURS1","NO",GROUP)) Q
 .   I '$G(GROUPALL),'$D(^TMP($J,"PRCPURS1","YES",GROUP)) Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,20)_" (#"_GROUP_")"
 .   S:GROUPNM="" GROUPNM=" "
 .   I SRT=2 S ORDER=ITEMDA
 .   I SRT=1 D
 ..    S DESCR=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA) S:DESCR="" DESCR=" "
 ..    S DESCR=$E(DESCR,1,20)
 ..    S ORDER=DESCR
 .   S DATE=STARTDT-1,TOTAL=0 F  S DATE=$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,DATE)) Q:'DATE!(DATE>ENDDT)  S TOTAL=TOTAL+$P($G(^(DATE,0)),"^",2)
 .   Q:TOTAL=""  S AVERAGE=TOTAL/MONTHS,COMDATA=+$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,2,COMDT,0)),"^",2) X SCREEN Q:'$T
 .   S CHANGE=$S(AVERAGE=0:"***.**",1:(COMDATA-AVERAGE)/AVERAGE*100) S:CHANGE<0 CHANGE=-CHANGE I CHANGE'["*",CHANGE<PERCENT Q
 .   S ^TMP($J,"USAGE2",GROUPNM,ORDER,ITEMDA)=COMDATA_"^"_$J(AVERAGE,0,2)_"^"_$S(CHANGE["*":CHANGE,1:$J(CHANGE,0,2))
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1
 S Y=COMDT_"00" D DD^%DT S COMPARE=Y,Y=STARTDT_"00" D DD^%DT S START=Y,Y=ENDDT_"00" D DD^%DT S END=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 I $D(^TMP($J))=0 D END^PRCPUREP G Q
 S GROUPNM="" F  S GROUPNM=$O(^TMP($J,"USAGE2",GROUPNM)) Q:GROUPNM=""  D
 .Q:$D(PRCPFLAG)
 . W !,?6,"GROUP:  ",GROUPNM
 . I GROUPNM=""!(GROUPNM=" ") W "<NONE>"
 . W !
 . I $Y>(IOSL-5) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 . S ORDER="" F  S ORDER=$O(^TMP($J,"USAGE2",GROUPNM,ORDER)) Q:ORDER=""  D
 .. Q:$D(PRCPFLAG)
 .. S ITEMDA="" F  S ITEMDA=$O(^TMP($J,"USAGE2",GROUPNM,ORDER,ITEMDA)) Q:ITEMDA=""  D
 ... S ODIFLG=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 ... I (TYPNUM=1)&(ODIFLG="Y") Q
 ... I (TYPNUM=2)&(ODIFLG'="Y") Q
 ... Q:$D(PRCPFLAG)
 ... S DATA=$G(^TMP($J,"USAGE2",GROUPNM,ORDER,ITEMDA))
 ...   W !,ITEMDA
 ...   S ODIFLG=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 ...   I ODIFLG="Y" W ?9,"D"
 ...   W ?15,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,20),?41,$J($P(DATA,"^"),10),?55,$J($P(DATA,"^",2),10),?70,$J($P(DATA,"^",3),9)
 ...   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 ...   Q:$D(PRCPFLAG)
 ...   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 .. Q:$D(PRCPFLAG)
 . Q:$D(PRCPFLAG)
 . W !
 D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"USAGE2"),^TMP($J,"PRCPURS1") Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"USAGE DEMAND ANALYSIS FOR: ",PRCP("IN"),?(80-$L(%)),%
 W !?5,"AVERAGE USAGE FROM ",START," TO ",END,"  (",MONTHS," MONTHS)"
 W !?5,"COMPARE USAGE WITH ",COMPARE,?40,"PERCENT ",REPTYPE," AT LEAST: ",PERCENT," %"
 S %="",$P(%,"-",81)="" W !,"IM#",?8,"OD",?15,"DESCRIPTION",?41,"COMPARE QTY",?55,"AVERAGE QTY",?70,"% "_REPTYPE,!,% Q
