ECXASUR ;ALB/JAP - SUR Extract Audit Report ; 4/26/02 11:16am
 ;;3.0;DSS EXTRACTS;**8,33,44,123**;Dec 22, 1997;Build 8
 ;
EN ;entry point for SUR extract audit report
 ;select extract
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,SITES,ECX
 ;ecxaud=0 for 'extract' audit
 S ECXERR=0
 S ECXHEAD="SUR",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;determine if facility is multidivisional
 K ECX D FILE^DID(133,,"ENTRIES","ECX") S SITES=ECX("ENTRIES") K ECX
 I SITES=1 S ECXALL=1
 I SITES>1 D
 .W !!
 .S DIR(0)="Y",DIR("A")="Do you want the "_ECXHEAD_" extract audit report for all divisions"
 .S DIR("B")="NO" D ^DIR K DIR
 .I $G(DIRUT) S ECXERR=1 Q
 .;if y=0 i.e., 'no', then ecxall=0 i.e., 'selected'
 .S ECXALL=Y
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;select divisions/sites; all divisions if ecxall=1
 W !
 S ECXSTART=ECXARRAY("START"),ECXEND=ECXARRAY("END")
 D SUR^ECXDVSN2(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 S ECXPGM="PROCESS^ECXASUR",ECXDESC="SUR Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXASUR
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.811
 N X,Y,JJ,DIV,IEN,DATA,DATE,CASE,CASES,OR,LOC,PROC,PROCN,PSI,CAN,CPT,DIC,QQFLG,CNT
 K ^TMP($J,"ECXAUD"),^TMP($J,"ECXS")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get records within date range and surgery site(s)
 S IEN="" F  S IEN=$O(^ECX(727.811,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.811,IEN,0),DATA1=^(1),DATE=$P(DATA,U,9)
 .S DIV=$P(DATA,U,4)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .Q:'$D(ECXDIV(DIV))
 .Q:$P(DATA,U,17)="I"
 .S CASE=$P(DATA,U,10),OR=$P(DATA,U,12),PSI=$P(DATA,U,17)
 .S CAN=$P(DATA,U,28)
 .S PROC=$E($P(DATA1,U,11),1,5)
 .Q:(PROC="")&(PSI="I")
 .S (CPT,PROCN)="" I PROC]"" D
 ..;from cpt code get procedure name; variable cpt should be same as variable proc
 ..S Y=$$CPT^ICPTCOD(PROC,DATE)
 ..S CPT=$P($G(Y),U,2),PROCN=$P($G(Y),U,3)
 .S:CPT="" CPT="Unknown" S:PROCN="" PROCN="Unknown" S CPT="A"_CPT
 .S LOC=$S(OR="":2,1:1)
 .I CAN'="" S LOC=3
 .;tally procedures by location and division
 .I '$D(^TMP($J,"ECXAUD",DIV,LOC,CPT)) S ^TMP($J,"ECXAUD",DIV,LOC,CPT)=0_U_PROCN
 .S $P(^(CPT),U,1)=$P(^TMP($J,"ECXAUD",DIV,LOC,CPT),U,1)+1,CNT=CNT+1
 .I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ Q
 .I '$D(^TMP($J,"ECXS",DIV,LOC,CASE)) S ^TMP($J,"ECXS",DIV,LOC,CASE)=""
 ;total cases for each division and location
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S DIV="" F  S DIV=$O(^TMP($J,"ECXS",DIV)) Q:DIV=""  F LOC=1:1:3 S CASES(DIV,LOC)=0,CASE="" D
 .F  S CASE=$O(^TMP($J,"ECXS",DIV,LOC,CASE)) Q:CASE=""  S CASES(DIV,LOC)=CASES(DIV,LOC)+1
 K ^TMP($J,"ECXS")
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print the SUR audit report by location and division
 N LN,PG,QFLG,TOT,GTOT,DIVNM,CPT,CPTN,PROCN,LOCNM,LOCNMC,SS,DIR,DR,DIRUT,DTOUT,DUOUT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  F LOC=1:1:3 D  Q:QFLG
 .S DIVNM=$P(ECXDIV(DIV),U,2)_" ("_DIV_")",GTOT(LOC)=0
 .S LOCNM=$S(LOC=1:"O.R. Surgical Procedures",LOC=2:"Non-O.R. Surgical Procedures",1:"Cancelled/Aborted Procedures")
 .D HEADER
 .I '$D(^TMP($J,"ECXAUD",DIV,LOC)) D
 ..W !!,?3,"No data available for "_LOCNM_".",!!
 .I $D(^TMP($J,"ECXAUD",DIV,LOC)) S CPT="" F  S CPT=$O(^TMP($J,"ECXAUD",DIV,LOC,CPT)) Q:CPT=""  S TOT(LOC)=$P(^(CPT),U,1),PROCN=$P(^(CPT),U,2),CPTN=$E(CPT,2,99) D  Q:QFLG
 ..S GTOT(LOC)=GTOT(LOC)+TOT(LOC)
 ..;write procedure and total
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,CPTN,?14,$E(PROCN,1,40),?63,$$RJ^XLFSTR(TOT(LOC),5," ")
 .;write the division totals
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,$E(LN,1,65)
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"For Division "_DIVNM_"--"
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,"Total "_LOCNM_":",?63,$$RJ^XLFSTR(GTOT(LOC),5," ")
 .S LOCNMC=$P(LOCNM,"Pro",1) S:'$D(CASES(DIV,LOC)) CASES(DIV,LOC)=0
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,"Total "_LOCNMC_"Cases:",?63,$$RJ^XLFSTR(CASES(DIV,LOC),5," ")
 ;print the audit descriptive narrative
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:    "_ECXEXT
 .W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time: "_ECXRUN,?68,"Page: ",PG
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
 W !,"Surgery Division:     "_$P(ECXDIV(DIV),U,2)_" ("_DIV_")",?63,"Page: "_PG
 W !!,LOCNM
 W !,?3,"CPT Code",?14,"Procedure",?63,"# of Procedures"
 W !,LN,!
 Q
