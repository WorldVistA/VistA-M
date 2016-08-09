PSSDOSER ;BIR/RTR-Dose edit option ; 21 Sep 2015  8:37 PM
 ;;1.0;PHARMACY DATA MANAGEMENT;**34,38,50,57,47,68,82,125,129,144,155,194**;9/30/97;Build 9
 ;Reference to ^PS(50.607 supported by DBIA #2221
 ;Reference to ^PS(59 supported by DBIA #1976
 ;
 ;have an entry point for NDF to call when rematching
DOS ;Edit dosages
 D CHECK^PSSUTLPR I $G(PSSNOCON) K PSSNOCON D END Q
 D END
 W !! S DIC(0)="QEAMZ",DIC("A")="Select Drug: ",DIC="^PSDRUG(" D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) D END W ! Q
 S PSSIEN=+Y,PSSNAME=$P($G(^PSDRUG(PSSIEN,0)),"^"),PSSIND=$P($G(^("I")),"^"),PSSNFID=$P($G(^(0)),"^",9)
 S PSSPKG=$P($G(^PSDRUG(PSSIEN,2)),"^",3)
 W !!,"This entry is marked for the following PHARMACY packages:"
 W:PSSPKG["O" !,"Outpatient" W:PSSPKG["U" !,"Unit Dose"
 W:PSSPKG["I" !,"IV" W:PSSPKG["W" !,"Ward Stock"
 W:PSSPKG["N" !,"Controlled Substances" W:PSSPKG["X" !,"Non-VA Med"
 I PSSPKG'["O",PSSPKG'["U",PSSPKG'["I",PSSPKG'["W",PSSPKG'["N",PSSPKG'["X" W !," (none)"
 K PSSPKG L +^PSDRUG(PSSIEN):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T W !!,$C(7),"Another person is editing this drug.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR G DOS
 W !!,PSSNAME_$S($G(PSSNFID):"    *N/F*",1:"") W ?52,"Inactive Date: "_$S($G(PSSIND):$E(PSSIND,4,5)_"/"_$E(PSSIND,6,7)_"/"_$E(PSSIND,2,3),1:"")
 S (PSSIZZ,PSSOZZ,PSSSKIPP)=0
RES ;
 D STUN
 I PSSST="",$O(^PSDRUG(PSSIEN,"DOS1",0)) K ^PSDRUG(PSSIEN,"DOS") K ^PSDRUG(PSSIEN,"DOS1")
 S PSSXYZ=0 D CHECK
 I PSSXYZ,PSSUPRA="NN" D MPD K:$D(PSSZ) PSSZ Q
 D:$G(PSSST) XNWS I $G(PSSST),$O(^PSDRUG(PSSIEN,"DOS1",0)) D STR G SKIP
 I PSSXYZ,'$O(^PSDRUG(PSSIEN,"DOS1",0)) D  D ^DIR K DIR I Y=1 S PSSSKIPP=1 D EN2^PSSUTIL(PSSIEN,1) G RES
 .K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Create Possible Dosages for this drug",DIR("?")=" "
 .S DIR("?",1)="This drug meets the criteria to have Possible Dosages, but it currently does",DIR("?",2)="not have any. If you answer 'YES', Possible Dosages will be created for this"
 .S DIR("?",3)="drug, based on the match to the National Drug File."
 .W !!!,"This drug can have Possible Dosages, but currently does not have any.",!
 .I PSSUPRA["N" W !,"This drug has been set within the National Drug File to "_$S(PSSUPRA="NN":"not ",1:"")_"auto create "_$S(PSSUPRA="NO":"only one ",PSSUPRA="NB":"two ",1:""),!,"possible dosage"_$S(PSSUPRA="NO":".",1:"s."),!
 .W !
SKIP ;
 K PSSXYZ,PSSZ
 I '$O(^PSDRUG(PSSIEN,"DOS1",0)) G LOCX
DOSA S PSSST=$P($G(^PSDRUG(PSSIEN,"DOS")),"^")
 W !!,"Strength => "_$S($E($G(PSSST),1)=".":"0",1:"")_$G(PSSST)_"   Unit => "_$S($P($G(^PS(50.607,+$G(PSSUN),0)),"^")'["/":$P($G(^(0)),"^"),1:"") W !
 I PSSUPRA["N",'PSSSKIPP,'$G(PSSZ) S PSSZ=1 D
 .W !,"This drug has been set within the National Drug File to "_$S(PSSUPRA="NN":"not ",1:"")_"auto create "_$S(PSSUPRA="NO":"only one ",PSSUPRA="NB":"two ",1:""),!,"possible dosage"_$S(PSSUPRA="NO":".",1:"s."),!
 K DIC S DA(1)=PSSIEN,DIC="^PSDRUG("_PSSIEN_",""DOS1"",",DIC(0)="QEAMLZ",DLAYGO=50,DIC("A")="Select DISPENSE UNITS PER DOSE: " D  D ^DIC K DIC,DLAYGO I Y<1!($D(DTOUT))!($D(DUOUT)) G DOSLOC
 .S DIC("W")="W ""  ""_$S($E($P($G(^PSDRUG(PSSIEN,""DOS1"",+Y,0)),""^"",2),1)=""."":""0"",1:"""")_$P($G(^PSDRUG(PSSIEN,""DOS1"",+Y,0)),""^"",2)_""    ""_$P($G(^PSDRUG(PSSIEN,""DOS1"",+Y,0)),""^"",3)"
 S PSSDOSA=+Y,PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 W ! K DIE S DA(1)=PSSIEN,DA=PSSDOSA,DR=".01;S:'$G(PSSOTH) Y=""@1"";@1;2",DIE="^PSDRUG("_PSSIEN_",""DOS1""," D ^DIE K DIE D:'$D(Y)&('$D(DTOUT)) BCMA G:$D(Y)!($D(DTOUT)) DOSLOC  ;;<*144 - RJS
 G DOSA
DOSLOC ;
 S (PSSPCI,PSSPCO)=0 K:$D(PSSZ) PSSZ
 F PSSPCZ=0:0 S PSSPCZ=$O(^PSDRUG(PSSIEN,"DOS1",PSSPCZ)) Q:'PSSPCZ  D
 .I $P($G(^PSDRUG(PSSIEN,"DOS1",PSSPCZ,0)),"^",2)'="" S:$P($G(^(0)),"^",3)["I" PSSPCI=1 S:$P($G(^(0)),"^",3)["O" PSSPCO=1
 I PSSPCI,PSSPCO W !! K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Enter/Edit Local Possible Dosages" D  D ^DIR K DIR I Y'=1 K PSSPCI,PSSPCO,PSSPCZ W ! D ULK G DOS
 .S DIR("?")=" ",DIR("?",1)="Possible Dosages exist for both Outpatient Pharmacy and Inpatient Medications.",DIR("?",2)="Local Possible Dosages can be added, but will not be displayed for selection"
 .S DIR("?",3)="as long as there are Possible Dosages.",DIR("?",4)=" ",DIR("?",5)="Enter 'Y' to Enter/Edit Local Possible Dosages."
 K PSSPCI,PSSPCO,PSSPCZ
LOCX ;
 I $G(PSSSKIPP) G LOC
 I $G(PSSIZZ),$G(PSSOZZ) G LOC
 K PSSONLYI,PSSONLYO
 I $G(PSSIZZ),'$G(PSSOZZ) S PSSONLYO=1
 I $G(PSSOZZ),'$G(PSSIZZ) S PSSONLYI=1
 S PSSTALK=1,PSSDIEN=PSSIEN D LOC^PSSUTIL K PSSONLYO,PSSONLYI,PSSTALK,PSSDIEN
 ;MAKE SURE THOSE ARE THE VARIABLES YOU NEED TO SET
LOC ; Edit local dose
 D STUN,NATND,PR
 W ! K DIC S DA(1)=PSSIEN,DIC="^PSDRUG("_PSSIEN_",""DOS2"",",DLAYGO=50,DIC(0)="QEAMLZ" D  D ^DIC K DIC,DLAYGO I Y<1!($D(DTOUT))!($D(DUOUT)) D ULK G DOS
 .S DIC("W")="W ""  ""_$P($G(^PSDRUG(PSSIEN,""DOS2"",+Y,0)),""^"",2)"
 S PSSDOSA=+Y,PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 W ! K DIE S DA(1)=PSSIEN,DA=PSSDOSA,DR=".01;S:'$G(PSSOTH) Y=""@1"";3;@1;1",DIE="^PSDRUG("_PSSIEN_",""DOS2""," D ^DIE K DIE,PSSOTH
 I $P($G(^PSDRUG(PSSIEN,"DOS2",PSSDOSA,0)),"^")="" G LOC
 D:'$D(Y)&('$D(DTOUT)) BCMA1 I $D(Y)!($D(DTOUT)) D ULK G DOS
 I '$D(Y)&('$D(DTOUT)),$$TEST^PSSDSPOP(PSSIEN) K DA,DIE,DR,DIDEL S DA(1)=PSSIEN,DA=PSSDOSA,DR="4;5",DIE="^PSDRUG("_PSSIEN_",""DOS2""," D ^DIE K DIE,DA,DR,DIDEL I $D(Y)!($D(DTOUT)) D ULK G DOS
 G LOC
 Q
STR ;Edit strength
 N PSSIENS,PSS11
 ;W !!,"Strength from National Drug File match => "_$S($E($G(PSSNATST),1)=".":"0",1:"")_$G(PSSNATST)_"    "_$P($G(^PS(50.607,+$G(PSSUN),0)),"^")
 ;W !,"Strength currently in the Drug File    => "_$S($E($P($G(^PSDRUG(PSSIEN,"DOS")),"^"),1)=".":"0",1:"")_$P($G(^PSDRUG(PSSIEN,"DOS")),"^")_"    "_$S($P($G(^PS(50.607,+$G(PSSUN),0)),"^")'["/":$P($G(^(0)),"^"),1:"") D MS^PSSDSPOP
 W ! K DIR S DIR(0)="Y",DIR("?")="Changing the strength will update all possible dosages for this Drug",DIR("B")="NO",DIR("A")="Edit Strength" D ^DIR K DIR I 'Y W ! Q
 W !!,"Changing the strength will not change the concentration."
 W ! K DIR S DIR(0)="Y"
 S DIR("?")="Changes in strength do not cause changes in concentration."
 S DIR("B")="NO",DIR("A")="Are you sure you need to change the strength" D ^DIR K DIR I 'Y W ! Q
 W ! K DIE S DIE="^PSDRUG(",DA=PSSIEN,DR=901 D ^DIE K DIE W !
 I $P($G(^PSDRUG(PSSIEN,"DOS")),"^")="" K ^PSDRUG(PSSIEN,"DOS") K ^PSDRUG(PSSIEN,"DOS1") W !!,"Deleting Strength has deleted all Possible Dosages!",!
 Q
CHECK ;
 K PSSNAT,PSSNATND,PSSNATDF,PSSNATUN,PSSNATST,PSSIZZ,PSSOZZ
 S PSSNAT=+$P($G(^PSDRUG(PSSIEN,"ND")),"^",3),PSSNAT1=$P($G(^("ND")),"^") I 'PSSNAT!('PSSNAT1) Q
 S PSSNATND=$$DFSU^PSNAPIS(PSSNAT1,PSSNAT) S PSSNATDF=$P(PSSNATND,"^"),PSSNATST=$P(PSSNATND,"^",4),PSSNATUN=$P(PSSNATND,"^",5)
 S PSSUPRA=$$SUPRA^PSSUTIL3(PSSNAT)
 ;I $G(PSSST) S PSSXYZ=1 Q
 Q:'PSSNATDF!('PSSNATUN)!($G(PSSNATST)="")
 Q:'$D(^PS(50.606,PSSNATDF,0))!('$D(^PS(50.607,PSSNATUN,0)))
 I PSSNATST'?.N&(PSSNATST'?.N1".".N) Q
 I $D(^PS(50.606,"ACONI",PSSNATDF,PSSNATUN)),$O(^PS(50.606,"ADUPI",PSSNATDF,0)) S (PSSXYZ,PSSIZZ)=1
 I $D(^PS(50.606,"ACONO",PSSNATDF,PSSNATUN)),$O(^PS(50.606,"ADUPO",PSSNATDF,0)) S (PSSXYZ,PSSOZZ)=1
 Q
END K PSSIZZ,PSSOZZ,PSSSKIPP,PSSNFID,PSSNAT,PSSNAT1,PSSNATND,PSSNATDF,PSSNATUN,PSSNOCON,PSSST,PSSUN,PSSIEN,PSSNAME,PSSIND,PSSDOSA,PSSXYZ,PSSNATST
 Q
ULK ;
 Q:'$G(PSSIEN)
 N XX,DNSNAM,DNSPORT,DVER,DMFU S XX=""
 I '$G(PSSHUIDG) D DRG^PSSHUIDG(PSSIEN) D
 .F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D
 ..S DVER=$$GET1^DIQ(59,XX_",",105,"I"),DMFU=$$GET1^DIQ(59,XX_",",105.2)
 ..I DVER="2.4" S DNSNAM=$$GET1^DIQ(59,XX_",",2006),DNSPORT=$$GET1^DIQ(59,XX_",",2007) I DNSNAM'=""&(DMFU="YES") D DRG^PSSDGUPD(PSSIEN,"",DNSNAM,DNSPORT)
 L -^PSDRUG(PSSIEN)
 Q
BCMA ;
 I $P($G(^PSDRUG(PSSIEN,2)),"^",3)'["I",$P($G(^(2)),"^",3)'["U" Q
 I $P($G(^PSDRUG(PSSIEN,"DOS1",PSSDOSA,0)),"^",3)'["I" Q
 K DIE S DA(1)=PSSIEN,DA=PSSDOSA,DR=3,DIE="^PSDRUG("_PSSIEN_",""DOS1""," D ^DIE K DIE
 Q
BCMA1 ;
 I $P($G(^PSDRUG(PSSIEN,2)),"^",3)'["I",$P($G(^(2)),"^",3)'["U" Q
 I $P($G(^PSDRUG(PSSIEN,"DOS2",PSSDOSA,0)),"^",2)'["I" Q
 K DIE S DA(1)=PSSIEN,DA=PSSDOSA,DR=2,DIE="^PSDRUG("_PSSIEN_",""DOS2""," D ^DIE K DIE
 Q
STUN S PSSST=$P($G(^PSDRUG(PSSIEN,"DOS")),"^"),PSSUN=$P($G(^("DOS")),"^",2)
 Q
NATND S PSSNAT=+$P($G(^PSDRUG(PSSIEN,"ND")),"^",3),PSSNAT1=$P($G(^("ND")),"^")
 S PSSNATND=$$DFSU^PSNAPIS(PSSNAT1,PSSNAT) S PSSNATDF=$P(PSSNATND,"^"),PSSNATST=$P(PSSNATND,"^",4),PSSNATUN=$P(PSSNATND,"^",5)
 Q
PR I PSSST'=""!(PSSNATST'=""),(PSSUN!(PSSNATUN)) D
 .W !!,"Strength: "_$S($E($S(PSSST'="":PSSST,1:PSSNATST),1)=".":"0",1:"")_$S(PSSST'="":PSSST,1:PSSNATST)
 .W ?30,"Unit: "_$P($G(^PS(50.607,+$S(PSSUN:PSSUN,1:PSSNATUN),0)),"^")
 E  W !!,"Strength: ",?30,"Unit: "
 Q
 ;
 ;
XNWS ;
 N PSSDESTP S PSSDESTP=1
 W !!,"Strength from National Drug File match => "_$S($E($G(PSSNATST),1)=".":"0",1:"")_$G(PSSNATST)_"    "_$P($G(^PS(50.607,+$G(PSSUN),0)),"^")
 W !,"Strength currently in the Drug File    => "_$S($E($P($G(^PSDRUG(PSSIEN,"DOS")),"^"),1)=".":"0",1:"")_$P($G(^PSDRUG(PSSIEN,"DOS")),"^")_"    "_$S($P($G(^PS(50.607,+$G(PSSUN),0)),"^")'["/":$P($G(^(0)),"^"),1:"") D MS^PSSDSPOP
 K PSSDESTP
 Q
MPD ; manually enter poosible dosage
 I $P($G(^PSDRUG(PSSIEN,"DOS")),"^")="" S:$P(^PSDRUG(PSSIEN,"ND"),"^",2)]"" ^PSDRUG(PSSIEN,"DOS")=PSSNATST_"^"_PSSNATUN
 I PSSXYZ,'$O(^PSDRUG(PSSIEN,"DOS1",0)) D  D ^DIR K DIR I 'Y W ! K PSSXYZ K:$D(PSSZ) PSSZ I '$O(^PSDRUG(PSSIEN,"DOS1",0)) G LOCX Q
 .K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to manually enter possible dosages",DIR("?")=" "
 .S DIR("?",1)="This drug meets the criteria to have Possible Dosages, but it currently does",DIR("?",2)="not have any. If you answer 'YES', Possible Dosages can be manually entered for this drug."
 .W !!!,"This drug can have Possible Dosages, but currently does not have any.",!
 .S PSSZ=1 W !,"This drug has been set within the National Drug File to "_$S(PSSUPRA="NN":"not ",1:"")_"auto create "_$S(PSSUPRA="NO":"only one ",PSSUPRA="NB":"two ",1:""),!,"possible dosage"_$S(PSSUPRA="NO":".",1:"s."),!
 D XNWS,STR,DOSA
 Q
