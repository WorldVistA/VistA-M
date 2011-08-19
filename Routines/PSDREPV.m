PSDREPV ;BIR/LTL-Review PV Receipt Transactions ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**18**;13 Feb 97
 ;
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to ^PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 N C,D,DIC,DIR,DIRUT,DTOUT,DUOUT,PSD,PSDL,PSDEV,PSDOUT,X,Y
 D DT^DICRW
 S DIR(0)="Y",DIR("A")="Would you like to select a date range"
 S DIR("B")="No",DIR("?")="If you select a date range, I'll show all invoices for that range." D ^DIR K DIR G:Y<0 END G:Y ^PSDREPD
 S DIC="^PSD(58.81,",DIC(0)="AEQ",D="PV",DIC("A")="Please select Prime Vendor Invoice number: " W ! D IX^DIC K DIC S PSD=+Y,PSD(2)=$P($G(^PSD(58.81,+Y,8)),U) I Y<0 S PSDOUT=1 G END
 I PSD(2)']"" W !!,"No Prime Vendor Invoice for this transaction." S PSDOUT=1 G END
DEV ;(PSD*3*18) Changed %ZIS( call to fileman - SQA.
 ;S PSDEV=$P($G(^%ZIS(1,+$P($G(^PSD(58.8,+$S($G(PSDLOC):PSDLOC,1:$P($G(^PSD(58.81,+Y,0)),U,3)),2)),U,9),0)),U)
 S X="`"_+$P($G(^PSD(58.8,+$S($G(PSDLOC):PSDLOC,1:$P($G(^PSD(58.81,+Y,0)),"^",3)),2)),U,9)
 S DIC=3.5,DIC(0)="" D ^DIC S PSDEV=$P($G(Y),"^",2) ; IA # 10114
 ;asks device and queueing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" S PSDOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDREPV",ZTDESC="Invoice receipt review",ZTSAVE("PSD*")="" D ^%ZTLOAD,HOME^%ZIS S PSDOUT=1 G END
START ;compiles and prints output
 N %DT,LN,PG,RPDT S (PG,PSDOUT,PSD(1))=0,Y=DT X ^DD("DD") S RPDT=Y
 D HEADER
LOOP F  S PSD(1)=$O(^PSD(58.81,"PV",PSD(2),PSD(1))) Q:'PSD(1)  G:$G(PSDOUT) END D:$Y+5>IOSL HEADER G:PSDOUT END S PSD(3)=$G(^PSD(58.81,+PSD(1),0)) D
 .I '$G(PSDLOC) S PSDLOC=$P(PSD(3),U,3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+PSDLOC,0)),U),!
 .I $G(PSDLOC)'=$P(PSD(3),U,3),$P(PSD(3),U,3) S PSDL(PSD(1))=PSD(3) Q
 .S Y=+$E($P(PSD(3),U,4),1,12) X ^DD("DD") W !,Y,"  "
 .W $E($P($G(^PSDRUG(+$P(PSD(3),U,5),0)),U),1,25)," -> "
 .W $P(PSD(3),U,6)," rec'd by "
 .W $E($P($G(^VA(200,+$P(PSD(3),U,7),0)),U),1,20),!
 W:$O(PSDL(0)) !,"Receiving Site: ",$P($G(^PSD(58.8,+$P(PSD(3),U,3),0)),U),!
 F  S PSD(1)=$O(PSDL(PSD(1))) Q:'PSD(1)  D:$Y+5>IOSL HEADER Q:PSDOUT  D
 .S PSD(3)=$G(PSDL(PSD(1)))
 .S Y=$E($P(PSD(3),U,4),1,12) X ^DD("DD") W !,Y,"  "
 .W $E($P($G(^PSDRUG(+$P(PSD(3),U,5),0)),U),1,25)," -> "
 .W $P(PSD(3),U,6)," rec'd by "
 .W $E($P($G(^VA(200,+$P(PSD(3),U,7),0)),U),1,20),!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'$G(PSDOUT) S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu. " D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1 Q
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1 W !,"History of receipts for Invoice # ",PSD(2),?57,RPDT,?70,"PAGE: ",PG,!,LN,!
