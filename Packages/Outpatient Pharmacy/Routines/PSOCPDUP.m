PSOCPDUP ;BIR/SAB - Dup drug and class checker for copy orders ;1/3/05 11:34am
 ;;7.0;OUTPATIENT PHARMACY;**11,27,32,130,132,192,207,222,243,305**;DEC 1997;Build 8
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 ;External references to ^ORRDI1 supported by DBIA 4659
 ;External references to ^XTMP("ORRDI" supported by DBIA 4660
 S $P(PSONULN,"-",79)="-",(STA,DNM)=""
 F  S STA=$O(PSOSD(STA)) Q:STA=""  F  S DNM=$O(PSOSD(STA,DNM)) Q:DNM=""  D  Q:$G(PSORX("DFLG"))
 .I STA="PENDING" D ^PSODRDU1 Q
 .I STA="ZNONVA" D NVA^PSODRDU1 Q
 .D:PSODRUG("NAME")=$P(DNM,"^")&('$D(^XUSEC("PSORPH",DUZ)))  Q:$G(PSORX("DFLG"))
 ..I $P($G(PSOPAR),"^",16) D DUP Q:$G(PSORX("DFLG"))
 ..I $P(PSOPAR,"^",2),'$P($G(PSOPAR),"^",16) D DUP Q:$G(PSORX("DFLG"))
 ..I '$P(PSOPAR,"^",2),'$P($G(PSOPAR),"^",16) D DUP Q:$G(PSORX("DFLG"))
 .D:PSODRUG("NAME")=$P(DNM,"^")&($D(^XUSEC("PSORPH",DUZ))) DUP Q:$G(PSORX("DFLG"))
 .I PSODRUG("VA CLASS")]"",$E(PSODRUG("VA CLASS"),1,4)=$E($P(PSOSD(STA,DNM),"^",5),1,4),PSODRUG("NAME")'=$P(DNM,"^") S PSOCPCLS=1 D CLS K PSOCPCLS
 K ^TMP($J,"DD"),^TMP($J,"DC"),^TMP($J,"DI")
 D REMOTE
EXIT D ^PSOBUILD K CAN,DA,DIR,DNM,DUPRX0,ISSD,J,LSTFL,MSG,PHYS,PSOCLC,PSONULN,REA,RFLS,RX0,RX2,RXREC,ST,Y,ZZ,ACT,PSOCLOZ,PSOLR,PSOLDT,PSOCD,SIG
 Q
DUP S:$P(PSOSD(STA,DNM),"^",2)<10!($P(PSOSD(STA,DNM),"^",2)=16) DUP=1 W !,PSONULN,!,$C(7),"DUPLICATE DRUG "_$P(DNM,"^")_" in Prescription: ",$P(^PSRX(+PSOSD(STA,DNM),0),"^")
 S RXREC=+PSOSD(STA,DNM),MSG="Discontinued During Prescription Entry COPY - Duplicate Drug"
DATA S DUPRX0=^PSRX(RXREC,0),RFLS=$P(DUPRX0,"^",9),ISSD=$P(^PSRX(RXREC,0),"^",13),RX0=DUPRX0,RX2=^PSRX(RXREC,2),SIG=$P($G(^PSRX(RXREC,"SIG")),"^"),$P(RX0,"^",15)=+$G(^PSRX(RXREC,"STA"))
 W !!,$J("Status: ",24) S J=RXREC D STAT^PSOFUNC W ST K RX0,RX2 W ?40,$J("Issued: ",24),$E(ISSD,4,5)_"/"_$E(ISSD,6,7)_"/"_$E(ISSD,2,3)
 D PRSTAT^PSODRDUP(RXREC)
 K FSIG,BSIG I $P($G(^PSRX(RXREC,"SIG")),"^",2) D FSIG^PSOUTLA("R",RXREC,54) F PSREV=1:1 Q:'$D(FSIG(PSREV))  S BSIG(PSREV)=FSIG(PSREV)
 K FSIG,PSREV I '$P($G(^PSRX(RXREC,"SIG")),"^",2) D EN2^PSOUTLA1(RXREC,54)
 W !,$J("SIG: ",24) W $G(BSIG(1))
 I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  W !?24,$G(BSIG(PSREV))
 K BSIG,PSREV
 W !,$J("QTY: ",24)_$P(DUPRX0,"^",7),?40,$J("# of refills: ",24)_RFLS S PHYS=$S($D(^VA(200,+$P(DUPRX0,"^",4),0)):$P(^(0),"^"),1:"UNKNOWN")
 W !,$J("Provider: ",24)_PHYS,?40,$J("Refills remaining: ",24),RFLS-$S($D(^PSRX(RXREC,1,0)):$P(^(0),"^",4),1:0)
 S LSTFL=+^PSRX(RXREC,3) W !?40,$J("Last filled on: ",24)_$E(LSTFL,4,5)_"/"_$E(LSTFL,6,7)_"/"_$E(LSTFL,2,3),!?40,$J("Days Supply: ",24)_$P(DUPRX0,"^",8)
 W !,PSONULN,! I $P($G(^PS(53,+$P($G(PSORX("PATIENT STATUS")),"^"),0)),"^")["AUTH ABS"!($G(PSORX("PATIENT STATUS"))["AUTH ABS")&'$P(PSOPAR,"^",5) W !,"PATIENT ON AUTHORIZED ABSENCE!" Q
ASKCAN I $P(PSOSD(STA,DNM),"^",2)>10,$P(PSOSD(STA,DNM),"^",2)'=16 Q
 I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16),'$D(^XUSEC("PSORPH",DUZ)),'$G(CLS) S PSORX("DFLG")=1 K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR Q
 I $P(PSOPAR,"^",2),'$P(PSOPAR,"^",16),'$D(^XUSEC("PSORPH",DUZ)),'$G(CLS) S PSORX("DFLG")=1 K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR Q
 I $P(PSOSD(STA,DNM),"^",2)=16,$G(DUP) W !!,"Prescription "_$S(+$G(PSOSD(STA,DNM)):$P($G(^PSRX(+$G(PSOSD(STA,DNM)),0)),"^")_" ",1:"")_"is on Provider Hold, it cannot be discontinued.",! D  Q
 .S PSORX("DFLG")=1 K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,DUP
 I $G(PSOCPCLS),$G(RXRECCOP) D PSOL^PSSLOCK(RXRECCOP) I '$G(PSOMSG) D  K PSOMSG,DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR S PSORX("DFLG")=1 Q
 .I $P($G(PSOMSG),"^",2)'="" W !!,$P(PSOMSG,"^",2) Q
 .W !!,"Another person is editing Rx "_$P($G(^PSRX(RXRECCOP,0)),"^")
 K PSOMSG S DIR("A")="Discontinue Rx # "_$P(^PSRX(+PSOSD(STA,DNM),0),"^"),DIR(0)="Y",DIR("?")="Enter Y to discontinue this Rx."
 D ^DIR K DIR S DA=RXREC S ACT="Discontinued while entering new Rx"
 I 'Y W $C(7)," -Prescription was not discontinued..." S:'$D(PSOCLC) PSOCLC=DUZ S MSG=ACT,REA="C" S:$G(DUP) PSORX("DFLG")=1 K DUP,CLS D  Q
 .I $D(^TMP("PSORXDC",$J,RXREC,0)) K ^TMP("PSORXDC",$J,RXREC,0)
 .D:$G(PSOCPCLS) ULRX
 I $P(PSOSD(STA,DNM),"^",2)=16,$G(CLS) W !!,"Prescription "_$P($G(^PSRX(+$G(RXRECLOC),0)),"^")_" is on Provider Hold, it cannot be discontinued.",! D ULRX K CLS,DUP,RXRECLOC S PSORX("DFLG")=1 H 2 Q
 S PSOCLC=DUZ,MSG=$S($G(MSG)]"":MSG,1:ACT_" During New Rx Entry - DUPLICATE RX"),REA="C"
 W !!,"Duplicate "_$S($G(CLS):"Class",1:"Drug")_" will be discontinued after the acceptance of the new order.",!
 S ^TMP("PSORXDC",$J,RXREC,0)="52^"_DA_"^"_MSG_"^"_REA_"^"_ACT_"^"_STA_"^"_DNM,PSONOOR="D"
 K CLS,DUP,PSOCPCLS Q
CLS K DUP S CLS=1,MSG="Discontinued During New Prescription Entry - Duplicate Class" W !,PSONULN
 W !?5,$C(7),"*** SAME CLASS *** OF DRUG IN RX #"_$P(^PSRX(+PSOSD(STA,DNM),0),"^")_" FOR "_$P(DNM,"^"),!,"CLASS: "_PSODRUG("VA CLASS")
 S CAN=$P(PSOSD(STA,DNM),"^",2)'<11!($P(PSOSD(STA,DNM),"^",2)=1) S (RXREC,RXRECCOP)=+PSOSD(STA,DNM) S PSOELSE=$P(PSOPAR,"^",10) I PSOELSE D DATA
 I 'PSOELSE S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,DTOUT,DUOUT,DIRUT
 K PSOELSE,RXRECCOP Q
ULRX ;
 I '$G(RXRECCOP) Q
 D PSOUL^PSSLOCK(RXRECCOP)
 Q
 ;
REMOTE ;
 Q:$G(PSORX("DFLG"))
 I $T(HAVEHDR^ORRDI1)']"" Q
 I '$$HAVEHDR^ORRDI1 Q
 I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) G REMOTE2
 W:$D(IOF) @IOF W !,"Now doing remote order checks. Please wait..."
 D REMOTE^PSOORRDI(PSODFN,PSODRUG("IEN"))
 I $D(^TMP($J,"DD")) D DUP^PSOORRD2
 I $D(^TMP($J,"DC")) D CLS^PSOORRD2
REMOTE2 ;
 K ^TMP($J,"DD"),^TMP($J,"DC"),^TMP($J,"DI")
 Q
 ;
