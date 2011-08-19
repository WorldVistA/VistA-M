PSAREV ;BIR/LTL-Purchase Order Review ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine reviews receipt transactions.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;
 N DIC,DIR,DTOUT,DUOUT,PSALOC,PSAOUT,PSAPO,X,Y
 S DIC="^PRC(442,",DIC(0)="AEMQZ",DIC("A")="Please Select Purchase Order Number: ",DIC("S")="I $P($G(^(0)),U,5)[822400",PSAOUT=1 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<1) END S PSAPO=+Y
 I '$O(^PSD(58.81,"C",+Y,"")) W !!,"There have been no receipts for this Purchase Order.",!! G END
DEV ;asks device and queueing info
 K IO("Q"),PSALOC N %ZIS,IOP,POP S %ZIS="Q" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAREV",ZTDESC="Receipt transaction review",ZTSAVE("PSAPO")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
START ;compiles and prints output
 N %DT,PSALN,PSAR,PSAPG,PSARPDT S (PSAPG,PSAOUT)=0,Y=DT,PSAR="" X ^DD("DD") S PSARPDT=Y D HEADER
LOOP F  S PSAR=$O(^PSD(58.81,"C",PSAPO,PSAR)) G:'PSAR END D:$Y+5>IOSL HEADER G:PSAOUT END D
 .I '$D(PSALOC) S PSALOC=$P($G(^PSD(58.81,+PSAR,0)),U,3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+PSALOC,0)),U),!
 .I $G(PSALOC)'=$P($G(^PSD(58.81,+PSAR,0)),U,3) S PSALOC=$P($G(^(0)),U,3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+$P($G(^PSD(58.81,+PSAR,0)),U,3),0)),U),!
 .S Y=$P($G(^PSD(58.81,+PSAR,0)),U,4) X ^DD("DD") W !,Y,"  ",$E($P($G(^PSDRUG(+$P($G(^PSD(58.81,PSAR,0)),U,5),0)),U),1,25)," -> "
 .W $P($G(^PSD(58.81,+PSAR,0)),U,6)," rec'd by ",$E($P($G(^VA(200,+$P($G(^PSD(58.81,+PSAR,0)),U,7),0)),U),1,20),!
END W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'PSAOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !?2,"History of receipts for P.O.# ",$P($G(^PRC(442,+PSAPO,0)),U),?50,PSARPDT,?70,"PAGE: ",PSAPG,!,PSALN,!
 Q
