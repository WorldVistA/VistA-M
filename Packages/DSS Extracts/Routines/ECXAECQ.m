ECXAECQ ;ALB/JAP - ECQ Extract Audit Report ; 5/22/02 3:47pm
 ;;3.0;DSS EXTRACTS;**8,33,35,43,44,123**;Dec 22, 1997;Build 8
 ;
EN ;entry point for ECQ extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,ECXQV,ECXPOS,ECXYR,ECXMTH,ECXPFLG,ECXOPT,QFLG,Q2FLG
 S (ECXERR,QFLG)=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="ECQ",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;determine if version 3 and using EC National Procedure Codes for current fiscal year
 D FILE^DID(509850.6,,"VERSION","ARR","ERR")
 S ECXQV=$G(ARR("VERSION"))
 S ECXPOS=29
 I +ECXQV=3 D 
 .S ECXYR=$E($P(ECXARRAY("START"),",",2),4,5)
 .S ECXMTH=$E(ECXARRAY("START"),1,3)
 .I (ECXMTH="OCT")!(ECXMTH="NOV")!(ECXMTH="DEC") S ECXYR=ECXYR+1
 .S ECDA=0 F  S ECDA=$O(^ACK(509850.8,ECDA)) Q:'ECDA!QFLG  S ECDIV=0 F  S ECDIV=$O(^ACK(509850.8,ECDA,2,ECDIV)) Q:'ECDIV!QFLG  D
 ..S ECCL=0 F  S ECCL=$O(^ACK(509850.8,ECDA,2,ECDIV,2,"B",ECXYR,ECCL)) Q:'ECCL!QFLG  D
 ...S ECXPFLG=$P($G(^ACK(509850.8,ECDA,2,ECDIV,2,ECCL,0)),U,2)
 ...I ECXPFLG D  S QFLG=1
 ....W !!,"Your site has division(s) which are using EC National Procedure Codes for the",!,"fiscal year covering the time period of this extract."
 ....W !!,"You have the option to display either EC National Procedure Codes or CPT Codes",!,"for these division(s)."
 ....F  D  Q:Q2FLG
 .....S Q2FLG=1
 .....S DIR(0)="S^1:EC National Procedure Codes;2:CPT Codes",DIR("A")="Selection",DIR("B")=1 D ^DIR K DIR S ECXOPT=Y
 .....I X["^" W !!,"This is a required response" S Q2FLG=0
 ....I ECXOPT=1 S ECXPOS=12
 ;currently, quasar does not accommodate multi-divisional sites
 S ECXALL=0
 D ECQ^ECXDVSN1(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 W !
 S ECXPGM="PROCESS^ECXAECQ",ECXDESC="ECQ Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")="",ECXSAVE("ECXPOS")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXAECQ
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.825
 N X,Y,W,ADIV,DATA,DATE,DIV,DIVACK,IEN,LOC,ECNIEN
 N UNIT,UNITN,VOL,PROC,PROCN,SDIV,QQFLG,CNT
 K ^TMP($J,"ECXAUD"),^TMP($J,"ECXPROC")
 S (CNT,QQFLG)=0,ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y,X=ECXARRAY("END")
 D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get the dss unit links for this division/site
 S DIV=0
 F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  D
 .S DIVACK=$P(ECXDIV(DIV),U,1),ECXLINK(DIV)=^ACK(509850.8,DIVACK,"DSS")
 ;get extract records in date range
 S IEN=""
 F  S IEN=$O(^ECX(727.825,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.825,IEN,0),DIV=$P(DATA,U,4),DATE=$P(DATA,U,9)
 .S ADIV=$P(^ECX(727.825,IEN,1),U,11) S:ADIV="" ADIV="UNK"
 .I +ADIV S X=^DG(40.8,ADIV,0),ADIV=$P(X,U)_" ("_$P(X,U,2)_")"
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;if location is among those selected, then tally event capture data
 .I $D(ECXDIV(DIV)) D  Q:QQFLG
 ..;any quasar site that doesn't have links to dss is identified by "xx"
 ..S UNIT=$P(DATA,U,10)
 ..S LOC=$S(UNIT=$P(ECXLINK(DIV),U,1):"A",UNIT=$P(ECXLINK(DIV),U,2):"S",1:"XX")
 ..;any invalid cpt code is identified as "xxxxx"
 ..S PROC=$E($P(DATA,U,ECXPOS),1,5),VOL=$P(DATA,U,13),PROCN=""
 ..I ECXPOS=12 D
 ...S ECNIEN=0,ECNIEN=$O(^EC(725,"D",PROC,ECNIEN)) Q:'ECNIEN
 ...S PROCN=$P($G(^EC(725,+ECNIEN,0)),U)
 ..I PROCN="" D
 ...S ECNIEN=0,ECNIEN=$$CODEN^ICPTCOD(PROC) I +ECNIEN>0 S PROCN=$P($$CPT^ICPTCOD(PROC,DATE),U,3)
 ..S PROC="A"_PROC S:VOL="" VOL=1
 ..S:PROCN="" PROCN="Unknown"
 ..I '$D(^TMP($J,"ECXAUD",DIV,ADIV,LOC,PROC)) S ^TMP($J,"ECXAUD",DIV,ADIV,LOC,PROC)=0_U_PROCN
 ..S $P(^(PROC),U,1)=$P(^TMP($J,"ECXAUD",DIV,ADIV,LOC,PROC),U,1)+VOL,CNT=CNT+1
 ..I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print quasar data by site and dss unit order
 N JJ,SS,LN,P,LOC,UNITN,PG,QFLG,GTOT,STOT,TOT,PROC,PROCN
 N DIR,DIRUT,DIV,DIVNM,DTOUT,DUOUT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  D  Q:QFLG
 .S DIVNM=$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")"
 .D HEADER Q:QFLG
 .S GTOT=0,STOT("A")=0,STOT("S")=0,STOT("XX")=0
 .I '$D(^TMP($J,"ECXAUD",DIV)) D  Q
 ..W !!,?5,"No data available for this QUASAR site.",!!
 .I $D(^TMP($J,"ECXAUD",DIV)) S ADIV="" D
 ..F  S ADIV=$O(^TMP($J,"ECXAUD",DIV,ADIV)) Q:ADIV=""  S LOC="" D  Q:QFLG
 ...F  S LOC=$O(^TMP($J,"ECXAUD",DIV,ADIV,LOC)) Q:LOC=""  D  Q:QFLG
 ....;write the unit name
 ....S UNITN=$S(LOC="A":"Audiology",LOC="S":"Speech Pathology",1:"Unknown"),PROC=""
 ....D:($Y+2>IOSL) HEADER Q:QFLG  W !,"Division: ("_ADIV_")",!?20,UNITN
 ....F  S PROC=$O(^TMP($J,"ECXAUD",DIV,ADIV,LOC,PROC)) Q:PROC=""  D  Q:QFLG
 .....S TOT=+^TMP($J,"ECXAUD",DIV,ADIV,LOC,PROC),PROCN=$P(^(PROC),U,2),P=$E(PROC,2,99)
 .....S SDIV(ADIV,LOC)=$G(SDIV(ADIV,LOC))+TOT
 .....S STOT(LOC)=STOT(LOC)+TOT,GTOT=GTOT+TOT
 .....D:($Y+3>IOSL) HEADER Q:QFLG  W !,?25,P,?35,$E(PROCN,1,30),?68,$$RJ^XLFSTR(TOT,5," ")
 ....;write the unit subtotal
 ....D:($Y+4>IOSL) HEADER Q:QFLG
 ....W !,?25,$E(LN,1,54)
 ....W !,"Volume for "_UNITN_":",?68,$$RJ^XLFSTR(+$G(SDIV(ADIV,LOC)),5," "),!!
 .;write the division grandtotal
 .D:($Y+5>IOSL) HEADER Q:QFLG
 .W !!,"Total Volume for Audiology:",?68,$$RJ^XLFSTR(STOT("A"),5," ")
 .W !,"Total Volume for Speech Pathology:",?68,$$RJ^XLFSTR(STOT("S"),5," ")
 .W !!,"Grand Total for Site "_DIVNM_":",?68,$$RJ^XLFSTR(GTOT,5," ")
 ;print the audit descriptive narrative
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:       "_ECXEXT
 .W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time:    "_ECXRUN,?68,"Page: ",PG
 .W !!,LN,!!
 .S DIC="^ECX(727.1,",DA=ECXARRAY("DEF"),DR="1" D EN^DIQ
 I ($E(IOST)="C"),('QFLG) D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q
 ;
HEADER ;header and page control
 N JJ,SS
 I ($E(IOST)="C"),('QFLG) D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 W !,"DSS Extract Log #:    "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 W !,"QUASAR Site:         "_$P(ECXDIV(DIV),U,2)_"("_$P(ECXDIV(DIV),U,3)_")",?68,"Page: "_PG
 W !!,"DSS Unit",?25,"Procedure",?68,"Volume"
 W !,LN
 Q
