ECXAPRO ;ALB/JAP - PRO Extract Audit Report ; Nov 16, 1998
 ;;3.0;DSS EXTRACTS;**9,21,33,36**;Dec 22, 1997
 ;
EN ;entry point for PRO extract audit report
 N %X,%Y,DIV,X,Y,DIC,DA,DR,DIQ,DIR,DIRUT,DTOUT,DUOUT
 S ECXERR=0
 ;ecxaud=0 for 'extract' audit
 S ECXHEAD="PRO",ECXAUD=0
 W !!,"Setup for ",ECXHEAD," Extract Audit Report --",!!
 ;determine primary division
 S ECXPRIME=$$PDIV^ECXPUTL
 I ECXPRIME=0 D ^ECXKILL Q
 S DA=ECXPRIME,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99" D EN^DIQ1
 S ECXPRIME=ECXPRIME_U_$G(ECXDIC(4,DA,99,"I"))_U_$G(ECXDIC(4,DA,.01,"I"))
 ;select 1 or more prosthetics divisions for report
 D PRO^ECXDVSN2(DUZ,ECXPRIME,.ECXDIV,.ECXALL,.ECXERR)
 I ECXERR D  Q
 .D ^ECXKILL W !!,?5,"Try again later... exiting.",!
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 I ECXERR=1 D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 ;if user's selected division doesn't match extract's division, then quit
 I +ECXPRIME'=ECXARRAY("DIV") D  Q
 .S DIV=+ECXARRAY("DIV") S:$D(^DIC(4,DIV,0)) DIV=$P(^(0),U,1)
 .W !!,?5,"Your primary division ("_$P(ECXPRIME,U,3)_") does not match the"
 .W !,?5,"division ("_DIV_") associated with Extract #"_ECXARRAY("EXTRACT")_"."
 .W !!,?5,"Try again... exiting.",!
 .I $E(IOST)="C" D
 ..S SS=20-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" W ! D ^DIR K DIR
 ..W @IOF
 ;select summary or detail
 K DIR S DIR(0)="S^D:DETAIL;S:SUMMARY",DIR("A")="Type of Report",DIR("B")="SUMMARY"
 D ^DIR K DIR
 I $D(DIRUT)!($D(DTOUT)) D  Q
 .W !!,?5,"Try again later... exiting.",!
 .D AUDIT^ECXKILL
 S ECXREPT=Y
 ;continue with detail report
 I ECXREPT="D" D
 .F  D ASK2^ECXAPRO2 Q:$D(DIRUT)!($D(DTOUT))
 ;continue with summary report
 I ECXREPT="S" D
 .S ECXPGM="TASK^ECXAPRO",ECXDESC="PRO Extract Audit Report"
 .S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")="",ECXSAVE("ECXREPT")="",ECXSAVE("ECXPRIME")="",ECXSAVE("ECXALL")=""
 .W !
 .;determine output device and queue if requested
 .D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE) I ECXSAVE("POP")=1 D  Q
 ..W !!,?5,"Try again later... exiting.",!
 ..D AUDIT^ECXKILL
 .I ECXSAVE("ZTSK")=0 D
 ..K ECXSAVE,ECXPGM,ECXDESC
 ..D PROCESS,DISP^ECXAPRO1
 ..;allow user to get details
 ..D ASK^ECXAPRO2
 ;clean-up and close
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
TASK ;entry point from taskmanager
 D PROCESS
 I ECXREPT="S" D DISP^ECXAPRO1
 I ECXREPT="D" D DISP^ECXAPRO2
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;process the data in file #727.826
 N J,CNT,CODE,COST,CPTNM,DATE,DESC,FLG,GN,IEN,KEY,LOC,LABLC,LABMC,NODE,PTNAM,PSASNM,QTY,QFLG,QQFLG,RD,SSN,STN,SRCE,TYPE
 K ^TMP($J)
 S (CNT,QQFLG)=0
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S X=ECXARRAY("START") D ^%DT S ECXSTART=Y S X=ECXARRAY("END") D ^%DT S ECXEND=Y
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 I ECXALL=0 S J=$O(ECXDIV(99),-1),ECXDIV=ECXDIV(J)
 I ECXALL=1 S ECXDIV=ECXPRIME
 S STN=$P(ECXDIV,U,2)
 ;initialize the prosthetics tmp global for cumulative data
 D CODE^ECXAPRO1
 ;gather extract data and sort by grouper number, calc flag, and nppd code
 S IEN="" F  S IEN=$O(^ECX(727.826,"AC",ECXEXT,IEN)) Q:IEN=""  D  Q:QQFLG
 .S ECXPRO=^ECX(727.826,IEN,0)
 .;
 .;- Remove trailing "^" from ECXPRO if there
 .I $E(ECXPRO,$L(ECXPRO))="^" S ECXPRO=$E(ECXPRO,1,$L(ECXPRO)-1)
 .S ECXPRO=ECXPRO_U_$P(^ECX(727.826,IEN,1),U,4)
 .S DATE=$P(ECXPRO,U,9)
 .S $E(DATE,1,2)=$E(DATE,1,2)-17
 .Q:$L(DATE)<7  Q:(DATE<ECXSTART)  Q:(DATE>ECXEND)
 .S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)
 .S PTNAM=$P(ECXPRO,U,7),SSN=$E($P(ECXPRO,U,6),6,9)
 .S LOC=$P(ECXPRO,U,10),KEY=$P(ECXPRO,U,11),QTY=$P(ECXPRO,U,12)
 .S COST=$P(ECXPRO,U,25),LABLC=$P(ECXPRO,U,26),LABMC=$P(ECXPRO,U,27)
 .S GN=$P(ECXPRO,U,34),GN=$S(GN="":" ",1:GN)
 .;don't double count lab items
 .Q:LOC["LAB"
 .;duplicate the logic in sort^rmprn6 that sets cost=0 if form=4
 .I LOC["ORD" S COST=0
 .S LOC=$S(LOC["ORD":$P(LOC,"ORD",1),1:$P(LOC,"NONL",1))
 .;quit if feeder location isn't for division selected for report
 .I ECXALL=1,LOC'[STN Q
 .I ECXALL=0,LOC'=STN Q
 .S TYPE=$E(KEY,6),SRCE=$E(KEY,7)
 .S CPTNM=$P(ECXPRO,U,15),PSASNM=$P(ECXPRO,U,33)
 .D GETCODE(PSASNM,.NODE)
 .Q:NODE=""
 .S CODE=$S(TYPE="X":$P(NODE,U,3),1:$P(NODE,U,4))
 .S FLG=$P(NODE,U,2),DESC=$P(NODE,U,5)
 .S ^TMP($J,"RMPRGN",STN,GN,FLG,CODE,IEN)=TYPE_U_SRCE_U_QTY_U_COST_U_LABLC_U_LABMC_U_PSASNM_U_DESC_U_PTNAM_U_SSN_U_DATE_U_LOC
 ;accumulate summary & detail data
 S GN=""
 F  S GN=$O(^TMP($J,"RMPRGN",STN,GN)) Q:GN=""  D
 .S FLG=0
 .F  S FLG=$O(^TMP($J,"RMPRGN",STN,GN,FLG)) Q:FLG'>0  D
 ..I FLG=1 D GROUP S FLG=2 Q
 ..S CODE=0
 ..F  S CODE=$O(^TMP($J,"RMPRGN",STN,GN,FLG,CODE)) Q:CODE=""  D
 ...S RD=0
 ...F  S RD=$O(^TMP($J,"RMPRGN",STN,GN,FLG,CODE,RD)) Q:RD'>0  D
 ....S TYPE=$P(^TMP($J,"RMPRGN",STN,GN,FLG,CODE,RD),U,1),SRCE=$P(^(RD),U,2),QTY=$P(^(RD),U,3),COST=$P(^(RD),U,4)
 ....S ^TMP($J,CODE,RD)=^TMP($J,"RMPRGN",STN,GN,FLG,CODE,RD)
 ....I TYPE="X" D REP(CODE)
 ....I TYPE="N" D NEW(CODE)
 Q
 ;
GETCODE(PSAS,NODE) ;find the appropriate nppd code using psas hcpcs
 N DIC,X,Y,DESC,FLG,NU,REP
 S NODE=""
 S DIC="^RMPR(661.1,",DIC(0)="XZ",X=PSAS D ^DIC
 I Y=-1 S NODE=U_"2"_U_"R99 Z"_U_"999 Z"_U_"NO HCPCS" Q
 S DESC=$E($P(Y(0),U,2),1,20)
 S FLG=$P(Y(0),U,8) S:FLG="" FLG=2
 ;make sure each code at least 4 characters; group codes are 3 characters in tmp($j,rmprcode)
 S REP=$P(Y(0),U,6) S:$L(REP)=3 REP=REP_" " S:REP="" REP="R99 X"
 S NU=$P(Y(0),U,7) S:$L(NU)=3 NU=NU_" " S:NU="" NU="999 X"
 S NODE=U_FLG_U_REP_U_NU_U_DESC
 Q
 ;
GROUP ;total grouper to main key
 N BF,BL,BR,BCOST,BTCOST,COST,QTY,TYPE,SRCE
 S BF=0,BTCOST=0
 F  S BF=$O(^TMP($J,"RMPRGN",STN,GN,BF)) Q:BF'>0  D
 .S BL=0
 .F  S BL=$O(^TMP($J,"RMPRGN",STN,GN,BF,BL)) Q:BL=""  D
 ..S BR=0
 ..F  S BR=$O(^TMP($J,"RMPRGN",STN,GN,BF,BL,BR)) Q:BR'>0  D
 ...S BCOST=$P(^TMP($J,"RMPRGN",STN,GN,BF,BL,BR),U,4)
 ...S BTCOST=BTCOST+BCOST
 S BL=$O(^TMP($J,"RMPRGN",STN,GN,1,"")),BR=$O(^TMP($J,"RMPRGN",STN,GN,1,BL,""))
 ;calculate based on primary
 S TYPE=$P(^TMP($J,"RMPRGN",STN,GN,1,BL,BR),U,1),SRCE=$P(^(BR),U,2),QTY=$P(^(BR),U,3)
 S COST=BTCOST
 S ^TMP($J,BL,BR)=^TMP($J,"RMPRGN",STN,GN,1,BL,BR),$P(^TMP($J,BL,BR),U,4)=COST
 I TYPE="X" D REP(BL)
 I TYPE="N" D NEW(BL)
 Q
 ;
REP(C) ;calculate repair cost
 N LINE
 S LINE=C
 I LINE="R90 A" S SRCE="C",QTY=1
 I $G(^TMP($J,"R",STN,LINE))="" S ^TMP($J,"R",STN,LINE)=""
 I SRCE["V" S $P(^TMP($J,"R",STN,LINE),U,1)=$P(^TMP($J,"R",STN,LINE),U,1)+QTY
 I SRCE["C" S $P(^TMP($J,"R",STN,LINE),U,2)=$P(^TMP($J,"R",STN,LINE),U,2)+QTY
 S $P(^TMP($J,"R",STN,LINE),U,3)=$P(^TMP($J,"R",STN,LINE),U,3)+COST
 Q
 ;
NEW(C) ;calculate new costs
 N LINE
 S LINE=C
 I $G(^TMP($J,"N",STN,LINE))="" S ^TMP($J,"N",STN,LINE)=""
 I SRCE["V" S $P(^TMP($J,"N",STN,LINE),U,1)=$P(^TMP($J,"N",STN,LINE),U,1)+QTY
 I SRCE["C" S $P(^TMP($J,"N",STN,LINE),U,2)=$P(^TMP($J,"N",STN,LINE),U,2)+QTY
 S $P(^TMP($J,"N",STN,LINE),U,3)=$P(^TMP($J,"N",STN,LINE),U,3)+COST
 Q
