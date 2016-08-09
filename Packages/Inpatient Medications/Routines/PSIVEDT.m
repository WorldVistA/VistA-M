PSIVEDT ;BIR/MLM - EDIT IV ORDER ;2/10/98 3:23 PM
 ;;5.0;INPATIENT MEDICATIONS;**4,110,127,133,134,181,252,281**;16 DEC 97;Build 113
 ;
 ; Reference to ^PS(53.1 is supported by DBIA 2256.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
EDIT ;
 ;Store the DRG array.  If it changed then to do an OC
 NEW TMPDRG,PSJFLG57,PSIVE,PSIALLFL
 D SAVEDRG^PSIVEDRG(.TMPDRG,.DRG)
 I $G(DFN)&($G(PSJORD)["V") I $$COMPLEX^PSJOE(DFN,PSJORD) D
 . N X,Y,PARENT,P2ND S P2ND=$S($G(^PS(55,PSGP,"IV",+PSJORD,.2)):$G(^PS(55,PSGP,"IV",+PSJORD,.2)),1:$G(^PS(55,PSGP,5,+PSJORD,.2)))
 . S PARENT=$P(P2ND,"^",8)
 . I PARENT D FULL^VALM1 W !!?5,"This order is part of a complex order. Please review the following ",!?5,"associated orders before changing this order." D CMPLX^PSJCOM1(PSGP,PARENT,PSJORD)
 S DONE=0
 F PSIVE=1:1 S:DONE&$E(PSIVAC)="C" OREND=1 Q:PSIVE>$L(EDIT,U)!(DONE)  Q:'$L($P(EDIT,U,PSIVE))  D @($P(EDIT,U,PSIVE)) S:$E(PSIVAC,2)="N" PSIVOK=PSIVOK_U_$P(EDIT,U,PSIVE) I $E(X)=U,$L(X)>1 S:PSIVE>1 PSIVE=PSIVE-1 F  D FF Q:Y<0  D @Y Q:$E(X)'=U
 I $G(PSGORQF) K PSIVEDIT S PSJOCCHK=1,PSIVENO=1 ;RTC 151046
 I '$G(PSGORQF),$G(PSJOCCHK) K PSJOCCHK,PSIVENO D OC^PSIVOC
 K EDIT,PSIVOK,PSGDI
 ;If quit then restore DRG( to pre-edit state
 I $G(PSGORQF) D SAVEDRG^PSIVEDRG(.DRG,.TMPDRG)
 Q
 ;
1 ; Provider.
 I $G(P("RES"))="R" I $G(PSJORD)["P",$P($G(^PS(53.1,+$G(ON),0)),"^",24)="R" D  Q
 . W !!?5,"This is Renewal order. Provider may not be edited at this point." D PAUSE^VALM1
 I $G(DFN)&($G(ON)["V") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Provider may not be edited at this point." D PAUSE^VALM1
 S P(6)=$S('$G(^VA(200,+P(6),"PS")):"",'$P(^("PS"),U,4):P(6),$P(^("PS"),U,4)<DT:"",1:P(6))
 W !,"PROVIDER: "_$S($P(P(6),U,2)]"":$P(P(6),U,2)_"//",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I $E(X)=U!(X=""&P(6)) Q
 I X["???",($E(P("OT"))="I"),(PSIVAC["C") D ORFLDS^PSIVEDT1 G 1
 I X]"" K DIC S DIC=200,DIC(0)="EQMZ",DIC("S")="I $D(^(""PS"")),^(""PS""),$S('$P(^(""PS""),U,4):1,$P(^(""PS""),U,4)>DT:1,1:0)" D ^DIC K DIC I Y>0 S P(6)=+Y_U_Y(0,0) Q
 S F1=53.1,F2=1 D ENHLP^PSIVORC1 W $C(7),!!,"A Provider must be entered.",!! G 1
 Q
 ;
3 ; Med Route.
 I $G(P("RES"))="R" I $G(PSJORD)["P",$P($G(^PS(53.1,+ON,0)),"^",24)="R" D  Q
 . W !!?5,"Med Route may not be edited at this point." D PAUSE^VALM1
 I $G(DFN)&($G(ON)["V") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Med Route may not be edited at this point." D PAUSE^VALM1
 S P(6)=$S('$G(^VA(200,+P(6),"PS")):"",'$P(^("PS"),U,4):P(6),$P(^("PS"),U,4)<DT:"",1:P(6))
 I P("MR")="" D
 .N AD,SOL,OI,RT,RTCNT
 .S AD=0 F  S AD=$O(DRG("AD",AD)) Q:'AD  S OI=$P(DRG("AD",AD),"^",6) I OI S OI(OI)=""
 .S SOL=0 F  S SOL=$O(DRG("SOL",SOL)) Q:'SOL  S OI=$P(DRG("SOL",SOL),"^",6) I OI S OI(OI)=""
 .S OI="" F  S OI=$O(OI(OI)) Q:'OI  S RT=$P(^PS(50.7,OI,0),"^",6) S:RT="" RT="NONE" S RT(RT)=$P($G(^PS(51.2,+RT,0)),"^",3)
 .S RT="" F RTCNT=0:1 S RT=$O(RT(RT)) Q:RT=""
 .Q:RTCNT>1
 .S RT=$O(RT("")) I RT]"" S P("MR")=RT_"^"_$G(RT(RT))
 W !,"MED ROUTE: "_$S($P(P("MR"),U,2)]"":$P(P("MR"),U,2)_"//",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I X=U!(X=""&P("MR"))!($E(X)=U) Q
 I X["???",($E(P("OT"))="I"),(PSIVAC["C") D ORFLDS^PSIVEDT1 G 3
 I X]"" K DIC S DIC=51.2,DIC(0)="EQMZ",DIC("S")="I $P(^(0),U,4)" D ^DIC K DIC I Y>0 S P("MR")=+Y_U_$P(Y(0),U,3) S:$E($G(PSJOCFG),1,2)="FN" PSJFNDS=1 Q
 S F1=53.1,F2=3 D ENHLP^PSIVORC1 W $C(7),!!,"A Med Route must be entered." G 3
 Q
 ;
10 ; Start Date.
 D 10^PSIVEDT1
 I $E($G(PSJOCFG),1,2)="FN" S PSJFNDS=1
 Q
 ;
25 ; Stop Date.
 D 25^PSIVEDT1
 I $E($G(PSJOCFG),1,2)="FN" S PSJFNDS=1
 Q
26 ; Schedule
 D 26^PSIVEDT1
 Q
 ;
39 ; Admin Times.
 D 39^PSIVEDT1
 Q
 ;
57 ; Additive.
 I $G(P("RES"))="R" I $G(PSJORD)["P",$P($G(^PS(53.1,+ON,0)),"^",24)="R" D  Q
 . W !!?5,"Additive may not be edited at this point." D PAUSE^VALM1
 I $G(DFN)&($G(ON)["V") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Provider may not be edited at this point." D PAUSE^VALM1
 I $E(PSIVAC)="O" W !!,"Only additives marked for use in IV Fluid Order Entry may be selected."
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 S FIL=52.6,DRGT="AD",DRGTN="ADDITIVE" D DRG^PSIVEDRG,DKILL
 ;I $G(X)="^" G DKILL
 ;If Solution prompt is next then wait to do dose checks after all solutions are entered.
 ;PSJFLG57 is set so OC is triggered when the user entered ^ADDITIVE.
 I $$COMPARE^PSJMISC(.DRG,.TMPDRG) D
 . D ENSTOP^PSIVCAL
 . I $S($G(PSJFLG57):1,($G(EDIT)'["58"):1,1:0) K PSJFLG57,PSJOCCHK D OC^PSIVOC S:$G(EDIT)]"" PSJENHOC=1
 I $G(X)="^" G DKILL
 Q
 ;
58 ; Solution.
 NEW PSJCMPFG
 I $G(P("RES"))="R" I $G(PSJORD)["P",$P($G(^PS(53.1,+ON,0)),"^",24)="R" D  Q
 . W !!?5,"Solution may not be edited at this point." D PAUSE^VALM1
 S FIL=52.7,DRGT="SOL",DRGTN="SOLUTION" D DRG^PSIVEDRG
 ;I $G(X)="^" G DKILL
 ;I $G(X)']"^",$$COMPARE^PSJMISC(.DRG,.TMPDRG) D OC^PSIVOC
 S PSJCMPFG=$$COMPARE^PSJMISC(.DRG,.TMPDRG)
 I 'PSJCMPFG,$$COMPARE^PSJMISC(.DRG,.TMPDRG,1) D
 . NEW X,PSJALLGY
 . K PSJALLGY
 . D SETDD^PSIVOC(1)
 . D GMRAOC^PSJOC S:'$G(PSGORQF) PSIALLFL=1
 . K PSJALLGY
 Q:$G(PSGORQF)
 I PSJCMPFG K PSJOCCHK D ENSTOP^PSIVCAL D OC^PSIVOC S:$G(EDIT)]"" PSJENHOC=1
 K PSJCMPFG
 I $G(X)="^" G DKILL
 ;
DKILL ; Kill for drug edit.
 K DRGI,DRGN,DRGT,DRGTN,FIL,PSIVSTR
 Q
 ;
59 ; Infusion Rate.
 D 59^PSIVEDT1
 Q
 ;
62 ; IV Room.
 N DIR S DIR(0)="PA^59.5",DIR("A")="IV Room: ",DIR("??")="^S F1=59.5,F2=.01 D ENHLP^PSIVORC1" S:P("IVRM") DIR("B")=$P(P("IVRM"),U,2)
 D ^DIR Q:$D(DIRUT)  I Y>0 S P("IVRM")=Y W $P($P(Y,U,2),X,2)
 Q
 ;
63 ; Remarks.
 D 63^PSIVEDT1
 Q
 ;
64 ; Other Print Info.
 D 64^PSIVEDT1
 Q
 ;
66 ; Provider's comments.
 N DA,DIE,DIR,DR S DA=PSIVUP,DIE="^PS(53.45,",DR=4 D ^DIE S PSGSI=X,Y=1
 Q
 ;
101 ; Orderable Item.
 I $G(P("RES"))="R" I $G(PSJORD)["P",$P($G(^PS(53.1,+ON,0)),"^",24)="R" D  Q
 . W !!?5,"This is Renewal order. Orderable Item may not be edited at this point." D PAUSE^VALM1
 I $G(DFN)&($G(ON)["V") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Orderable Item may not be edited at this point." D PAUSE^VALM1
 W !,"Orderable Item: "_$S(P("PD"):$P(P("PD"),U,2)_"//",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I $E(X)=U!(X=""&P("PD")) Q
 I X]"" N DIC S DIC="^PS(50.7,",DIC(0)="EMQZ",DIC("B")=$S(P("PD")]"":+$P(("PD"),U),1:""),DIC("S")="S PSJSCT=1 I $$DRGSC^PSIVUTL(Y,PSJSCT) K PSJSCT" D ^DIC K DIC I Y>0 S P("PD")=Y Q
 W $C(7),!!,"Orderable Item is required!",!! G 101
 Q
109 ; Dosage Ordered.
 W !,"DOSAGE ORDERED: "_$S(P("DO")]"":P("DO")_"//",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I $E(X)=U!(P("DO")]""&(X="")) Q
 I X="???" D ORFLDS^PSIVEDT1 G 109
 D:X]"" CHK^DIE(53.1,109,"",X,.X) I $G(X)="^" W $C(7),!!,"Enter the dosage in which the Orderable Item entered should be dispensed.",! W "Answer must be 1-20 characters in length." G 109
 S P("DO")=X
 Q
 ;
FF ; up-arrow to another field.
 N DIC S X=$P(X,U,2),DIC="^DD(53.1,",DIC(0)="QEM",DIC("S")="I U_PSIVOK_U[(U_+Y_U)" D ^DIC K DIC S Y=+Y
 I Y=57 S PSJFLG57=1
 Q
 ;
NEWDRG ; Ask if adding a new drug.
 K DIR S DIR(0)="Y",DIR("A")="Are you adding "_$P(TDRG,U,2)_" as a new "_$S(DRGT="AD":"additive",1:"solution")_" for this order",DIR("B")="NO" D ^DIR I $D(DTOUT)!$D(DUOUT) Q
 I Y S (DRGI,DRG(DRGT,0))=DRG(DRGT,0)+1,DRG=TDRG,DRG(DRGT,+DRGI)=+DRG_U_$P(DRG,U,2) I DRGT="SOL" S X=$G(^PS(52.7,+DRG,0)),$P(DRG(DRGT,DRG),U,3)=$P(X,U,3)
 Q
