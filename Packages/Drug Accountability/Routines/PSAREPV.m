PSAREPV ;BIR/LTL,JMB-Invoice Review ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine reviews prime vendor receipt transactions in GIP.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;
 N DIC,DIR,DTOUT,DUOUT,PSA,PSALOC,PSAOUT,X,Y
 D DT^DICRW
 S DIC="^PSD(58.81,",DIC(0)="AEQS",D="PV",DIC("A")="Please select Prime Vendor Invoice number: "
 D IX^DIC K DIC S PSA=+Y,PSA(2)=$P($G(^PSD(58.81,+Y,8)),"^") I Y<0 S PSAOUT=1 G END
 I $P($G(^PSD(58.81,+Y,8)),"^")']"" S PSAOUT=1 G END
DEV ;asks device and queueing info
 K IO("Q") N %ZIS,IOP,POP S %ZIS="Q" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" S PSAOUT=1 G END
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAREPV",ZTDESC="Invoice receipt review",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G END
START ;compiles and prints output
 N %DT,PSALN,PSAPG,PSARPDT S (PSAPG,PSAOUT)=0,Y=DT,PSA(1)="" X ^DD("DD") S PSARPDT=Y D HEADER
LOOP F  S PSA(1)=$O(^PSD(58.81,"PV",PSA(2),PSA(1))) G:$G(PSAOUT)!('PSA(1)) END D:$Y+5>IOSL HEADER G:PSAOUT END D
 .I '$D(PSALOC) S PSALOC=$P($G(^PSD(58.81,+PSA(1),0)),"^",3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+PSALOC,0)),"^"),!
 .I $G(PSALOC)'=$P($G(^PSD(58.81,+PSA(1),0)),"^",3) S PSALOC=$P($G(^(0)),"^",3) W !,"Receiving Site: ",$P($G(^PSD(58.8,+$P($G(^PSD(58.81,+PSA(1),0)),"^",3),0)),"^"),!
 .S Y=$P($G(^PSD(58.81,+PSA(1),0)),"^",4) X ^DD("DD") W !,Y,"  ",$E($P($G(^PSDRUG(+$P($G(^PSD(58.81,+PSA(1),0)),"^",5),0)),"^"),1,25)," => "
 .W $P($G(^PSD(58.81,+PSA(1),0)),"^",6)," rec'd by ",$E($P($G(^VA(200,+$P($G(^PSD(58.81,+PSA(1),0)),"^",7),0)),"^"),1,20),!
END W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'$G(PSAOUT) S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu. " D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),"^"),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !,"History of receipts for Invoice # ",PSA(2),?57,PSARPDT,?70,"PAGE: ",PSAPG,!,PSALN,!
 Q
