PSDREV ;BIR/LTL-Review Receipt Transactions ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**18**;13 Feb 97
 ;
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to ^PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 ;References to ^PRC(442 are covered by DBIA#682
 N C,DIC,DIR,DTOUT,DUOUT,PSDEV,PSDLOC,PSDOUT,PSDPO,X,Y
 S DIC="^PRC(442,",DIC(0)="AEMQZ",DIC("A")="Please Select Purchase Order Number: ",DIC("S")="I $P($G(^(0)),U,5)[822400",PSDOUT=1 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<1) END S PSDPO=+Y
 I '$O(^PSD(58.81,"C",+Y,"")) W !!,"There have been no receipts for this Purchase Order.",!! G END
DEV ;asks device and queueing info
 S Y=$P($G(^PSD(58.8,+$P($G(^PSD(58.81,+$O(^PSD(58.81,"C",+Y,0)),0)),U,3),2)),U,9),C=$P(^DD(58.8,24,0),U,2) D Y^DIQ S PSDEV=Y
 K IO("Q"),PSDLOC N %ZIS,IOP,POP S %ZIS="Q",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDREV",ZTDESC="Receipt transaction review",ZTSAVE("PSDPO")="" D ^%ZTLOAD,HOME^%ZIS S PSDOUT=1 G END
START ;compiles and prints output
 N %DT,LN,PSDR,PG,RPDT S (PG,PSDOUT)=0,Y=DT,PSDR="" X ^DD("DD") S RPDT=Y D HEADER
LOOP F  S PSDR=$O(^PSD(58.81,"C",PSDPO,PSDR)) G:'PSDR END D:$Y+5>IOSL HEADER G:PSDOUT END D
 .I '$D(PSDLOC) S PSDLOC=$P($G(^PSD(58.81,+PSDR,0)),U,3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+PSDLOC,0)),U),!
 .I $G(PSDLOC)'=$P($G(^PSD(58.81,+PSDR,0)),U,3) S PSDLOC=$P($G(^(0)),U,3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+$P($G(^PSD(58.81,+PSDR,0)),U,3),0)),U),!
 .S Y=$P($G(^PSD(58.81,+PSDR,0)),U,4) X ^DD("DD") W !,Y,"  ",$E($P($G(^PSDRUG(+$P($G(^PSD(58.81,PSDR,0)),U,5),0)),U),1,25)," -> "
 .W $P($G(^PSD(58.81,+PSDR,0)),U,6)," rec'd by ",$E($P($G(^VA(200,+$P($G(^PSD(58.81,+PSDR,0)),U,7),0)),U),1,20),!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1 Q
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1 W !?2,"History of receipts for P.O.# ",$P($G(^PRC(442,+PSDPO,0)),U),?50,RPDT,?70,"PAGE: ",PG,!,LN,!
