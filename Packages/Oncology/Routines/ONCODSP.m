ONCODSP ;Hines OIFO/GWB,RTK - MISCELLANEOUS OPTIONS ;05/05/10
 ;;2.11;ONCOLOGY;**1,5,6,13,18,22,23,25,26,39,40,44,48,51,53,56**;Mar 07, 1995;Build 10
 ;
TR ;[TR Define Tumor Registry Parameters]
 W ! S DIC="^ONCO(160.1,",DIC(0)="AEMLQ",DLAYGO=160.1 D ^DIC
 I Y=-1 G EX
 W @IOF,!,"  ONCOLOGY SITE PARAMETERS"
 W !,"  ------------------------"
 S DIE="^ONCO(160.1,",DA=+Y
 S DR=""
 S DR(1,160.1,1)=".01  HOSPITAL NAME....."
 S DR(1,160.1,2)=".02  STREET ADDRESS...."
 S DR(1,160.1,3)=".03  ZIPCODE..........."
 ;S DR(1,160.1,3.1)="W !,""  CITY..............: "",$$GET1^DIQ(160.1,DA,66)"
 ;S DR(1,160.1,3.2)="W !,""  STATE.............: "",$$GET1^DIQ(160.1,DA,67)"
 S DR(1,160.1,4)=".04  REFERENCE DATE...."
 S DR(1,160.1,5)="1  TUMOR REGISTRAR..."
 S DR(1,160.1,6)="1.02  PHONE NUMBER......"
 S DR(1,160.1,7)="1.03  STATE HOSPITAL #.."
 S DR(1,160.1,8)="27  FACILITY ID #....."
 S DR(1,160.1,8.1)="S FACPNT=$P($G(^ONCO(160.1,DA,1)),U,4) D FNPI^ONCNPI"
 S DR(1,160.1,9)="28  CENTRAL REGISTRY #"
 S DR(1,160.1,10)="7  VISN.............."
 S DR(1,160.1,10.1)="19  CS/EDITS URL......"
 S DR(1,160.1,11)="6  DIVISION.........."
 S DR(1,160.1,11.1)="68  COC ACCREDITATION."
 S DR(1,160.1,12)="W !"
 S DR(1,160.1,13)="8  AFFILIATED DIVISION."
 S DR(1,160.1,14)="W !"
 S DR(1,160.1,15)="5  AUTHORZIED QA USER.."
 D ^DIE
 W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 G EX
 ;
DIVID ;DIVISION (160.1,6) identifier
 S ONCDIV=""
 Q:'$D(^ONCO(160.1,Y,1))
 S INSPTR=$P(^ONCO(160.1,Y,1),U,8)
 Q:'$D(^DIC(4,INSPTR,99))
 S ONCDIV=$P(^DIC(4,INSPTR,99),U,1)
 W ?30,ONCDIV
 K ONCDIV,INSPTR
 Q
 ;
WS ;[WS Edit/print worksheet]
 K DIR
 S DIR("A")=" Action",DIR(0)="SO^E:Edit worksheet;P:Print worksheet"
 D ^DIR G EW:Y="E",PW:Y="P",EX
 ;
EW ;Edit worksheet
 S DIE="^ONCO(160.2,",DA=5,DR=1 D ^DIE
 G WS
 ;
PW ;Print Worksheet
 S DIC="^ONCO(160.2,",L=0,(NUMBER,DA)=5
 S BY="@NUMBER",FR=NUMBER,TO=NUMBER,FLDS="[ONCO WORKSHEET]"
 D EN1^DIP
 G WS
 ;
RSR ;[RS Registry Summary Reports]
 S ONCOS("T")="T",DIR("A")=" Select"
 S DIR(0)="S^T:Today;A:Annual;F:Follow-Up",DIR("B")="Today"
 D ^DIR G EX:Y=""!(Y[U) G @Y
 ;
A ;[RS Registry Summary Reports - Annual]
 S BYR=$O(^ONCO(165.5,"AY",0))
 F YR=$E(DT,1)+17_$E(DT,2,3)-1:-1:BYR-1 S EYR=$O(^ONCO(165.5,"AY",YR))  Q:EYR'=""
 W !!
 K DIR
 S YR=$E(DT,1)+17_$E(DT,2,3)
 S DIR("A")=" Select year for summary"
 S DIR("B")=YR-1 S:DIR("B")<BYR DIR("B")=BYR
 S DIR(0)="N^"_BYR_":"_EYR D ^DIR K DIR
 G EX:Y[U!(Y=""),A:Y>YR,A:Y'?1.N S ONCOS("T")=Y
 K DIR
 S DIR("A")=" Analytic cases only"
 S DIR("B")="YES"
 S DIR(0)="Y"
 S DIR("?")=" "
 S DIR("?",1)=" Answer 'YES' if you want only analytic cases (CLASS OF CASE 00-22) displayed."
 S DIR("?",2)=" Answer  'NO' if you want all cases (analytic and non-analytic) displayed."
 D ^DIR
 I $D(DIRUT) Q
 S ACO=Y
 ;
T ;[RS Registry Summary Reports - Today]
 K IO("Q") S %ZIS="Q" W !! D ^%ZIS I POP S ONCOUT="" G EX
 I '$D(IO("Q")) D WAIT^DICD,TK^ONCODSP G EX
 S ZTSAVE("ONCOS*")="",ZTSAVE("ACO")=""
 S ZTRTN="TK^ONCODSP",ZTDESC="REGISTRY SUMMARY RPT"
 D ^%ZTLOAD G EX
 ;
F ;[RS Registry Summary Reports - Follow-Up]
 K DIR
 W !!," Follow-up rate calculation parameters (select 1 or 2):",!
 W !," 1) All analytic patients from the cancer registry reference date"
 W !," 2) All analytic patients diagnosed within the last five years, or"
 W !,"    from the cancer registry reference date, whichever is shorter"
 W !
 N DIR,X,Y
 S DIR(0)="SAO^1:From cancer registry reference date;2:Within last 5 years or reference date (whichever is shorter)"
 S DIR("A")=" Select follow-up rate calculation parameter: "
 S DIR("?")="Select the starting point to compute the follow-up rate"
 D ^DIR G EX:Y=""!(Y[U) S ONCOS("F")=Y
 K IO("Q") S %ZIS="Q" W !! D ^%ZIS I POP S ONCOUT="" G EX
 I '$D(IO("Q")) D WAIT^DICD G FR^ONCOCOF
 S ZTSAVE("ONCOS*")="",ZTRTN="FR^ONCOCOF",ZTDESC="FOLLOWUP RATE REPORT"
 D ^%ZTLOAD G EX
 ;
TK ;Tasked [RS Registry Summary Reports - Today] report 
 S YR=ONCOS("T")
 G AN:YR'="T"
 S V(9)=0,F(8)=0 F I=0,1 S G(I)=0,V(I)=0,F(I)=0
 ;S G=0,XD0=0 F  S XD0=$O(^ONCO(165.5,"AG",G,XD0)) Q:XD0'>0  I $$DIV^ONCFUNC(XD0)=DUZ(2) S G(G)=G(G)+1
 ;S G=1,XD0=0 F  S XD0=$O(^ONCO(165.5,"AG",G,XD0)) Q:XD0'>0  I $$DIV^ONCFUNC(XD0)=DUZ(2) S G(G)=G(G)+1
 S G=0,XD0=0 F  S XD0=$O(^ONCO(165.5,"AG",G,XD0)) Q:XD0'>0  I $$DIV^ONCFUNC(XD0)=DUZ(2),$P($G(^ONCO(165.5,XD0,7)),"^",2)'="A" S G(G)=G(G)+1
 S G=1,XD0=0 F  S XD0=$O(^ONCO(165.5,"AG",G,XD0)) Q:XD0'>0  I $$DIV^ONCFUNC(XD0)=DUZ(2),$P($G(^ONCO(165.5,XD0,7)),"^",2)'="A" S G(G)=G(G)+1
 S W=0,X0=0 F  S X0=$O(^ONCO(160,"ADX",X0)) Q:'X0  S X1=0 F  S X1=$O(^ONCO(160,"ADX",X0,X1)) Q:'X1  S X2=0 F  S X2=$O(^ONCO(160,"ADX",X0,X1,X2)) Q:'X2  I $$SUSDIV^ONCFUNC(X1,X2)=DUZ(2) S W=W+1
 ;F I=0:1:3 S W(I)=0
 ;F I=0:1:3 S X0=0 F  S X0=$O(^ONCO(165.5,"AS",I,X0)) Q:X0'>0  I $$DIV^ONCFUNC(X0)=DUZ(2) S W(I)=W(I)+1
 F I=0,1,2,3,"A" S W(I)=0
 F I=0,1,2,3,"A" S X0=0 F  S X0=$O(^ONCO(165.5,"AS",I,X0)) Q:X0'>0  I $$DIV^ONCFUNC(X0)=DUZ(2) S W(I)=W(I)+1
 W !!?30,"Analytical: ",$J(G(1),5)
 W !?26,"Non-Analytical: ",$J(G(0),5)
 W !?26,"Accession Only: ",$J(W("A"),5)
 W !?42,"-----"
 ;W !?35,"Total: ",$J(G(0)+G(1),5),!!
 W !?35,"Total: ",$J(G(0)+G(1)+W("A"),5),!!
 W !,?30,"WORKLOAD STATISTICS",!!
 ;W "Suspense: ",W,?15,"Incomplete: ",W(0),?35,"Minimal: ",W(1),?50,"Partial: ",W(2),?65,"Complete: ",W(3),!!
 W "Suspense: ",W,!!,"Incomplete: ",W(0),?19,"Minimal: ",W(1),?34,"Partial: ",W(2),?49,"Complete: ",W(3),?65,"Acc Only: ",W("A"),!
 W "---------------",!,"Total: ",W(0)+W(1)+W(2)+W(3)+W("A")
 Q
 ;
AN ;[RS Registry Summary Reports - Annual]
 K ^TMP($J,"ANNSUM")
 S ^ONCO(164.08,"YR")=YR
 S XD0=0 F  S XD0=$O(^ONCO(164.08,XD0)) Q:XD0'>0  F J="CC","RS","SG" S ^ONCO(164.08,XD0,J)=""
 S ^TMP($J,"ANNSUM","YR")=YR
 S XD0=0 F  S XD0=$O(^ONCO(164.08,XD0)) Q:XD0'>0  S ^TMP($J,"ANNSUM",XD0,0)=$G(^ONCO(164.08,XD0,0)) F J="CC","RS","SG" S ^TMP($J,"ANNSUM",XD0,J)=""
 S XD0=0 F  S XD0=$O(^ONCO(165.5,"AY",YR,XD0)) Q:XD0'>0  I $$DIV^ONCFUNC(XD0)=DUZ(2) S X0=^ONCO(165.5,XD0,0),CSG=$P($G(^ONCO(165.5,XD0,2)),U,20),PSG=$P($G(^ONCO(165.5,XD0,2.1)),U,4),SG=$P($G(^ONCO(165.5,XD0,2)),U,28) D
 .I $P($G(^ONCO(165.5,XD0,7)),U,2)="A" Q
 .S COCANAL=$$GET1^DIQ(165.5,XD0,.042)
 .I ACO=1,COCANAL="NONANALYTIC" Q
 .I SG'="" S SG=$S(SG=0:0,SG="I":1,SG="II":2,SG="III":3,SG="IV":4,SG="U":99,SG="NA":88,1:"")
 .I SG="" S SG=7 ;incomplete=7 (will put them in 8th piece of SG node)
 .S ST=$P(X0,U),IC=$P(X0,U,22),PT=$P(X0,U,2),CC=$P(X0,U,20) Q:IC=""
 .I IC=6799 S IC=6780
 .S P0=$G(^ONCO(160,PT,0)) Q:P0=""  S RC=+$P(P0,U,6),SX=$P(P0,U,8),R=$S(RC=1:"W",RC=2:"B",1:"O"),S=$S(SX=1:"M",1:"F"),RS=R_S
 .S CC=$S(CC=0:3,1:2),RS=$S(RS="WM":1,RS="WF":2,RS="BM":3,RS="BF":4,RS="OM":5,1:6)
 .S SG=+SG+1,SG=$S(SG=100:6,SG=89:7,1:SG)
 .S $P(^TMP($J,"ANNSUM",IC,"CC"),U,CC)=$P(^TMP($J,"ANNSUM",IC,"CC"),U,CC)+1,$P(^TMP($J,"ANNSUM",IC,"CC"),U)=$P(^TMP($J,"ANNSUM",IC,"CC"),U)+1
 .S $P(^TMP($J,"ANNSUM",IC,"RS"),U,RS)=$P(^TMP($J,"ANNSUM",IC,"RS"),U,RS)+1
 .S $P(^TMP($J,"ANNSUM",IC,"SG"),U,SG)=$P(^TMP($J,"ANNSUM",IC,"SG"),U,SG)+1
 ;
PRT ;Print report
 D ^ONCODSP1
 ;
EX ;EXIT
 K BY,BYR,CC,CSG,EYR,F,FLDS,FR,G,I,IC,J,L,NUMBER,ONCOS,ONCOUT
 K P0,PSG,PT,R,RC,RS,SG,ST,SX,TO,V,W,X,X0,X1,X2,XD0,Y,YR
 K DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,SITEPARAM
 K ^TMP($J)
 Q
 ;
CLEANUP ;Cleanup
 K %ZIS,ACO,COCANAL,OUT,POP,S,ZTDESC,ZTRTN,ZTSAVE
