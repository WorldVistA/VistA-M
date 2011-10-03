PSXRSUS ;BIR/WPB,BAB,HTW-CMOP Transmission Handler ;15 Dec 2001
 ;;2.0;CMOP;**2,3,24,23,26,28,41,57,48**;11 Apr 97
 ;Reference to ^PS(52.5 supported by DBIA #1978
 ;Reference to ^PS(59   supported by DBIA #1976
 ;Reference to routine DEV1^PSOSULB1 supported by DBIA #2478
 ;
 ;Select CMOP Rx data from File 52.5,build HL7 segments,
 ;and transmit data
 ; This routine is called from PSOSULB1 'Print from Suspense'
 ;
START I '$D(^XUSEC("PSXCMOPMGR",DUZ)) W !,"You are not authorized to use this option!" Q
 I '$D(^XUSEC("PSX XMIT",DUZ)) W !,"You are not authorized to use this option!" Q
 S (PSXFLAG,PSXTRANS)=0
 L +^PSX(550.1):3 I '$T W !,"A lock on the RX QUEUE file was not obtainable. A transmission is in progress, try later." Q
 ; lock on 550.1 obtainable, clear flags
 I $D(^PSX(550,"TR","T")) F  S PSXSYS=$O(^PSX(550,"TR","T",0)) Q:PSXSYS'>0  S PSXSTAT="H" D PSXSTAT^PSXRSYU
 D SET^PSXSYS
 S STATUS=$P($G(^PSX(550,+PSXSYS,0)),"^",3) I STATUS'="H" W !,STATUS," no Manual Transmission nor Print CMOP Suspense allowed at this time" G EXIT
QRY W ! K DIR
 S DIR(0)="NAO^1:5",DIR("A")="Select (1, 2, 3, 4, 5):  "
 S DIR("A",1)="  1 - Initiate Standard CMOP Transmission"
 S DIR("A",2)="  2 - Initiate CS CMOP Transmission"
 S DIR("A",3)="  3 - Print Current Division -  Standard CMOP from Suspense"
 S DIR("A",4)="  4 - Print Current Division -  CS CMOP from Suspense"
 S DIR("A",5)="  5 - Standard Print from Suspense"
 S DIR("A",6)=" "
 S DIR("?")="Enter a number between 1 and 5.",DIR("??")="^D MSG1^PSXRHLP" D ^DIR I (Y<0)!($D(DIRUT)) K DIR G EXIT
 W !!,DIR("A",X),!
 S REPLY=X K Y,X
 K DIRUT,DTOUT,DUOUT,DIROUT,DIR
DIRECT ;Set PSXCS, PSXTRANS & PSXFLAG as per user choice
 I REPLY="5" G DEV1^PSOSULB1
 I "24"[REPLY S PSXCS=1
 I "12"[REPLY S (PSXTRANS,PSXFLAG)=1
 I "34"[REPLY S PSXFLAG=2
 K REPLY
 ;
ASK ;Ask 'all divisions y/n' & date range for data transmission & checks for data
 W !
 ;ask all divisions y/n
 I PSXFLAG=2 S PSXDIVML=0 G ASK2
 K DIR S DIR(0)="Y",DIR("A")="Transmit Data for All Divisions ? ",DIR("B")="YES"
 S DIR("?",1)="Yes - Transmit/Print All Divisions"
 S DIR("?")="No  - Transmit/Print One Division:   "_$$GET1^DIQ(59,PSOSITE,.01)
 D ^DIR K DIR
 G:(Y<0)!($D(DIRUT)) EXIT
 N PSXDIVML S PSXDIVML=+Y
ASK2 W !
 S %DT="AEX",%DT("A")=$S(PSXFLAG=1:"TRANSMIT CMOP DATA THRU DATE:  ",PSXFLAG=2:"PRINT CMOP LABELS THRU DATE:  ",1:0),%DT("B")="TODAY" D ^%DT K %DT,%DT("A"),%DT("B")
 S:Y<0 PFLAG=1 G:Y<0 EXIT
 S (PDT,PRTDT,TPRTDT)=Y K Y S Y=PDT X ^DD("DD") S PDT=Y K Y
 S CHKDT=$O(^PS(52.5,"AQ","")) I CHKDT>PRTDT W !!,$S(PSXFLAG=1:"NOTHING THRU THIS DATE TO TRANSMIT.",PSXFLAG=2:"NOTHING THRU THIS DATE TO PRINT.",1:0) S PFLAG=1 G EXIT
 I '$O(^PS(52.5,"AQ",0)) W !!,$S(PSXFLAG=1:"NOTHING THRU THIS DATE TO TRANSMIT.",PSXFLAG=2:"NOTHING THRU THIS DATE TO PRINT.",1:0) S PFLAG=1 G EXIT
 ;
 W ! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you wish to continue" D ^DIR K DIR S STOP=Y G:Y=0!($D(DIRUT))!($D(DUOUT)) EXIT K Y
 S PSXSTAT="T" D PSXSTAT^PSXRSYU S PFLAG=0 I $G(PSXLOCK)>0 G EX1
 ;
DRIV ;calls the remaining routines to build the data for transmission and
 S PSXDAYS=$P(PSOPAR,"^",27),X1=TPRTDT,X2=PSXDAYS D C^%DTC S PSXDTRG=X K X,X1,X2
 S PSXVENDR=$S($P(^PSX(550,+$G(PSXSYS),0),"^")["HINE":"SI BAKER",$P(^PSX(550,+$G(PSXSYS),0),"^")["MURF":"SI BAKER",1:"ELECTROCOM")
 ;set up queue device PSX or printer
 I PSXFLAG=2 D BEGIN^PSXRPPL G:$G(POP) EXIT ;select printer PSLION
QUE ; QUEUE the group/individual PSOSITE jobs for trans or the single job for print labels one division
 S PSXDESC="CMOP "_$S($G(PSXCS)=1:"CS ",1:"NON-CS ")_"Transmission"
 ;
 S ZTDESC=$S(PSXFLAG=1:$G(PSXDESC),PSXFLAG=2:"Print CMOP Suspense",1:"")
 S:PSXFLAG=1 ZTIO="",ZTRTN="TRANDIVS^PSXRSUS"
 S:PSXFLAG=2 ZTIO=PSLION,ZTRTN="PRT^PSXRSUS"
 ;
 S PSXDUZ=DUZ,(PSOINST,PSXSITE)=+$P($G(PSXSYS),U,2)
 S ZTDTH=$H
 F X="PSXDIVML","PSOSITE","PSOLAP","PSOSYS","PSOPAR","PSXSYS","DUZ","PSXTRANS","PSXFLAG","PRTDT","PSOINST","PSXDUZ","PSXSITE","PSXVER" S ZTSAVE(X)=""
 F X="PSXCS","PSXDAYS","PSXDTRG","PSOBARS","PSOBAR1","PSOBAR0","PSOPROP","PSXVENDR","PSLION","TPRTDT" S ZTSAVE(X)=""
 ;
 K ZTSK
 D ^%ZTLOAD ;****TESTING switch to tasking vs foreground
 W:$G(ZTSK) !,"Tasked ",ZTSK H 4
 ;D @ZTRTN ;****TESTING run foreground, comment out above two lines
 Q
 ;
TRANDIVS ;Entry from transmission tasking; loop all divisions / or process only 1
 ;process/transmit all divisions
LOCK ; >>>**** LOCK OF FILE 550.1 ****<<<
 F I=1:1:3 L +^PSX(550.1):10 I $T S I=100
 I I'=100 D CANMSG G EXIT ; could not get a lock in 18 minutes of waiting
 D STOREVAR^PSXRSUS1 ; store critical variables
 I $D(^PSX(550.2,"AQ")) D EN1^PSXRCVRY
 I PSXDIVML N PSOSITE,PSOPAR D  G EXIT
 . S PSOSITE=0 F  S PSOSITE=$O(^PS(59,PSOSITE)) Q:PSOSITE'>0  D
 .. I '$D(^XTMP("PSXAUTOERR")) N $ETRAP,$ESTACK S $ETRAP="D TRAPERR^PSXRSUS"
 .. D RESETVAR^PSXRSUS1 ;retrieve critical variables
 .. S PSOPAR=^PS(59,PSOSITE,1),PRTDT=TPRTDT
 .. S PSXDAYS=$P(PSOPAR,"^",27),X1=PRTDT,X2=PSXDAYS D C^%DTC S PSXDTRG=X K X,X1,X2 ;adjusts variables per divisional parameters.
 .. D TRANS
 ; process a single division
 D
 . I '$D(^XTMP("PSXAUTOERR")) N $ETRAP,$ESTACK S $ETRAP="D TRAPERR^PSXRSUS"
 . D TRANS
 G EXIT
 ;
 ;Called by Taskman to build CMOP PRINT data
TRANS ;;Called by PSXAUTO Taskman to begin CMOP transmissions one division
 S PSXZTSK=$G(ZTSK),PSXERFLG=0,PSXDUZ=DUZ
 S PSXTST=0,PSXIN=$$GET1^DIQ(59,PSOSITE,2004,"I")
 S:PSXIN'=""&(PSXIN<(DT+.1)) PSXTST=1
 Q:PSXTST  ;division inactivated
 ;VMP OIFO BAY PINES;ELR;PSX*2*57 CK IF ALL NECESSARY ELEMENTS OF DIVISION ARE HERE
 NEW PSXDIVER S PSXPRECK=1 D DIV^PSXBLD1 K PSXPRECK I $G(PSXDIVER) Q
 S PSXSTAT="T" D PSXSTAT^PSXRSYU
 I $G(PSXCS)=1 S X=$$FMADD^XLFDT(DT,+2) S ^XTMP("PSXCS"_PSOSITE,0)=X_U_DT_U_"CMOP CS TRANSMISSION"
 D SDT^PSXRPPL I PSXERFLG=1 S PSXJOB=7 D ^PSXERR
 I '$G(PSXBAT) D OERRCLR Q  ;no RXs found nor loaded into 550.2
RTR ;
 ;Clear 550.1 of entries (INSURE NO MERGE) prior to transmission
 K DIK,DA S DIK="^PSX(550.1,",DA=0 F  S DA=$O(^PSX(550.1,DA)) Q:DA'>0  D ^DIK ;****TESTING
 D EN^PSXBLD ; build entries into 550.1 by alpha patient
 I PSXERFLG=1 S PFLAG=1 D EN^PSXERR
 D EN^PSXRTR ;complete and send mailman message to CMOP
 ;Clear 550.1 of entries (INSURE NO MERGE) after transmission complete
 K DIK,DA S DIK="^PSX(550.1,",DA=0 F  S DA=$O(^PSX(550.1,DA)) Q:DA'>0  D ^DIK ;****TESTING
 D OERRCLR
 Q
PRT ; print from CMOP suspense
 F I=1:1:3 L +^PSX(550.1):60 I $T S I=100
 I I'=100 D CANMSG G EXIT ; could not get a lock in 3 minutes of waiting
 ; set auto error trapping
 D
 . I '$D(^XTMP("PSXAUTOERR")) N $ETRAP,$ESTACK S $ETRAP="D PRTERR^PSXRPPL1"
 . D PRT1
 D OERRCLR
 G EX1
PRT1 S ZTREQ="@",PSXERFLG=0,NFLAG=2
 D SDT^PSXRPPL
 I $G(PSXBAT),$D(^PSX(550.2,PSXBAT,15)) D PRT^PSXRPPL
 I PSXERFLG=1 S PSXJOB=7 D ^PSXERR
 ;remove the batch from the transmission file as it was used only to hold the RXs for printing and not transmission
 I $G(PSXBAT) K DIK,DA S DA=PSXBAT,DIK="^PSX(550.2," D ^DIK K DIK,DA ;****TESTING
 G EX1
EXIT ;
 I $G(POP) S PSXSTAT="H" D PSXSTAT^PSXRSYU ;exit from 'no printer selected' of print labels CMOP
 ;I $G(PFLAG)=1 S PSXSTAT="H" D PSXSTAT^PSXRSYU
 K DA,DIE,DR
 S DA=+PSXSYS,DIE="^PSX(550,",DR="9///@"
 L +^PSX(550,DA):600 D ^DIE L -^PSX(550,DA)
 K DA,DIE,DR
 S PSXSTAT="H" D PSXSTAT^PSXRSYU
EX1 K ^PSX("CMOP TRAN")
 K CNAME,DFN,FILNUM,PNAME,PSXDAYS,PSXDTRG,^TMP($J,"PSX"),J,Y
 K PSXPTR,REC,REF,REPLY,SDT,X,X1,X2,Y,ANSWER,PSXOK,RXNUM,PSXSITE,DIR,DIRUT,DTOUT,DUOUT,DIROUT,PSXCS,TXT,TEXT
 K XDFN,STATUS,PSXSTAT,^TMP($J,"PSXDFN"),PDT,PSXDUZ,SITE,CHKDT,PSXERFLG,PSXRXERR,RXEX,FDATE,PSXJOB,PFLAG,PSXZTSK,PSXVENDR,ORSUB,ORST
 L -^PSX(550.1)
 Q
OERRCLR ; clear any locks left in ^XTMP("OERR-"
 S (ORST,ORSUB)="ORLK-"
 F  S ORSUB=$O(^XTMP(ORSUB)) Q:ORSUB'[ORST  I ^XTMP(ORSUB,0)["CPRS/CMOP" K ^XTMP(ORSUB)
 Q
CANMSG ; lock on 550.1 not achieved send transmission/print cancelled message
 S PSXCS=+$G(PSXCS)
 S XMSUB=$S($G(PSXCS):"",1:"NON-")_"CS Manual Scheduled Transmission Canceled"
 S:PSXFLAG=2 XMSUB="Print CMOP Suspense Cancelled."
 S XMTEXT="TXT("
 S TXT(1,0)="The "_$S($G(PSXCS):"",1:"NON-")_"CS Manual Transmission was cancelled"
 S:PSXFLAG=2 TXT(1,0)="Print from CMOP Suspense was cancelled"
 S TXT(2,0)="It could not obtain a lock on the RX QUEUE file. #550.1"
 S TXT(3,0)="This indicates that a transmission was in progress."
 S TXT(6,0)=" "
 S TXT(7,0)="If you are getting this message frequently, please contact your IRM Group"
 D GRP1^PSXNOTE
 ;S XMY(DUZ)=""
 D ^XMD
 Q
TRAPERR ; trap/process error
 S XXERR=$$EC^%ZOSV
 S PSXDIVNM=$$GET1^DIQ(59,PSOSITE,.01)
 ;save an image of the transient file 550.1 for 2 days
 D NOW^%DTC S DTTM=%
 ;VMP OIFO BAY PINES;ELR;PSX*2*57 CHANGE PURGE DAYS TO T+12 FROM T+2
 S X=$$FMADD^XLFDT(DT,+12) S ^XTMP("PSXERR "_DTTM,0)=X_U_DT_U_"CMOP "_XXERR
 M ^XTMP("PSXERR "_DTTM,550.1)=^PSX(550.1)
 S XMSUB="CMOP Error "_PSXDIVNM_" "_$$GET1^DIQ(550.2,+$G(PSXBAT),.01)
 D GRP1^PSXNOTE
 ;S XMY(DUZ)=""
 S XMTEXT="TEXT("
 S TEXT(1,0)=$S($G(PSXCS):"",1:"NON-")_"CS CMOP Transmission encountered the following error. Please investigate"
 S TEXT(2,0)="Division:         "_PSXDIVNM
 S TEXT(3,0)="Type/Batch        "_$S($G(PSXCS):"CS",1:"NON-CS")_" / "_$$GET1^DIQ(550.2,+$G(PSXBAT),.01)
 S TEXT(4,0)="Error:            "_XXERR
 S TEXT(5,0)="The prescriptions have been reset and other divisions' transmissions are continuing."
 S TEXT(6,0)="A copy of the file 550.1 can be found in ^XTMP(""PSXERR "_DTTM_""")"
 D ^%ZTER
 D ^XMD
 ;I $E(IOST)="C" F XX=1:1:5 W !,TEXT(XX,0)
 S PSXXDIV=PSOSITE
 D EN1^PSXRCVRY ;hopefully no errors will be experienced in recovery
 S PSOSITE=PSXXDIV
 G UNWIND^%ZTER
 Q
STOPET ;disable auto error trapping
 S ^XTMP("PSXAUTOERR",0)=DT_U_DT_U_"disable PSX CMOP auto error trapping for today"
 Q
STARTET ;enable auto error trapping
 K ^XTMP("PSXAUTOERR",0)
 Q
