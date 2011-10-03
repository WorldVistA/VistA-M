ECXSARXS ;BIR/DMA-SAS Report from Prescription Extract; 22 Sep 95 / 10:27 AM
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
EN ;entry point from menu option
 W @IOF,!!,"Prescription Extract SAS Report",!!
 ;ecxaud=1 for 'sas' audit
 S ECXHEAD="PRE",ECXAUD=1
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 I ECXERR D AUDIT^ECXKILL Q
 ;select all pharmacy sites/divisions
 S ECXALL=1 D PRE^ECXDVSN1(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR D AUDIT^ECXKILL Q
 W !!
 S ECXPGM="PROCESS^ECXSARXS",ECXDESC="Prescription Extract SAS Report"
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
 N J,X,Y,JJ,SS,LN,PG,DIV,EC,ECFK,ECFL,ECQ,MAIL,NEWRX,COPAY,DEA,TOT,QFLG,DIQ,DR,DA,DIR,DIRUT,DTOUT,DUOUT
 K ^TMP($J,"ECXAUD")
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S (QFLG,PG)=0,$P(LN,"-",80)=""
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;process the extract records
 S J="" F  S J=$O(^ECX(727.81,"AC",ECXEXT,J)) Q:'J  I $D(^ECX(727.81,J,0)) S EC=^(0) D
 .S DIV=$P(EC,U,10),MAIL=+$P(EC,U,13),NEWRX=+$P(EC,U,15),COPAY=+$P(EC,U,27),DEA=$P(EC,U,29)
 .;non-cmop rxs only
 .;feeder location is always "pre"_div
 .I MAIL'=2 D
 ..S ECFL="PRE"_DIV,ECFK=$P(EC,U,28),ECQ=+$P(EC,U,17)
 ..S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ..;additional feeder key records for non-cmop rx
 ..S ECFK="BASIC",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ..I MAIL=1 D
 ...S ECFK="VAMAIL",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ...I NEWRX=1 D
 ....S ECFK="NEWVMOP",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ..I MAIL=0&(NEWRX=1) D
 ...S ECFK="NEWWIN",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ..I COPAY=1 D
 ...S ECFK="COPAY",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ..I DEA="I" D
 ...S ECFK="PREDEASP",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 .;cmop rxs only
 .;feeder location is "cmopdsu"_div, "cmopdis"_div, and also "pre"_div
 .I MAIL=2 D
 ..S ECFL="CMOPDSU"_DIV,ECFK=$P(EC,U,28),ECQ=+$P(EC,U,17),^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ..S ECFL="CMOPDIS"_DIV,ECFK="CMOPDISP",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ..S ECFL="PRE"_DIV D
 ...;possibly three additional feeder key recods for cmop rx
 ...I NEWRX=1 D
 ....S ECFK="NEWCMOP",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ...I COPAY=1 D
 ....S ECFK="COPAY",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ...I DEA="I" D
 ....S ECFK="PREDEASP",ECQ=1,^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ;print the report
 U IO
 S DIV="" F  S DIV=$O(^TMP($J,"ECXAUD",DIV)) Q:DIV=""  D  Q:QFLG
 .D HEADER
 .S ECFL="" F  S ECFL=$O(^TMP($J,"ECXAUD",DIV,ECFL)) Q:ECFL=""  D  Q:QFLG
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,ECFL
 ..S ECFK="" F  S ECFK=$O(^TMP($J,"ECXAUD",DIV,ECFL,ECFK)) Q:ECFK=""  S TOT=^(ECFK) D  Q:QFLG
 ...D:($Y+3>IOSL) HEADER Q:QFLG  W ?40,ECFK,?68,$$RJ^XLFSTR(TOT,5," "),!
 ;close
 I $E(IOST)'="C" W @IOF
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 D AUDIT^ECXKILL
 Q
 ;
HEADER ;print the header
 D SASHEAD^ECXUTLA(DIV,ECXHEAD,.ECXDIV,.ECXARRAY,.PG)
 Q
