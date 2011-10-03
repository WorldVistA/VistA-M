ECXSADEN ;BIR/DMA-SAS Report from Dental Extract; 31 Aug 95 / 1:40 PM
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
EN ;entry point from menu option
 W @IOF,!!,"Dental Extract SAS Report",!!
 ;ecxaud=1 for 'sas' audit
 S ECXHEAD="DEN",ECXAUD=1
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 I ECXERR D AUDIT^ECXKILL Q
 ;select all dental sites/divisions
 S ECXALL=1 D DEN^ECXDVSN(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR D AUDIT^ECXKILL Q
 W !!
 S ECXPGM="PROCESS^ECXSADEN",ECXDESC="Dental Extract SAS Report"
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
 N J,K,X,Y,JJ,SS,LN,PG,DIV,DIVNUM,EC,ECQ,ECFK,ECFL,QFLG,TOT,DIR,DIRUT,DTOUT,DUOUT
 K ^TMP($J,"ECXAUD")
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S (QFLG,PG)=0,$P(LN,"-",80)=""
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;arrange dental divisions by station #
 S DIV="" F  S DIV=$O(ECXDIV(DIV)) Q:DIV=""  S DIVNUM=$P(ECXDIV(DIV),U,3),DIV(DIVNUM)=ECXDIV(DIV)
 ;process the extract records
 S J="" F  S J=$O(^ECX(727.806,"AC",ECXEXT,J)) Q:'J  I $D(^ECX(727.806,J,0)) S EC=^(0),ECFL=$P(EC,U,41) D
 .I $P(EC,U,12) S ^("D09")=$G(^TMP($J,"ECXAUD",ECFL,"D09"))+1
 .F K=10,11,15:1:18,20:1:24,27:1:37 S ECQ=$P(EC,U,K+3) I ECQ S ^("D"_K)=$G(^TMP($J,"ECXAUD",ECFL,"D"_K))+ECQ
 .I $P(EC,U,11)="C" S ^("D08C")=$G(^TMP($J,"ECXAUD",ECFL,"D08C"))+1
 .I $P(EC,U,11)="S" S ^("D08S")=$G(^TMP($J,"ECXAUD",ECFL,"D08S"))+1
 .F K=12,13,14 I $P(EC,U,K+3)=1 S ^("D"_K)=$G(^TMP($J,"ECXAUD",ECFL,"D"_K))+1
 .I $P(EC,U,28)=3 S ^("D25I")=$G(^TMP($J,"ECXAUD",ECFL,"D25I"))+1
 .I $P(EC,U,28)=4 S ^("D25G")=$G(^TMP($J,"ECXAUD",ECFL,"D25G"))+1
 .I $P(EC,U,29)=1 S ^("D26S")=$G(^TMP($J,"ECXAUD",ECFL,"D26S"))+1
 .I $P(EC,U,29)=3 S ^("D26F")=$G(^TMP($J,"ECXAUD",ECFL,"D26F"))+1
 .I $P(EC,U,42)=2 S ^("D39C")=$G(^TMP($J,"ECXAUD",ECFL,"D39C"))+1
 .I $P(EC,U,42)=3 S ^("D39T")=$G(^TMP($J,"ECXAUD",ECFL,"D39T"))+1
 .F K=40:1:42 I $P(EC,U,K+3)=1 S ^("D"_K)=$G(^TMP($J,"ECXAUD",ECFL,"D"_K))+1
 .S EC=$P(EC,U,46),EC=$S(EC=1:"M",EC=2:"Q",EC=3:"R",1:"") I EC]"" S ^("D43"_EC)=$G(^TMP($J,"ECXAUD",ECFL,"D43"_EC))+1
 ;print the report
 U IO
 S ECFL="" F  S ECFL=$O(^TMP($J,"ECXAUD",ECFL)) Q:ECFL=""  D  Q:QFLG
 .D HEADER
 .S TOT(ECFL)=0
 .S ECFK="" F  S ECFK=$O(^TMP($J,"ECXAUD",ECFL,ECFK)) Q:ECFK=""  S TOT=^(ECFK) D  Q:QFLG
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,?3,ECFL,?43,ECFK,?68,$$RJ^XLFSTR(TOT,5," ")
 ..S TOT(ECFL)=TOT(ECFL)+TOT
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,?40,$E(LN,1,34)
 .D:($Y+3>IOSL) HEADER Q:QFLG  W !,"Total for Feeder Location "_ECFL_":",?68,$$RJ^XLFSTR(TOT(ECFL),5," ")
 ;close
 I $E(IOST)'="C" W @IOF
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 D AUDIT^ECXKILL
 Q
 ;
HEADER ;print the header
 D SASHEAD^ECXUTLA(ECFL,ECXHEAD,.DIV,.ECXARRAY,.PG)
 Q
