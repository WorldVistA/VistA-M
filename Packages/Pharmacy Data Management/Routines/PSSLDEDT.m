PSSLDEDT ;BIR/RTR-Edit Local Possible Dosage Unit/Dosage ;06/23/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
 ;
 ;Reference to 50.607 supported by DBIA 2221
 ;
EDT ;Edit New Local Possible Dosages Fields Numeric Dose and Dose Unit
 N DIRUT,DIROUT,DIC,DTOUT,DUOUT,X,Y,DIE,DA,DR,PSSLVIEN,PSSLVOK,PSSLVTST,PSSLVZR,PSSLVND1,PSSLVND3,PSSLVDF,PSSLVSTN,PSSLVUNT,PSSLVNDF,PSSLVSXX,PSSLVSZZ,PSSLVUNX,PSSLVLP,PSSLVLPN,PSSLVOUT,PSSLVLOC,PSSLVLCX,PSSLVFLG,PSSLVCNT
 N PSSLVGG1,PSSLVGG2,PSSLVGG3,PSSLVGG4,PSSLVGG5,PSSLVGG6,PSSLVAF6,PSSLVBF6,DIR,DIDEL
EDTX ;
 K PSSLVIEN,PSSLVOK,PSSLVTST,PSSLVZR,PSSLVND1,PSSLVND3,PSSLVDF,PSSLVSTN,PSSLVUNT,PSSLVNDF,PSSLVSXX,PSSLVSZZ,PSSLVUNX,PSSLVLP,PSSLVLPN,PSSLVOUT,PSSLVLOC,PSSLVLCX,PSSLVFLG,PSSLVCNT
 K PSSLVGG1,PSSLVGG2,PSSLVGG3,PSSLVGG4,PSSLVGG5,PSSLVGG6,PSSLVAF6,PSSLVBF6
 S PSSLVOUT=0
 W ! K DIC,DTOUT,DUOUT S DIC=50,DIC(0)="QEAMZ",DIC("A")="Select Drug: " D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(+Y'>0) W ! Q
 S PSSLVIEN=+Y,PSSLVZR=$G(^PSDRUG(PSSLVIEN,0)),PSSLVND1=$P($G(^PSDRUG(PSSLVIEN,"ND")),"^"),PSSLVND3=$P($G(^PSDRUG(PSSLVIEN,"ND")),"^",3)
 S PSSLVSTN=$P($G(^PSDRUG(PSSLVIEN,"DOS")),"^"),PSSLVUNT=$P($G(^PSDRUG(PSSLVIEN,"DOS")),"^",2)
 S PSSLVOK=$$TEST(PSSLVIEN)
 I 'PSSLVOK G EDTX
 S PSSLVUNX=$S($G(PSSLVUNT):$P($G(^PS(50.607,+$G(PSSLVUNT),0)),"^"),$P($G(PSSLVNDF),"^",6)'="":$P($G(PSSLVNDF),"^",6),1:"")
 I 'PSSLVND3!('PSSLVND1) W !!,"This drug is not matched to NDF and therefore will be excluded from dosing",!,"checks."
 L +^PSDRUG(PSSLVIEN):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T W !!,"Another person is editing this drug.",! G EDTX
 I PSSLVND1,PSSLVND3 S PSSLVSXX=$P(PSSLVNDF,"^",4),PSSLVSZZ=$P(PSSLVNDF,"^",6)
 I PSSLVSTN'="",$E($G(PSSLVSTN),1)="." S PSSLVSTN="0"_PSSLVSTN
 I $G(PSSLVSXX)'="",$E($G(PSSLVSXX),1)="." S PSSLVSXX="0"_PSSLVSXX
 S PSSLVFLG=0
 I $G(PSSLVSXX)'="",($G(PSSLVSTN)'="") I $G(PSSLVSXX)'=$G(PSSLVSTN) D
 .S PSSLVFLG=1
 .S PSSLVGG1=$L($G(PSSLVSXX)),PSSLVGG2=$L($G(PSSLVUNX)),PSSLVGG3=$L($G(PSSLVSTN)),PSSLVGG4=$L($S($G(PSSLVUNX)'["/":$G(PSSLVUNX),1:""))
 .W !!,"Strength from National Drug File match => " D
 ..I PSSLVGG1+PSSLVGG2<34 W $G(PSSLVSXX)_"   "_$G(PSSLVUNX) Q
 ..W !?3,$G(PSSLVSXX) D
 ...I PSSLVGG1+PSSLVGG2<73 W "   "_$G(PSSLVUNX) Q
 ...W !?3,$G(PSSLVUNX)
 .W !,"Strength currently in the Drug File    => " D
 ..I PSSLVGG3+PSSLVGG4<34 W $G(PSSLVSTN)_"   "_$S($G(PSSLVUNX)'["/":$G(PSSLVUNX),1:"") Q
 ..W !?3,$G(PSSLVSTN) D
 ...I PSSLVGG3+PSSLVGG4<73 W "   "_$S($G(PSSLVUNX)'["/":$G(PSSLVUNX),1:"") Q
 ...W !?3,$S($G(PSSLVUNX)'["/":$G(PSSLVUNX),1:"")
 .W !!,"Please Note: Strength of drug does not match strength of VA Product it is",!,"matched to."
 S PSSLVCNT=0
 F PSSLVLP=0:0 S PSSLVLP=$O(^PSDRUG(PSSLVIEN,"DOS2",PSSLVLP)) Q:'PSSLVLP!(PSSLVOUT)  S PSSLVLOC=$G(^PSDRUG(PSSLVIEN,"DOS2",PSSLVLP,0)) D:$P(PSSLVLOC,"^")'=""
 .I 'PSSLVCNT,'PSSLVFLG I $G(PSSLVSXX)'=""!($G(PSSLVSTN)'="")!($G(PSSLVUNX)'="") D
 ..S PSSLVGG5=$L($S($G(PSSLVSTN)'="":$G(PSSLVSTN),$G(PSSLVSXX)'="":$G(PSSLVSXX),1:"")),PSSLVGG6=$L($G(PSSLVUNX))
 ..W !!,"Strength: "_$S($G(PSSLVSTN)'="":$G(PSSLVSTN),$G(PSSLVSXX)'="":$G(PSSLVSXX),1:"")
 ..I PSSLVGG5+PSSLVGG6<60 W "   Unit: "_$G(PSSLVUNX) Q
 ..W !,"Unit: "_$G(PSSLVUNX)
 .S PSSLVCNT=1
 .W !!!,$P(PSSLVLOC,"^") I $P(PSSLVLOC,"^",5)!($P(PSSLVLOC,"^",6)'="") D
 ..W !,"Numeric Dose: "_$S($E($P(PSSLVLOC,"^",6),1)=".":"0"_$P(PSSLVLOC,"^",6),1:$P(PSSLVLOC,"^",6))
 ..W ?37,"Dose Unit: "_$S('$P(PSSLVLOC,"^",5):"",1:$P($G(^PS(51.24,+$P(PSSLVLOC,"^",5),0)),"^"))
 .W ! K DIE,Y,DTOUT,DR,DA,DIDEL S DA(1)=PSSLVIEN,DIE="^PSDRUG("_PSSLVIEN_",""DOS2"",",DR="4;5",DA=PSSLVLP
 .D ^DIE K DIE,DR,DA I $D(DTOUT)!($D(Y)) D  Q:PSSLVOUT
 ..W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to exit this option",DIR("B")="Y",DIR("?")="Enter 'Y' to exit this option, enter 'N' to continue editing."
 ..D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($G(Y)) S PSSLVOUT=1
 .S PSSLVLCX=$G(^PSDRUG(PSSLVIEN,"DOS2",PSSLVLP,0))
 .S PSSLVBF6=$S($E($P(PSSLVLOC,"^",6),1)=".":"0"_$P(PSSLVLOC,"^",6),1:$P(PSSLVLOC,"^",6)) S PSSLVAF6=$S($E($P(PSSLVLCX,"^",6),1)=".":"0"_$P(PSSLVLCX,"^",6),1:$P(PSSLVLCX,"^",6))
 .I $P(PSSLVLCX,"^",5)'=$P(PSSLVLOC,"^",5)!(PSSLVBF6'=PSSLVAF6) D
 ..W !!,$P(PSSLVLCX,"^")
 ..W !,"Numeric Dose: "_$S($E($P(PSSLVLCX,"^",6),1)=".":"0"_$P(PSSLVLCX,"^",6),1:$P(PSSLVLCX,"^",6))
 ..W ?40,"Dose Unit: "_$S('$P(PSSLVLCX,"^",5):"",1:$P($G(^PS(51.24,+$P(PSSLVLCX,"^",5),0)),"^"))
 D UL
 I 'PSSLVOUT G EDTX
 Q
 ;
UL ;unlock drug
 L -^PSDRUG(PSSLVIEN)
 Q
 ;
TEST(PSSLVTST) ;See if drug need Dose Unit and Numeric Dose defined
 N PSSLVDOV
 S PSSLVDOV=""
 I PSSLVND1,PSSLVND3,$T(OVRIDE^PSNAPIS)]"" S PSSLVDOV=$$OVRIDE^PSNAPIS(PSSLVND1,PSSLVND3)
 I '$O(^PSDRUG(PSSLVTST,"DOS2",0)) W !!,"No local possible dosages exist for this drug." Q 0
 I $P(PSSLVZR,"^",3)["S"!($E($P(PSSLVZR,"^",2),1,2)="XA") D  Q 0
 .W !!,"This drug is marked as a supply and therefore excluded from dosing checks."
 .W !,"Population of the numeric dose and dose unit for this drug's local possible"
 .W !,"dosages is not required."
 I PSSLVND1,PSSLVND3 S PSSLVNDF=$$DFSU^PSNAPIS(PSSLVND1,PSSLVND3) S PSSLVDF=$P(PSSLVNDF,"^")
 I $G(PSSLVDF)'>0,$P($G(^PSDRUG(PSSLVTST,2)),"^") S PSSLVDF=$P($G(^PS(50.7,+$P($G(^PSDRUG(PSSLVTST,2)),"^"),0)),"^",2)
 I PSSLVDOV=""!('$G(PSSLVDF))!($P($G(^PS(50.606,+$G(PSSLVDF),1)),"^")="") Q 1
 I $P($G(^PS(50.606,+$G(PSSLVDF),1)),"^"),'PSSLVDOV D  Q 0
 .W !!,"The dosage form '"_$P($G(^PS(50.606,+PSSLVDF,0)),"^")_"' associated with the drug has"
 .W !,"been excluded from dosage checks. Population of the numeric dose and dose"
 .W !,"unit for this drug's local possible dosages is not required."
 I '$P($G(^PS(50.606,+$G(PSSLVDF),1)),"^"),PSSLVDOV D  Q 0
 .W !!,"The VA product that this drug is matched to has been excluded from dosage"
 .W !,"checks. Population of the numeric dose and dose unit for this drug's local"
 .W !,"possible dosages is not required."
 Q 1
