ECXARAD ;ALB/JAP - RAD Extract Audit Report ;3/11/14  12:58
 ;;3.0;DSS EXTRACTS;**8,33,39,149**;Dec 22, 1997;Build 27
 ;
EN ;entry point for RAD extract audit report
 ;select extract
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,SITES,ECX,ECXPORT,RCNT ;149
 ;ecxaud=0 for 'extract' audit
 S ECXERR=0
 S ECXHEAD="RAD",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;determine if facility is multidivisional
 K ECX D FILE^DID(79,,"ENTRIES","ECX") S SITES=ECX("ENTRIES") K ECX
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
 D RAD^ECXDVSN2(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 S ECXPGM="PROCESS^ECXARAD",ECXDESC="RAD Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q  ;149 Section added
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="EXTRACT LOG #^RADIOLOGY DIVISION^IMAGING TYPE (FEEDER LOCATION)^CPT CODE^PROCEDURE^# OF INPT PROCEDURES^# OF OUTPT PROCEDURES",RCNT=1
 .D PROCESS
 .D EXPDISP^ECXUTL1
 .D AUDIT^ECXKILL
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXARAD
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.814
 N X,Y,JJ,DIV,IEN,DATA,DATE,ECX,PAT,TYPE,IMNM,IMAB,PROC,PROCN,CPT,DIC,DIQ,DR,DA,QQFLG,CNT
 K ^TMP($J,"ECXAUD")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;setup array of imaging types
 S TYPE=0 F  S TYPE=$O(^RA(79.2,TYPE)) Q:+TYPE<1  D
 .K ECX S DIC="^RA(79.2,",DR=".01;3",DIQ="ECX",DIQ(0)="I",DA=TYPE D EN^DIQ1
 .S TYPE(TYPE)=ECX(79.2,TYPE,.01,"I")_U_ECX(79.2,TYPE,3,"I")
 ;get records within date range and radiology site(s)
 S IEN="" F  S IEN=$O(^ECX(727.814,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.814,IEN,0),DATE=$P(DATA,U,9),DIV=$P(DATA,U,4)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .Q:'$D(ECXDIV(DIV))
 .S PAT=$P(DATA,U,8),TYPE=$P(DATA,U,21),PROC=$P(DATA,U,11)
 .S CPT=$E($P(DATA,U,10),1,5),CPT="A"_$$RJ^XLFSTR(CPT,5,0)
 .S IMNM=$P(TYPE(TYPE),U,1),IMAB=$P(TYPE(TYPE),U,2)
 .K ECX S DIC="^RAMIS(71,",DR=".01",DIQ="ECX",DIQ(0)="I",DA=+PROC D EN^DIQ1
 .S PROCN=$G(ECX(71,+PROC,.01,"I")) I PROCN="" S PROCN="Unknown"
 .;tally procedures; 1st piece is outpatient total, 2nd piece is inpatient total
 .I '$D(^TMP($J,"ECXAUD",DIV,IMNM,CPT)) S ^TMP($J,"ECXAUD",DIV,IMNM,CPT)=0_U_0_U_PROCN
 .I PAT=1!(PAT="O") S $P(^(CPT),U,1)=$P(^TMP($J,"ECXAUD",DIV,IMNM,CPT),U,1)+1,CNT=CNT+1
 .I PAT=3!(PAT="I") S $P(^(CPT),U,2)=$P(^TMP($J,"ECXAUD",DIV,IMNM,CPT),U,2)+1,CNT=CNT+1
 .I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;print the report
 D PRINT
 I $G(ECXPORT) Q  ;149
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print the RAD audit report by radiology site
 N LN,P,PG,QFLG,TOT,STOT,GTOT,DIVNM,IMAG,IMTYPE,T,SS,DIC,DIR,DR,DIRUT,DTOUT,DUOUT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 ;arrange type array by name
 S T=0 F  S T=$O(TYPE(T)) Q:T=""  S IMNM=$P(TYPE(T),U,1),IMAG(IMNM)=T
 F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  D  Q:QFLG
 .S DIVNM=$P(ECXDIV(DIV),U,2)_" ("_DIV_")",GTOT(1)=0,GTOT(3)=0 I '$G(ECXPORT) D HEADER ;149
 .I '$D(^TMP($J,"ECXAUD",DIV)) D  Q
 ..I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)=ECXARRAY("EXTRACT")_U_DIVNM_U_"No data available for this Radiology Division",RCNT=RCNT+1 Q  ;149
 ..W !!,?5,"No data available for this Radiology Division.",!!
 .I $D(^TMP($J,"ECXAUD",DIV)) S IMNM="" F  S IMNM=$O(^TMP($J,"ECXAUD",DIV,IMNM)) Q:IMNM=""  D  Q:QFLG
 ..S STOT(1)=0,STOT(3)=0,IMTYPE=IMAG(IMNM),CPT=""
 ..;write the imaging type name
 ..I '$G(ECXPORT) D:($Y+3>IOSL) HEADER Q:QFLG  W !,IMNM_" ("_DIV_"-"_IMTYPE_")",! ;149
 ..F  S CPT=$O(^TMP($J,"ECXAUD",DIV,IMNM,CPT)) Q:CPT=""  S TOT(1)=$P(^(CPT),U,1),TOT(3)=$P(^(CPT),U,2),PROCN=$P(^(CPT),U,3) D  Q:QFLG
 ...S STOT(1)=STOT(1)+TOT(1),STOT(3)=STOT(3)+TOT(3)
 ...S GTOT(1)=GTOT(1)+TOT(1),GTOT(3)=GTOT(3)+TOT(3)
 ...;write procedure and total
 ...I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)=ECXARRAY("EXTRACT")_U_DIVNM_U_IMNM_" ("_DIV_"-"_IMTYPE_")"_U_$E(CPT,2,6)_U_PROCN_U_TOT(3)_U_TOT(1),RCNT=RCNT+1 Q  ;149
 ...D:($Y+3>IOSL) HEADER Q:QFLG  W ?3,$E(CPT,2,6),?14,$E(PROCN,1,38),?60,$$RJ^XLFSTR(TOT(3),5," "),?70,$$RJ^XLFSTR(TOT(1),5," "),!
 ..;write the unit subtotal
 ..I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^^Sub-totals for "_IMNM_" ("_DIV_"-"_IMTYPE_")"_"^^^"_STOT(3)_U_STOT(1)_U,RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1 Q  ;149
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?5,$E(LN,1,74)
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,"Sub-totals for "_IMNM_" ("_DIV_"-"_IMTYPE_"):",?60,$$RJ^XLFSTR(STOT(3),5," "),?70,$$RJ^XLFSTR(STOT(1),5," "),!
 .;write the division grandtotal
 .I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)="^^Grand Total for Divsion "_DIVNM_"^^^"_GTOT(3)_U_GTOT(1),RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1 Q  ;149
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"Grand Total for Division "_DIVNM_":",?60,$$RJ^XLFSTR(GTOT(3),5," "),?70,$$RJ^XLFSTR(GTOT(1),5," ")
 ;print the audit descriptive narrative
 I $G(ECXPORT) Q  ;149
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
 I $E(IOST)="C",'QFLG D  ;149 Fixed problem with report not stopping when user enters "^"
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 W !,"DSS Extract Log #:    "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 W !,"Radiology Division:   "_$P(ECXDIV(DIV),U,2)_" ("_DIV_")",?60,"Page: "_PG
 W !!,"Imaging Type (Feeder Location)",?60,"# of Procedures"
 W !,?3,"CPT Code",?14,"Procedure",?60,"Inpt.",?70,"Outpt."
 W !,LN,!
 Q
