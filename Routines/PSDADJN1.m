PSDADJN1 ;B'ham ISC/LTL - Review NAOU adj transactions for a drug ; 2 Sept 93
 ;;3.0; CONTROLLED SUBSTANCES ;**18**;13 Feb 97
 ;References to ^PSD(58.8 are covered by DBIA2711
 ;References to ^PSD(58.81 are covered by DBIA2808
 ;References to ^PSDRUG( are covered by DBIA221
 N DIC,DIR,DIRUT,DTOUT,DUOUT,PSD,PSDEV,PSDLOC,PSDLOCN,PSDOUT,PSDR,PSDT,PSDS,X,Y
 D DT^DICRW
LOOK S DIC="^PSD(58.8,",DIC(0)="AEMQ",DIC("A")="Select NAOU: ",DIC("S")="I $P($G(^(0)),U,2)[""N"",'$P(^(0),""^"",7),($S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0))",PSDOUT=1
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<1) END S PSDLOC=+Y,PSDLOCN=$P(Y,U,2)
CHKD I '$O(^PSD(58.8,PSDLOC,1,0)) W !!,"There are no drugs in ",PSDLOCN G END
 S DIC="^PSD(58.8,PSDLOC,1,",DIC(0)="AEMQZ",DIC("A")="Select "_PSDLOCN_" drug: ",DIC("S")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)>DT,1:1)",DA(1)=PSDLOC G:$D(DTOUT)!($D(DUOUT)) END
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<1) END S PSD=+Y
 I '$O(^PSD(58.81,"F",+Y,"")) W !!,"There have been no adjustments for this drug.",!! G END
 S DIR(0)="D:AEP",DIR("A")="How far back in time do you want to go: ",DIR("B")="T-6M" D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 G END
 S PSDT=Y
DEV ;asks device and queueing info
 ;Changed direct global read to accomodate SQA on PSD*3*18
 ;Use DBA 10114 for read w/fileman (DAVE B)
 S PSDEV=+$P($G(^PSD(58.8,+PSDLOC,2)),U,9) ; DAVE B (PSD*3*18)
 S X="`"_PSDEV,DIC=3.5,DIC(0)="" D ^DIC S PSDEV=$P(Y,U,2) ;DBA 10114
 K X,DIC,Y
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" S PSDOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDADJR",ZTDESC="Drug adjustment transaction review",ZTSAVE("PSD*")="" D ^%ZTLOAD,HOME^%ZIS S PSDOUT=1 G END
START ;compiles and prints output
 N %DT,LN,PG,RPDT S (PG,PSDOUT)=0,Y=DT D DD^%DT S RPDT=Y,PSDR="" D HEADER
LOOP F  S PSDR=$O(^PSD(58.81,"F",PSD,PSDR)) G:'PSDR END D:$Y+5>IOSL HEADER G:PSDOUT END I $P($G(^PSD(58.81,+PSDR,0)),U,4)'<PSDT,$P($G(^(0)),U,2)=9,$P($G(^(0)),U,3)=PSDLOC D
 .S Y=$P($G(^PSD(58.81,+PSDR,0)),U,4) X ^DD("DD") W !,Y,"  ",$E($P($G(^PSDRUG(+$P($G(^PSD(58.81,PSDR,0)),U,5),0)),U),1,25)," -> "
 .W $P($G(^PSD(58.81,+PSDR,0)),U,6)," adjusted by ",$E($P($G(^VA(200,+$P($G(^PSD(58.81,+PSDR,0)),U,7),0)),U),1,20),!,"Reason: ",$P($G(^PSD(58.81,+PSDR,0)),U,16),!!
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'$G(PSDOUT) W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PG S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1
 W:$Y @IOF S $P(LN,"-",81)="",PG=PG+1 W !?2,"History of adjustments for ",$E($P($G(^PSDRUG(+PSD,0)),U),1,20),?50,RPDT,?70,"PAGE: ",PG,!,LN,!
