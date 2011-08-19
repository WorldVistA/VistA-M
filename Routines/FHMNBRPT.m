FHMNBRPT ;Hines OIFO/JT,RTK - Dietetics Monitor Brief ;07/26/01  11:49
 ;;5.5;DIETETICS;**2**;Jan 28, 2005
 ;
DATE ;sets date
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D ^FHMMBRPT Q
 W ! S %DT="AEPT",%DT("A")="Enter beginning date: " D ^%DT Q:Y<0
 S FHSDT=Y,%DT(0)=FHSDT,%DT("A")="Enter ending date: " D ^%DT K %DT(0)
 I Y<0 D END Q
 S FHEDT=Y D DEV
 D END Q
 ;
EN ;get admission/monitor information
 S PG=0,EX="" D NOW^%DTC S Y=X D DD^%DT S FHNDT=Y D HDR
 S ADMTOT=0,MONTOT=0
 S I=FHSDT F  S I=$O(^DGPM("ATT1",I)) Q:'I!(I>FHEDT)  D
 .S J=0 F  S J=$O(^DGPM("ATT1",I,J)) Q:'J!(EX=U)  D
 ..S DFN=$P(^DGPM(J,0),U,3) I $Y>(IOSL-4) D PG I EX=U Q
 ..S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 ..S Y=$P(I,".") X ^DD("DD") W !,Y,?13,$E($P(^DPT(DFN,0),U,1),1,23)
 ..W ?39,$E($P(^DPT(DFN,0),U,9),6,9) S ADMTOT=ADMTOT+1
 ..I $D(^FHPT(FHDFN,"A",J,"MO","B")) W ?48,"Yes" S MONTOT=MONTOT+1
 ..S Y=$P($P($G(^FHPT(FHDFN,"A",J,0)),U,14),".",1) I Y X ^DD("DD") W ?56,Y
 ..Q
 .Q
 I EX=U D END Q
 W !!,"TOTAL ADMISSIONS: ",?22,ADMTOT
 W !,"TOTAL WITH MONITORS:",?22,MONTOT
 W !,"Percentage of Admissions with Monitors: "
 I ADMTOT=0!(MONTOT=0) W "0.0%" D END Q
 S FHPER=(MONTOT/ADMTOT)*100
 I $L($P(FHPER,".",2))>2 S FHPER=$P(FHPER,".",1)_"."_$E($P(FHPER,".",2),1,2)
 W FHPER,"%"
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
 D END Q
DEV ;get device and set up queue
 W ! K %ZIS,IOP S %ZIS="Q" D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D EN,^%ZISC,END Q
 S ZTRTN="EN^FHMNBRPT",ZTSAVE("FHSDT")="",ZTSAVE("FHEDT")=""
 S ZTSAVE=("FHNDT"),ZTSAVE=("FHPER")
 S ZTDESC="Dietetics Monitor Report" D ^%ZTLOAD
 D ^%ZISC K %ZIS,IOP
 D END Q
END ;kill and quit
 K I,J,FHDFN,DFN,SSN,ADMTOT,MONTOT,FHPER,FHSDT,FHEDT,FHNDT,X,Y,PG
 Q
PG ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
HDR ;Header
 W:$Y @IOF W !,FHNDT,?60,"Page: " S PG=PG+1 W PG,!!
 W "Admission",?13,"Patient",?39,"SSN",?45,"Monitor?",?56,"Discharge"
 W ! F Z=1:1:79 W "="
 Q
