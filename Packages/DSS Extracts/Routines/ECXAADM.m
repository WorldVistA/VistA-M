ECXAADM ;ALB/JAP - ADM Extract Audit Report ;Oct 08, 1997
 ;;3.0;DSS EXTRACTS;**8,33**;Dec 22, 1997
EN ;entry point for ADM extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,DIRUT,DTOUT,DUOUT
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="ADM",ECXAUD=0
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
 W !
 D ADM^ECXDVSN(.ECXDIV,ECXALL,ECXSTART,ECXEND,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 S ECXPGM="PROCESS^ECXAADM",ECXDESC="ADM Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXAADM
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.802
 N X,Y,W,DATE,DIV,IEN,TL,ORDER,SORD,GTOT,STOT,WARD,QQFLG,CNT
 K ^TMP($J,"ECXWARD"),^TMP($J,"ECXORDER")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get ward info in ^tmp($j,"ecxward" and ^tmp($j,"ecxorder"
 D WARDS^ECXUTLA(ECXALL,.ECXDIV)
 S W="" F  S W=$O(^TMP($J,"ECXWARD",W)) Q:W=""  D
 .S DIV=$P(^TMP($J,"ECXWARD",W),U,3),GTOT(DIV)=0,TL(W)=0,ORDER="" D
 ..F  S ORDER=$O(^TMP($J,"ECXORDER",DIV,ORDER)) Q:ORDER=""  I $D(^(ORDER,1)) S STOT(DIV,ORDER)=0
 ;get records in date range and ward set
 S IEN="" F  S IEN=$O(^ECX(727.802,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATE=$P(^ECX(727.802,IEN,0),U,9),WARD=$P(^(0),U,28)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;track missing wards
 .I WARD="" D  Q
 ..S ^TMP($J,"MISWRD")=$G(^TMP($J,"MISWRD"))+1,^("MISWRD",IEN)=""
 .;if ward is among those selected, then tally admission data
 .I $D(TL(WARD)) S TL(WARD)=TL(WARD)+1,CNT=CNT+1
 .I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;after all the extract records are processed, set totals into ^tmp($j,"ecxorder"
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S W="" F  S W=$O(TL(W)) Q:W=""  D
 .S ORDER=$P(^TMP($J,"ECXWARD",W),U,1),DIV=$P(^(W),U,3)
 .S $P(^TMP($J,"ECXORDER",DIV,ORDER),U,3)=TL(W)
 ;determine ward group subtotal and division grandtotal
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S DIV="" F  S DIV=$O(^TMP($J,"ECXORDER",DIV)) Q:DIV=""  S GTOT(DIV)=0 D
 .S ORDER="",STOT=0 F  S ORDER=$O(^TMP($J,"ECXORDER",DIV,ORDER)) Q:ORDER=""  D
 ..S TOT=$P(^TMP($J,"ECXORDER",DIV,ORDER),U,3),STOT=STOT+TOT,GTOT(DIV)=GTOT(DIV)+TOT
 ..I $D(^TMP($J,"ECXORDER",DIV,ORDER,1)) S $P(^(1),U,3)=STOT,STOT=0
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print the admission data by division and ward order
 N JJ,SS,LN,PG,QFLG,WRDNM,WRDTOT,GRPNM,GRPTOT,DATA,DATA1,DIC,DA,DR,DIR
 N DIRUT,DTOUT,DUOUT,IEN,FAC,ADMDT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(GTOT(DIV)) Q:DIV=""  D  Q:QFLG
 .D HEADER Q:QFLG
 .I GTOT(DIV)=0 D  Q
 ..W !!,?5,"No admission data extracted for this medical center division.",!
 .S ORDER="" F  S ORDER=$O(^TMP($J,"ECXORDER",DIV,ORDER)) Q:ORDER=""  D  Q:QFLG
 ..S DATA=^TMP($J,"ECXORDER",DIV,ORDER) K DATA1 I $D(^(ORDER,1)) S DATA1=^(1)
 ..S WRDNM=$P(DATA,U,2),WRDTOT=+$P(DATA,U,3)
 ..;don't display inactive wards unless there is admission data
 ..;don't attempt to group inactive/unordered wards
 ..I ORDER>999990 K DATA1 I WRDTOT=0 Q
 ..D:($Y+3>IOSL) HEADER Q:QFLG
 ..W !,?5,WRDNM,?45,$$RJ^XLFSTR(WRDTOT,5," ")
 ..;if data1 exists, then this is the end of a ward group so print group total
 ..I $G(DATA1) D  Q:QFLG
 ...S GRPNM=$P(DATA1,U,2),GRPTOT=$P(DATA1,U,3)
 ...D:($Y+3>IOSL) HEADER Q:QFLG
 ...W !,?40,"----------"
 ...W !,"Ward group "_GRPNM_" subtotal:",?45,$$RJ^XLFSTR(GRPTOT,5," ")
 ...D:($Y+3>IOSL) HEADER Q:QFLG
 ...W !!
 .D:($Y+3>IOSL) HEADER Q:QFLG
 .W !!,"Division "_$P(ECXDIV(DIV),U,2)_" Grand Total:",?45,$$RJ^XLFSTR(GTOT(DIV),5," ")
 ;print patients with missing wards
 I $D(^TMP($J,"MISWRD")) D
 .S DIV="MISWRD",ECXDIV(DIV)="^^^^^*** MISSING WARDS ***^" D HEADER
 .S WRDTOT=$G(^TMP($J,"MISWRD"))
 .W !,?5,"MISSING WARD",?45,$$RJ^XLFSTR(WRDTOT,5," "),!!
 .D HEAD
 .S IEN="" F  S IEN=$O(^TMP($J,"MISWRD",IEN)) Q:'IEN  D  I QFLG Q
 ..S DATA=$G(^ECX(727.802,IEN,0)),ADMDT=$P(DATA,U,9) Q:DATA=""
 ..S FAC=$P(DATA,U,4) S:FAC'="" FAC=$$GET1^DIQ(40.8,FAC,.01,"E")
 ..W !?2,$P(DATA,U,7),?8,$P(DATA,U,5),?25,$E(FAC,1,14),?45
 ..W $E(ADMDT,5,6)_"/"_$E(ADMDT,7,8)_"/"_$E(ADMDT,1,4)," "
 ..W $E($P(DATA,U,34),1,2)_":"_$E($P(DATA,U,34),3,4)
 ..D:($Y+3>IOSL) HEADER,HEAD Q:QFLG
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:       "_ECXEXT
 .W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time:    "_ECXRUN,?68,"Page: ",PG
 .W !!,LN,!!
 .S DIC="^ECX(727.1,",DA=ECXARRAY("DEF"),DR="1" D EN^DIQ
 .W @IOF
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 Q
 ;
HEAD ;header for missing wards
 W !,?2,"NAME",?8,"PATIENT DFN",?25,"FACILITY",?45,"ADMISSION DATE"
 W !,?2,"====",?8,"===========",?25,"========",?45,"=============="
 Q
 ;
HEADER ;header and page control
 N JJ,SS,DIR,DIRUT,DTOUT,DUOUT,DSSID
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 S DSSID=$P(ECXDIV(DIV),U,6)
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 W !,"DSS Extract Log #:       "_ECXEXT
 W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time:    "_ECXRUN
 I DSSID="" W !,"Medical Center Division: "_$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")",?68,"Page: "_PG
 I DSSID]"" W !,"Medical Center Division: "_$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")"_" <"_DSSID_">",?68,"Page: "_PG
 W !!,?5,"Ward <DSS Dept.>",?40,"# of Admissions"
 W !,LN,!
 Q
