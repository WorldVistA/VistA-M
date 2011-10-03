SRTPRACE ;BIR/SJA - RACE INFORMATION ;03/27/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 N RAC,I,SRY,CNT,SRPAGE,SRYN S $P(SRLINE,"-",80)=""
 S SRSOUT=0 I '$D(SRTPP) W @IOF,!!,"A transplant assessment must be selected prior to using this option.",!!,"Press RETURN to continue  " R X:DTIME S SRSOUT=1 G END
START S SRPAGE="RACE INFORMATION" D HDR
 K SRORAC S (RAC,CNT)=0 F  S RAC=$O(^SRT(SRTPP,44,RAC)) Q:'RAC!($D(SRORAC))  Q:SRSOUT  S CNT=CNT+1 D LIST I CNT=13 W !!,SRLINE D SEL
 I SRSOUT Q
 I $D(SRORAC) D EDIT G START
 I CNT W !!,SRLINE
 I CNT=0 D ASK G:'SRSOUT START S SRSOUT=0 Q
OPT W !!,"Enter "_$S(CNT=1:1,1:"(1-"_CNT_")")_" to edit an existing race, or 'NEW' to enter another race code: " R X:DTIME I '$T!("^"[X) Q
 I "Nn"[$E(X) D NEW G START
 I '$D(SRACE(X)) W !!,"Select the number corresponding to the race you want to edit, or 'NEW' to",!,"enter an additional race information." G OPT
 S SRORAC=$P(SRACE(X),"^",3) D EDIT G START
 Q
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL W @IOF
 Q
LIST ; list existing race
 K SRY S DIC="^SRT(",DR=44,DA=SRTPP,DR(139.544)=".01",DA(139.544)=RAC,DIQ="SRY",DIQ(0)="E" D EN^DIQ1
 S SRACE(CNT)=$G(^SRT(SRTPP,44,RAC,0))_"^"_$G(SRY(139.544,RAC,.01,"E"))_"^"_RAC
 W !,$S(CNT<10:" ",1:"")_CNT_". "_$P(SRACE(CNT),"^",2)
 Q
SEL ; select race
 W !!,"Select (1-"_CNT_") to edit an existing race, or RETURN to continue: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X="" S CNT=0 K SRACE D HDR Q
 I '$D(SRACE(X)) W !!,"Enter the number corresponding to the race you want to edit, or RETURN",!,"to continue listing." G SEL
 S SRORAC=$P(SRACE(X),"^",3)
 Q
HDR ; print screen header
 I '$D(SRHDR) D SRHDR^SRTPUTL
 W @IOF,!,SRHDR W:$G(SRPAGE)'="" ?(79-$L(SRPAGE)),SRPAGE
 S I=0 F  S I=$O(SRHDR(I)) Q:'I  W !,SRHDR(I) I I=1,$L($G(SRHPG)) W ?(79-$L(SRHPG)),SRHPG
 K SRHPG,SRPAGE W ! F I=1:1:80 W "-"
 W !
 Q
EDIT ; edit one race
 D HDR W ! S DA=SRORAC,DIE="^SRT("_SRTPP_",44,",DA(1)=SRTPP,DR=".01T" D ^DIE K DR,DIE
 Q
ASK W !!,"There are no race data entered for this donor.  Do you want to add",!,"a new race ? YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N"
 S:SRYN="" SRYN="Y"
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to add another race, or 'NO' to return to the",!,"previous screen." G ASK
 I "Nn"[SRYN S SRSOUT=1 Q
NEW D HDR W ! K DIR,DA S DIR(0)="139.544,.01",DIR("A")="Donor Race" D ^DIR I Y=""!$D(DTOUT)!$D(DUOUT) Q
 I $D(^SRT(SRTPP,44,"B",Y)) W $C(7)," ??" Q
 I '$D(^SRT(SRTPP,44,0)) S ^SRT(SRTPP,44,0)="^139.544SA^^"
 K DA,DIC,DD,DO,DINUM S DA(1)=SRTPP,X=Y,DIC="^SRT("_SRTPP_",44,",DIC(0)="L" D FILE^DICN K DA,DIC,DD,DO,DINUM
 Q
