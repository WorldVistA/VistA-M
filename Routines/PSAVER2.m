PSAVER2 ;BIR/JMB-Verify Invoices - CONT'D ;10/7/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,12,21,60,64**; 10/24/97;Build 4
 ;This routine contains the prompts for the fields that the verifier
 ;is allowed to edit.
 ;
 ;References to ^DIC(51.5, are covered by IA #1931
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PSDRUG("C" are covered by IA #2095
 ;
ASKDRUG W !,"If the item will never be in the DRUG, press the Return key then",!,"answer YES to the ""Is this a supply item?"" prompt. To bypass this",!,"line item, enter ""^"" then press the Return key.",!
 S PSAGAIN=0,PSABEFOR=PSADRG,DIC(0)="AEMQZ",DIC="^PSDRUG(" D ^DIC K DIC
 I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 S PSADJFLD="D",PSAREA="",PSASUPP=0
 I +Y=-1 D  Q:PSASUPP!(PSAOUT)
 .S PSAVER=1 D SUPPLY^PSANDF Q:PSAOUT  I 'PSASUPP S PSAGAIN=1 Q
 .S PSA50IEN=0,PSADJ=PSAREA,PSAREA="" K ^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,2)
 .D RECORD
 G:$G(PSAGAIN) ASKDRUG
 S (PSA50IEN,PSADJ,PSADRG)=+Y D RECORD,HDR^PSAVER1,VERDISP^PSAUTL4
 I PSANDC'="",$O(^PSDRUG("C",PSANDC,PSA50IEN,0)) D
 .S PSASUB=+$O(^PSDRUG("C",PSANDC,PSA50IEN,0)),$P(^PSD(58.811,PSAIEN,1,PSAIEN1,2),"^",3)=PSASUB
 .I '+$P($G(^PSDRUG(PSA50IEN,1,PSASUB,0)),"^",7) D DUOU Q
 .I +$P($G(^PSDRUG(PSA50IEN,1,PSASUB,0)),"^",7),+$P($G(^PSDRUG(PSA50IEN,1,PSASUB,0)),"^",7)'=+$P($G(^PSDRUG(PSABEFOR,1,PSASUB,0)),"^",7) D DUOU
 ;
 I PSANDC'="",'$O(^PSDRUG("C",PSANDC,PSA50IEN,0)),PSA50IEN'=PSABEFOR D DUOU
 ;
 I PSANDC="",PSAUPC="" D
 .W !,"The vendor did not send a NDC or UPC for the drug. Enter the",!,"NDC if it is available. Enter the UPC if you do not know the NDC.",!
 .S DIR(0)="SA^N:NDC;U:UPC",DIR("A")="Will you enter the NDC or UPC? ",DIR("B")="N",DIR("??")="^D NDCUPC^PSANDF1" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 .I Y="N" D GETNDC^PSANDF Q:PSAOUT  S PSANDC=Y D:PSANDC'="" ADDDATA
 .I Y="U" D GETUPC^PSANDF Q:PSAOUT  S PSANDC="S"_Y,PSAUPC=Y D:PSANDC'="" ADDDATA
 Q
 ;
ADDDATA ;Adds the missing NDC and/or UPC
 K DA S DA(2)=PSAIEN,DA(1)=PSAIEN1,DA=PSALINE,DIE="^PSD(58.811,"_DA(2)_",1,"_DA(1)_",1,",DR="13///^S X="_PSANDC_$S(PSAUPC'="":";15///^S X="_PSAUPC,1:"")
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 K DIE I $G(DTOUT)!($G(DUOUT)) S PSAOUT=0 Q
 D VERDISP^PSAUTL4
 Q
RECORD ;Adds adjusted data to DA ORDERS file
 S PSANEW=0
 I '$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,0)) S ^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,0)="^58.811259SA^^"
 I $D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"B",PSADJFLD)) D  Q
 .S DA=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"B",PSADJFLD,0))
 .I '$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,DA,0)) D NEW Q
 .D ADJ
 ;
NEW S:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,0)) DIC("P")=$P(^DD(58.81125,9,0),"^",2) K DA
 S DA(3)=PSAIEN,DA(2)=PSAIEN1,DA(1)=PSALINE,X=PSADJFLD,DIC="^PSD(58.811,"_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,",DIC(0)="L",DLAYGO=58.811
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIC L -^PSD(58.811,PSAIEN,1,PSAIEN1,0) K DIC,DLAYGO S DA=+Y
 ;
ADJ S DA(3)=PSAIEN,DA(2)=PSAIEN1,DA(1)=PSALINE,DIE="^PSD(58.811,"_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"
 ;
 ;PSA*3*3 (DaveB 1JUN98)
 S DR="5///^S X=PSADJ"_$S(PSAREA'="":";6////^S X=PSAREA",1:"")_";7///^S X="_DT_";8////^S X="_DUZ  ; *60
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE
INDEX S DIK=DIE D IX1^DIK K DIE,DIK L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 Q
 ;
DUOU ;Gets Dispense Units Per Order Unit
 ;DAVE B (PSA*3*12) If PSASUPP is defined, the item is supply
 ;no need to ask for dispense units per order unit.
 I $G(PSASUPP)=1 W !,"Item appears to be marked for supply, no need to enter Dispense Units Per Order Unit." Q
 W !,"DISPENSE UNITS: "_$S($P($G(^PSDRUG(PSA50IEN,660)),"^",8)'="":$P($G(^PSDRUG(PSA50IEN,660)),"^",8),1:"Blank")
 S DIR(0)="NO^::2",DIR("A")="DISPENSE UNITS PER ORDER UNIT",DIR("B")=$P($G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,2)),"^")
 S DIR("?")="Enter the number of dispense units contained in one order unit",DIR("??")="^D DUOUHELP^PSAPROC3"
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,2),"^")=+Y S:+Y PSASET=1
 Q:Y'=""
 ;
 W !!,"The dispense units per order unit must be entered",!,"to change the status of the invoice to Verified."
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to enter the data now"
 S DIR("?",1)="Enter Yes to return to the DISPENSE UNITS PER ORDER UNIT prompt.",DIR("?")="Enter No to bypass entering the dispense units now."
 S DIR("??")="^D DUOUYN^PSAPROC8" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 W ! G:+Y DUOU
 Q
 ;
OU ;Get order unit
 S DIC(0)="QAEMZ",DIC="^DIC(51.5,",DIC("A")="ORDER UNIT: ",DR=.01 S:+PSAOU&($P($G(^DIC(51.5,+PSAOU,0)),"^")'="") DIC("B")=$P(^DIC(51.5,+PSAOU,0),"^") D ^DIC K DIC
 I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 ;
 ;PSA*3*12 Dave B, allow verifier to change OU to original if necessary
 G:Y=-1 OU S PSADJFLD="O",PSADJ=+Y,PSAREA="" D RECORD
 Q
 ;
PHARM ;Pharmacy Location/Master Vault -- DR is set prior to the call.
 K DA S DA(1)=PSAIEN,DA=PSAIEN1,DIE="^PSD(58.811,"_DA(1)_",1," D ^DIE K DIE
 S:$G(DTOUT)!($G(DUOUT)) PSAOUT=1
 Q
 ;
QTY ;Adjust the quantity received
 S DIR(0)="N",DIR("A")="QUANTITY RECEIVED",DIR("B")=PSAQTY
 S DIR("?",1)="If the quantity received is different than the invoiced or",DIR("?")="adjusted quantity, enter the correct quantity received.",DIR("??")="^D QTYHELP^PSAPROC3"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 Q:PSAQTY=+Y  S PSADJ=+Y
 S DIR(0)="F^1:30",DIR("A")="ADJUSTMENT REASON",DIR("?")="Enter the reason you adjusted the quantity received.",DIR("??")="^D ADJREA^PSAPROC3"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S PSADJFLD="Q",PSAREA=Y D RECORD
 Q
 ;
RECD ;Date Received
 K PSARECD S PSAREC=$S(+$P(PSAIN,"^",7):+$P(PSAIN,"^",7),+$P(PSAIN,"^",6):+$P(PSAIN,"^",6),1:"")
 S DIR(0)="D",DIR("A")="Date received",DIR("?")="Enter the date the drugs were received.",DIR("??")="^D RECHELP^PSAPROC3" S:PSAREC DIR("B")=$$FMTE^XLFDT(PSAREC)
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 Q:'+$P(PSAIN,"^",7)&(+Y=+$P(PSAIN,"^",6))
 Q:+$P(PSAIN,"^",6)'=+$P(PSAIN,"^",7)&(+$P(PSAIN,"^",7)=+Y)
 S:+$P(PSAIN,"^",6)=+Y PSARECD="@"
 S:+$P(PSAIN,"^",6)'=+Y&(+$P(PSAIN,"^",7)'=+Y) PSARECD=+Y
 Q:'$D(PSARECD)  K DA
 S DA(1)=PSAIEN,DA=PSAIEN1,DIE="^PSD(58.811,"_DA(1)_",1,",DR="8///"_$S(+PSARECD:"^S X="_PSARECD,1:"@")
 F  L +^PSD(58.811,PSAIEN,1,PSAIEN1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSD(58.811,PSAIEN,1,PSAIEN1,0)
 K DIE
 I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1
 Q
 ;
REORDER ;Enter reorder level for drug if the field is blank.
 S DIR(0)="NO^0:99999",DIR("A")="REORDER LEVEL (in Dispense Units)",DIR("??")="^D REORD^PSAPROC8",DIR("B")=+PSAREORD
 S DIR("?")="Enter the minimum number of dispense units to keep in the "_$S(+$P(PSADATA,"^",10):"master vault",1:"pharmacy location")_"."
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,2),"^",2)=+Y
 Q
STOCK ;Enter stock level for drug if the field is blank.
 S DIR(0)="NO^0:99999",DIR("A")="STOCK LEVEL (in Dispense Units)",DIR("??")="^D STKLEVEL^PSAPROC8",DIR("B")=+PSASTOCK
 S DIR("?")="Enter the ideal number of dispense units to keep on the shelf."
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 S $P(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,2),"^",4)=+Y
 Q
