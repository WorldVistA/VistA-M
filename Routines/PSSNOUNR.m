PSSNOUNR ;BIR/RTR-Dosage Form and Noun report ;03/24/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**34,48**;9/30/97
 ;
EN ;
 W !!,"This report shows the Dosage Forms and Nouns, along with the package use for",!,"each Noun and the resulting Local Possible Dosage.",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! Q
 I $D(IO("Q")) S ZTRTN="START^PSSNOUNR",ZTDESC="Dosage Form/Noun Report" D ^%ZTLOAD K %ZIS W !,"Report queued to print.",! Q
START ;
 U IO
 S PSSOUT=0,PSSDV=$S($E(IOST)="C":"C",1:"P"),PSSCT=1
 K PSSLINE S $P(PSSLINE,"-",78)=""
 D NOHD
 S PSSDF="" F  S PSSDF=$O(^PS(50.606,"B",PSSDF)) Q:PSSDF=""!($G(PSSOUT))  F PSSN=0:0 S PSSN=$O(^PS(50.606,"B",PSSDF,PSSN)) Q:'PSSN!($G(PSSOUT))  D
 .S PSSNODE=$G(^PS(50.606,PSSN,0)) I $P(PSSNODE,"^",2),$P(PSSNODE,"^",2)<DT Q
 .I ($Y+5)>IOSL D NOHD Q:$G(PSSOUT)
 .W !!,$P(PSSNODE,"^") K PSSDAR F PSSDUP=0:0 S PSSDUP=$O(^PS(50.606,PSSN,"DUPD",PSSDUP)) Q:'PSSDUP  I $P($G(^(PSSDUP,0)),"^") S PSSDAR($P($G(^(0)),"^"))=""
 .I $O(PSSDAR(0)) W ?34,"(" F PSSX=0:0 S PSSX=$O(PSSDAR(PSSX)) Q:'PSSX  W PSSX W:$O(PSSDAR(PSSX)) ","
 .I $O(PSSDAR(0)) W ")"
 .I ($Y+5)>IOSL D NOHD Q:$G(PSSOUT)
 .S PSSNFLAG=0
 .F PSSNN=0:0 S PSSNN=$O(^PS(50.606,PSSN,"NOUN",PSSNN)) Q:'PSSNN!($G(PSSOUT))  S PSSNAME=$P($G(^(PSSNN,0)),"^"),PSSPAK=$P($G(^(0)),"^",2) I PSSNAME'="" S PSSNFLAG=1 D
 ..I ($Y+5)>IOSL D NOHD Q:$G(PSSOUT)
 ..I '$O(PSSDAR(0)) W !?2,$G(PSSNAME) D  Q
 ...I $G(PSSPAK)="" W ?34,"(No package)" Q
 ...W ?34,$S($L($G(PSSPAK))>1:$G(PSSPAK),1:" "_$G(PSSPAK))_"--> "_$G(PSSNAME)
 ..I $G(PSSPAK)="" W !?2,$G(PSSNAME),?34,"(No package)" Q
 ..W !?2,$G(PSSNAME),?34,$S($L($G(PSSPAK))>1:$G(PSSPAK),1:" "_$G(PSSPAK))
 ..S PSSZC=1 F PSSZ=0:0 S PSSZ=$O(PSSDAR(PSSZ)) Q:'PSSZ!($G(PSSOUT))  D
 ...I PSSZC=1 D PARN W "--> "_PSSZ_" "_$S($G(PSSXN)'="":$G(PSSXN),1:$G(PSSNAME)) S PSSZC=PSSZC+1 Q
 ...I ($Y+5)>IOSL D NOHD Q:$G(PSSOUT)
 ...D PARN W !?34,$S($L($G(PSSPAK))>1:$G(PSSPAK),1:" "_$G(PSSPAK)),"--> ",PSSZ_" "_$S($G(PSSXN)'="":$G(PSSXN),1:$G(PSSNAME))
 .I '$G(PSSNFLAG) W !?2,"(No Nouns)"
END ;
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
 K PSSDF,PSSN,PSSOUT,PSSLINE,PSSDV,PSSCT,PSSDAR,PSSDUP,PSSX,PSSNN,PSSNFLAG,PSSNAME,PSSNODE,PSSPAK,PSSZ,PSSZC,PSSXN,PSSXNX D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
NOHD ;
 I $G(PSSDV)="C",$G(PSSCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !,"Dosage Form",?34,"Dispense Units per Dose",?69,"PAGE: "_$G(PSSCT) S PSSCT=PSSCT+1
 W !?2,"Noun(s)",?26,"Package-->Local Possible Dosage",!,PSSLINE
 Q
PARN ;
 K PSSXN,PSSXNX
 Q:$G(PSSNAME)=""
 Q:$L(PSSNAME)'>3
 S PSSXNX=$E(PSSNAME,($L(PSSNAME)-2),$L(PSSNAME))
 I $G(PSSXNX)="(S)"!($G(PSSXNX)="(s)") D
 .I $G(PSSZ)'>1 S PSSXN=$E(PSSNAME,1,($L(PSSNAME)-3))
 .I $G(PSSZ)>1 S PSSXN=$E(PSSNAME,1,($L(PSSNAME)-3))_$E(PSSXNX,2)
 Q
