PSDEA ;BIR/JPW-List Drug Name & DEA Special Handling ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 W !!,"This report lists Drug name, DEA Special Handling, and NDC information",!,"for all drugs marked for Controlled Substances use.",!
DEV ;asks device and queueing information
 W !,"This report is designed for an 80 column format.",!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDEA",ZTDESC="CS PHARM List DEA SPECIAL HANDLING" D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compiles and prints data for report
 K ^TMP("PSDEA",$J)
 S (PG,PSDOUT)=0,%DT="",X="T" D ^%DT X ^DD("DD") S RPDT=Y
 S PSD="" F  S PSD=$O(^PSDRUG("AIUN",PSD)) Q:PSD=""  F NUM=0:0 S NUM=$O(^PSDRUG("AIUN",PSD,NUM)) Q:'NUM  I $D(^PSDRUG(NUM,0)) D
 .S NODE=^PSDRUG(NUM,0),PSDN=$S($P(NODE,"^")]"":$P(NODE,"^"),1:"ZZ #"_NUM_" DRUG NAME MISSING"),PSDEA=$S($P(NODE,"^",3)]"":$P(NODE,"^",3),1:"NOT LISTED")
 .S PSDNDC=$S($P($G(^PSDRUG(NUM,2)),"^",4)]"":$P(^(2),"^",4),1:"NOT LISTED")
 .S ^TMP("PSDEA",$J,PSDN,NUM)=PSDEA_"^"_PSDNDC
PRINT ;print from ^tmp
 K LN S $P(LN,"-",80)="" D HEADER
 I '$D(^TMP("PSDEA",$J)) W !!,?10,"NO DATA FOR THE DEA SPECIAL HANDLING REPORT!!",!! G DONE
 S PSDN="" F  S PSDN=$O(^TMP("PSDEA",$J,PSDN)) Q:PSDN=""!(PSDOUT)  D:$Y+5>IOSL HEADER  Q:PSDOUT  F NUM=0:0 S NUM=$O(^TMP("PSDEA",$J,PSDN,NUM)) Q:'NUM!(PSDOUT)  D
 .S NODE=$G(^TMP("PSDEA",$J,PSDN,NUM))
 .W !,?2,PSDN,?51,$P(NODE,"^"),?65,$P(NODE,"^",2)
 W !
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %DT,%ZIS,DA,DEA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NODE,NUM,PG,PSD,PSDEA,PSDN,PSDNDC,PSDOUT,RPDT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSK
 K ^TMP("PSDEA",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HEADER ;prints header information
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,?15,"DEA SPECIAL HANDLING FOR CS PHARM DRUGS",!,?29,RPDT,?70,"PAGE: "_PG
 W !!,?48,"DEA SPECIAL",!,"DRUG NAME",?49,"HANDLING",?70,"NDC",!,LN,!
 Q
