PSDRF5 ;BIR/JPW,LTL-Nurse RF defective liquid Dispensing ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 S DIR(0)="NA^.01:"_OQTY_":2",DIR("A")="Amount defective: "
 W ! D ^DIR K DIR S:$D(DIRUT) PSDOUT=1 Q:Y'>0  S (WQTY,PSDQ)=Y
WIT S NUR2=$$WITNESS^XUVERIFY("WITNESS")
 I NUR2=DUZ W !!,"Wait a minute, you can't witness yourself!",$C(7) G WIT
 I NUR2'>0 S PSDOUT=1 Q
 W !!,"Thank you, ",$S($P($G(^VA(200,NUR2,.1)),U,4)]"":$P($G(^(.1)),U,4),1:$P($G(^VA(200,NUR2,0)),U))
 W !!,"Remaining Balance: ",$P(PSDR(1),U,4)-PSDQ," ",$P(PSDR(1),U,8)
 D UPDAT^PSDRF1 G DRUG^PSDRF4
END W:$G(PSDOUT) !!,"No dose signed out.",$C(7),!! K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K NAOU,NAOUN,NBKU,NPKG,OK,OKTYP,ORD,PSDA,PSDEM,PSDOUT,PSDQTY,PSDRD,PSDR,PSDRN,PSDS,PSDT,PSDUZ,PSDUZN,REQD,TEXT,TYPE,WORD,X,Y
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
