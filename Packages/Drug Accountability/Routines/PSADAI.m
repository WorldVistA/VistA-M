PSADAI ;BIR/LTL/,JMB/PDW-Drug Balances by Location ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15,53**; 10/24/97
 ;
 ;Reference to ^PS(59.4 are covered by IA #2505
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRCP( are covered by IA #214
 ;References to ^PS(59 are covered by IA #212
 ;
LOC S (PSACNT,PSAOUT)=0 D ^PSAUTL3 G:PSAOUT EXIT1
 S PSACNT=0,PSACHK=$O(PSALOC(""))
 I PSACHK="",'PSALOC W !,"There are no active pharmacy locations." G EXIT1
 I PSACHK'="",$G(PSASEL)="",PSALOC W !!,PSALOCN
 ;
DEVICE W ! K IO("Q") S %ZIS="Q" D ^%ZIS I POP S DTOUT=1,Y=-1 W !,"No Device was selected or output printed." G EXIT1
 I $D(IO("Q")) S ZTRTN="START^PSADAI",ZTDESC="Drug Accountability - Drug Location Report",ZTSAVE("PSALOC(")="" D ^%ZTLOAD,HOME^%ZIS S Y=1 G EXIT1
START S PSAOUT=0,PSALOCN="",$P(PSASLN,"-",80)=""
 S PSARPDT=$E($$HTFM^XLFDT($H),1,12),PSADT=$P(PSARPDT,".")
 S PSARPDT=$E(PSADT,4,5)_"/"_$E(PSADT,6,7)_"/"_$E(PSADT,2,3)_"@"_$P(PSARPDT,".",2)
 F  S PSALOCN=$O(PSALOC(PSALOCN)) Q:PSALOCN=""  D  Q:PSAOUT
 .S PSAIEN=0 F  S PSAIEN=+$O(PSALOC(PSALOCN,PSAIEN)) Q:'PSAIEN  D  Q:PSAOUT
 ..S PSAISIT=+$P(PSALOC(PSALOCN,PSAIEN),"^"),PSAOSIT=+$P(PSALOC(PSALOCN,PSAIEN),"^",2)
 ..S PSAISITN=$S($P($G(^PS(59.4,PSAISIT,0)),"^")'="":$P($G(^PS(59.4,PSAISIT,0)),"^"),1:"UNKNOWN")
 ..S PSAOSITN=$S($P($G(^PS(59,PSAOSIT,0)),"^")'="":$P($G(^PS(59,PSAOSIT,0)),"^"),1:"UNKNOWN")
 ..S PSASITES=$S(PSAISIT&(PSAOSIT):PSAISITN_" (IP)  "_PSAOSITN_" (OP)",PSAISIT:PSAISITN_" (IP)",1:PSAOSITN_" (OP)")
 ..D COMPILE D:'PSAOUT DONE
EXIT D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q") W:$E(IOST,1,2)="C-" @IOF
EXIT1 K ^TMP($J,"PSADRG"),%ZIS,DIR,DIRUT,DTOUT
 K PSACHK,PSACNT,PSADRG,PSADT,PSAIEN,PSAINV,PSAISIT,PSAISITN,PSALEN,PSALINK,PSALNK,PSALOC,PSALOCA,PSALOCN,PSAOSIT,PSAOSITN
 K PSAOUT,PSAPG,PSARPDT,PSAS,PSASEL,PSASITES,PSASLN,PSASS,PSATMP,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK
 Q
COMPILE ;Creates ^TMP(Drug Name)= current balance ^ dispense unit ^ total inventory (current balance in 50)
 K ^TMP($J,"PSADRG")
 S PSADRG=0 F  S PSADRG=+$O(^PSD(58.8,PSAIEN,1,PSADRG)) Q:'PSADRG  D
 .Q:'$D(^PSDRUG(PSADRG,0))
 .I $P($G(^PSD(58.8,PSAIEN,1,PSADRG,0)),"^",4)=0,$P($G(^PSD(58.8,PSAIEN,1,PSADRG,0)),"^",14)<DT Q  ;*53 0 QT & inactive
 .S ^TMP($J,"PSADRG",$P(^PSDRUG(PSADRG,0),"^"))=$P($G(^PSD(58.8,PSAIEN,1,PSADRG,0)),"^",4)_"^"_$P($G(^PSDRUG(PSADRG,660)),"^",8)_"^"_$P($G(^PSDRUG(PSADRG,660.1)),"^")
PRINT ;Prints body of report
 ;Finds longest length of inventory link(s).
 S (PSALNK,PSALEN)=0 F  S PSALNK=+$O(^PSD(58.8,PSAIEN,4,PSALNK)) Q:'PSALNK  D
 .S PSALINK(+$P($G(^PSD(58.8,PSAIEN,4,PSALNK,0)),"^"))=""
 .S PSAINV="INVENTORY LINK: "_$S($P($G(^PRCP(445,PSALNK,0)),"^")'="":$P($G(^PRCP(445,PSALNK,0)),"^"),1:"NONE")
 .S:PSALEN<$L(PSAINV) PSALEN=$L(PSAINV)
 S PSAPG=0,PSADRG="" D HDR
 ;If no data in ^TMP, prints message & exit routine.
 S PSATMP=$O(^TMP($J,"PSADRG","")) I PSATMP="" W !!,"<< NO DRUGS WERE FOUND. >>",! G DONE
 ;If data is found, prints drug name, current balance, & dispense unit
 F  S PSADRG=$O(^TMP($J,"PSADRG",PSADRG)) Q:PSADRG=""  D  I PSAOUT W:$E(IOST,1,2)="C-" @IOF Q
 .D:$Y+4>IOSL HDR Q:PSAOUT
 .W !,PSADRG
 .S PSALEN=$L($P($P(^TMP($J,"PSADRG",PSADRG),"^"),".",2))
 .W ?(44+PSALEN),$J($FN($P(^TMP($J,"PSADRG",PSADRG),"^"),",",PSALEN),(10+PSALEN))
 .W:$P(^TMP($J,"PSADRG",PSADRG),"^",2)'="" ?61,$P(^TMP($J,"PSADRG",PSADRG),"^",2)
 .W ?69,$J($FN($P(^TMP($J,"PSADRG",PSADRG),"^",3),",",0),9)
 Q
DONE ;Holds screen or ejects paper if sent to printer
 I $E(IOST,1,2)="C-" D
 .S PSAS=22-$Y F PSASS=1:1:PSAS W !
 .S DIR(0)="EA",DIR("A")="End of display! Enter RETURN to continue or '^' to exit:" D ^DIR K DIR S:'Y PSAOUT=1
 W:$E(IOST)'="C" @IOF
 Q
HDR ;Print header
 S PSAPG=PSAPG+1
 I PSAPG=1,$E(IOST,1,2)="C-" W @IOF
 I PSAPG>1,$E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",PSAPG>1 D  Q:PSAOUT
 .S PSAS=22-$Y F PSASS=1:1:PSAS W !
 .S DIR(0)="E" D ^DIR K DIR W:'$G(DIRUT) @IOF S:'Y PSAOUT=1
 W:$E(IOST)'="C" !!,PSARPDT W:$E(IOST,1,2)="C-" !
 W ?21,"D R U G   A C C O U N T A B I L I T Y",?71,"Page ",$J(PSAPG,2)
 W !?24,"DRUG BALANCES BY LOCATION REPORT"
 W !?((80-$L(PSALOCN))/2),PSALOCN
 S PSALNK=0 F  S PSALNK=$O(PSALINK(PSALNK)) Q:'PSALNK  D
 .S PSAINV="INVENTORY LINK: "_$S($P($G(^PRCP(445,PSALNK,0)),"^")'="":$P($G(^PRCP(445,PSALNK,0)),"^"),1:"NONE")
 .W !?((80-$L(PSAINV))/2),PSAINV
 W !!?47,"CURRENT",?58,"DISPENSE",?72,"TOTAL"
 W !,"DRUG NAME",?47,"BALANCE",?60,"UNIT",?70,"INVENTORY",!,PSASLN
 Q
