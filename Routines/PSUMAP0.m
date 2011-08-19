PSUMAP0 ;BHM/PDW-MAP OAU,NAOU,DA LOCATION TO DIVISION/OUTPATIENT SITES ; 4/12/07 2:12pm
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**12**;MARCH, 2005;Build 19
 ;
 ;DBIA's
 ;Reference to file (#59.7) supported by DBIA 2854
 ;
EN ; select Editing or Report of Mapping
 W @IOF,!,?10,"MAPPING PHARMACY LOCATIONS FOR PBM EXTRACTS",!!
 ;
MODP ; module selection prompt
 W !!,?5,"This option allows the mapping of dispensing/procurement locations"
 W !,?5,"from the AR/WS, Controlled Substances, and Drug Accountability"
 W !,?5,"applications to either a Medical Center Division or an Outpatient Site."
 W !,?5,"Any dispensing/procurement data associated with an AR/WS AOU, CS NAOU"
 W !,?5,"or DA Pharmacy Location that has not been mapped will be attributed to"
 W !,?5,"to the facility at which the database resides.  Any unmapped locations"
 W !,?5,"will be displayed upon entering the option.",!
 ;
 D EN1^PSUMAPR ;scan and report unmapped locations
 W @IOF
 ;
MODULE ;
 W !!,"Select the dispensing/procurement location to map:",!
 S PSUA(1)="1.  AR/WS Area of Use (AOU)"
 S PSUA(2)="2.  Controlled Substances (CS) Narcotic Area of Use (NAOU)"
 S PSUA(3)="3.  Drug Accountability (DA) Pharmacy location"
 S PSUA(4)="4.  Print Report of Mapped/Unmapped Locations"
 F I=1:1:4 W !,?10,PSUA(I)
 W !!,?2,"You may select all by entering 'A' for ALL or by using '1:4'.",!
 W !,?2,"Select the dispensing/procurement location: "
 R X:DTIME E  W !!,"Nothing Selected - Exiting",! H 3 G EXIT
 I X["^" G EXIT:X="^"
 I X="" W "  <??>",$C(7) S X="?"
 ;
 S:"Aa"[$E(X) X="1:4"
MODHLP I X["?" D  G MODULE
 .W !!,"Enter:  A single number to edit (or print) that selection."
 .W !,?8,"A range of code numbers.  Example:  1:3"
 .W !,?8,"Multiple code numbers separated by commas.  Example:  1,3"
 .W !,?8,"The letter A to select ALL items."
 .W !,?8,"A single up-arrow ( ^ ) to exit now without any action."
 S X=$TR(X,"-;_><.A","::::::")
 K PSUMOD
 F PII=1:1:$L(X,",") D
 .S X1=$P(X,",",PII)
 .Q:X1=""
 .I X1[":" D  Q
 ..S XBEG=$P(X1,":",1),XEND=$P(X1,":",2)
 ..I (XBEG="")!(XEND="") Q
 ..F PJJ=XBEG:1:XEND S PSUMOD(PJJ)=""
 ..K PJJ,XBEG,XEND
 .S PSUMOD(X1)=""
 ; modified to fix <UNDEFINED> PSU*3*12 BAJ
 S X="",ERC=0 F  S X=$O(PSUMOD(X)) Q:X=""  I '$D(PSUA(X)) S ERC=1 Q
 I ERC W !!,"<INVALID CHOICE - ",X,", TRY AGAIN>",$C(7) G MODP
 I '$D(PSUMOD) W !!,"No choices were made." K DIR S DIR(0)="E",DIR("A")="EXITING" D ^DIR G EXIT
 ;
 ;
 W !!,"You have selected: "
 S X="",PSUOPTS="" F  S X=$O(PSUMOD(X)) Q:X=""  W !,?10,PSUA(X)
 W ! K DIR S DIR(0)="E" D ^DIR G:'Y EXIT
 I $D(PSUMOD(4)) D REPORT K PSUA(4)
 I $D(PSUMOD(1)) D E9001
 I $D(PSUMOD(2)) D E9002
 I $D(PSUMOD(3)) D E9003
 Q
E9001 ;EDIT 90.01 AR/WS AOU MAPPING
 W @IOF,!!,?20,"EDITING Mapping of AR/WS AOUs",!!
 K DIC,DA,DIE
 K Z,ZZ,IENS
 S DA(1)=1
 S DIC="^PS(59.7,1,90.01,",DA(1)=1,DIC(0)="ACEQML"
 S DIC("W")="X XX1,XX2"
 S XX1="S IENS=+Y_"",""_DA(1) S Z=$$GET1^DIQ(59.79001,IENS,.02),ZZ=$$GET1^DIQ(59.79001,IENS,.03) W:$L(Z) ?35,""Div: "",Z W:$L(ZZ) ?35,""OP:  "",ZZ"
 S XX2="S ZZ=$$GET1^DIQ(58.1,+Y,3,""I"") W:ZZ ?65,""**INACTIVE**"""
 D ^DIC
 Q:Y'>0
 S DA=+Y,DIE=DIC
 S ZZ=^PS(59.7,1,90.01,DA,0),XX=$P(ZZ,U,2),YY=$P(ZZ,U,3)
 I YY S DR=".01;.03;S:X'="""" Y=0;.02" I 1
 E  S DR=".01;.02;S:X'="""" Y=0;.03"
 D ^DIE W !
 G E9001
 ;
CHK1 ;check that AOUs are mapped
 K IENS
 S DA=0,DA(1)=1 F  S DA=$O(^PS(59.7,1,90.01,DA)) Q:DA'>0  D
 . S Z=^PS(59.7,1,90.01,DA,0),X=$P(Z,U,2),Y=$P(Z,U,3)
 . I Y,'X Q
 . I 'Y,X Q
 . S IENS=DA_",1" W !,?3,"AR/WS AOU",?15,$$GET1^DIQ(59.79001,IENS,.01),?25," is not mapped."
 I $G(STOP),$G(IENS) K DIR S DIR(0)="E" D ^DIR I X="^" S PSUSTOP=1 I 1
 Q
 ;
E9002 ;EDIT 90.02 CS NAOU MAPPING
 W @IOF,!!,?20,"EDITING Mapping of CS NAOUs",!!
 K DIC,DA,DIE
 K Z,ZZ,IENS
 S DA(1)=1
 S DIC="^PS(59.7,DA(1),90.02,",DIC(0)="AEQMLCZ"
 S DIC("W")="X XX1,XX2"
 S XX1="S IENS=+Y_"",""_DA(1) S Z=$$GET1^DIQ(59.79002,IENS,.02),ZZ=$$GET1^DIQ(59.79002,IENS,.03) W:$L(Z) ?35,""Div: "",Z W:$L(ZZ) ?35,""OP:  "",ZZ"
 S XX2="S ZZ=$$GET1^DIQ(58.8,+Y,4,""I"") W:ZZ ?65,""**INACTIVE** """
 D ^DIC
 Q:Y'>0
 S DA=+Y,DIE=DIC
 S ZZ=^PS(59.7,1,90.02,DA,0),XX=$P(ZZ,U,2),YY=$P(ZZ,U,3)
 I YY S DR=".01;.03;S:X'="""" Y=0;.02" I 1
 E  S DR=".01;.02;S:X'="""" Y=0;.03"
 D ^DIE W !
 G E9002
 ;
CHK2 ;check that NAOUs are mapped
 K IENS
 S DA=0,DA(1)=1 F  S DA=$O(^PS(59.7,1,90.02,DA)) Q:DA'>0  D
 . S Z=^PS(59.7,1,90.02,DA,0),X=$P(Z,U,2),Y=$P(Z,U,3)
 . I Y,'X Q
 . I 'Y,X Q
 . S IENS=DA_",1" W !,?3,"CS NAOU",?15,$$GET1^DIQ(59.79002,IENS,.01),?25," is not mapped."
 Q
E9003 ;EDIT 90.03 DRUG ACCOUNTABILITY LOCATION MAPPING
 W @IOF,!!,?20,"EDITING Mapping of DA Pharmacy Locations",!!
 K DIC,DA,DIE
 K Z,ZZ,IENS
 S DA(1)=1
 S DIC="^PS(59.7,DA(1),90.03,",DIC(0)="AEQMLZ"
 S DIC("W")="X XX1,XX2"
 S XX1="S IENS=+Y_"",""_DA(1) S Z=$$GET1^DIQ(59.79003,IENS,.02),ZZ=$$GET1^DIQ(59.79003,IENS,.03) W:$L(Z) ?35,"" Div: "",Z W:$L(ZZ) ?35,""OP:  "",ZZ"
 S XX2="S ZZ=$$GET1^DIQ(58.8,+Y,4,""I"") W:ZZ ?65,""**INACTIVE** """
 D ^DIC
 Q:Y'>0
 S DA=+Y,DIE=DIC
 S ZZ=^PS(59.7,1,90.03,DA,0),XX=$P(ZZ,U,2),YY=$P(ZZ,U,3)
 I YY S DR=".01;.03;S:X'="""" Y=0;.02" I 1
 E  S DR=".01;.02;S:X'="""" Y=0;.03"
 D ^DIE W !
 G E9003
 ;
CHK3 ;check that DRUG ACCOUNTABILITY LOCATIONs are mapped
 K IENS
 S DA=0,DA(1)=1 F  S DA=$O(^PS(59.7,1,90.03,DA)) Q:DA'>0  D
 . S Z=^PS(59.7,1,90.03,DA,0),X=$P(Z,U,2),Y=$P(Z,U,3)
 . I Y,'X Q
 . I 'Y,X Q
 . S IENS=DA_",1" W !,?3,"DA Phar Loc",?15,$$GET1^DIQ(59.79003,IENS,.01),?25," is not mapped."
 I $G(STOP),$G(IENS) K DIR S DIR(0)="E" D ^DIR I X="^" S PSUSTOP=1 I 1
 Q
REPORT ;Print Mapping Report
 W @IOF,!,"Print Pharmacy Location PBM Extract Mapping Report",!
 S %ZIS="Q" D ^%ZIS
 Q:POP
 I $D(IO("Q")) D QUEUE Q
 D EN^PSUMAPR
 Q
QUEUE S ZTRTN="EN^PSUMAPR",ZTDESC="PRINT REPORT OF PBM EXTRACT MAPPING"
 S ZTREQ="@" D ^%ZTLOAD
 W !,"TASKED with ",$G(ZTSK) I '$G(ZTSK) W ">> DID NOT Task !!",! H 3
 Q
EXIT ;
 Q
