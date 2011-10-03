PSDRFU ;BIR/JPW,LTL-Nurse RF Delayed Dispensing Liquid ;8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**50**;13 Feb 97
QTY S DIR(0)="NA^.01:"_OQTY_":2",DIR("A")="Amount given: "
 W ! D ^DIR K DIR G:Y'>0 END S (PSDQ,OQTY)=Y
WASTE I PSDQ#1 D  G:$G(PSDOUT) END
 .S DIR(0)="Y",DIR("A")="Will you be wasting any of this dose"
 .W ! D ^DIR K DIR S:$D(DIRUT) PSDOUT=1 Q:Y'=1
 .W ?44,"Amount to be wasted: ",1-PSDQ#1,! S WQTY=1-PSDQ#1
WIT .S NUR2=$$WITNESS^XUVERIFY("WITNESS")
 .I NUR2=DUZ W !!,"Wait a minute, you can't witness yourself!",$C(7) G WIT
 .I NUR2'>0 S PSDOUT=1 Q
 .W !!,"Thank you, ",$S($P($G(^VA(200,NUR2,.1)),U,4)]"":$P($G(^(.1)),U,4),1:$P($G(^VA(200,NUR2,0)),U))
 .S PSDQ=PSDQ+WQTY ;S DUZ=PSDUZ
 S %DT="AEPRX",%DT(0)="-NOW",%DT("A")="Date/time given: "
 W ! D ^%DT K %DT G:Y<1 END S PSDT=Y
 S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Nurse that signed out dose: "
 ; PSD*3*50 RJS - MODIFY TO CHECK SIGN OUT NURSE AGAINST WITNESS
ADMN W ! D ^DIC K DIC G:Y<1 END S NUR1=+Y,NUR1(1)=DUZ
 I $D(NUR2),NUR1=NUR2 W !,"Witness and Sign Out Nurse can not be the same person" G:NUR1=NUR2 ADMN
 W !!,"Remaining Balance: ",$P(PSDR(1),U,4)-PSDQ," ",$P(PSDR(1),U,8)
 D UPDAT^PSDRFT G DRUG^PSDRFS
END W:$G(PSDOUT) !!,"No dose signed out.",$C(7),!! K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
