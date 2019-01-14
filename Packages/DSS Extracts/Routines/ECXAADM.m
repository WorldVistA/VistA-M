ECXAADM ;ALB/JAP - ADM Extract Audit Report ;12/11/18  12:06
 ;;3.0;DSS EXTRACTS;**8,33,149,170,173**;Dec 22, 1997;Build 3
EN ;entry point for ADM extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,DIRUT,DTOUT,DUOUT,ECXPORT,RCNT ;149
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
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q  ;149 Section added
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="EXTRACT LOG #^MEDICAL CENTER DIVISION^DATE RANGE OF AUDIT^WARD <DSS DEPT.>^# OF ADMISSIONS^",RCNT=1 ;173
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
 .D PROCESS^ECXAADM
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.802
 N X,Y,W,DATE,DIV,IEN,TL,ORDER,SORD,GTOT,STOT,WARD,QQFLG,CNT,TSV,ASIH ;170,173
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
 .S DATE=$P(^ECX(727.802,IEN,0),U,9),WARD=$P(^(0),U,28),TSV=$P(^(0),U,29),ASIH=$S($P(^(0),U,8)="A":1,1:0) ;170,173 Add Treating Specialty Value and ASIH status
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;track missing wards
 .I WARD="" D  ;170
 ..S ^TMP($J,"MISWRD")=$G(^TMP($J,"MISWRD"))+1,^("MISWRD",IEN)=""
 .;170 Track missing treating specialties
 .I TSV="" D  ;170
 ..S ^TMP($J,"MISTRT")=$G(^TMP($J,"MISTRT"))+1,^("MISTRT",IEN)="" ;170
 .I ASIH S ^TMP($J,"ASIH")=$G(^TMP($J,"ASIH"))+1,^("ASIH",IEN)="" ;173 Count ASIH records
 .I WARD=""!(TSV="")!(ASIH) Q  ;170,173 Don't process if missing ward or treating specialty or ASIH OTHER FACILITY
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
 I '$G(ECXPORT) D AUDIT^ECXKILL ;149
 Q
 ;
PRINT ;print the admission data by division and ward order
 N JJ,SS,LN,PG,QFLG,WRDNM,WRDTOT,GRPNM,GRPTOT,DATA,DATA1,DIC,DA,DR,DIR,DIVNM,MISTYPE ;149,170
 N DIRUT,DTOUT,DUOUT,IEN,FAC,ADMDT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(GTOT(DIV)) Q:DIV=""  D  Q:QFLG
 .S DIVNM=$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")"_$S($P(ECXDIV(DIV),U,6)'="":(" <"_$P(ECXDIV(DIV),U,6)_">"),1:"") ;149
 .I '$G(ECXPORT) D HEADER Q:QFLG  ;149
 .I GTOT(DIV)=0 D  Q
 ..I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)=DIVNM_U_ECXARRAY("START")_" to "_ECXARRAY("END")_U_"No admission data extracted for this medical center division",RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1 Q  ;149
 ..W !!,?5,"No admission data extracted for this medical center division.",!
 .S ORDER="" F  S ORDER=$O(^TMP($J,"ECXORDER",DIV,ORDER)) Q:ORDER=""  D  Q:QFLG
 ..S DATA=^TMP($J,"ECXORDER",DIV,ORDER) K DATA1 I $D(^(ORDER,1)) S DATA1=^(1)
 ..S WRDNM=$P(DATA,U,2),WRDTOT=+$P(DATA,U,3)
 ..;don't display inactive wards unless there is admission data
 ..;don't attempt to group inactive/unordered wards
 ..I ORDER>999990 K DATA1 I WRDTOT=0 Q
 ..I '$G(ECXPORT) D:($Y+3>IOSL) HEADER Q:QFLG  ;149
 ..I '$G(ECXPORT) W !,?5,WRDNM,?45,$$RJ^XLFSTR(WRDTOT,5," ") ;149
 ..I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)=ECXEXT_U_DIVNM_U_ECXARRAY("START")_" to "_ECXARRAY("END")_U_WRDNM_U_WRDTOT,RCNT=RCNT+1 ;149
 ..;if data1 exists, then this is the end of a ward group so print group total
 ..I $G(DATA1) D  Q:QFLG
 ...S GRPNM=$P(DATA1,U,2),GRPTOT=$P(DATA1,U,3)
 ...I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)="^^Ward group "_GRPNM_" subtotal:"_U_GRPTOT,RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1 Q  ;149
 ...D:($Y+3>IOSL) HEADER Q:QFLG
 ...W !,?40,"----------"
 ...W !,"Ward group "_GRPNM_" subtotal:",?45,$$RJ^XLFSTR(GRPTOT,5," ")
 ...D:($Y+3>IOSL) HEADER Q:QFLG
 ...W !!
 .I '$G(ECXPORT) D:($Y+3>IOSL) HEADER Q:QFLG  ;149
 .I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)="^^Division "_$P(ECXDIV(DIV),U,2)_U_"Grand Total:"_U_GTOT(DIV),RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1 Q  ;149
 .W !!,"Division "_$P(ECXDIV(DIV),U,2)_" Grand Total:",?45,$$RJ^XLFSTR(GTOT(DIV),5," ")
 ;print patients with missing wards or missing treating specialties
 Q:QFLG  ;149 Stop if user entered "^"
 F MISTYPE="MISWRD","MISTRT","ASIH" Q:QFLG  I $D(^TMP($J,MISTYPE)) D  ;170,173
 .S DIV=MISTYPE,ECXDIV(DIV)="^^^^^*** "_$S(MISTYPE="MISWRD":"MISSING WARDS",MISTYPE="ASIH":"ASIH OTHER FACILITY",1:"MISSING TREATING SPECIALTIES")_" ***^" D:'$G(ECXPORT) HEADER Q:QFLG  ;149,170,173
 .S WRDTOT=$G(^TMP($J,MISTYPE)) ;170
 .I '$G(ECXPORT) D  ;149,170,173
 ..W !,?5,$S(MISTYPE="MISWRD":"MISSING WARD",MISTYPE="ASIH":"ASIH OTHER FACILITY",1:"MISSING TREATING SPECIALTY"),?45,$$RJ^XLFSTR(WRDTOT,5," "),!! ;149,170,173
 ..I MISTYPE="ASIH" D  ;173
 ...W "Note: Starting with FY19, records will be generated in the extract for ASIH" ;173
 ...W !,"Other Facility movement types.  If present in your facility, the Extract"
 ...W !,"Audit report will display these records here and they require no action.",!! ;173
 .I $G(ECXPORT) D  ;149,170
 ..S ^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^^"_$S(MISTYPE="MISWRD":"MISSING WARD",MISTYPE="ASIH":"ASIH OTHER FACILITY",1:"MISSING TREATING SPECIALTY")_U_WRDTOT ;170,173
 ..I MISTYPE="ASIH" D  ;173
 ...S RCNT=RCNT+1 ;173
 ...S ^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^Note: Starting with FY19, records will be generated in the extract for ASIH Other",RCNT=RCNT+1 ;173
 ...S ^TMP($J,"ECXPORT",RCNT)="^Facility movement types. If present in your facility, the Extract Audit report will",RCNT=RCNT+1 ;173
 ...S ^TMP($J,"ECXPORT",RCNT)="^display these records here and they require no action." ;173
 ..S RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^",RCNT=RCNT+1,^TMP($J,"ECXPORT",RCNT)="^NAME^PATIENT DFN^FACILITY^ADMISSION DATE^ASIH OTHER FACILITY",RCNT=RCNT+1 ;170,173
 .I '$G(ECXPORT) D HEAD ;149
 .S IEN="" F  S IEN=$O(^TMP($J,MISTYPE,IEN)) Q:'IEN  D  I QFLG Q  ;170
 ..S DATA=$G(^ECX(727.802,IEN,0)),ADMDT=$P(DATA,U,9) Q:DATA=""
 ..S FAC=$P(DATA,U,4) S:FAC'="" FAC=$$GET1^DIQ(40.8,FAC,.01,"E") ;173
 ..I $G(ECXPORT) S ^TMP($J,"ECXPORT",RCNT)="^"_$P(DATA,U,7)_U_$P(DATA,U,5)_U_FAC_U_$E(ADMDT,5,6)_"/"_$E(ADMDT,7,8)_"/"_$E(ADMDT,1,4)_" "_$E($P(DATA,U,34),1,2)_":"_$E($P(DATA,U,34),3,4)_U_$S($P(DATA,U,8)="A":"YES",1:"NO"),RCNT=RCNT+1 Q  ;149,173
 ..W !?2,$P(DATA,U,7),?8,$P(DATA,U,5),?25,$E(FAC,1,14),?45
 ..W $E(ADMDT,5,6)_"/"_$E(ADMDT,7,8)_"/"_$E(ADMDT,1,4)," "
 ..W $E($P(DATA,U,34),1,2)_":"_$E($P(DATA,U,34),3,4)
 ..W ?63,$S($P(DATA,U,8)="A":"YES",1:"NO") ;173
 ..D:($Y+3>IOSL) HEADER,HEAD Q:QFLG
 I $G(ECXPORT) Q  ;149
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
HEAD ;173 header for missing wards, treating specialties, and ASIH OTHER FACILITY
 W !,?2,"NAME",?8,"PATIENT DFN",?25,"FACILITY",?45,"ADMISSION DATE",?63,"ASIH OTHER FAC" ;173
 W !,?2,"====",?8,"===========",?25,"========",?45,"==============",?63,"==============" ;173
 Q
 ;
HEADER ;header and page control
 N JJ,SS,DIR,DIRUT,DTOUT,DUOUT,DSSID
 I $E(IOST)="C",'QFLG D  ;149 Stop if user entered "^"
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
