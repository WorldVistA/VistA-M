PSDADJW ;BIR/LTL-Review Adjustment Transactions for a Drug; 2 Nov 94 [ 11/02/94  12:19 PM ]
 ;;3.0; CONTROLLED SUBSTANCES ;**32**;13 Feb 97
 ;
 ; Reference to ^PSD(58.81 supported by DBIA # 2808
 ;
START ;compiles and prints output
 N LN,JJ,KK,NN,PSDR,PG S (PG,PSDOUT)=0 D HEADER
LOOP F  S PSDT=$O(^PSD(58.81,"ACT",PSDT)) Q:'PSDT!(PSDT>PSDTB(1))  F JJ=0:0 S JJ=$O(^PSD(58.81,"ACT",PSDT,JJ)) Q:'JJ  D:JJ=PSDLOC  G:PSDOUT END
 .F KK=0:0 S KK=$O(^PSD(58.81,"ACT",PSDT,JJ,KK)) Q:'KK  F NN=0:0 S NN=$O(^PSD(58.81,"ACT",PSDT,JJ,KK,9,NN)) Q:'NN  D
 ..S PSDR=KK
 ..Q:'$D(PSDA(+PSDR))
 ..S PSDR(1)=NN
 ..S PSDR(2)=$G(^PSD(58.81,NN,0))
 ..D:$Y+7>IOSL HEADER Q:PSDOUT
 ..W !,$$FMTE^XLFDT($E($P(PSDR(2),U,4),1,12),"2P"),?18,PSDA(PSDR)
 ..W ?61,$J($P(PSDR(2),U,6),6),?69,$P(PSDR(2),U,16),?116
 ..W $E($P($G(^VA(200,+$P(PSDR(2),U,7),0)),U),1,16),!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",80)="",PG=PG+1 W !,"Adjustments from ",PSDTB(2)," to ",PSDTB(3),?70,"PAGE: ",PG,!,LN,!?2,"Date",?18,"Drug",?64,"QTY",?69,"Reason",?116,"Pharmacist",!,LN,!
 Q
