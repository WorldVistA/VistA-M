VADPT60 ;ALB/MJK - Patient ID Utilities; 12 AUG 89 @1200
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN D DT^DICRW S X="VADPT60",DIK="^DOPT("""_X_""","
 G:$D(^DOPT(X,7)) A S ^DOPT(X,0)="Patient ID Utilities^1N^"
 F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT(X,I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A ;
 W !! S DIC="^DOPT(""VADPT60"",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;ID Format Enter/Edit
 G 1^VADPT61
 ;
2 ;;Eligibility Code Enter/Edit
 G 2^VADPT61
 ;
3 ;;Specific ID Format Reset (All Patients)
 W ! S DIC="^DIC(8.2,",DIC(0)="AEMQZ" D ^DIC K DIC G Q3:+Y<1 S VAFMT=+Y
 S X=Y(0) D WARN^VADPT61
31 W !!,"Are you sure" S %=2 D YN^DICN
 I '% W !?5,"Answer 'YES' if you wish to reset id's for all patients with",!?5,"this format." G 31
 G 3:%'=1
 S VAOPT=3 D TASK^VADPT61 G Q3
QUE3 ; -- determine which elig use format
 D BEG^VADPT61
 K VAELG F VAELG=0:0 S VAELG=$O(^DIC(8,"AF",VAFMT,VAELG)) Q:'VAELG  S VAELG(VAELG)=""
 ; -- find pt's and reset
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  F VAELG=0:0 S VAELG=$O(^DPT(DFN,"E",VAELG)) Q:'VAELG  I $D(VAELG(VAELG)),$D(^(VAELG,0)) D IX
 D END^VADPT61
Q3 K DFN,VAELG,VAFMT Q
 ;
4 ;;Primary Eligibility ID Reset (All Patients)
 W !!,"Are you sure" S %=2 D YN^DICN
 I '% W !?5,"Answer 'YES' if you wish to set or reset the patient id for",!?5,"the id format associated with EACH patient's primary eligibility." G 4
 G Q4:%'=1
41 S VAOPT=4 D TASK^VADPT61 G Q4
QUE4 K VALL D BEG^VADPT61,ALL,END^VADPT61
Q4 Q
 ;
5 ;;Specific Eligibility ID Reset (All Patients)
 W ! S DIC="^DIC(8,",DIC(0)="AEMQZ" D ^DIC K DIC G Q5:+Y<1 S VAELG=+Y
 I '$D(^DIC(8.2,+$P(Y(0),U,10),0)) W !!?5,*7,"No id format specified for this eligibility." G Q5
 S X=^(0) D WARN^VADPT61
51 W !!,"Are you sure" S %=2 D YN^DICN
 I '% W !?5,"Answer 'YES' if you wish to reset id's for all patients with",!?5,"this ELIGIBILITY." G 51
 G 5:%'=1
 S VAOPT=5 D TASK^VADPT61 G Q5
QUE5 D BEG^VADPT61
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  I $D(^DPT(DFN,"E",VAELG,0)) D IX
 D END^VADPT61
Q5 K VAELG,DFN Q
 ;
6 ;;Reset ALL ID's for a Patient
 W ! S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC K DIC G Q6:+Y<1 S DFN=+Y
61 W !!,"Are you sure" S %=2 D YN^DICN
 I '% W !?5,"Answer 'YES' if you want to reset all the id's associated",!?5,"with this patient.",!!?5,"If the id format requires user input, you will be asked to enter the id." G 61
 G 6:%'=1
PAT ; -- entry point if DFN is defined
 F VAELG=0:0 S VAELG=$O(^DPT(DFN,"E",VAELG)) Q:'VAELG  I $D(^(VAELG,0)),$D(^DIC(8,VAELG,0)) W:'$D(VABATCH) !?5,"...",$P(^(0),U) D IX I '$D(VABATCH) D ASK^VADPT61 W ?40,$P(^DPT(DFN,"E",VAELG,0),U,3)_" / "_$P(^(0),U,4)
Q6 K DFN,VAELG
 Q
 ;
7 ;;Reset ALL ID's for ALL Patients
 W !!,"Are you sure" S %=2 D YN^DICN
 I '% W !?5,"Answer 'YES' if you want to reset all the id's associated",!?5,"with ALL patients." G 7
 G Q7:%'=1
 S VAOPT=7 D TASK^VADPT61 G Q7
QUE7 S VALL="" D BEG^VADPT61,ALL,END^VADPT61
Q7 K VALL
 Q
 ;
FILE ;
 S $P(^DPT(DFN,"E",0),U,2)="2.0361P"
 I $D(^DPT(DFN,"E",VAELG,0)) D IX G PATQ
 L +^DPT(DFN,"E",VAELG)
 S $P(^(0),"^",3,4)=VAELG_"^"_($P(^DPT(DFN,"E",0),"^",4)+1)
 S ^DPT(DFN,"E",VAELG,0)=VAELG
 L -^DPT(DFN,"E",VAELG)
 S DA(1)=DFN,DA=VAELG,DIK="^DPT("_DA(1)_",""E"",",DIK(1)=".01" D EN1^DIK
 K DA,DIK Q
PATQ Q
 ;
IX ;
 S DA(1)=DFN,DA=VAELG,DIK="^DPT("_DA(1)_",""E"",",DIK(1)=".01^3" D EN^DIK
 K DA,DIK Q
 ;
ALL ; -- resets all id's for all pt's
 ;    if VALL not defined then only primary reset
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  D PRI I $D(VALL) F VAELG=0:0 S VAELG=$O(^DPT(DFN,"E",VAELG)) Q:'VAELG  D IX:VAELG'=VAPRI
 K VAPRI,DFN,VAELG
 Q
 ;
PRI ; -- set/reset pri elig id
 S VAPRI=0
 I $D(^DPT(DFN,.36)) S (VAPRI,VAELG)=+^(.36) I $D(^DIC(8,VAELG,0)) D FILE
 Q
 ;
UPDT ; -- called by v5 clean-up
 W !,">>>PRIMARY ELIGIBILITY ID UPDATE..."
 D 41 Q
