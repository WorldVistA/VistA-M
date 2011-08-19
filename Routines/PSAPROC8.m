PSAPROC8 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,64,70**; 10/24/97;Build 12
 ;This routine processes uploaded invoices.
 ;
DU ;Prompts Dispense Unit if blank
 F  L +^PSDRUG(PSAIEN,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S DIE="^PSDRUG(",DA=PSAIEN,DR=14.5 D ^DIE K DIE L -^PSDRUG(PSAIEN,0)
 I +$P($G(^PSDRUG(PSAIEN,660)),"^",8) D  G DU
 .F  L +^PSDRUG(PSAIEN,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .S DIE="^PSDRUG(",DA=PSAIEN,DR="14.5///@" D ^DIE K DIE L -^PSDRUG(PSAIEN,0)
 I $P($G(^PSDRUG(PSAIEN,660)),"^",8)'="" S PSADU=1 Q
 ;
 W !,"The dispense units must be entered to change",!,"the status of the invoice to Processed."
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to enter the dispense units now",DIR("?",1)="Enter Yes to return to the DISPENSE UNIT prompt.",DIR("?")="Enter No to bypass entering the dispense units now."
 S DIR("??")="^D DISPYN^PSAPROC8" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 G:+Y DU
 Q
 ;
DUOU ;Gets Dispense Units per Order Unit
 W:'$G(PSADU) !,"DISPENSE UNITS: "_$P($G(^PSDRUG(PSAIEN,660)),"^",8)
 S PSADU=1
 F  L +^PSDRUG(PSAIEN,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S DIE="^PSDRUG("_PSAIEN_",1,",DA(1)=PSAIEN,DA=+PSASUB,DR=403 D ^DIE K DIE L -^PSDRUG(PSAIEN,0)
 I $D(Y)!($G(DTOUT)) S PSAOUT=1 Q
 Q:+$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",7)
 ;
 S DIR(0)="Y",DIR("B")="Y",DIR("A",1)="The dispense units per order unit must be entered to change the ",DIR("A")="status of the invoice to Processed. Do you want to enter the data now"
 S DIR("?",1)="Enter Yes to return to the "_$P($G(^PSDRUG(PSAIEN,660)),"^",8)_"s per "_$P($G(^DIC(51.5,+$P($P(PSADATA,"^",2),"~",2),0)),"^",2)_" prompt."
 S DIR("?")="Enter No to bypass entering the dispense units now.",DIR("??")="^D DUOUYN^PSAPROC8"
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 G:+Y DUOU
 Q
OK ;
 S PSACNTOK=PSACNTOK+1,PSAOK(PSACNTOK)=$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",4)_"^"_$P(^("IN"),"^",2)_"^"_PSACTRL_"^"_$P(^("IN"),"^",7)
 Q
PRICE ;Price per Order Unit changed
 S PSAIPR=$L($FN($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",3),",",2)),PSAFPR=$L($FN($P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",6),",",2))
 S PSAJUST=$S(PSAIPR>PSAFPR:PSAIPR,1:PSAFPR)
 W !!,"Price per Order Unit -- Invoice's: $"_$J($FN($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",3),",",2),PSAJUST,2),!?24,"File's   : $"_$J($FN($P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",6),",",2),PSAJUST,2),!
 S DIR(0)="Y",DIR("A")="Is the invoice's price per order unit correct",DIR("B")="Y",DIR("?",1)="Enter Yes if "_$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",3)_" is correct."
 S DIR("?")="Enter No to keep the file's price per order unit.",DIR("??")="^D PRICEOU^PSAPROC1" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",22)=+Y
 I '+Y S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",23)=+$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",6),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",24)=DUZ,$P(^(PSALINE),"^",25)=DT
 Q
 ;
REORDER ;Enter reorder level for drug if the field is blank.
 W:'$G(PSADU) !,"DISPENSE UNITS: "_$P($G(^PSDRUG(+PSAIEN,660)),"^",8)
 S PSADU=1,DIR(0)="NO^0:99999",DIR("A")="REORDER LEVEL IN "_$P($G(^PSD(58.8,PSALOC,0)),"^")
 S DIR("?")="Enter the minimum number of dispense units to keep in the "_$S($P(PSADATA,"^",19)="CS":"master vault.",1:"pharmacy location."),DIR("??")="^D REORD^PSAPROC8"
 S DIR("B")=$S(+$P(PSADATA,"^",21):+$P(PSADATA,"^",21),+$P($G(^PSD(58.8,PSALOC,1,PSAIEN,0)),"^",5):$P(^PSD(58.8,PSALOC,1,PSAIEN,0),"^",5),1:"")
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",21)=+Y
 Q
 ;
STOCK ;Enter stock level for drug if the field is blank.
 W:'$G(PSADU) !,"DISPENSE UNITS: "_$P($G(^PSDRUG(+PSAIEN,660)),"^",8)
 S PSADU=1,DIR(0)="NO^0:99999",DIR("A")="STOCK LEVEL IN "_$P($G(^PSD(58.8,+PSALOC,0)),"^")
 S DIR("?")="Enter the minimum number of dispense units to keep on the shelf",DIR("??")="^D STKLEVEL^PSAPROC8"
 S DIR("B")=$S(+$P(PSADATA,"^",27):+$P(PSADATA,"^",27),+$P($G(^PSD(58.8,PSALOC,1,PSAIEN,0)),"^",3):$P(^PSD(58.8,PSALOC,1,PSAIEN,0),"^",3),1:"")
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 Q:$G(DIRUT)
 S:+Y $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",27)=+Y
 Q
 ;
DISPYN ;Extended help to enter dispense units
 W !?5,"Enter Yes if you want to enter the dispense units now.",!!?5,"Enter No to bypass entering the dispense units. The invoice will not",!?5,"be placed in a Processed status if the dispense units are not entered."
 Q
DUOUYN ;Extended help to enter dispense units per order units
 W !?5,"Enter Yes if you want to enter the dispense units per order unit now.",!!?5,"Enter No to bypass entering the dispense units per order unit. The"
 W !?5,"invoice will not be placed in a "_$S($D(PSABEFOR):"Verified",1:"Processed")_" status if the dispense units",!?5,"are not entered."
 Q
PRICEOU ;Extended help to 'Is invoice's price per order unit correct'
 W !?5,"Enter Yes if the invoice's price per order unit is correct. The",!?5,"invoice's price per order unit will be entered into the DRUG file."
 W !!?5,"Enter No if the invoice's price per order unit is not correct.",!?5,"The DRUG file's price per order unit will remain the same."
 Q
REORD ;Extended help for 'Reorder level'
 W !?5,"Enter the lowest amount of "_$P($G(^PSDRUG(PSAIEN,660)),"^",8)_"s to keep in the "_$S($P(PSADATA,"^",19)="CS":"master vault",1:"pharmacy location")_"."
 W !!?5,"When the amount on hand is lower than the reorder level, a mail",!?5,"message will be sent showing the drug name, reorder level, and",!?5,"quantity on hand."
 Q
STKLEVEL ;Extended help for 'Stock level'
 W !?5,"Enter the ideal number of dispense units to keep on the shelf. When the",!?5,"number of dispense units is equal to or less than the reorder level, the"
 W !?5,"amount to order is determined by subtracting the current number of dispense",!?5,"units from the stock level."
 Q
PLOCK(PSATYP) ;SET ^XTMP("PSAPV",PSACRTL WITH A LOCK INDENTIFER  <- PSA*3*70 RJS
 N PSAPC,PSAORD,PSATMP,PSAMENU,PSADUZ S PSATMP=""
 F  L +^XTMP("PSAPVL"):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 I PSATYP=2 D
 .F PSAPC=1:1 S PSAMENU=$P(PSASEL,",",PSAPC) Q:'PSAMENU!(PSAOUT)  D
 ..Q:'$D(PSAERR(PSAMENU))
 ..S PSACTRL=$P(PSAERR(PSAMENU),"^",3),PSAORD=$P(PSAERR(PSAMENU),"^",1),PSADUZ=$G(^XTMP("PSAPVL",PSACTRL))
 ..I $P(PSADUZ,"^",3)<+$H K ^XTMP("PSAPVL",PSACTRL)
 ..I $D(^XTMP("PSAPVL",PSACTRL)),+PSADUZ=DUZ,$P(PSADUZ,"^",2)'=$J W !!,?5,"YOU ARE CURRENTLY PROCESSING ORDER# ",PSAORD," IN ANOTHER SESSION" Q
 ..I $D(^XTMP("PSAPVL",PSACTRL)),+PSADUZ'=DUZ W !!,?5,"ORDER# ",PSAORD," IS CURRENTLY BEING PROCESSED BY ",$P($P(^VA(200,+PSADUZ,0),"^",1),",",2)," ",$P($P(^VA(200,+PSADUZ,0),"^",1),",",1) Q
 ..I '$D(^XTMP("PSAPV",PSACTRL,"IN"))&($D(^PSD(58.811,"B",PSAORD))) W !!,?5,"ORDER# ",PSAORD," HAS ALREAY BEEN PROCESSED BY ANOTHER USER" Q
 ..S ^XTMP("PSAPVL",PSACTRL)=DUZ_"^"_$J_"^"_+$H
 ..S PSATMP=PSATMP_PSAMENU_",",PSALCK=1
 I PSATYP=1 D
 .F PSAPC=1:1 S PSA=+$P(PSASEL,",",PSAPC) Q:'PSA  D
 ..Q:'$D(PSAOK(PSA))
 ..S PSACTRL=$P(PSAOK(PSA),"^",3),PSAORD=$P(PSAOK(PSA),"^",1),PSADUZ=$G(^XTMP("PSAPVL",PSACTRL))
 ..I $P(PSADUZ,"^",3)<+$H K ^XTMP("PSAPVL",PSACTRL)
 ..I $D(^XTMP("PSAPVL",PSACTRL)),+PSADUZ=DUZ,$P(PSADUZ,"^",2)'=$J W !!,?5,"YOU ARE CURRENTLY PROCESSING ORDER# ",PSAORD," IN ANOTHER SESSION" Q
 ..I $D(^XTMP("PSAPVL",PSACTRL)),+PSADUZ'=DUZ W !!,?5,"ORDER# ",PSAORD," IS CURRENTLY BEING PROCESSED BY ",$P($P(^VA(200,+PSADUZ,0),"^",1),",",2)," ",$P($P(^VA(200,+PSADUZ,0),"^",1),",",1) Q
 ..I '$D(^XTMP("PSAPV",PSACTRL,"IN"))&($D(^PSD(58.811,"B",PSAORD))) W !!,?5,"ORDER# ",PSAORD," HAS ALREAY BEEN PROCESSED BY ANOTHER USER" Q
 ..S ^XTMP("PSAPVL",PSACTRL)=DUZ_"^"_$J_"^"_+$H
 ..S PSATMP=PSATMP_PSACTRL_",",PSALCK=1
 S PSASEL=PSATMP K PSATYP
 L -^XTMP("PSAPVL")
 Q
PSAUNLCK ;CLEANUP LOCK INDICATOR  <- PSA*3*70 RJS
 N PSACTRL,PSADUZ
 S PSACTRL=0 F  S PSACTRL=$O(^XTMP("PSAPVL",PSACTRL)) Q:'PSACTRL  D
 .S PSADUZ=$G(^XTMP("PSAPVL",PSACTRL))
 .I $P(PSADUZ,"^",3)<+$H K ^XTMP("PSAPVL",PSACTRL) Q
 .I $G(^XTMP("PSAPVL",PSACTRL)),'$G(^XTMP("PSAPV",PSACTRL,"IN")) K ^XTMP("PSAPVL",PSACTRL)  Q
 .I +$G(^XTMP("PSAPVL",PSACTRL))=DUZ,$G(^XTMP("PSAPV",PSACTRL,"IN")) D  Q
 ..K:$P(^XTMP("PSAPVL",PSACTRL),"^",2)=$J ^XTMP("PSAPVL",PSACTRL) Q
 ..W !!,"YOU ARE CURRENTLY PROCESSING ORDER# ",$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",4)," IN ANOTHER SESSION"
 .I +$G(^XTMP("PSAPVL",PSACTRL))'=DUZ,$G(^XTMP("PSAPV",PSACTRL,"IN")) D  Q
 ..W !!,$P($P(^VA(200,+PSADUZ,0),"^",1),",",2)," ",$P($P(^VA(200,+PSADUZ,0),"^",1),",",1)," IS CURRENTLY PROCESSING ORDER# ",$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",4)," IN ANOTHER SESSION"
 K PSALCK
 Q
