PSDNTF ;BIR/JPW-Transfer Green Sheet - From this NAOU ; 8/29/07 1:25pm
 ;;3.0; CONTROLLED SUBSTANCES ;**8,56,63,66,64**;13 Feb 97;Build 33
 ;**Y2K compliance**;display 4 digit year on va forms
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,$D(^XUSEC("PSJ RPHARM",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Coordinator for access to",!,?12,"transfer narcotic orders.",!!,"PSJ RNURSE, PSD NURSE, or PSJ RPHARM security key required.",! K OK Q
 W !!,"Transfer a Green Sheet from this NAOU" S PSDUZ=DUZ,PSDUZN=$P($G(^VA(200,PSDUZ,0)),"^")
ASKN ;ask transfer from naou
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEAZ",DIC("A")="Select Transfer from NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S AOU=+Y,AOUN=$P(Y,"^",2)
GS ;select green sheet #
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S DIC("S")="I $P(^(0),""^"",11)=4!($P(^(0),U,11)=13),$P(^(0),""^"",18)=AOU",DIC("W")="W "" "",$P($G(^PSDRUG($P(^(0),U,5),0)),U),"" => "",$P($G(^DPT(+$P($G(^PSD(58.81,Y,9)),U),0)),U)"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S ORD=+$P(Y(0),"^",20),NAOU=+$P(Y(0),"^",18),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^"),PSDR=+$P(Y(0),"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^")
 S MFG=$P(Y(0),"^",13),LOT=$P(Y(0),"^",14),EXP=$P(Y(0),"^",15),QTY=+$P(Y(0),"^",6),PSDS=+$P(Y(0),"^",3)
 S NBKU=$P($G(^PSD(58.8,+PSDS,1,+PSDR,0)),"^",8)
 I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S QTY=+$P(^(4),"^",3)
 I AOU'=NAOU W !!,"The Green Sheet # ",PSDPN," does not reside on ",AOUN,".",!,"Please select another Green Sheet.",! G ASKN
 I '$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)) W $C(7),!!,"There's no data on ",NAOUN," for Green Sheet # ",PSDPN,".",!,"Contact your Pharmacy Coordinator for assistance.",! G END
 I STAT'=4,STAT'=13 W !!,"This Green Sheet has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please contact your Pharmacy Coordinator for assistance.",! G END
 I 'QTY W !!,"Previous transfer quantity was 0.",!,"Use option 'Transfer GS for PCA/Infusion Signed Out to Patient'",! G END
ASKT ;ask transfer to naou
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEAZ",DIC("A")="Select Transfer To NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S NAOUT=+Y,NAOUTN=$P(Y,"^",2)
 I NAOUT=AOU W !!,"You may not transfer a Green Sheet to your NAOU!",!,"Please select another NAOU.",!! G ASKT
 ;*64
 N PSDGS,PSDGSPTQ,PSDGSP0,PSDGSP9
 S PSDGS=0 F  S PSDGS=$O(^PSD(58.81,"D",PSDPN,PSDGS)) Q:'PSDGS  D
 .S PSDGSP0=$G(^PSD(58.81,PSDGS,0)),PSDGSP9=$G(^PSD(58.81,PSDGS,9))
 .I $P(PSDGSP0,"^",2)=17,$P(PSDGSP9,"^",1)]"" S PSDGSPTQ=$G(PSDGSPTQ)+$P(PSDGSP9,"^",3)
 I $G(PSDGSPTQ) W !!,"Green Sheet "_PSDPN_" has dose(s) signed out to patient.",!
 I QTY=1 S RQTY=1 W !,"Quantity to Transfer (",NBKU,"/1)",! G OK
QTY ;
 W !,"Quantity to Transfer ("_NBKU_"/"_QTY_"): " R X:DTIME I '$T!(X="^")!(X="") S PSDOUT=1 W !!,"**** No action taken. ****",!! G END
 ;I X'?1.6N!(X=0) W !!,"Enter a whole number between 1 and ",QTY,! G QTY
 I +X'=X!(X>999999)!(X'>0)!(X?.E1"."4N.N) D  G QTY
 . W !!,"Enter a number between .01 and ",QTY,!
 I X>QTY W $C(7),!!,"The quantity returned must not exceed "_QTY_"!",! G QTY
 S RQTY=X
OK ;if perpetual NAOU and not ordered for patient
 D:QTY=1&('$P($G(^PSD(58.81,PSDA,9)),U))  G:$G(PSDOUT) END
 .W !,PSDRN," Current Balance:  ",$P($G(^PSD(58.8,NAOU,1,PSDR,0)),U,4)," ",NBKU,!
 .S DIR(0)="Y",DIR("A")="Is this a PCA syringe that has already been signed out for a patient",DIR("B")="Y",DIR("?")="If you answer no, your balance will be subtracted by one" D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 Q
 .Q:Y'=1
 .S RQTY(1)=1
 .S DIC="^DPT(",DIC(0)="AEMQ",DIC("A")="Scan/Enter Patient: "
 .W ! D ^DIC K DIC I Y<1 S PSDOUT=1 W !!,"No action taken.",!! Q
 .S PAT=+Y
 ;ask ok to transfer
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to transfer this Green Sheet to another NAOU or",DIR("?")="answer 'NO' to leave the Green Sheet status active on your NAOU."
 D ^DIR K DIR G:$D(DIRUT) END G:'Y GS
 D NOW^%DTC S (RECD,Y)=+$E(%,1,12) X ^DD("DD") S RECDT=Y
COM ;complete at order level in 58.8
 W !!,"Accessing ",PSDRN," information...",!!
 S BQTY=$S($P($G(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)),"^",22):$P(^(0),"^",22)-RQTY,1:QTY-RQTY)
 W !!,"Updating your records now..."
 ;update transaction file (58.81)
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="64////"_RECD_";65////"_PSDUZ_";66////"_NAOUT_";70////"_RQTY_";10////10;73////"_$G(PAT) D ^DIE K DA,DIE,DR
 I $D(Y)!$D(DTOUT) W $C(7),!!,"** THIS GREEN SHEET HAS NOT BEEN TRANSFERRED **",!!,"The status remains "_STATN,! G END
 ;update order
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////10;22////"_BQTY D ^DIE K DA,DIE,DR
 ;update naou bal
 F  L +^PSD(58.8,NAOU,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ;PSD*3*56;REMOVED CHECK FOR PATIENT ID
 S:'$G(RQTY(1)) $P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)=$P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)-RQTY
 W:$P($G(^PSD(58.8,NAOU,2)),U,5) !,PSDRN," Remaining Balance:  ",$P($G(^PSD(58.8,NAOU,1,PSDR,0)),U,4)," ",NBKU,!
 L -^PSD(58.8,NAOU,1,PSDR,0)
 S STAT=$P($G(^PSD(58.81,PSDA,0)),"^",11)
 W ?2,!,"*** The status of your Green Sheet #"_PSDPN_" is now",!,$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" ***",!
PRINT ;print 2321
 W !!,"Number of copies of VA FORM 10-2321? " R NUM:DTIME I '$T!(NUM="^")!(NUM="") W !!,"No copies printed!!",!! Q
 I NUM'?1N!(NUM=0)  W !!,"Enter a whole number between 1 and 9",! G PRINT
 S Y=RECD X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4)
 S (PG,PSDOUT)=0,REAS="",COMP=999,RECDT=$E(RECD,4,5)_"/"_$E(RECD,6,7)_"/"_PSDYR
 I EXP S (EXP1,EXPD)=$$FMTE^XLFDT(EXP,"5D") S:'$P(EXP1,"/",2) EXPD=$P(EXP1,"/")_"/"_$P(EXP1,"/",3) S EXP=EXPD
 D ^PSDGSRV2
END K %,%DT,%H,%I,AOU,AOUN,BQTY,COMP,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,EXP1,EXPD,LOT,MFG
 K NAOU,NAOUN,NAOUT,NAOUTN,NBKU,NUM,OK,ORD,PG,PSDA,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDUZ,PSDUZN,PSDYR,QTY,REAS,RECD,RECDT,RQTY,STAT,STATN,X,Y
 Q
