RGMTHLPD ;BIR/CML-MPI/PD HL7 MESSAGE STATUS REPORT (DETAILED) ;12/12/00
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**21**;30 Apr 99
 ;
 ;Reference to ^HL(771.6 supported by IA #2507
 ;Reference to ^HL(772 supported by IA #3464
 ;Reference to ^HLCS(870 supported by IA #2525
 ;Reference to ^HLMA( supported by IA #3273
 ;Reference to ^ORD(101 supported by IA #2596
 ;
BEGIN ; Produce DETAILED Report
 W !!,"This option allows you to print information found during the ""Compile MPI/PD"
 W !,"HL7 Data"" compilation. The report is sorted by RELATED EVENT PROTOCOL, date,"
 W !,"transmission type, and status. Detailed information for each HL7 message is"
 W !,"displayed."
 ;
PROT ;Ask for all or single PROTCOL
 K DIR,DIRUT,DTOUT,DUOUT,REPNM
 W !! S DIR(0)="SAM^A:ALL Protocols;S:Single Protocol;"
 S DIR("A")="Do you want (A)ll or a (S)ingle Protocol:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT I Y="A" G ASK1
 S DIC="^ORD(101,",DIC(0)="QEAM"
 S DIC("S")="S ORD=$P(^(0),""^"") I $D(^XTMP(""RGMT"",""HL"",ORD))"
 D ^DIC K DIC G:Y<0 QUIT
 S PROT=+Y,REPNM=$P(Y,"^",2)
 ;
ASK1 ;Ask for Date Range
 W !!,"Enter date range for data to be included in report."
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DAO^:DT:EPX",DIR("A")="Beginning Date for Report:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT
 S RGBDT=Y,DIR(0)="DAO^"_RGBDT_":DT:EPX"
 S DIR("A")="Ending Date for Report:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT S RGEDT=Y
 ;
DEV ;
 W !!,"The right margin for this report is 132.",!!
 S ZTSAVE("RGBDT")="",ZTSAVE("RGEDT")="",ZTSAVE("REPNM")=""
 D EN^XUTMDEVQ("START^RGMTHLPD","MPI/PD - Print HL7 Message Status (DETAILED)") I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 G QUIT
 ;
START ;Print report
 S (PG,QFLG)=0,U="^",$P(LN,"-",132)="",SITE=$P($$SITE^VASITE(),U,2)
 S PRGBDT=$$FMTE^XLFDT(RGBDT),PRGEDT=$$FMTE^XLFDT(RGEDT)
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 D HDR
 I $D(REPNM) W !!,REPNM,":" D LOOP G QUIT
 S REPNM="@@@@"
 F  S REPNM=$O(^XTMP("RGMT","HL",REPNM)) Q:REPNM=""  Q:QFLG  D
 .D:$Y+3>IOSL HDR Q:QFLG
 .W !!,REPNM,":" D LOOP
 ;
QUIT ;
 I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 K %,CNT,DFN,DIC,DIR,DIRUT,DTOUT,DUOUT,HDT,HLMADTPR,HLMAICN,HLMALINK,HLMALL,HLMAPROT,HLMASTAT,ICN,IEN
 K IEN0,JJ,LN,PG,PRGBDT,PRGEDT,PROCDT,PROT,PTNM,QFLG,REP,REPNM,RGBDT,RGDT,RGEDT,SITE,SS,STAT
 K STATNM,STOPDT,TXT,TYPE,X,Y,ZTSK
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
LOOP ;
 S STOPDT=RGEDT_".9",CNT=0
 S RGDT=RGBDT-.1
 F  S RGDT=$O(^XTMP("RGMT","HL",REPNM,RGDT)) Q:'RGDT  Q:RGDT>STOPDT  Q:QFLG  D
 .D:$Y+4>IOSL HDR Q:QFLG
 .S TYPE=""
 .F  S TYPE=$O(^XTMP("RGMT","HL",REPNM,RGDT,TYPE)) Q:TYPE=""  Q:QFLG  D
 ..S STAT=""
 ..F  S STAT=$O(^XTMP("RGMT","HL",REPNM,RGDT,TYPE,STAT)) Q:STAT=""  Q:QFLG  D
 ...S IEN=0
 ...F  S IEN=$O(^XTMP("RGMT","HL",REPNM,RGDT,TYPE,STAT,IEN)) Q:'IEN  Q:QFLG  D
 ....D:$Y+3>IOSL HDR Q:QFLG  S CNT=CNT+1
 ....W !!?3,$$FMTE^XLFDT($E(RGDT,1,12)),?18,$S(TYPE="O":"OUTGOING",1:"INCOMING"),?29,STAT
 ....I '$D(^HL(772,IEN,0)) W ?96,"<<PURGED>>" Q
 ....S PROCDT=$P($G(^HL(772,IEN,"P")),U,2),PROCDT=$$FMTE^XLFDT($E(PROCDT,1,12))
 ....W ?61,PROCDT,?83,"^HL(772,",IEN
 ....I REPNM="MPIF CMOR RESULT SERVER"&(TYPE="O") I $D(^HL(772,IEN,"IN",1,0)) D
 .....S ICN=+$P(^HL(772,IEN,"IN",1,0),"^",3)
 .....S DFN=$$GETDFN^MPIF001(ICN)
 .....S PTNM="NO DFN" I DFN S PTNM=$P(^DPT(DFN,0),"^")
 .....W !?6,"ICN: ",ICN,"   NAME: ",PTNM
 ....S HLMAIEN=0
 ....F  S HLMAIEN=$O(^HLMA("B",IEN,HLMAIEN)) Q:'HLMAIEN  Q:QFLG  D
 .....S HLMASTAT=$P(^HL(771.6,($P(^HLMA(HLMAIEN,"P"),"^")),0),"^")
 .....S HLMADTPR="" I $D(^HLMA(HLMAIEN,"S")) S HLMADTPR=$$FMTE^XLFDT($E($P(^HLMA(HLMAIEN,"S"),"^"),1,12))
 .....S HLMAPROT=$P(^ORD(101,$P(^HLMA(HLMAIEN,0),"^",8),0),"^")
 .....S HLMALL=$P(^HLMA(HLMAIEN,0),"^",7)
 .....S HLMALINK=$P(^HLCS(870,HLMALL,0),"^")
 .....D:$Y+3>IOSL HDR Q:QFLG
 .....W !?6,"=>^HLMA(",HLMAIEN,?29,HLMASTAT,?61,HLMADTPR,?83,HLMAPROT,?116,HLMALINK
 W !!?110,"TOTAL: ",CNT
 Q
 ;
HDR ;HEADER
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF
 W !,"MPI/PD HL7 MESSAGE STATUS REPORT - DETAILED (",PRGBDT," to ",PRGEDT,")"
 W ?117,"Page: ",PG,!,"Printed at ",SITE," on ",HDT
 W !!,"RELATED EVENT PROTOCOL",!?3,"DATE",?18,"TYPE",?29,"STATUS IN FILE #772"
 W ?61,"DATE PROCESSED",?83,"FILE #772 IEN"
 W !?6,"=>FILE #773 ENTRY",?29,"STATUS IN FILE #773",?61,"DATE PROCESSED"
 W ?83,"PROTOCOL",?116,"LOGICAL LINK",!,LN
 Q
 ;
REPROC ;reprocess entries in xtmp global ^XTMP("REPROC"
 S CNT=0
 S HLMALINK=""
 F  S HLMALINK=$O(^XTMP("REPROC",HLMALINK)) Q:HLMALINK=""  D
 .S HLMAIEN=0
 .F  S HLMAIEN=$O(^XTMP("REPROC",HLMALINK,HLMAIEN)) Q:'HLMAIEN  D
 ..S CNT=CNT+1
 W !!,CNT," messages to attempt to process."
 ;
 S CNT=0
 S HLMALINK=""
 F  S HLMALINK=$O(^XTMP("REPROC",HLMALINK)) Q:HLMALINK=""  D
 .S HLMAIEN=0
 .F  S HLMAIEN=$O(^XTMP("REPROC",HLMALINK,HLMAIEN)) Q:'HLMAIEN  D
 ..S RGRTN=$G(^ORD(101,PROT,771))
 ..I '$$REPROC^HLUTIL(HLMAIEN,RGRTN) S CNT=CNT+1
 W !!,CNT," messages successfully processed."
 K CNT,HLMALINK,HLMAIEN,RGRTN
 Q
