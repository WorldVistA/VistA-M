PSSPOIMO ;BIR/RTR/WRT-Edit Orderable Item Name and Inactive date ;05/12/17  07:11
 ;;1.0;PHARMACY DATA MANAGEMENT;**29,32,38,47,68,102,125,141,153,159,166,172,191,189,204,210**;9/30/97;Build 9
 S PSSITE=+$O(^PS(59.7,0)) I +$P($G(^PS(59.7,PSSITE,80)),"^",2)<2 W !!?3,"Orderable Item Auto-Create has not been completed yet!",! K PSSITE K DIR S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR Q
 K PSSITE W !!,"This option enables you to edit Orderable Item names, Formulary status,",!,"drug text, Inactive Dates, Indications for Use, and Synonyms."
EN I $D(PSOIEN) L -^PS(50.7,PSOIEN)
 K PSSCROSS,DTOUT,DUOUT,DIRUT
 K DIC ; S PY=$P($G(^PS(59.7,1,31)),"^",2)
 S PSS1="W ""  ""_$P(^PS(50.606,$P(^PS(50.7,+Y,0),""^"",2),0),""^"")_""  ""_$S($P($G(^PS(50.7,+Y,0)),""^"",4):$E($P(^(0),""^"",4),4,5)_""-""_$E($P(^(0),""^"",4),6,7)_""-""_$E($P(^(0),""^"",4),2,3),1:"""")"
 S PSS2=" S NF=$P($G(^PS(50.7,+Y,0)),""^"",12) I NF S NF=""   N/F"" W NF"
 S DIC("W")=PSS1_PSS2,DIC("S")="I '$P($G(^PS(50.7,+Y,0)),""^"",3)"
 ;PSO*7*102;ONLY SEARCH B AND C X-REFS
 S $P(PLINE,"-",79)="" W !! K PSOUT S DIC="^PS(50.7,",DIC(0)="QEAMZ",D="B^C" D MIX^DIC1 K DIC,PY,D G:Y<0!($D(DTOUT))!($D(DUOUT)) END
 S PSOIEN=+Y,PSOINAME=$P(Y,"^",2),PSDOSE=+$P(^PS(50.7,PSOIEN,0),"^",2) L +^PS(50.7,PSOIEN):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T W !,$C(7),"Another person is editing this one." Q
 W !!!,?5,"Orderable Item -> ",PSOINAME,!?5,"Dosage Form    -> ",$P($G(^PS(50.606,PSDOSE,0)),"^"),!
 K DIR S DIR("?")=" ",DIR("?",1)="Enter 'Yes' to see all of the Dispense Drugs, IV Additives, and IV Solutions",DIR("?",2)="that are matched to this Orderable Item. IV Additives will be identified with"
 S DIR("?",3)="an (A), and IV Solutions with an (S)."
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="List all Drugs/Additives/Solutions tied to this Orderable Item" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) G EN
 I Y D DISP
EDIT K DIR W ! S DIR(0)="Y",DIR("A")="Are you sure you want to edit this Orderable Item",DIR("B")="NO",DIR("?")="Answer YES to edit the fields associated with this Orderable Item." D ^DIR K DIR I 'Y!($D(DTOUT))!($D(DUOUT)) G EN
 W !!?3,"Now editing Orderable Item:",!?3,PSOINAME,"   ",$P($G(^PS(50.606,PSDOSE,0)),"^")
DIR K DIR S DIR(0)="F^3:40",DIR("B")=PSOINAME,DIR("A")="Orderable Item Name" D ^DIR
 I Y["^"!($D(DUOUT))!($D(DTOUT)) G EN
 I X[""""!($A(X)=45)!('(X'?1P.E))!(X?2"z".E) W $C(7),!!?5,"??" G DIR
 I X'=PSOINAME S ZZFLAG=0 D @$S('$P($G(^PS(50.7,PSOIEN,0)),"^",3):"CHECK",1:"ZCHECK") I ZZFLAG G DIR
 S PSONEW=X,DIE="^PS(50.7,",DA=PSOIEN,DR=".01////"_X D ^DIE I PSONEW'=PSOINAME W !!,"Name changed from  ",PSOINAME,!?15,"to  ",PSONEW
 S PSSDTENT=0 W ! K DIE N MFLG S PSBEFORE=$P(^PS(50.7,PSOIEN,0),"^",4),PSAFTER=0,PSINORDE="" D
 .;If reactivate OI, prompt to reactivate DD's only if there are any, then always give message saying OI now Active. If Inactivate, prompt to inactivate any active DD's if there are any, and give message
 .;but if OI is reactivated, and there are no activities matched to it, and user does not want to activate the drugs, then inactivate the OI again, and give a clear message explaining this.
 .W !,"This Orderable Item is "_$S($P($G(^PS(50.7,PSOIEN,0)),"^",12):"Non-Formulary.",1:"Formulary."),!
 .I $P($G(^PS(50.7,PSOIEN,0)),"^",10) W !,"This Orderable Item is marked as a Non-VA Med.",!
 .S DIE="^PS(50.7,",DA=PSOIEN,DR=6 S PSCREATE=1 D ^DIE K DIE,PSCREATE I $D(DTOUT)!($D(Y)>10) Q
 .;PSS*1*102;ADD DRUG TEXT AS SYNONYM IS REQUESTED BY USER
 .D ADDSYN^PSSPOIMP
 .K DIR S DIR(0)="DO",DIR("A")="INACTIVE DATE" D  D ^DIR K DIR I $G(Y)["^"!($D(DTOUT))!($G(DUOUT)) Q
 ..I $G(PSBEFORE) S Y=PSBEFORE D DD^%DT S DIR("B")=$G(Y)
 .I $G(PSBEFORE),'$G(Y) W ?40,"Inactive Date deleted!"
 .S PSSDTENT=$G(Y) I $G(Y) D DD^%DT W ?40,$G(Y)
 .S PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 .S DIE="^PS(50.7,",DA=PSOIEN N PSSFG,PSSOU
 .S DR=".05;@1;D SETF^PSSPOIMO;.06;D DFR^PSSPOIMO(PSDOSE);10//YES;I X=""Y"" S Y=""@2"";S:$G(DUOUT) Y=""@3"";" D
 ..S DR=DR_"D PDCHK^PSSPOIMO S:PSSFG Y=""@1"";S:$G(DUOUT) Y=""@3"";@2;K DIE(""NO^""),DIRUT;D MRSEL^PSSPOIMO;.07;.08;1;12//0;7;S:'$G(PSSOTH) Y=""@3"";7.1;@3" ;*191
 .S PSCREATE=1 D ^DIE K DIE,PSCREATE,PSSOTH,^TMP("PSJMR",$J),^TMP("PSSDMR",$J) I $D(PSSOU),'$G(PSSOU) D MRSEL K ^TMP("PSJMR",$J)
 .S $P(^PS(50.7,PSOIEN,0),"^",4)=PSSDTENT,PSAFTER=PSSDTENT
 S:PSBEFORE&('$P(^PS(50.7,PSOIEN,0),"^",4)) PSINORDE="D" S:$P(^PS(50.7,PSOIEN,0),"^",4) PSINORDE="I"
 I PSINORDE'="" D CHECK^PSSPOID2(PSOIEN) D
 .I PSINORDE="D" D  Q
 ..I $O(PSSDACTI(0))!($O(PSSSACTI(0)))!($O(PSSAACTI(0))) D
 ...W !!,"There are inactive "_$S($O(PSSDACTI(0)):"drugs, ",1:"")_$S($O(PSSAACTI(0)):"additives, ",1:"")_$S($O(PSSSACTI(0)):"solutions,",1:""),!,"matched to this Pharmacy Orderable Item."
 .I $O(PSSDACT(0))!($O(PSSSACT(0)))!($O(PSSAACT(0))) D
 ..W !!,"There are active "_$S($O(PSSDACT(0)):"drugs, ",1:"")_$S($O(PSSAACT(0)):"additives, ",1:"")_$S($O(PSSSACT(0)):"solutions,",1:""),!,"matched to this Pharmacy Orderable Item."
 I $G(PSINORDE)="D" I $O(PSSDACTI(0))!($O(PSSSACTI(0)))!($O(PSSAACTI(0))) D REST^PSSPOIDT(PSOIEN)
 I $G(PSINORDE)="I" I $O(PSSDACT(0))!($O(PSSSACT(0)))!($O(PSSAACT(0))) D REST^PSSPOIDT(PSOIEN)
 S DIK="^PS(50.7,",DA=PSOIEN,DIK(1)=.04 D EN^DIK K DIK
 K PSBEFORE,PSAFTER,PSINORDE,PSSDTENT,PSSDACT,PSSDACTI,PSSSACT,PSSSACTI,PSSAACT,PSSAACTI
 N DIE,DA,DR  ; Indications for Use fields PSS*1*204
 S DIE="^PS(50.7,",DA=PSOIEN,DR="14;13" D ^DIE K DIE
IMMUN ;PSS*1*141 FOR 'IMMUNIZATIONS DOCUMENTATION BY BCMA'
 I $O(^PSDRUG("AOC",PSOIEN,"IM000"))'["IM" G SYN ;ASK WHEN APPROPRIATE
 W ! S DIE="^PS(50.7,",DA=PSOIEN,DR=9 D ^DIE K DIE
SYN I $G(Y)["^"!($G(DIRUT))!$D(DTOUT)!($D(Y)>10) G SYN1
 W ! K DIC S:'$D(^PS(50.7,PSOIEN,2,0)) ^PS(50.7,PSOIEN,2,0)="^50.72^0^0" S DIC="^PS(50.7,"_PSOIEN_",2,",DA(1)=PSOIEN,DIC(0)="QEAMZL",DIC("A")="Select SYNONYM: ",DLAYGO=50.72 D ^DIC K DIC
 I Y<0!($D(DUOUT))!($D(DTOUT)) K:'$O(^PS(50.7,PSOIEN,2,0)) ^PS(50.7,PSOIEN,2,0) D EN^PSSPOIDT(PSOIEN),EN2^PSSHL1(PSOIEN,"MUP") G EN
 W ! S DA=+Y,DIE="^PS(50.7,"_PSOIEN_",2,",DA(1)=PSOIEN,DR=.01 D ^DIE K DIE G SYN
SYN1 ;File
 D EN^PSSPOIDT(PSOIEN),EN2^PSSHL1(PSOIEN,"MUP")
 G EN
END K ZZFLAG,DIC,DIR,DIE,DTOUT,DUOUT,DIRUT,FLAG,PSOINAME,PSOUT,PSDOSE,PSONEW,UPFLAG,VV,ZZ,AA,BB,Y,AAA,SSS,PSOARR,PSOARRAD,PLINE I $D(PSOIEN) L -^PS(50.7,PSOIEN) K PSOIEN
 Q
DISP N PSSLFLAG,PSSLDATE S FLAG=1 D HEAD F ZZ=0:0 S ZZ=$O(^PSDRUG("ASP",PSOIEN,ZZ)) Q:'ZZ!($G(PSOUT))  S FLAG=0 D:($Y+5)>IOSL HEAD Q:$G(PSOUT)  I ZZ W !,$P($G(^PSDRUG(ZZ,0)),"^") W:$P($G(^PSDRUG(ZZ,0)),"^",9) "   N/F" D DTE
 Q:$G(PSOUT)
 S (FLAG,PSSLFLAG)=0
 F ZZ=0:0 S ZZ=$O(^PS(52.6,"AOI",PSOIEN,ZZ)) Q:'ZZ!($G(PSOUT))  D:($Y+5)>IOSL HEAD Q:$G(PSOUT)  I ZZ D
 .S PSSLFLAG=1
 .W !,$P($G(^PS(52.6,ZZ,0)),"^"),?31," (A) "
 .W ?40,"Additive Strength: ",$S($$GET1^DIQ(52.6,ZZ,19)'="":$$GET1^DIQ(52.6,ZZ,19)_" "_$$GET1^DIQ(52.6,ZZ,2),1:"N/A")," "
 .S PSSLDATE=$P($G(^PS(52.6,ZZ,"I")),"^") I PSSLDATE D DTEX
 Q:$G(PSOUT)
 ;I $G(PSSLFLAG) W !
 F ZZ=0:0 S ZZ=$O(^PS(52.7,"AOI",PSOIEN,ZZ)) Q:'ZZ!($G(PSOUT))  D:($Y+5)>IOSL HEAD Q:$G(PSOUT)  I ZZ D
 .W !,$P($G(^PS(52.7,ZZ,0)),"^"),?31,$P($G(^(0)),"^",3),?42,"(S)"
 .S PSSLDATE=$P($G(^PS(52.7,ZZ,"I")),"^") I PSSLDATE D DTEX
 Q
HEAD I 'FLAG W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR I 'Y S PSOUT=1 Q
 W @IOF W !,?6,"Orderable Item ->  ",PSOINAME,!?6,"Dosage Form    ->  ",$P($G(^PS(50.606,+$P($G(^PS(50.7,PSOIEN,0)),"^",2),0)),"^"),!!,"Dispense Drugs:"_$S('FLAG:" (continued)",1:""),!,"---------------"
 Q
ADDIT ;If orderable item is flagged for IV
 S AA=$O(^PS(52.6,"AOI",PSOIEN,0))
 S BB=$O(^PS(52.7,"AOI",PSOIEN,0))
 I 'AA,'BB W $C(7),!,"This Orderable Item is flagged for IV use, but currently there are no IV",!,"Additives or IV Solutions matched to this Orderable Item!" G EDIT
 G SOL
CHECK ;
 S ZZFLAG=0 F VV=0:0 S VV=$O(^PS(50.7,"ADF",X,PSDOSE,VV)) Q:'VV  I VV,'$P($G(^PS(50.7,VV,0)),"^",3) S ZZFLAG=1
 I ZZFLAG W $C(7),!!?5,"There is already an Orderable Item with this same name and Dosage Form",!?5,"that is not flagged as 'IV'. Use the 'DISPENSE DRUG/ORDERABLE ITEM",!?5,"MAINTENANCE' option if you want to re-match to this Orderable Item!",!
 Q
ZCHECK ;
 S ZZFLAG=0 F VV=0:0 S VV=$O(^PS(50.7,"ADF",X,PSDOSE,VV)) Q:'VV  I VV,$P($G(^PS(50.7,VV,0)),"^",3) S ZZFLAG=1
 I ZZFLAG W $C(7),!!?5,"There is already an Orderable Item with the same name and Dosage Form,",!?5,"that is flagged for 'IV' use.",!
 Q
SOL ;
 K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="List all Additives and Solutions tied to this Orderable Item" D ^DIR K DIR G:Y["^"!($D(DTOUT)) EN G:Y=0 EDIT
 H 1 K PSOARR,PSOARRAD S AAA=$O(^PS(52.6,"AOI",PSOIEN,0)) I AAA,$D(^PS(52.6,AAA,0)) S PSOARRAD=AAA
 F SSS=0:0 S SSS=$O(^PS(52.7,"AOI",PSOIEN,SSS)) Q:'SSS  S:$D(^PS(52.7,SSS,0)) PSOARR(SSS)=""
 S FLAG=1,UPFLAG=0 D SHEAD F ZZ=0:0 S ZZ=$O(PSOARR(ZZ)) Q:'ZZ!($G(PSOUT))!($G(UPFLAG))  S FLAG=0 D:($Y+7)>IOSL SHEAD Q:$G(PSOUT)!($G(UPFLAG))  I ZZ W !,$P($G(^PS(52.7,ZZ,0)),"^"),"   ",$P($G(^(0)),"^",3)
 G:$G(PSOUT) EN
 G EDIT
SHEAD I 'FLAG W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR I 'Y S:Y="" PSOUT=1 S:Y=0 UPFLAG=1 Q
 W @IOF W !?6,"Orderable Item ->  ",PSOINAME,?68,"(IV)",!?6,"Dosage Form    ->  ",$P($G(^PS(50.606,+$P($G(^PS(50.7,PSOIEN,0)),"^",2),0)),"^"),!,PLINE I FLAG,'$G(PSOARRAD) W !?5,"IV Solutions:",!
 I 'FLAG W !?5,"IV Solutions:",!
 I FLAG,$G(PSOARRAD) W !,$P($G(^PS(52.6,PSOARRAD,0)),"^"),"    ","(IV Additive)",! I $D(PSOARR) W !?5,"IV Solutions:",!
 Q
DTE I $D(^PSDRUG(ZZ,"I")) S Y=$P(^PSDRUG(ZZ,"I"),"^") D DD^%DT W ?50,Y K Y
 Q
DTEX S Y=$G(PSSLDATE) D DD^%DT W ?50,$G(Y) K Y
 Q
IVMSG ; display a message if the CORRESPONDING IV field is entered
 ;
 S PSSIVMSG=$P(^PS(50.7,PSOIEN,0),"^",11) I PSSIVMSG="" Q
 S PSSIVFRM=$P(^PS(50.7,PSSIVMSG,0),"^",2) I PSSIVFRM S PSSIVFRM=$P(^PS(50.606,PSSIVFRM,0),"^")
 S PSSIVMSG=$P(^PS(50.7,PSSIVMSG,0),"^")_" "_PSSIVFRM
 W !!,"The Corresponding IV Item is currently identified as: "_PSSIVMSG,!
 K PSSIVFRM,PSSIVMSG
 Q
UDMSG ; display a message if the CORRESPONDING UD field is entered
 ;
 S PSSUDMSG=$P(^PS(50.7,PSOIEN,0),"^",10) I PSSUDMSG="" Q
 S PSSUDFRM=$P(^PS(50.7,PSSUDMSG,0),"^",2) I PSSUDFRM S PSSUDFRM=$P(^PS(50.606,PSSUDFRM,0),"^")
 S PSSUDMSG=$P(^PS(50.7,PSSUDMSG,0),"^")_" "_PSSUDFRM
 W !!,"The Corresponding UD Item is currently identified as: "_PSSUDMSG,!
 K PSSUDMSG,PSSUDFRM
 Q
DFR(PSDOSE) ; dosage form med routes - called by DR string at DIR+20^PSSPOIMO
 D SETF
 N MR,MRNODE,XX K ^TMP("PSSDMR",$J)
 S (MCT,MR)=0 F  S MR=$O(^PS(50.606,PSDOSE,"MR",MR)) Q:'MR  D
 .S XX=+$G(^PS(50.606,PSDOSE,"MR",MR,0)) Q:'XX  S MRNODE=$G(^PS(51.2,XX,0)) I $P($G(MRNODE),"^",4)'=1 Q
 .S MCT=MCT+1,^TMP("PSSDMR",$J,MCT)=$P(MRNODE,U),^TMP("PSSDMR",$J,"B",XX)=""
 D DFRL
 Q
DFRL W !!," List of med routes associated with the DOSAGE FORM of the orderable item:",!
 S MCT=0 I '$O(^TMP("PSSDMR",$J,MCT)) W !,?3,"NO MED ROUTE DEFINED"
 F  S MCT=$O(^TMP("PSSDMR",$J,MCT)) Q:'MCT  W !,?3,$G(^(MCT))
 D EN^DDIOL(" If you answer YES to the next prompt, the DEFAULT MED ROUTE (if populated)",,"!!")
 D EN^DDIOL(" and this list (if populated) will be displayed as selectable med routes",,"!")
 D EN^DDIOL(" during medication ordering dialog. If you answer NO, the DEFAULT MED ROUTE",,"!")
 D EN^DDIOL(" (if populated) and POSSIBLE MED ROUTES list will be displayed instead.",,"!") W !
 ;K ^TMP("PSSMR",$J)
 Q
PDR ; possible med routes - called by DR string at DIR+20^PSSPOIMO
 N MCT,MR,MRNODE,XX K ^TMP("PSSMR",$J)
 S (XX,MCT)=0 F  S XX=$O(^PS(50.7,$S($G(PSVAR):PSVAR,1:PSOIEN),3,"B",XX)) Q:'XX  S MRNODE=$G(^PS(51.2,XX,0)),MCT=MCT+1,^TMP("PSSMR",$J,MCT)=$P(MRNODE,U)
 I $O(^TMP("PSSMR",$J,0)) D
 .W !!," List of Possible Med Routes associated with the orderable item:",!
 .S MCT=0 F  S MCT=$O(^TMP("PSSMR",$J,MCT)) Q:'MCT  W !,?3,$G(^(MCT))
 W ! K ^TMP("PSSMR",$J)
 Q
PDCHK ; called by DR string at DIR+20^PSSPOIMO
 N ANS,D,DIC,DIE,DO,DICR,DR,DIR,PSOUT,PSSDA,PSSX,PSSXA,PSSY,Q,X,Y,Z
 S DIR(0)="PO^51.2:EMZ",DIR("A")="POSSIBLE MED ROUTES",DIR("S")="I $P(^(0),U,4)" S PSOUT=0
 S DIR("PRE")="I X=""?"" D MRTHLP^PSSPOIMO"
 F  D PDR,^DIR D  I PSOUT Q
 .I (X="")!$D(DTOUT)!$D(DUOUT) S PSOUT=1 Q
 .I X="@",$D(PSSY) S ANS=DA D:$$DASK  Q
 ..N DIK,DA S DA(1)=ANS,DIK="^PS(50.7,"_DA(1)_",3,"
 ..S DA=$O(^PS(50.7,DA(1),3,"B",PSSY,"")) I DA="" Q
 ..D ^DIK K PSSY,DIR("B")
 .I Y="" W "  ??" Q
 .I $D(^PS(50.7,DA,3,"B",+Y)) D  Q
 ..I $D(DIR("B")) K PSSY,DIR("B") Q
 ..S DIR("B")=Y(0,0),PSSY=+Y Q
 .S PSSXA=Y(0,0),PSSX=+Y D DFR(+$P(^PS(50.7,DA,0),"^",2))
 .I $G(PSSX) S ANS=$$ASK() I 'ANS Q
 .S PSSDA(50.711,"+1,"_DA_",",.01)=+PSSX
 .D UPDATE^DIE("","PSSDA")
 .K ^TMP("PSSMR",$J)
 D DP
 Q
ASK() ; confirm adding the new entry
 N DIR,X,Y W ! S DIR(0)="YO",DIR("B")="YES"
 I $D(^TMP("PSSDMR",$J)),'$D(^TMP("PSSDMR",$J,"B",PSSX)) S DIR("B")="NO",DIR("A",1)="The selected entry does not match to any of the dosage form med routes."
 W $C(7) S DIR("A")="  Are you adding '"_PSSXA_"' as a new POSSIBLE MED ROUTE" D ^DIR
 Q $S(Y=1:1,1:0)
DASK() ; delete possible med route
 N DIR
 W $C(7) S DIR("A")="     SURE YOU WANT TO DELETE ",DIR(0)="Y" D ^DIR
 Q $S(Y=1:1,1:0)
MRTHLP ; help of possible med route
 N DIC,RTE,D
 S RTE=0 F  S RTE=$O(^PS(50.7,DA,3,"B",RTE)) Q:'RTE   D EN^DDIOL($P($G(^PS(51.2,RTE,0)),"^"),,"!,?4")
 W ! D EN^DDIOL("Enter the most common MED ROUTE associated with this Orderable Item.",,"!,?5")
 D EN^DDIOL("ONLY MED ROUTES MARKED FOR USE BY ALL PACKAGES ARE SELECTABLE.",,"!,?5")
 Q
DP ; check the existence of Default Med Route & Possible Med Routes
 N D,DIC,DIE,DO,DICR,DR,DIR,Q,X,Y,Z
 I '$P($G(^PS(50.7,$S($G(PSVAR):PSVAR,1:PSOIEN),0)),"^",6)&('$O(^PS(50.7,$S($G(PSVAR):PSVAR,1:PSOIEN),3,0))) D
 .S PSR(1)=" You have not selected ANY med routes to display during order entry. In"
 .S PSR(2)=" order to have med routes displayed during order entry, you must either"
 .S PSR(3)=" define a DEFAULT MED ROUTE and/or at least one POSSIBLE MED ROUTE, or"
 .S PSR(4)=" answer YES to the USE DOSAGE FORM MED ROUTE LIST prompt."
 .S PSR(5)=" **WITH THE CURRENT SETTINGS, NO MED ROUTES WILL DISPLAY FOR SELECTION ",PSR(5,"F")="!!"
 .S PSR(6)=" DURING ORDER ENTRY FOR THIS ORDERABLE ITEM**"
 .D EN^DDIOL(.PSR),EN^DDIOL(" ","","!")
 .K DIR S DIR(0)="Y",DIR("?",1)="If you select NO, you will continue to loop back to the Default Med Route"
 .S DIR("?")="prompt until either a selection is made or you answer YES to this prompt to proceed."
 .S DIR("A",1)="",DIR("A",2)="The current setting is usually only appropriate for supply items."
 .S DIR("A")="Continue with NO med route displaying for selection during order entry",DIR("B")="NO"
 .D ^DIR K DIR W ! I 'Y!($D(DTOUT))!($D(DUOUT)) S PSSFG=1
 .S:Y PSSFG=0
 E  S PSSFG=0
 Q
 ;
SETF ;
 S PSSOU=0 K ^TMP("PSJMR",$J) D MEDRT^PSSJORDF($S($G(PSVAR):PSVAR,1:PSOIEN))
 I '$D(^TMP("PSJMR",$J)) S DIE("NO^")="",PSSFG=1
 E  S PSSFG=0 K DIE("NO^")
 Q
MRSEL ;
 K ^TMP("PSJMR",$J) D MEDRT^PSSJORDF($S($G(PSVAR):PSVAR,1:PSOIEN))
 W !,"The following Med Routes will now be displayed during order entry:"
 N I S (PSSOU,I)=0 F  S I=$O(^TMP("PSJMR",$J,I)) Q:'I   W !,$P(^(I),"^",2) S PSSOU=1
 W:'PSSOU !,"(None)"
 W ! S PSSOU=1
 Q
 ;
