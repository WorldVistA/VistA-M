PSOSUCLE ;BIR/SAB-utility to resuspended Rxs ;04/11/00
 ;;7.0;OUTPATIENT PHARMACY;**39**;DEC 1997
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^DPT supported by DBIA 10035
 ;
 D ^PSOLSET K DIRUT,DUOUT,DIR
 W !! S DIR(0)="SA^Q:Queue Background;R:Run while I wait;E:Exit"
 S DIR("A",1)="This utility will re-suspend all prescriptions that have not yet printed or have",DIR("A",2)="not been queued for transmission to CMOP."
 S DIR("A",3)=" ",DIR("A",4)="Do you want to Queue to run in the background or"
 S DIR("B")="Queue",DIR("A")="Run while you wait? " D ^DIR
 G:Y="Q" QUE G:X="E"!($D(DIRUT)) EXIT
EN K SUSDAT,XFLAG,PSOQ,^TMP("PSOSUCLE",$J)
 F SU=0:0 S SU=$O(^PS(52.5,SU)) Q:'SU  I $P(^PS(52.5,SU,0),"^",7)="",$G(^("P"))=0 D
 .I $P(^PS(52.5,SU,0),"^",2)="" S $P(^PS(52.5,SU,0),"^",2)=DT
 .I $D(^TMP("PSOSUCLE",$J,"RXN",$P(^PS(52.5,SU,0),"^"))) S DA=SU,DIK="^PS(52.5," D ^DIK Q
 .S ^TMP("PSOSUCLE",$J,SU,0)=^PS(52.5,SU,0),^TMP("PSOSUCLE",$J,"RXN",$P(^PS(52.5,SU,0),"^"))=""
 F SU=0:0 S SU=$O(^TMP("PSOSUCLE",$J,SU)) Q:'SU  S SUSDAT=^TMP("PSOSUCLE",$J,SU,0) D REQUE K XFLAG,SUSDAT
EXIT K ^TMP("PSOSUCLE",$J),SU,RXN,DIR,%DT,PSOQ,SD,L,RXN,ACT,X,Y,DIRUT,DUOUT,DTOUT,DIROUT,XFLAG,SUSDAT,PSOSYS S ZTREQ="@"
 Q
REQUE S RXN=$P(SUSDAT,"^"),DA=SU,ACT=1,SD=$S($P(SUSDAT,"^",2):$P(SUSDAT,"^",2),1:DT),DIK="^PS(52.5," D ^DIK
 I $P($G(^PSRX(RXN,"STA")),"^")=3 Q
 I $G(PSXSYS) S DA=RXN D SUS1^PSOCMOP I $G(XFLAG)=1 K XFLAG Q
 S RXP=+$P(SUSDAT,"^",5),DIC="^PS(52.5,",DIC(0)="L",X=RXN
 S DIC("DR")=".02///"_SD_";.03////"_$P(SUSDAT,"^",3)_";.04///M;.05///"_RXP_";.06////"_$P(SUSDAT,"^",6)_";2///0;6////"_$P(SUSDAT,"^",10)_";8////"_$P(SUSDAT,"^",12)_";9////"_$P(SUSDAT,"^",13)
 K DD,DO D FILE^DICN K DD,DO
 S LFD=$E(SD,4,5)_"-"_$E(SD,6,7)_"-"_$E(SD,2,3) D ACT
 W:$G(PSOQ)'=1 !!,"Rx# "_$P(^PSRX(RXN,0),"^")_" has been Re-suspended until "_LFD_"."
 Q
ACT S RXF=0 F I=0:0 S I=$O(^PSRX(RXN,1,I)) Q:'I  S RXF=I S:I>5 RXF=I+1
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(RXN,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(RXN,"A",0)="^52.3DA^"_IR_"^"_IR
 D NOW^%DTC S ^PSRX(RXN,"A",IR,0)=%_"^S^"_DUZ_"^"_RXF_"^"_"Rx Re-Suspended until "_LFD K RXF,I,FDA,DIC,DIE,DR,Y,X,%,%H,%I,IR
 Q
QUE ;queues job to background
 D NOW^%DTC S %DT(0)=% K %,%H,%I,X
 W !! S %DT="AETX",%DT("B")="Now",%DT("A")="Date and Time to Run: " D ^%DT I Y=-1 W !!,"Background Job not queued!",! G EXIT
 I $P(Y,".",2)="" W !!,"Date and time Required!",! G QUE
 S ZTRTN="EN^PSOSUCLE",ZTIO="",ZTDESC="Outpatient Pharmacy Utility Routine to Re-Suspend Rxs.",ZTDTH=Y,PSOQ=1
 F G="PSOQ","DUZ","PSOSYS","PSOPAR","PSOSITE","PSXSYS","PSXVER","PSOINST" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD W:$D(ZTSK) !!,"Background Job Queued to Run.",! K ZTSK G EXIT
 Q
RESUS ;resuspends individual Rxs that have printed local but should have gone to CMOP
 D ^PSOLSET I '$D(PSOPAR) W !,"No Division Selected!",! Q
 S DIC("A")="Select Rx to Re-Suspend: ",DIC=52.5,DIC(0)="AEQMZ",DIC("S")="I $P(^PS(52.5,+Y,0),""^"",7)'=""X"",$G(^(""P""))=1"
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) EXIT G:Y=-1 RESUS
 S SU=+Y,SUSDAT=Y(0) D REQUE K Y,XFLAG,SUSDAT,SU G RESUS
 Q
SURPT ;prints report of printed Rxs that have cmop drugs
 D ^PSOLSET I '$D(PSOPAR) W !,"No Division Selected!",! Q
 W !!,"Enter a date range to see Rxs printed locally with CMOP Drugs from suspense within those dates."
BEG W ! K %DT S %DT="AEX",%DT("A")="Start date: " D ^%DT K %DT G:Y<0!($D(DTOUT)) END S (%DT(0),BEGDATE,BEG)=Y
 W ! S %DT="AEX",%DT("A")="End date: " D ^%DT K %DT G:Y<0!($D(DTOUT)) END S (END,ENDDATE)=Y
 S BEGDATE=BEGDATE-.0001,ENDDATE=ENDDATE+.9999
 K %ZIS,IOP,ZTSK,ZTQUEUED S PSOION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION G END
        K PSOION I $D(IO("Q"))  D  G END
 .S ZTDESC="Report that List Rxs from Suspense with CMOP Drugs.",ZTRTN="ENT^PSOSUCLE",ZTSAVE("ZTREQ")="@"
        .F G="BEG","END","BEGDATE","ENDDATE","PSOPAR","PSOSITE" S:$D(@G) ZTSAVE(G)=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued to Print !!",! K ZTSK,IO("Q")
 W !!,"Gathering Rxs, please wait...",! H 1
ENT K ^TMP($J,"PSOREQ")
 F Z=BEGDATE:0 S Z=$O(^PS(52.5,"AS",Z)) Q:'Z!(Z>ENDDATE)  F X=0:0 S X=$O(^PS(52.5,"AS",Z,X)) Q:'X  F M=0:0 S M=$O(^PS(52.5,"AS",Z,X,M)) Q:'M  D:M=$G(PSOSITE)
 .F Q=0:0 S Q=$O(^PS(52.5,"AS",Z,X,M,Q)) Q:'Q  F DA=0:0 S DA=$O(^PS(52.5,"AS",Z,X,M,Q,DA)) Q:'DA  D
 ..I '$D(^PS(52.5,DA,0)) K ^PS(52.5,"AS",Z,X,M,Q,DA) Q
 ..S RXN=$P(^PS(52.5,DA,0),"^"),DRG=$P(^PSRX(RXN,0),"^",6) Q:'$D(^PSDRUG("AQ",DRG))
 ..S ^TMP($J,"PSOREQ",DA,0)=RXN I $P(^PS(52.5,DA,0),"^",2)="" S $P(^PS(52.5,DA,0),"^",2)=Z
 D LIST
END K ^TMP($J,"PSOREQ"),%DT,%ZIS,BEGDATE,DUOUT,DTOUT,ENDDATE,G,INRX,L,M,POP,X,ZZZZ,BEG,END,DRG,RXN,DRG D ^%ZISC
 Q
LIST D HEAD I '$O(^TMP($J,"PSOREQ",0)) U IO W !!,"There are no locally printed CMOP Rxs printed for specified date range!",! Q
 F L=0:0 S L=$O(^TMP($J,"PSOREQ",L)) Q:'L!($G(PSOOUT))  I $D(^PS(52.5,L,0)) S INRX=$P(^(0),"^") I $D(^PSRX(INRX,0)) S DRG=$P(^(0),"^",6) D
 .W !,$P(^PSRX(INRX,0),"^"),?20,$P($G(^DPT(+$P(^PSRX(INRX,0),"^",2),0)),"^"),?60,$S($P($G(^PS(52.5,L,0)),"^",5):"(PARTIAL)",$P($G(^(0)),"^",12):"(REPRINT)",1:"")
 .W ?60,$E($P(^PS(52.5,L,0),"^",8),4,5)_"/"_$E($P(^PS(52.5,L,0),"^",8),6,7)_"/"_$E($P(^PS(52.5,L,0),"^",8),2,3),!?5,"Drug: "_$P($G(^PSDRUG(DRG,0)),"^")
 .D:($Y+5)>IOSL HEADONE
 W !,$S('$G(PSOOUT):"End of List",1:"Printout Terminated")
 Q
HEAD U IO W @IOF,!?20,"Rxs Printed Locally that have CMOP Drugs"
 W !,"Date Range Requested: "_$E(BEG,4,5)_"/"_$E(BEG,6,7)_"/"_$E(BEG,2,3)_" to "_$E(END,4,5)_"/"_$E(END,6,7)_"/"_$E(END,2,3),!
 W ! W "Rx #",?20,"Patient Name",?60,"Date Printed",!
 F ZZZZ=1:1:78 W "-"
 Q
HEADONE I '$D(ZTSK) S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 D HEAD
 Q
