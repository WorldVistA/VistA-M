ECXAPRO1 ;ALB/JAP - PRO Extract Audit Report (cont) ; Nov 16, 1998
 ;;3.0;DSS EXTRACTS;**9,21**;Dec 22, 1997
 ;
DISP ;entry point
 N DIC,DA,DR,DIRUT,DTOUT,DUOUT,JJ,SS,LN,PG,QFLG,STN,TYPE
 N A1,A2,A3,CA,CB,CC,GCA,GCB,GCC,GRP,GRPHEAD,LINE,LINEP
 U IO
 S (QFLG,PG)=0,$P(LN,"-",80)=""
 F TYPE="N","R" S STN="",STN=$O(^TMP($J,TYPE,STN)) D  Q:QFLG
 .D HEADER
 .D CDATA Q:QFLG
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:       "_ECXEXT
 .W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time:    "_ECXRUN,?68,"Page: ",PG
 .W !!,LN,!!
 .S DIC="^ECX(727.1,",DA=ECXARRAY("DEF"),DR="1" D EN^DIQ
 .W @IOF
 I $D(IO(0)) I IO(0)'=IO D ^%ZISC
 D HOME^%ZIS
 Q
 ;
CDATA ;accummulate data within each nppd group
 S (LINE,LINEP)=""
 S (GCA,GCB,GCC)=0
 S (CA,CB,CC)=0
 I '$D(^TMP($J,TYPE)) D  Q
 .W !,?26,"No data available.",!
 .I $E(IOST)="C",'QFLG D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" D ^DIR K DIR
 F  S LINE=$O(^TMP($J,TYPE,STN,LINE)) Q:LINE=""  D  Q:QFLG
 .S GRP=$E(LINE,1,3) D  Q:QFLG
 ..I TYPE="R",GRP["R9" S GRP="R90"
 ..S GRPHEAD=^TMP($J,"RMPRCODE",GRP)
 ..I LINEP="" D
 ...D:($Y+5>IOSL) HEADER Q:QFLG
 ...W !,GRPHEAD
 .I $E(LINE,0,3)'=$E(LINEP,0,3),LINEP'="" D  Q:QFLG
 ..D:($Y+5>IOSL) HEADER Q:QFLG 
 ..W !,LN,!
 ..W ?26,$J(CA,5,0),?34,$J(CB,5,0),?42,$J((CA+CB),5,0),?51,$J(CC,7,0),!
 ..S (CA,CB,CC)=0
 ..D:($Y+5>IOSL) HEADER Q:QFLG 
 ..W:LINE'["R99" !,GRPHEAD
 .D:($Y+3>IOSL) HEADER Q:QFLG 
 .W !,LINE,?6,$E($P(^TMP($J,TYPE,STN,LINE),U,15),1,15)
 .S A1=+$P(^TMP($J,TYPE,STN,LINE),U,1),A2=+$P(^(LINE),U,2),A3=+$P(^(LINE),U,3)
 .W ?26,$J(A1,5,0) S CA=CA+A1,GCA=GCA+A1
 .W ?34,$J(A2,5,0) S CB=CB+A2,GCB=GCB+A2
 .W ?42,$J(A1+A2,5,0)
 .W ?51,$J(A3,7,0) S CC=CC+A3,GCC=GCC+A3
 .W:A2>0 ?61,$J(A3/A2,6,0)
 .S LINEP=LINE
 Q:QFLG
 D SUM
 Q
 ;
SUM ;print summary for type
 D:($Y+7>IOSL) HEADER Q:QFLG 
 W:TYPE="N" !!!,"STATION SUMMARY (NEW)"
 W:TYPE="R" !!!,"STATION SUMMARY (REPAIR)"
 W !,?28,"VA",?36,"Com",?44,"Total",?54,"Cost ($)"
 W !,LN
 W !,?26,$J(GCA,5,0),?34,$J(GCB,5,0),?42,$J((GCA+GCB),5,0),?51,$J(GCC,7,0)
 W !,LN
 Q
 ;
HEADER ;header and page control
 I $E(IOST)="C" D
 .S SS=20-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report",?64,"Page "_PG
 W !,"DSS Extract Log #:       "_ECXEXT
 W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Station (#):             "_$P(ECXDIV,U,2)_" ("_$P(ECXDIV,U,3)_")"
 W !,"Report Run Date/Time:    "_ECXRUN
 W:TYPE="N" !!,"REPORT OF NEW PROSTHETICS ACTIVITIES"
 W:TYPE="R" !!,"REPORT OF REPAIR PROSTHETICS ACTIVITIES"
 W !,"Line",?6,"Item",?28,"VA",?36,"Com",?44,"Total",?54,"Cost ($)",?64,"Ave Com ($)"
 W !,LN,!
 Q
 ;
CODE ;setup nppd codes
 ;intended to duplicate code^rmprn63
 N NULINE
 F I=1:1 S NULINE=$P($T(TEXT+I^ECXAPRO3),";;",2) Q:NULINE["QUIT"  D
 .I $L($P(NULINE,";",1))>3,STN]"" D
 ..I $E(NULINE,0,1)'="R" S:$D(^TMP($J,"N",STN,$P(NULINE,";",1))) $P(^TMP($J,"N",STN,$P(NULINE,";",1)),U,15)=$P(NULINE,";",2)
 ..I $E(NULINE,0,1)="R" S:$D(^TMP($J,"R",STN,$P(NULINE,";",1))) $P(^TMP($J,"R",STN,$P(NULINE,";",1)),U,15)=$P(NULINE,";",2)
 .S ^TMP($J,"RMPRCODE",$P(NULINE,";",1))=$P(NULINE,";",2)
 Q
