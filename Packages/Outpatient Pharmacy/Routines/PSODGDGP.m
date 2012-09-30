PSODGDGP ;BIR/SAB - drug drug interaction checker ;4/14/93
 ;;7.0;OUTPATIENT PHARMACY;**251,387,379**;DEC 1997;Build 28
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External references PSOUL^PSSLOCK supported by DBIA 2789
 ;External references to ^ORRDI1 supported by DBIA 4659
 ;External reference ^XTMP("ORRDI" supported by DBIA 4660
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5425
 N DRG,PSOREMOT S (CRIT,DRG,LSI,DGI,DGS,SER,SERS,STA,PSOICT)="",PSOREMOT=0
 D BLD Q:+$G(PSORX("DFLG"))!($G(PSODLQT))
 I '$D(^XUSEC("PSORPH",DUZ)),$G(DGI)]"" S:$G(CRIT) PSONEW("STATUS")=4 W $C(7),!,"DRUG INTERACTON WITH RX #s: "_LSI,!
 I '$D(^XUSEC("PSORPH",DUZ)),(","_$G(^TMP("PSOSER",$J,0))_",")[(",1,") S:$D(^TMP("PSODGI",$J,0)) PSONEW("STATUS")=4
 K DRG,NDF,PSOICT,IT,LSI
 I +$G(PSORX("DFLG")) Q
 I +$G(PSODRUG("NDF"))'=0 D
 .I $T(HAVEHDR^ORRDI1)']"" Q
 .I '$$HAVEHDR^ORRDI1 Q
 .D HD^PSODDPR2():(($Y+5)>IOSL)
 .I $P($G(^XTMP("ORRDI","PSOO",PSODFN,0)),"^",3)<0 W !!,"Remote data not available - Only local order checks processed.",!! S PSOREMOT=1 D HD^PSODDPR2():(($Y+5)>IOSL) Q
 .I $D(^TMP($J,"DI"_PSODFN)) K ^TMP($J,"DI") M ^TMP($J,"DI")=^TMP($J,"DI"_PSODFN) D DRGINT^PSOORRD2
 .K ^TMP($J,"DI"_PSODFN),^TMP($J,"DI")
 I '$D(^XUSEC("PSORPH",DUZ)),$G(PSOREMOT)!($G(DGI)]"") K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue..." D ^DIR K DIR,DUOUT,DTOUT
 Q
TECH ;add tech entry to RX VERIFY file (#52.4); called from new order/copy/renew
 I $$DS^PSSDSAPI,+$G(^TMP("PSODOSF",$J,0)) S ^PS(52.4,PSOXIRXN,1)=^TMP("PSODOSF",$J,0)
 Q:'$D(^TMP("PSODGI",$J,0))
 S $P(^PSRX(PSOXIRXN,"DRI"),"^")=^TMP("PSOSER",$J,0)_"^"_^TMP("PSODGI",$J,0)
 S $P(^PS(52.4,PSOXIRXN,0),"^",8)=1,$P(^PS(52.4,PSOXIRXN,0),"^",9)=^TMP("PSOSER",$J,0),$P(^PS(52.4,PSOXIRXN,0),"^",10)=^TMP("PSODGI",$J,0)
 Q
TECH2(PSOXIRXN,PSODFN,DUZ,PSOX) ;
 Q:$D(^XUSEC("PSORPH",DUZ))
 N PSODWARN,PSOSIGNIF,PSOINTSV,PSOTLBL S (PSODWARN,PSOSIGNIF,PSOTLBL,PSOINTSV)=0
 S:$$DS^PSSDSAPI&(+$G(^TMP("PSODOSF",$J,0))) PSODWARN=1  ;dosing drug warning
 I $D(^TMP("PSOSER",$J,0)) S PSOINTSV=$G(^TMP("PSOSER",$J,0)) S:PSOINTSV[1 PSODWARN=1 S:PSOINTSV[2 PSOSIGNIF=1 ;critical and significant drug interaction drug warnings
 I '$G(PSORX("VERIFY")),'PSODWARN&($G(PSOSIGNIF)) D  Q PSOTLBL  ;don't set 52.4 when  verification is off and only signficiant interation
 .S $P(^PSRX(PSOXIRXN,"DRI"),"^")=^TMP("PSOSER",$J,0),$P(^PSRX(PSOXIRXN,"DRI"),"^",2)=^TMP("PSODGI",$J,0) S:'$P(PSOPAR,"^",2) PSOTLBL=1
 I $G(PSODWARN)!($G(PSORX("VERIFY"))) D
 .K DIC,DLAYGO,DINUM,DIADD,X,DD,DO S DIC="^PS(52.4,",DLAYGO=52.4,DINUM=PSOXIRXN,DIC(0)="ML",X=PSOXIRXN
 .D FILE^DICN K DD,DO,DIC,DLAYGO,DINUM S ^PS(52.4,PSOXIRXN,0)=PSOXIRXN_"^"_PSODFN_"^"_DUZ_"^"_"^"_$E(PSOX("LOGIN DATE"),1,7)_"^"_PSOXIRXN_"^"_PSOX("STOP DATE")
 .Q:PSOINTSV'[1&('PSODWARN)
 .D TECH
 I $D(^PS(52.4,PSOXIRXN)) K DIK,DA S DIK="^PS(52.4,",DA=PSOX("IRXN") D IX^DIK K DIK,DA
 I '$G(PSORX("VERIFY")) S:(PSOX("STATUS")=4!$G(PSODWARN)) PSOTLBL=1 ;verification off, dose warn or drug interaction, print technician warning label
 I $G(PSORX("VERIFY")) S PSOTLBL=$S('$G(PSODWARN)&('$G(PSOSIGNIF)):2,'$G(PSODWARN)&($G(PSOSIGNIF)):2,$G(PSODWARN):1,1:0)
 Q PSOTLBL
 ;
BLD I $D(^XUSEC("PSORPH",DUZ)) S PSORX("PHARM")=DUZ D PHARM Q
BLD2 ;
 Q:$P(ON,";")'="O"
 S LSI=$P(^PSRX($P(ON,";",2),0),"^")_"/"_$P(^PSDRUG($P(^PSRX($P(ON,";",2),0),"^",6),0),"^")_","_LSI
 I '$D(^TMP("PSODGI",$J,0)) D
 . S ^TMP("PSODGI",$J,0)=$P(ON,";",2)_","_$G(^TMP("PSODGI",$J,0)),^TMP("PSOSER",$J,0)=IT_","_$G(^TMP("PSOSER",$J,0))
 I ^TMP("PSODGI",$J,0)'[$P(ON,";",2) D
 .S ^TMP("PSODGI",$J,0)=$P(ON,";",2)_","_$G(^TMP("PSODGI",$J,0))
 .S ^TMP("PSOSER",$J,0)=IT_","_$G(^TMP("PSOSER",$J,0))
 I IT=2 S ^TMP("PSOSERS",$J,0)=IT_","_$G(^TMP("PSOSERS",$J,0)),^TMP("PSODGS",$J,0)=$P(ON,";",2)_","_$G(^TMP("PSODGS",$J,0))
 S:IT=1 ^TMP("PSOTDD",$J,1)=1
 Q
PHARM ;pharmacist verification of drug interaction
 S PSODGRLX=$P(ON,";",2)
 S DIR("?",1)="Answer 'YES' if you DO want to "_$S(IT=1:"continue processing",1:"enter an intervention for")_" this medication,"
 S DIR("?")="       'NO' if you DON'T want to "_$S(IT=1:"continue processing",1:"enter an intervention for")_" this medication,"
 W ! S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to "_$S(IT=1:"Continue? ",1:"Intervene? "),DIR("B")="Y" D ^DIR
 I 'Y,IT=1 S PSODLQT=1,DGI="" S:'$G(PSORXED)&('$G(PSOREINS)) PSORX("DFLG")=1 S:$G(PSORXED)!($G(PSOREINS)) PSOQUIT=1 K DIR,DTOUT,DIRUT,DIROUT,DUOUT Q
 I Y,IT=1 S PSORX("INTERVENE")=1,DGI="" K DIR,DTOUT,DIRUT,DIROUT,DUOUT G CRI Q
 I 'Y,IT=2 S:$G(DIRUT) (PSODLQT,PSOQUIT)=1 K DIR,DTOUT,DIRUT,DIROUT,DUOUT D ULRX Q
 I Y,IT=2 S PSORX("INTERVENE")=2,DGI="" K DIR,DTOUT,DIRUT,DIROUT,DUOUT
 D ULRX
 Q
CRI ;process new drug interactions entered by pharmacist
 K DIR ;G:$P(PSOSD(STA,DRG),"^",9) CRITN 
 S DIR("A",1)="",DIR("A",2)="Do you want to Process medication",DIR("A")=PSODRUG("NAME")_": ",DIR(0)="SA^1:PROCESS;0:ABORT ORDER ENTRY",DIR("B")="P"
 S DIR("?",1)="Enter '1' or 'P' to Activate medication",DIR("?")="      '0' or 'A' to Abort Order Entry process" D ^DIR K X1,DIR I 'Y S PSORX("DFLG")=1,DGI="" K DTOUT,DIRUT,DIROUT,DUOUT,PSORX("INTERVENE") D ULRX Q
 I IT=1 D
 .S PSORX("INTERVENE")=IT
 .D SIG^XUSESIG I X1="" K PSORX("INTERVENE") S PSORX("DFLG")=1 Q
 K DUOUT,DTOUT,DIRUT,DIROUT D ULRX Q
CRITN ;process multiple new drug interactions
 K X1,DIR S DIR("A",1)="",DIR("A",2)="Do you want to: ",DIR("A",3)=" 1.  Delete NEW medication "_PSODRUG("NAME"),DIR("A",4)=" 2.  Cancel ACTIVE New Rx #"_$P(^PSRX($P(ON,";",2),0),"^")_" DRUG: "_DRG
 S DIR("A",5)=" 3.  Delete 1 and Cancel 2",DIR("A")=" 4.  Continue ?: ",DIR(0)="SA^1:NEW MEDICATION;2:ACTIVE New Rx "_DRG_";3:BOTH;4:CONTINUE"
 S DIR("?",1)="Enter '1' or 'N' to Delete New Medication and Dispense Rx #"_$P(^PSRX($P(ON,";",2),0),"^")
 S DIR("?",2)="      '2' or 'A' to Cancel Active Rx #"_$P(^PSRX($P(ON,";",2),0),"^")_" and Dispense New Rx"
 S DIR("?",3)="      '3' or 'B' to Delete 1 and Cancel 2",DIR("?")="      '4' or 'C' to do nothing to either Rx" D ^DIR K DIR
 I Y=1 S PSORX("DFLG")=1,DGI="",PSHLDDRG=PSODRUG("IEN") D  D ULRX Q
 .I $G(PSORXED) D  Q
 ..D NOOR^PSOCAN4 I $D(DIRUT) W $C(7)," ACTION NOT TAKEN!",! S PSORX("DFLG")=1 K PSORX("INTERVENE") Q
 ..S DA=$P(ON,";",2) D MESS,ENQ^PSORXDL,FULL^VALM1
 ..K PSOSD($P(PSOLST($P(ON,";",2)),"^",3),PSODRUG("NAME")),DTOUT,DIROUT,DIRUT,DUOUT S:$G(PSOSD) PSOSD=PSOSD-1 S ZONE=1
 .S PSODRUG("IEN")=$P(^PSRX($P(ON,";",2),0),"^",6) D FULL^VALM1,^PSORXI
 .S PSODRUG("IEN")=PSHLDDRG,VALMBCK="R"
 .K DTOUT,DIRUT,DIROUT,DUOUT,PSHLDDRG
 .I $G(OR0) D
 ..D NOOR^PSOCAN4 I $D(DIRUT) D  Q
 ...W $C(7)," ACTION NOT TAKEN!",! K PSORX("INTERVENE") S PSORX("DFLG")=1
 ..D DC^PSOORFI2
 I Y=2 S (DA,PSOHOLDA)=$P(ON,";",2) D  D ULRX Q
 .D NOOR^PSOCAN4 I $D(DIRUT) D  Q
 ..W $C(7)," ACTION NOT TAKEN!",! K PSORX("INTERVENE") S PSORX("DFLG")=1
 .D MESS,ENQ^PSORXDL
 .S DA=PSOHOLDA D FULL^VALM1,EN1^PSORXI(.DA),PPL
 .K DTOUT,DIROUT,DIRUT,DUOUT,PSOHOLDA
 .S:$G(PSOSD) PSOSD=PSOSD-1 S VALMBCK="R"
 I Y=3 S (DA,PSOHOLDA)=$P(ON,";",2) D  S VALMBCK="R"
 .D NOOR^PSOCAN4 I $D(DIRUT) D  Q
 ..W $C(7)," ACTION NOT TAKEN!",! K PSORX("INTERVENE") S PSORX("DFLG")=1
 .S:$G(PSOSD) PSOSD=PSOSD-1 S PSORX("DFLG")=1 D MESS,ENQ^PSORXDL
 .I $G(OR0) D DC^PSOORFI2
 .S DA=PSOHOLDA D FULL^VALM1,EN1^PSORXI(.DA),PPL K PSOHOLDA
 .I $G(PSORXED) D
 ..S DA=$P(ON,";",2) D MESS,ENQ^PSORXDL,FULL^VALM1
 ..K DTOUT,DIROUT,DIRUT,DUOUT S:$G(PSOSD) PSOSD=PSOSD-1 S ZONE=1
 K DTOUT,DIROUT,DIRUT,DUOUT
 D ULRX
 Q
MESS W !!,"Canceling Rx: "_$P($G(^PSRX(DA,0)),"^")_"   "_"Drug: "_$P($G(^PSDRUG($P(^PSRX(DA,0),"^",6),0)),"^"),! Q
PPL F PSOSL=0:0 S PSOSL=$O(PSORX("PSOL",PSOSL)) Q:'PSOSL  S PSOX2=PSOSL
 I $G(PSOX2) D
 .F PSOSL=0:1:PSOX2 S PSOSL=$O(PSORX("PSOL",PSOSL)) Q:'PSOSL  F ENT=1:1:$L(PSORX("PSOL",PSOSL),",") I $P(PSORX("PSOL",PSOSL),",",ENT)=$P(ON,";",2) S PSOL(PSOSL,ENT)=""
 .F PSOL=0:0 S PSOL=$O(PSOL(PSOL)) Q:'PSOL  F ENT=0:0 S ENT=$O(PSOL(PSOL,ENT)) Q:'ENT  D
 ..I ENT=1,'$P(PSORX("PSOL",PSOL),",",2) K PSORX("PSOL",PSOL) Q
 ..I ENT=1,$P(PSORX("PSOL",PSOL),",",2) S PSORX("PSOL",PSOL)=$P(PSORX("PSOL",PSOL),",",2,99) Q
 ..S PSORX("PSOL",PSOL)=$P(PSORX("PSOL",PSOL),",",1,ENT-1)_","_$P(PSORX("PSOL",PSOL),",",ENT+1,99)
 K PSOX2,PSOSL,PSOL,ENT Q
ULRX ;
 I '$G(PSODGRLX) Q
 D PSOUL^PSSLOCK(PSODGRLX) K PSODGRLX
 Q
