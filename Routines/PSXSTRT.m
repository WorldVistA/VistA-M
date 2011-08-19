PSXSTRT ;BIR/BAB-Start Interface ;[ 03/10/99  11:08 AM ]
 ;;2.0;CMOP;**17**;11 Apr 97
START ;Start here when queued
 S:'$D(^PSX(553,1,"X",0)) ^PSX(553,1,"X",0)="^553.01DA^^"
 S TERM=13,SOH=1,STX=2,ETB=23,ETX=3,EOT=4,ENQ=5,NAK=21,ACK=16
 S PSXABORT=0,ZCNT=1 D NOW^%DTC S XCNT=% K %
 D SETPAR,PURG G STRT^PSXJOB
SETPAR ;Set parameters (TIMERS,LINE BID,RETRIES)
 S PSXPAR0=$G(^PSX(553,1,0)),PSXPART=$G(^PSX(553,1,"T"))
 S PSXDLTA=$P(PSXPART,"^"),PSXDLTB=$P(PSXPART,"^",2)
 S PSXDLTD=$P(PSXPART,"^",3),PSXDLTE=$P(PSXPART,"^",4)
 S PSXTRYM=$P(PSXPAR0,"^",6),PSXTRYL=$P(PSXPAR0,"^",5)
 S PSXVNDR=$S(^PSX(553,1,0)["MURF":1,^PSX(553,1,0)["HIN":2,^PSX(553,1,0)["CHAR":2,1:0)
 Q
PURG ;Purge CMOP log file
 S PSXPURG=0 F PSXCNT=1:1 S PSXPURG=$O(^PSX(553,1,"X",PSXPURG)) Q:'PSXPURG  I PSXCNT>1000 S DA=PSXPURG,DA(1)=1,DIK="^PSX(553,"_DA(1)_",""X""," D ^DIK
 K PSXCNT,PSXPURG,DA,DIK
 Q
QUE ;Entry point to queue interface background job
 I $P($G(^PSX(553,1,0)),"^")["LEAVENWORTH" G QUE^PSXYSTRT
 K PSXONE
 I $G(^PSX(553,1,"P"))="R" W !!,"INTERFACE CANNOT BE STARTED WHILE LABELS ARE PRINTING!......TRY LATER." Q
 L +^PSX(553,1,"S"):30 I '$T W !!,"The CMOP Interface file is in use, try later." Q
 I $P(^PSX(553,1,"S"),"^",1)="R" W !!,"INTERFACE is already RUNNING, or PURGE is in progress!" Q
 ;G ALL
ASK S DIR(0)="SM^A:All Transmissions Queued;S:Single Transmission;P:Prioritize Queue;Q:Query Request",DIR("??")="^D HELP^PSXSTRT",DIR("B")="A" D ^DIR K DIR G:$G(DTOUT)!($G(DUOUT)) EXIT G:"Aa"[X ALL G:"Pp"[X ^PSXQUE G:"Qq"[X QUERY
ONE K DIRUT,DUOUT,DTOUT,DIROUT,Y,X
 S DIC(0)="AEOX",DIC("A")="Enter Transmission Number: ",DIC="^PSX(552.1,",DIC("S")="I $P(^PSX(552.1,+Y,0),U,4)>0&($P(^PSX(552.1,+Y,0),U,2)=""2""),($D(^PSX(552.1,""AQ"",$P(^PSX(552.1,+Y,0),U,4),X,+Y)))"
 D ^DIC K DIC S TRAN=+Y,PSXONE=$G(X) I Y'>0!($D(DTOUT))!($D(DUOUT)) K PSXIN G EXIT
 K DUOUT,DTOUT,Y
 S DIR(0)="Y",DIR("A")="Download Transmission "_$G(X),DIR("B")="YES" D ^DIR K DIR I Y'>0!($G(DTOUT))!($D(DUOUT))!($D(DIROUT))!($D(DIRUT)) K PSXIN G EXIT
 S ZTSAVE("PSXONE")=""
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT,Y,X,TRAN
ALL S ^PSX(553,1,"S")="R",PSXIN=1
 L -^PSX(553,1,"S")
 U IO(0) W !!,?10,"*** Interface STARTED ***"
 S ZTIO="CMOP",ZTRTN="START^PSXSTRT",ZTDTH=$H,ZTREQ="@"
 S ZTDESC="CMOP Interface"
 D ^%ZTLOAD
EXIT K ACK,ENQ,EOT,ETB,ETX,NAK,PSXABORT,PSXDLTA,PSXDLTB,PSXDLTD,PSXDLTE,LOG,PSXTME,PSXTMOUT,PSXTRASH,TRAN,PSXONE,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,WAIT,INT,XZ,%,LQRYTM,NEXT,WAIT
 G:$G(PSXIN)>0 ^PSXHSYS
 Q
QUERY D NOW^%DTC S XZ=$P(^PSX(553.1,0),"^",3),INT=$P(^PSX(553,1,0),"^",9) S:$G(INT)'>0 INT=1
 I $G(XZ) S LQRYTM=$P(^PSX(553.1,XZ,0),"^",2) S NEXT=$$FMADD^XLFDT(LQRYTM,0,$G(INT),0,0) I %'>NEXT S WAIT=$$FMDIFF^XLFDT(NEXT,%,2) W !!,"Another query can not be initiated for ",($G(WAIT)\60)," minutes." G EXIT
 S PSXQRY=1,ZTSAVE("PSXQRY")="",PSXQRYA=1,ZTSAVE("PSXQRYA")="" G ALL
 Q
HELP W !,"A - All Transmissions Queued. Sends all transmissions in the queue to the",!,"vendor. The interface will NOT stop after all transmissions have been sent to",!,"the vendor system."
 W !!,"S - Single Transmission. Only sends the transmission selected to the vendor.",!,"The interface will stop when the transmission download has completed."
 W !!,"P - Prioritize Queue. Allows the user to establish a priority for sending",!,"transmissions to the vendor. The interface will NOT stop after all transmissions",!,"have been sent to the vendor."
 W !!,"Q - Query Request. Allows the user to initiate a query request. Once the query",!,"request is complete the interface stops."
 Q
