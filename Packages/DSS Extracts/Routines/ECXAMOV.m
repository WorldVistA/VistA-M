ECXAMOV ;ALB/JAP - MOV Extract Audit Report ;Oct 10, 1997
 ;;3.0;DSS EXTRACTS;**8,33**;Dec 22, 1997
 ;
EN ;entry point for MOV extract audit report
 N %X,%Y,X,Y,DIC,DA,DR,DIQ,DIR
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="MOV",ECXAUD=0
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
 D MOV^ECXDVSN(.ECXDIV,ECXALL,ECXSTART,ECXEND,.ECXERR)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;determine output device and queue if requested
 W !
 S ECXPGM="PROCESS^ECXAMOV",ECXDESC="MOV Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !!,?5,"The format of this report requires a page or screen",!,?5,"width of 132 characters.",!
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS^ECXAMOV
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process data in file #727.808
 N X,Y,W,JJ,DATE,DATA,DIV,IEN,MOV,TL,ORDER,SORD,GTOT,STOT,WARD,TMOV,QQFLG,CNT,LINETOT
 K ^TMP($J,"ECXWARD"),^TMP($J,"ECXORDER"),^TMP($J,"MISWRD")
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get ward info in ^tmp($j,"ecxward" and ^tmp($j,"ecxorder"
 D WARDS^ECXUTLA(ECXALL,.ECXDIV)
 ;setup up ^tmp($j,"mov", for legend
 S JJ=0 F  S JJ=$O(^DG(405.2,JJ)) Q:+JJ<1  S MOV=JJ D
 .S DATA=^DG(405.2,JJ,0),NM=$P(DATA,U,1),TYPE=$P(DATA,U,2)
 .S ^TMP($J,"MOV",TYPE,JJ)=NM
 F JJ=1:1:MOV S $P(TL,U,JJ)=0
 S W="" F  S W=$O(^TMP($J,"ECXWARD",W)) Q:W=""  D
 .S DIV=$P(^TMP($J,"ECXWARD",W),U,3) I '$D(GTOT(DIV)) F JJ=1:1:MOV S $P(GTOT(DIV),U,JJ)=0
 .S ^TMP($J,"TL",W)=TL
 .S ORDER="" D
 ..F  S ORDER=$O(^TMP($J,"ECXORDER",DIV,ORDER)) Q:ORDER=""  I $D(^(ORDER,1)) D
 ...F JJ=1:1:MOV S $P(STOT(DIV,ORDER),U,JJ)=0
 ;get records in date range and ward set
 S IEN="" F  S IEN=$O(^ECX(727.808,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S DATA=^ECX(727.808,IEN,0),DATE=$P(DATA,U,9),WARD=$P(DATA,U,15),TMOV=$P(DATA,U,19)
 .;convert free text date to fm internal format date
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .;track missing wards
 .I WARD="" D  Q
 ..S ^TMP($J,"MISWRD")=$G(^TMP($J,"MISWRD"))+1,^("MISWRD",IEN)=""
 .;if ward is among those selected, then tally movement data
 .I $D(^TMP($J,"TL",WARD)) D
 ..S $P(^TMP($J,"TL",WARD),U,TMOV)=$P(^TMP($J,"TL",WARD),U,TMOV)+1
 ..S ORDER=$P(^TMP($J,"ECXWARD",WARD),U,1),DIV=$P(^(WARD),U,3),$P(GTOT(DIV),U,TMOV)=$P(GTOT(DIV),U,TMOV)+1
 ..S SORD=ORDER-.01,SORD=$O(STOT(DIV,SORD)) I +SORD S $P(STOT(DIV,SORD),U,TMOV)=$P(STOT(DIV,SORD),U,TMOV)+1
 ..S CNT=CNT+1 I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QQFLG=1,ZTSTOP=1 K ZTREQ
 ;after all the extract records are processed, set totals into ^tmp($j,"ecxorder"
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S W="" F  S W=$O(^TMP($J,"TL",W)) Q:W=""  S TL(W)=^(W) D
 .S ORDER=$P(^TMP($J,"ECXWARD",W),U,1),DIV=$P(^(W),U,3)
 .S LINETOT=0 F JJ=1:1:MOV S $P(^TMP($J,"ECXORDER",DIV,ORDER),U,JJ+2)=$P(TL(W),U,JJ),LINETOT=LINETOT+$P(TL(W),U,JJ)
 .K TL(W)
 .;don't keep inactive wards unless there is movement data
 .I ORDER>999990,LINETOT=0 K ^TMP($J,"ECXORDER",DIV,ORDER)
 .I $D(^TMP($J,"ECXORDER",DIV,ORDER,1)) D
 ..;don't do group total on inactive/unordered wards
 ..I ORDER>999990 K ^TMP($J,"ECXORDER",DIV,ORDER,1) Q
 ..F JJ=1:1:MOV S $P(^TMP($J,"ECXORDER",DIV,ORDER,1),U,JJ+2)=$P(STOT(DIV,ORDER),U,JJ)
 D PRINT
 D AUDIT^ECXKILL
 Q
 ;
PRINT ;print the movement data by division and ward order
 N JJ,SS,LN,NM,TNM,PG,QFLG,WRDNM,WRDTOT,GRPNM,GRPTOT,DIVTOT,DATA,DATA1
 N TYPE,DIC,DA,DR,DIR,DIRUT,DTOUT,DUOUT,W1,W2,ADMDT,IEN,FAC
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (QFLG,PG)=0,$P(LN,"-",132)="",DIV=""
 F  S DIV=$O(GTOT(DIV)) Q:DIV=""  D  Q:QFLG
 .F TYPE=2,3 S TNM=$S(TYPE=2:"Transfer",TYPE=3:"Discharge",1:"") D HEADER Q:QFLG  S MOV="",DIVTOT=0 D  Q:QFLG
 ..F  S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  S DIVTOT=DIVTOT+$P(GTOT(DIV),U,MOV)
 ..I DIVTOT=0 D  Q
 ...W !!,"No "_TNM_" data extracted for this medical center division.",!
 ..S ORDER="" F  S ORDER=$O(^TMP($J,"ECXORDER",DIV,ORDER)) Q:ORDER=""  D  Q:QFLG
 ...S DATA=^TMP($J,"ECXORDER",DIV,ORDER) K DATA1 I $D(^(ORDER,1)) S DATA1=^(1)
 ...S WRDNM=$P(DATA,U,2)
 ...I TYPE=3 S WRDNM=$P(WRDNM,"<",1),WRDNM=$E(WRDNM,1,14)
 ...I TYPE=2 D
 ....S W1=$P(WRDNM,"<",1),W2=$P(WRDNM,"<",2)
 ....S:W2="" WRDNM=$E(W1,1,14) S:W2]"" WRDNM=$$LJ^XLFSTR($E(W1,1,12),12," ")_" <"_W2
 ...D:($Y+3>IOSL) HEADER Q:QFLG
 ...W !,WRDNM S TAB=$S(TYPE=2:20,1:10),LINETOT=0
 ...F  S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  D
 ....S WRDTOT=$P(DATA,U,2+MOV),TAB=TAB+6 W ?TAB,$$RJ^XLFSTR(WRDTOT,5," ") S LINETOT=LINETOT+WRDTOT
 ...S TAB=TAB+8 W ?TAB,$$RJ^XLFSTR(LINETOT,5," ")
 ...;if data1 exists, then this is the end of a ward group so print group totals
 ...I $G(DATA1) D  Q:QFLG
 ....S GRPNM=$P(DATA1,U,2) D:($Y+3>IOSL) HEADER Q:QFLG
 ....W !,?18,$E(LN,1,113)
 ....D:($Y+3>IOSL) HEADER Q:QFLG  W !,"Ward group "_GRPNM_" subtotals:",!
 ....D:($Y+3>IOSL) HEADER Q:QFLG
 ....S TAB=$S(TYPE=2:20,1:10),LINETOT=0
 ....F  S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  D
 .....S GRPTOT=$P(DATA1,U,2+MOV),TAB=TAB+6 W ?TAB,$$RJ^XLFSTR(GRPTOT,5," ") S LINETOT=LINETOT+GRPTOT
 ....S TAB=TAB+8 W ?TAB,$$RJ^XLFSTR(LINETOT,5," ")
 ....D:($Y+3>IOSL) HEADER Q:QFLG
 ....W !!
 ..Q:QFLG
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !!,"Division "_$P(ECXDIV(DIV),U,2)_" Grand Totals:",!
 ..D:($Y+3>IOSL) HEADER Q:QFLG
 ..S TAB=$S(TYPE=2:20,1:10),LINETOT=0
 ..F  S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  D
 ...S GTOT=$P(GTOT(DIV),U,MOV),TAB=TAB+6 W ?TAB,$$RJ^XLFSTR(GTOT,5," ") S LINETOT=LINETOT+GTOT
 ..S TAB=TAB+8 W ?TAB,$$RJ^XLFSTR(LINETOT,5," ")
 ..I $E(IOST)'="C" D LEGEND
 ;print patients with missing wards
 I $D(^TMP($J,"MISWRD")) D
 .S DIV="MISWRD",ECXDIV(DIV)="^^^^^*** MISSING WARDS ***^",TYPE=0
 .D HEADER S WRDTOT=$G(^TMP($J,"MISWRD"))
 .W !,?5,"MISSING WARD",?45,$$RJ^XLFSTR(WRDTOT,5," "),!!
 .D HEAD S IEN=""
 .F  S IEN=$O(^TMP($J,"MISWRD",IEN)) Q:'IEN  D  I QFLG Q
 ..S DATA=$G(^ECX(727.808,IEN,0)),ADMDT=$P(DATA,U,11) Q:DATA=""
 ..S FAC=$P(DATA,U,4) S:FAC'="" FAC=$$GET1^DIQ(42,FAC,.01,"E")
 ..W !?2,$P(DATA,U,7),?8,$P(DATA,U,5),?25,$E(FAC,1,14),?45
 ..W $E(ADMDT,5,6)_"/"_$E(ADMDT,7,8)_"/"_$E(ADMDT,1,4)," "
 ..W $E($P(DATA,U,22),1,2)_":"_$E($P(DATA,U,22),3,4)
 ..D:($Y+3>IOSL) HEADER,HEAD Q:QFLG
 I $E(IOST)'="C" D
 .W @IOF S PG=PG+1
 .W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 .W !,"DSS Extract Log #:       "_ECXEXT
 .W !,"Date Range of Audit:     "_ECXARRAY("START")_" to "_ECXARRAY("END")
 .W !,"Report Run Date/Time:    "_ECXRUN,?120,"Page: ",PG
 .W !!,LN,!!
 .S DIC="^ECX(727.1,",DA=ECXARRAY("DEF"),DR="1" D EN^DIQ
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
 N JJ,SS,TAB,DSSID
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
 I DSSID="" W !,"Medical Center Division: "_$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")",?120,"Page: "_PG
 I DSSID]"" W !,"Medical Center Division: "_$P(ECXDIV(DIV),U,2)_" ("_$P(ECXDIV(DIV),U,3)_")"_" <"_DSSID_">",?120,"Page: "_PG
 S TAB=$S(TYPE=2:28,1:20) W !!
 I TYPE=2 W "Ward <DSS Dept.>",?TAB,"MAS Movement ("_TNM_") Types",!
 I TYPE=3 W "Ward",?TAB,"MAS Movement ("_TNM_") Types",!
 S MOV="",TAB=$S(TYPE=0:40,TYPE=2:20,1:10)
 F  S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  S TAB=TAB+6 W ?TAB,$$RJ^XLFSTR(MOV,5," ")
 S TAB=TAB+8 W ?TAB,$$RJ^XLFSTR("Total",5," ")
 W !,LN,!
 Q
 ;
LEGEND ;print legend for each report type
 N MOV,MOVNM
 D:($Y+10>IOSL) HEADER
 W !!,TNM_" Movements Legend --"
 S MOV="" F  S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  D  Q:MOV=""
 .S MOVNM=^TMP($J,"MOV",TYPE,MOV) W !,MOV,?4,"= ",$E(MOVNM,1,32)
 .S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  S MOVNM=^(MOV) W ?41,MOV,?44,"= ",$E(MOVNM,1,32)
 .S MOV=$O(^TMP($J,"MOV",TYPE,MOV)) Q:MOV=""  S MOVNM=^(MOV) W ?81,MOV,?84,"= ",$E(MOVNM,1,32)
 Q
