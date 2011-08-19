RGMTHLDB ;BIR/CML-MPI/PD HL7 ACTIVITY BY PATIENT/SINGLE PROTOCOL ;11/05/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**21**;30 Apr 99
 ;
 ;Reference to ^ORD(101 supported by IA #2596
 ;Reference to ^HL(772 supported by IA #3464
 ;Reference to ^DPT(DFN,"MPI" supported by IA #2070
 ;
 S QFLG=1
CHK ;
 I '$D(^XTMP("RGMT","HL")) D  G QUIT
 .W !!,$C(7),"The option ""Compile MPI/PD HL7 Data"" must have"
 .W !,"run to completion before this report can be printed!"
 ;
 I '$D(^XTMP("RGMT","HL","@@@@","STOPPED")) D  G QUIT
 .W !!,$C(7),"The option ""Compile MPI/PD HL7 Data"" is currently running."
 .W !,"This report cannot be generated until the compile has run to completion."
 .W !!,"Please try again later.",!
 ;
 W @IOF
 I $D(^XTMP("RGMT","HL","@@@@","RANGE")) D
 .W !!,"Data has been compiled for ",^XTMP("RGMT","HL","@@@@","RANGE"),"."
 .W !,"Use the ""Compile MPI/PD HL7 Data"" option if this range is not sufficient."
 ;
BEGIN ;
 W !!,"This option allows you to search for activity related to a specific protocol in"
 W !,"the HL7 MESSAGE TEXT (#772) file for a patient during a selected period of time."
 W !,"This search is accomplished using data set into a temporary global built by the"
 W !,"option ""Compile MPI/PD HL7 Data""."
 ;
ASK1 ;Ask for Protocol
 W !
 S DIC="^ORD(101,",DIC(0)="QEAM"
 S DIC("S")="S ORD=$P(^(0),""^"") I $D(^XTMP(""RGMT"",""HL"",ORD))"
 D ^DIC K DIC G:Y<0 QUIT S PROT=$P(Y,"^",2)
 ;
ASK2 ;Ask for Date Range
 W !
 K DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="DAO^:DT:EPX",DIR("A")="Beginning Date:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT
 ;
 S RGBDT=Y,DIR(0)="DAO^"_RGBDT_":DT:EPX",DIR("A")="Ending Date:  "
 D ^DIR K DIR G:$D(DIRUT) QUIT S RGEDT=Y
 ;
ASK3 ;Ask for TYPE
 W !
 S DIR(0)="SB^I:INCOMING;O:OUTGOING",DIR("A")="Select TYPE"
 D ^DIR K DIR G:$D(DIRUT) QUIT S TYPE=Y
 ;
ASK4 ;Ask for PATIENT
 W !!!,"Patient lookup can be done by (P)atient Name/SSN or by (I)CN.",!
 S DIR(0)="SB^I:ICN;P:PATIENT NAME/SSN",DIR("A")="Select LOOKUP",DIR("B")="P"
 D ^DIR K DIR G:$D(DIRUT) QUIT S LOOKUP=Y
 I LOOKUP="P" D LOOKUP1 G:'$D(DFN) ASK4
 I LOOKUP="I" D LOOKUP2 G:'$D(DFN) ASK4
 ;
DEV ;
 W !!,"The right margin for this print is 80.",!!
 S ZTSAVE("RGBDT")="",ZTSAVE("RGEDT")="",ZTSAVE("PROT")=""
 S ZTSAVE("TYPE")="",ZTSAVE("DFN")="",ZTSAVE("ICN")=""
 D EN^XUTMDEVQ("START^RGMTHLDB","MPI/PD - Print HL7 Message Data for Patient/Single Protocol") I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 G QUIT
START ;
 G:'$D(^XTMP("RGMT","HL")) QUIT
 S (PG,QFLG,GOTDATA)=0,U="^",$P(LN,"-",81)="",SITE=$P($$SITE^VASITE(),U,2)
 S PRGBDT=$$FMTE^XLFDT(RGBDT),PRGEDT=$$FMTE^XLFDT(RGEDT)
 D NOW^%DTC S HDT=$$FMTE^XLFDT($E(%,1,12))
 D HDR
 ;
LOOP ;Loop on ^XTMP("RGMT","HLICN" & ^XTMP("RGMT","HLDFN"
 I '$D(^XTMP("RGMT","HLICN"))&'($D(^XTMP("RGMT","HLDFN"))) G QUIT
 S STOPDT=RGEDT_".9"
 F SUB1="HLICN","HLDFN" S SUB2=$S(SUB1="HLICN":ICN,1:DFN) Q:QFLG  D
 .S RGDT=RGBDT-.1
 .F  S RGDT=$O(^XTMP("RGMT",SUB1,SUB2,RGDT)) Q:'RGDT  Q:RGDT>STOPDT  Q:QFLG  D
 ..S STAT="" F  S STAT=$O(^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE,STAT)) Q:STAT=""  Q:QFLG  D
 ...S IEN=0 F  S IEN=$O(^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE,STAT,IEN))  Q:'IEN  Q:QFLG  D
 ....I ^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE,STAT,IEN)]"" D BATCHPRT Q
 ....I $O(^HL(772,IEN,"IN",0)) S GOT=0 D  Q:QFLG
 .....S TXT=0 F  S TXT=$O(^HL(772,IEN,"IN",TXT)) Q:'TXT  Q:QFLG  D  Q:GOT  Q:QFLG
 ......I $P(^HL(772,IEN,"IN",TXT,0),U)="PID",+$P(^(0),U,3)=ICN D PROC Q
 ......I $P(^HL(772,IEN,"IN",TXT,0),U)="MFE",$P(^(0),U,2)="MAD",+$P($P(^(0),U,5),"~",4)=ICN D PROC Q
 ......I $P(^HL(772,IEN,"IN",TXT,0),U)="MFE",$P(^(0),U,2)="MUP",+$P(^(0),U,5)=ICN D PROC Q
 ......I $P(^HL(772,IEN,"IN",TXT,0),U)="QAK",+$P(^(0),U,2)=DFN D PROC
 I 'GOTDATA W !,"No data found for this patient."
 ;
QUIT ;
 I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 K %,BATCHIEN,CNT,DFN,GOT,GOTDATA,HDT,ICN,IEN,JJ,LIM,LINE,LN,LOOKUP,NODE,NUM,PG,PRGBDT
 K PRGEDT,PROT,QFLG,RGBDT,RGDT,RGEDT,SITE,SS,STAT,STOPDT,SUB1,SUB2,TXT,TYPE,Y,ZTSK
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
HDR ;HEADER
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF I $E(IOST)'="C"!($E(IOST)="C"&(PG=1)) D
 .W !,"HL7 TRANSMISSION DATA at ",SITE," on ",HDT,?72,"Page: ",PG
 .W !!,"Patient: ",$P(^DPT(DFN,0),U)
 .W !,"Protocol: ",PROT
 .W !,"Date Range: ",PRGBDT," to ",PRGEDT,?45,"Type: ",$S(TYPE="I":"INCOMING",1:"OUTGOING"),!
 W !,"File #772 IEN",?19,"Date",?39,"Status",!?4,"""IN"" Subfield",!,LN
 Q
 ;
BATCHPRT ;
 S GOTDATA=1
 D:$Y+4>IOSL HDR Q:QFLG
 S BATCHIEN=+$P(^XTMP("RGMT",SUB1,SUB2,RGDT,PROT,TYPE,STAT,IEN),",""IN"",",2)
 W !,"Batch Msg #",IEN," - Line #",BATCHIEN
 W !?19,$$FMTE^XLFDT($E(RGDT,1,12)),?39,STAT,!
 S NODE=^HL(772,IEN,"IN",BATCHIEN,0)
 I $L(NODE)>75 D BREAK Q
 W !?4,NODE
 Q
 ;
PROC ;Print data
 S GOT=1,GOTDATA=1
 W !,IEN,?19,$$FMTE^XLFDT($E(RGDT,1,12)),?39,STAT,!
 S NUM=0 F  S NUM=$O(^HL(772,IEN,"IN",NUM)) Q:'NUM  Q:QFLG  S NODE=^HL(772,IEN,"IN",NUM,0) D
 .I $L(NODE)>75 D BREAK Q
 .D:$Y+3>IOSL HDR Q:QFLG  W !?4,NODE
 Q
 ;
BREAK ;Break up text lines greater than 75
 S CNT=1,LIM=$L(NODE)/75 I LIM["." S LIM=$P(LIM,".")+1
 F LINE=1:1:LIM D:$Y+3>IOSL HDR Q:QFLG  W !?4,$E(NODE,CNT,CNT+74) S CNT=CNT+75
 Q
 ;
LOOKUP1 ;Lookup by patient name/ssn
 W ! K DFN,ICN
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: " D ^DIC K DIC
 Q:Y<0
 S DFN=+Y
 S ICN=+$P($G(^DPT(DFN,"MPI")),U) I 'ICN W !!,"This patient does not have an ICN!" K DFN,ICN
 Q
 ;
LOOKUP2 ;Lookup by ICN
 W ! K DFN,ICN
 S DIR(0)="N:1:999999999999:0",DIR("A")="Select ICN" D ^DIR K DIR Q:$D(DIRUT)
 S ICN=Y S DFN=$$GETDFN^MPIF001(ICN)
 I +DFN<0 W !!,"No patient match can be found for this ICN!" K DFN,ICN Q
 W "  ",$P(^DPT(DFN,0),"^")
 Q
