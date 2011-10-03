PSIVRQ1 ;BIR/PR-CONT. REPORT DRIVER ;16 DEC 97 / 1:40 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**31**;16 DEC 97
 ;
 ; Reference to ^PS(50.605 is supported by DBIA #2138
 ;
 D:$D(PSIVDCR) D D:$D(PSIVPCR) P D:$D(PSIVPAT) PAT I $D(PSIVWCR) D D Q:"^"[X  D I3
 G:"^"[X!(X<0) K^PSIVRQ
QUEUE ;Queue logic
 W ! K IO("Q"),%ZIS,IOP S %ZIS("B")=PSIVPR,%ZIS="QM" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED" G K^PSIVRQ
 G:'$D(IO("Q")) NQ S ZTRTN=$S($D(PSIVPCR):"^PSIVPCR",$D(PSIVDCR):"^PSIVDCR",$D(PSIVWCR):"^PSIVWCR",$D(PSIVPAT):"^PSIVPAT",1:"^PSIVAMIS")
 K ZTDTH,ZTSAVE,ZTSK S ZTIO="",I6=$S($G(IO("DOC"))'="":ION_";"_IO("DOC"),1:ION),ZTDESC="IV "_$S($D(PSIVPCR):"PROVIDER DRUG COST",$D(PSIVDCR):"DRUG COST",$D(PSIVWCR):"WARD/DRUG COST",$D(PSIVPAT):"PATIENT COST",1:"AMIS")_" REPORT (SORT)"
 F G="PQ","I2","BRIEF","SMO","I3","I1","I5","I7","I8","I6","I9","I10","I11","I15","I4","UCO","LCO","PSIVPR","PSJSYSU","PSJSYSP0" S ZTSAVE(G)=""
 K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Queued." D ^%ZISC G K^PSIVRQ
 ;
NQ ;No queue so run report
 D @($S($D(PSIVPCR):"^PSIVPCR",$D(PSIVDCR):"^PSIVDCR",$D(PSIVPAT):"^PSIVPAT",$D(PSIVWCR):"^PSIVWCR",1:"^PSIVAMIS"))
 G K^PSIVRQ
 ;
P ;Select provider for provider report
 R !!,"Select PROVIDER (or enter ^ALL): ",X:DTIME W:'$T $C(7) Q:'$T!("^"[X)  I $P("^ALL",X)="" W $P("^ALL",X,2) S I1="ALL",I9="ALL PROVIDERS" D D Q
 S:X["?" HELP="PROVRP" D:X["?" ^PSIVHLP1 G:X["?" P S DIC(0)="QEM",DIC="^VA(200,",DIC("S")="I $D(^(""PS""))" D ^DIC K DIC G:Y<0 P S I1=+Y,I9=$P(Y,"^",2) D D
 Q
 ;
D ;Select drug
 W !!,"Select DRUG:",!?5,"or ^ALL (All drugs):",!?5,"or ^NON (Non-formulary drugs):",!?5,"or ^CAT (Category of drugs):",!?5,"or ^VADC (VA drug class):" W:$D(PSIVDCR) !?5,"or ^HIGH (H/L cost):",!?5,"or ^TYPE (IV type):" R X:DTIME Q:'$T!("^"[X)
 I $D(PSIVDCR),X["^" F Y="^HIGH" I $P(Y,X)="" W $P(Y,X,2) D HI G:Y<0 D S I2="HIGH",I10="HIGH/LOW COST RANGE: "_"$"_LCO_" THROUGH "_"$"_UCO G PQ
 I $D(PSIVDCR),X["^" F Y="^TYPE" I $P(Y,X)="" W $P(Y,X,2) D T G:Y<0 D S I2=Y,I10="IV TYPE: "_Y(0) K PQ G PQ
 I X["^" F Y="^ALL","^NON","^CAT","^VADC" I $P(Y,X)="" W $P(Y,X,2) D:Y="^CAT" CAT D:Y="^VADC" VADC Q:Y<0  S I2=$E(Y,2,999) S:'$D(I10) I10=$S(Y["NON":"NON-FORMULARY DRUGS",1:"ALL DRUGS") G PQ
 I X["?" S HELP="DCR" D ^PSIVHLP2 G D
 F DIC=52.6,52.7 S DIC(0)="QEMZ" D ^DIC G:X["?"&(DIC[7) D I Y>0 S I10=$P(Y,U,2) Q
 G:Y<0 D S I2=$P(Y(0),U,2)
 ;
PQ ;Ask for patient data for drug cost report but not if 'TYPE' selected
 ;or a brief or summary only report is requested
 Q:'$D(PQ)  F Q=0:0 S HELP="PATQ" W !!,"Should this report include patient data" S %=2 D YN^DICN Q:%  S HELP="PATQ" D ^PSIVHLP1
 S:%<0 (PQ,X)="^" K:%=2 PQ S:%=1 PQ="Y" Q
 ;
PAT ;Ask patient for patient cost report
 D ENGETP^PSIV S (X,I5)=DFN Q
 ;
I3 ;Select ward for ward cost report
 W !! R "Select WARD",!?5,"or enter ^ALL (all wards)",!?5,"or enter ^OUTPATIENT (outpatient ward): ",X:DTIME W:'$T $C(7) Q:'$T!("^"[X)  I $P("^ALL",X)="" W $P("^ALL",X,2) S I3="ALL",I11="ALL WARDS" Q
 I $P("^OUTPATIENT",X)="" W $P("^OUTPATIENT",X,2) S I3=.5,I11="WARD: OUTPATIENT" Q
 I X["?" S HELP="WARD" D ^PSIVHLP1 G I3
 S DIC(0)="QEM",DIC="^DIC(42," D ^DIC K DIC G:Y<0 I3 S I3=+Y,I11="WARD: "_$P(Y,U,2) Q
 ;
CAT ;Category of drugs
 W ! S DIC="^PS(50.2,",DIC(0)="AEQ" D ^DIC I Y>0 S I10="IV CATEGORY: "_$P(Y,U,2),Y="^C."_+Y
 Q
 ;
VADC ;Va drug class codes
 W ! S DIC="^PS(50.605,",DIC(0)="AEQ" D ^DIC I Y>0 S I10="VA DRUG CLASS CODE: "_$P(Y,U,2)_" = "_$P(^PS(50.605,+Y,0),U,2),Y="^V."_$P(Y,U,2)
 Q
HI ;High low cost
 K DIR S DIR(0)="NAO^-999999999999:999999999999:2",DIR("A")="SELECT UPPER COST BOUND: ",DIR("?")="ENTER A NUMBER BETWEEN -999999999999 AND 999999999999" D ^DIR I $D(DIRUT) S Y=-1 Q
 S Y=1,UCO=X,X=1
 S DIR("A")="SELECT LOWER COST BOUND: " D ^DIR I $D(DIRUT) S Y=-1 Q
 I X>UCO W $C(7),!,"LOWER COST BOUND MUST BE LESS THAN UPPER COST BOUND!" G HI
 K DIR S Y=1,LCO=X,X=1
 Q
 ;
T ;Type
 K DA,DIR S DIR(0)="55.01,.04O",DIR("A")="Select IV TYPE" W ! D ^DIR I "^"'[X S Y="T."_Y
 E  S Y=-1
 Q
