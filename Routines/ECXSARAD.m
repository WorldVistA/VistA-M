ECXSARAD ;BIR/DMA-SAS Report from Radiology Extract; 25 Apr 95 / 11:03 AM
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
EN ;entry point from menu option
 W @IOF,!!,"Radiology Extract SAS Report",!!
 ;ecxaud=1 for 'sas' audit
 S ECXHEAD="RAD",ECXAUD=1
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 I ECXERR D AUDIT^ECXKILL Q
 ;select all radiology sites/divisions
 S ECXALL=1 D RAD^ECXDVSN2(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR D AUDIT^ECXKILL Q
 W !!
 S ECXPGM="PROCESS^ECXSARAD",ECXDESC="Radiology Extract SAS Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try agian later... exiting.",!
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
 N J,K,X,Y,JJ,SS,LN,PG,DIV,EC,ECFK,ECFL,QFLG,TOT,TYPE,TYPENM,DIQ,DR,DA,DIR,DIRUT,DTOUT,DUOUT
 K ^TMP($J,"ECXAUD")
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S (QFLG,PG)=0,$P(LN,"-",80)=""
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;setup array of imaging types
 S TYPE=0 F  S TYPE=$O(^RA(79.2,TYPE)) Q:+TYPE<1  D
 .K ECX S DIC="^RA(79.2,",DR=".01;3",DIQ="ECX",DIQ(0)="I",DA=TYPE D EN^DIQ1
 .S TYPE(TYPE)=ECX(79.2,TYPE,.01,"I")_U_ECX(79.2,TYPE,3,"I")
 ;process the extract records
 S J="" F  S J=$O(^ECX(727.814,"AC",ECXEXT,J)) Q:'J  I $D(^ECX(727.814,J,0)) S EC=^(0),DIV=$P(EC,U,4),ECFL=DIV_"-"_$P(EC,U,21) D
 .S ECFK=$P(EC,U,10) I ECFK="" S ECFK=$P(EC,U,11)
 .I $P(EC,U,10)="",$P(EC,U,11)=468 S ECFK=777777
 .S MODS=";"_$P(EC,U,17)_";"
 .S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+1
 .I MODS[";1;" S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+1
 .I MODS[";2;" S ^(888888)=$G(^TMP($J,"ECXAUD",DIV,ECFL,888888))+1
 .I MODS[";3;" S ^(999999)=$G(^TMP($J,"ECXAUD",DIV,ECFL,999999))+1
 ;print the report
 U IO
 S DIV="" F  S DIV=$O(^TMP($J,"ECXAUD",DIV)) Q:DIV=""  D  Q:QFLG
 .D HEADER S TOT("D")=0
 .S ECFL="" F  S ECFL=$O(^TMP($J,"ECXAUD",DIV,ECFL)) Q:ECFL=""  S TYPE=+$P(ECFL,"-",2) D  Q:QFLG
 ..S TYPENM=$P($G(TYPE(TYPE)),U,1),TYPENM=$E(TYPENM,1,18),TOT("FL")=0
 ..S ECFK="" F  S ECFK=$O(^TMP($J,"ECXAUD",DIV,ECFL,ECFK)) Q:ECFK=""  S TOT=^(ECFK) D  Q:QFLG
 ...D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,ECFL,?43,ECFK,?68,$$RJ^XLFSTR(TOT,5," ")
 ...S TOT("FL")=TOT("FL")+TOT,TOT("D")=TOT("D")+TOT
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?40,$E(LN,1,34)
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,"Total for Feeder Location "_DIV_"-"_TYPENM_" ("_ECFL_"):",?68,$$RJ^XLFSTR(TOT("FL"),5," ")
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"Grand Total for Division "_DIV_":",?68,$$RJ^XLFSTR(TOT("D"),5," ")
 ;close
 I $E(IOST)'="C" W @IOF
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 D AUDIT^ECXKILL
 Q
HEADER ;print the header
 D SASHEAD^ECXUTLA(DIV,ECXHEAD,.ECXDIV,.ECXARRAY,.PG)
 Q
