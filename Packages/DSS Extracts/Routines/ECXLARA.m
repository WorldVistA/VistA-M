ECXLARA ;ALB/JRC - LAR Extract Audit Report ; 9/24/08 3:35pm
 ;;3.0;DSS EXTRACTS;**105,112,120,136**;Dec 22, 1997;Build 28
 Q
EN ;entry point for NUT extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,DIRUT,DTOUT,DUOUT,SCRNARR,REPORT
 N SCRNARR,ECXERR,ECXHEAD,ECXAUD,ECXARRAY,STATUS,FLAG,ECXALL,TMP
 N ZTQUEUED,ZTSTOP
 S SCRNARR="^TMP(""ECX"",$J,""SCRNARR"")"
 K @SCRNARR@("DIVISION")
 S (ECXERR,FLAG)=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="LAR",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 Q:ECXERR
 W !!
 ;select divisions/sites; all divisions if ecxall=1
 S ECXERR=$$NUT^ECXDVSN()
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .K @SCRNARR@("DIVISION")
 .D AUDIT^ECXKILL
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 W !
 ;determine output device and queue if requested
 S ECXPGM="PROCESS^ECXLARA",ECXDESC="LAR Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("STATUS")="",ECXSAVE("REPORT")="",ECXSAVE("FLAG")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")="",ECXSAVE("SCRNARR")="",TMP=$$OREF^DILF(SCRNARR),ECXSAVE(TMP)=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .K @SCRNARR@("DIVISION")
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXLARA
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.824 and store in ^tmp global
 N %,ARRAY,ECXEXT,ECXDEF,X,ECXSTART,ECXEND,ECXRUN,IEN,FLAG,NODE0,NODE1,DATE,DIV,TEST,I,MIN,MAX,RESULT
 S ARRAY="^TMP($J,""ECXORDER"")",FLAG=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get records in date range and set values
 S IEN=0 F  S IEN=$O(^ECX(727.824,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:FLAG
 .S NODE0=$G(^ECX(727.824,IEN,0)),NODE1=$D(^(1))
 .S DIV=$P(NODE0,U,4),DATE=$P(NODE0,U,9),TEST=$P(NODE0,U,10),RESULT=$P(NODE0,U,11)
 .;filter out divisions if not all selected
 .Q:$G(@SCRNARR@("DIVISION"))'=1&'$D(@SCRNARR@("DIVISION",+$G(DIV)))
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .;check for unknowns so that they won't be lost
 .F I="DIV","TEST","DATE" I @I="" S @I="UNKNOWN"
 .;increment div/test count, check min/max save in ^tmp global
 .S $P(^TMP($J,"ECXDSS",DIV,TEST),U)=$P($G(^TMP($J,"ECXDSS",DIV,TEST)),U)+1
 .;S MIN=$P(^TMP($J,"ECXDSS",DIV,TEST),U,2)
 .;S MAX=$P(^TMP($J,"ECXDSS",DIV,TEST),U,3)
 .;S $P(^TMP($J,"ECXDSS",DIV,TEST),U,2)=$S(MIN']"":RESULT,RESULT<MIN:RESULT,1:MIN),$P(^(TEST),U,3)=$S(RESULT>MAX:RESULT,1:MAX)
 .;S $P(^TMP($J,"ECXDSS",DIV,TEST),U,2)=$S(RESULT["NEG":"NEG",+RESULT<+MIN:RESULT,1:""),$P(^(TEST),U,3)=$S(RESULT["POS":"POS",RESULT>MAX:RESULT,1:"")
 .;S $P(^TMP($J,"ECXDSS",DIV,TEST),U,2)=$S(RESULT["NEG":"NEG",MIN']"":RESULT,+RESULT'=0&RESULT<MIN:RESULT,1:MIN),$P(^(TEST),U,3)=$S(RESULT["POS":"POS",MAX']""&RESULT'=0:RESULT,RESULT>MAX:RESULT,1:MAX)
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print report
 N PG,NODE,ECN,ECXTSTNM
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S PG=0,ECXTSTNM=""
 I '$D(^TMP($J,"ECXDSS")) D  Q
 .S DIV=0 F  S DIV=$O(@SCRNARR@("DIVISION",DIV)) Q:'DIV  D  Q:FLAG
 ..D HEADER Q:FLAG
 ..W !
 ..W !,"**************************************************"
 ..W !,"*  No data available for this division.          *"
 ..W !,"**************************************************"
 S DIV=0 F  S DIV=$O(^TMP($J,"ECXDSS",DIV)) Q:'DIV  D
 .D HEADER Q:FLAG
 .S ECN=0 F  S ECN=$O(^ECX(727.29,"AC",ECN)) Q:'ECN  S TEST=$$RJ^XLFSTR(ECN,4,0),ECXTSTNM=$$GET1^DIQ(727.29,+$O(^ECX(727.29,"AC",ECN,0)),.03) D  Q:FLAG
 ..S NODE=$S($D(^TMP($J,"ECXDSS",DIV,TEST)):^TMP($J,"ECXDSS",DIV,TEST),1:"")
 ..;S TEST="" F  S TEST=$O(^TMP($J,"ECXDSS",DIV,TEST)) Q:TEST']""  D  Q:FLAG
 ..;S NODE=^TMP($J,"ECXDSS",DIV,TEST)
 ..;S MIN=$P(^TMP($J,"ECXDSS",DIV,TEST),U,2)
 ..;S MAX=$P(^TMP($J,"ECXDSS",DIV,TEST),U,3)
 ..D:($Y+3>IOSL) HEADER Q:FLAG
 ..W !,?1,TEST,?13,ECXTSTNM,?55,$$ECXYMX^ECXUTL($$ECXYM^ECXUTL(DATE)),?65,$S(NODE:$J($P(NODE,U,1),15),1:$J("Not in Extract",15))
 ..;;W !,?4,TEST,?14,$$ECXYMX^ECXUTL($$ECXYM^ECXUTL(DATE)),?27,$S(MIN["NEG":$J("NEG",15),1:$J(MIN,15,4)),?44,$S(MAX["POS":$J("POS",15),MAX>0:$J(MAX,15,4),1:""),?60,$J($P(NODE,U,1),15)
 Q
 ;
HEADER ;header and page control
 N JJ,SS,DIR,DIRUT,DTOUT,DUOUT,DSSID
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y FLAG=1
 Q:FLAG
 S DSSID=$S($G(DIV):$$NNT^XUAF4(DIV),1:"UNKNOWN^^")
 W:$Y!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 W !,"DSS Extract Log #:       "_ECXEXT
 W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time:    "_ECXRUN
 W !,"Division: "_$P(DSSID,U)_$S($P(DSSID,U,2)'="":" ("_$P(DSSID,U,2)_")",1:""),?68,"Page: "_PG
 ;Detailed report sub-header
 Q:'$D(^TMP($J))
 W !!,?1,"Test Code",?13,"DSS TEST NAME",?53,"Month Year",?69,"Total Count"
 ;W !!,?2,"Test Code",?14,"Month Year",?32,"Min Result",?49,"Max Result",?64,"Total Count"
 Q
