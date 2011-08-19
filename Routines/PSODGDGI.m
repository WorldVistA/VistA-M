PSODGDGI ;BIR/SAB - drug drug interaction checker ; 6/28/07 7:36am
 ;;7.0;OUTPATIENT PHARMACY;**10,27,48,130,144,132,188,207,243,274**;DEC 1997;Build 8
 ;External reference to ^PS(56 supported by DBIA 2229
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to DDIEX^PSNAPIS supported by DBIA 2574
 ;External references to ^ORRDI1 supported by DBIA 4659
 ;External reference ^XTMP("ORRDI" supported by DBIA 4660
 Q:$$DDIEX^PSNAPIS($P(PSODRUG("NDF"),"A"),$P(PSODRUG("NDF"),"A",2))
 N PSOICT S (CRIT,DRG,LSI,DGI,DGS,SER,SERS,STA,PSOICT)=""
 F  S STA=$O(PSOSD(STA)) Q:STA=""!($G(PSORX("DFLG")))  F  S DRG=$O(PSOSD(STA,DRG)) Q:DRG=""!($G(PSORX("DFLG")))  I $P(PSOSD(STA,DRG),"^",2)<10 D
 .Q:$P(PSOSD(STA,DRG),"^",7)']""
 .S NDF=$P(PSOSD(STA,DRG),"^",7)
 .;New logic to Loop All interactions and filter-up a critical if it exists
 .S IT=0,PSOICT=""
 .F  S IT=$O(^PS(56,"APD",NDF,PSODRUG("NDF"),IT)) Q:'IT  D
 ..Q:$$DDIEX^PSNAPIS($P(NDF,"A"),$P(NDF,"A",2))
 ..Q:$P(^PS(56,IT,0),"^",7)&($P(^PS(56,IT,0),"^",7)<DT)
 ..I 'PSOICT S PSOICT=IT Q
 ..I $P($G(^PS(56,IT,0)),"^",4)=1 S PSOICT=IT Q
 ..Q
 .I 'PSOICT Q
 .S IT=PSOICT
 .I STA="ZNONVA" S DNM=DRG W ! D NVA^PSODRDU1 K DNM,IT,PSOICT Q
 .D BLD Q:+$G(PSORX("DFLG"))
 .Q
 I '$D(^XUSEC("PSORPH",DUZ)),$G(DGI)]"" S:+CRIT PSONEW("STATUS")=4 W $C(7),!,"DRUG INTERACTION WITH RX #s: "_LSI,! K LSI,DRG,IT,NDF,PSOICT
 K IT
 ; CHECK FOR REMOTE DRUG INTERACTIONS
 I +$G(PSORX("DFLG")) Q
 I $T(HAVEHDR^ORRDI1)']"" Q
 I '$$HAVEHDR^ORRDI1 Q
 I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) D  Q
 .I $T(REMOTE^PSORX1)]"" Q
 .W !,"Remote data not available - Only local order checks processed." D PAUSE^PSOORRD2
 I $P($G(^XTMP("ORRDI","PSOO",PSODFN,0)),"^",3)<0 W !,"Remote data not available - Only local order checks processed." D PAUSE^PSOORRD2 Q
 I $D(^TMP($J,"DI"_PSODFN)) K ^TMP($J,"DI") M ^TMP($J,"DI")=^TMP($J,"DI"_PSODFN) D DRGINT^PSOORRD2
 K ^TMP($J,"DI"_PSODFN),^TMP($J,"DI")
 Q
TECH ;add tech entry to RX VERIFY file (#52.4)
 I +CRIT S PSODI=1,DIC="^PS(52.4,",DLAYGO=52.4,DIC(0)="L",(DINUM,X)=PSOX("IRXN"),DIC("DR")="1////"_PSODFN_";2////"_DUZ_";4///"_DT_";7///"_1_";7.1///"_SER_";7.2///"_DGI K DD,DO D FILE^DICN K DD,DO
 S:$G(DGS)'="" $P(^PSRX(PSOX("IRXN"),"DRI"),"^")=SERS,$P(^PSRX(PSOX("IRXN"),"DRI"),"^",2)=DGS  K PSODI,CRIT,DIC,DLAYGO,DINUM,DGI,DGS,SER,SERS Q
BLD I $D(^XUSEC("PSORPH",DUZ)) D PHARM Q
 S LSI=$P(^PSRX(+PSOSD(STA,DRG),0),"^")_"/"_$P(^PSDRUG($P(^(0),"^",6),0),"^")_","_LSI,DGI=$P(PSOSD(STA,DRG),"^")_","_DGI,SER=IT_","_SER I $P(PSOSD(STA,DRG),"^",9),$P(^PS(56,IT,0),"^",4)=1 S $P(^PSRX(+PSOSD(STA,DRG),"STA"),"^")=4
 I $P(^PS(56,IT,0),"^",4)=2 S SERS=IT_","_SERS,DGS=$P(PSOSD(STA,DRG),"^")_","_DGS
 S:$P(^PS(56,IT,0),"^",4)=1 CRIT=1 Q
PHARM ;pharmacist verification of drug interaction
 D PSOL^PSSLOCK($P(PSOSD(STA,DRG),"^")) I '$G(PSOMSG) D  K PSOMSG S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR S PSORX("DFLG")=1 Q
 .I $P($G(PSOMSG),"^",2)'="" W !!,$P(PSOMSG,"^",2) D  Q
 ..W !,"Rx: "_$P($G(^PSRX($P(PSOSD(STA,DRG),"^"),0)),"^")_"    Drug: "_$P($G(^PSDRUG(+$P($G(^(0)),"^",6),0)),"^")
 ..W !,"which interacts with the drug you are entering!",!
 .W !!,"Another person is editing Rx "_$P($G(^PSRX($P(PSOSD(STA,DRG),"^"),0)),"^")_",",!,"which interacts with the drug you are entering!",!
 S PSODGRLX=$P(PSOSD(STA,DRG),"^")
 S SER=^PS(56,IT,0),DIR("?",1)="Answer 'YES' if you DO want to "_$S($P(SER,"^",4)=1:"continue processing",1:"enter an intervention for")_" this medication,"
 S DIR("?")="       'NO' if you DON'T want to "_$S($P(SER,"^",4)=1:"continue processing",1:"enter an intervention for")_" this medication,"
 W $C(7),$C(7) S DIR("A",1)="***"_$S($P(SER,"^",4)=1:"CRITICAL",1:"SIGNIFICANT")_"*** "_"Drug Interaction with RX #"_$P(^PSRX($P(PSOSD(STA,DRG),"^"),0),"^"),DIR("A",2)="DRUG: "_$P(DRG,"^")
 S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to "_$S($P(SER,"^",4)=1:"Continue? ",1:"Intervene? "),DIR("B")="Y" D ^DIR
 I 'Y,$P(SER,"^",4)=1 S PSORX("DFLG")=1,DGI="" K DIR,DTOUT,DIRUT,DIROUT,DUOUT
 I Y,$P(SER,"^",4)=1 S PSORX("INTERVENE")=1,DGI="" K DIR,DTOUT,DIRUT,DIROUT,DUOUT G CRI Q
 I 'Y,$P(SER,"^",4)=2 K DIR,DTOUT,DIRUT,DIROUT,DUOUT D ULRX Q
 I Y,$P(SER,"^",4)=2 S PSORX("INTERVENE")=2,DGI="" K DIR,DTOUT,DIRUT,DIROUT,DUOUT
 D ULRX
 Q
CRI ;process new drug interactions entered by pharmacist
 K DIR G:$P(PSOSD(STA,DRG),"^",9) CRITN S DIR("A",1)="",DIR("A",2)="Do you want to Process medication",DIR("A")=PSODRUG("NAME")_": ",DIR(0)="SA^1:PROCESS;0:ABORT ORDER ENTRY",DIR("B")="P"
 S DIR("?",1)="Enter '1' or 'P' to Activate medication",DIR("?")="      '0' or 'A' to Abort Order Entry process" D ^DIR K X1,DIR I 'Y S PSORX("DFLG")=1,DGI="" K DTOUT,DIRUT,DIROUT,DUOUT,PSORX("INTERVENE") D ULRX Q
 I $P(SER,"^",4)=1 D
 .D SIG^XUSESIG I X1="" K PSORX("INTERVENE") S PSORX("DFLG")=1 Q
 .S PSORX("INTERVENE")=$P(SER,"^",4)
 K DUOUT,DTOUT,DIRUT,DIROUT D ULRX Q
CRITN ;process multiple new drug interactions
 K X1,DIR S DIR("A",1)="",DIR("A",2)="Do you want to: ",DIR("A",3)=" 1.  Delete NEW medication "_PSODRUG("NAME"),DIR("A",4)=" 2.  Cancel ACTIVE New Rx #"_$P(^PSRX($P(PSOSD(STA,DRG),"^"),0),"^")_" DRUG: "_$P(DRG,"^")
 S DIR("A",5)=" 3.  Delete 1 and Cancel 2",DIR("A")=" 4.  Continue ?: ",DIR(0)="SA^1:NEW MEDICATION;2:ACTIVE New Rx "_$P(DRG,"^")_";3:BOTH;4:CONTINUE"
 S DIR("?",1)="Enter '1' or 'N' to Delete New Medication and Dispense Rx #"_$P(^PSRX(+PSOSD(STA,DRG),0),"^")
 S DIR("?",2)="      '2' or 'A' to Cancel Active Rx #"_$P(^PSRX(+PSOSD(STA,DRG),0),"^")_" and Dispense New Rx"
 S DIR("?",3)="      '3' or 'B' to Delete 1 and Cancel 2",DIR("?")="      '4' or 'C' to do nothing to either Rx" D ^DIR K DIR
 I Y=1 S PSORX("DFLG")=1,DGI="",PSHLDDRG=PSODRUG("IEN") D  D ULRX Q
 .I $G(PSORXED) D  Q
 ..D NOOR^PSOCAN4 I $D(DIRUT) W $C(7)," ACTION NOT TAKEN!",! S PSORX("DFLG")=1 K PSORX("INTERVENE") Q
 ..S DA=$P(PSOLST(ORN),"^",2) D MESS,ENQ^PSORXDL,FULL^VALM1
 ..K PSOSD($P(PSOLST(ORN),"^",3),PSODRUG("NAME")),DTOUT,DIROUT,DIRUT,DUOUT S:$G(PSOSD) PSOSD=PSOSD-1 S ZONE=1
 .S PSODRUG("IEN")=$P(^PSRX($P(PSOSD(STA,DRG),"^"),0),"^",6) D FULL^VALM1,^PSORXI
 .S PSODRUG("IEN")=PSHLDDRG,VALMBCK="R"
 .K DTOUT,DIRUT,DIROUT,DUOUT,PSHLDDRG
 .I $G(OR0) D
 ..D NOOR^PSOCAN4 I $D(DIRUT) D  Q
 ...W $C(7)," ACTION NOT TAKEN!",! K PSORX("INTERVENE") S PSORX("DFLG")=1
 ..D DC^PSOORFI2
 I Y=2 S (DA,PSOHOLDA)=+PSOSD(STA,DRG) D  D ULRX Q
 .D NOOR^PSOCAN4 I $D(DIRUT) D  Q
 ..W $C(7)," ACTION NOT TAKEN!",! K PSORX("INTERVENE") S PSORX("DFLG")=1
 .D MESS,ENQ^PSORXDL
 .S DA=PSOHOLDA D FULL^VALM1,EN1^PSORXI(.DA),PPL
 .K PSOSD(STA,DRG),DTOUT,DIROUT,DIRUT,DUOUT,PSOHOLDA
 .S:$G(PSOSD) PSOSD=PSOSD-1 S VALMBCK="R"
 I Y=3 S (DA,PSOHOLDA)=+PSOSD(STA,DRG) D  S VALMBCK="R"
 .D NOOR^PSOCAN4 I $D(DIRUT) D  Q
 ..W $C(7)," ACTION NOT TAKEN!",! K PSORX("INTERVENE") S PSORX("DFLG")=1
 .S:$G(PSOSD) PSOSD=PSOSD-1 S PSORX("DFLG")=1 D MESS,ENQ^PSORXDL
 .I $G(OR0) D DC^PSOORFI2
 .S DA=PSOHOLDA D FULL^VALM1,EN1^PSORXI(.DA),PPL K PSOSD(STA,DRG),PSOHOLDA
 .I $G(PSORXED) D
 ..S DA=$P(PSOLST(ORN),"^",2) D MESS,ENQ^PSORXDL,FULL^VALM1
 ..K PSOSD($P(PSOLST(ORN),"^",3),PSODRUG("NAME")),DTOUT,DIROUT,DIRUT,DUOUT S:$G(PSOSD) PSOSD=PSOSD-1 S ZONE=1
 K DTOUT,DIROUT,DIRUT,DUOUT
 D ULRX
 Q
MESS W !!,"Canceling Rx: "_$P($G(^PSRX(DA,0)),"^")_"   "_"Drug: "_$P($G(^PSDRUG($P(^PSRX(DA,0),"^",6),0)),"^"),! Q
PPL F PSOSL=0:0 S PSOSL=$O(PSORX("PSOL",PSOSL)) Q:'PSOSL  S PSOX2=PSOSL
 I $G(PSOX2) D
 .F PSOSL=0:1:PSOX2 S PSOSL=$O(PSORX("PSOL",PSOSL)) Q:'PSOSL  F ENT=1:1:$L(PSORX("PSOL",PSOSL),",") I $P(PSORX("PSOL",PSOSL),",",ENT)=$P(PSOSD(STA,DRG),"^") S PSOL(PSOSL,ENT)=""
 .F PSOL=0:0 S PSOL=$O(PSOL(PSOL)) Q:'PSOL  F ENT=0:0 S ENT=$O(PSOL(PSOL,ENT)) Q:'ENT  D
 ..I ENT=1,'$P(PSORX("PSOL",PSOL),",",2) K PSORX("PSOL",PSOL) Q
 ..I ENT=1,$P(PSORX("PSOL",PSOL),",",2) S PSORX("PSOL",PSOL)=$P(PSORX("PSOL",PSOL),",",2,99) Q
 ..S PSORX("PSOL",PSOL)=$P(PSORX("PSOL",PSOL),",",1,ENT-1)_","_$P(PSORX("PSOL",PSOL),",",ENT+1,99)
 K PSOX2,PSOSL,PSOL,ENT Q
ULRX ;
 I '$G(PSODGRLX) Q
 D PSOUL^PSSLOCK(PSODGRLX) K PSODGRLX
 Q
