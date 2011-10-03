LREPIRS ;DALOI/CKA - EPI-LOCAL REPORT/SPREADSHEET ; 5/14/03
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ; Reference to ^ORD(101 supported by IA #872
 ;USED TO PRINT REPORT OR SPREADSHEET 
 D NOW^%DTC
 S LRLRDT=% ;Set LRLRDT- local report date time=now
 S LRRTYPE=1,LRPROT=0
 S LRPROT=$O(^ORD(101,"B","LREPI",LRPROT))
 W @IOF,?(IOM/2-15),"Laboratory Generate Local Report/Spreadsheet option"
CRI K LRCYCLE,LREPI S LRMSG="Pathogens" D ALL G:$D(DIRUT) EXIT
 K DIR,DIRUT,DTOUT,DUOUT,DIROUT
 I +LRALL D PICKALL G DATE
 S LRMSG="Local Pathogens" D ALL G:$D(DIRUT) CRI
 K DIR,DIRUT,DTOUT,DUOUT,DIROUT
 I +LRALL D LOCALL G DATE
 I +LRALL'>0 D
 .W @IOF
 .F  Q:$D(DIRUT)  D
 ..S DIR(0)="PAO^69.5:EMZ",DIR("A")="Select Pathogens: "
 ..S DIR("S")="D CHKL^LREPIRM I LROK I $P(^(0),U,7)=LRPROT"
 ..D ^DIR
 ..Q:$D(DIRUT)
 ..S LREPI(+Y)=""
 G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) CRI
 I '$D(LREPI) W !,"Sorry No Pathogens Selected" G EXIT
DATE ;Select Search Date
 K DIR,DIRUT
 S DIR("A")="Select Start Date: "
 S DIR(0)="DOA^:"_DT D ^DIR
 G:$D(DIRUT) CRI
 S LRRPS=Y
 K DIR,DIRUT
 S DIR("A")="Select End Date: "
 S DIR(0)="DOA^:"_DT D ^DIR
 G:$D(DIRUT) DATE
 S LRRPE=Y
RORS ;REPORT OR SPREADSHEET
 K DIR,DIRUT
 S DIR(0)="SO^1:REPORT;2:SPREADSHEET"
 D ^DIR
 G:$D(DIRUT) DATE
 S LRREP=Y
 W !!
 I LRREP=1,$D(^XTMP("LREPILOCALREP"_LRLRDT)) D  G EXIT
 .W !,"Data already exists for this date and time.  Please try again later."
 I LRREP=2,$D(^XTMP("LREPILOCALSPSHT"_LRLRDT)) D  G EXIT
 .W !,"Data already exists for this date and time.  Please try again later."
 D SEG G:$D(DIRUT) RORS
TITLE K DIR,DIRUT
 S DIR(0)="F^3:30",DIR("A")="DOCUMENT TITLE"
 D ^DIR
 G:$D(DIRUT) RORS
 S ^XTMP("LREPI"_$S(LRREP=1:"LOCALREP",1:"LOCALSPSHT")_LRLRDT,"TITLE")=Y
 D TASK,HOME^%ZIS
EXIT ;
 K D0,J,LRALL,LRAUTO,LRBEG,LRCYCLE,LRDT,LREND,LREPI,LRMSG,LROK,LROVR
 K LRDUZ,LRRNDT,LRRPE,LRREP,LRRPS,LRRTYPE,LRY,ZTSAVE
 K ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK,X,Y,X1,%DT
 K LRLC,LRHDG,LRPROT,LRLRDT
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,LRSEG
 K ^TMP($J)
 Q
 ;
TASK ;LETS TASK THIS JOB
 Q:'$D(LREPI)
 W !!
 S LRDUZ=DUZ
 K ZTSAVE
 S ZTSAVE("LRRTYPE")="" S:LRRTYPE=0 ZTDTH=DT
 S ZTSAVE("LR*")=""
 S ZTIO="",ZTRTN="EN^LREPI",ZTDESC="Laboratory EPI local spreadsheet/report-generate"
 D ^%ZTLOAD
 I '$D(ZTQUEUED)&($D(ZTSK)) W @IOF,!!,"The Task has been queued",!,"Task # ",$G(ZTSK) H 5
 Q
PICKALL ;SELECT ALL ASSOCIATED PARAMETERS
 S Y=0 F  S Y=$O(^LAB(69.5,Y)) Q:+Y'>0  D CHK S:LROK LREPI(Y)=""
 Q
LOCALL ;SELECT ALL LOCAL PATHOGENS
 S Y=99 F  S Y=$O(^LAB(69.5,Y)) Q:Y'>0  D CHK S:LROK LREPI(Y)=""
 Q
CHK ;CHECK TO SEE IF ITS OK
 S:'$D(LRCYCLE) LRCYCLE=$P(^LAB(69.5,Y,0),U,5)
 S LROK=1
 S:($P(^LAB(69.5,Y,0),U,2)="1") LROK=0 Q
 S:$P(^LAB(69.5,Y,0),U,7)="" LROK=0 Q
 S:'$D(^ORD(101,$P(^LAB(69.5,Y,0),U,7),0)) LROK=0 Q
 S:$P(^LAB(69.5,Y,0),U,5)=LRCYCLE LROK=0 Q
 Q
ALL K DIR,DIRUT
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Include All "_LRMSG
 S DIR("?")="Enter (Y)es or return to individually select pathogens."
 D ^DIR
 S LRALL=+Y
 Q
SEG ;CHOOSE SEGMENTS FOR SPREADSHEET
 W !,"Choose the segments to capture for ",$S(LRREP=1:"report.",1:"spreadsheet.")
 W !,"1-PID"
 W !,"2-PV1"
 W !,"3-DG1"
 W !,"4-NTE"
 W !,"5-OBR"
 W !,"6-OBX"
 K DIR,DIRUT
 S DIR(0)="L^1:6"
 D ^DIR
 Q:$D(DIRUT)
 S LRY=Y
 I LRY[1 S LRSEG("PID")=1 D
 .W !!
 .W !,"Choose the fields from the PID segment to capture for ",$S(LRREP=1:"report.",1:"spreadsheet.")
 .W !,"1-Set Id"
 .W !,"2-SSN"
 .W !,"3-MPI"
 .W !,"4-Patient Name"
 .W !,"5-Date of Birth"
 .W !,"6-Sex"
 .W !,"7-Race"
 .W !,"8-Homeless"
 .W !,"9-State"
 .W !,"10-Zip Code"
 .W !,"11-County"
 .W !,"12-Ethnicity"
 .W !,"13-Period of Service"
 .K DIR,DIRUT
 .S DIR(0)="L^1:13"
 .D ^DIR
 .Q:$D(DIRUT)
 .F I=1:1:13 I Y[I S LRSEG("PID",I)=""
 I LRY[2 S LRSEG("PV1")=1 D
 .W !,"Choose the fields from the PV1 segment to capture for ",$S(LRREP=1:"report.",1:"spreadsheet.")
 .W !,"1-Set Id"
 .W !,"2-Patient Class"
 .W !,"3-Hospital Location"
 .W !,"4-Discharge Disposition"
 .W !,"5-Facility"
 .W !,"6-Admit Date/Time"
 .W !,"7-Discharge Date/Time"
 .K DIR,DIRUT
 .S DIR(0)="L^1:7"
 .D ^DIR
 .Q:$D(DIRUT) 
 .F I=1:1:7 I Y[I S LRSEG("PV1",I)=""
 I LRY[3 S LRSEG("DG1")=1 D
 .W !,"Choose the fields from the DG1 segment to capture for ",$S(LRREP=1:"report.",1:"spreadsheet.")
 .W !,"1-Set Id"
 .W !,"2-Diagnosis Code"
 .W !,"3-Diagnosis"
 .W !,"4-Admission Date"
 .K DIR,DIRUT
 .S DIR(0)="L^1:4"
 .D ^DIR
 .Q:$D(DIRUT)
 .F I=1:1:4 I Y[I S LRSEG("DG1",I)=""
 I LRY[4 S LRSEG("NTE")=1 D
 .W !,"Choose the fields from the NTE segment to capture for ",$S(LRREP=1:"report.",1:"spreadsheet.")
 .W !,"1-Set Id"
 .W !,"2-Comment"
 .K DIR,DIRUT
 .S DIR(0)="L^1:2"
 .D ^DIR
 .Q:$D(DIRUT)
 .F I=1:1:2 I Y[I S LRSEG("NTE",I)=""
 I LRY[5 S LRSEG("OBR")=1 D
 .W !,"Choose the fields from the OBR segment to capture for ",$S(LRREP=1:"report.",1:"spreadsheet.")
 .W !,"1-Set Id"
 .W !,"2-Test Name"
 .W !,"3-Accession Date"
 .W !,"4-Specimen"
 .W !,"5-Accession Number"
 .K DIR,DIRUT
 .S DIR(0)="L^1:5"
 .D ^DIR
 .Q:$D(DIRUT)
 .F I=1:1:5 I Y[I S LRSEG("OBR",I)=""
 I LRY[6 S LRSEG("OBX")=1 D
 .W !,"Choose the fields from the OBX segment to capture for ",$S(LRREP=1:"report.",1:"spreadsheet.")
 .W !,"1-Set Id"
 .W !,"2-Value Type"
 .W !,"3-Test Name"
 .W !,"4-LOINC Code"
 .W !,"5-LOINC Name"
 .W !,"6-Test Result"
 .W !,"7-Units"
 .W !,"8-Abnormal Flags"
 .W !,"9-Verified Date/Time"
 .K DIR,DIRUT
 .S DIR(0)="L^1:9"
 .D ^DIR
 .Q:$D(DIRUT)
 .F I=1:1:10 I Y[I S LRSEG("OBX",I)=""
 Q
