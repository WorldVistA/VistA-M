PSDRFZ ;BIR/JPW,LTL-Nurse RF Delayed Dispensing review; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 ;PAT=PATIENT,PSDR=DRUG
LOOP N PSD,PSDL S (PSDL,PSDA)=0
 W !!,"Checking for any transactions since ",$$FMTE^XLFDT(PSDT,"1P")
 S PSD=PSDT
CHEC F  S PSD=$O(^PSD(58.81,"ACT",PSD)) Q:'PSD  F  S PSDL=$O(^PSD(58.81,"ACT",PSD,PSDL)) Q:'PSDL  F  S PSDA=$O(^PSD(58.81,"ACT",PSD,PSDL,PSDR,17,PSDA)) Q:'PSDA  D
 .W !!,"You may need to re-adjust the balance because of the following transaction(s)."
 .S PSDA(2)=$$FMTE^XLFDT(PSD,"2P"),PSDA(3)=PSD
 .W !!,PSDA(2),?20,$P($G(^PSD(58.81,PSDA,0)),U,6)," ",$S($P($G(^(0)),U,8)]"":$P($G(^(0)),U,8),1:$P($G(^PSDRUG(PSDR,660)),U,8))
 .W:$P($G(^PSD(58.81,PSDA,9)),U,4) " (",$P($G(^(9)),U,4)," WASTED)"
 .W:$P($G(^PSD(58.81,PSDA,3)),U,2) " (",$P($G(^(3)),U,2)," RETURNED)"
 .W "  ",$P($G(^VA(200,+$P($G(^PSD(58.81,PSDA,0)),U,7),0)),U)
 .W:$P($G(^PSD(58.81,PSDA,0)),U,16)]"" !?25,$P($G(^(0)),U,16) S PSDA(4)=$P($G(^(0)),U,7)
 .W:PSDL'=$G(NAOU) " {",$P($G(^PSD(58.8,PSDL,0)),U),"}"
 .S PSDA(1)=PSDA
END Q
