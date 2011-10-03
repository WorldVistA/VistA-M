FHMMNADM ;Hines OIFO/JT,RTK,AAC - Multidiv Adm/Disc Monitor Report ;10/10/03  10:34
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
COM ;Get Communication Offices
 ;
 S (XX,ZCO,CO,COXX,CNAME,CONAME,CONAM,WARD,FHCOMM)="",(ALLMON,ALLMV)=0
 ;S ZZOUT=$G(^FH(119.73,0)),(CONUMX,ZOUT)=$P(ZZOUT,"^",4)
 S ZZCOUNT=0 F ZZCOUNT=0:0 S ZZCOUNT=$O(^FH(119.73,ZZCOUNT)) Q:ZZCOUNT'>0  S ZOUT=ZZCOUNT
 R !!,"Print report for all Communications Offices Y or N: ",ZCO:DTIME W ! S ZCO=$TR(ZCO,"y","Y")
 I ZCO'="Y" D N2 I (Y=-1)&(CO="") Q
 ;
DATE ;sets date
 ;
 K %DT(0) S %DT="AEPT",%DT("A")="Enter beginning date: " D ^%DT Q:Y<0
 S FHSDT=Y,%DT(0)=FHSDT,%DT("A")="Enter ending date: " D ^%DT Q:Y<0
 S FHEDT=Y
 S DIR(0)="SA^A:Admissions;D:Discharges"
 S DIR("A")="Select type of movement for this report: " D ^DIR
 Q:Y["^"!(Y="")  S TYP=Y
 D DEV Q
 ;
EN ;get admission/monitor information
 Q:XX="*"
 I ZCO'="Y" S CONUMX=CONUMX-1 G:CONUMX=0 THEND  S COXX=$P(CO,"^",CONUMX),CNAME=$P(CONAME,"^",CONUMX)
 I ZCO="Y" S COXX=COXX+1 G:COXX>ZOUT THEND  S CNAME=$G(^FH(119.73,COXX,0)),CNAME=$P(CNAME,"^")
 I $D(^FH(119.73,COXX,"I"))!'$D(^FH(119.73,COXX,0)) G EN
 ;
 I TYP'="A" G EN1 Q
 S PG=0,EX="",Y=DT X ^DD("DD") S FHNDT=Y D HDR
 S MVTOT=0,MONTOT=0
 S I=FHSDT F  S I=$O(^DGPM("ATT1",I)) Q:'I!(I>FHEDT)!(EX=U)  D 
 .S J=0 F  S J=$O(^DGPM("ATT1",I,J)) Q:'J!(EX=U)  S REC=$G(^DGPM(J,0)) S WARD=$P(REC,"^",6) Q:WARD=""  D COFF2 Q:FHCOMM=""  Q:$D(^FH(119.73,FHCOMM,"I"))  Q:FHCOMM'=COXX  D
 ..S ADM=J,ADMD=I D WRT
 .Q
 Q:XX="*"
 D END
 D EN
 Q
 ;
COFF ;get communication offices
 Q:'$D(^DIC(42,"B",WARD))
 S WARDIEN=$O(^DIC(42,"B",WARD,""))
 Q:'$D(^FH(119.6,"AW",WARDIEN))
 S FHWARD=$O(^FH(119.6,"AW",WARDIEN,""))
 S FHCOMM=$P($G(^FH(119.6,FHWARD,0)),"^",8)
 Q
 ;
COFF2 ;
 Q:'$D(^FH(119.6,"AW",WARD))
 S FHWARD=$O(^FH(119.6,"AW",WARD,""))
 S FHCOMM=$P($G(^FH(119.6,FHWARD,0)),"^",8)
 Q
 ;
WRT ;write info
 ; 
 S DFN=$P(^DGPM(J,0),U,3) I $Y>(IOSL-4) D PG I EX=U S XX="*" Q
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 S Y=$P(ADMD,".") X ^DD("DD") W !,Y,?13,$E($P($G(^DPT(DFN,0)),U,1),U,23)
 W ?39,$E($P($G(^DPT(DFN,0)),U,9),6,9) S MVTOT=MVTOT+1
 I $D(^FHPT(FHDFN,"A",ADM,"MO","B")) W ?48,"Yes" S MONTOT=MONTOT+1
 S Y=$P($P($G(^FHPT(FHDFN,"A",ADM,0)),U,14),".",1) I Y X ^DD("DD") W ?56,Y
 I $Y>(IOSL-4) D PG I EX=U S XX="*" Q
 Q
 ;
EN1 ;discharges
 S PG=0,EX="",Y=DT X ^DD("DD") S FHNDT=Y D HDR I EX=U S XX="*" Q
 S MVTOT=0,MONTOT=0
 S I=FHSDT F  S I=$O(^DGPM("ATT3",I)) Q:'I!(I>FHEDT)!(EX=U)  D
 .S J=0 F  S J=$O(^DGPM("ATT3",I,J)) Q:'J!(EX=U)  S D0=J D WARD^DGPMUTL S WARD=X Q:WARD=""  D COFF Q:FHCOMM=""  Q:$D(^FH(119.73,FHCOMM,"I"))  Q:FHCOMM'=COXX  D
 ..S ADM=$P(^DGPM(J,0),U,14)
 ..S ADMD=$P(^DGPM(ADM,0),U,1) D WRT
 .Q
 D END
 D EN Q
 ;
END ;end/kill/quit
 ;
 I EX=U Q
 W !!,"TOTAL "_$S(TYP="A":"ADMISSIONS",TYP="D":"DISCHARGES")_": ",?22,MVTOT S ALLMV=ALLMV+MVTOT
 W !,"TOTAL WITH MONITORS:",?22,MONTOT S ALLMON=ALLMON+MONTOT
 S FHPER=0 I MONTOT>0,MVTOT>0 S FHPER=(MONTOT/MVTOT)*100
 I $L($P(FHPER,".",2))>2 S FHPER=$P(FHPER,".",1)_"."_$E($P(FHPER,".",2),1,2)
 W !,"Percentage of "
 W $S(TYP="A":"Admissions",TYP="D":"Discharges")
 W " with Monitors: ",FHPER,"%"
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
 Q
 ;
THEND ;end/kill/quit
 ;
 I EX=U Q
 S CNAME="ALL "
 D HDR
 W !!,"ALL TOTAL "_$S(TYP="A":"ADMISSIONS",TYP="D":"DISCHARGES")_": ",?22,ALLMV
 W !,"TOTAL WITH MONITORS:",?22,ALLMON
 S ALLFHPER=0 I ALLMON>0,ALLMV>0 S ALLFHPER=(ALLMON/ALLMV)*100
 I $L($P(ALLFHPER,".",2))>2 S ALLFHPER=$P(ALLFHPER,".",1)_"."_$E($P(ALLFHPER,".",2),1,2)
 W !,"Percentage of "
 W $S(TYP="A":"Admissions",TYP="D":"Discharges")
 W " with Monitors: ",ALLFHPER,"%"
 Q
 ;
 ;
DEV ;get device and set up queue
 S TAG=$S(TYP="A":"EN",TYP="D":"EN")
 K %ZIS,IOP S %ZIS="Q" D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D @TAG,^%ZISC Q
 S ZTRTN=TAG_"^FHMMNADM",ZTSAVE("FHSDT")="",ZTSAVE("FHEDT")=""
 S ZTSAVE("ZCO")="",ZTSAVE("COXX")="",ZTSAVE("CONUMX")="",ZTSAVE("ZOUT")="",ZTSAVE("XX")=""
 S ZTSAVE("CNAME")="",ZTSAVE("FHCOMM")="",ZTSAVE("CO")="",ZTSAVE("CONAME")=""
 S ZTSAVE("ALLMV")="",ZTSAVE("ALLMON")="",ZTSAVE("ALLFHPER")=""
 S ZTSAVE("TYP")="",ZTDESC="Dietetics Monitor Report" D ^%ZTLOAD
 W !,"Task #",ZTSK
 D ^%ZISC K %ZIS,IOP Q
 Q
 ;
KL ;
 K I,J,DFN,FHDFN,SSN,MVTOT,MONTOT,FHPER,X,Y,PG,FHNDT,ADM,CO,CONAME,CONAM,WARD,FHCOMM,ALLMON,ALLMV
 K TAG,DIR,%DT,ADDT Q
 Q
 ;
N2 ;Find Communications Office
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
 ;
 W:$Y @IOF
 W !,"DIETETIC MONITOR REPORT (Monitoring "
 W $S(TYP="A":"Admissions",TYP="D":"Discharges")_")"
 W !,FHNDT,?60,"Page: " S PG=PG+1 W PG,!
 W !,?5,"Communication Offices: ",CNAME,!!
 W "Admission",?13,"Patient",?39,"SSN",?45,"Monitor?",?56,"Discharge"
 W ! F Z=1:1:79 W "="
 Q
