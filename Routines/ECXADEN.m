ECXADEN ;ALB/JAP - DEN Extract Audit Report ;Oct 10, 1997
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
EN ;entry point for DEN extract audit report
 ;select extract
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,SITES,ECX
 ;ecxaud=0 for 'extract' audit
 S ECXERR=0
 S ECXHEAD="DEN",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 ;determine if facility is multidivisional
 K ECX D FILE^DID(225,,"ENTRIES","ECX") S SITES=ECX("ENTRIES") K ECX
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
 D DEN^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 S ECXPGM="PROCESS^ECXADEN",ECXDESC="DEN Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXADEN
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.806
 N X,Y,JJ,DATE,DIV,IEN,DFN,SXAM,CXAM,EXAM,PT,TMP,TOTPTS,QQFLG,CNT
 K ^TMP($J,"ECXAUD"),^TMP($J,"ECXPATS"),^TMP($J,"ECXPROC")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;convert ecxdiv array to be subscripted by dental site id #
 S JJ=0 F  S JJ=$O(ECXDIV(JJ)) Q:JJ=""  S DIV=$P(ECXDIV(JJ),U,3),DIV(DIV)=JJ
 ;get records within date range and dental site(s)
 S IEN="" F  S IEN=$O(^ECX(727.806,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S PT=^ECX(727.806,IEN,0)
 .S DATE=$P(PT,U,9),DIV=$P(PT,U,41)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;if dental division is in selected set, then tally dental data
 .Q:'$D(DIV(DIV))
 .S DFN=$P(PT,U,5),(SXAM,CXAM)=0,EXAM=$P(PT,U,11) S:EXAM="S" SXAM=1 S:EXAM="C" CXAM=1
 .S DATA=SXAM_U_CXAM_U
 .S DATA=DATA_+$P(PT,U,44)_U_+$P(PT,U,13)_U_+$P(PT,U,14)_U_+$P(PT,U,18)_U_+$P(PT,U,24)_U_+$P(PT,U,25)_U_+$P(PT,U,26)_U_+$P(PT,U,27)_U
 .S DATA=DATA_+$P(PT,U,15)_U_+$P(PT,U,16)_U_+$P(PT,U,38)_U_+$P(PT,U,39)_U_+$P(PT,U,19)_U_+$P(PT,U,20)_U_+$P(PT,U,21)_U
 .S DATA=DATA_+$P(PT,U,30)_U_+$P(PT,U,31)_U_+$P(PT,U,32)_U_+$P(PT,U,33)_U_+$P(PT,U,34)_U_+$P(PT,U,35)_U_+$P(PT,U,36)
 .I '$D(^TMP($J,"ECXAUD",DIV,DFN)) S ^TMP($J,"ECXAUD",DIV,DFN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 .S TMP=^TMP($J,"ECXAUD",DIV,DFN)
 .F JJ=1:1:24 S $P(TMP,U,JJ)=$P(TMP,U,JJ)+$P(DATA,U,JJ)
 .S ^TMP($J,"ECXAUD",DIV,DFN)=TMP,CNT=CNT+1
 .I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ Q
 ;after all dental extract records processed, then do totals by patient and procedure
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S DIV="" F  S DIV=$O(DIV(DIV)) Q:DIV=""  S TOTPTS(DIV)=0 F JJ=1:1:24 S ^TMP($J,"ECXPROC",DIV,JJ)=0,^TMP($J,"ECXPATS",DIV,JJ)=0
 S DIV="" F  S DIV=$O(^TMP($J,"ECXAUD",DIV)) Q:DIV=""  D
 .S DFN="" F  S DFN=$O(^TMP($J,"ECXAUD",DIV,DFN)) Q:DFN=""  D
 ..S TMP=^TMP($J,"ECXAUD",DIV,DFN),TOTPTS(DIV)=TOTPTS(DIV)+1
 ..F JJ=1:1:24 S ^TMP($J,"ECXPROC",DIV,JJ)=^TMP($J,"ECXPROC",DIV,JJ)+$P(TMP,U,JJ) I +$P(TMP,U,JJ)>0 S ^TMP($J,"ECXPATS",DIV,JJ)=^TMP($J,"ECXPATS",DIV,JJ)+1
 ;print the report
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print the DEN audit report by dental site
 N LN,P,PG,SS,QFLG,GTPROC,GTPAT,TPROC,TPAT,DIEN,TEXT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",80)="",DIV=""
 F  S DIV=$O(^TMP($J,"ECXPROC",DIV)) Q:DIV=""  S DIEN=DIV(DIV) D  Q:QFLG
 .S (GTPROC,GTPAT)=0
 .D HEADER Q:QFLG
 .I TOTPTS(DIV)=0 D  Q
 ..W !!,?28,"No data for Dental Site "_$P(ECXDIV(DIEN),U,3)_".",!
 .S GTPAT=TOTPTS(DIV)
 .F P=1:1:24 D  Q:QFLG
 ..S TEXT=$T(DENT+P),TEXT=$P(TEXT,";;",2),TPROC=^TMP($J,"ECXPROC",DIV,P),TPAT=^TMP($J,"ECXPATS",DIV,P),GTPROC=GTPROC+TPROC
 ..D:($Y+3>IOSL) HEADER Q:QFLG
 ..W !,$E($P(TEXT,U,1),1,25),?28,$E($P(TEXT,U,2),1,25),?56,$$RJ^XLFSTR(TPROC,5," "),?70,$$RJ^XLFSTR(TPAT,5," ")
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !!
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,?56,"-----",?70,"-----"
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,"Totals for Dental Site "_$P(ECXDIV(DIEN),U,3)_":",?56,$$RJ^XLFSTR(GTPROC,5," "),?70,$$RJ^XLFSTR(GTPAT,5," ")," **"
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"** Total # of unique patients.",!
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:    "_ECXEXT
 .W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time: "_ECXRUN,?70,"Page: ",PG
 .W !!,LN,!!
 .S DIC="^ECX(727.1,",DA=ECXARRAY("DEF"),DR="1" D EN^DIQ
 .W @IOF
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
 W !,"DSS Extract Log #:    "_ECXEXT
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 I $P(ECXDIV(DIEN),U,2)="" S $P(ECXDIV(DIEN),U,2)="Unknown"
 W !,"Dental Site:          "_$P(ECXDIV(DIEN),U,3)_" ("_$P(ECXDIV(DIEN),U,2)_")",?70,"Page: "_PG
 W !!,?56,"# of",?70,"# of"
 W !,"DSS Procedure",?28,"Dental Procedure",?56,"Procedures",?70,"Patients"
 W !,LN,!
 Q
 ;
DENT ;;procedure names for report
 ;;Screening Exam^ SCREENING EXAMINATION
 ;;Complete Exam^ COMPLETE EXAMINATION
 ;;Evaluation^ EVALUATION
 ;;X-Rays Extraoral^ DIAGNOSTIC FILMS-EXTRAORAL
 ;;X-Rays Intraoral^ DIAGNOSTIC FILMS-INTRAORAL
 ;;Neoplasm Confirmed Malignant^ MALIGNANT NEOPLASM CONFIRMED
 ;;Surfaces Restored^ SURFACE RESTORED
 ;;Root Canal Therapy^ ROOT CANAL FILLED
 ;;Periodontal Quads (Surgical)^ QUADRANT OF PERIODONTAL SURGERY
 ;;Periodontal Quads (Root Plane)^ QUADRANT OF ROOT PLANING AND CURETTAGE
 ;;Prophy Natural Dentition^ PROPHYLAXIS - NATURAL DENTITION
 ;;Prophy Denture^ PATIENT WITH PROTHESES CLEANED
 ;;Extractions^ EXTRACTIONS (WEIGHTED)
 ;;Surgical Extractions^ SURGICAL EXTRACTION
 ;;Neoplasm Removed^ NEOPLASM REMOVED
 ;;Biopsy/Smear^ BIOPSY AND/OR CYTOLOGICAL SMEARS
 ;;Fracture^ MAXILLOFACIAL FRACTURE REDUCTION
 ;;Individual Crowns^ SINGLE CROWN (PER CROWN)
 ;;Post & Cores^ POST AND CORE OR OVERDENTURE COPING
 ;;Fixed Partials (Abut)^ ABUTMENT UNIT FOR FIXED PROSTHESIS
 ;;Fixed Partials (Pont Only)^ PONTIC UNIT FOR FIXED PROSTHESIS
 ;;Removable Partials^ REMOVABLE PARTIAL DENTURE INSERTED
 ;;Complete Dentures^ REMOVABLE COMPLETE DENTURE INSERTED
 ;;Prosthetic Repair^ PROTHESIS REPAIRED
