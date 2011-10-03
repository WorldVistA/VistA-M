PSOREF ;BIR/SAB-refill data entry ;4/25/07 8:45am
 ;;7.0;OUTPATIENT PHARMACY;**1,23,27,36,46,78,130,131,148,206**;DEC 1997;Build 39
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 ;
EOJ ;
 K PSOMSG,PSOREF,PSORX("BAR CODE"),PSOLIST,LFD,MAX,MIN,NODE,PS,PSOERR,REF,RF,RXO,RXN,RXP,RXS,SD,VAERR,PSORX("FILL DATE")
 D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2))
 Q
OERR ;single refil
 I $$LMREJ^PSOREJU1($P(PSOLST(ORN),"^",2),,.VALMSG,.VALMBCK) Q
 I $D(RXRP($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="A Reprint Label has been requested!" Q
 I $D(RXPR($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="A Partial has already been requested!" Q
 I $D(RXRS($P(PSOLST(ORN),"^",2))) S VALMBCK="",VALMSG="Rx is being pulled from suspense!" Q
 I $D(RXFL($P(PSOLST(ORN),"^",2))) S PTRX=$P(PSOLST(ORN),"^",2) D ^PSOCMOPT I '$G(PSOXFLAG) K PSOXFLAG S VALMBCK="",VALMSG="Fill already requested for CMOP!" Q
 K PSOXFLAG
 D PSOL^PSSLOCK($P(PSOLST(ORN),"^",2)) I '$G(PSOMSG) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG Q
 N RXN K PSORX("FILL DATE") D FULL^VALM1 S:$G(PSOFROM)'="NEW" PSOFROM="REFILL" S PSOREF("DFLG")=0,PSOREF("IRXN")=$P(PSOLST(ORN),"^",2),PSOREF("QFLG")=0
 K PSOID D ^PSOREF1 I PSOREF("DFLG") D EOJ S VALMBCK="R" Q
 D ^PSOREF0
 W ! K DIR,DIRUT,DTOUT,DUOUT S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,DIRUT,DTOUT,DUOUT S PSORXED=1 D ^PSOBUILD,ACT^PSOORNE2 K PSORXED S VALMBCK="Q" D EOJ
 Q
SPEED ;speed refill
 K LST,PSORX("FILL DATE") N VALMCNT I '$G(PSOCNT) S VALMSG="This patient has no Prescriptions!" S VALMBCK="" Q
 K DIR,DIRUT S DIR(0)="Y",DIR("B")="NO",DIR("A")="Barcode Refill",DIR("?")="If you want to use a barcode reader to process refills enter 'Y'."
 D ^DIR K DIR,DUOUT,DTOUT I $D(DIRUT) S VALMBCK="" Q
 G BCREF:Y
 K PSOREF,PSOFDR,DIR,DUOUT,DIRUT S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT S VALMBCK="" Q
 K DIR,DIRUT,DTOUT,PSOOELSE,DTOUT I +Y S (ASK,SPEED,PSOOELSE)=1 D FULL^VALM1 S LST=Y D  G:$G(PSOREF("DFLG"))!($G(PSOREF("QFLG"))) SPEEDX
 .F ORD=1:1:$L(LST,",") Q:$P(LST,",",ORD)']""!($G(PSOREF("QFLG")))  S ORN=$P(LST,",",ORD) D:+PSOLST(ORN)=52
 ..I $$LMREJ^PSOREJU1($P(PSOLST(ORN),"^",2)) W $C(7),!!,"Rx "_$$GET1^DIQ(52,$P(PSOLST(ORN),"^",2),.01)_" has OPEN/UNRESOLVED 3rd Party Payer Reject!" K DIR D PAUSE^VALM1 Q
 ..D PSOL^PSSLOCK($P(PSOLST(ORN),"^",2)) I '$G(PSOMSG) W $C(7),!!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing Rx "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^")),! D PAUSE^VALM1 K PSOMSG Q
 ..K PSOMSG I $D(RXRP($P(PSOLST(ORN),"^",2))) W $C(7),!!,"A Reprint Label has been requested!" D ULK D PAUSE^VALM1 Q
 ..I $D(RXPR($P(PSOLST(ORN),"^",2))) W $C(7),!!,"A Partial has already been requested!" D ULK D PAUSE^VALM1 Q
 ..I $D(RXFL($P(PSOLST(ORN),"^",2))) S PTRX=$P(PSOLST(ORN),"^",2) D ^PSOCMOPT I '$G(PSOXFLAG) K PSOXFLAG W $C(7),!!,"A CMOP fill has already been requested for Rx "_$P($G(^PSRX($P(PSOLST(ORN),"^",2),0)),"^") D ULK D PAUSE^VALM1 Q
 ..K PSOXFLAG I $D(RXRS($P(PSOLST(ORN),"^",2))) W $C(7),!!,"Rx is being pulled from suspense!" D ULK D PAUSE^VALM1 Q
 ..I $P($G(^PSRX($P(PSOLST(ORN),"^",2),"STA")),"^")=11 D  D ULK Q
 ...W $C(7),!!?5,"RX "_$P($G(^PSRX($P(PSOLST(ORN),"^",2),0)),"^")_" is in an EXPIRED status." W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 ..S PSOREF("IRXN")=$P(PSOLST(ORN),"^",2) I ASK D ^PSOREF1 S ASK=0 D:$G(PSOREF("QFLG")) ULK Q:$G(PSOREF("QFLG"))
 ..N RXN D FULL^VALM1 S:$G(PSOFROM)'="NEW" PSOFROM="REFILL" S PSOREF("DFLG")=0,PSOREF("IRXN")=$P(PSOLST(ORN),"^",2)
 ..I PSOREF("DFLG") D EOJ S VALMBCK="R" Q
 ..D ^PSOREF0 D ULK
 S:'$G(PSOOELSE) VALMBCK=""
 S PSORXED=1 D ^PSOBUILD,BLD^PSOORUT1
SPEEDX K PSOREF,PSORX("BAR CODE"),PSOLIST,LFD,MAX,MIN,NODE,PS,PSOERR,REF,RF,RXO,RXN,RXP,RXS,SD,VAERR,PSORX("FILL DATE")
 K LST,SPEED,PSORXED,PSOREF,PSOFDR,PSOOELSE,ASK S:'$D(VALMBCK) VALMBCK="R"
 K PSORX("FILL DATE"),PSORX("MAIL/WINDOW"),PSORX("METHOD OF PICK-UP")
 Q
BCREF ;barcode refills
 K LST,DIR,DIRUT,DUOUT,DTOUT D FULL^VALM1
ASK S DIR(0)="FO^5:245^K:X'?3N1""-""1.N X",DIR("A")="WAND BARCODE"
 S DIR("?",1)="Wand the barcoded number of the prescription to be processed."
 S DIR("?",2)="The number should be of the form NNN-NNNNNN",DIR("?",3)="where the number before the dash is your station number."
 S DIR("?")="Enter ""^"", or a RETURN to quit."
 D ^DIR I $D(DUOUT)!($D(DTOUT)) S VALMBCK="" G BCREFX
 I $G(X)']"",'$G(LST) S VALMBCK="" G BCREFX
 I $D(DIRUT),+$G(LST) D  S VALMBCK="R" G BCREFX
 .K DIR,DIRUT,DTOUT,PSOOELSE,DTOUT
 .S (BCREF,ASK,SPEED,PSOOELSE)=1 D FULL^VALM1 D
 ..F ORD=1:1:$L(LST,",") Q:$P(LST,",",ORD)']""!($G(PSOREF("QFLG")))  S ORN=$P(LST,",",ORD) D:+PSOLST(ORN)=52
 ...I $$LMREJ^PSOREJU1($P(PSOLST(ORN),"^",2)) W $C(7),!!,"Rx "_$$GET1^DIQ(52,$P(PSOLST(ORN),"^",2),.01)_" has OPEN/UNRESOLVED 3rd Party Payer Reject!" K DIR D PAUSE^VALM1 Q
 ...D PSOL^PSSLOCK($P(PSOLST(ORN),"^",2)) I '$G(PSOMSG) W $C(7),!!,$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing Rx "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^")),! D PAUSE^VALM1 K PSOMSG Q
 ...K PSOMSG I $D(RXRP($P(PSOLST(ORN),"^",2))) W $C(7),!!,"A Reprint Label has been requested for Rx "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^"),! D ULK D PAUSE^VALM1 Q
 ...I $D(RXPR($P(PSOLST(ORN),"^",2))) W $C(7),!!,"A Partial has already been requested for Rx "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^"),! D ULK D PAUSE^VALM1 Q
 ...I $D(RXFL($P(PSOLST(ORN),"^",2))) S PTRX=$P(PSOLST(ORN),"^",2) D ^PSOCMOPT I '$G(PSOXFLAG) K PSOXFLAG W $C(7),!!,"A CMOP fill has already been requested for Rx "_$P($G(^PSRX($P(PSOLST(ORN),"^",2),0)),"^") D ULK D PAUSE^VALM1 Q
 ...K PSOXFLAG I $D(RXRS($P(PSOLST(ORN),"^",2))) W $C(7),!!,"Rx "_$P(^PSRX($P(PSOLST(ORN),"^",2),0),"^")_" is being pulled from suspense!" D ULK D PAUSE^VALM1 Q
 ...S PSOREF("IRXN")=$P(PSOLST(ORN),"^",2) I ASK D ^PSOREF1 S ASK=0 D:$G(PSOREF("DFLG")) ULK Q:$G(PSOREF("DFLG"))
 ...N RXN D FULL^VALM1 S:$G(PSOFROM)'="NEW" PSOFROM="REFILL" S PSOREF("DFLG")=0,PSOREF("IRXN")=$P(PSOLST(ORN),"^",2)
 ...I PSOREF("DFLG") D EOJ S VALMBCK="R" Q
 ...D ^PSOREF0 D ULK
 F RX=1:1:PSOCNT I $P(PSOLST(RX),"^",2)=$P(X,"-",2) D  Q
 .I $D(PSOBBC(RX)) Q
 .S LST=$G(LST)_RX_",",PSOBBC(RX)=1
 G ASK
BCREFX K BCREF,ASK,LST,SPEED,RX,PSOBBC,DIR,DIRUT,PSORXED,PSOREF,PSOFDR,PSOOELSE S PSORXED=1 D ^PSOBUILD,BLD^PSOORUT1
 S VALMBCK="R" Q
REFILL(PLACER) ;passes flag to CPRS for front door refill request
 ;PLACER=PHARMACY NUMBER
 N PSORFRM,PSOLC,PSODRG,PSODRUG0,RXN,ST,PSODEA
 I $G(PLACER)["S"!('$G(PLACER)) Q "-1^Not a Valid Outpatient Medication Order."
 S RXN=PLACER I '$D(^PSRX(RXN,0)) Q "-1^Not a Valid Outpatient Medication Order."
 S RX0=^PSRX(RXN,0),PSODRG=$P(^PSRX(RXN,0),"^",6),ST=+^("STA"),PSODRUG0=^PSDRUG(PSODRG,0),PSODEA=$P($G(^(0)),"^",3),DIV=$P(^PSRX(RXN,2),"^",9),PSORFRM=$P(RX0,"^",9)
 I PSODEA["2" Q "0^Schedule 2 Drug. Order cannot be refilled."
 I '$P($G(^PSRX(RXN,"OR1")),"^"),'$P($G(^PSDRUG(PSODRG,2)),"^") Q "0^Cannot Refill. Drug not matched to a Pharmacy Orderable Item."
 I '$P($G(^PSRX(RXN,"OR1")),"^"),$P($G(^PSDRUG(PSODRG,2)),"^") S $P(^PSRX(RXN,"OR1"),"^")=$P(^PSDRUG(PSODRG,2),"^")
 S CLOZPAT=$S($P($G(^PSDRUG(PSODRG,"CLOZ1")),"^")="PSOCLO1":1,1:0)
 I 'CLOZPAT I PSODEA["A"&(PSODEA'["B")!(PSODEA["F")!(PSODEA[1)!(PSODEA[2) Q "0^"_$S(PSODEA["A":"Narcotic Drug. ",1:"")_"Order Non-Refillable."
 K CLOZPAT I DT>$P($G(^PSRX(RXN,2)),"^",6) Q "0^Non-Refillable.  Prescription has Expired."
 I $P(^PSRX(RXN,3),"^",2)>$P(^PSRX(RXN,2),"^",6) Q "0^Next Refill Date Past Expiration Date.  New Order Required."
 I '$P($G(^PS(59,DIV,1)),"^",11),$G(^PSDRUG(PSODRG,"I"))]"",DT>$G(^("I")) Q "0^Inactive Drug, Non Refillable."
 I ST Q "0^Prescription is in a Non-Refillable Status."
 I $P($G(^PSDRUG(PSODRG,2)),"^",3)'["O" Q "0^Cannot Refill. Drug No Longer Used by Outpatient Pharmacy."
 S PSORFRM=$P(RX0,"^",9) F PSOJ=0:0 S PSOJ=$O(^PSRX(RXN,1,PSOJ)) Q:'PSOJ  S PSORFRM=PSORFRM-1
 I PSORFRM<1 Q "0^No Refills remaining. New Med order required."
 I $P(^PSRX(RXN,3),"^"),DT=$P(^PSRX(RXN,3),"^") Q "0^Can't Refill, Fill Date already exists for "_$E($P(^PSRX(RXN,3),"^"),4,5)_"/"_$E($P(^PSRX(RXN,3),"^"),6,7)_"/"_$E($P(^PSRX(RXN,3),"^"),2,3)_"."
 I $P(^PSRX(RXN,3),"^"),DT<$P(^PSRX(RXN,3),"^") Q "0^Can't Refill, later Refill Date already exists for "_$E($P(^PSRX(RXN,3),"^"),4,5)_"/"_$E($P(^PSRX(RXN,3),"^"),6,7)_"/"_$E($P(^PSRX(RXN,3),"^"),2,3)_"."
 I $O(^PS(52.41,"ARF",RXN,0)) Q "0^Pending Refill Request already exists."
 Q 1
 ;
ULK D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2))
 Q
