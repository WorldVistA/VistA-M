PSOP2 ;BIR/SAB - medication profile long or short ;02/25/94
 ;;7.0;OUTPATIENT PHARMACY;**15,98,132,326**;DEC 1997;Build 11
 ;External reference to File #55 supported by DBIA 2228
 ;External reference to PSDRUG supported by DBIA 221
 ;External reference ^PS(50.606 supported by DBIA 2174
 ;External reference ^PS(50.7 supported by DBIA 2223
DATE I $G(DTS) D  Q:'$G(TRDT)
 .S:$P(^PSRX(J,0),"^",13)'<SDT&($P(^(0),"^",13)'>EDT) TRDT=1
 S X=$P(^PSRX(J,0),"^",13),X=999999999-X,^TMP($J,X,J)=^(0) K TRDT
 Q
DRUG Q:'$D(^PSDRUG(+$P(^PSRX(J,0),"^",6),0))  S DRG=$P(^(0),"^")
 I $G(DRS) D  Q:'$G(TRDR)
 .I DRG]PSFR,PSTO]DRG S TRDR=1
 I $P($G(^PSRX(J,3)),"^",5),$P($G(^PSRX(J,3)),"^",5)<PSODTCT,$P($G(^("STA")),"^")>11,$P($G(^("STA")),"^")'=16 K TRDR Q
 I $P($G(^PSRX(J,2)),"^",6)'<PSODTCT S ^TMP($J,$E(DRG,1,31),J)=^PSRX(J,0) K TRDR
 Q
CLSS Q:'$D(^PSDRUG(+$P(^PSRX(J,0),"^",6),0))  S DRG=$P(^(0),"^",2)
 I $G(CLS) D  Q:'$G(TRCL)
 .I DRG]PSFR,PSTO]DRG S TRCL=1
 I $P($G(^PSRX(J,3)),"^",5),$P($G(^PSRX(J,3)),"^",5)<PSODTCT,$P($G(^("STA")),"^")>11,$P($G(^("STA")),"^")'=16 K TRCL Q
 I $P($G(^PSRX(J,2)),"^",6)'<PSODTCT S ^TMP($J,$S(DRG]"":$E(DRG,1,31),1:"UNKNOWN"),J)=^PSRX(J,0) K TRCL
 Q
PEND ;list pending orders
 S PPPCNT=1 F PPP=0:0 S PPP=$O(^PS(52.41,"P",DFN,PPP)) Q:'PPP  S PPPSTAT=$P($G(^PS(52.41,PPP,0)),"^",3) I PPPSTAT="NW"!(PPPSTAT="HD")!(PPPSTAT="RNW") D
 .S PSOPEND(PPPCNT)=PPP_"^"_$S(+$P($G(^PS(52.41,PPP,0)),"^",9):"DD",1:"OI")_"^"_$P($G(^(0)),"^",5)_"^"_$P(^(0),"^",6)_"^"_$P(^(0),"^",10)_"^"_$P(^(0),"^",11) S PPPCNT=PPPCNT+1
 Q:PPPCNT=1  I $E(IOST)="C" D DIR^PSOP1 Q:$G(PQT)
 D HD1 S PPCOUNT=1 F EEEE=0:0 S EEEE=$O(PSOPEND(EEEE)) Q:'EEEE!($G(PQT))  D
 .S PENDREX=$P(PSOPEND(EEEE),"^"),PPDIS=$P($G(^PS(52.41,PENDREX,0)),"^",9),PPOI=$P($G(^(0)),"^",8)
 .W:PPCOUNT>1 ! W !,"Drug: ",$S($P(PSOPEND(EEEE),"^",2)="DD":$P($G(^PSDRUG(+PPDIS,0)),"^"),1:$P($G(^PS(50.7,+PPOI,0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")),! S PPCOUNT=PPCOUNT+1
 .W ?1,"Eff. Date: ",$E($P(PSOPEND(EEEE),"^",4),4,5)_"-"_$E($P(PSOPEND(EEEE),"^",4),6,7)_"-"_$E($P(PSOPEND(EEEE),"^",4),2,3),?22,"Qty: ",$P(PSOPEND(EEEE),"^",5),?40,"Refills: ",$P(PSOPEND(EEEE),"^",6)
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="M",X="`"_+$P(PSOPEND(EEEE),"^",3) D ^DIC K DIC,X
 .W ?52,"Prov: "_$E($P(Y,"^",2),1,21)
 .D:($Y+5>IOSL)&($E(IOST)="C") DIR^PSOP1 Q:$G(PQT)  D:$Y+5>IOSL HD1
 .S PCOUNT=1 W !?1,"Sig: " F AAAA=0:0 S AAAA=$O(^PS(52.41,PENDREX,"SIG",AAAA)) Q:'AAAA!($G(PQT))  W:PCOUNT>1 ! W ?6,$G(^PS(52.41,PENDREX,"SIG",AAAA,0)) S PCOUNT=PCOUNT+1 D:($Y+5>IOSL)&($E(IOST)="C") DIR^PSOP1 Q:$G(PQT)  D:$Y+5>IOSL
 ..D HD1 S PPCOUNT=$S('$O(^PS(52.41,PENDREX,"SIG",AAAA)):1,1:PPCOUNT)
 I '$G(PQT),$E(IOST)="C" D DIR^PSOP1
 Q
HD1 ;W @IOF W !,?29,"PENDING ORDERS",!,PSOPLINE
 I $G(PLS)="L" S PAGE=PAGE+1
 W @IOF W !,"Patient: "_$P($G(^DPT(DFN,0)),"^"),?70,"Page: "_PAGE,!?21,$S($G(NVA):"Non-VA MEDS (Not Dispensed by VA)",1:"Pending Outpatient Orders"),!,PSOPLINE
 I $G(PLS)="S" S PAGE=PAGE+1
 Q
NVA ;non-va meds
 Q:'$O(^PS(55,DFN,"NVA",0))
 W !!,PSOPLINE,!?(80-$L("Non-VA MEDS (Not Dispensed by VA)"))/2,"Non-VA MEDS (Not Dispensed by VA)",!
 K PQT S PCNT=1 F PPP=0:0 S PPP=$O(^PS(55,DFN,"NVA",PPP)) Q:'PPP!($G(PQT))  S NVAOR=^PS(55,DFN,"NVA",PPP,0),NVA=1 D
 .;I PCNT D HD1 S PCNT=0
 .Q:'$P(NVAOR,"^")
 .I $Y+10>IOSL,$E(IOST)="C" D DIR^PSOP1 Q:$D(PQT)  W @IOF
 .I $Y+11>IOSL,$E(IOST)'="C" D HD1
 .W !!,$S($P(NVAOR,"^",2):$P($G(^PSDRUG(+$P(NVAOR,"^",2),0)),"^"),1:$P($G(^PS(50.7,$P(NVAOR,"^"),0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"))
 .I PLS="S" D  Q
 ..W !?2,"Dosage: "_$P(NVAOR,"^",3)
 ..W !?2,"Schedule: "_$P(NVAOR,"^",5)
 ..W !?2,"Date Documented: "
 ..W $E($P(NVAOR,"^",10),4,5)_"/"_$E($P(NVAOR,"^",10),6,7)_"/"_$E($P(NVAOR,"^",10),2,3)
 ..W !?2,"Status: "_$S($P(NVAOR,"^",7):"Discontinued ("_$E($P(NVAOR,"^",7),4,5)_"/"_$E($P(NVAOR,"^",7),6,7)_"/"_$E($P(NVAOR,"^",7),2,3)_")",1:"Active")
 .I ($Y+5)>IOSL,$E(IOST)'="C" D HD1
 .W !?2,"Dosage: "_$P(NVAOR,"^",3)
 .W !?2,"Schedule: "_$P(NVAOR,"^",5)
 .W !?2,"Route: "_$P(NVAOR,"^",4)
 .W !?2,"Status: "_$S($P(NVAOR,"^",7):"Discontinued ("_$E($P(NVAOR,"^",7),4,5)_"/"_$E($P(NVAOR,"^",7),6,7)_"/"_$E($P(NVAOR,"^",7),2,3)_")",1:"Active")
 .W !?2,"Start Date: "_$E($P(NVAOR,"^",9),4,5)_"/"_$E($P(NVAOR,"^",9),6,7)_"/"_$E($P(NVAOR,"^",9),2,3),?$X+5,"CPRS Order #: "_$P(NVAOR,"^",8)
 .W !?2,"Documented By: "_$S($G(^VA(200,$P(NVAOR,"^",11),0))]"":$P(^VA(200,$P(NVAOR,"^",11),0),"^"),1:"Unknown")_" on "_$E($P(NVAOR,"^",10),4,5)_"/"_$E($P(NVAOR,"^",10),6,7)_"/"_$E($P(NVAOR,"^",10),2,3)
 .I ($Y+5)>IOSL,$E(IOST)'="C" D HD1
 .I $O(^PS(55,DFN,"NVA",PPP,"OCK",0)) W !?2,"Order Check(s):" D
 ..I ($Y+5)>IOSL,$E(IOST)'="C" D HD1 W !?2,"Order Check(s):"
 ..F NVAP=0:0 S NVAP=$O(^PS(55,DFN,"NVA",PPP,"OCK",NVAP)) Q:'NVAP  W !?3,"#"_NVAP_". "_$P(^PS(55,DFN,"NVA",PPP,"OCK",NVAP,0),"^") S PRV=$P(^(0),"^",2) D  I ($Y+5)>IOSL,$E(IOST)'="C" D HD1 W !?2,"Order Check(s):"
 ...I ($Y+5)>IOSL,$E(IOST)'="C" D HD1
 ...I $O(^PS(55,DFN,"NVA",PPP,"OCK",NVAP,"OVR",0)) W !?5,"Override Reason: " D
 ....I ($Y+5)>IOSL,$E(IOST)'="C" D HD1
 ....F NVAPR=0:0 S NVAPR=$O(^PS(55,DFN,"NVA",PPP,"OCK",NVAP,"OVR",NVAPR)) Q:'NVAPR  W ?22,^PS(55,DFN,"NVA",PPP,"OCK",NVAP,"OVR",NVAPR,0),!
 ..W ?2,"Override Provider: "_$P(^VA(200,PRV,0),"^"),!
 .I ($Y+5)>IOSL,$E(IOST)'="C" D HD1
 .I $O(^PS(55,DFN,"NVA",PPP,"DSC",0)) W !?2,"Statement/Explanation/Comments: " D
 ..I ($Y+5)>IOSL,$E(IOST)'="C" D HD1
 ..F NVAP=0:0 S NVAP=$O(^PS(55,DFN,"NVA",PPP,"DSC",NVAP)) Q:'NVAP  W $P(^PS(55,DFN,"NVA",PPP,"DSC",NVAP,0),"^"),!?34
 W ! K NVA,NVAP,NVAPR,NVAOR
 Q
