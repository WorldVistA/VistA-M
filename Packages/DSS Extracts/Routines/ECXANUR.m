ECXANUR ;ALB/JAP - NUR Extract Audit Report ;Oct 15, 1997
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
EN ;entry point for NUR extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="NUR",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;determine if facility is multidivisional
 S DIC="^DG(43,",DA=1,DR="11;",DIQ="ECX",DIQ(0)="I" D EN^DIQ1
 I +ECX(43,1,11,"I")=0 S ECXALL=1
 I +ECX(43,1,11,"I")=1 D
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
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 D NUR^ECXDVSN1(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 W !
 S ECXPGM="PROCESS^ECXANUR",ECXDESC="NUR Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXANUR
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.805
 N X,Y,W,DATA,DATE,DIV,IEN,LOC,PAT,BD,BDS,QQFLG,CNT
 K ^TMP($J,"ECXAUD")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get records in date range and ward set
 S IEN="" F  S IEN=$O(^ECX(727.805,"AC",ECXEXT,IEN)) Q:IEN=""  D
 .S DATA=^ECX(727.805,IEN,0),DATE=$P(DATA,U,9),LOC=$P(DATA,U,13)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;if ward is among those selected, then tally nursing data
 .I $D(ECXDIV(LOC)) D
 ..S DIV="",DIV=$O(ECXDIV(LOC,DIV))
 ..S PAT=$P(DATA,U,10),BD=$P(DATA,U,14)
 ..I '$D(^TMP($J,"ECXAUD",DIV,LOC,BD,PAT)) S ^TMP($J,"ECXAUD",DIV,LOC,BD,PAT)=0
 ..S ^(PAT)=^TMP($J,"ECXAUD",DIV,LOC,BD,PAT)+1,CNT=CNT+1
 ..I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;after all extract records processed, get bedsection names for printing
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S IEN=0 F  S IEN=$O(^NURSF(213.3,IEN)) Q:+IEN=0  S BDS(IEN)=$P(^NURSF(213.3,IEN,0),U,1)
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print the nursing classification data by division and location order
 N JJ,SS,LN,NM,BDNM,NLNM,DIV,DIVNM,LOC,PG,QFLG,BTOT,GTOT,STOT,DIR,DIRUT,DTOUT,DUOUT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(ECXDIV("D",DIV)) Q:DIV=""  D  Q:QFLG
 .S DIVNM=$P(ECXDIV("D",DIV),U,2)_" ("_$P(ECXDIV("D",DIV),U,3)_")" D HEADER
 .I '$D(^TMP($J,"ECXAUD",DIV)) D  Q
 ..W !!,?3,"No data available for this division.",!!
 .F JJ=1:1:5 S GTOT(JJ)=0,GTOT("T")=0
 .I $D(^TMP($J,"ECXAUD",DIV)) S LOC="" F  S LOC=$O(^TMP($J,"ECXAUD",DIV,LOC)) Q:LOC=""  D  Q:QFLG
 ..F JJ=1:1:5 S STOT(JJ)=0,STOT("T")=0
 ..S NLNM=$P(ECXDIV(LOC,DIV),U,2)_" ("_LOC_")",BD=""
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,NLNM
 ..F  S BD=$O(^TMP($J,"ECXAUD",DIV,LOC,BD)) Q:BD=""  D  Q:QFLG
 ...F PAT=1:1:5 S TOT(PAT)=+$G(^TMP($J,"ECXAUD",DIV,LOC,BD,PAT))
 ...S BDNM=BDS(BD),BDNM=$E(BDNM,1,22)_" ("_BD_")",BTOT=0 F JJ=1:1:5 S BTOT=BTOT+TOT(JJ)
 ...;write the bedsection totals
 ...D:($Y+3>IOSL) HEADER Q:QFLG
 ...W !,?3,BDNM,?33,$$RJ^XLFSTR(TOT(1),5," "),?41,$$RJ^XLFSTR(TOT(2),5," "),?50,$$RJ^XLFSTR(TOT(3),5," "),?57,$$RJ^XLFSTR(TOT(4),5," "),?64,$$RJ^XLFSTR(TOT(5),5," "),?74,$$RJ^XLFSTR(BTOT,5," ")
 ...;increment grand total and subtotal
 ...F JJ=1:1:5 S GTOT(JJ)=GTOT(JJ)+TOT(JJ),STOT(JJ)=STOT(JJ)+TOT(JJ)
 ...S GTOT("T")=GTOT("T")+BTOT,STOT("T")=STOT("T")+BTOT
 ..;write the location subtotals
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?33,$E(LN,1,46)
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,"Sub-totals for Location ("_LOC_"):"
 ..W ?33,$$RJ^XLFSTR(STOT(1),5," "),?41,$$RJ^XLFSTR(STOT(2),5," "),?50,$$RJ^XLFSTR(STOT(3),5," "),?57,$$RJ^XLFSTR(STOT(4),5," "),?64,$$RJ^XLFSTR(STOT(5),5," "),?74,$$RJ^XLFSTR(STOT("T"),5," ")
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !!
 .;write the division grand totals
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"Grand Totals for "_DIVNM_":"
 .W ?33,$$RJ^XLFSTR(GTOT(1),5," "),?41,$$RJ^XLFSTR(GTOT(2),5," "),?50,$$RJ^XLFSTR(GTOT(3),5," "),?57,$$RJ^XLFSTR(GTOT(4),5," "),?64,$$RJ^XLFSTR(GTOT(5),5," "),?74,$$RJ^XLFSTR(GTOT("T"),5," ")
 ;print the audit descriptive narrative
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
 W !,"DSS Extract Log #:       "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time:    "_ECXRUN
 W !,"Medical Center Division: "_$P(ECXDIV("D",DIV),U,2)_" ("_$P(ECXDIV("D",DIV),U,3)_")",?68,"Page: "_PG
 W !!,"Nursing Location",?36,"Patients per Acuity Level (Category)"
 W !,?3,"Nursing Bedsection",?37,"I",?44,"II",?52,"III",?60,"IV",?68,"V",?74,"Total"
 W !,LN,!
 Q
