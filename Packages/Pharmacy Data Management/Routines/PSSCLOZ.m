PSSCLOZ ;BIR/TTH-CLOZAPINE DRUG ENTER/EDIT CLOZAPINE ; 01/25/99
 ;;1.0;PHARMACY DATA MANAGEMENT;**19,90**;9/30/97
 ;
 ;Reference to ^LAB(60 supported by DBIA #10054
 ;Reference to ^LAB(61 supported by DBIA #10055
 ;
 Q:'$D(DISPDRG)
 N DA,DIC,DIE,DIK,DINUM,DIR,DR,PSSANS,PSSANS2,PSSCIM,PSSCLO,PSSCNT,PSSCRN,PSSIEN,PSSLAB1,PSSLAB2,PSSLT,PSSLTN,PSSNN,PSSNUM,PSSOPP,PSSPTY,PSSPTYN,PSSSUB,PSSTOT,PSSTUFF,PSSTYP0,PSSXX,X,Y
 K DIRUT,DUOUT
 ;Mark drug for Clozapine and create "ACLOZ" cross-reference.
 S DA=DISPDRG,DIE=50,DR="17.5///^S X=""PSOCLO1""" D ^DIE K DA,DIE
 ;
CLOZBEG I $D(DIRUT)!($D(DUOUT)) Q
 S (PSSIEN,PSSCNT)=0
 I $O(^PSDRUG(DISPDRG,"CLOZ2",0)) F PSSIEN=0:0 S PSSIEN=$O(^PSDRUG(DISPDRG,"CLOZ2",PSSIEN)) Q:'PSSIEN  D
 .S PSSSUB=$P($G(^PSDRUG(DISPDRG,"CLOZ2",PSSIEN,0)),U),PSSTYP0=$P($G(^(0)),U,4),PSSCIM=$P($G(^(0)),U,3)
 .K PSSLAB1,PSSLAB2 S PSSLAB1=$$GET1^DIQ(60,PSSSUB,.01,"I"),PSSLAB2=$$GET1^DIQ(61,PSSCIM,.01,"I")
 .S PSSCNT=PSSCNT+1,PSSCLO(PSSCNT)=$S($D(PSSLAB1):PSSLAB1,1:"**Unknown Lab Test**")_"^"_PSSSUB_"^"_PSSIEN_"^"_PSSTYP0_"^"_$S($D(PSSLAB2):PSSLAB2,1:"**Unknown Lab Test**")
 W !!,"Prescription of Clozapine requires identification of two",!,"laboratory tests, WBC and Absolute Neutrophil Count (ANC).",!!
 I PSSCNT=0 W "You do not have any laboratory tests identified." W !! S DIR(0)="SOA^WBC:WBC;ANC:ANC",DIR("B")="WBC" S DIR("A")="Select Laboratory Test Type: " D ^DIR Q:$D(DIRUT)  S PSSTUFF=Y K DIR,X,Y G CLOZBG2
 I PSSCNT=1 W "You have one laboratory type of "_$S(PSSTYP0=1:"WBC",PSSTYP0=2:"ANC",1:"**Unknown**")_" test identified." S PSSTUFF=$S(PSSTYP0=2:1,1:2)
 I PSSCNT>1 W "You currently have both laboratory tests identified."
 ;
 D DISPLAY
 ;
CLOZBG2 I PSSCNT=0 S PSSANS="A" D CLOZSEL Q
 S DIR("?")="Enter the letter that correspond with the function."
 I PSSCNT=1 D  Q:$D(DIRUT)
 .S PSSOPP=$S(PSSTYP0=2:"WBC",PSSTYP0=1:"ANC",1:"**Data Missing**")
 .W !!,"A second laboratory type of "_PSSOPP_" test should be added.",! S DIR(0)="SOA^A:ADD;E:EDIT;D:DELETE",DIR("A")="(A)dd, (E)dit, or (D)elete entry? " D ^DIR Q:$D(DIRUT)
 I PSSCNT>1 W !! S DIR(0)="SOA^E:EDIT;D:DELETE",DIR("A")="(E)dit or (D)elete entry? " D ^DIR Q:$D(DIRUT)
 S PSSANS=Y D CLOZSEL Q:$D(DIRUT)
 ;
END ;Kill variables.
 K DIC,DIE,DIK,DIR,DR,PSSANS,PSSANS2,PSSCNT,PSSSUB,PSSXX,X,Y
 Q
 ;
DISPLAY ;Display lab test.
 W !!!,?2,"Type of",!,?2,"Test",?12,"Lab Test Monitor",?55,"Specimen Type",!,?2,"-------",?12,"----------------",?55,"-------------"
 Q:'$O(PSSCLO(0))  W ! F PSSXX=0:0 S PSSXX=$O(PSSCLO(PSSXX)) Q:'PSSXX  D
 .S PSSTOT=$P($G(PSSCLO(PSSXX)),U,4)
 .W !,?2,PSSXX_".  "_$S(PSSTOT=1:"WBC",PSSTOT=2:"ANC",1:"**Unknown**"),?12,$P(PSSCLO(PSSXX),U),?55,$E($P(PSSCLO(PSSXX),U,5),1,20)
 Q
 ;
CLOZSEL ;Execute add, edit or delete submodule.
 I PSSCNT>1,($G(PSSANS)'="A") D CLOZASK Q:$D(DIRUT)
 I PSSANS="D" D:PSSCNT=1 CLOZASK D CLOZDEL Q
 I PSSANS="E" D:PSSCNT=1 CLOZASK D CLOZEDT Q
 ;
CLOZADD ;Add Clozapine sub-entry
 Q:$D(DIRUT)
 D DISPLY2 Q:$D(DIRUT)  I Y=0 D END Q:$G(DIRUT)  W !! K PSSCLO G CLOZBEG
CLOZAD2 K DIC,DD,DO S X=PSSLTN,DA(1)=DISPDRG,DIC="^PSDRUG("_DA(1)_",""CLOZ2"","
 S DIC(0)="L",DIC("P")="50.02P"
 S DIC("DR")="2///"_PSSPTYN_";3///"_PSSTUFF
 D FILE^DICN K DD,DO I Y=-1 S (DUOUT,DIRUT)=1 K DIC,DA,X,Y Q
 D END Q:$G(DIRUT)  W !! K PSSCLO G CLOZBEG
 Q
 ;
CLOZEDT ;Edit Clozapine sub-entry
 Q:$D(DIRUT)  K DIE,DR,X,Y S DA=PSSANS2
 S DIE="^PSDRUG(DISPDRG,""CLOZ2"","
 S DR=".01;2;3///"_PSSTUFF D ^DIE I $D(Y) S (DUOUT,DIRUT)=1 D CLOZDXX K ^PSDRUG(DISPDRG,"CLOZ2"),DIE,DR,X,Y Q
 D END Q:$G(DIRUT)  W !! K PSSCLO G CLOZBEG
 Q
 ;
CLOZDEL ;Delete Clozapine sub-entry
 Q:$D(DIRUT)  I PSSCNT<3 W !,"You must have a test defined for WBC and ANC to dispense Clozapine.",!
 S DIR("A")="Are you sure that you want to delete this test",DIR("?")="Enter YES to delete the laboratory test, NO to return to selection.",DIR(0)="Y",DIR("B")="NO" D ^DIR Q:$D(DIRUT)  I +Y=0 D END W !! K PSSCLO G CLOZBEG
 ;
CLOZDXX K DIK,X,Y
 S DA(1)=DISPDRG,DA=PSSANS2,DIK="^PSDRUG(DISPDRG,""CLOZ2"","
 D ^DIK  K DIK,X,Y
 I PSSANS="E",PSSCNT>1 Q
 Q:PSSANS="A"  W !!,"Deleting "_$P(PSSCLO(PSSNUM),U)_"...."
 D END Q:$G(DIRUT)  W !! K PSSCLO G CLOZBEG
 Q
CLOZASK ;Select LAB Test number.
 I $D(DIRUT)!($D(DUOUT)) Q
 W ! K DIR,Y S DIR(0)="NA^1:"_PSSCNT_":1",DIR("A")="Select the Number of the test you want to "_$S(PSSANS="D":"delete",1:"edit")_" (1 or "_PSSCNT_"): "
 S DIR("?")="Enter the number you want to delete or edit." D ^DIR Q:$D(DIRUT)
 S PSSNUM=+Y,PSSANS2=$P(PSSCLO(PSSNUM),U,3) I PSSANS="E" S PSSTUFF=$P(PSSCLO(PSSNUM),U,4) I PSSCNT>1 D  Q:$D(DIRUT)  I Y=0 D END W !! K PSSCLO G CLOZBEG
 .S PSSNN=$S(PSSNUM=1:2,1:1),PSSCRN=$P(PSSCLO(PSSNN),U,2)
 .D DISPLY3 Q:$D(DIRUT)!(Y=0)
 .D CLOZDXX ;Delete selected entry.
 .D CLOZAD2 ;Add entry with new changes.
 Q
 ;
DISPLY2 ;Display selection before adding to file.
 Q:$D(DIRUT)  S PSSCRN=$P($G(PSSCLO(1)),U,2)
DISPLY3 K DIR,X,Y W ! S DIR(0)="P^60:EMAQZ",DIR("S")="I PSSCRN'=+Y" D ^DIR Q:$D(DIRUT)  S PSSLTN=+Y,PSSLT=$P(Y,U,2)
 K DIR,X,Y S DIR(0)="P^61:EMAQZ",DIR("A")="Select SPECIMEN TYPE" D ^DIR Q:$D(DIRUT)  S PSSPTYN=+Y,PSSPTY=$P(Y,U,2) K DIR,X,Y
 W !!,"You have selected the following information for",!,"a Laboratory Type of "_$S(PSSTUFF=2:"ANC",1:"WBC")_" test."
 W !!,?2,"Lab Test Monitor: "_PSSLT,!,?2,"Specimen Type   : "_PSSPTY
 K DIR,X,Y W !! S DIR("A")="Is this correct",DIR("?")="Enter YES to accept, NO to reject.",DIR(0)="Y",DIR("B")="YES" D ^DIR
 Q
 ;
CLOZMOV ;In File #50, move data CLOZ node to CLOZ2 node.
 N PSSIEN,PSSGLO
 S (PSSIEN,PSSGLO)=0
 F PSSIEN=0:0 S PSSIEN=$O(^PSDRUG(PSSIEN)) Q:'PSSIEN  I $P($G(^PSDRUG(PSSIEN,"CLOZ1")),"^")="PSOCLO1" D
 .S ^PSDRUG("ACLOZ",PSSIEN)="",PSSGLO=^PSDRUG(PSSIEN,"CLOZ")
 .K DIC,DD,DO,X S (DA,DINUM)=1,DA(1)=PSSIEN,X=$P(PSSGLO,"^") Q:'X
 .S DIC("P")="50.02P",DIC(0)="L"
 .S DIC="^PSDRUG("_DA(1)_",""CLOZ2"","
 .S DIC("DR")="1////"_$P(PSSGLO,"^",2)_";2////"_$P(PSSGLO,"^",3)_";3///1"
 .D FILE^DICN K DIC,DA
 Q
