ECXCPRO ;ALB/JAP - PRO Extract YTD Report ; 8/23/05 1:36pm
 ;;3.0;DSS EXTRACTS;**21,24,33,84**;Dec 22, 1997
 ;accumulates extract data by hcpcs code for all extracts in fiscal year date range
 ;if an extract has been purged, then totals will be falsely low
 ;if more than 1 extract exists for a particular month, then totals will be falsely high
 ;if site is multidivisional, then user can generate report for
 ;  any one division - data stored under divisional station# (e.g., 326 or 326AB)
 ;  or for entire facility - data stored under primary station# (e.g., 326) but includes data from all subdivisions
 ;if site is non-divisional, then data stored under facility station#
 ;
 ;
EN ;setup & queue
 N DIC,DA,DR,DIQ,DIR,DIRUT,DTOUT,DUOUT,DIV,LAST,OUT
 S ECXERR=0
 S ECXHEAD="PRO"
 W !!,"Setup for PRO Extract YTD HCPCS Report --",!
 ;determine primary division
 W !,"If you belong to more than one Primary Division, you must"
 W !,"select a Primary Division for the report.",!
 S ECXPRIME=$$PDIV^ECXPUTL
 I ECXPRIME=0 D ^ECXKILL Q
 S DA=ECXPRIME,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99" D EN^DIQ1
 S ECXPRIME=ECXPRIME_U_$G(ECXDIC(4,DA,99,"I"))_U_$G(ECXDIC(4,DA,.01,"I"))
 ;select 1 or more prosthetics divisions for report
 D PRO^ECXDVSN2(DUZ,ECXPRIME,.ECXDIV,.ECXALL,.ECXERR)
 I ECXERR D  Q
 .D ^ECXKILL W !!,?5,"Try again later... exiting.",!
 ;determine fiscal year of report
 S DIR(0)="SMBA^C:CURRENT;P:PREVIOUS",DIR("A")="Select C(urrent) or P(revious) Fiscal Year: ",DIR("B")="CURRENT"
 W ! K X,Y D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) D  Q
 .D ^ECXKILL W !!,?5,"Try again later... exiting.",!
 I Y="C" D
 .S X=$$CYFY^ECXUTL1(DT),ECXARRAY("START")=$P(X,U,3),ECXARRAY("END")=$P(X,U,4)
 I Y="P" D
 .S YR=$E(DT,1,3),MON=$E(DT,4,5) S:+MON<10 YR=YR-1 S X1=YR_"0930"
 .S X=$$CYFY^ECXUTL1(X1),ECXARRAY("START")=$P(X,U,3),ECXARRAY("END")=$P(X,U,4)
 .K C,MON,YR,X1
 ;setup variables for taskmanager
 S ECXPGM="PROCESS^ECXCPRO",ECXDESC="PRO Extract YTD Lab Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")="",ECXSAVE("ECXPRIME")="",ECXSAVE("ECXALL")=""
 ;determine output device and queue if requested
 W !!,"Please note: The PRO Extract YTD HCPCS Report requires 132 columns."
 W !,"             Select an appropriate device for output."
 W ! D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 W ! D ^ECXKILL Q
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS
 ;clean-up and close
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
 ;
PROCESS ;begin processing
 N DIVISION,E,EXTRACT,REC,NODE0,NODE1,LASTDAY
 K ^TMP($J,"ECXP") S LASTDAY=""
 ;determine which extracts contain data for report
 S (EXTRACT,E)=0
 F  S E=$O(^ECX(727,"E",ECXHEAD,E)) Q:'E  D
 .Q:'$D(^ECX(727,E,0))
 .Q:$P($G(^ECX(727,E,0)),U,4)<ECXARRAY("START")
 .Q:$P($G(^ECX(727,E,0)),U,4)>ECXARRAY("END")
 .Q:$G(^ECX(727,E,"DIV"))'=+ECXPRIME
 .S EXTRACT(E)=^ECX(727,E,0)
 .I $P(EXTRACT(E),U,5)>LASTDAY S LASTDAY=$P(EXTRACT(E),U,5)
 ;setup array of station numbers included in report
 F DIV=0:0 S DIV=$O(ECXDIV(DIV)) Q:'DIV  S ECXSTAT=$P(ECXDIV(DIV),U,2),DIVISION(ECXSTAT)=ECXDIV(DIV)
 ;get the extract data
 S E=0 F  S E=$O(EXTRACT(E)) Q:'E  S REC=0 I $D(^ECX(727.826,"AC",E)) F  S REC=$O(^ECX(727.826,"AC",E,REC)) Q:'REC  D
 .S NODE0=$G(^ECX(727.826,REC,0)),NODE1=$G(^ECX(727.826,REC,1)) Q:NODE0=""
 .S (ECXCTAMT,ECXLLC,ECXLMC)=0
 .S ECXFELOC=$P(NODE0,U,10),ECXFEKEY=$P(NODE0,U,11)
 .S ECXHCPC=$P(NODE0,U,33),ECXTYPE=$E(ECXFEKEY,6),ECXSRCE=$E(ECXFEKEY,7)
 .S ECXQTY=$P(NODE0,U,12),ECXCTAMT=$P(NODE0,U,25),ECXGRPR=$P(NODE1,U,4)
 .I ECXFELOC["NONL" S ECXSTAT=$P(ECXFELOC,"NONL",1),ECXFORM="NONL"
 .;if this station is lab requesting station, then count lab transaction
 .I ECXFELOC["ORD" D
 ..S ECXSTAT=$P(ECXFELOC,"ORD",1),ECXFORM="ORD"
 ..S ECXLLC=$P(NODE0,U,26),ECXLMC=$P(NODE0,U,27)
 .;ignore record for receiving station feeder location
 .Q:ECXFELOC["LAB"
 .;ignore record if division not included in this report
 .Q:ECXSTAT=""  Q:'$D(DIVISION(ECXSTAT))
 .;if combining data from all subdivisions, then set in ^tmp using primary station#
 .I ECXALL=1 S ECXSTAT=$P(ECXPRIME,U,2)
 .;be sure there's no padding on cost variables
 .S ECXCTAMT=+$TR(ECXCTAMT," ",0),ECXLLC=+$TR(ECXLLC," ",0),ECXLMC=+$TR(ECXLMC," ",0)
 .;tmp global holds - com qty^com cost^va nonlab qty^va nonlab cost^lab qty^lab labor cost^lab matrl cost
 .I '$D(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC)) S ^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC)="0^0^0^0^0^0^0"
 .I ECXSRCE="C",ECXFORM="NONL" D
 ..S $P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,1)=$P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,1)+ECXQTY
 ..S $P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,2)=$P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,2)+ECXCTAMT
 .I ECXSRCE="V",ECXFORM="NONL" D
 ..S $P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,3)=$P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,3)+ECXQTY
 ..S $P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,4)=$P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,4)+ECXCTAMT
 .I ECXFORM="ORD" D
 ..S $P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,5)=$P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,5)+ECXQTY
 ..S $P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,6)=$P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,6)+ECXLLC
 ..S $P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,7)=$P(^TMP($J,"ECXP",ECXSTAT,ECXTYPE,ECXHCPC),U,7)+ECXLMC
 ;setup hcpcs descriptions
 D HCPCS
 ;print report
 D PRINT^ECXCPRO1
 ;cleanup
 D AUDIT^ECXKILL
 Q
 ;
HCPCS ;setup hcpcs cross-reference
 N H,HCPCS,CODE,CPTNM,DESC
 S H=0
 F  S H=$O(^RMPR(661.1,H)) Q:+H<1  D
 .;don't skip inactive hcpcs in case doing previous fy
 .S HCPCS="",HCPCS=$P(^RMPR(661.1,H,0),U,1)
 .S CODE=$$CPT^ICPTCOD(HCPCS)
 .I +CODE>0 S CPTNM=$P(CODE,U,2),DESC=$E($P(CODE,U,3),1,26)
 .Q:CPTNM=""
 .S ^TMP($J,"HCPCS",CPTNM)=DESC
 Q
