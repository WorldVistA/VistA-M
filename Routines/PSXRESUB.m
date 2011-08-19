PSXRESUB ;BIR/HTW-Resubmit an Rx to the CMOP ;03/11/99  1:14 PM
 ;;2.0;CMOP;**3,20,21,41**;11 Apr 97
 ;Reference to ^PSRX (File #52) supported by DBIA #1977
 ;Reference to routine PSOCMOP supported by DBIA #2476
 I '$D(^XUSEC("PSXRESUB",DUZ)) W !,"You are not authorized to use this option." Q
 W !!,"CMOP Prescription Resubmission Utility",!!
TOP S LAST=0
 S DIR(0)="FO^1:15",DIR("A")="Enter the Rx # to resubmit"
 S DIR("?")="Enter the prescription number you want to send back to the CMOP to be dispensed."
 D ^DIR K DIR I $D(DIRUT) G END
 S RX=Y K Y
 S I52=$O(^PSRX("B",RX,"")) I $G(I52)']"" W !,"Rx # "_RX_" either does not exist or is an invalid #." D END G PSXRESUB
 ;      Check for CMOP nodes
 I '$D(^PSRX(I52,4)) W !,"There have been no CMOP transmissions for this Rx.  You can not Resubmit it!",! D END G PSXRESUB
 ;      Get last OP refill
 I $D(^PSRX(I52,1)) F I=0:0 S I=$O(^PSRX(I52,1,I)) Q:'I  S RF=I
 ;      Get last CMOP event entry marked as Not Dispensed
 F CT=0:0 S CT=$O(^PSRX(I52,4,CT)) Q:'CT  D
 .S NODE=$G(^PSRX(I52,4,CT,0))
 .S CHECK=$P($G(NODE),"^",3) Q:$P($G(NODE),"^",4)'=3
 .;      S PSX(FILL#)=RESUBMIT #
 .S PSX($P($G(NODE),"^",3))=$P($G(NODE),"^",6)_"^"_CT,LAST=$P($G(NODE),"^",3)
 ;      If the last CMOP '= the last OP Quit
 I $G(RF)>$G(LAST) W !!,"This Rx cannot be resubmitted.  A later fill has already been entered." D END G TOP
 I $G(CHECK)>$G(LAST) W !!,"This Rx cannot be resubmitted.  A later fill has already been transmitted to the CMOP." D END G TOP
 I $P($G(^PSRX(I52,2)),"^",6)<DT W !!,"This prescription has expired. You cannot resubmit it." D END G TOP
 I $G(PSX(LAST))["Y" W !!,"This Rx has already been resubmitted the maximum allowable times. You cannot resubmit it." D END G TOP
 I $G(PSX(LAST))']"" W !!,"This Rx is not eligible for resubmission.",!,"The last fill must have a status of 'NOT DISPENSED'.",! D END G TOP
 I $G(PSX(LAST))=3,($G(^PSRX(I52,4,LAST,1))["DUPLICATE") W !!,"This Rx is not eligible for resubmission.",!,"The last fill has been returned as a duplicate.",! D END G TOP
 I LAST>0 I '$D(^PSRX(I52,1,LAST,0)) W !!,"This RX is not eligible for resubmission.",!,"The fill # "_LAST_" appears to have been canceled.",! D END G TOP ;*41
 W !!,"You have chosen Rx # "_RX_" to be resubmitted to the CMOP."
 S DIR("A")="Do you want to continue? ",DIR("B")="NO"
 S DIR(0)="SB^Y:YES;N:NO",DIR("?")="Enter Y if you want to send the selected prescription to the CMOP."
 D ^DIR K DIR I $D(DIRUT)!("Nn"[$E(Y)) D END G TOP
 I $G(PSOSITE)]"" S PSXSITEA=$G(PSOSITE)
 S PSOSITE=$S(LAST=0:$P(^PSRX(I52,2),"^",9),1:$P(^PSRX(I52,1,LAST,0),"^",9))
 D NOW^%DTC N ZD
 S PPL=I52,ZD(I52)=% D TEST^PSOCMOP
 I $G(PPL)']"" S $P(^PSRX(I52,4,$P(PSX(LAST),"^",2),0),"^",6)="Y"
 I $G(PPL)]"" W !!,"This is not a CMOP Rx.  Make sure the last fill has a Mail routing, the drug is marked for CMOP, etc...",!!
 I $G(PSXSITEA)]"" S PSOSITE=PSXSITEA
 D END G TOP
END K CHECK,CT,DIR,DIROUT,DIRUT,I52,LAST,NODE,PSX,PSXPPL,PPL,RF,RX,X,Y,ZD,%
 K PSXSITEA
 Q
