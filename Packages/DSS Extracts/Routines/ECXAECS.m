ECXAECS ;ALB/JAP - ECS Extract Audit Report ;Oct 15, 1997
 ;;3.0;DSS EXTRACTS;**8,33,123**;Dec 22, 1997;Build 8
 ;
EN ;entry point for ECS extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,CNT
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="ECS",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;determine if facility is multidivisional for event capture
 S CNT=0,ECXD="" F  S ECXD=$O(^DIC(4,"LOC",ECXD)) Q:ECXD=""  S CNT=CNT+1
 S ECXALL=1
 I CNT>1 D
 .W !!
 .S DIR(0)="Y",DIR("A")="Do you want the "_ECXHEAD_" extract audit report for all Locations"
 .S DIR("B")="NO" D ^DIR K DIR
 .I $G(DIRUT) S ECXERR=1 Q
 .;if y=0 i.e., 'no', then ecxall=0 i.e., 'selected'
 .S ECXALL=Y
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;select divisions/sites; all ec locations if ecxall=1
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 D ECS^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 W !
 S ECXPGM="PROCESS^ECXAECS",ECXDESC="ECS Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXAECS
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.815
 N X,Y,W,DATA,DATE,DIV,IEN,UNIT,UNITN,CAT,CATN,VOL,PROC,PROCN,PIEN,PRI,PRXF,PRSYN,QQFLG,CNT
 K ^TMP($J,"ECXAUD")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get records in date range
 S IEN="" F  S IEN=$O(^ECX(727.815,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.815,IEN,0),DATE=$P(DATA,U,9),DIV=$P(DATA,U,4)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;if location is among those selected, then tally event capture data
 .I $D(ECXDIV(DIV)) D  Q:QQFLG
 ..S UNIT=$P(DATA,U,10),UNITN=$P($G(^ECD(UNIT,0)),U,1),UNIT(UNITN)=UNIT
 ..;if no category, then cat=0
 ..S CAT=+$P(DATA,U,11),CATN="" S:+CAT CATN=$P($G(^EC(726,CAT,0)),U,1) S:CATN="" CATN="Unknown"
 ..S VOL=$P(DATA,U,13) S:VOL="" VOL=1 S PROC=$E($P(DATA,U,12),1,5)
 ..I '$D(^TMP($J,"ECXAUD",DIV,UNITN,CATN,PROC)) S ^TMP($J,"ECXAUD",DIV,UNITN,CATN,PROC)=0
 ..S ^(PROC)=^TMP($J,"ECXAUD",DIV,UNITN,CATN,PROC)+VOL,CNT=CNT+1
 ..I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ Q
 ..;get the procedure name and setup in global array
 ..S PIEN=0,PROCN="" S:PROC'?5N PIEN=$O(^EC(725,"E",PROC,""))
 ..;procedures from file #725
 ..I +PIEN>0 D
 ...S PROCN=$P($G(^EC(725,PIEN,0)),U,1)
 ...S PRXF=PIEN_";EC(725,"
 ...S PRI=+$O(^ECJ("AP",DIV,UNIT,CAT,PRXF,0)),PRSYN=$P($G(^ECJ(PRI,"PRO")),U,2)
 ...I PRSYN]"" S PROCN=PRSYN
 ..;procedures from file #81
 ..I PIEN=0,PROCN="" D
 ...S PIEN=$$CODEN^ICPTCOD(PROC) I +PIEN>0 S PROCN=$P($$CPT^ICPTCOD(PROC,DATE),U,3)
 ...S PRXF=PIEN_";ICPT("
 ...S PRI=+$O(^ECJ("AP",DIV,UNIT,CAT,PRXF,0)),PRSYN=$P($G(^ECJ(PRI,"PRO")),U,2)
 ...I PRSYN]"" S PROCN=PRSYN
 ..S:PROCN="" PROCN="Unknown"
 ..S ^TMP($J,"ECXPROC",PROC)=PROCN
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print event capture data by location/division and dss unit order
 N JJ,SS,P,PN,LN,NM,DIV,DIVNM,PG,QFLG,GTOT,PROC,STOT,TOT,DIR,DIRUT,DTOUT,DUOUT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  D  Q:QFLG
 .S DIVNM=$P(ECXDIV(DIV),U,2)_" ("_DIV_")",GTOT=0 D HEADER
 .I '$D(^TMP($J,"ECXAUD",DIV)) D  Q
 ..W !!,?5,"No data available for this Event Capture Location.",!!
 .I $D(^TMP($J,"ECXAUD",DIV)) S UNITN="" F  S UNITN=$O(^TMP($J,"ECXAUD",DIV,UNITN)) Q:UNITN=""  D  Q:QFLG
 ..S STOT=0,UNIT=UNIT(UNITN),CATN=""
 ..;write the unit name
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,UNITN_" ("_UNIT_")",!
 ..;initialize the proc array and set totals in array
 ..F  S CATN=$O(^TMP($J,"ECXAUD",DIV,UNITN,CATN)) Q:CATN=""  K PROC S PROC="" D  Q:QFLG
 ...;write the category name
 ...D:($Y+3>IOSL) HEADER Q:QFLG  W !,?5,$E(CATN,1,25)
 ...F  S PROC=$O(^TMP($J,"ECXAUD",DIV,UNITN,CATN,PROC)) Q:PROC=""  S TOT=^(PROC) D
 ....S STOT=STOT+TOT,GTOT=GTOT+TOT,PROCN=""
 ....I $D(^TMP($J,"ECXPROC",PROC)) S PROCN=^(PROC)
 ....S PROC($$LJ^XLFSTR(PROC,6," ")_" "_PROCN)=TOT
 ...S PN="" F  S PN=$O(PROC(PN)) Q:PN=""  S TOT=PROC(PN) D  Q:QFLG
 ....;write procedure and total
 ....W ?35,$E(PN,1,30),?68,$$RJ^XLFSTR(TOT,5," "),!
 ..;write the unit subtotal
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?5,$E(LN,1,74)
 ..W !,"Total Volume for Unit "_UNITN_" ("_UNIT_"):",?68,$$RJ^XLFSTR(STOT,5," "),!
 .;write the division grandtotal
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"Grand Total for Location "_DIVNM_":",?68,$$RJ^XLFSTR(GTOT,5," ")
 ;print the audit descriptive narrative
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:      "_ECXEXT
 .W !,"Date Range of Audit:    "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time:   "_ECXRUN,?68,"Page: ",PG
 .W !!,LN,!!
 .S DIC="^ECX(727.1,",DA=ECXARRAY("DEF"),DR="1" D EN^DIQ
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
HEADER ;header and page control
 N JJ,SS
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 W !,"DSS Extract Log #:      "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:    "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time:   "_ECXRUN
 W !,"Event Capture Location: "_$P(ECXDIV(DIV),U,2)_" ("_DIV_")",?68,"Page: "_PG
 W !!,"DSS Unit",!,?5,"Category",?35,"Procedure",?68,"Volume"
 W !,LN,!
 Q
