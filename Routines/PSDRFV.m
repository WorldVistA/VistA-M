PSDRFV ;BIR/JPW,LTL-Nurse RF Dispensing review; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**5,12,25,27**;13 Feb 97
 ;Reference to ^PSD(58.8 are covered by DBIA #2711
 ;Reference to ^PSD(58.81 are covered by DBIA #2808
 ;Reference to ^PSDRUG( are covered by DBIA #221
 ; Reference to VA(200 DBIA # 10060
 ;
 ;PAT=PATIENT,PSDR=DRUG
LOOP N PSD,PSDL S (PSDL,PSDA,PSDT)=0
 W !!,"Doses signed out in the last ",$S($G(NAOU(1)):NAOU(1),1:"eight")," hours:"
 S PSDT=$$FMADD^XLFDT($$NOW^XLFDT,0,-$S($G(NAOU(1)):NAOU(1),1:8))
CHEC ;PSD*3*27 (DAVE B - Do not need to look at every ward - PSDL)
 S PSDL=$G(NAOU)
 F  S PSDT=$O(^PSD(58.81,"ACT",PSDT)) Q:'PSDT  F  S PSDA=$O(^PSD(58.81,"ACT",PSDT,PSDL,PSDR,17,PSDA)) Q:'PSDA  D:$P($G(^PSD(58.81,PSDA,9)),U)=$G(PAT)
 .S PSDA(2)=$$FMTE^XLFDT(PSDT,"2P"),PSDA(3)=PSDT
 .W !!,PSDA(2),?22,$P($G(^PSD(58.81,PSDA,0)),U,6)," ",$S($P($G(^(0)),U,8)]"":$P($G(^(0)),U,8),1:$P($G(^PSDRUG(PSDR,660)),U,8))
 .W:$P($G(^PSD(58.81,PSDA,9)),U,4) " (",$P($G(^(9)),U,4)," WASTED)"
 .W:$P($G(^PSD(58.81,PSDA,3)),U,2) " (",$P($G(^(3)),U,2)," RETURNED)"
 .W "  ",$P($G(^VA(200,+$P($G(^PSD(58.81,PSDA,0)),U,7),0)),U)
 .W:$P($G(^PSD(58.81,PSDA,0)),U,16)]"" !?25,$P($G(^(0)),U,16) S PSDA(4)=$P($G(^(0)),U,7)
 .S PSDA(1)=PSDA
END Q
