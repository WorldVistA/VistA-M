PSDORNO ;BIR/JPW,LTL-Nurse CS Order Request Entry (One time); 15 Jan 95
 ;;3.0; CONTROLLED SUBSTANCES ;**20**;13 Feb 97
 ;
 ; Reference to DD("DD" supported by DBIA # 10017
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ;
 S DIR(0)="Y",DIR("B")="No"
 S DIR("A",1)="You have selected "_PSDRN
 S DIR("A",2)="which is "_$S('$G(^PSD(58.8,+NAOU,1,PSDR,0)):"not stocked by ",1:"inactive on ")_NAOUN_"."
 S DIR("A")="Are you sure you want to create a one time request"
 S DIR("?")="^N XQH S XQH=""PSD ORDER ENTRY ONE TIME"" D EN^XQH"
 W ! D ^DIR K DIR Q:Y<1
 I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) S MSG=2 D MSG G END
 S DIR(0)="DA^NOW::AEFT",DIR("A")="Date/time required: "
 S DIR("?",1)="You are on the verge of creating a priority order."
 S DIR("?",2)="If this is a mistake, enter ""^"" to create a scheduled order, otherwise,"
 S DIR("?")="Pharmacy needs to know how soon you need this order."
 W ! D ^DIR K DIR G:$D(DIRUT) END X ^DD("DD") S PSDT(9)=Y
 I '$D(^PSD(58.8,+NAOU,1,+PSDR,0)) S DA(1)=+NAOU,DIC="^PSD(58.8,+NAOU,1,",DIC(0)="L",DLAYGO=58.8,X="`"_PSDR,DIC("DR")="13////"_DT_";14////"_"O"_";14.5////"_"One Time Request",DINUM=PSDR D ^DIC K DIC,DLAYGO I Y<1 W !,"Inactive drug" G END
 S NBKU=$P(^PSD(58.8,+PSDS,1,PSDR,0),"^",8),NPKG=+$P(^(0),"^",9)
 I NBKU']"" S MSG1=3 D MSG G END
 I 'NPKG S MSG1=4 D MSG G END
 W !!,"Sending a Mailman message to the Pharmacy Supervisor(s)...",!!
 D ^PSDORM,LIST^PSDORL
QTY K ORD S PSDOUT=0 S PSDQTY=NPKG,CNT=0 D DIE G:PSDOUT END
 D ASK^PSDORN1 G:PSDOUT END
END K %,%DT,%H,%I,CNT,CNT1,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,LN,MSG,MSG1
 K PSDEM,PSDOUT,X,Y
 Q
DIE ;create the order request
 Q:'$D(^PSD(58.8,NAOU,1,PSDR,0))
 S PSDEM=1
 S:'$D(^PSD(58.8,NAOU,1,PSDR,3,0)) ^(0)="^58.800118A^^"
DIE2 S PSDA=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA)) S $P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)=$P(^PSD(58.8,NAOU,1,PSDR,3,0),"^",3)+1 G DIE2
 K DA,DIC,DIE,DD,DR,DO S DIC(0)="L",(DIC,DIE)="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,",DA(2)=NAOU,DA(1)=PSDR,(X,DINUM)=PSDA D FILE^DICN K DIC
 D NOW^%DTC S PSDT=+$E(%,1,12)
 W ?10,!!,"processing one order for ",PSDQTY," now..."
 S DA=PSDA,DA(1)=PSDR,DA(2)=NAOU,DR="1////"_PSDT_";2////"_+PSDS_";3////"_PSDUZ_";10////1;5////"_PSDQTY_";24////"_$G(PSDEM)_";13" D ^DIE K DIE,DR
 Q
MSG ;display error message
 W $C(7),!!,?10,"Contact your Pharmacy Coordinator.",!,?10,"This "_$S(MSG=2:"Dispensing Site",MSG=1:"NAOU",1:"Drug")_" is missing "
 W $S(MSG1=1:"Primary Disp. Site",MSG1=2:"stocked drugs",MSG1=3:"narcotic breakdown unit",MSG1=4:"narcotic package size",1:"data")_".",!
 Q
