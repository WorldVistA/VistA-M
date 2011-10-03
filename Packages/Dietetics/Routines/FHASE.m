FHASE ; HISC/REL/NCA - Dietetic Encounters ;7/22/96  13:17
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Encounter Types
 S (DIC,DIE)="^FH(115.6,",DIC(0)="AEQLM",DIC("DR")=".01",DLAYGO=115.6 W ! D ^DIC K DIC,DLAYGO G KIL:"^"[X!$D(DTOUT),EN1:Y<1
 S DA=+Y,DR=$S(DA=1:2,DA=2:"2;3",1:".01;1:4;10;5:6;I X'=""Y"" S Y=99;7;8;99") S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=115.6 D ^DIE,KIL G EN1
EN2 ; List Encounter Types
 W ! S L=0,DIC="^FH(115.6,",FLDS=".01,2,3,4,10,5,6,7,8,99",BY=".01"
 S (FR,TO)="",DHD="ENCOUNTER TYPES" D EN1^DIP,RSET Q
EN3 ; Enter Dietetic Encounter
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D EN3^FHMASE Q
 W ! K DIR S FHN=0,DIR(0)="YAO",DIR("A")="Enter a NEW Encounter (Y/N)? " D ^DIR G:$D(DIROUT)!($D(DIRUT)) KIL K DIR,DIROUT,DIRUT
 I 'Y S FHN=1 G EN4
EN30 ; Enter/Edit a Encounter
 D EN31 G:Y<1 KIL G EN3
EN31 ; Enter a Encounter
 K %DT S FHN=0,%DT="AETPX",%DT("A")="DATE/TIME OF ENCOUNTER: ",%DT("B")="TODAY",%DT(0)="-NOW" W ! D ^%DT K %DT S:$D(DTOUT) Y=0 Q:Y<1  S DTE=Y
 K DIC,DD,DO S DIC="^FHEN(",DIC(0)="L",DIC("DR")="1////^S X=DTE",DLAYGO=115.7
A L +^FHEN(0) S DA=$P(^FHEN(0),"^",3)+1 I $D(^FHEN(DA)) S $P(^FHEN(0),"^",3)=DA L -^FHEN(0) G A
 S (X,DINUM)=DA D FILE^DICN L -^FHEN(0) S ASE=+Y,FHX4="" K DIC,DLAYGO,DINUM
 D EDIT Q
EN4 ; Process Edit Encounter
 W ! K ^TMP($J,"ECTR"),%DT S %DT="AEPX",%DT("A")="Enter Date of Encounter you want to edit: " D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 KIL S X1=Y,(TIM,X1)=X1-.0001,(EDT,X2)=Y\1+.3,CTR=0
A0 W !! K DIR S DIR(0)="SO^C:CLINICIAN;P:PATIENT",DIR("A")="CHOOSE CLINICIAN or PATIENT" D ^DIR K DIR G:$D(DIROUT)!($D(DIRUT)) KIL I Y?1"P" D PAT G:'DFN KIL D PR G:Y<1 KIL D ASK G KIL:Y<1,EN4
A1 K DIC S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Select CLINICIAN: " W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),A1:Y<1 S NAM=+Y D CLIN,PR G:Y<1 KIL D ASK G KIL:Y<1,EN4
PR W ! S K1="" F CTR=0:0 S CTR=$O(^TMP($J,"ECTR",CTR)) Q:CTR<1  S X=$G(^(CTR,0)),K1=CTR W !,CTR,"  " S Y=$P(X,"^",2) X ^DD("DD") W Y,"  ",$P(X,"^",3) K Y
 I 'K1 W !?5,"No encounter on file on this date" S Y=0 Q
 W !!,"Select number you want: " R X:DTIME I '$T!("^"[X) S Y=0 Q
 I X'?1.N!(X<1)!(X>K1) W *7,!!,"Select only a number no greater than ",K1," or press ""^"" or a return to exit." G PR
 S ASE=$P($G(^TMP($J,"ECTR",+X,0)),"^",1),FHX4=$G(^FHEN(ASE,0))
 S FHCLK=$P($G(^TMP($J,"ECTR",+X,0)),"^",4) W !
EDIT N FHX1 S DA=ASE K DIC,DIE S DIE="^FHEN(",DR="[FHASE]" D ^DIE K DIC,DIE,DR
 S DA=ASE,X=^FHEN(DA,0)
 I '$P(X,"^",3)!('$P(X,"^",4)) S DIK="^FHEN(" D ^DIK W *7,!,"<encounter deleted>" K DIK,DA
 S Y=1 Q
PAT ; Get Patient
 S ALL=1 D ^FHDPA Q:'DFN
 I $P($G(^DPT(DFN,.35)),"^",1) W *7,!!?5,"Patient has expired." G PAT
 I '$D(^FHEN("AP",DFN)) W !!,"No Encounter on file for this patient." G PAT
 F DTE=TIM:0 S DTE=$O(^FHEN("AP",DFN,DTE)) Q:DTE<1!(DTE>EDT)  F ASE=0:0 S ASE=$O(^FHEN("AP",DFN,DTE,ASE)) Q:ASE<1  S Y=$P($G(^FHEN(ASE,0)),"^",4) I Y>2 D
 .S CTR=CTR+1,^TMP($J,"ECTR",CTR,0)=ASE_"^"_DTE_"^"_$P($G(^FH(115.6,+Y,0)),"^",1)_"^"_$P($G(^FHEN(ASE,0)),"^",13) Q
 Q
CLIN ; Get Clinician
 S X1=$O(^FHEN("AT",X1)) Q:X1<1!(X1>X2)
 S ASE=0
R1 S ASE=$O(^FHEN("AT",X1,ASE)) G:ASE="" CLIN
 S Y=$G(^FHEN(ASE,0)),E1=$P(Y,"^",3) I $P(Y,"^",4)>2,E1,E1=NAM S CTR=CTR+1,^TMP($J,"ECTR",CTR,0)=ASE_"^"_$P(Y,"^",2)_"^"_$P($G(^FH(115.6,+$P(Y,"^",4),0)),"^",1)_"^"_$P(Y,"^",13),DTE=$P(Y,"^",2)
 G R1
ASK R !!,"Is this correct? Y// ",YN:DTIME I '$T!(YN["^") S Y=0 Q
 S:YN="" YN="Y" S X=YN D TR^FH S YN=X
 I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G ASK
 Q:YN?1"Y".E
 I FHCLK'=DUZ W !!,"You can ONLY DELETE an encounter that is entered by you.",! G EDIT
E5 R !,"Want to delete encounter? N// ",YN:DTIME I '$T!(YN["^") S Y=0 Q
 S:YN="" YN="N" S X=YN D TR^FH S YN=X
 I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G E5
 Q:YN?1"N".E
 S DIK="^FHEN(",DA=ASE D ^DIK W *7,!,"<encounter deleted>" K DA,DIK S Y=1 Q
CNT S FHX3=FHX3+$P($G(^FHEN(ASE,"P",0)),"^",4)
 S ST="" F LP=0:0 S LP=$O(^FHEN(ASE,"P",LP)) Q:LP<1  S ST=$G(^(LP,0)) I $P(ST,"^",3)'<1 S FHX3=FHX3+$P(ST,"^",3)
 Q
RSET K %ZIS S IOP="" D ^%ZIS
KIL K ^TMP($J,"ECTR") G KILL^XUSCLEAN
