ECXRACPT ;ALB/DAN - Radiology extract invalid CPT report ;7/25/18  14:29
 ;;3.0;DSS EXTRACTS;**170**;Dec 22, 1997;Build 12
EN ;entry point from menu option
 N ECXPORT,CNT,ECXHEAD,ECXERR,ECXARRAY,ECXAUD,ECXDIV,ECXALL,ECXDESC,ECXPGM,ECXSAVE,D0
 W @IOF,!!,"Radiology (RAD) Extract CPT Code Audit",!!
 ;ecxaud=1 stops user from being able to select a date range 
 S ECXHEAD="RAD",ECXAUD=1
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 I ECXERR D AUDIT^ECXKILL Q
 ;select all radiology sites/divisions
 S ECXALL=1 D RAD^ECXDVSN2(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR D AUDIT^ECXKILL Q
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q
 .K ^TMP($J,"ECXPORT")
 .S ^TMP($J,"ECXPORT",0)="EXTRACT LOG #^DIVISION/SITE^IMAGING TYPE (FEEDER LOCATION)^PROCEDURE DATE^FEEDER KEY^PROCEDURE^PATIENT DFN",CNT=1
 .D PROCESS
 .D EXPDISP^ECXUTL1
 .D AUDIT^ECXKILL
 W !!
 S ECXPGM="PROCESS^ECXRACPT",ECXDESC="Radiology Extract Invalid CPT Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;queued entry
 N J,X,Y,PG,DIV,EC,ECFK,ECFL,QFLG,TYPE,TYPENMN,DIQ,DR,DA,DIR,DIRUT,DTOUT,DUOUT,CPT,DAY,%DT,ECXRUN,ECX,DIC,ECXEXT,ECXDEF,DATA,SEQ,ECXP
 K ^TMP($J,"ECXCPT")
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S (QFLG,PG)=0
 ;get run date in external format
 S ECXRUN=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12))
 ;setup array of imaging types
 S TYPE=0 F  S TYPE=$O(^RA(79.2,TYPE)) Q:+TYPE<1  D
 .K ECX S DIC="^RA(79.2,",DR=".01;3",DIQ="ECX",DIQ(0)="I",DA=TYPE D EN^DIQ1
 .S TYPE(TYPE)=ECX(79.2,TYPE,.01,"I")_U_ECX(79.2,TYPE,3,"I")
 ;process the extract records
 S J="" F  S J=$O(^ECX(727.814,"AC",ECXEXT,J)) Q:'J  I $D(^ECX(727.814,J,0)) S EC=^(0),DIV=$P(EC,U,4),ECFL=DIV_"-"_$P(EC,U,21) D
 .S ECFK=$P(EC,U,10),ECXP=$P(EC,U,11)
 .S CPT=$E(ECFK,1,5) ;Get just CPT code from the CPT Code and modifier info in ECFK
 .S DAY=$$ECXDATEX^ECXUTL($P(EC,U,9)) ;Convert DSS to readable date
 .S X=DAY,%DT="X" D ^%DT S DAY=Y ;Convert readable date to FM date
 .I $$STATCHK^ICPTAPIU(CPT,DAY) Q  ;If CPT code was valid on this date, skip it
 .S ^TMP($J,"ECXCPT",DIV,ECFL,J)=DAY_U_ECXP_U_$$GET1^DIQ(71,$P(EC,U,11),.01)_U_$P(EC,U,5)
 .Q
 ;
 ;Print/export report
 U IO
 I '$G(ECXPORT) I '$D(^TMP($J,"ECXCPT")) S DIV=0 D HEADER W !,"No data found." Q
 S DIV="" F  S DIV=$O(^TMP($J,"ECXCPT",DIV)) Q:DIV=""!(QFLG)  D
 .D:'$G(ECXPORT) HEADER
 .S ECFL="" F  S ECFL=$O(^TMP($J,"ECXCPT",DIV,ECFL)) Q:ECFL=""!(QFLG)  S TYPE=+$P(ECFL,"-",2) D
 ..S TYPENMN=$E($P($G(TYPE(TYPE)),U),1,18)
 ..S SEQ="" F  S SEQ=$O(^TMP($J,"ECXCPT",DIV,ECFL,SEQ))  Q:SEQ=""!(QFLG)  D
 ...I '$G(ECXPORT) D:($Y+3>IOSL) HEADER Q:QFLG
 ...S DATA=^TMP($J,"ECXCPT",DIV,ECFL,SEQ)
 ...I $G(ECXPORT) D  Q
 ....S ^TMP($J,"ECXPORT",CNT)=ECXEXT_U_$P($G(ECXDIV(DIV)),U,2)_"("_$P($G(ECXDIV(DIV)),U)_")"_U_TYPENMN_" ("_ECFL_")"
 ....S ^TMP($J,"ECXPORT",CNT)=^TMP($J,"ECXPORT",CNT)_U_$TR($$FMTE^XLFDT($P(DATA,U),"2F")," ",0)_U_$P(DATA,U,2)_U_$P(DATA,U,3)_U_$P(DATA,U,4),CNT=CNT+1 Q
 ...W TYPENMN," (",ECFL,")"
 ...W !,?3,$P(DATA,U,2),?11,$E($P(DATA,U,3),1,45),?58,$TR($$FMTE^XLFDT($P(DATA,U),"2F")," ",0),?69,$P(DATA,U,4),!
 ...Q
 ..Q
 .Q
 Q
 ;
HEADER ;
 N JJ,SS,LN
 S $P(LN,"-",80)="-"
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,"Radiology (RAD) Extract CPT Code Audit"
 W !,"DSS Extract Log #:    "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 I $D(ECXDIV(DIV)) W !,"Division/Site:        "_$P(ECXDIV(DIV),U,2)_" ("_DIV_")",?68,"Page: "_PG
 I '$D(ECXDIV(DIV)) W !,"Division/Site:        "_"Unknown",?68,"Page: "_PG
 W !!,"Imaging Type (Feeder Location)",?58,"Procedure"
 W !?3,"FdrKey",?11,"Procedure",?58,"Date",?69,"DFN"
 W !,LN,!
 Q
