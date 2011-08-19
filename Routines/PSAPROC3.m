PSAPROC3 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,60**; 10/24/97;Build 4
 ;This routine allows the user to edit invoices with errors or missing
 ;data.
 ;
DUOU ;Gets & stores dispense unit per order unit in XTMP
 W:'$G(PSADU) !,"DISPENSE UNITS: "_$P($G(^PSDRUG(PSAIEN,660)),"^",8)
 S PSADU=1
 ;
 ;DAVE B (PSA*3*3)
 S DIR(0)="NO^::2",DIR("A")="DISPENSE UNIT PER ORDER UNIT",DIR("?")="Enter the number of dispense units contained in one order unit.",DIR("??")="^D DUOUHELP^PSAPROC3"
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 I +Y S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",20)=+Y,PSADATA=^(PSALINE) Q
 ;
 W !,"The dispense units per order unit must be entered",!,"to change the status of the invoice to Processed."
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to enter the data now"
 S DIR("?",1)="Enter Yes to return to the DISPENSE UNIT PER ORDER UNIT prompt.",DIR("?")="Enter No to bypass entering the dispense units now."
 S DIR("??")="^D DUOUYN^PSAPROC8" D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 Q:Y=""  G:+Y DUOU Q
 ;
GETOU ;Get the Order Unit if it is blank or if it is not in the ORDER UNIT file.
 S DIR(0)="P^51.5:EMZ",DIR("A")="ORDER UNIT",DIR("?")="Enter the unit of order.",DIR("??")="^D OUHELP^PSAPROC3"
 S DIR("B")=$S(+$P($P(PSADATA,"^",2),"~",2):$P($G(^DIC(51.5,+$P($P(PSADATA,"^",2),"~",2),0)),"^"),+$P($G(^PSDRUG(PSAIEN,660)),"^",2):$P($G(^DIC(51.5,+$P($G(^PSDRUG(PSAIEN,660)),"^",2),0)),"^"),1:"")
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 ;
 ;DAVE B (PSA*3*3)
 ;Q:+$P($P(PSADATA,"^",2),"~",2)=+Y
 I +Y S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",12)=+Y,$P(^(PSALINE),"^",13)=DUZ,$P(^(PSALINE),"^",14)=DT,PSADATA=^(PSALINE) Q
 ;
 W !,"The order unit must be entered to change",!,"the status of the invoice to Processed.",!
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to enter the data now"
 S DIR("?",1)="Enter Yes to return to the ORDER UNIT prompt.",DIR("?")="Enter No to bypass entering the order units now.",DIR("??")="^D OUYN^PSAPROC3"
 D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 Q:Y=""
 G:+Y GETOU
 Q
 ;
PRICE ;If price per order unit is blank or 0, get price from user.
 S DIR(0)="NO^0:9999:4",DIR("A")="PRICE PER ORDER UNIT",DIR("B")=0
 S DIR("?",1)="If the price per order unit is not zero (0), enter",DIR("?",2)="the correct price. If the price per order unit is",DIR("?")="zero, press return to verify that the price is correct."
 S DIR("??")="^D PRICEHLP^PSAPROC3" D ^DIR K DIR I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 I +$P(PSADATA,"^",3),+$P(PSADATA,"^",3)=+Y Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",23)=+Y,$P(^(PSALINE),"^",24)=DUZ,$P(^(PSALINE),"^",25)=DT,PSADATA=^(PSALINE)
 Q
 ;
QTY ;If qty is blank, prompt for it.
 S DIR(0)="N",DIR("A")="QUANTITY RECEIVED",DIR("B")=$S(+$P(PSADATA,"^",8):+$P(PSADATA,"^",8),+PSADATA:+PSADATA,1:0)
 S DIR("?",1)="If the quantity received is different than the",DIR("?")="quantity invoiced, enter the correct quantity received.",DIR("??")="^D QTYHELP^PSAPROC3"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 Q:+PSADATA=+Y  S PSADJQTY=+Y
 S DIR(0)="F^1:30",DIR("A")="ADJUSTMENT REASON",DIR("?")="Enter the reason you adjusted the quantity received.",DIR("??")="^D ADJREA^PSAPROC3"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",8)=PSADJQTY,$P(^(PSALINE),"^",9)=DUZ,$P(^(PSALINE),"^",10)=DT,$P(^(PSALINE),"^",11)=Y,PSADATA=^(PSALINE)
 Q
 ;
RECD ;Enter the date the invoiced drugs were received.
 S DIR(0)="D",DIR("A")="Date received",DIR("?")="Enter the date the drugs were received.",DIR("??")="^D RECHELP^PSAPROC3" ;*60 removed default receive date
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 S:$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",6)'=+Y $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",11)=+Y S PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 Q
 ;
SETLINE ;Set line as process if all data is present.
 S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE),PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 I $D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP")) S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="P",PSALINES=PSALINES+1,PSALLSUP=PSALLSUP+1 Q
 S PSAIEN=$S(+$P(PSADATA,"^",15):+$P(PSADATA,"^",15),+$P(PSADATA,"^",6):+$P(PSADATA,"^",6),1:0),PSASUB=+$P(PSADATA,"^",7)
 I PSAIEN,$P($G(^PSDRUG(PSAIEN,2)),"^",3)["N" S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)="CS"
 E  S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)=""
 S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE),PSALOC=$S($P(PSADATA,"^",19)'="CS":+$P(PSAIN,"^",7),1:+$P(PSAIN,"^",12))
 I +$P(PSADATA,"^",6)!(+$P(PSADATA,"^",15)),$P(PSADATA,"^")'=""!($P(PSADATA,"^",8)'=""),$P($G(^PSDRUG(PSAIEN,660)),"^",8)'="" D
 .I +$P($G(^PSDRUG(PSAIEN,1,+$G(PSASUB),0)),"^",7)!(+$P(PSADATA,"^",20)),+$P($P(PSADATA,"^",2),"~",2)!(+$P(PSADATA,"^",12))!(+$P($G(^PSDRUG(PSAIEN,1,+$G(PSASUB),0)),"^",5)) D
 ..S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="P",PSALINES=PSALINES+1,$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",13)="",PSAIN=^("IN")
 Q
 ;
ADJREA ;Extended help for 'qty adjustment reason'
 W !?5,"Enter why you changed the quantity.",!?5,"For example: 2 bottles were broken.",!?5,"             Package contained only 11 tubes."
 Q
DUOUHELP ;Extended help for entering dispense units per order unit
 W !?5,"Enter the number of dispense units contained in the order unit.",!!?5,"For example: Dispense Units: TAB",!?18,"Order Unit    : CS"
 W !!?18,"The case contains 12 bottles of 1,000 tablets",!?18,"12 x 1,000 = 12,000",!?18,"DISPENSE UNITS PER ORDER UNIT: 12,000"
 Q
NDCHELP ;Extended help for selecting invoiced drug
 W !?5,"Enter the number to the left of the invoiced drug. If you select  a drug",!?5,"from the list, the invoiced drug will be matched to that drug. If you"
 W !?5,"choose to select another drug, you can select the invoiced drug from the",!?5,"DRUG file or flag this item as a supply item."
 Q
OUHELP ;Extended help for selecting the Order Unit
 W !?5,"Enter the packaging unit for which the drug was ordered."
 Q
OUYN ;Extended help for returning to the 'ORDER UNIT' prompt.
 W !?5,"Enter Yes if you want to enter the order unit now.",!?5,"Enter No to bypass entering the order unit."
 W !!?5,"The invoice will not be placed in a Processed",!?5,"status if the order units are not entered."
 Q
PRICEHLP ;Extended help for price per order unit
 W !?5,"If the price per order unit is not zero, enter the correct price. ",!?5,"The total cost for the item will be adjusted. If it is zero, press ",!?5,"the return key to verify that zero is the correct price."
 Q
QTYHELP ;Extended help for quantity delivered
 W !?5,"If the quantity received is different than the quantity",!?5,"displayed, enter the correct quantity you received. The",!?5,"total cost for the item will be adjusted."
 Q
RECHELP ;Extended help to 'Date Received'
 W !?5,"Enter the date the drugs were received. The date the prime vendor",!?5,"said the drugs were delivered and the date you say the drugs were",!?5,"received will be retained."
 Q
