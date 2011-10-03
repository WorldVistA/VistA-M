PSDORSU ;BIR/JPW,LTL-Nurse Order Stats Report ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 W !!,"You are about to adjust the balance upward.",!!
 W "Before you do, let's check to see if there are any orders that need receiving."
 N AOU,STAT,ORD S STAT=3
 S:'$G(NAOU) NAOU=PSDLOC
 S AOU=NAOU,ORD=0
 S:$G(PSDRUG) PSDR=PSDRUG
ORD ;order loop
 S:'$D(^XUSEC("PSJ RNURSE",DUZ))&('$D(^XUSEC("PSD NURSE",DUZ))) STAT(1)=1
 F  S ORD=$O(^PSD(58.8,"AC",STAT,NAOU,PSDR,ORD)) Q:'ORD  D  Q:$D(DIRUT)!($G(PSDOUT))
 .S ORD(1)=$G(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)),PSDA=$P(ORD(1),U,17)
 .W !!,"Pharmacy Dispensing #: ",$P(ORD(1),U,16)
 .W "  Date/time ordered: ",$$FMTE^XLFDT($P(ORD(1),U,2),"2P")
 .W "  Quantity: ",$P(ORD(1),U,6)
 .Q:$G(STAT(1))
 .S DIR(0)="Y",DIR("A")="Receive now" W ! D ^DIR K DIR
 .S:$D(DIRUT) PSDOUT=1 Q:Y'=1
 .S Y(0)=$G(^PSD(58.81,+PSDA,0)) D ORD^PSDNRGO
 Q
