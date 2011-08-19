FHMNADM ;Hines OIFO/JT,RTK - Dietetics Adm/Disc Monitor Report ;06/12/02  10:34
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
DATE ;sets date
 ;
 ; Check for multidivisional site
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D ^FHMMNADM Q
 K %DT(0) S %DT="AEPT",%DT("A")="Enter beginning date: " D ^%DT Q:Y<0
 S FHSDT=Y,%DT(0)=FHSDT,%DT("A")="Enter ending date: " D ^%DT Q:Y<0
 S FHEDT=Y
 S DIR(0)="SA^A:Admissions;D:Discharges"
 S DIR("A")="Select type of movement for this report: " D ^DIR
 Q:Y["^"!(Y="")  S TYP=Y
 G DEV
 ;
EN ;get admission/monitor information
 S PG=0,EX="",Y=DT X ^DD("DD") S FHNDT=Y D HDR
 S MVTOT=0,MONTOT=0
 S I=FHSDT F  S I=$O(^DGPM("ATT1",I)) Q:'I!(I>FHEDT)!(EX=U)  D
 .S J=0 F  S J=$O(^DGPM("ATT1",I,J)) Q:'J!(EX=U)  D
 ..S ADM=J,ADMD=I D WRT Q
 .Q
 D END Q
 ;
WRT ;write info
 ; 
 S DFN=$P(^DGPM(J,0),U,3) I $Y>(IOSL-4) D PG I EX=U Q
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 S Y=$P(ADMD,".") X ^DD("DD") W !,Y,?13,$E($P(^DPT(DFN,0),U,1),U,23)
 W ?39,$E($P(^(0),U,9),6,9) S MVTOT=MVTOT+1
 I $D(^FHPT(FHDFN,"A",ADM,"MO"))>9 W ?48,"Yes" S MONTOT=MONTOT+1
 S Y=$P($P($G(^FHPT(FHDFN,"A",ADM,0)),U,14),".",1) I Y X ^DD("DD") W ?56,Y
 Q
 ;
EN1 ;discharges
 S PG=0,EX="",Y=DT X ^DD("DD") S FHNDT=Y D HDR
 S MVTOT=0,MONTOT=0
 S I=FHSDT F  S I=$O(^DGPM("ATT3",I)) Q:'I!(I>FHEDT)!(EX=U)  D
 .S J=0 F  S J=$O(^DGPM("ATT3",I,J)) Q:'J!(EX=U)  D
 ..S ADM=$P(^DGPM(J,0),U,14)
 ..S ADMD=$P(^DGPM(ADM,0),U,1) D WRT Q
 .Q
 ;
END ;end/kill/quit
 ; 
 I EX=U D KL Q
 W !!,"TOTAL "_$S(TYP="A":"ADMISSIONS",TYP="D":"DISCHARGES")_": ",?22,MVTOT
 W !,"TOTAL WITH MONITORS:",?22,MONTOT
 S FHPER=0 I MONTOT>0,MVTOT>0 S FHPER=(MONTOT/MVTOT)*100
 I $L($P(FHPER,".",2))>2 S FHPER=$P(FHPER,".",1)_"."_$E($P(FHPER,".",2),1,2)
 W !,"Percentage of "
 W $S(TYP="A":"Admissions",TYP="D":"Discharges")
 W " with Monitors: ",FHPER,"%"
KL K I,J,FHDFN,DFN,SSN,MVTOT,MONTOT,FHPER,FHSDT,FHEDT,X,Y,PG,FHNDT,ADM
 K TAG,TYP,DIR,%DT,ADDT Q
 ;
DEV ;get device and set up queue
 S TAG=$S(TYP="A":"EN",TYP="D":"EN1")
 K %ZIS,IOP S %ZIS="Q" D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D @TAG,^%ZISC Q
 S ZTRTN=TAG_"^FHMNADM",ZTSAVE("FHSDT")="",ZTSAVE("FHEDT")=""
 S ZTSAVE("TYP")="",ZTDESC="Dietetics Monitor Report" D ^%ZTLOAD
 W !,"Task #",ZTSK
 D ^%ZISC K %ZIS,IOP,FHSDT,FHEDT Q
PG ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
HDR ;Header
 ;
 W:$Y @IOF
 W !,"DIETETIC MONITOR REPORT (Monitoring "
 W $S(TYP="A":"Admissions",TYP="D":"Discharges")_")"
 W !,FHNDT,?60,"Page: " S PG=PG+1 W PG,!!
 W "Admission",?13,"Patient",?39,"SSN",?45,"Monitor?",?56,"Discharge"
 W ! F Z=1:1:79 W "="
 Q
