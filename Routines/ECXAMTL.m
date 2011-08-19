ECXAMTL ;ALB/JAM - MTL Extract Audit Report; May 24, 1999
 ;;3.0;DSS EXTRACTS;**24,44**;May 24, 1999
EN ;entry point for MTL extract audit report
 N %X,%Y
 ;ecxaud=0 for 'extract' audit
 S ECXERR=0
 S ECXHEAD="MTL",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD) I ECXERR D  Q
 . K ECXHEAD,ECXAUD,ECXERR
 ;get facility/division
 S ECXALL=1
 D MTL^ECXDVSN2(.ECXDIV,ECXALL,.ECXERR) I ECXERR D AUDIT^ECXKILL Q
 ;select output device and queue report if requested
 S ECXPGM="PROCESS^ECXAMTL",ECXDESC="MTL Extract Audit Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXALL")="",ECXSAVE("ECXDIV(")=""
 S ECXSAVE("ECXARRAY(")="" W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 . W !!,?5,"Try again later... exiting.",!
 . D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 . K ECXSAVE,ECXPGM,ECXDESC
 . D PROCESS^ECXAMTL
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
PROCESS ;process data in file #727.812
 N DAY,MTLDAT,MTLDAT1,SSN,NAME,EXN,IEN,ASI,SPC,TSTNAM,PROV,DATND,TSTSC
 N NODE
 K ^TMP($J,"ECXMTL") S EXN=ECXARRAY("EXTRACT")
 ;set start and end date in interal format
 S X=ECXARRAY("START") S %DT="" D ^%DT S ECXSTART=Y
 S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;get records for specified date range within extract
 S IEN=0 F  S IEN=$O(^ECX(727.812,"AC",EXN,IEN)) Q:'IEN  D
 . S MTLDAT=^ECX(727.812,IEN,0),MTLDAT1=$G(^ECX(727.812,IEN,1))
 . ;convert date to fileman internal format
 . S DAY=$P(MTLDAT,U,9),$E(DAY,1,2)=$E(DAY,1,2)-17 Q:$L(DAY)<7
 . I DAY<ECXSTART!(DAY>ECXEND) Q
 . S SSN=$P(MTLDAT,U,6),NAME=$P(MTLDAT,U,7),TSTNAM=$P(MTLDAT,U,21)
 . S PROV=$P(MTLDAT,U,18)
 . S:PROV'="" PROV=$$GET1^DIQ(200,$E(PROV,2,999),.01,"I")
 . S TSTSC=$P(MTLDAT,U,25),ASI=$P(MTLDAT1,U,5),SPC=$P(MTLDAT1,U,6)
 . ;determine next level for ^TMP($J,"ECXMTL",
 . Q:TSTNAM=""  S NODE=TSTNAM I TSTNAM'="ASI",TSTNAM'="GAF" S NODE="PI"
 . ;data to be stored at node in ^TMP($J,"ECXMTL,NODE
 . S DATND=$S(NODE="ASI":ASI_U_SPC,NODE="GAF":TSTSC_U_PROV,1:"")
 . ;store data in ^TMP($J,"ECXMTL",NODE
 . I NODE="PI" D  Q
 . . I '$D(^TMP($J,"ECXMTL",NODE,TSTNAM,NAME,SSN,DAY)) D
 . . . S ^TMP($J,"ECXMTL",NODE,TSTNAM,NAME,SSN,DAY)=DATND
 . . . S ^TMP($J,"ECXMTL",NODE,TSTNAM)=$G(^TMP($J,"ECXMTL",NODE,TSTNAM))+1
 . I '$D(^TMP($J,"ECXMTL",NODE,NAME,SSN,DAY)) D
 . . S ^TMP($J,"ECXMTL",NODE,NAME,SSN,DAY)=DATND
 D PRINT,AUDIT^ECXKILL
 Q
PRINT ;print the MTL audit report
 N ND,NAM,SSN,DAY,PITOT,GAFTOT,ASI,INSTOT,CNT,DIV,QFL,LN,I,CLS,SPC,ASISP
 N PG,ASITOT,ASISPTOT
 U IO
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ Q
 S (ASITOT,ASISPTOT,QFL,PG,CNT)=0,$P(LN,"-",74)="",DIV=$O(ECXDIV(""))
 ;
 ;- Added new class, ASI-MV, per MH patch YS*5.01*67
 F I=1:1:4,999 S (ASI(I),ASISP(I))=0 D
 . S ASI(I,0)=$S(I=1:"Full",I=2:"Lite",I=3:"Follow-up",I=4:"For ASI-MV",1:"Unspecified")
 . S ASISP(I,0)=$S(I=1:"Terminated",I=2:"Refused",I=3:"Unable",1:"Unspecified")
 S ASISP(0)=0,ASISP(0,0)="Completed" D HEADER
 S ND="" F  S ND=$O(^TMP($J,"ECXMTL",ND)) Q:ND=""  D  I QFL Q
 . S CNT=CNT+1 D H1 S NAM="" I ($Y+3)>IOSL D HEADER I QFL Q
 . I ND="PI" D  Q
 . . F  S NAM=$O(^TMP($J,"ECXMTL",ND,NAM)) Q:NAM=""  D  I QFL Q
 . . . S INSTOT=^TMP($J,"ECXMTL",ND,NAM)
 . . . D:($Y+3)>IOSL HEADER Q:QFL  W ?5,NAM,?32,$J(INSTOT,8),!
 . . . S PITOT=$G(PITOT)+INSTOT
 . . I ($Y+3)>IOSL D HEADER I QFL Q
 . . W ?5,LN,!,?5,"Total",?30,$J(PITOT,10),!
 . F  S NAM=$O(^TMP($J,"ECXMTL",ND,NAM)) Q:NAM=""  S SSN="" D  I QFL Q
 . .F  S SSN=$O(^TMP($J,"ECXMTL",ND,NAM,SSN)) Q:SSN=""  S DAY="" D  Q:QFL
 . . . F  S DAY=$O(^TMP($J,"ECXMTL",ND,NAM,SSN,DAY)) Q:DAY=""  D P1 Q:QFL
 . I QFL Q
 . ;print GAF total
 . I ND="GAF" D  Q
 . . D:($Y+3)>IOSL HEADER Q:QFL  W ?5,LN,!,?5,"Total: ",GAFTOT,!
 . ;print ASI totals
 . I ND="ASI" D  Q
 . . D:($Y+3)>IOSL HEADER Q:QFL  W ?5,LN,! S (CLS,SPC)=-1
 . . F I=1:1:5 D  Q:(CLS="")&(SPC="")  I QFL Q
 . . . I ($Y+3)>IOSL D HEADER I QFL Q
 . . . I CLS'="" S CLS=$O(ASI(CLS)) D:CLS'=""
 . . . . W ?29,$J(ASI(CLS),8)," ",ASI(CLS,0)
 . . . . S ASITOT=ASITOT+ASI(CLS)
 . . . I SPC'="" S SPC=$O(ASISP(SPC)) D:SPC'=""
 . . . . W ?50,$J(ASISP(SPC),8)," ",ASISP(SPC,0) D
 . . . . S ASISPTOT=ASISPTOT+ASISP(SPC)
 . . . W !
 . . Q:QFL  W ?5,LN,!,?27,$J(ASITOT,10),?48,$J(ASISPTOT,10)," ","Total"
 Q
P1 ;print ASI and GAF records
 N DATND,DATE
 S DATND=^TMP($J,"ECXMTL",ND,NAM,SSN,DAY)
 S DATE=$E(DAY,4,5)_"/"_$E(DAY,6,7)_"/"_($E(DAY)+17)_$E(DAY,2,3)
 D:($Y+3)>IOSL HEADER Q:QFL  W ?5,NAM,?14,$E(SSN,$L(SSN)-3,$L(SSN))
 I ND="ASI" D  Q
 . S CLS=$P(DATND,U),SPC=$P(DATND,U,2)
 . W ?21,DATE,?36,$S(CLS=1:"Full",CLS=2:"Lite",CLS=3:"F-up",CLS=4:"ASI-MV",1:""),?57,SPC,!
 . S:CLS="" CLS=999 S:SPC="" SPC=999 S:SPC="N" SPC=0
 . S ASI(CLS)=$G(ASI(CLS))+1,ASISP(SPC)=$G(ASISP(SPC))+1
 I ND="GAF" D  Q
 . W ?21,DATE,?36,$P(DATND,U,2),!
 . S GAFTOT=$G(GAFTOT)+1
 Q
HEADER ;header and page control
 N JJ,SS
 I $E(IOST)="C" D  I QFL Q
 . S SS=22-$Y F JJ=1:1:SS W !
 . I PG S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFL=1
 W:PG!($E(IOST)="C") @IOF S PG=PG+1
 W !,ECXARRAY("TYPE")_" ("_ECXHEAD_") Extract Audit Report"
 W !,"DSS Extract Log #:    "_ECXARRAY("EXTRACT")
 W !,"Date Range of Audit:  "_ECXARRAY("START")_" to "_ECXARRAY("END")
 W !,"Report Run Date/Time: "_ECXRUN
 I $P(ECXDIV(DIV),U)="" D
 . S $P(ECXDIV(DIV),U)=$P(ECXDIV(DIV),U,3)
 . I $P(ECXDIV(DIV),U)="" S $P(ECXDIV(DIV),U)="Unknown"
 W !,"Facility:             "_$P(ECXDIV(DIV),U)
 W " ("_$P(ECXDIV(DIV),U,4)_")",?68,"Page: "_PG
H1 I $G(ND)'="" D
 . W !!,CNT,".",?5
 . I ND="PI" W "Psych Instruments segment",!! Q
 . W ND," segment",!!
 . W ?5,"Name",?14,"SSN",?21
 . I ND="ASI" W "Interview",?36,"Class",?54,"Special"
 . I ND="GAF" W "Date",?36,"Clinician"
 . W !,?5,LN,!
 Q
