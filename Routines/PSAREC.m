PSAREC ;BIR/LTL,JMB-Receiving Directly into Drug Accountability ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**10**; 10/24/97
 ;This routine receives non-prime vendor's drugs into pharmacy locations.
 ;The balances are incremented in the pharmacy location & the DRUG file.
 ;
SETUP S (PSACNT,PSAOUT)=0 D ^PSAUTL3 G:PSAOUT EXIT
 S PSACHK=$O(PSALOC(""))
 I PSACHK="",'PSALOC W !,"There are no active pharmacy locations." G EXIT
 S PSAPO=$P($G(^PSD(58.8,+PSALOC,0)),"^",9)
 I +$E($P($G(^PRC(442,+PSAPO,12)),"^",5),4,5)'=+$E(DT,4,5) W !!,"The current PO# for this location doesn't seem current.",! D  G:$D(DIRUT) EXIT
 .S DIR(0)="Y",DIR("A")="Would you like to correct it",DIR("B")="No",DIR("?")="You can store a obligation number and it will be presented as the default.",DIR("??")="^D CORRECT^PSAREC"
 .D ^DIR K DIR Q:$D(DIRUT)!(Y<1)
 .S DIE="^PSD(58.8,",DA=PSALOC,DR="13" D ^DIE K DIE
 .S DIC("B")=$P($G(^PRC(442,+$P($G(^PSD(58.8,+PSALOC,0)),"^",9),0)),"^")
PO S PSAOUT=0 W ! S DIC="^PRC(442,",DIC(0)="AEMQZ"
 S DIC("A")="Select Obligation Number: ",DIC("S")="I $P($G(^(0)),""^"",5)[822400" D ^DIC K DIC G:Y<1 EXIT S PSAPO=+Y,PSACON=$P($G(Y(0)),"^",12)
 S DIE="^PSD(58.8,",DA=PSALOC,DR="13///^S X="+PSAPO D ^DIE K DIE
PART D START G PO
 ;
EXIT K %,DA,DIE,DINUM,DIRUT,DR,DTOUT,DUOUT,PSA,PSA50SYN,PSACBAL,PSACHK,PSACNT,PSACOMB,PSACON,PSACOST,PSADASH,PSADRG,PSADRGN,PSADT,PSADUOU
 K PSAIEN,PSAIEN1,PSAISIT,PSAISITN,PSALEN,PSALINE,PSALOC,PSALOCN,PSANDC,PSANODE,PSANPDU,PSANPOU,PSAODASH,PSAONDC,PSAOSIT,PSAOSITN,PSAOU,PSAOUT
 K PSAPDU,PSAPO,PSAPOU,PSA(2),PSAREC,PSASEL,PSAT,PSATDRG,PSAVEND,X,Y
 Q
 ;
START S DIC="^PRCS(410,",DIC(0)="AEMQZ",DIC("A")="Select Pharmacy Transaction number: ",DIC("B")=$S($D(PSACON):$P($G(^PRCS(410,+PSACON,0)),"^"),1:""),DIC("S")="I $P($G(^(0)),""^"",2)=""O"",$P($G(^(3)),""^"",3)[822400"
 D ^DIC K DIC Q:Y<1  S PSACON=$S(Y>0:+Y,1:"")
 S DIR(0)="58.81,71O",DIR("A")="Invoice number",DIR("?")="The invoice will be stored, allowing look-ups for receipts against this invoice.",DIR("??")="^D INV^PSAREC"
 D ^DIR K DIR Q:Y'=""&($D(DIRUT))  S PSA(2)=Y
 I $G(PSA(2))'="",$O(^PSD(58.81,"PV",Y,"")) D  Q:$D(DIRUT)  G:Y=1 DEV^PSAREPV
 .W !!,"Previous receipts have been processed for this invoice.",!! S DIR(0)="Y",DIR("A")="Would you like to review",DIR("B")="Yes" D ^DIR K DIR
 ;
DRUG W !!,$G(PSALOCN),!
 F  S DIC="^PSDRUG(",DIC(0)="AEMQ",DA(1)=PSALOC D  Q:PSAOUT
 .D ^DIC K DIC I Y<0 S PSAOUT=1 Q
 .D GETDATA Q:$G(PSAOUT)
 Q
 ;
GETDATA ;Gets receipts data
 S PSADRG=+Y,PSADRGN=$P($G(^PSDRUG(+Y,0)),"^"),PSACBAL=$P($G(^PSD(58.8,PSALOC,1,PSADRG,0)),"^",4)
NDC S DIR(0)="FO^1:15",DIR("A")="NDC",DIR("?")="Enter the National Drug Code for the drug received.",DIR("??")="^D NDCHELP^PSAREC"
 D ^DIR K DIR
 I $G(DIRUT) S (PSADASH,PSADUOU,PSANDC,PSAOU,PSAPOU)="",PSA50SYN=0 G OU
 S:Y'="" PSADASH=Y
 I PSADASH["-" S PSANDC=$E("000000",1,(6-$L($P(PSADASH,"-"))))_$P(PSADASH,"-")_$E("0000",1,(4-$L($P(PSADASH,"-",2))))_$P(PSADASH,"-",2)_$E("00",1,(2-$L($P(PSADASH,"-",3))))_$P(PSADASH,"-",3)
 E  S PSANDC=""
 S:PSANDC'?12N PSANDC="" S (PSAOU,PSADUOU,PSAPOU)=""
 I PSANDC'="",$O(^PSDRUG("C",PSANDC,PSADRG,0)) D
 .S PSA50SYN=+$O(^PSDRUG("C",PSANDC,PSADRG,0))
 .Q:'$D(^PSDRUG(PSADRG,1,PSA50SYN,0))
 .S PSAOU=$P($G(^PSDRUG(PSADRG,1,PSA50SYN,0)),"^",5),PSADUOU=$P($G(^(0)),"^",7),PSAPOU=$P($G(^(0)),"^",6)
 E  S PSA50SYN=0
OU S DIC(0)="QAEMZ",DIC="^DIC(51.5,",DIC("A")="Order Unit: ",DR=.01 S:PSAOU DIC("B")=PSAOU D ^DIC K DIC
 I Y<0 S PSAOUT=1 Q
 S PSAOU=+Y
 W !,"Dispense Units: "_$S($P($G(^PSDRUG(PSADRG,660)),"^",8)'="":$P(^PSDRUG(PSADRG,660),"^",8),1:"Unknown")
 ;
 ;DAVE B (PSA*3*10) decimal digits on Disp Units per OU
DUOU S DIR(0)="NO^::2",DIR("A")="Dispense Units per Order Unit" S:PSADUOU DIR("B")=PSADUOU
 S DIR("?")="Enter the number of dispense units contained in one order unit.",DIR("??")="^D DUOUHELP^PSAPROC3" D ^DIR K DIR
 I $G(DIRUT) S PSAOUT=1 Q
 S PSADUOU=+Y
PRICE S DIR(0)="NO^0:9999:4",DIR("A")="Price per Order Unit",DIR("?")="Enter the price for each order unit.",DIR("??")="^D PRICEHLP^PSAREC" S:PSAPOU DIR("B")=PSAPOU D ^DIR K DIR
 I $G(DIRUT) S PSAOUT=1 Q
 S PSAPOU=+Y S:+PSAPOU&(PSADUOU) PSAPDU=PSAPOU/PSADUOU
QTY S DIR(0)="N^0:9999999:0",DIR("A")="Quantity received",DIR("?")="Enter the number of order units you received.",DIR("??")="^D QTYHELP^PSAREC" D ^DIR K DIR
 I $D(DIRUT) S PSAOUT=1 Q
 S (PSAREC,PSAREC(1))=Y,PSAVEND=$P($G(^PRC(440,+$P($G(^PRC(442,PSAPO,1)),"^"),0)),"^"),PSACOST=PSAREC*PSAPOU,PSAREC=PSADUOU*PSAREC
DISP W ?50,"Converted quantity: ",PSAREC
 ;
 W ! S DIR(0)="Y",DIR("A")="Okay to post",DIR("B")="Yes",DIR("?",1)="Enter YES to add the received drug to the pharmacy location.",DIR("?")="Enter NO to cancel the receipt of the drug.",DIR("??")="^D POSTHELP^PSAREC"
 D ^DIR K DIR I $D(DIRUT) S PSAOUT=1 Q
 D:+Y POST^PSAREC1
 Q
 ;
CORRECT ;Extended help for 'Would you like to correct it'
 W !?5,"Enter YES to enter the current obligation number. It will be presented",!?5,"as the default the next time the obligation number prompt is displayed."
 W !!?5,"Enter NO to keep the current obligation number as the default."
 Q
 ;
INV ;Extended help for 'Invoice number'
 W !?5,"Enter the invoice number for the receipts."
 Q
NDCHELP ;Extended help for 'NDC'
 W !?5,"Enter the National Drug Code (NDC) for the received drug.",!?5,"Enter the NDC with dashes or 12-digits without dashes."
 Q
POSTHELP ;Extended help for 'Okay to post?'
 W !?5,"Enter YES to update the balances in the pharmacy location and DRUG file",!?5,"and add a transaction."
 W !?5,"Enter NO to abort receiving the drug."
 Q
PRICEHLP ;Extended help for 'Price per order unit'
 W !?5,"Enter the cost for each order unit."
 Q
QTYHELP ;
 W !?5,"The quantity entered will be multiplied by the dispense units",!?5,"per order unit to determine the number of dispense units received."
 Q
