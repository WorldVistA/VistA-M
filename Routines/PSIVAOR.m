PSIVAOR ;BIR/PR-BUILD ACT/DC ORDER RPT BY WD/DRUG ;24 JAN 94 / 11:18 AM
 ;;5.0; INPATIENT MEDICATIONS ;**31**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ; Reference to ^DIC(42 is supported by DBIA# 10039
 ;
SW ;
 I XREF="ADC" S STSRPT=1 D DTS^PSIVRQ K STSRPT I '$D(I7)!('$D(I8)) G K
WARD ;Select ward
 R !!,"Select Ward (or enter ^ALL or ^OUTPATIENT): ",X:DTIME G:'$T!("^"[X) K I $P("^ALL",X)="" W $P("^ALL",X,2) S I3="ALL",I11="ALL WARDS" G DRUG
 I $P("^OUTPATIENT",X)="" W $P("^OUTPATIENT",X,2) S I3=.5,I11="OUTPATIENT WARD" G DRUG
 I X["?" S HELP="ZW" D ^PSIVHLP2 G WARD
 S DIC(0)="EQMZ",DIC=42 D ^DIC G:Y<0 WARD S I3=+Y,I11=$P(Y(0),U)
 ;
DRUG ;Select drug
 R !,"Select DRUG (or enter ^ALL): ",X:DTIME G:'$T!("^"[X) K
 I X[U F Y="^ALL" I $P(Y,X)="" W $P(Y,X,2) S I2="ALL",I10="ALL DRUGS" G QUEUE
 I X["?" S HELP="ACT" D ^PSIVHLP2 G DRUG
 F FI=52.6,52.7 S DIC=FI,DIC(0)="EQMZ" D ^DIC G:X["?"&(DIC[7) DRUG I Y>0 S FI=$S(FI[6:"AD",1:"SOL") Q
 G:Y<0 DRUG S I2=+Y,I10=$P(Y(0),U)
 ;
QUEUE ;Ask to queue report
 K %ZIS,IOP,IO("Q") S %ZIS="QM",%ZIS("B")=PSIVPR D ^%ZIS I POP W !,"No Device selected or report run." G K
 I $D(IO("Q")) D
 .K IO("Q")
 .S I6=$S($G(IO("DOC"))'="":ION_";"_IO("DOC"),1:ION),ZTIO=""
 .K ZTSAVE,ZTDTH,ZTSK
 .S ZTDESC="ACTIVE ORDER REPORT BY WARD/DRUG (SORT)",ZTRTN="ENQ1^PSIVAOR"
 .F G="I6","I2","I3","XREF","I11","FI","I8","I7","I10","PSJSYSW0","PSJSYSU","PSJSYSP0" S ZTSAVE(G)=""
 I  D ^%ZTLOAD W:$D(ZTSK) !,"Queued." D ^%ZISC G K
 ;
ENQ1 ;Entry from first queue or fall through
 I '$D(I6) D WAIT^DICD
 D NOW^%DTC S PSIVQ=$S(XREF="AIV":%-.0001,1:I7-1) K ^TMP("PSJ",$J) S S=$S(I3&(I2):1,I3&('I2):2,'I3&('I2):3,1:4) F DAT=PSIVQ:0 S DAT=$O(^PS(55,XREF,DAT)) Q:'DAT  Q:XREF="ADC"&($P(DAT,".")>$S($D(I8):I8,1:9999999))  D @XREF
 G Q2
 ;
AIV ;Active orders
 F DFN=0:0 S DFN=$O(^PS(55,XREF,DAT,DFN)) Q:'DFN  D ENIV^PSJAC I '$D(PSIVDCF) D NOW^%DTC F ON=0:0 S ON=$O(^PS(55,XREF,DAT,DFN,ON)) Q:'ON  I $D(^PS(55,DFN,"IV",ON,0)),"AOHR"[$P(^(0),U,17),$P(^(0),U,3)>% S G=^(0),P4=$P(G,U,4),IV=$P(^(2),U,2) D @S
 Q
ADC ;Discontinued orders
 F DFN=0:0 S DFN=$O(^PS(55,XREF,DAT,DFN)) Q:'DFN  D ENIV^PSJAC,NOW^%DTC F ON=0:0 S ON=$O(^PS(55,XREF,DAT,DFN,ON)) Q:'ON  I $D(^PS(55,DFN,"IV",ON,0)),$P(^(0),U,17)="D" S G=^(0),P4=$P(G,U,4),IV=$P(^(2),U,2) D @S
 Q
 ;
Q2 ;Do second queue
 G:'$D(I6) ENQ2 S ZTIO=I6,ZTDESC="ACTIVE ORDER REPORT BY WARD/DRUG (PRINT)",ZTRTN="ENQ2^PSIVAOR",ZTDTH=$H F JJ="^TMP(""PSJ"",$J,","I3","I2","I11","FI","XREF","I8","I7","I6","I10","PSJSYSW0","PSJSYSU","PSJSYSP0" S ZTSAVE(JJ)=""
 S %ZIS="QN",IOP=I6 D ^%ZIS,^%ZTLOAD G K
 ;
 ;
1 ;1 w 1 d
 Q:$P(G,U,22)'=I3  F NA=0:0 S NA=$O(^PS(55,DFN,"IV",ON,FI,NA)) Q:'NA  I $D(^(NA,0)),+^(0)=I2 S W42=$S(I3=.5:"OUTPATIENT",1:$P(^DIC(42,I3,0),U)) D B
 Q
2 ;1 w all d
 I $P(G,U,22)=I3 S W42=$S(I3=.5:"OUTPATIENT",1:$P(^DIC(42,I3,0),U)) D B
 Q
 ;
3 ;All w all d
 S W42=$P(G,U,22),W42=$S(W42=.5:"OUTPATIENT",$D(^DIC(42,+W42,0)):$P(^(0),U),1:"zz") D B
 Q
 ;
4 ;1 d all w
 S W42=$P(G,U,22),W42=$S(W42=.5:"OUTPATIENT",$D(^DIC(42,+W42,0)):$P(^(0),U),1:"zz") F NA=0:0 S NA=$O(^PS(55,DFN,"IV",ON,FI,NA)) Q:'NA  I $D(^(NA,0)),+^(0)=I2 D B
 Q
 ;
B ;;Build TMP
 S ^TMP("PSJ",$J,IV,W42,VADM(1)_U_DFN_U_$E(VADM(2),6,9)_U_VAIN(5),ON_U_P4)="" Q
 ;
ENQ2 ;Entry second queue
 I XREF="ADC" S Y=I7 X ^DD("DD") S RANGE=Y,Y=I8 X ^DD("DD") S RANGE=RANGE_" THROUGH "_Y
 U IO S PG=0,I11=I11_", "_I10 D NOW^%DTC S Y=% X ^DD("DD") S USER="Printed by: "_$P(^VA(200,DUZ,0),U)_" on "_Y,TYPE=$S(XREF="AIV":"Active ",1:"Discontinued ") I '$D(^TMP("PSJ",$J)) D H W !,"No data" G K
 D H,^PSIVAOR1 G K
H ;
 S PG=PG+1 W:$Y @IOF W TYPE,"Order Report by Ward/Drug For: ",I11,!,USER W:XREF="ADC" !,"Date range: ",RANGE W ?70,"PAGE: ",PG,!!,"IV ROOM/WARD/NAME/ORDER",?35,"STOP DATE",?60,"PROVIDER",! F I=1:1:20 W "===="
 Q
K ;
 W:$E($G(IOST),1)'="C"&($Y) @IOF
 K %T,D,DAT,DFN,DIC,FI,G,I,I2,I3,I6,I7,I8,I10,I11,IV,NA,ON,P2,P3,P4,P5,P6,PAT,PG,PSIVQ,S,TYPE,USER,VAERR,W42,WD,XREF,Z,ZTSK,^TMP("PSJ",$J) D ENIVKV^PSGSETU
 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 Q
