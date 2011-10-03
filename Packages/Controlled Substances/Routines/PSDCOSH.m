PSDCOSH ;BIR/LTL-Cost Report by High Cost, PSDCOST (cont'd) ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 N PSDN,LN,PG,X2 S PSDSD(1)=PSDSD S:$D(ZTQUEUED) ZTREQ="@"
 F  S PSDSD=$O(^PSD(58.81,"ACT",PSDSD)) W:$E(IOST)="C" "." Q:'PSDSD!(PSDSD>PSDED)  S PSDN=$O(^PSD(58.81,"ACT",PSDSD,0)) D:$P($G(^PSD(58.8,+PSDN,0)),U,3)=+PSDSITE
 .S PSDN(1)=$O(^PSD(58.81,"ACT",PSDSD,PSDN,0))
 .S PSDN(2)=$O(^PSD(58.81,"ACT",PSDSD,PSDN,PSDN(1),0))
 .Q:PSDN(2)<2!(PSDN(2)>5)&(PSDN(2)'=9)
 .S PSDN(3)=$P($G(^PSDRUG(+PSDN(1),0)),U)
 .S PSDN(4)=$O(^PSD(58.81,"ACT",PSDSD,PSDN,PSDN(1),PSDN(2),0))
 .S PSDN(8)=$G(^PSD(58.81,+PSDN(4),0))
 .Q:'$D(LOC(+$P(PSDN(8),U,18)))&(PSDN(2)'=9)!('$D(LOC(+PSDN))&(PSDN(2)=9))
 .;get NAOU for everything including adjustments
 .S PSDN(9)=$S(PSDN(2)=9:PSDN,1:$P(PSDN(8),U,18))
 .;qty rec'd by NAOU w/green sheet
 .S PSDN(5)=$P($G(^PSD(58.81,+PSDN(4),1)),U,8)
 .;qty dispensed by Master Vault w/o green sheet
 .S:$P(PSDN(8),U,17)']"" PSDN(5)=$P(PSDN(8),U,6)
 .;Returned to Stock
 .S:PSDN(2)=3 PSDN(5)=-$P($G(^PSD(58.81,+PSDN(4),3)),U,2)
 .;Destroyed
 .S:PSDN(2)=4 PSDN(5)=-$P($G(^PSD(58.81,+PSDN(4),3)),U,5)
 .;include transfer ins with dispensed
 .S:PSDN(2)=5 PSDN(2)=2
 .;Check for transfers
 .S PSDN(6)=$G(^PSD(58.81,+PSDN(4),7))
 .D:$P(PSDN(6),U)>PSDSD(1)&($P(PSDN(6),U)<PSDED)
 ..S PSDN(5)=PSDN(5)-$P(PSDN(6),U,7),PSDN(2)=5
 .S PSDN(7)=$G(^TMP("PSD",$J,PSDN(3)))
 .;total dispensed
 .S $P(^TMP("PSD",$J,PSDN(3)),U)=$P(PSDN(7),U)+PSDN(5)
 .;total cost
 .S $P(^TMP("PSD",$J,PSDN(3)),U,2)=$P(^TMP("PSD",$J,PSDN(3)),U,2)+($P($G(^PSDRUG(+PSDN(1),660)),U,6)*PSDN(5))
 .K PSDN
PRTQUE ;queues print after data is compiled
 I $D(ZTQUEUED) K ZTSAVE,ZTSK S ZTIO=PSDIO,ZTDESC="CS High Cost Report",ZTRTN="START^PSDCOSH",ZTDTH=$H,ZTSAVE("PSD*")="",ZTSAVE("^TMP(""PSD"",$J,")="",ZTSAVE("ALL")="",ZTSAVE("LOC(")="" D ^%ZTLOAD,HOME^%ZIS G QUIT
START S (PG,PSDN)=0 D HEADER
 D:PSD(1)=1
 .F  S PSDN=$O(^TMP("PSD",$J,PSDN)) Q:PSDN!(PSDN']"")  S PSDN(1)=$G(^TMP("PSD",$J,PSDN)) D:$P(PSDN(1),U,2)>PSD
 ..S ^TMP("PSD",$J,999999999-$P(PSDN(1),U,2))=$P(PSDN(1),U)_U_$P(PSDN(1),U,2)_U_PSDN
 F  S PSDN=$O(^TMP("PSD",$J,PSDN)) Q:(PSD(1)=1&('PSDN))!(PSDN']"")  D:$Y+6>IOSL HEADER G:$G(PSDOUT) END D  G:$G(PSDOUT) END
 .S PSDN(1)=$G(^TMP("PSD",$J,PSDN))
 .Q:PSD(1)=2&($P(PSDN(1),U,2)'>PSD)
 .W $E($S(PSDN:$P(PSDN(1),U,3),1:PSDN),1,34),?36
 .W $J($P(PSDN(1),U),10),?62
 .S X=$P(PSDN(1),U,2),X2="2$" D COMMA^%DTC W X,!!
 W:'$O(^TMP("PSD",$J,0)) !!,"Sorry, nothing to report for selected NAOU(s).",!!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'$G(PSDOUT) W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
QUIT K ^TMP("PSD",$J),IO("Q") Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",80)="",PG=PG+1 W !?2,PSDCHO(1)," From "
 W $P(PSDATE,U)," To ",$P(PSDATE,U,2),?72,"Page ",PG,!!
 S PSD(2)=$O(LOC(0)) W "For " W:$G(ALL) "ALL NAOU(s)"
 W:'$O(LOC(PSD(2)))&('$G(ALL)) $P($G(^PSD(58.8,+$O(LOC(0)),0)),U)
 I $O(LOC(PSD(2))),'$G(ALL) W "The Following NAOU(s):  " D
 .S PSD(2)=0 F  S PSD(2)=$O(LOC(PSD(2))) Q:'PSD(2)  W $P($G(^PSD(58.8,+PSD(2),0)),U),!?28
 W ?45,"Report Date:  ",PSDT(1),!!?40,"Quantity",!,"Drug",?40,"Dispensed"
 W ?70,"Cost",!,LN,!!
