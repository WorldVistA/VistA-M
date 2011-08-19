PSIVRNL ;BIR/RGY-PRINT RENEWAL AND ACTIVE ORDER LIST ; 15 May 98 / 9:27 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3,137**;16 DEC 97
 ;
ENRNL ;
 D ^PSIVXU I $D(XQUIT) K XQUIT Q
 D BEGRNL K DFN,I,ON,P,PSIV,PSIV1,PSIVBEG,PSIVDT,PSIVEND,PSIVRUN,WARD,WRD,WRDB,WRDE,VAERR,Z
 Q
 ;
BEGRNL W ! S %DT="EXT",X="Enter beginning date: ^T@0001^^^1" D ENQ^PSIV,^%DT G:X["^" QRNL G:Y<0&(X'="?") BEGRNL I X["?" S HELP="RNL" D ^PSIVHLP G BEGRNL
 S PSIVBEG=Y I Y'["." W $C(7),!!,"*** Please enter time with date. ***",! G BEGRNL
ENDRNL W ! S X="Enter ending date: ^T@2400^^^1" D ENQ^PSIV,^%DT G:X["^" QRNL G:Y<0&(X'="?") ENDRNL I X["?" S HELP="RNL" D ^PSIVHLP G ENDRNL
 I Y'["." W $C(7),!!,"*** Please enter time with date. ***",! G ENDRNL
EN1 S PSIVEND=Y K WRD
BEG K DIR S DIR(0)="F^1:30",DIR("A")="Start at WARD",DIR("B")="BEG"
 S DIR("?")="or enter any ward.",DIR("?",1)="Press <RETURN> to start from the first ward",DIR("?",2)="or enter ""^Outpatient"" for Outpatient IV"
 D ^DIR
 G QRNL:$D(DTOUT)!("^"[X) I X="BEG" S WRDB="" G END
 S X=$$ENLU^PSGMI(X) I "^OUTPATIENT"[X W $P("^OUTPATIENT IV",X,2) S WRDB="Outpatient IV" G END
 I X]"" K DA,DIC S DIC="^DIC(42,",DIC(0)="QEM" D ^DIC K DA,DIC G:Y<1 BEG
 S WRDB=$P(Y,"^",2)
END K DIR S DIR(0)="F^1:30",DIR("A")="Stop at WARD",DIR("B")="END"
 S DIR("?")="or enter any ward.",DIR("?",1)="Press <RETURN> to stop at the last ward",DIR("?",2)="or enter ""^Outpatient"" for Outpatient IV"
 D ^DIR
 G QRNL:$D(DTOUT)!("^"[X) I X="END" S WRDE="z" G WRD
 S X=$$ENLU^PSGMI(X) I "^OUTPATIENT"[X W $P("^OUTPATIENT IV",X,2) S WRDE="Outpatient IV" G WRD
 I X]"" K DA,DIC S DIC="^DIC(42,",DIC(0)="QEM" D ^DIC K DA,DIC G:Y<1 END
 S WRDE=$P(Y,"^",2)
WRD S WRDB=$E(WRDB,1,$L(WRDB)-1)_$C($A(WRDB,$L(WRDB))-1),WRDE=$E(WRDE,1,$L(WRDE)-1)_$C($A(WRDE,$L(WRDE))+1) K X S X(WRDE)=""
 I $O(X(WRDB))'=WRDE W ! K DIR S DIR(0)="E",DIR("A",1)="The starting ward must be alphabetically before the ending ward.",DIR("A")="Press <RETURN> to continue" D ^DIR K X G BEG
 I PSIVPR'=ION D QUERNL G QRNL
DEQRNL K ^UTILITY("PSIV",$J) S (WARD,^($J,WRDE))="" D NOW^%DTC S:$E(PSIVEND)=9 PSIVBEG=% S PSIVRUN=$E(%,1,12)
 F PSIVDT=PSIVBEG-.0001:0 S PSIVDT=$O(^PS(55,"AIV",PSIVDT)) Q:'PSIVDT!(PSIVDT>PSIVEND)  F DFN=0:0 S DFN=$O(^PS(55,"AIV",PSIVDT,DFN)) Q:'DFN  D DEQRNL1
 S WRD=WRDB F PSIV1=0:0 S WRD=$O(^UTILITY("PSIV",$J,WRD)) Q:WRD=""!(WRDE']WRD)  F DFN=0:0 S DFN=$O(^UTILITY("PSIV",$J,WRD,DFN)) Q:'DFN  F ON=0:0 S ON=$O(^UTILITY("PSIV",$J,WRD,DFN,ON)) Q:'ON  D SETP,CHK
QRNL W:'$D(PSIVPR)&($Y) @IOF K ^UTILITY("PSIV",$J) S:$D(ZTQUEUED) ZTREQ="@" Q
WD X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) Q
SETP S Y=^PS(55,DFN,"IV",ON,0) F X=1:1:23 S P(X)=$P(Y,"^",X)
 Q
 ;
DEQRNL1 ;
 S PSIV("NME")=$P($G(^DPT(DFN,0)),U) D INP^VADPT F ON=0:0 S ON=$O(^PS(55,"AIV",PSIVDT,DFN,ON)) Q:'ON  D SETP,UT
 Q
PRNT D:$Y+7>IOSL!(WARD'=WRD) HDR D ENIV^PSJAC W !,VAIN(5),?30 S PSIV=$O(^PS(55,DFN,"IV",ON,"AD",0)) D:PSIV ENP2 W ?80 S Y=P(3) D WD W ?105,$P($G(^VA(200,+P(6),0)),"^")
ENP1 W !,VADM(1)
 S SSNF=0
ENP3 I PSIV]"" S PSIV=$O(^PS(55,DFN,"IV",ON,"AD",PSIV)) I PSIV D ENP2 W ! D CHK2
 I PSIV]"" F PSIV=PSIV:0 S PSIV=$O(^PS(55,DFN,"IV",ON,"AD",PSIV)) Q:'PSIV  D ENP2 W ! D CHK2
 F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IV",ON,"SOL",PSIV)) Q:'PSIV  D
 .; naked ref below refers to line above
 .S PSIV=PSIV_"^"_^(PSIV,0) W ?30,$S($D(^PS(52.7,$P(PSIV,"^",2),0)):$P(^(0),"^")_" "_$P(PSIV,"^",3)_" "_$P(^(0),"^",4),1:"*** Undefined Solution"),! D CHK2
 W:P(8)]"" ?30,$P(P(8),"@"),! D CHK2
 W:P(9)]"" ?30,P(9) W:P(11)]"" " (",P(11),")" W:P(9)_P(11)]"" ! D CHK2
 S PSIV=$S($D(^PS(55,DFN,"IV",ON,3)):$P(^(3),"^"),1:"") W:PSIV]"" ?30,"Other print info.: ",PSIV,! D CHK2
 ; naked ref below refers to line above
 S PSIV=$S($D(^(1)):$P(^(1),"^"),1:"") W:PSIV]"" ?40,"Remarks: ",PSIV,! D CHK2
 I "OHD"[P(17) S Y=^DD(55.01,100,0),X=P(17),X=$P($P(";"_$P(Y,"^",3),";"_X_":",2),";") W ?30,"*** THIS ORDER HAS A STATUS OF '",X,"' ***",!
 D CHK2 K SSNF Q
ENP2 S PSIV=PSIV_"^"_^PS(55,DFN,"IV",ON,"AD",+PSIV,0) W ?30,$S($D(^PS(52.6,$P(PSIV,"^",2),0)):$P(^(0),"^")_" "_$P(PSIV,"^",3),1:"*** Undefined Additive") I $P(PSIV,"^",4)]"" W " (",$P(PSIV,"^",4),")"
 S PSIV=+PSIV Q
HDR W:$Y @IOF,!! I $E(PSIVEND)=9 W "Active order list"
 E  W "Renewal list from " S Y=PSIVBEG D WD W " to " S Y=PSIVEND D WD
 W !,"Printed on: " S Y=PSIVRUN D WD W !!,"Patient name",?40,"Order",?80,"Stop date",?105,"Provider",! F Y=1:1:130 W "-"
 S WARD=WRD W !?50,"**** Ward: ",WRD," ****" W ! Q
QUERNL S ZTIO=PSIVPR,ZTDESC="IV "_$S($E(PSIVEND)=9:"ACTIVE ORDER",1:"RENEWAL")_" LIST",ZTRTN="DEQRNL^PSIVRNL" F X="WRDE","WRDB","PSIVBEG","PSIVEND","PSIVSITE","PSIVSN","PSJSYSW0","PSJSYSU","PSJSYSP","PSJSYSP0" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) !,"Queued." G QRNL
UT S ^UTILITY("PSIV",$J,$S($P(VAIN(4),U,2)]"":$P(VAIN(4),U,2),1:"Outpatient IV"),DFN,ON)="" Q
CHK I "DEPN"'[P(17),$P($G(^PS(55,DFN,"IV",ON,2)),U,2)=PSIVSN D:$S($E(PSIVEND)=9:1,1:$P(^(2),U,9)'="R") PRNT
 Q
ENTACT D NOW^%DTC S PSIVBEG=%,Y=9999999 G EN1
CHK2 I '$G(SSNF) W VA("BID")," [",ON,"]" S SSNF=1 Q
