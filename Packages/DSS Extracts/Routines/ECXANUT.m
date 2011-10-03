ECXANUT ;ALB/JRC - NUT Extract Audit Report ; 7/24/09 11:28am
 ;;3.0;DSS EXTRACTS;**105,111,119**;Dec 22, 1997;Build 19
 Q
EN ;entry point for NUT extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR,DIRUT,DTOUT,DUOUT,SCRNARR,REPORT
 N SCRNARR,ECXERR,ECXHEAD,ECXAUD,ECXARRAY,STATUS,FLAG,ECXALL,TMP
 N ZTQUEUED,ZTSTOP
 S SCRNARR="^TMP(""ECX"",$J,""SCRNARR"")"
 K @SCRNARR@("DIVISION")
 S (ECXERR,FLAG)=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="NUT",ECXAUD=0
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
 ;prompt for report type, (s)ummary or (d)etail
 S REPORT=$$REPORT() Q:FLAG
 ;if detail selected, prompt for (i)npatient, (o)utpatient or (b)oth
 I REPORT="D" S STATUS=$$STATUS() Q:FLAG
 ;determine output device and queue if requested
 S ECXPGM="PROCESS^ECXANUT",ECXDESC="NUT Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("STATUS")="",ECXSAVE("REPORT")="",ECXSAVE("FLAG")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")="",ECXSAVE("SCRNARR")="",TMP=$$OREF^DILF(SCRNARR),ECXSAVE(TMP)=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .K @SCRNARR@("DIVISION")
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXANUT
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.832 and store in ^tmp global
 N %,ARRAY,ECXEXT,ECXDEF,X,ECXSTART,ECXEND,ECXRUN,IEN,NODE0,NODE1,DATE,FKEY,DIV,OBS,DLTYPE,DFL,ENC,FPD,FPF,I,PFK,DLDIV
 S ARRAY="^TMP($J,""ECXORDER"")"
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get records in date range and set values
 S IEN=0 F  S IEN=$O(^ECX(727.832,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:FLAG
 .S NODE0=$G(^ECX(727.832,IEN,0)),NODE1=$G(^(1))
 .S DATE=$P(NODE0,U,9),STAT=$P(NODE0,U,8),PFK=$P(NODE1,U,8),DIV=$P(NODE1,U,5),OBS=$P(NODE1,U,2),DLT=$P(NODE1,U,10),FPD=$P(NODE1,U,6),FPF=$P(NODE1,U,9),ENC=$P(NODE1,U,4),DFL=$P(NODE1,U,11),DLDIV=$P(NODE1,U,7)
 .;filter out divisions if not all selected
 .Q:$G(@SCRNARR@("DIVISION"))'=1&'$D(@SCRNARR@("DIVISION",+$G(DIV)))
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;Update totals and store in ^tmp global, add count for each unique 
 .;feeder key/delivery location. Under each unique key create a record
 .;for each unique combination of in/out code, observation status
 .;save it in ^tmp global for later use.
 .I REPORT="S" D
 ..F I="DIV","DLT","STAT","OBS","PFK" I @I="" S @I="UNKNOWN"
 ..;Increment delivery location type (dlt) counter
 ..;S ^TMP($J,"ECXDLT",DIV,DLT,STAT,OBS)=$G(^TMP($J,"ECXDLT",DIV,DLT,STAT,OBS))+1
 ..S ^TMP($J,DIV,"ECXDLT",DLT,STAT,OBS)=$G(^TMP($J,DIV,"ECXDLT",DLT,STAT,OBS))+1
 ..;Increment feeder key (fk) counter 
 ..;S ^TMP($J,"ECXFKEY",DIV,PFK,STAT,OBS)=$G(^TMP($J,"ECXFKEY",DIV,PFK,STAT,OBS))+1
 ..S ^TMP($J,DIV,"ECXFKEY",PFK,STAT,OBS)=$G(^TMP($J,DIV,"ECXFKEY",PFK,STAT,OBS))+1
 .I REPORT="D" D
 ..F I="FPD","FPF","PFK","OBS","ENC" I $G(@I)="" S @I="UNKNOWN"
 ..F I="DIV","DLDIV","DFL","DLT" I $G(@I)="" S @I="UNK"
 ..;Check patient status and screen if necessary
 ..Q:STATUS'="B"&(STATUS'=STAT)
 ..;Increment fpd, fpf, pfk, obs counter
 ..S ^TMP($J,DIV,FPD,FPF,PFK,OBS)=$G(^TMP($J,DIV,FPD,FPF,PFK,OBS))+1
 ..;Increment div, dfl, dlt counter
 ..S ^TMP($J,DIV,FPD,FPF,PFK,OBS,ENC,DLDIV,DFL,DLT)=$G(^TMP($J,DIV,FPD,FPF,PFK,OBS,ENC,DLDIV,DFL,DLT))+1
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print report
 N FLAG,PG,LN,KEY,DLT,STAT,OBS,TOTAL,TCNT,CNT,PDLT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (FLAG,PG)=0,$P(LN,"-",80)=""
 I '$D(^TMP($J)) D  Q
 .S DIV=0 F  S DIV=$O(@SCRNARR@("DIVISION",DIV)) Q:'DIV  D
 ..D HEADER
 ..W !
 ..W !,"**************************************************"
 ..W !,"*  No data available for this patient division.  *"
 ..W !,"**************************************************"
 I REPORT="S" D
 .S DIV="" F  S DIV=$O(^TMP($J,DIV)) Q:DIV']""  D  Q:FLAG
 ..D HEADER Q:FLAG
 ..S KEY="" F  S KEY=$O(^TMP($J,DIV,KEY)) Q:KEY']""  D  Q:FLAG
 ...S PFK="" F  S PFK=$O(^TMP($J,DIV,KEY,PFK)) Q:PFK']""  D  Q:FLAG
 ....D SUB Q:FLAG
 ....S STAT="" F  S STAT=$O(^TMP($J,DIV,KEY,PFK,STAT)) Q:STAT']""  D  Q:FLAG
 .....S OBS="" F  S OBS=$O(^TMP($J,DIV,KEY,PFK,STAT,OBS)) Q:OBS']""  D  Q:FLAG
 ......S TOTAL=$P(^TMP($J,DIV,KEY,PFK,STAT,OBS),U)
 ......;Print by delivery location type (feeder key)
 ......D:($Y+3>IOSL) HEADER,SUB Q:FLAG
 ......W !,?1,STAT,?12,$S(OBS="NO":" NO",1:"YES"),?30,TOTAL
 ;detail report print
 I REPORT="D" D
 .S DIV="" F  S DIV=$O(^TMP($J,DIV)) Q:DIV']""  D  Q:FLAG
 ..S FPD="" F  S FPD=$O(^TMP($J,DIV,FPD)) Q:FPD']""  D  Q:FLAG
 ...S FPF="" F  S FPF=$O(^TMP($J,DIV,FPD,FPF)) Q:FPF']""  D  Q:FLAG
 ....S PFK="" F  S PFK=$O(^TMP($J,DIV,FPD,FPF,PFK)) Q:PFK']""  D  Q:FLAG
 .....S OBS="" F  S OBS=$O(^TMP($J,DIV,FPD,FPF,PFK,OBS)) Q:OBS']""  D  Q:FLAG
 ......S TCNT=$G(^TMP($J,DIV,FPD,FPF,PFK,OBS))
 ......D HEADER
 ......S ENC="" F  S ENC=$O(^TMP($J,DIV,FPD,FPF,PFK,OBS,ENC)) Q:ENC']""  D  Q:FLAG
 .......S DLDIV="" F  S DLDIV=$O(^TMP($J,DIV,FPD,FPF,PFK,OBS,ENC,DLDIV)) Q:DLDIV']""  D  Q:FLAG
 ........S DFL="" F  S DFL=$O(^TMP($J,DIV,FPD,FPF,PFK,OBS,ENC,DLDIV,DFL)) Q:DFL']""  D  Q:FLAG
 .........S DLT="" F  S DLT=$O(^TMP($J,DIV,FPD,FPF,PFK,OBS,ENC,DLDIV,DFL,DLT)) Q:DLT']""  D  Q:FLAG
 ..........S CNT=$G(^TMP($J,DIV,FPD,FPF,PFK,OBS,ENC,DLDIV,DFL,DLT))
 ..........S PDLT=DLT
 ..........I ENC["I",DLT="UNK" S PDLT=$S(PFK["ST ORDER":"N/A",PFK["SUPP FEED":"N/A",PFK["TF":"N/A",1:DLT)
 ..........W !,?1,$E(ENC,1,25),?28,DLDIV,?42,DFL,?60,PDLT,?71,CNT
 ..........D:($Y+3>IOSL) HEADER Q:FLAG
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
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"_$S(REPORT="S":"  (Summary)",1:"  (Detail)")
 W !,"DSS Extract Log #:       "_ECXEXT
 W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time:    "_ECXRUN
 W !,"Patient Division: "_$P(DSSID,U)_$S($P(DSSID,U,2)'="":" ("_$P(DSSID,U,2)_")",1:""),?68,$S(REPORT="S":"Page: "_PG,1:"")
 ;Detailed report sub-header
 Q:'$D(^TMP($J))
 I REPORT="D" D
 .W !,"Patient Status: "_$S(STATUS="I":"Inpatient",STATUS="O":"Outpatient",1:"Inpatient and Outpatient"),?68,"Page: "_PG
 .W !!,"Prod Div: "_FPD_" Prod Fac: "_FPF_" Prod FK: "_PFK_" OBS: "_OBS,?60," TOTAL: ",TCNT
 .W !,?1,"Encounter Number",?28,"Del Div",?42,"Del Feed Loc",?60,"Loc Type",?71,"Count"
 Q
SUB ;Summary report sub-header
 I REPORT="S" D
 .W !!,"FEEDER KEY: "_PFK
 .W !!,"I/O",?12,"OBS",?30,"TOTAL"
 Q
 ;
REPORT() ;Select report type
 ;
 ;      Output - S = summary
 ;               D = detail
 ;Init variables
 N DIR,DIRUT,DUOUT,X,Y
 S DIR(0)="S^S:SUMMARY;D:DETAIL"
 S DIR("A")="Select type of report"
 S DIR("?",1)="S = Summary"
 S DIR("?",2)="D = Detail"
 D ^DIR
 I $D(DIRUT)!$D(DUOUT) S FLAG=1 Q ""
 Q Y
 ;
STATUS() ;Select patient status for report
 ;
 ;      Output - I = inpatient
 ;               O = outpatient
 ;               B = both
 ;Init variables
 N DIR,DIRUT,DUOUT,X,Y
 S DIR(0)="S^I:INPATIENT;O:OUTPATIENT;B:BOTH"
 S DIR("A")=" report?"
 S DIR("A")="Select patient status for report"
 S DIR("?",1)="I = Inpatient"
 S DIR("?",2)="O = Outpatient"
 S DIR("?",3)="B = Both"
 D ^DIR
 I $D(DIRUT)!$D(DUOUT) S FLAG=1 Q ""
 Q Y
