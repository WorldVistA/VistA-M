RGMTHLP ;BIR/CML-MPI/PD HL7 MESSAGE STATUS REPORT ;12/12/00
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**21**;30 Apr 99
 S QFLG=1
CHK ;
 I '$D(^XTMP("RGMT","HL")) D  G QUIT
 .W !!,$C(7),"The option ""Compile MPI/PD HL7 Data"" must have"
 .W !,"run to completion before this report can be printed!"
 I '$D(^XTMP("RGMT","HL","@@@@","STOPPED")) D  G QUIT
 .W !!,$C(7),"The option ""Compile MPI/PD HL7 Data"" is currently running."
 .W !,"This report cannot be generated until the compile has run to completion."
 .W !!,"Please try again later.",!
 W @IOF
 I $D(^XTMP("RGMT","HL","@@@@","RANGE")) D
 .W !!,"Data has been compiled for ",^XTMP("RGMT","HL","@@@@","RANGE"),"."
 .W !,"Use the ""Compile MPI/PD HL7 Data"" option if this range is not sufficient."
 ;
REP ;Ask for type of report
 K DIR,DIRUT,DTOUT,DUOUT
 W !!
 S DIR(0)="SAM^D:Detailed;S:Summary;"
 S DIR("A")="Select TYPE of Report - (D)etailed or (S)ummary:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT
 G:Y="D" ^RGMTHLPD
 ;
BEGIN ; Produce SUMMARY Report
 W !!,"This option allows you to print information found during the ""Compile MPI/PD"
 W !,"HL7 Data"" compilation. The report is sorted by RELATED EVENT PROTOCOL, date,"
 W !,"transmission type, and status. The total number of messages for each date,"
 W !,"transmission type, and status are displayed."
 ;
ASK1 ;Ask for Date Range
 W !!,"Enter date range for data to be included in report."
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DAO^:DT:EPX",DIR("A")="Beginning Date for Report:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT S RGBDT=Y
 S DIR(0)="DAO^"_RGBDT_":DT:EPX"
 S DIR("A")="Ending Date for Report:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT S RGEDT=Y
 ;
DEV ;
 W !!,"The right margin for this report is 80.",!!
 S ZTSAVE("RGBDT")="",ZTSAVE("RGEDT")=""
 D EN^XUTMDEVQ("START^RGMTHLP","MPI/PD - Print HL7 Message Status (SUMMARY)") I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 G QUIT
 ;
START ;Print report
 S (PG,QFLG)=0,U="^",$P(LN,"-",81)="",SITE=$P($$SITE^VASITE(),U,2)
 S PRGBDT=$$FMTE^XLFDT(RGBDT),PRGEDT=$$FMTE^XLFDT(RGEDT)
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 D HDR
 S STOPDT=RGEDT_".9"
 S REPNM="@@@@"
 F  S REPNM=$O(^XTMP("RGMT","HL",REPNM)) Q:REPNM=""  Q:QFLG  D
 .D:$Y+3>IOSL HDR Q:QFLG
 .W !!,REPNM,":" D
 ..S RGDT=RGBDT-.1
 ..F  S RGDT=$O(^XTMP("RGMT","HL",REPNM,RGDT)) Q:'RGDT  Q:RGDT>STOPDT  Q:QFLG  D
 ...D:$Y+4>IOSL HDR Q:QFLG
 ...W !!?4,$$FMTE^XLFDT(RGDT) D
 ....S TYPE="",TYPECNT=0
 ....F  S TYPE=$O(^XTMP("RGMT","HL",REPNM,RGDT,TYPE)) Q:TYPE=""  Q:QFLG  D
 .....S TYPECNT=TYPECNT+1
 .....W:TYPE="O"&(TYPECNT>1) !
 .....W ?25,$S(TYPE="O":"OUTGOING",1:"INCOMING") S TOTCNT=0 D
 ......S STATCNT=0,STAT=""
 ......F  S STAT=$O(^XTMP("RGMT","HL",REPNM,RGDT,TYPE,STAT)) Q:STAT=""  Q:QFLG  D
 .......W:STATCNT>0 !
 .......S STATCNT=STATCNT+1
 .......W ?41,STAT S CNT=0 D  W ?69,$J(CNT,6) S TOTCNT=TOTCNT+CNT
 ........S IEN=0
 ........F  S IEN=$O(^XTMP("RGMT","HL",REPNM,RGDT,TYPE,STAT,IEN)) Q:'IEN  Q:QFLG  S CNT=CNT+1
 ......I STATCNT>1 W !?69,"-------",!?59,"TOTAL",?69,$J(TOTCNT,6),!
 ;
QUIT ;
 I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 K %,CNT,HDT,IEN,IEN0,JJ,LN,MSGID,PG,PRGBDT,PRGEDT,QFLG,REP,REPNM,RGBDT
 K RGDT,RGEDT,SITE,SS,STAT,STATCNT,STATNM,STOPDT,TOTCNT,TYPE,TYPECNT,X,Y,ZTSK
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HDR ;HEADER
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF
 W !,"MPI/PD HL7 MESSAGE STATUS REPORT - SUMMARY (",PRGBDT," to ",PRGEDT,")"
 W ?72,"Page: ",PG,!,"Printed at ",SITE," on ",HDT
 W !!,"RELATED EVENT PROTOCOL",!?23,"TRANSMISSION",!?4,"DATE",?27,"TYPE"
 W ?41,"STATUS",?69,"TOTAL",!,LN
 Q
