PSXARC ;BIR/HTW-CMOP Master Database Archive [ 07/14/97  1:05 PM ]
 ;;2.0;CMOP;**1,4,46**;11 Apr 97
BEGDATE ;GET ARCHIVE DATE
 K ^TMP("PSX",$J) S LEN=8,CT=1
 S START=$O(^PSX(552.1,"AC",0)),START1=$E(START,1,5),START=$E(START,4,5)_"/"_$E(START,2,3)
 S TODAY=$E(DT,1,5)
 I TODAY=START1 W !,"There are no transmissions to be archived.",! G END
 S DIR("B")=START
 ;VMP IOFO-BAY PINES;ELR;PSX*2*46 ADDED EMP TO DIR(0)
 S DIR(0)="DO^::EMP",DIR("A")="ENTER MONTH/YEAR TO "_$S($G(PSXPURGE)=1:"PURGE ",1:"ARCHIVE ") D ^DIR K DIR
 G:($G(Y)="")!($D(DIRUT)) END
 Q:$D(DTOUT)  I $D(DUOUT) G BEGDATE
 I $E(Y,4,5)="00" W !!,"You must enter a month",!! D CLEAR G BEGDATE
 S PSXD=$E(Y,1,5)_"01",PSXBEE=$E(Y,1,5) X ^DD("DD") S PSXB=Y
 I TODAY=$E(PSXBEE,1,5) W !!,"You may not archive the current month's data.",!! D CLEAR G BEGDATE
 ;VMP IOFO-BAY PINES;ELR;PSX*2*46 NEW VERIFY QUESTION
 I $E(PSXBEE,1,5)>TODAY W !!," You may not archive a future month's data",!! D CLEAR G BEGDATE
 S DIR("A")="ARE YOU SURE YOU WANT TO "_$S($G(PSXPURGE)=1:"PURGE ",1:"ARCHIVE ")_PSXB
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 G:($G(Y)="")!($D(DIRUT)) END
 Q:$D(DTOUT)  I $D(DUOUT) D CLEAR G BEGDATE
 I '$G(Y) D CLEAR G BEGDATE
 ;Print selected transmissions for OK to archive
 W !?15,"CMOP MASTER DATABASE "_$S($G(PSXPURGE)=1:"PURGE ",1:"ARCHIVE"),!!
 F  S PSXD=$O(^PSX(552.1,"AC",PSXD)) Q:($G(PSXD)']"")!(PSXD'[PSXBEE)  D  Q:$G(ANS)]""
 .S BATCH="" F  S BATCH=$O(^PSX(552.1,"AC",PSXD,BATCH)) Q:($G(BATCH)']"")  D  Q:$G(ANS)]""
 ..S TOTBAT=$G(TOTBAT)+1
 ..S BAT=$P(BATCH,"-")_$P(BATCH,"-",2),I5521=$O(^PSX(552.1,"AC",PSXD,BATCH,""))
 ..I '$D(^PSX(552.1,I5521,0)) K ^PSX(552.1,"AC",PSXD,BATCH,I5521) Q
 ..S TOTORD=$G(TOTORD)+$P(^PSX(552.1,I5521,1),"^",3)
 ..S TOTRX=$G(TOTRX)+$P(^PSX(552.1,I5521,1),"^",4)
 ..S I5524=$O(^PSX(552.4,"B",I5521,""))
 ..I $G(PSXPURGE)=1 S BAT=I5521
 ..S ^TMP("PSX",$J,BAT)=I5521_"^"_I5524_"^"_BATCH
 ..S LEN=LEN+$L(BATCH)+1
 ..I IOST["C-",($Y>20),($X>63) D  Q:$G(ANS)]""  W @IOF
 ...K DIR S DIR(0)="FO",DIR("A")="Press RETURN to continue or ""^"" to exit" D ^DIR S:$D(DTOUT)!($D(DUOUT)) (ANS)="^"
 I '$D(^TMP("PSX",$J)) W !!,"No closed transmissions found for the month requested.",!! G BEGDATE
 W !,"Total transmissions to be ",$S($G(PSXPURGE)=1:"purged  : ",1:"archived: "),TOTBAT
 W !,"Total orders to be ",$S($G(PSXPURGE)=1:"purged         : ",1:"archived       : "),TOTORD
 W !,"Total Rx's to be ",$S($G(PSXPURGE)=1:"purged           : ",1:"archived         : "),TOTRX
 K ANS,BAT,BATCH,CT,DIR,I,I5521,I5524,LEN,PAD,PSX,PSXB,PSXD,START
 K TOTBAT,TOTRX,TOTORD,Y
 W !!
 S DIR("A")="Do you want to continue? ",DIR("B")="NO"
 S DIR(0)="SB^Y:YES;N:NO",DIR("?")="Enter Y if you want to "_$S($G(PSXPURGE)=1:"purge",1:"archive")_" the selected transmission data."
 D ^DIR K DIR G:$D(DIRUT) END G:("Nn"[$E(Y)) END
 ;Set default values for home device
 S PSXIOF=IOF,PSXTAPE=PSXBEE_"1"
 ;    Check archive file for duplicate tape #'s
TAPECK I $O(^PSXARC("C",PSXTAPE,"")) S PSXTAPE=$E(PSXTAPE,1,5)_$E(PSXTAPE,6)+1 G TAPECK
 I $G(PSXPURGE)=1 G PURGE
MOUNT I $G(PSXRPT)=1 U IO(0) W !!,"Please mount tape #: ",PSXTNO
 I  W !,"Press Return when ready..." R XX:DTIME I '$T!($G(XX)["^") S PSXERR=1 Q
 ;
TAPE W !! S %ZIS("A")="Select Tape Drive: ",%ZIS("B")=""
 D ^%ZIS K %ZIS("A") I POP S PSXERR=1 G END
 I IOST'["MAGTAPE" D ^%ZISC W !,"You must select a MAGTAPE device! " G TAPE
 X ^%ZOSF("MAGTAPE") S PSXT=IO,PSXTBS=IOBS,PSXTIOF=IOF,PSXAM=IOM,PSXTPAR=IOPAR
 U PSXT X ^%ZOSF("MTONLINE") I $G(Y)'=1 S PSXERR=1 U IO(0) W !,"Tape drive not online.  Please correct and try again.",! K PSXT,PSXTBS,PSXTIOF,PSXAM,PSXTPAR,Y G TAPE
 K PSXERR
 U PSXT W @%MT("REW")
 D END Q:$G(PSXRPT)=1  G ^PSXARC1
END K BAT,BATCH,DA,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,I,I5521,I5524,PAD,PAD1,POP
 K PSX,PSXB,PSXD,PSXE,PSXEE,START1,TODAY,XX,Y,PSXPURGE
 Q
 ;**********************************************************************
PURGE ; This option purges the data from files 552.1 (CMOP REFERENCE) and
 ; 552.4 (CMOP MASTER DATABASE).  It will only purge those entries
 ; that have been marked as archived.
 F Z=0:0 S Z=$O(^TMP("PSX",$J,Z)) Q:'Z  S ZZ=^TMP("PSX",$J,Z) D P1
 D ^%ZISC
 K I521,I524,I555,PSXBEE,PSXIOF,PSXPURGE,PSXTAPE
 K ^TMP("PSX",$J),Z,ZX,ZZ
 G END
P1 S I521=$P(ZZ,"^"),I524=$P(ZZ,"^",2),BATCH=$P(ZZ,"^",3)
 I '$G(I524) G K5521
 I '$D(^PSX(552.4,I524)) G K5521
 I '$D(^PSX(552.1,I521,"-9")) W !,"Transmission# "_BATCH_" has not been archived yet and may not be purged." Q
 I $D(^PSX(552.4,I524,"-9")) K ^PSX(552.4,I524,"-9")
 S DIK="^PSX(552.4,",DA=I524 D ^DIK K DIK
K5521 I '$G(I521) Q
 I '$D(^PSX(552.1,I521)) Q
 K ^PSX(552.1,I521,"-9")
 S DIK="^PSX(552.1,",DA=I521 D ^DIK K DIK
 S I555=$O(^PSXARC("B",BATCH,""))
 S DIE=555,DA=I555,DR="4////1" D ^DIE K DIE,DA,DR
 W !,"Transmission #: "_BATCH_" has been purged."
 Q
PEN S PSXPURGE=1 G PSXARC
 Q
 ;VMP IOFO-BAY PINES;ELR;PSX*2*46
CLEAR K DIR,DIRUT,DTOUT,DUOUT,PSXB,PSXD,PSXBEE,START,START1,TODAY
 Q
