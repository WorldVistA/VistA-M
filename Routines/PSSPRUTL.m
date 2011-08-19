PSSPRUTL ;BIR/RTR-Edit IV Solution ;04/19/08
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
 ;
 ;
EDIT ;Edit IV Solution
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,DIC,DA,DR,DLAYGO,DIDEL,PSSEDSDA,PSSEDSXX,PSSEDSZZ,PSSEDSDR,PSSEDSGG,PSSEDSAR,DRUGEDIT
 ;Newing D in next line because FileMan is leaving it defined to a zero node upon option exit
 N %,%DT,D0,I,J,MSG,PSJCLEAR,PSPOINT,PSSIVID,SYNIEN,XX,PSSCROSS,D
 I '$D(^XUSEC("PSJI MGR",DUZ)) W !!!,"Sorry, you need the 'PSJI MGR' key to access this option.",! D MESS Q
 L +^PS(52.7):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I '$T W !!!,"Sorry, someone else is editing entries in the IV SOLUTIONS (#52.7) File.",! D MESS Q
EDITM ;
 K X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,DIC,DA,DR,DLAYGO,DIDEL,%,%DT,D0,I,J,MSG,PSJCLEAR,PSPOINT,PSSIVID,SYNIEN,XX,PSSCROSS,D
 ;Setting DRUGEDIT in next line because cross reference on GENERIC DRUG #1 Field of IV SOLUTION (#52.7) File needs it defined
 K PSSEDSDA,PSSEDSXX,PSSEDSZZ,PSSEDSDR,PSSEDSGG,PSSEDSAR S DRUGEDIT=1
 W ! K DIC,X,DTOUT,DUOUT S DIC="^PS(52.7,",DIC(0)="AEQMZ" D ^DIC K DIC,X I Y<0!($D(DUOUT))!($D(DTOUT)) D UN Q
 S PSSEDSDA=+Y,PSSEDSXX=$P($G(^PS(52.7,PSSEDSDA,0)),"^",11)
 K DIE,DA,DR S DIE="^PS(52.7,",DA=PSSEDSDA,DR=".01;.02;1;D GETD^PSSPRUTL;2;8;17;18" D ^DIE K DIE,DA,DR
 ;Change the Generic Drug could automatically change the Orderable Item of the IV Solution
 ;Now doing what MSF^PSSDFEE does, updating Orderable Items, though cross reference on 52.,7,1 should have already done it
 ;Just as a safeguard, we'll look to update all Orderable Items again, note that PSSEDSZZ and PSSEDSGG should never be different
 S PSSEDSZZ=$P($G(^PS(52.7,PSSEDSDA,0)),"^",11),PSSEDSDR=$P($G(^PS(52.7,PSSEDSDA,0)),"^",2),PSSEDSGG=$P($G(^PSDRUG(+PSSEDSDR,2)),"^")
 I PSSEDSZZ K PSSCROSS D EN^PSSPOIDT(PSSEDSZZ),EN2^PSSHL1(PSSEDSZZ,"MUP")
 I PSSEDSGG,PSSEDSGG'=PSSEDSZZ K PSSCROSS D EN^PSSPOIDT(PSSEDSGG),EN2^PSSHL1(PSSEDSGG,"MUP")
 ;I PSSEDSXX D EN^PSSPOIDT(PSSEDSXX),EN2^PSSHL1(PSSEDSXX,"MUP") S PSSEDSAR(PSSEDSXX)=""
 ;I PSSEDSZZ,'$D(PSSEDSAR(PSSEDSZZ)) D EN^PSSPOIDT(PSSEDSZZ),EN2^PSSHL1(PSSEDSZZ,"MUP") S PSSEDSAR(PSSEDSZZ)=""
 ;I PSSEDSGG,'$D(PSSEDSAR(PSSEDSGG)) D EN^PSSPOIDT(PSSEDSGG),EN2^PSSHL1(PSSEDSGG,"MUP") S PSSEDSAR(PSSEDSGG)=""
 W ! G EDITM
 ;D UN
 Q
UN ;Unlock File
 L -^PS(52.7)
 Q
 ;
GETD ;See if generic drug is inactive in file 50, code cloned from line tag GETD Of routine PSSVIDRG
 I $D(^PSDRUG(X,"I")),^("I"),(DT+1>+^("I")) W $C(7),$C(7),!!,"This drug is inactive and will not be selectable during IV order entry.",! S $P(^PS(52.7,PSSEDSDA,"I"),"^")=$P(^PSDRUG(X,"I"),"^")
 Q
 ;
MESS ;
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 Q
