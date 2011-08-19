PSDOPTZ ;BIR/LTL-Review OP Transactions by Rx # ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 S PSDRX=PSDRX(4)-1,(PSD,PSDU)=0
 F  S PSD=$O(^TMP("PSD",$J,PSD)) Q:PSD']""  F  S PSDU=$O(^TMP("PSD",$J,PSD,PSDU)) Q:PSDU']""  S PSDU(1)=$O(^TMP("PSD",$J,PSD,PSDU,0)) D  G:PSDOUT END S PSDRX=PSDRX(4)-1,PSDT(1)=0
LOOP .F  S PSDRX=$O(^PSD(58.81,"AOP",PSDRX)) W:$E(IOST)="C" "." Q:'PSDRX!(PSDRX>PSDRX(2))  S PSDRX(5)=0 F  S PSDRX(5)=$O(^PSD(58.81,"AOP",PSDRX,PSDRX(5))) Q:'PSDRX(5)  D  Q:PSDOUT
 ..S PSDR(2)=$G(^PSD(58.81,PSDRX(5),0))
 ..Q:$P(PSDR(2),U,3)'=PSDLOC!($P(PSDR(2),U,5)'=PSDU(1))
 ..S PSDR(4)=$G(^PSD(58.81,PSDRX(5),6))
 ..D:$Y+6>IOSL HEADER Q:PSDOUT
 ..S PSDT(1)=$G(PSDT(1))+1 W:PSDT(1)=1 !,PSDU,?60,PSD,!
 ..S Y=$E($P(PSDR(2),U,4),1,12) X ^DD("DD") W !,Y,?19
 ..S DFN=$P($G(^PSRX(+$P(PSDR(4),U),0)),U,2)
 ..N C S Y=DFN,C=$P(^DD(58.81,73,0),U,2) D Y^DIQ
 ..W $P(PSDR(4),U,5),?28,Y
 ..D PID^VADPT6 W " ("_VA("BID")_")",?60
 ..I $P(PSDR(4),U,2) S Y=$P($G(^PSRX(+$P(PSDR(4),U),1,+$P(PSDR(4),U,2),0)),U,18) X ^DD("DD") W Y
 ..I $P(PSDR(4),U,4) S Y=$P($G(^PSRX(+$P(PSDR(4),U),"P",+$P(PSDR(4),U,4),0)),U,19) X ^DD("DD") W Y
 ..I '$P(PSDR(4),U,2)&('$P(PSDR(4),U,4)) S Y=$P($G(^PSRX(+$P(PSDR(4),U),2)),U,13) X ^DD("DD") W Y
 ..W !,"Qty: ",$P(PSDR(2),U,6),"  Bal: ",$P(PSDR(2),U,10)-$P(PSDR(2),U,6),?22,"RPH=> ",$P($G(^VA(200,+$P(PSDR(2),U,7),0)),U),?60
 ..W $S($P(PSDR(4),U,2):"Refill #"_$P(PSDR(4),U,2),$P(PSDR(4),U,4):"Partial #"_$P(PSDR(4),U,4),1:"Original")
 ..W !,LN,!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 D KVAR^VADPT K IO("Q"),VA("PID"),VA("BID"),^TMP("PSD",$J)
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1 W !,"Outpatient Activity from Rx # ",PSDRX(1)," to Rx # ",PSDRX(3),?70,"PAGE: ",PG,!,LN,!,"Date Posted",?19,"Rx#",?28,"Patient",?60,"Date Released",!,LN W:$G(PSDT(1)) !,PSDU," (continued)",!
