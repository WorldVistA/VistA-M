PSDSP ;BIR/JPW-Check for Disp Site - one or more ; 27 Jul 92
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
EN S CNT=0 F LOC="M","S" F JJ=0:0 S JJ=$O(^PSD(58.8,"ASITE",+PSDSITE,LOC,JJ)) Q:'JJ  S CNT=CNT+1,LOC(CNT)=JJ
 I '$D(LOC(1)) W !!,"Please contact your Pharmacy Coordinator.",!,"You have not defined a pharmacy Dispensing Site",!! G END
 S:'$D(LOC(2)) PSDS=+LOC(1),PSDSN=$P($G(^PSD(58.8,+PSDS,0)),"^")
END K CNT,JJ,LOC
