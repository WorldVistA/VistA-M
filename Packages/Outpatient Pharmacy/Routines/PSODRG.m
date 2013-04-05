PSODRG ;IHS/DSD/JCM - ORDER ENTRY DRUG SELECTION ; 2/16/12 12:50pm
 ;;7.0;OUTPATIENT PHARMACY;**20,23,36,53,54,46,112,139,207,148,243,268,324,251,375,387,398,390**;DEC 1997;Build 86
 ;Reference ^PSDRUG supported by DBIA 221
 ;Reference ^PS(50.7 supported by DBIA 2223
 ;Reference to PSSDIN supported by DBIA 3166
 ;Reference to $$NDCFMT^PSSNDCUT supported by IA 4707
 ;Reference to OROCAPI controlled subscription supported by IA 5367
 ;Reference to $$OITM^ORX8 supported by IA 5469
 ;Reference to ^VADPT supported by IA 10061
 ;Reference to IN^PSSHRQ2 supported by DBIA 5369
 ;----------------------------------------------------------
START ;
 S (PSONEW("DFLG"),PSONEW("FIELD"),PSODRG("QFLG"))=0 K PSORX("DFLG")
 D @($S(+$G(PSOEDIT)=1&('$D(DA)):"SELECT^PSODRGN",1:"SELECT"))
 G:$G(PSORXED("DFLG")) END ; Select Drug
 I $G(PSORX("EDIT")),$G(PSOY),$G(PSODRUG("IEN"))=+PSOY D  G:$G(PSORXED("DFLG")) END
 . N NDC D NDC(+$G(PSORXED("IRXN")),0,+PSOY,.NDC) I $G(NDC)="^" S PSORXED("DFLG")=1 Q
 . I $G(NDC)'="" S (PSODRUG("NDC"),PSORXED("FLD",27))=NDC
 ;
 I $G(PSORX("EDIT"))]"",'PSONEW("FIELD") D TRADE
 G:$G(PSONEW("DFLG"))!($G(PSODRG("QFLG")))!($G(PSORXED("DFLG"))) END
 D SET ; Set various drug information
 D NFI ; Display dispense drug/orderable item text
 D:'$G(PSOEDIT) POST I $G(PSORX("DFLG")) S PSONEW("DFLG")=1 K:'$G(PSORX("EDIT")) PSORX("DFLG") ; Do any post selection action
END ;D EOJ
 Q
 ;------------------------------------------------------------
 ;
SELECT ;
 K:'$G(PSORXED) CLOZPAT
 K IT,DIC,X,Y,PSODRUG("TRADE NAME"),PSODRUG("NDC"),PSODRUG("DAW"),PSODRUG("BAD") S:$G(POERR)&($P($G(OR0),"^",9)) Y=$P(^PSDRUG($P(OR0,"^",9),0),"^")
 I $G(PSODRUG("IEN"))]"" S Y=PSODRUG("NAME"),PSONEW("OLD VAL")=PSODRUG("IEN")
 W !,"DRUG: "_$S($G(Y)]"":Y_"// ",1:"") R X:$S($D(DTIME):DTIME,1:300) I '$T S DTOUT=1
 I X="",$G(Y)]"" S:Y X=Y S:'X X=$G(PSODRUG("IEN")) S:X X="`"_X
 G:X="" SELECT
 I X?1."?" W !!,"Answer with DRUG NUMBER, or GENERIC NAME, or VA PRODUCT NAME, or",!,"NATIONAL DRUG CLASS, or SYNONYM" G SELECT
 I $G(PSORXED),X["^" S PSORXED("DFLG")=1 G SELECTX
 I X="^"!(X["^^")!($D(DTOUT)) S PSONEW("DFLG")=1 G SELECTX
 I '$G(POERR),X[U,$L(X)>1 S PSODIR("FLD")=PSONEW("FLD") D JUMP^PSODIR1 S:$G(PSODIR("FIELD")) PSONEW("FIELD")=PSODIR("FIELD") K PSODIR S PSODRG("QFLG")=1 G SELECTX
 S DIC=50,DIC(0)="EMQZVT",DIC("T")="",D="B^C^VAPN^VAC"
 S DIC("S")="I $S('$D(^PSDRUG(+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0),$S($P($G(^PSDRUG(+Y,2)),""^"",3)'[""O"":0,1:1),$D(^PSDRUG(""ASP"",+$G(^(2)),+Y))"
 D MIX^DIC1 K DIC,D
 I $D(DTOUT) S PSONEW("DFLG")=1 G SELECTX
 I $D(DUOUT) K DUOUT G SELECT
 I Y<0 G SELECT
 S:$G(PSONEW("OLD VAL"))=+Y&('$G(PSOEDIT)) PSODRG("QFLG")=1
 K PSOY S PSOY=Y,PSOY(0)=Y(0)
 I $P(PSOY(0),"^")="OTHER DRUG"!($P(PSOY(0),"^")="OUTSIDE DRUG") D TRADE
SELECTX K X,Y,DTOUT,DUOUT,PSONEW("OLD VAL")
 Q
 ;
NDC(RX,RFL,DRG,NDC) ; Editing NDC for ECME Released Rx's
 S NDC=$S($G(NDC)'="":$G(NDC),1:$$GETNDC^PSONDCUT(RX,.RFL))
 I $$STATUS^PSOBPSUT(RX,RFL)="" Q
 I '$$RXRLDT^PSOBPSUT(RX,RFL) Q
 ;
 S NDC=$S($G(NDC)'="":$G(NDC),1:$$GETNDC^PSONDCUT(RX,.RFL))
 D NDCEDT^PSONDCUT(RX,.RFL,$G(DRG),$G(PSOSITE),.NDC)
 Q
 ;
TRADE ;
 K DIR,DIC,DA,X,Y
 S DIR(0)="52,6.5" S:$G(PSOTRN)]"" DIR("B")=$G(PSOTRN) D ^DIR K DIR,DIC
 I X="@" S Y=X K DIRUT
 I $D(DIRUT) S:$D(DUOUT)!$D(DTOUT)&('$D(PSORX("EDIT"))) PSONEW("DFLG")=1 G TRADEX
 S PSODRUG("TRADE NAME")=Y
TRADEX I $G(PSORXED("DFLG")),$D(DIRUT) S PSORXED("DFLG")=1
 K DIRUT,DTOUT,DUOUT,X,Y,DA,DR,DIE
 Q
SET ;
 N STAT S PSODRUG("IEN")=+PSOY,PSODRUG("VA CLASS")=$P(PSOY(0),"^",2)
 S PSODRUG("NAME")=$P(PSOY(0),"^")
 S:+$G(^PSDRUG(+PSOY,2)) PSODRUG("OI")=+$G(^(2)),PSODRUG("OIN")=$P(^PS(50.7,+$G(^(2)),0),"^")
 S PSODRUG("NDF")=$S($G(^PSDRUG(+PSOY,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 S PSODRUG("MAXDOSE")=$P(PSOY(0),"^",4),PSODRUG("DEA")=$P(PSOY(0),"^",3)
 S PSODRUG("CLN")=$S($D(^PSDRUG(+PSOY,"ND")):+$P(^("ND"),"^",6),1:0)
 S PSODRUG("SIG")=$P(PSOY(0),"^",5)
 I $G(PSODRUG("NDC"))="" S PSODRUG("NDC")=$$GETNDC^PSSNDCUT(+PSOY,$G(PSOSITE))
 S PSODRUG("DAW")=+$$GET1^DIQ(50,+PSOY,81)
 S PSODRUG("STKLVL")=$G(^PSDRUG(+PSOY,660.1))
 G:$G(^PSDRUG(+PSOY,660))']"" SETX
 S PSOX1=$G(^PSDRUG(+PSOY,660))
 S PSODRUG("COST")=$P($G(PSOX1),"^",6)
 S PSODRUG("UNIT")=$P($G(PSOX1),"^",8)
 S PSODRUG("EXPIRATION DATE")=$P($G(PSOX1),"^",9)
SETX K PSOX1,PSOY
 Q
NFI ;display restriction/guidelines
 D EN^PSSDIN(PSODRUG("OI"),PSODRUG("IEN")) S NFI=$$PROMPT^PSSDIN
 I NFI]"","ODY"[NFI D TD^PSONFI
 K NFI Q
POST ;order checks
 N LIST S LIST="PSOPEPS"
 K PSODOSD,^TMP("PSORXDC",$J),^TMP($J,LIST)
 K ZDGDG,ZTHER,IT,PSODLQT,PSODOSD
 S ^TMP($J,LIST,"IN","PING")="" D IN^PSSHRQ2(LIST)
 K DIR I $P(^TMP($J,LIST,"OUT",0),"^")=-1 D DATACK^PSODDPRE
 K ^TMP($J,LIST,"IN"),^TMP($J,LIST,"OUT","EXCEPTIONS")
 G:$G(PSORX("DFLG"))!($G(PSORXED("DFLG"))) POSTX
 K PSORX("INTERVENE") N STAT,SIG,PTR,NDF,VAP S PSORX("DFLG")=0
 W !! D HD^PSODDPR2():(($Y+5)'>IOSL)
 D ^PSOBUILD
 D:'$D(PSODGCK) @$S($G(COPY):"^PSOCPPRE",1:"^PSODDPRE") ; Duplicate drug check
 G:$G(PSORX("DFLG")) POSTX
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 I $P($G(^PSDRUG(PSODRUG("IEN"),"CLOZ1")),"^")="PSOCLO1" W !,"Now doing Clozapine Order checks.  Please wait...",! D CLOZ
 G:PSORX("DFLG") POSTX
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 W !,"Now doing allergy checks.  Please wait...",!
 S PSONOAL="" D ALLERGY^PSOORUT2 D:PSONOAL'="" NOALRGY K PSONOAL
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 G:PSORX("DFLG") POSTX
 I '$D(PSODGCKX) D ^PSODGAL1 K PSORX("INTERVENE")
 ;This is the allergy check for profile drugs
 I $D(PSODGCK),$D(PSOSD) D PRFLP^PSOUTL
 ;aminoglycoside
 N AOC
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 S AOC=$$AOC^OROCAPI(PSODFN,$P(PSODRUG("NDF"),"A",2)) I $P(AOC,"^",4)]"" D
 .W !!,"***Aminoglycoside Ordered***",!!
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=78,DIWF="" S X=$P(AOC,"^",4) D ^DIWP
 .W !! F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?2,^UTILITY($J,"W",1,ZX,0),! D HD^PSODDPR2():(($Y+5)'>IOSL)
 .K ^UTILITY($J,"W")
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 ;dangerous meds for pat >64
 I $G(PSODRUG("OI")) D
 .N OI,OIR S OI=$$OITM^ORX8(PSODRUG("OI"),"99PSP") Q:'OI
 .S OIR=$$DOC^OROCAPI(PSODFN,OI) I $P(OIR,"^",4)]"" D
 ..D HD^PSODDPR2():(($Y+5)'>IOSL) W !!,"***Dangerous Meds for Patient >64***",!! S DFN=PSODFN D DEM^VADPT
 ..K ^UTILITY($J,"W") S DIWL=1,DIWR=78,DIWF="" S X=$P(OIR,"^",4) D ^DIWP
 ..F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?2,^UTILITY($J,"W",1,ZX,0),! D HD^PSODDPR2():(($Y+5)'>IOSL)
 ..K ^UTILITY($J,"W")
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 ;metformin lab results
 N GOC S GOC=$$GOC^OROCAPI(PSODFN,PSODRUG("NAME")) I $P(GOC,"^",4)]"" D
 .W !!,"***Metformin Lab Results***",!!
 .K ^UTILITY($J,"W") S DIWL=1,DIWR=78,DIWF="" S X=$P(GOC,"^",4) D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W ?2,^UTILITY($J,"W",1,ZX,0),! D HD^PSODDPR2():(($Y+5)'>IOSL)
 .K ^UTILITY($J,"W")
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 K DIWF,DIWL,DIWR,ZX,DFN
 I $G(PSODRUG("DEA"))["S"!($E($G(PSODRUG("VA CLASS")),1,2)="XA") D  G POSTX ;stops if drug is supply
 .W !,"Now Processing Enhanced Order Checks!  Please wait...",! H 1
 ;enhanced OC
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 W ! D @$S($G(COPY):"OBX^PSOCPPRE",1:"OBX^PSODDPRE") ; Set PSORX("DFLG")=1 if process to stop new enhanced order checks
POSTX ;
 K IT,^TMP($J,"DI"),PSORX("INTERVENE"),DA,^TMP($J,"PSODRDI"),ZDGDG,ZTHER K ^TMP($J,"DI"_PSODFN),PSZZQUIT
 Q
 ;
EOJ ;
 K PSODRG
 Q
WAIT ;
 K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue..." W !
 D ^DIR K DIRUT,DUOUT,DIR,X,Y
 Q
 ;
CLOZ ;
 S ANQRTN=$P(^PSDRUG(PSODRUG("IEN"),"CLOZ1"),"^"),ANQX=0
 S P(5)=PSODRUG("IEN"),DFN=PSODFN,X=ANQRTN
 X ^%ZOSF("TEST") I  D @("^"_ANQRTN) S:$G(ANQX) PSORX("DFLG")=1
 K P(5),ANQRTN,ANQX,X,DFN
 Q
 ;
EN(DRG) ;returns lab test identified for clozapine order checking
 K LAB I $P($G(^PSDRUG(DRG,"CLOZ1")),"^")'="PSOCLO1" S LAB("NOT")=0 Q
 I $P($G(^PSDRUG(DRG,"CLOZ1")),"^")="PSOCLO1" D
 .S (CNT,I)=0 F  S I=$O(^PSDRUG(DRG,"CLOZ2",I)) Q:'I  S CNT=$G(CNT)+1
 .I CNT'=2 S LAB("BAD TEST")=0 K CNT Q
 .K CNT F I=0:0 S I=$O(^PSDRUG(DRG,"CLOZ2",I)) Q:'I  D
 ..S LABT=$S($P(^PSDRUG(DRG,"CLOZ2",I,0),"^",4)=1:"WBC",1:"ANC"),LAB(LABT)=$P(^PSDRUG(DRG,"CLOZ2",I,0),"^")_"^"_$P(^(0),"^",3)_"^"_$P(^(0),"^",4)
 K LABT,I
 Q
NOALRGY ;
 D HD^PSODDPR2():(($Y+5)'>IOSL)
 N DIR S DIR(0)="SA^1:YES;0:NO"
 I $D(^TMP($J,"PSOINTERVENE",+PSODFN)) D  Q
 .S DIR("A")="No Allergy Assessment - Do you want to duplicate Intervention?: ",DIR("B")="Yes"
 .D ^DIR
 .I 'Y D  Q
 ..I Y=0 D ^PSORXI Q
 ..S PSORX("DFLG")=1
 .D DUPINV^PSORXI
 W $C(7),!,"There is no allergy assessment on file for this patient."
 W !,"You will be prompted to intervene if you continue with this prescription"
 I $D(PSODGCK) W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue..." D ^DIR K DIR
 Q:$D(PSODGCK)
 N DUOUT,DTOUT,RXIEN,RXSTA               ;*398
 S DIR("A")="Do you want to Continue?: ",DIR("B")="N" D ^DIR
 I 'Y!($D(DUOUT))!($D(DTOUT)) D  Q       ;*398 - Exit/Timeout
 .I $D(PSONV) S PSZZQUIT=1 Q
 .S PSORX("DFLG")=1
 .I '$O(PSCAN(0)) Q                      ;*398 - Array has Rx IEN
 .I $G(REA)'="R" Q                       ;*398 - Reinstate only
 .S RXIEN=+$G(PSCAN(RX)) I 'RXIEN Q      ;*398 - Get Rx IEN
 .S RXSTA=$$GET1^DIQ(52,RXIEN,100,"I")   ;*398 - Get status
 .I RXSTA=12 Q                           ;*398 - Correct status
 .S DIE="^PSRX(",DA=RXIEN,DR="100///12"  ;*398 - Discontinued
 .D ^DIE                                 ;*398 - Update Rx file
 I $D(PSONV) S PSORX("INTERVENE")=0 D EN1^PSORXI(PSONV) Q
 D ^PSORXI
 Q
