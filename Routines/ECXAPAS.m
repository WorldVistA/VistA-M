ECXAPAS ;ALB/JAP - PAS Extract Audit Report ;Oct 16, 1997
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
EN ;entry point for PAS extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="PAS",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;currently, quasar does not accommodate multi-divisional sites
 S ECXALL=1
 D PAS^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 W !
 S ECXPGM="PROCESS^ECXAPAS",ECXDESC="PAS Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXAPAS
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.823
 N X,Y,W,DATA,DATE,DIV,IEN,QQFLG,CNT
 K ^TMP($J,"ECXAUD")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get extract records in date range
 S IEN="" F  S IEN=$O(^ECX(727.823,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.823,IEN,0),DATE=$P(DATA,U,9),DIV=$P(DATA,U,4)
 .;currently the 4th piece of extract record is always null for pai
 .S:DIV="" DIV=1
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .I $D(ECXDIV(DIV)) D
 ..I '$D(^TMP($J,"ECXAUD",DIV)) S ^TMP($J,"ECXAUD",DIV)=0
 ..S ^(DIV)=^TMP($J,"ECXAUD",DIV)+1,CNT=CNT+1
 ..I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print pai data by site
 N JJ,SS,LN,P,DIV,DIVNM,GTOT,PG,QFLG,DIR,DIRUT,DTOUT,DUOUT
 U IO
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  D  Q:QFLG
 .S DIVNM=$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")" D HEADER
 .S GTOT=$G(^TMP($J,"ECXAUD",DIV))
 .D:($Y+3>IOSL) HEADER Q:QFLG
 .W !!,"Total Patient Assessments extracted for date range: "_GTOT
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:       "_ECXEXT
 .W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time:    "_ECXRUN,?68,"Page: ",PG
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
 W !,"DSS Extract Log #:    "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 W !,"DSS Site:             "_$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")",?68,"Page: "_PG
 W !,LN,!
 Q
