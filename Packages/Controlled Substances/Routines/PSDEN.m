PSDEN ;BIR/JPW-Enter NAOUs ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSD PARAM",DUZ)) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to enter/edit",!,?12,"NAOUs.  PSD PARAM security key required.",! Q
 S SITEN=$P($G(^PS(59.4,+PSDSITE,0)),"^"),MULTI=$S($P(PSDSITE,"^",2)="M":1,1:0)
NAOU ;entry for NAOUs into file 58.8
 K DIC,DLAYGO W ! S (DIC,DLAYGO)=58.8,DIC(0)="QEAL",DIC("A")="Select NAOU: ",DIC("DR")="2////"_+PSDSITE,DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$P(^(0),""^"",2)'=""P"""
 D ^DIC K DIC,DLAYGO G:Y<0 END S PSDA=+Y,NEW=+$P(Y,"^",3) D TYPE
 G NAOU
END K ANS,DA,DIC,DIE,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,MULTI,NEW,PSDA,SITEN,X,Y
 Q
TYPE ;selects location type
 W !!,"CONTROLLED SUBSTANCES SITE : "_SITEN
 I $P(^PSD(58.8,PSDA,0),"^",2)]"",+$O(^PSD(58.8,PSDA,1,0)) S ANS=$P(^PSD(58.8,PSDA,0),"^",2) G DIE
 K ANS,DIR,DIRUT S DIR(0)="S^M:MASTER VAULT;S:SATELLITE VAULT;N:NARCOTIC LOCATION",DIR("A")="LOCATION TYPE"
 S DIR("?")="'S' for Satellite Vault or 'N' for Narcotic location.",DIR("?",1)="Enter this NAOU's type.  Select 'M' for Master Vault,"
 S:$P(^PSD(58.8,PSDA,0),"^",2)]"" DIR("B")=$P(^(0),"^",2) D ^DIR K DIR
 I $D(DIRUT),NEW K DIK S DIK="^PSD(58.8,",DA=+PSDA D ^DIK K DIK W $C(7),!!,"No location type entered.  Entry has been deleted!",!! Q
 Q:$D(DIRUT)  S ANS=Y
DIE ;edit
 S PSDJLP=1
 K DA,DIE,DR S DIE=58.8,DA=PSDA
 S:ANS="M" DR=".01T;1////"_ANS_";Q;5;3///@;14;I 'X S Y=19;15;Q;16;Q;17;Q;19;19.5;23;24;25;26;29;28;30;12;S:'$P(^(0),U,8) Y=0;13"
 S:ANS="S" DR=".01T;1////"_ANS_";Q;3;5;14;I 'X S Y=19;15;Q;16;Q;17;Q;19;19.5;23;24;25;26;29;28;30"
 S:ANS="N" DR=".01T;1////"_ANS_";Q;3;18;6T;32;33"
 D ^DIE K DIE,DR,DA,PSDJLP
 ;link ward for dispensing equipment interface
 D:$O(^HL(770,"B","PSD-NDES",0))&(ANS="N")
WARD .I $O(^PSD(58.8,+PSDA,3,0)) W !!,"Current Ward(s):  " S PSDA(1)=0 F  S PSDA(1)=$O(^PSD(58.8,+PSDA,3,PSDA(1))) Q:'PSDA(1)  W ?20,$P($G(^DIC(42,+PSDA(1),0)),U),!
 .S DIR(0)="PO^42:AEMQ"
 .S DIR("A")="Select Ward for dispensing equipment interface"
 .S DIR("?")="When doses are dispensed the ward will be used as a path to this NAOU."
 .W ! D ^DIR K DIR Q:Y<1  S PSDA(1)=0,PSDA(2)=+Y,PSDA(3)=$P(Y,U,2)
 .I $D(^PSD(58.8,"AB",PSDA(2),PSDA)) D  Q:$D(DIRUT)  G WARD
 ..S DIR(0)="Y",DIR("A")="Remove "_PSDA(3)_"'s link to "_$P($G(^PSD(58.8,+PSDA,0)),U) D ^DIR K DIR
 ..I Y=1 W !!,PSDA(3)," removed.",! S DIK="^PSD(58.8,+PSDA,3,",DA(1)=PSDA,DA=PSDA(2) D ^DIK K DIK,DA
 .F  S PSDA(1)=$O(^PSD(58.8,"AB",PSDA(2),PSDA(1))) Q:'PSDA(1)  S:$P($G(^PSD(58.8,PSDA(1),0)),U,2)="N"&(PSDA'=PSDA(1)) PSDA(4)=$P($G(^(0)),U)
 .I $G(PSDA(4))]"" W !!,PSDA(3)," is already linked to ",PSDA(4),"." K PSDA(4) G WARD
 .S DIC="^PSD(58.8,"_+PSDA_",3,",DIC(0)="LM",DLAYGO=58.8,DA(1)=PSDA
 .S X=PSDA(3),DA=PSDA(2),DIC("P")=$P(^DD(58.8,21,0),U,2),DINUM=PSDA(2)
 .D ^DIC K DIC,DA,DLAYGO G WARD
 ;Set up Default Dispensing Site
 I "MS"[ANS S $P(PSDSITE,U,3)=PSDA,$P(PSDSITE,U,4)=$P($G(^PSD(58.8,+PSDA,0)),U),$P(PSDSITE,U,5)=0 D EN^PSDSP S:$G(PSDS) $P(PSDSITE,U,5)=1
 K PSDA,PSDS,PSDSN Q
