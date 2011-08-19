PSXDUAL ;BIR/HTW - Host Interface Startup ;Compiled 1998-12-05 11:25AM for M/WNT [ 02/16/99  10:15 AM ]
 ;;2.0;CMOP;**17**;11 Apr 97
 K PSXONE
 S PSXQRY=$P($G(^PSX(553,1,"Q")),"^")
 I (PSXQRY="S")!(PSXQRY="") W !,"The Query Interface is stopped!!",! G QUERY
 I PSXQRY="R" W !,"The Query Interface is already running!!",!
 S DIR("A")="Do you want to Stop the Query",DIR("B")="NO"
 S DIR(0)="SB^Y:YES;N:NO",DIR("?")="The Query interface is running. Answer Yes to stop it."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 K DIR I "Yy"[$E(Y) S ^PSX(553,1,"Q")="S" G EXIT
 Q
QUERY S DIR("A")="Do you want to Start the Query",DIR("B")="YES"
 S DIR(0)="SB^Y:YES;N:NO",DIR("?")="The Query interface is stopped. Answer Yes to start it."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 I "Nn"[$E(Y) G EXIT
 I "Yy"[$E(Y) S ^PSX(553,1,"Q")="R"
 S ZTIO="CMOPQ",ZTRTN="EN^PSXDUAL",ZTDTH=$H,ZTDESC="CMOP Query" D ^%ZTLOAD
 I $D(ZTSK) W !,"JOB QUEUED ",ZTSK
 G EXIT
 Q
EN S:'$D(^PSX(553,1,"X",0)) ^PSX(553,1,"X",0)="^553.01DA^^"
 S TERM=13,SOH=1,STX=2,ETB=23,ETX=3,EOT=4,ENQ=5,NAK=21,ACK=16
 S PSXABORT=0,ZCNT=1 D NOW^%DTC S XCNT=% K %
SETPAR ;Set parameters (TIMERS,LINE BID,RETRIES)
 S PSXPAR0=$G(^PSX(553,1,0)),PSXPART=$G(^PSX(553,1,"T"))
 S PSXDLTA=$P(PSXPART,"^"),PSXDLTB=$P(PSXPART,"^",2)
 S PSXDLTD=$P(PSXPART,"^",3),PSXDLTE=$P(PSXPART,"^",4)
 S PSXTRYM=$P(PSXPAR0,"^",6),PSXTRYL=$P(PSXPAR0,"^",5)
 S PSXQRYA=1
 ;change PSXVNDR to be the vendor system name, change the set on the MSH,BHS,QRD to use this variable
 S PSXVNDR=$S(^PSX(553,1,0)["MURF":2,^PSX(553,1,0)["HIN":2,^PSX(553,1,0)["CHAR":2,^PSX(553,1,0)["LEAV":1,1:0)
 D FLUSH1^PSXUTL
 G ^PSXYQRY
EXIT K PSXQRY Q
