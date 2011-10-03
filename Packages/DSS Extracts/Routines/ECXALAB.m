ECXALAB ;ALB/JAP - ECS Extract Audit Report ;Oct 23, 1997
 ;;3.0;DSS EXTRACTS;**1,8**;Dec 22, 1997
 ;
EN ;entry point for LAB extract audit report
 ;this audit report can be used for extracts done with
 ;either ECXLABN or ECXLABO
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="LAB",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 W !!
 ;get the dss site name for report header
 S ECXALL=1 D DEFAULT^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 Q:ECXERR=1
 S DIR(0)="Y",DIR("A")="Do you want the "_ECXHEAD_" extract audit report for all Accession Areas"
 S DIR("B")="NO" D ^DIR K DIR
 I $G(DIRUT) S ECXERR=1 Q
 ;if y=0 i.e., 'no', then ecxall=0 i.e., 'selected'
 S ECXALL=Y
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;select accession areas; all accession areas if ecxall=1
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 D LAB^ECXDVSN1(.ECXACC,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 W !
 S ECXPGM="PROCESS^ECXALAB",ECXDESC="LAB Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXACC(")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXALAB
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.813
 N X,Y,JJ,LMIP,IEN,DATA,DATE,ACC,ACCNM,WKLDNM,WKLD,FILE,QQFLG,CNT
 K ^TMP($J,"ECXAUD")
 S (CNT,QQFLG)=0
 ;see if site is using lmip codes
 S LMIP=+$G(^ECX(728,1,"LMIP"))
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;setup acc. area array by name
 S ACC="" F  S ACC=$O(ECXACC(ACC)) Q:ACC=""  D
 .S ACCNM=$P(ECXACC(ACC),U,1),ACCAB=$P(ECXACC(ACC),U,2),ACC(ACCAB)=ACCNM_" ("_ACCAB_")"
 ;get records within date range and accession area
 S IEN="" F  S IEN=$O(^ECX(727.813,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.813,IEN,0),DATE=$P(DATA,U,9),ACC=$P(DATA,U,11)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .Q:'$D(ACC(ACC))
 .S ACCNM=$P(ACC(ACC),U,1)
 .S WKLD="",WKLD=$P(DATA,U,20) D
 ..S WKLDNM="" I WKLD]"" S X=WKLD,DIC="^LAM(",DIC(0)="MX" D ^DIC S WKLDNM=$P(Y,U,2)
 ..I WKLD="" S:LMIP=1 WKLD="Unknown" S:LMIP=0 WKLD="NA"
 ..I WKLDNM="" S WKLDNM="Unknown "_WKLD
 .S FILE=$P(DATA,U,18)
 .Q:((FILE'=2)&(FILE'=67))
 .I '$D(^TMP($J,"ECXAUD",ACCNM,WKLDNM)) S ^TMP($J,"ECXAUD",ACCNM,WKLDNM)=0_U_0_U_WKLD
 .I FILE=2 S $P(^(WKLDNM),U,1)=$P(^TMP($J,"ECXAUD",ACCNM,WKLDNM),U,1)+1,CNT=CNT+1
 .I FILE=67 S $P(^(WKLDNM),U,2)=$P(^TMP($J,"ECXAUD",ACCNM,WKLDNM),U,2)+1,CNT=CNT+1
 .I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print the LAB audit report by accession area and test
 N SS,LN,PG,QFLG,TOTP,TOTR,GTOT,DIV,DIVNM,ACCAB,DIR,DR,DIRUT,DTOUT,DUOUT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",ACCAB="",DIV="",DIV=$O(ECXDIV(DIV)) D HEADER
 F  S ACCAB=$O(ACC(ACCAB)) Q:ACCAB=""  D  Q:QFLG
 .S ACCNM=ACC(ACCAB),GTOT("P")=0,GTOT("R")=0
 .;write the accession area name
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,ACCNM
 .I '$D(^TMP($J,"ECXAUD",ACCNM)) D  Q
 ..W !,?3,"No data available for this Accession Area.",!!
 .I $D(^TMP($J,"ECXAUD",ACCNM)) S WKLDNM="" F  S WKLDNM=$O(^TMP($J,"ECXAUD",ACCNM,WKLDNM)) Q:WKLDNM=""  D  Q:QFLG
 ..S TOTP=$P(^TMP($J,"ECXAUD",ACCNM,WKLDNM),U,1),TOTR=$P(^(WKLDNM),U,2),WKLD=$P(^(WKLDNM),U,3)
 ..S GTOT("P")=GTOT("P")+TOTP,GTOT("R")=GTOT("R")+TOTR
 ..;write the test data
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,$E(WKLDNM,1,36),?40,WKLD,?56,$$RJ^XLFSTR(TOTP,5," "),?68,$$RJ^XLFSTR(TOTR,5," ")
 .;write the accession area grandtotal
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,$E(LN,1,70)
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,"Total for "_ACCNM_":",?56,$$RJ^XLFSTR(GTOT("P"),5," "),?68,$$RJ^XLFSTR(GTOT("R"),5," "),!!
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
 W !,"DSS Site:             "_$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")",?68,"Page: "_PG
 W !!,"Accession Area (Feeder Location)",?40,"LMIP",?56,"# of Tests",?68,"# of Tests"
 W !,?3,"Procedure",?40,"Code",?56,"(Patients)",?68,"(Referrals)"
 W !,LN,!
 Q
