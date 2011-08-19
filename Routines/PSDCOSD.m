PSDCOSD ;BIR/LTL-Cost Report by Drugs, PSDCOST (cont'd) ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 N PSDN,LN,PG,X2 S PSDSD(1)=PSDSD S:$D(ZTQUEUED) ZTREQ="@"
 F  S PSDSD=$O(^PSD(58.81,"ACT",PSDSD)) W:$E(IOST)="C" "." Q:'PSDSD!(PSDSD>PSDED)  S PSDN=$O(^PSD(58.81,"ACT",PSDSD,0)) D:$P($G(^PSD(58.8,+PSDN,0)),U,3)=+PSDSITE
 .S PSDN(1)=$O(^PSD(58.81,"ACT",PSDSD,PSDN,0))
 .Q:'$D(LOC(+PSDN(1)))&('$G(ALL))
 .S PSDN(2)=$O(^PSD(58.81,"ACT",PSDSD,PSDN,PSDN(1),0))
 .Q:PSDN(2)<2!(PSDN(2)>5)&(PSDN(2)'=9)
 .S PSDN(3)=$S($P($G(^PSDRUG(+PSDN(1),0)),U)]"":$P($G(^(0)),U),1:"UNKNOWN DRUG #"_PSDN(1))
 .S PSDN(4)=$O(^PSD(58.81,"ACT",PSDSD,PSDN,PSDN(1),PSDN(2),0))
 .S PSDN(8)=$G(^PSD(58.81,+PSDN(4),0))
 .;get NAOU for everything including adjustments
 .S PSDN(9)=$S(PSDN(2)=9:PSDN,1:$P(PSDN(8),U,18))
 .Q:$P($G(^PSD(58.8,+PSDN(9),0)),U,2)'="N"
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
 .S PSDN(7)=$G(^TMP("PSD",$J,PSDN(3),PSDN(9)))
 .;total dispensed
 .S $P(^TMP("PSD",$J,PSDN(3),PSDN(9)),U)=$P(PSDN(7),U)+PSDN(5)
 .;DA for drug
 .S:'$P(PSDN(7),U,2) $P(^TMP("PSD",$J,PSDN(3),PSDN(9)),U,2)=PSDN(1)
 .;total returned to stock
 .S:PSDN(2)=3 $P(^TMP("PSD",$J,PSDN(3),PSDN(9)),U,3)=PSDN(5)+$P(PSDN(7),U,3)
 .;total destroyed
 .S:PSDN(2)=4 $P(^TMP("PSD",$J,PSDN(3),PSDN(9)),U,4)=PSDN(5)+$P(PSDN(7),U,4)
 .;total transferred
 .S:PSDN(2)=5 $P(^TMP("PSD",$J,PSDN(3),PSDN(9)),U,5)=-$P(PSDN(6),U,7)+$P(PSDN(7),U,5)
 .;total adjusted by NAOU
 .S:PSDN(2)=9 $P(^TMP("PSD",$J,PSDN(3),PSDN(9)),U,6)=PSDN(5)+$P(PSDN(7),U,6)
 .K PSDN
PRTQUE ;queues print after data is compiled
 I $D(ZTQUEUED) K ZTSAVE,ZTSK S ZTIO=PSDIO,ZTDESC="CS Drug Cost Report",ZTRTN="START^PSDCOSD",ZTDTH=$H,ZTSAVE("PSD*")="",ZTSAVE("^TMP(""PSD"",$J,")="",ZTSAVE("SUM")="" D ^%ZTLOAD,HOME^%ZIS G QUIT
START S (PG,PSDN)=0 D HEADER
 F  S PSDN=$O(^TMP("PSD",$J,PSDN)) Q:PSDN']""  D:$Y+6>IOSL HEADER G:$G(PSDOUT) END S PSDN(8)=$G(PSDN(8))+1 K PG(PSDN) D  G:$G(PSDOUT) END
 .W ?8,"DRUG ==> ",PSDN,!! S PSDN(1)=0
 .F  S PSDN(1)=$O(^TMP("PSD",$J,PSDN,PSDN(1))) Q:'PSDN(1)  D:$Y+6>IOSL HEADER Q:$G(PSDOUT)  S PSDN(9)=$G(PSDN(9))+1 D
 ..I $D(PG(PSDN)) W ?8,"DRUG ==> ",PSDN," (continued)",!! K PG(PSDN)
 ..W:'$G(SUM) $P($G(^PSD(58.8,+PSDN(1),0)),U),?36
 ..S PSDN(2)=$G(^TMP("PSD",$J,PSDN,PSDN(1))),PSDN(3)=$G(PSDN(3))+PSDN(2)
 ..W:'$G(SUM) $J($P(PSDN(2),U),10),?62
 ..S PSDN(11)=$P($G(^PSDRUG(+$P(PSDN(2),U,2),660)),U,6)
 ..S (X,PSDN(4))=$P(PSDN(2),U)*PSDN(11),X2="2$",PSDN(5)=$G(PSDN(5))+PSDN(4) D COMMA^%DTC W:'$G(SUM) X,!!
 ..S PSDN(10)=" (Subtracted from total)"
 ..W:'$G(SUM)&($P(PSDN(2),U,3)) "Doses Returned to Stock: ",$P(PSDN(2),U,3),PSDN(10),!!
 ..W:'$G(SUM)&($P(PSDN(2),U,4)) "Doses Destroyed: ",$P(PSDN(2),U,4),PSDN(10),!!
 ..W:'$G(SUM)&($P(PSDN(2),U,5)) "Doses Transferred: ",$P(PSDN(2),U,5),PSDN(10),!!
 ..W:'$G(SUM)&($P(PSDN(2),U,6)) "Doses Adjusted by NAOU: ",$P(PSDN(2),U,6)," (Not affecting total)",!!
 ..S:'PSDN(11) ^TMP("PSDM",$J,PSDN)=""
 .Q:$G(PSDOUT)  W LN,!?28,"Total:  ",$J($G(PSDN(3)),10),?62
 .S X=$G(PSDN(5)) D COMMA^%DTC W X,!! S PSDN(6)=$G(PSDN(6))+PSDN(3)
 .S PSDN(7)=$G(PSDN(7))+PSDN(5) K PSDN(3),PSDN(5),PSDN(9)
 I $G(PSDN(8))>1 W LN,!?14,"Total for all NAOUs:  ",$J($G(PSDN(6)),10) S X=$G(PSDN(7)) D COMMA^%DTC W ?62,X,!!
 I $D(^TMP("PSDM",$J)) S ZTRTN="^PSDCOSM",ZTIO="",ZTDTH=$H,ZTDESC="Mailman notification of 0 DRUG file cost",ZTSAVE("PSD*")="",ZTSAVE("^TMP(""PSDM"",$J,")="" D ^%ZTLOAD,HOME^%ZIS
 W:'$O(^TMP("PSD",$J,0)) !!,"Sorry, nothing to report for selected drug(s).",!!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'$G(PSDOUT) W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
QUIT K ^TMP("PSD",$J),^TMP("PSDM",$J),IO("Q") Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",80)="",PG=PG+1,PG(PSDN)="" W !?2,PSDCHO(1)," From "
 W $P(PSDATE,U)," To ",$P(PSDATE,U,2),?72,"Page ",PG,!!
 W ?45,"Report Date:  ",PSDT(1),!!?40,"Quantity",!,"NAOU",?40,"Dispensed"
 W ?70,"Cost",!,LN,!!
