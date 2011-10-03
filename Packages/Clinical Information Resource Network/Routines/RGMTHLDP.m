RGMTHLDP ;BIR/CML-MPI/PD HL7 ACTIVITY BY PATIENT/ALL PROTOCOLS ;11/05/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**21**;30 Apr 99
 ;
 ;Reference to ^ORD(101 supported by IA #2596
 ;Reference to ^HL(771.6 supported by IA #2507
 ;Reference to ^HLMA( supported by IA #3273
 ;Reference to ^HLCS(870 supported by IA #2525
 ;Reference to ^DPT(DFN,"MPI" supported by IA #2070
 ;
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
BEGIN ;
 W !!,"This option allows you to search for ALL activity in the HL7 MESSAGE TEXT"
 W !,"(#772) file for a specific patient during a selected period of time.  This"
 W !,"search is accomplished using data set into a temporary global built by the"
 W !,"option ""Compile MPI/PD HL7 Data""."
 ;
ASK1 ;Ask for PATIENT
 W !!!,"Patient lookup can be done by (P)atient Name/SSN or by (I)CN.",!
 S DIR(0)="SB^I:ICN;P:PATIENT NAME/SSN",DIR("A")="Select LOOKUP",DIR("B")="P"
 D ^DIR K DIR G:$D(DIRUT) QUIT S TYPE=Y
 I TYPE="P" D LOOKUP1 G:'$D(ICN) ASK1 G ASK2
 I TYPE="I" D LOOKUP2 G:'$D(ICN) ASK1
 ;check if selected patient had activity in compiled data
 I 'ICN,'$D(^XTMP("RGMT","HLDFN",DFN)) D MSG G QUIT
 I '$D(^XTMP("RGMT","HLICN",ICN)) D MSG G QUIT
 ;
ASK2 ;Ask for Date Range
 W !!,"Enter date range for data to be included in report."
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DAO^:DT:EPX",DIR("A")="Beginning Date:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT S RGBDT=Y
 S DIR(0)="DAO^"_RGBDT_":DT:EPX",DIR("A")="Ending Date:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT S RGEDT=Y
 ;
DEV ;
 W !!,"The right margin for this report is 80.",!!
 S ZTSAVE("RGBDT")="",ZTSAVE("RGEDT")="",ZTSAVE("DFN")="",ZTSAVE("ICN")=""
 D EN^XUTMDEVQ("START^RGMTHLDP","MPI/PD - Print HL7 Message Data for Patient/All Protocols") I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 G QUIT
 ;
START ;
 K ^TMP("RGMTHLDP",$J) S U="^"
 ;
LOOP ;Loop on ^XTMP("RGMT","HLICN" & ^XTMP("RGMT","HLDFN"
 I '$D(^XTMP("RGMT","HLICN"))&'($D(^XTMP("RGMT","HLDFN"))) G QUIT
 S STOPDT=RGEDT_".9"
 F SUB1="HLICN","HLDFN" S SUB2=$S(SUB1="HLICN":ICN,1:DFN) D
 .S RGDT=RGBDT-.1
 .F  S RGDT=$O(^XTMP("RGMT",SUB1,SUB2,RGDT)) Q:'RGDT  Q:RGDT>STOPDT  D
 ..S PROT="" F  S PROT=$O(^XTMP("RGMT",SUB1,SUB2,RGDT,PROT)) Q:PROT=""  D
 ...S TYPE="" F  S TYPE=$O(^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE)) Q:TYPE=""  D
 ....S STAT="" F  S STAT=$O(^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE,STAT)) Q:STAT=""  D
 .....S IEN=0 F  S IEN=$O(^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE,STAT,IEN))  Q:'IEN  D
 ......S ^TMP("RGMTHLDP",$J,PROT,RGDT,TYPE,STAT,IEN)=^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE,STAT,IEN)
 ;
PRT ;Print report
 S (PG,QFLG)=0,U="^",$P(LN,"-",81)="",SITE=$P($$SITE^VASITE(),U,2)
 S PRGBDT=$$FMTE^XLFDT(RGBDT),PRGEDT=$$FMTE^XLFDT(RGEDT)
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 D HDR
 S PROT="" F  S PROT=$O(^TMP("RGMTHLDP",$J,PROT)) Q:PROT=""  Q:QFLG  W !!,PROT,":" D
 .S RGDT=0
 .F  S RGDT=$O(^TMP("RGMTHLDP",$J,PROT,RGDT)) Q:'RGDT  Q:QFLG  D
 ..S TYPE=""
 ..F  S TYPE=$O(^TMP("RGMTHLDP",$J,PROT,RGDT,TYPE)) Q:TYPE=""  Q:QFLG  D
 ...S STAT=""
 ...F  S STAT=$O(^TMP("RGMTHLDP",$J,PROT,RGDT,TYPE,STAT)) Q:STAT=""  Q:QFLG  D
 ....S IEN=0
 ....F  S IEN=$O(^TMP("RGMTHLDP",$J,PROT,RGDT,TYPE,STAT,IEN)) Q:'IEN  Q:QFLG  D
 .....D:$Y+3>IOSL HDR Q:QFLG
 .....W !!?4,$$FMTE^XLFDT($E(RGDT,1,12))
 .....W ?25,$S(TYPE="O":"OUTGOING",1:"INCOMING"),?41,STAT,?69,IEN
 .....I ^TMP("RGMTHLDP",$J,PROT,RGDT,TYPE,STAT,IEN)]"" D  Q
 ......W !?35,^TMP("RGMTHLDP",$J,PROT,RGDT,TYPE,STAT,IEN)
 .....S HLMAIEN=0
 .....F  S HLMAIEN=$O(^HLMA("B",IEN,HLMAIEN)) Q:'HLMAIEN  Q:QFLG  D
 ......S HLMASTAT=$P(^HL(771.6,($P(^HLMA(HLMAIEN,"P"),"^")),0),"^")
 ......S HLMAPROT=$P(^ORD(101,$P(^HLMA(HLMAIEN,0),"^",8),0),"^")
 ......S HLMALINK=$P(^HLCS(870,$P(^HLMA(HLMAIEN,0),"^",7),0),"^")
 ......D:$Y+3>IOSL HDR Q:QFLG
 ......W !?4,"=>^HLMA(",HLMAIEN,?24,$E(HLMAPROT,1,25),?50,$E(HLMASTAT,1,22),?74,HLMALINK
 I '$D(^TMP("RGMTHLDP",$J)) W !!,"No data found for this patient."
QUIT ;
 I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 K ^TMP("RGMTHLDP",$J)
 K %,DFN,GOT,HDT,ICN,IEN,JJ,LL,LN,PG,PRGBDT,PRGEDT,PROT,QFLG,RGBDT
 K HLMAIEN,HLMASTAT,HLMAPROT,HLMALINK
 K RGDT,RGEDT,SITE,SS,STAT,STOPDT,SUB1,SUB2,TXT,TYPE,X,Y,ZTSK
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HDR ;HEADER
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF
 W !,"HL7 TRANSMISSION PATIENT DATA at ",SITE," on ",HDT,?72,"Page: ",PG
 W !!,"Patient: ",$P(^DPT(DFN,0),U)
 W !,"Date Range: ",PRGBDT," to ",PRGEDT
 W !!,"Related Event Protocol"
 W !?4,"Date",?26,"Type",?42,"Status",?69,"^HL(772,IEN"
 W !?4,"=>^HLMA(IEN",?24,"Protocol",?50,"Status",?74,"Link",!,LN
 Q
 ;
LOOKUP1 ;Lookup by patient name/ssn
 W ! K DFN,ICN
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: " D ^DIC K DIC
 Q:Y<0
 S DFN=+Y
 S ICN=+$P($G(^DPT(DFN,"MPI")),U)
 Q
 ;
LOOKUP2 ;Lookup by ICN
 W ! K DFN,ICN
 S DIR(0)="N:1:999999999999:0",DIR("A")="Select ICN" D ^DIR K DIR Q:$D(DIRUT)
 S ICN=Y S DFN=$$GETDFN^MPIF001(ICN)
 I +DFN<0 W !!,"No patient DFN match can be found for this ICN!" K DFN,ICN Q
 W "  ",$P(^DPT(DFN,0),"^")
 Q
 ;
MSG ;
 W !!,"This patient has no HL7 messaging activity in the current compiled data set."
 Q
