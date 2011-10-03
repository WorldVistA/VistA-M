FHMMBRPT ;Hines OIFO/JT,RTK,AAC - Multidiv Monitor Brief ;10/10/03  11:49
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
COM ;get Communication Offices
 S (ZCO,CO,CONAME,CONAM,WARD,FHCOMM,ZZOUT,ZOUT,CONUMX)="",(COXX,ALLMON,ALLADM,ALLFHPER)=0
 ;S ZZOUT=$G(^FH(119.73,0)),CONUMX=$P(ZZOUT,"^",4),ZOUT=CONUMX
 S ZZCOUNT=0 F ZZCOUNT=0:0 S ZZCOUNT=$O(^FH(119.73,ZZCOUNT)) Q:ZZCOUNT'>0  S ZOUT=ZZCOUNT
 R !!,"Print report for all Communication Offices Y or N: ",ZCO:DTIME W ! S ZCO=$TR(ZCO,"y","Y")
 I ZCO'="Y" D N2 I (Y=-1)&(CO="") Q
 ;
DATE ;sets date
 W ! S %DT="AEPT",%DT("A")="Enter beginning date: " D ^%DT Q:Y<0
 S FHSDT=Y,%DT(0)=FHSDT,%DT("A")="Enter ending date: " D ^%DT K %DT(0)
 S PG=0,EX=""
 I Y<0 D END Q
 S FHEDT=Y
 D DEV Q
 ;D END
 ;
EN ;get admission/monitor information
 I ZCO'="Y" S CONUMX=CONUMX-1 G:CONUMX=0 THEND  S COXX=$P(CO,"^",CONUMX),NAME=$P(CONAME,"^",CONUMX)
 I ZCO="Y" S COXX=COXX+1 G:COXX>ZOUT THEND  S NAME=$G(^FH(119.73,COXX,0)),NAME=$P(NAME,"^")
 I $D(^FH(119.73,COXX,"I"))!'$D(^FH(119.73,COXX,0)) G EN
 ;
 D NOW^%DTC S Y=X D DD^%DT S FHNDT=Y D PG
 S ADMTOT=0,MONTOT=0
 S I=FHSDT F  S I=$O(^DGPM("ATT1",I)) Q:'I!(I>FHEDT)  D
 .S J=0 F  S J=$O(^DGPM("ATT1",I,J)) Q:'J!(EX=U)  S REC=$G(^DGPM(J,0)) S WARD=$P(REC,"^",6) Q:WARD=""  D COFF Q:FHCOMM=""  Q:$D(^FH(119.73,FHCOMM,"I"))  Q:FHCOMM'=COXX  D
 ..S DFN=$P(^DGPM(J,0),U,3) I $Y>(IOSL-4) D PG I EX=U Q
 ..S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 ..S Y=$P(I,".") X ^DD("DD") W !,Y,?13,$E($P($G(^DPT(DFN,0)),U,1),1,23)
 ..W ?39,$E($P($G(^DPT(DFN,0)),U,9),6,9) S ADMTOT=ADMTOT+1
 ..I $D(^FHPT(FHDFN,"A",J,"MO","B")) W ?48,"Yes" S MONTOT=MONTOT+1
 ..S Y=$P($P($G(^FHPT(FHDFN,"A",J,0)),U,14),".",1) I Y X ^DD("DD") W ?56,Y
 ..Q
 .Q
 I EX=U D THEND Q
 W !!,"TOTAL ADMISSIONS: ",?22,ADMTOT S ALLADM=ALLADM+ADMTOT I $Y>(IOSL-4) D PG I EX=U Q
 W !,"TOTAL WITH MONITORS:",?22,MONTOT S ALLMON=ALLMON+MONTOT I $Y>(IOSL-4) D PG I EX=U Q
 W !,"Percentage of Admissions with Monitors: "
 I ADMTOT=0!(MONTOT=0) W "0.0%" D EN Q
 S FHPER=(MONTOT/ADMTOT)*100
 I $L($P(FHPER,".",2))>2 S FHPER=$P(FHPER,".",1)_"."_$E($P(FHPER,".",2),1,2)
 W FHPER,"%" I $Y>(IOSL-4) D PG I EX=U Q
 G EN
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
 Q
 ;
COFF ;get Communications Offices
 Q:'$D(^FH(119.6,"AW",WARD))
 S FHWARD=$O(^FH(119.6,"AW",WARD,""))
 S FHCOMM=$P($G(^FH(119.6,FHWARD,0)),"^",8)
 Q
 ;
DEV ;get device and set up queue
 W ! K %ZIS,IOP S %ZIS="Q" D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D EN,^%ZISC,END Q
 S ZTRTN="EN^FHMMBRPT",ZTSAVE("FHSDT")="",ZTSAVE("FHEDT")=""
 S ZTSAVE=("FHNDT")="",ZTSAVE=("FHPER")="",ZTSAVE("ZCO")=""
 S ZTSAVE("CO")="",ZTSAVE("ALLMON")="",ZTSAVE("PG")="",ZTSAVE("EX")=""
 S ZTSAVE("ZOUT")="",ZTSAVE("ALLADM")="",ZTSAVE("ALLFHPER")=""
 S ZTSAVE("COXX")="",ZTSAVE("CONUMX")="",ZTSAVE("FHCOMM")=""
 S ZTSAVE("CONAME")=""
 S ZTDESC="Dietetics Monitor Report" D ^%ZTLOAD
 D ^%ZISC K %ZIS,IOP
 ;D END Q
 ;
END ;kill and quit
 K I,J,DFN,FHDFN,SSN,ADMTOT,MONTOT,FHPER,FHSDT,FHEDT,FHNDT,X,Y,PG
 Q
 ;
THEND ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
 S NAME="ALL COMMUNICATION OFFICES " D HDR
 W !!,"ALL TOTAL ADMISSIONS: ",?22,ALLADM
 W !,"TOTAL WITH MONITORS:",?22,ALLMON
 W !,"Percentage of Admissions with Monitors: "
 I ALLADM=0!(ALLMON=0) W "0.0%" D END Q
 S ALLFHPER=(ALLMON/ALLADM)*100
 I $L($P(ALLFHPER,".",2))>2 S ALLFHPER=$P(ALLFHPER,".",1)_"."_$E($P(ALLFHPER,".",2),1,2)
 W ALLFHPER,"%" I $Y>(IOSL-4) D PG I EX=U Q
 G END Q
 ;
N2 ;find Communications Office
 S DIC=119.73,DIC(0)="AEQ",DIC("A")="Select Communication Offices: "
 D ^DIC I (Y=-1)&(CO="") Q
 I Y=-1 Q
 S CON=$P(Y,"^",1),CO=CON_"^"_CO,CONAM=$P(Y,"^",2),CONAME=CONAM_"^"_CONAME S CONUMX=$L(CO,"^") G N2
 I Y=-1 K DIC Q
 Q
 ;
PG ;
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 D HDR Q
HDR ;Header
 W:$Y @IOF W !,NAME,?30,"MONITOR BRIEF REPORT" W !,FHNDT,?60,"Page: " S PG=PG+1 W PG,!!
 W "Admission",?13,"Patient",?39,"SSN",?45,"Monitor?",?56,"Discharge"
 W ! F Z=1:1:79 W "="
 Q
