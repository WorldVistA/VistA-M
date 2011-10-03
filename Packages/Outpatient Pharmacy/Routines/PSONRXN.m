PSONRXN ;IHS/DSD/JCM - GETS NEXT VALID RX NUMBER ;08/09/93 9:17
 ;;7.0;OUTPATIENT PHARMACY;**5,25,166,268**;DEC 1997;Build 9
 ;
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^DIC supported by DBIA 10006
 ;External reference to ^DIE supported by DBIA 10018
 ;External reference to ^DIR supported by DBIA 10026
 ;External reference to ^VALM1 supported by DBIA 10016
 ;External reference to ^DPT( supported by DBIA 10035
 ;
 ; This routine asks for the next rx # if manually assigning rx#
 ; and gets next rx# if auto numbering.
 ;
 ;-------------------------------------------------------------------
 ;
MANUAL ; Entry Point to ask user for new rx #
 ;
 S PSONEW("DFLG")=0
 K DIR S DIR(0)="52,.01O"
 S DIR("A")="Select New Rx # for "_$S($G(PSORX("NAME"))]"":PSORX("NAME"),1:"")
 I $G(PSONEW("RX #"))]"",'$G(COPY) S DIR("B")=PSONEW("RX #")
 D DIR^PSODIR2 K DIR,DIC,DIE,DA
 I X="" S PSONEW("QFLG")=1 G MANUALX
 I "Pp"[Y K Y D ^PSODSPL G MANUAL
 I "Rr"[Y K Y S (PSONEW("QFLG"),PSORX("DO REFILL"))=1 G MANUALX
 I $G(PSODIR("DFLG"))=1 S (PSONEW("QFLG"),PSORX("QFLG"))=1 G MANUALX
 G:$G(PSONEW("FIELD")) MANUALX
 S PSOX=Y
 ;
CHECK ; Entry Point to check if valid new rx number
 S:'$D(PSOX) PSOX=$G(PSONEW("RX #"))
 S PSONRXN("ERR FLG")=0
 S DIC="^PSRX(",DIC(0)="XZ",X=PSOX D ^DIC K DIC
 I Y'<0 D  G MANUALX
 . W $C(7),!!,?10,"Not a new prescription number!!!",!,"Rxn: ",Y(0,0),!,"Patient: ",$S($D(^DPT(+$P(Y(0),"^",2),0)):$P(^(0),"^"),1:"UNKNOWN"),!,"Drug: ",$S($D(^PSDRUG(+$P(Y(0),"^",6),0)):$P(^(0),"^"),1:"UNKNOWN")
 . S PSONRXN("ID")=$P(Y(0),"^",13)
 . I PSONRXN("ID") W !,"Issued: ",$E(PSONRXN("ID"),4,5),"-",$E(PSONRXN("ID"),6,7),"-",$E(PSONRXN("ID"),2,3)
 . K PSONRXN("ID"),Y
 . W:$G(PSODRUG("NAME")) !,"RX DELETED",!
 . S PSONRXN("ERR FLG")=1
 . I $G(PSOFIN)!($G(PSOFINFL)),'$G(PSOAC) W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 . Q
 L +^PSRX("B",PSOX):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T L -^PSRX("B",PSOX) D  G MANUALX
 . W $C(7),?10,"Prescription Rx# "_PSOX_" already being processed."
 . W:$G(PSODRUG("NAME")) !,"Rx Deleted",!
 . S PSONRXN("ERR FLG")=1
 . Q
 S PSONEW("RX #")=PSOX
MANUALX I $G(PSONRXN("ERR FLG"))=1 S (PSONEW("DFLG"),PSONEW("QFLG"))=1
 K PSONRXN,X,Y,DIRUT,DTOUT,DUOUT,DIC,DIE,DR,PSOX,PSODIR,PSOX1
 Q
 ;
AUTO ; Entry point for getting next rx # if autonumbering
 S PSONEW("QFLG")=0
 S PSONRXN("TYPE")=$S('+$G(^PS(59,+PSOSITE,2)):8,PSODRUG("DEA")[2&(+$G(^PS(59,+PSOSITE,2))):3,1:8)
 L +^PS(59,+PSOSITE,PSONRXN("TYPE")):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3)
 S PSOX1=^PS(59,+PSOSITE,PSONRXN("TYPE")),PSONRXN("LO")=$P(PSOX1,"^")
 S PSONRXN("HI")=$P(PSOX1,"^",2),PSOI=$P(PSOX1,"^",3),PSONEW("OLD LAST RX#",PSONRXN("TYPE"))=PSOI
 S:PSOI<PSONRXN("LO") PSOI=PSONRXN("LO")
LOOP2 F  S PSOI=PSOI+1 D:PSOI>PSONRXN("HI") FATAL Q:'$D(^PSRX("B",PSOI))!PSONEW("QFLG")
 G:PSONEW("QFLG") AUTOX
 K DUP L +^PSRX("B",PSOI):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) D  I $G(DUP) K DUP,I G LOOP2
 .I $D(^PSRX("B",PSOI))!'$T L -^PSRX("B",PSOI) S DUP=1 Q
 .F I=65:1:90 I $D(^PSRX("B",PSOI_$C(I))) L -^PSRX("B",PSOI) S DUP=1 Q
 K DIC,DIE,DA,DUP,I
 S DIE=59,DA=PSOSITE
 S DR=$S(PSONRXN("TYPE")=8:"2003////"_PSOI,PSONRXN("TYPE")=3:"1002.1////"_PSOI,1:"2003////"_PSOI)
 S PSONEW("RX #")=PSOI
 D ^DIE K DIE,DIC,DR,DA
 L -^PS(59,+PSOSITE,PSONRXN("TYPE"))
AUTOX K PSOX1,PSONRXN,PSOI,X,Y
 Q
 ;
FATAL ;error in autonum queue if necessary and quit
 W !!,$C(7),"Fatal error in Autonumbering - No Numbers Left!",!,"See Application Package Coordinator!",!,$C(7)
 S PSONEW("QFLG")=1 S DIR("A")="Enter RETURN to continue" D PAUSE^VALM1
 Q
