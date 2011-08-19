PSOBAIRP ;BIR/RTR-Report of prescription mail labels with bad address ;08/16/2006
 ;;7.0;OUTPATIENT PHARMACY;**233,326**;DEC 1997;Build 11
 ;
EN ;
 N PSOFORM,PSOAPAT,PSOSDT,PSOEDT,PSOSDTX,PSOEDTX,X,Y,X1,X2
 W !!,"This option provides a report that shows patients and prescriptions whose last"
 W !,"label activity had a routing of mail and no valid permanent or temporary"
 W !,"address. It will also indicate whether the patient now has a good address.",!!
 K DIR S DIR(0)="SB^S:Single;A:All",DIR("A")="Print report for a Single patient, or All patients",DIR("B")="Single",DIR("?")=" ",DIR("?",1)="Enter 'S' to print address changes for one patient over the selected"
 S DIR("?",2)="date range, enter 'A' to print address changes for all patients",DIR("?",3)="over the selected date range."
 D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) D MESS Q
 S PSOFORM=$S(Y="S":1,1:0)
 I 'PSOFORM G DATE
 K DIC W ! S DIC(0)="QEAM",DIC("A")="Select PATIENT: " D EN^PSOPATLK S Y=PSOPTLK K DIC,PSOPTLK I Y<1!($D(DUOUT))!($D(DTOUT)) D MESS Q
 S PSOAPAT=+Y
DATE ;
 W !!
 W ! K %DT S %DT="AEX",%DT("A")="Start fill date: " D ^%DT K %DT I Y<0!($D(DTOUT))!($D(DUOUT)) D MESS Q 
 S (%DT(0),PSOSDT)=Y D DD^%DT S PSOSDTX=Y
 W ! S %DT="AEX",%DT("A")="End fill date: " D ^%DT K %DT I Y<0!($D(DTOUT))!($D(DUOUT)) D MESS Q
 S PSOEDT=Y D DD^%DT S PSOEDTX=Y
 S X1=PSOSDT,X2=-1 D C^%DTC S PSOSDT=X_".9999"
 S X1=PSOEDT,X2=+1 D C^%DTC S PSOEDT=X
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) D MESS Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="REP^PSOBAIRP",ZTDESC="Pharmacy bad address mail label report",ZTSAVE("PSOFORM")="",ZTSAVE("PSOAPAT")="",ZTSAVE("PSOSDT")="",ZTSAVE("PSOEDT")="",ZTSAVE("PSOEDTX")="",ZTSAVE("PSOSDTX")="" D ^%ZTLOAD K %ZIS
 .W !!,"Report queued to print.",!
REP ;
 K ^TMP("PSOBADL",$J)
 N PSODEV,PSOUT,PSOLINE,PSOPAGE,PSOADND,PSOADF,PSOADFF,PSOAOPT,PSOAOPTA,PSOAOPTZ,PSOAOPTB,PSOAOPTC,PSOADLP,PSOANODE,PSOADX,PSORX,PSOADATE,PSOC,PSOAALL,PSOADFN,PSOANAME,PSONI,PSONX,PSONB,PSOASN,VA,DFN,PSONSSN,PSOAFLAG
 U IO
 S (PSOUT,PSOAFLAG)=0,PSODEV=$S($E(IOST,1,2)'="C-":0,1:1),PSOPAGE=1
 S $P(PSOLINE,"-",78)=""
ALL ;Print report for all patients
 N PSORD,PSORX,PSOLBL,PSOX
 S PSORD=PSOSDT F  S PSORD=$O(^PSRX("AD",PSORD)) Q:'PSORD!(PSORD>PSOEDT)  D
 .S PSORX=0 F  S PSORX=$O(^PSRX("AD",PSORD,PSORX)) Q:'PSORX  D
 ..S PSOLBL=$O(^PSRX(PSORX,"L",999999),-1) I 'PSOLBL Q
 ..S PSOX=$G(^PSRX(PSORX,"L",PSOLBL,0)) I PSOX["(BAD ADDRESS",PSOX'["WINDOW" D
 ...S PSOADFN=$P($G(^PSRX(PSORX,0)),"^",2) Q:'PSOADFN
 ...I $G(PSOFORM),PSOADFN'=PSOAPAT Q
 ...S PSOANAME=$P($G(^DPT(PSOADFN,0)),"^") Q:PSOANAME=""
 ...S ^TMP("PSOBADL",$J,PSOANAME,PSOADFN,PSORD,PSORX)=""
 D HD
 I '$D(^TMP("PSOBADL",$J)) W !!,"No data found to print for this date range.",! G END
 S PSONI="" F  S PSONI=$O(^TMP("PSOBADL",$J,PSONI)) Q:PSONI=""!(PSOUT)  D
 .S PSONX="" F  S PSONX=$O(^TMP("PSOBADL",$J,PSONI,PSONX)) Q:PSONX=""!(PSOUT)  D NAME,PRALL D
 ..S PSONB="" F  S PSONB=$O(^TMP("PSOBADL",$J,PSONI,PSONX,PSONB)) Q:PSONB=""!(PSOUT)  D
 ...S PSORX="" F  S PSORX=$O(^TMP("PSOBADL",$J,PSONI,PSONX,PSONB,PSORX)) Q:PSORX=""!(PSOUT)  D
 ....I ($Y+5)>IOSL D HD Q:PSOUT
 ....S Y=PSONB D DD^%DT S PSOADATE=Y
 ....D PRONE
END ;
 K ^TMP("PSOBADL",$J)
 K DTOUT,DUOUT
 I '$G(PSOUT),PSODEV W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I 'PSODEV W !!,"End of Report."
 I PSODEV W !
 E  W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD ;
 I '$G(PSOFORM) S PSOAFLAG=1
 I PSODEV,PSOPAGE'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSOUT=1 Q
 I PSOPAGE=1,'PSODEV W ! I 1
 E  W @IOF
 D  W ?67,"PAGE: "_PSOPAGE S PSOPAGE=PSOPAGE+1
 .I PSOFORM W !,"Bad address mail label report for "_$G(PSOANAME) Q
 .W !,"Bad address mail label report for ALL Patients"
 W !,"for fill date between "_$G(PSOSDTX)_" and "_$G(PSOEDTX)
 W !,PSOLINE
 Q
MESS ;
 W !!,"Nothing queued to print.",!
 Q
NAME ;Set name(ssn)
 K VA S DFN=PSONX D PID^VADPT6
 S PSONSSN=$G(PSONI)_"   ("_$E(VA("PID"),5,12)_")"
 K VA
 Q
PRALL ;Print data for all patients
 N PSOADDR
 S PSOADDR=""
 S PSOAFLAG=0
 W !!,$G(PSONSSN) D CHKADDR W ?30,"  ",PSOADDR I ($Y+5)>IOSL D HD Q:PSOUT
 Q
PRONE ;Print data for one patient
 N PSORX0
 S PSORX0=$G(^PSRX(PSORX,0)) I PSORX0=""!($P(PSORX0,"^",6)="") Q
 D CON W !,$G(PSOADATE),?15," Rx#: ",$P(PSORX0,"^"),?30,"  ",$P($G(^PSDRUG($P(PSORX0,"^",6),0)),"^")
 I ($Y+5)>IOSL D HD Q:PSOUT
 Q
CON ;
 I PSOAFLAG,'PSOFORM W !,$G(PSONSSN) S PSOAFLAG=0
 Q
 ;
CHKADDR ;
 N PSOBADR,PSOTEMP
 I $G(PSONX)="" Q
 S PSOBADR=$$BADADR^DGUTL3(PSONX)
 I PSOBADR D
 .S PSOTEMP=$$CHKTEMP^PSOBAI(PSONX)
 I PSOBADR,'PSOTEMP S PSOADDR="** BAD ADDRESS **" Q
 S PSOADDR="PATIENT NOW HAS A VALID ADDRESS"
 Q
