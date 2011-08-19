PSSDOS ;BIR/RTR-Dose edit option ;03/10/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**38,49,50,47,129,147,155**;9/30/97;Build 36
 ;
 ;Reference to PS(50.607 supported by DBIA 2221
DOSN ;
 N X,Y,PSSNFID,PSSNAT,PSSNAT1,PSSNATND,PSSNATDF,PSSNATUN,PSSNOCON,PSSST,PSSUN,PSSNAME,PSSIND,PSSDOSA,PSSXYZ,PSSNATST,POSDOS,LPDOS
 N PSSDIEN,PSSONLYI,PSSONLYO,PSSTALK,PSSIZZ,PSSOZZ,PSSSKIPP,PSSWDXF
 N PSSUPRA,PSSIEN S PSSIEN=DA
DOSNX ;
 D STUN
 I PSSST="",$O(^PSDRUG(PSSIEN,"DOS1",0)) K ^PSDRUG(PSSIEN,"DOS") K ^PSDRUG(PSSIEN,"DOS1")
 S (PSSIZZ,PSSOZZ)=0 S:'$G(PSSSKIPP) PSSSKIPP=0
 S PSSXYZ=0 D CHECK
 ;Display strength
 D:$P($G(^PSDRUG(PSSIEN,"DOS")),"^")'="" XNWS
 I PSSXYZ,PSSUPRA="NN" D:$P($G(^PSDRUG(PSSIEN,"DOS")),"^")="" XNW G DOSA
 I $P($G(^PSDRUG(PSSIEN,"DOS")),"^")'="",$O(^PSDRUG(PSSIEN,"DOS1",0)) N PSSIENS,PSS11 G DOSA
 ;.N PSSDESTP W !!,"Strength from National Drug File match => "_$S($E($G(PSSNATST),1)=".":"0",1:"")_$G(PSSNATST)_"    "_$P($G(^PS(50.607,+$G(PSSUN),0)),"^")
 ;.W !,"Strength currently in the Drug File    => "_$S($E($P($G(^PSDRUG(PSSIEN,"DOS")),"^"),1)=".":"0",1:"")_$P($G(^PSDRUG(PSSIEN,"DOS")),"^")_"    "_$S($P($G(^PS(50.607,+$G(PSSUN),0)),"^")'["/":$P($G(^(0)),"^"),1:"") S PSSDESTP=1 D MS^PSSDSPOP
 ;.K PSSDESTP
 ;
 I $G(PSSXYZ),'$O(^PSDRUG(PSSIEN,"DOS1",0)) D  D ^DIR K DIR I Y=1 S PSSSKIPP=1 D EN2^PSSUTIL(PSSIEN,1) G DOSNX
 .K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Create Possible Dosages for this drug",DIR("?")=" "
 .S DIR("?",1)="This drug meets the criteria to have Possible Dosages, but it currently does",DIR("?",2)="not have any. If you answer 'YES', Possible Dosages will be created for this"
 .S DIR("?",3)="drug, based on the match to the National Drug File."
 .W !!,"This drug can have Possible Dosages, but currently does not have any.",!
 .I $G(PSSUPRAF)=2,(PSSUPRA="NO"!(PSSUPRA="NB")) W !,"This drug has been set within the National Drug File to auto create "_$S(PSSUPRA="NO":"only one ",PSSUPRA="NB":"two ",1:""),!,"possible dosage"_$S(PSSUPRA="NO":".",1:"s."),!
 I '$O(^PSDRUG(PSSIEN,"DOS1",0)) D LPD,QUES G:'Y END G LOCX
DOSA S PSSST=$P($G(^PSDRUG(PSSIEN,"DOS")),"^") S PSSWDXF=0
 W !!,"Strength => "_$S($E($G(PSSST),1)=".":"0",1:"")_$G(PSSST)_"   Unit => "_$S($P($G(^PS(50.607,+$G(PSSUN),0)),"^")'["/":$P($G(^(0)),"^"),1:"") W !
 ;;;I $D(^PSDRUG(PSSIEN,"DOS1"))
 D:($Y+5)>IOSL QASK G:PSSWDXF WXF W !,"POSSIBLE DOSAGES:" D
 .F PDS=0:0 S PDS=$O(^PSDRUG(PSSIEN,"DOS1",PDS)) Q:'PDS!(PSSWDXF)  D
 ..S POSDOS=$G(^PSDRUG(PSSIEN,"DOS1",PDS,0))
 ..D:($Y+5)>IOSL QASK Q:PSSWDXF  W !,"   DISPENSE UNITS PER DOSE: ",$S($E($P(POSDOS,U),1)=".":"0",1:"")_$P(POSDOS,U) D
 ...S X=$P(POSDOS,U) D SET^PSSDOSLZ W ?38,"DOSE: ",X,?60,"PACKAGE: ",$P(POSDOS,U,3)
 ;;;I $D(^PSDRUG(PSSIEN,"DOS2"))
 S PSSWDXF=0 W !!,"LOCAL POSSIBLE DOSAGES:" D
 .F PDS=0:0 S PDS=$O(^PSDRUG(PSSIEN,"DOS2",PDS)) Q:'PDS!(PSSWDXF)  D
 ..D:($Y+5)>IOSL QASK Q:PSSWDXF  S LPDOS=$G(^PSDRUG(PSSIEN,"DOS2",PDS,0)) W !,"  LOCAL POSSIBLE DOSAGE: " D
 ...I $L($P(LPDOS,U))'>27 W $P(LPDOS,U),?55,"PACKAGE: ",$P(LPDOS,U,2) D WXFPT(LPDOS) Q
 ...W !,?10,$P(LPDOS,U),!,?55,"PACKAGE: ",$P(LPDOS,U,2) D WXFPT(LPDOS)
WXF ;
 I $$CHECK^PSSUTIL3(PSSIEN),($G(PSSUPRAF)'=2) D
 .I PSSUPRA="NN" W !!,"Due to National Drug File settings no possible dosages were auto-created."
 .I PSSUPRA="NO" W !!,"Due to National Drug File settings only ONE possible dosage was auto-created.",!,"If other dosages are needed, create POSSIBLE DOSAGES or LOCAL POSSIBLE DOSAGES",!,"as appropriate."
 .I PSSUPRA="NB" W !!,"Due to National Drug File settings TWO possible dosages were auto-created."
 I $E(PSSUPRA)="N",($G(PSSUPRAF)=2) D
 .I PSSUPRA["N" W !!,"This drug has been set within the National Drug File to "_$S(PSSUPRA="NN":"not ",1:"")_"auto create "_$S(PSSUPRA="NO":"only one ",PSSUPRA="NB":"two ",1:""),!,"possible dosage"_$S(PSSUPRA="NO":".",1:"s.")
 .S DIR("?",1)="This drug meets the criteria to have Possible Dosages, but it currently does",DIR("?",2)="not have any. If you answer 'YES', Possible Dosages will be created for this"
 .S DIR("?",3)="drug, based on the match to the National Drug File."
 W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to "_$S(PSSUPRA="NN"&('$O(^PSDRUG(PSSIEN,"DOS1",0))):"manually enter possible",1:"edit the")_" dosages",DIR("B")="N"
 I $G(PSSXYZ),'$O(^PSDRUG(PSSIEN,"DOS1",0)),$E(PSSUPRA)="N" D
 .S DIR("?")=" ",DIR("?",1)="This drug meets the criteria to have Possible Dosages, but it currently does",DIR("?",2)="not have any. If you answer 'YES', Possible Dosages can be manually entered for this drug."
 D ^DIR K DIR I 'Y W ! D END Q
 I $G(PSSST) W !!,"Changing the strength will update all possible dosages for this Drug.",!
 ;Edit Strength
 I $G(PSSST) W ! K DIE S DIE="^PSDRUG(",DA=PSSIEN,DR=901 D ^DIE W ! K DIE,PSSXYZ I $P($G(^PSDRUG(PSSIEN,"DOS")),"^")="" K ^PSDRUG(PSSIEN,"DOS") K ^PSDRUG(PSSIEN,"DOS1") W !!,"Deleting Strength has deleted all Possible Dosages!",!
 I '$P($G(^PSDRUG(PSSIEN,"DOS")),"^") D LPD D QUES G:'Y END G LOC
 ;
DOSA1 K DIC S DA(1)=PSSIEN,DIC="^PSDRUG("_PSSIEN_",""DOS1"",",DIC(0)="QEAMLZ",DIC("A")="Select DISPENSE UNITS PER DOSE: " D  D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G DOSLOC
 .S DIC("W")="W ""  ""_$S($E($P($G(^PSDRUG(PSSIEN,""DOS1"",+Y,0)),""^"",2),1)=""."":""0"",1:"""")_$P($G(^PSDRUG(PSSIEN,""DOS1"",+Y,0)),""^"",2)_""    ""_$P($G(^PSDRUG(PSSIEN,""DOS1"",+Y,0)),""^"",3)"
 S PSSDOSA=+Y
 W ! K DIE S DA(1)=PSSIEN,DA=PSSDOSA,DR=".01;2",DIE="^PSDRUG("_PSSIEN_",""DOS1""," D ^DIE K DIE D:'$D(Y)&('$D(DTOUT)) BCMA^PSSDOSER G:$D(Y)!($D(DTOUT)) DOSLOC
 W ! G DOSA1
DOSLOC ;
 S (PSSPCI,PSSPCO)=0
 F PSSPCZ=0:0 S PSSPCZ=$O(^PSDRUG(PSSIEN,"DOS1",PSSPCZ)) Q:'PSSPCZ  D
 .I $P($G(^PSDRUG(PSSIEN,"DOS1",PSSPCZ,0)),"^",2)'="" S:$P($G(^(0)),"^",3)["I" PSSPCI=1 S:$P($G(^(0)),"^",3)["O" PSSPCO=1
 I PSSPCI,PSSPCO W !! K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Enter/Edit Local Possible Dosages" D  D ^DIR K DIR I Y'=1 K PSSPCI,PSSPCO,PSSPCZ W ! D END Q
 .S DIR("?")=" ",DIR("?",1)="Possible Dosages exist for both Outpatient Pharmacy and Inpatient Medications.",DIR("?",2)="Local Possible Dosages can be added, but will not be displayed for selection"
 .S DIR("?",3)="as long as there are Possible Dosages.",DIR("?",4)=" ",DIR("?",5)="Enter 'Y' to Enter/Edit Local Possible Dosages."
 K PSSPCI,PSSPCO,PSSPCZ
 ;
LOCX ;
 I $G(PSSSKIPP) G LOC
 I $G(PSSIZZ),$G(PSSOZZ) G LOC
 K PSSONLYO,PSSONLYI
 I $G(PSSIZZ),'$G(PSSOZZ) S PSSONLYO=1
 I $G(PSSOZZ),'$G(PSSIZZ) S PSSONLYI=1
 S PSSTALK=1,PSSDIEN=PSSIEN D LOC^PSSUTIL K PSSONLYI,PSSONLYO,PSSTALK,PSSDIEN
LOC ; Edit local dose
 D STUN,NATND,PR
 W ! K DIC S DA(1)=PSSIEN,DIC="^PSDRUG("_PSSIEN_",""DOS2"",",DIC(0)="QEAMLZ" D  D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) D END Q
 .S DIC("W")="W ""  ""_$P($G(^PSDRUG(PSSIEN,""DOS2"",+Y,0)),""^"",2)"
 S PSSDOSA=+Y,PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 W ! K DIE S DA(1)=PSSIEN,DA=PSSDOSA,DR=".01;S:'$G(PSSOTH) Y=""@1"";3;@1;1",DIE="^PSDRUG("_PSSIEN_",""DOS2"","
 D ^DIE K DIE,PSSOTH G:$P($G(^PSDRUG(PSSIEN,"DOS2",PSSDOSA,0)),"^")="" LOC D:'$D(Y)&('$D(DTOUT)) BCMA1^PSSDOSER I $D(Y)!($D(DTOUT)) D END Q
 I $$TEST^PSSDSPOP(PSSIEN) K DA,DIE,DR,DIDEL S DA(1)=PSSIEN,DA=PSSDOSA,DR="4;5",DIE="^PSDRUG("_PSSIEN_",""DOS2""," D ^DIE K DIE,DA,DR,DIDEL I $D(Y)!($D(DTOUT)) D END Q
 G LOC
LPD ; Display local dose before edit
 S PSSWDXF=0 D:($Y+5)>IOSL QASK Q:PSSWDXF  W !!,"LOCAL POSSIBLE DOSAGES:" D
 .F PDS=0:0 S PDS=$O(^PSDRUG(PSSIEN,"DOS2",PDS)) Q:'PDS!(PSSWDXF)  D
 ..D:($Y+5)>IOSL QASK Q:PSSWDXF  S LPDOS=$G(^PSDRUG(PSSIEN,"DOS2",PDS,0)) W !,"  " D
 ...I $L($P(LPDOS,U))'>27 W $P(LPDOS,U),?55,"PACKAGE: ",$P(LPDOS,U,2) D WXFPT(LPDOS) Q
 ...W !,?10,$P(LPDOS,U),!,?55,"PACKAGE: ",$P(LPDOS,U,2) D WXFPT(LPDOS)
 Q
CHECK ;
 K PSSUPRA,PSSNAT,PSSNATND,PSSNATDF,PSSNATUN,PSSNATST,PSSIZZ,PSSOZZ
 D NATND
 ;I $G(PSSST) S PSSXYZ=1 Q
 Q:'PSSNATDF!('PSSNATUN)!($G(PSSNATST)="")
 Q:'$D(^PS(50.606,PSSNATDF,0))!('$D(^PS(50.607,PSSNATUN,0)))
 I PSSNATST'?.N&(PSSNATST'?.N1".".N) Q
 I $D(^PS(50.606,"ACONI",PSSNATDF,PSSNATUN)),$O(^PS(50.606,"ADUPI",PSSNATDF,0)) S (PSSXYZ,PSSIZZ)=1
 I $D(^PS(50.606,"ACONO",PSSNATDF,PSSNATUN)),$O(^PS(50.606,"ADUPO",PSSNATDF,0)) S (PSSXYZ,PSSOZZ)=1
 Q
END K PSSNFID,PSSNAT,PSSNAT1,PSSNATND,PSSNATDF,PSSNATUN,PSSNOCON,PSSST,PSSUN,PSSIEN,PSSNAME,PSSIND,PSSDOSA,PSSXYZ,PSSNATST
 Q
ULK ;No need to unlock, called from Drug enter/edit
 Q:'$G(PSSIEN)
 L -^PSDRUG(PSSIEN)
 Q
QUES ;
 W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to edit Local Possible Dosages",DIR("B")="N" D ^DIR K DIR Q
 Q
STUN S PSSST=$P($G(^PSDRUG(PSSIEN,"DOS")),"^"),PSSUN=$P($G(^("DOS")),"^",2)
 Q
NATND S PSSNAT=+$P($G(^PSDRUG(PSSIEN,"ND")),"^",3),PSSNAT1=$P($G(^("ND")),"^")
 S PSSNATND=$$DFSU^PSNAPIS(PSSNAT1,PSSNAT) S PSSNATDF=$P(PSSNATND,"^"),PSSNATST=$P(PSSNATND,"^",4),PSSNATUN=$P(PSSNATND,"^",5)
 S PSSUPRA=$$SUPRA^PSSUTIL3(PSSNAT)
 Q
PR I PSSST'=""!(PSSNATST'=""),(PSSUN!(PSSNATUN)) D
 .W !!,"Strength: "_$S($E($S(PSSST'="":PSSST,1:PSSNATST),1)=".":"0",1:"")_$S(PSSST'="":PSSST,1:PSSNATST)
 .W ?30,"Unit: "_$P($G(^PS(50.607,+$S(PSSUN:PSSUN,1:PSSNATUN),0)),"^")
 E  W !!,"Strength: ",?30,"Unit: "
 Q
XNW ;
 I $P(^PSDRUG(PSSIEN,"ND"),"^",2)]"",('$D(^PSDRUG(PSSIEN,"DOS"))) S ^PSDRUG(PSSIEN,"DOS")=PSSNATST_"^"_PSSNATUN
XNWS ;
 N PSSDESTP W !!,"Strength from National Drug File match => "_$S($E($G(PSSNATST),1)=".":"0",1:"")_$G(PSSNATST)_"    "_$P($G(^PS(50.607,+$G(PSSUN),0)),"^")
 W !,"Strength currently in the Drug File    => "_$S($E($P($G(^PSDRUG(PSSIEN,"DOS")),"^"),1)=".":"0",1:"")_$P($G(^PSDRUG(PSSIEN,"DOS")),"^")_"    "_$S($P($G(^PS(50.607,+$G(PSSUN),0)),"^")'["/":$P($G(^(0)),"^"),1:"") S PSSDESTP=1 D MS^PSSDSPOP
 K PSSDESTP
 Q
 ;
 ;
QASK ;Ask to continue
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit"  D ^DIR K DIR I 'Y S PSSWDXF=1
 W @IOF
 Q
 ;
 ;
WXFPT(PSSWDXVL) ;Add print fields with PSS*1*147
 N PSSWDX1,PSSWDX2,PSSWDX3,PSSWDX4,PSSWDX5,PSSWDX6
 S PSSWDX4=""
 S PSSWDX1=$P(PSSWDXVL,"^",3),PSSWDX2=$P(PSSWDXVL,"^",5),PSSWDX3=$P(PSSWDXVL,"^",6)
 I PSSWDX2 S PSSWDX4=$P($G(^PS(51.24,+PSSWDX2,0)),"^")
 S PSSWDX5=$S($E(PSSWDX3)=".":"0",1:"")_PSSWDX3
 S PSSWDX6=$L(PSSWDX5)
 D:($Y+5)>IOSL QASK Q:PSSWDXF  W !?4,"BCMA UNITS PER DOSE: "_PSSWDX1
 I PSSWDX6<12 D:($Y+5)>IOSL QASK Q:PSSWDXF  W !?4,"       NUMERIC DOSE: "_PSSWDX5,?38,"DOSE UNIT: "_PSSWDX4 Q
 D:($Y+5)>IOSL QASK Q:PSSWDXF  W !,?4,"       NUMERIC DOSE: "_PSSWDX5
 D:($Y+5)>IOSL QASK Q:PSSWDXF  W !,?38,"DOSE UNIT: "_PSSWDX4
 Q
