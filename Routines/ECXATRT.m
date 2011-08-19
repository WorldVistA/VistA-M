ECXATRT ;ALB/JAP - TRT Extract Audit Report ;O4/12/2007
 ;;3.0;DSS EXTRACTS;**1,6,8,107,105**;Dec 22, 1997;Build 70
 ;
EN ;entry point for TRT extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="TRT",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;currently, this extract does not capture divisional data
 S ECXALL=1
 D TRT^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 W !
 S ECXPGM="PROCESS^ECXATRT",ECXDESC="TRT Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXATRT
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.817
 N X,Y,W,DATA,DATE,DIV,IEN,TS,SPEC,FTS,FTSNM,SERV,ECX,QQFLG,CNT,A1,A2,NUM,MN,NEWFTS,NEWSPEC
 K ^TMP($J,"ECXAUD"),^TMP($J,"ECXSPEC")
 S (QQFLG,CNT)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;set up the specialty array for site/division
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S DIV="" F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  D
 .S DIC="^DIC(42.4,",DR=".01;3",DIQ(0)="E",DIQ="ECX"
 .S SPEC="" F  S SPEC=$O(^DIC(42.4,"B",SPEC)) Q:SPEC=""  S TS=$O(^(SPEC,0)) D
 ..K ECX S DA=TS D EN^DIQ1
 ..S SPEC=$G(ECX(42.4,TS,.01,"E")),SERV=$G(ECX(42.4,TS,3,"E")) S:SERV="" SERV="Unknown"
 ..S ^TMP($J,"ECXSPEC",DIV,TS)=0_U_SERV_U_SPEC,NUM(TS)=0
 ;set up the specialty to facility treating specialty conversion array;
 ;determine if active between ecxstart and ecxend;
 ;ignore if facility treating specialty not active within date range of report;
 S DIC="^DIC(45.7,",DR=".01;1",DIQ(0)="I",DIQ="ECX"
 S FTSNM="" F  S FTSNM=$O(^DIC(45.7,"B",FTSNM)) Q:FTSNM=""  S FTS=$O(^(FTSNM,0)) D
 .K ECX S DA=FTS D EN^DIQ1
 .S FTSNM=$G(ECX(45.7,FTS,.01,"I")),TS=$G(ECX(45.7,FTS,1,"I"))
 .Q:TS=""
 .S A1=$$ACTIVE^DGACT(45.7,FTS,ECXSTART),A2=$$ACTIVE^DGACT(45.7,FTS,ECXEND)
 .Q:A1=0&(A2=0)
 .;num(ts) will hold the number of active facility treat. specialties (file #45.7) associated 
 .;with this national specialty (file #42.4).
 .I '$D(NUM(TS)) S NUM(TS)=0
 .S ^TMP($J,"ECXTS",TS,FTS)=FTSNM,^TMP($J,"ECXREVTS",FTS)=TS,NUM(TS)=NUM(TS)+1
 ;get extract records in date range
 S IEN="" F  S IEN=$O(^ECX(727.817,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.817,IEN,0),DATE=$P(DATA,U,9),DIV=$P(DATA,U,4)
 .;currently the 4th piece of extract record is always null for trt
 .S:DIV="" DIV=1
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .I $D(ECXDIV(DIV)) D
 ..;ts is the old specialty, newfts is the new facility treat. spec. for the movement date;
 ..;after patch #1 'losing treating specialty los' field (#17) is non-null only for actual specialty changes;
 ..;so should be able to distinguish true ts changes from provider-only changes;
 ..;although it will still be possible that old and new specialty are the same, but facility
 ..;treat. spec. was changed, but we've lost that info in the extract.
 ..;
 ..;filter out those records which are definitely provider-only changes;
 ..;these are the records that have 'losing treating specialty los' which is null;
 ..;but for extracts done prior to patch #1, still need to compare old & new specialty.
 ..;
 ..;convert 15th and 16th piece from PTF code back to Specialty
 ..;ECX*3.0*107
 ..;
 ..N ECXTS
 ..S ECXTS=$P(DATA,U,15) I ECXTS'="" S ECXTS=$O(^DIC(42.4,"C",$G(ECXTS),0)),$P(DATA,U,15)=ECXTS
 ..S ECXTS=$P(DATA,U,16) I ECXTS'="" S ECXTS=$O(^DIC(42.4,"C",$G(ECXTS),0)),$P(DATA,U,16)=ECXTS
 ..S NEWTS=$P(DATA,U,15),TS=$P(DATA,U,16),LOS=$P(DATA,U,17)
 ..;leaving this next line in here for v3.0 extracts done prior to patch #1
 ..Q:(NUM(+TS)=1)&(NEWTS=TS)
 ..Q:LOS=""
 ..S $P(^(TS),U,1)=$P(^TMP($J,"ECXSPEC",DIV,TS),U,1)+1,CNT=CNT+1
 ..I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;after all extract records processed, arrange by service and specialty;
 ;total can only be associated with specialty, not facility treating specialty;
 ;include specialty only if total loss is non-zero
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S DIV="" F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  I $D(^TMP($J,"ECXSPEC",DIV)) D
 .S TS="" F  S TS=$O(^TMP($J,"ECXSPEC",DIV,TS)) Q:TS=""  D
 ..S TOT=+$P(^TMP($J,"ECXSPEC",DIV,TS),U,1) I TOT>0 D
 ...S SERV=$P(^(TS),U,2),SPEC=$P(^(TS),U,3)
 ...S ^TMP($J,"ECXAUD",DIV,SERV,SPEC)=TOT_U_TS
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print trt data by site, by service, by specialty
 N JJ,SS,LN,P,DIV,DIVNM,GTOT,SVCTOT,PG,QFLG,DIR,DIRUT,DTOUT,DUOUT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)=""
 ;division associated with the treat. spec. change is not actually known; division is dss site
 S DIV="" S DIV=$O(ECXDIV(DIV)) Q:DIV=""  S GTOT=0
 D HEADER
 I '$D(^TMP($J,"ECXAUD",DIV)) D  Q
 .W !!,?5,"No data available for this DSS Site.",!!
 I $D(^TMP($J,"ECXAUD",DIV)) S SERV="" F  S SERV=$O(^TMP($J,"ECXAUD",DIV,SERV)) Q:SERV=""  D  Q:QFLG
 .S SVCTOT=0
 .;write the service name
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,SERV
 .S SPEC="" F  S SPEC=$O(^TMP($J,"ECXAUD",DIV,SERV,SPEC)) Q:SPEC=""  D  Q:QFLG
 ..;write the specialty name and total
 ..S TOT=$P(^TMP($J,"ECXAUD",DIV,SERV,SPEC),U,1),TS=$P(^(SPEC),U,2)
 ..W ?22,$E(SPEC,1,30)_" ("_TS_")",?68,$$RJ^XLFSTR(TOT,5," "),!
 ..S SVCTOT=SVCTOT+TOT,GTOT=GTOT+TOT
 ..S FTS="" F  S FTS=$O(^TMP($J,"ECXTS",TS,FTS)) Q:FTS=""  D  Q:QFLG
 ...S FTSNM=^TMP($J,"ECXTS",TS,FTS)
 ...D:($Y+3>IOSL) HEADER Q:QFLG  W ?25,$E(FTSNM,1,30),!
 .;write the service subtotal
 .Q:QFLG
 .W ?22,$E(LN,1,54),!
 .D:($Y+3>IOSL) HEADER Q:QFLG  W "Total for "_SERV_":",?68,$$RJ^XLFSTR(SVCTOT,5," "),!
 ;write the grandtotal for all services at facility
 D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"Grand Total for all Services:",?68,$$RJ^XLFSTR(GTOT,5," ")
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
 ;W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 W !,"Treating Specialty Change"_" ("_ECXHEAD_") Extract Audit Report"
 W !,"DSS Extract Log #:    "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 W !,"DSS Site:             "_$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")",?68,"Page: "_PG
 W !!,"Service",?22,"Specialty (DSS Code)",?68,"# of Losses"
 W !,?25,"Facility Treating Specialty"
 W !,LN,!
 Q
