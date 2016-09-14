PSORENW0 ;IHS/DSD/JCM-renew main driver continuation ;2/8/06 8:40am
 ;;7.0;OUTPATIENT PHARMACY;**11,27,32,59,64,46,71,96,100,130,237,206,251,375,379,372,411**;DEC 1997;Build 95
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to PSOL^PSSLOCK supported by DBIA 2789
 ;External reference to PSOUL^PSSLOCK supported by DBIA 2789
 ;
 ;PSO*237 was not adding to Clozapine Override file, fix
PROCESS ;
 D ^PSORENW1
 D INST2^PSORENW
 I $D(PSORX("BAR CODE")),PSODFN'=PSORENW("PSODFN") D NEWPT
 S PSORENW("DFLG")=0,PSORENW("FILL DATE")=PSORNW("FILL DATE")
 I $G(PSORNW("MAIL/WINDOW"))]"" S PSORENW("MAIL/WINDOW")=PSORNW("MAIL/WINDOW")
 W !!,"Now Renewing Rx # "_PSORENW("ORX #")_"   Drug: "_$P($G(^PSDRUG(+$G(PSORENW("DRUG IEN")),0)),"^"),!
 D CHECK G:PSORENW("DFLG") PROCESSX
 D FILDATE
 D DRUG G:PSORENW("DFLG")!PSORX("DFLG") PROCESSX
 D RXN G:PSORENW("DFLG") PROCESSX
 D STOP^PSORENW1,OERR^PSORENW1:$G(PSOFDR)
DSPL K PSOEDT,PSOLM D DSPLY^PSORENW3 G:PSORENW("DFLG") PROCESSX
 S PSORENW("QFLG")=0 D:'$G(PSOFDR) EDIT
 G:PSORENW("DFLG")!$G(PSORX("FN")) PROCESSX
 G:'$G(PSORX("FN"))&('$G(PSORENW("QFLG"))) DSPL
 D:$D(^XUSEC("PSORPH",DUZ))!('$P(PSOPAR,"^",2)) VER1^PSOORNE4(.PSORENW) I PSORENW("DFLG")=1 G PROCESSX
 I $G(NEWDOSE),PSORENW("ENT")>0 K NEWDOSE G DSPL
 D EN^PSORN52(.PSORENW)
 D RNPSOSD^PSOUTIL
 D CAN,DCORD^PSONEW2
 S BBRN="",BBRN1=$O(^PSRX("B",PSORENW("NRX #"),BBRN)) I $P($G(^PSRX(BBRN1,0)),"^",11)["W" S BINGCRT="Y",BINGRTE="W"
 ;PSO*237 add to Clozapine Override file
ANQ I $G(ANQDATA)]"" D NOW^%DTC G:$D(^PS(52.52,"B",%)) ANQ D
 . K DD,DO S DIC="^PS(52.52,",DIC(0)="L",DLAYGO=52.52,X=%
 . D FILE^DICN K DIC,DLAYGO,DD,DO,DA,DR
 . N PS52 S (PS52,DA)=+Y,DIE="^PS(52.52,",DR="1////"_PSORENW("IRXN")
 . D ^DIE K DIE,DA,DR
 . S $P(^PS(52.52,PS52,0),"^",3,6)=ANQDATA
 . K ANQDATA,X,Y,%,ANQREM
 ;
PROCESSX N PSORWRIT I PSORENW("DFLG")!$G(PSORX("DFLG")) S PSOBBCLK=1 W:'$G(POERR) !,$C(7),"RENEWED RX DELETED",! S PSOWRIT=1,PSORERR=1 D
 .D:$P($G(PSOLST(+$G(ORN))),"^",2) PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2)) S POERR("DFLG")=1 D CLEAN^PSOVER1 D
 ..W !! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR K DIR,DTOUT,DUOUT S VALMBCK="Q"
 D:$G(PSORENW("OLD FILL DATE"))]"" SUSDATEK^PSOUTIL(.PSORENW)
 K PRC,PHI,PSOQUIT,BBRN,BBRN1,PSORENW,PSODRUG,PSORX("PROVIDER NAME"),PSORX("CLINIC"),PSORX("FN")
 K PSOEDT,PSOLM S:$G(PSORENW("FROM"))="" (PSORENW("DFLG"),PSORENW("QFLG"))=0
 D CLEAN^PSOVER1
 Q
 ;
CHECK ;
 I '$D(PSORX("BAR CODE")),PSORENW("PSODFN")'=PSODFN D  G CHECKX
 .W !!,?5,$C(7),"Can't renew Rx # "_$P(PSORENW("RX0"),"^")_", it is not for this patient." S PSORENW("DFLG")=1
 .S:$G(POERR) VALMSG="Can't renew Rx # "_$P(PSORENW("RX0"),"^")_", not for this patient.",VALMBCK="R"
 ;Invalid dosage check
 N PSOOCPRX,PSOOLPF,PSOOLPD,PSONOSIG S PSOOCPRX=PSORENW("OIRXN") D CDOSE
 I PSOOLPF!(PSONOSIG) D  G CHECKX
 .S PSORENW("DFLG")=1
 .W !!,$C(7),"Cannot renew Rx # "_$P(PSORENW("RX0"),"^")_$S(PSOOLPF:", invalid dosage of "_$G(PSOOLPD),1:", Missing Sig")
 .S:$G(POERR) VALMSG="Cannot renew Rx # "_$P(PSORENW("RX0"),"^")_$S(PSOOLPF:", invalid Dosage of "_$G(PSOOLPD),1:", Missing Sig") S VALMBCK="R"
 .I '$G(PSORNSPD) W ! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR K DIR
 .I $G(PSORNSPD) W !
 ;
 N PSOS S (PSOS,PSOX,PSOY)="" K ACOM,DIR,DIRUT,DIRUT,DUOUT N DRG
 I $G(PSOSD) F  S PSOS=$O(PSOSD(PSOS)) Q:PSOS=""  F  S PSOX=$O(PSOSD(PSOS,PSOX)) Q:PSOX']""!(PSORENW("DFLG"))  I PSORENW("OIRXN")=+PSOSD(PSOS,PSOX) S PSOY=PSOSD(PSOS,PSOX) I $TR($P(PSOY,"^",3),"B")]"" D  K ACOM,DIR,DIRUT,DIRUT,DUOUT
 . S PSORENW("DFLG")=1
 . W !,$C(7),"Cannot renew Rx # ",$P(PSORENW("RX0"),"^")
 . S PSOREA=$P(PSOY,"^",3),PSOSTAT=+PSORENW("STA")
 . D STATUS^PSOUTIL(PSOREA,PSOSTAT) K PSOREA,PSOSTAT
 .I $G(ACOM)]"" D
 ..S DRG=$P(^PSDRUG($P(^PSRX(PSORENW("OIRXN"),0),"^",6),0),"^")
 ..W ! S DIR(0)="Y",DIR("A",1)="Do you want to Discontinue this Pending Order",DIR("A")="for "_DRG,DIR("B")="No"
 ..D ^DIR I 'Y!($D(DIRUT)) Q
 ..D NOOR^PSOCAN4 Q:$D(DIRUT)  D DE^PSOORFI2
 .Q
 I PSOY="",'$G(PSOORRNW) D
 .W !,$C(7),"Cannot renew Rx # ",$P(PSORENW("RX0"),"^")," later Rx exists." S PSORENW("DFLG")=1
 .S:$G(POERR) VALMSG="Cannot renew Rx # "_$P(PSORENW("RX0"),"^")_" later Rx exists.",VALMBCK="R"
 K PSOX,PSOY G:PSORENW("DFLG") CHECKX
 ;
 I $A($E(PSORENW("ORX #"),$L(PSORENW("ORX #"))))'<90 D  Q
 . W !,$C(7),"Cannot renew Rx # "_PSORENW("ORX #")_", Max number of renewals reached."
 .S:$G(POERR)!('$G(SPEED)) (ACOM,VALMSG)="Cannot renew Rx # "_PSORENW("ORX #")_", Max number reached.",VALMBCK="R"
 . S PSORENW("DFLG")=1
 .I $G(OR0)]"" D
 ..S DRG=$P(^PSDRUG($P(^PSRX(PSORENW("OIRXN"),0),"^",6),0),"^")
 ..W ! S DIR(0)="Y",DIR("A",1)="Do you want to Discontinue this Pending Order",DIR("A")="for "_DRG,DIR("B")="No"
 ..D ^DIR I 'Y!($D(DIRUT)) Q
 ..D NOOR^PSOCAN4 Q:$D(DIRUT)  D DE^PSOORFI2
 .K ACOM Q
 D CHKDIV G:PSORENW("DFLG") CHECKX
 ;
 D CHKPRV^PSOUTIL
CHECKX Q
 ;
CHKDIV ;
 G:$P(PSORENW("RX2"),"^",9)=+PSOSITE CHKDIVX
 W !?5,$C(7),"RX # ",$P(PSORENW("RX0"),"^")," is for (",$P(^PS(59,$P(PSORENW("RX2"),"^",9),0),"^"),") division."
 I '$P($G(PSOSYS),"^",2) S PSORENW("DFLG")=1 G CHKDIVX
 D:$P($G(PSOSYS),"^",3) DIR
CHKDIVX Q
 ;
DRUG ;
 K PSOY
 S PSOY=PSORENW("DRUG IEN"),PSOY(0)=^PSDRUG(PSOY,0),PSORENWD=1
 I '$P($G(^PSDRUG(PSOY,2)),"^") D  Q:$G(PSORX("DFLG"))
 .I $P($G(^PSRX(PSORENW("OIRXN"),"OR1")),"^") S PSODRUG("OI")=$P(^PSRX(PSORENW("OIRXN"),"OR1"),"^"),PSODRUG("OIN")=$P(^PS(50.7,+^("OR1"),0),"^") Q
 .W !!,"Cannot Renew!!  No Pharmacy Orderable Item!" S VALMSG="Cannot Renew!!  No Pharmacy Orderable Item!",PSORX("DFLG")=1
 D SET^PSODRG
 D POST^PSODRG D:'PSORX("DFLG") DOSCK^PSODOSUT("R") S:$G(PSORX("DFLG")) PSORENW("DFLG")=1 ;remove order checks for v7. do allergy checks only
 S PSONOOR=PSORENW("NOO")
 K PSORX("INTERVENE")
 S:$D(PSONEW("STATUS")) PSORENW("STATUS")=PSONEW("STATUS")
 K PSOY,PSONEW("STATUS"),PSORENWD
 Q
 ;
RXN ;
 K PSOX
 S PSOX=$E(PSORENW("ORX #"),$L(PSORENW("ORX #")))
 S PSORENW("NRX #")=$S(PSOX?1N:PSORENW("ORX #")_"A",1:$E(PSORENW("ORX #"),1,$L(PSORENW("ORX #"))-1)_$C($A(PSOX)+1))
RETRY I $O(^PSRX("B",PSORENW("NRX #"),0)) D  G:'$G(PSORENW("DFLG")) RETRY
 .W:$A($E(PSORENW("NRX #"),$L(PSORENW("ORX #"))))'=90 !,"Rx # "_PSORENW("NRX #")_" is already on file."
 .S:$G(PSOFDR) VALMSG="Rx # "_PSORENW("NRX #")_" is already on file."
 .I $A($E(PSORENW("NRX #"),$L(PSORENW("ORX #"))))=90 D
 ..W !,"Rx # "_PSORENW("NRX #")_" is already on file. Cannot renew Rx #"_PSORENW("ORX #")_".",!,"A new Rx must be entered.",!
 ..S:$G(PSOFDR) VALMSG="Rx # "_PSORENW("NRX #")_" is already on file. Cannot renew Rx #"_PSORENW("ORX #")_". A new Rx must be entered."
 ..K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR K DIR
 ..S:$G(POERR)!($G(PSOFDR)) VALMSG="Cannot renew Rx # "_PSORENW("ORX #")_", Max number reached.",VALMBCK="R" S PSORENW("DFLG")=1
 .S PSOX=$E(PSORENW("NRX #"),$L(PSORENW("NRX #")))
 .S PSORENW("NRX #")=$S(PSOX?1N:PSORENW("NRX #")_"A",1:$E(PSORENW("NRX #"),1,$L(PSORENW("NRX #"))-1)_$C($A(PSOX)+1))
RXNX K PSOX
 Q
 ;
FILDATE ;
 S PSORENW("IRXN")=PSORENW("OIRXN")
 D NEXT^PSOUTIL(.PSORENW)
 I PSORENW("FILL DATE")<$P(PSORENW("RX3"),"^",2) D
 .D RENFDT^PSOUTIL(.PSORENW)
 .I PSORENW("FILL DATE")<DT,PSORENW("FILL DATE")<PSORNW("FILL DATE") S (Y,PSORENW("FILL DATE"))=DT X ^DD("DD") S PSORX("FILL DATE")=Y K Y
 K PSORENW("IRXN")
 Q
 ;
EDIT ;
 K DIR,X,Y
 S DIR(0)="Y",DIR("B")=$S($G(DUZ("AG"))'="I":"Y",$G(PSEXDT):"Y",1:"N")
 S DIR("A")="Edit renewed Rx ",DIR("?")="Answer YES to edit the renewed Rx, NO not to."
 D ^DIR K DIR S:$D(DIRUT) PSORENW("DFLG")=1
 G:PSORENW("DFLG") EDITX
 K PSOQUIT,PSORX("FN") I Y S PSORNALL=1 D INIT^PSORENW3,EN^PSOORNE4(.PSORENW) K PSORNALL S:$G(PSOQUIT) PSORENW("DFLG")=1 I '$G(PSORX("FN")) D FULL^VALM1 Q
 Q:$G(PSORX("FN"))
EDITX S PSOEDT=1,VALMBCK="Q" K X,Y,DIRUT,DTOUT,DUOUT S PSORENW("QFLG")=1
 Q
 ;
DELETE ;
 K DA,DIK
 S DA=$O(^PS(52.5,"B",PSORENW("OIRXN"),0)),DIK="^PS(52.5,"
 D ^DIK K DIK,DIC
 Q
 ;
CAN ;
 K REA,DA,MSG
 S REA="C",DA=PSORENW("OIRXN")
 S MSG="Renewed"_$S($G(PSOFDR):" from CPRS",1:"")
 S PSCAN(PSORENW("ORX #"))=DA_"^C"
 D CAN^PSOCAN
 K REA,DA,MSG,PSCAN
 Q
 ;
DIR ;
 S DIR(0)="Y",DIR("A")="CONTINUE ",DIR("B")="N"
 S DIR("?")="Answer YES to Continue, NO to bypass"
 D ^DIR K DIR
 S:$D(DIRUT)!('Y) PSORENW("DFLG")=1
DIRX K DIRUT,DTOUT,DUOUT,X,Y
 Q
NEWPT ;
 S PSOQFLG=0 N PSODFN
 S PSODFN=PSORENW("PSODFN")
 D ^PSOPTPST I PSOQFLG S PSORENW("DFLG")=1,PSOQFLG=0 G NEWPTX
 D PROFILE^PSOREF1
NEWPTX Q
 ;
EN(PSORENW)        ; Entry Point for Batch Barcode Option
 S PSORENRX=$G(PSOBBC("OIRXN"))
 I $G(PSORENRX) D PSOL^PSSLOCK(PSORENRX) I '$G(PSOMSG) D  K DIR,PSOMSG W ! S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue" D ^DIR K DIR W ! Q
 .I $P($G(PSOMSG),"^",2)'="" W $C(7),!!,$P(PSOMSG,"^",2) Q
 .W $C(7),!!,"Another person is editing Rx "_$P($G(^PSRX(PSORENRX,0)),"^")
 K PSOMSG,PSOBBCLK S PSOBARCD=1 D PROCESS K PSOBARCD
 D KLIB^PSORENW1
 I $G(PSORENRX),$G(PSOBBCLK) D PSOUL^PSSLOCK(PSORENRX)
 K PSORENRX,PSOBBCLK
 Q
CDOSE ;Validate Dosage field on Renewal, Copy, Edit
 ;PSOOCPRX must be set to internal Rx number
 Q:'$G(PSOOCPRX)
 N PSOOLP,PSOOKZ
 S PSOOLP="",(PSOOLPF,PSONOSIG)=0 F  S PSOOLP=$O(^PSRX(PSOOCPRX,6,PSOOLP)) Q:PSOOLP=""!(PSOOLPF)  I $P($G(^PSRX(PSOOCPRX,6,PSOOLP,0)),"^")["0.." S PSOOLPD=$P($G(^(0)),"^"),PSOOLPF=1
 Q:PSOOLPF
 S PSOOKZ=0
 I $P($G(^PSRX(PSOOCPRX,"SIG")),"^",2) S PSOOLP="" F  S PSOOLP=$O(^PSRX(PSOOCPRX,"SIG1",PSOOLP)) Q:PSOOLP=""!(PSOOKZ)  I $G(^PSRX(PSOOCPRX,"SIG1",PSOOLP,0))'="" S PSOOKZ=1
 I '$P($G(^PSRX(PSOOCPRX,"SIG")),"^",2),$P($G(^("SIG")),"^")'="" S PSOOKZ=1
 I 'PSOOKZ S PSONOSIG=1
 Q
 ;
