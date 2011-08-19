PSOSD0 ;BHAM ISC/SAB - action or informational profile cont. ;6/21/07 8:20am
 ;;7.0;OUTPATIENT PHARMACY;**2,19,40,66,107,110,258,206**;DEC 1997;Build 39
 ;External reference to ^PS(50.605 supported by DBIA 696
 ;External reference to ^SC supported by DBIA 10040
 ;External reference to ^PSDRUG supported by DBIA 221
CLASS S (ZCLASS,CLASS)="",RXCNT=0 F Z0=0:0 S CLASS=$O(^TMP($J,"PRF",CLASS)) Q:CLASS=""  S PCLASS=$S($D(^PS(50.605,+$O(^PS(50.605,"B",CLASS,0)),0)):CLASS_" - "_$P(^(0),"^",2),1:"UNCLASSIFIED") D DRUG Q:$D(DTOUT)!($D(DUOUT))
 Q
DRUG S DRUG="" F Z1=0:0 S DRUG=$O(^TMP($J,"PRF",CLASS,DRUG)) Q:DRUG=""  S FDT="" F Z3=0:0 S FDT=$O(^TMP($J,"PRF",CLASS,DRUG,FDT)) Q:'FDT  D RXN Q:$D(DTOUT)!($D(DUOUT))
 Q
RXN I PSORM D
 .D:$S($P($G(PSOPAR),"^")&($G(PSTYPE))&('$D(DOD(DFN))):RXCNT=3,'$G(PSTYPE)!($D(DOD(DFN))):RXCNT=6,1:RXCNT=4) HD1^PSOSD2
 I 'PSORM D
 .D:$S($P($G(PSOPAR),"^")&($G(PSTYPE))&('$D(DOD(DFN))):RXCNT=2,1:RXCNT=5) HD1^PSOSD2
 S RXN=0 F Z2=0:0 S RXN=$O(^TMP($J,"PRF",CLASS,DRUG,FDT,RXN)) Q:'RXN  D   Q:$D(DTOUT)!($D(DUOUT))
 .S RX0=^TMP($J,"PRF",CLASS,DRUG,FDT,RXN),J=RXN,RX2=$S($D(^PSRX(J,2)):^(2),1:""),RX3=$G(^(3)),RXNO=RXN
 .S RXNODE=^PSRX(RXN,0),$P(RXNODE,"^",15)=+$G(^("STA")) D ENSAVE^PSODACT,RXN1
 Q
RXN1 S RFL=1,FILL(9999999-$P(RX2,"^",2))=+$P(RX2,"^",2)_"^"_$S($P(RX2,"^",15):"(R)",1:""),FILLS=+$P(RX0,"^",9)
 F II=0:0 S II=$O(^PSRX(J,1,II)) Q:'II  S FILL(9999999-^PSRX(J,1,II,0))=+^PSRX(J,1,II,0)_"^"_$S($P(^(0),"^",16):"(R)",1:"") S RFL=RFL+1
 S PHYS=$S($D(^VA(200,+$P(RX0,"^",4),0)):$P(^(0),"^"),1:"UNKNOWN")
 I 'PSTYPE,ZCLASS=CLASS,$E(IOST)="C" K DIR S DIR(0)="E" D ^DIR Q:$D(DTOUT)!($D(DUOUT))  W !
 I $S($G(PSTYPE):$Y>48,1:$Y>60)!(ZCLASS]""&(ZCLASS'=CLASS)&($S($G(PSTYPE):$Y+16>IOSL,1:$Y+8>IOSL))) D HD1^PSOSD2 Q:$D(DTOUT)!($D(DUOUT))
 I ZCLASS'=CLASS D:$S($G(PSTYPE):$Y>48,1:$Y>60) HD1^PSOSD2 W !,$S('PSORM:"Class: ",1:"Classification: ")_PCLASS,! S ZCLASS=CLASS
 I 'PSORM D EIGHTY Q
 W !,$S('$D(^PSDRUG(+$P(RX0,"^",6),0)):"",+$P(^PSDRUG(+$P(RX0,"^",6),0),"^",9):"N/F",1:"")," ",$S($D(^PSDRUG(+$P(RX0,"^",6),0)):$P(^(0),"^"),1:"NOT ON FILE")
 N ACTS D ACTS
 W ?45,"Qty: "_$P(RX0,"^",7)_" for "_$P(RX0,"^",8)_" Days ",?74,$P(RX0,"^"),?84," ",ACTS,?99,$E($P(RX2,"^",6),4,5)_"-"_$E($P(RX2,"^",6),6,7)_"-"_($E($P(RX2,"^",6),1,3)+1700)
 W ?110,$E(PHYS,1,30) D COS^PSOSDP
 I $G(^PSDRUG(+$P(RX0,"^",6),"PSO"))]"" W !," Message: "_$G(^PSDRUG(+$P(RX0,"^",6),"PSO"))
 S RXCNT=RXCNT+1 D SIG W !?9,"Sig: ",$G(BSIG(1))
 I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  W !?14,$G(BSIG(PSREV))
 K BSIG,PSREV
 S RFS=0 F RF=0:0 S RF=$O(^PSRX(RXN,1,RF)) Q:'RF  S RFS=RFS+1
 W !?10,"Filled: " F PSIII=0:0 S PSIII=$O(FILL(PSIII)) Q:'PSIII  S Y=FILL(PSIII) W:Y " ",$E($P(Y,"^"),4,5),"-",$E($P(Y,"^"),6,7),"-",($E($P(Y,"^"),1,3)+1700)_$P(Y,"^",2)
 S DUPD=$O(^TMP($J,"PRF",CLASS,DRUG,FDT)) I DUPD,RFL<6 D
 .S OLDRX2=RX2,OLDJ=J,OLDFILL=FDT,OLDRX=RXN W "  Past Fills:" D DUP S FDT=OLDFILL,J=OLDJ,RX2=OLDRX2,RXN=OLDRX K OLDJ,OLDRX2,OLDFILL,OLDRX
 W !?10,"Remaining Refills: "_($P(RX0,"^",9)-RFS),?45,"Clinic: ",$S($D(^SC(+$P(RX0,"^",5),0)):$E($P(^(0),"^"),1,30),1:"UNKNOWN")
 W ?105,"Price: " S PRICE=$S($D(^PSDRUG($P(RX0,"^",6),660)):$P(^(660),"^",6),1:0),COST=$P(RX0,"^",7)*PRICE S:COST<1 COST="0"_COST W "$",$J(COST,3,2),! K COST
 I 'PSTYPE D:$D(^PSDRUG(+$P(RX0,"^",6),"CLOZ"))&($P($G(^("CLOZ1")),"^")'="PSOCLO1") ^PSOLAB G RXN2
 G:$G(DOD(DFN))]"" RXN2
 D:+$G(PSOBAR4) BAR S PSRENW=0,PSODEA=$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^",3) I PSODEA'["1",PSODEA'["2",PSODEA'["W",$P($G(^PS(53,+$P(RX0,"^",3),0)),"^",5) S PSRENW=1
 S PSOIFSUP=$S(PSODEA']"":0,PSODEA["S":1,1:0),RXX=$P(RX0,"^"),RXX(1)="",RXX=$O(^PSRX("B",RXX,RXX(1)))
 W:$P($G(^PSRX(RXX,"IB")),"^") !?11,"****COPAY****" D PSRENW^PSOSD2
 I PSRENW W !?1,$S(PSOIFSUP:"",'$D(PSOPRINT):"",PSOPRINT]"":PSOPRINT,1:""),?11,"RENEW/MD:" F T=1:1:30 W "_" I T=30 W "VA#:" F I=1:1:10 W "_" I I=10 D
 .W "DATE__________ REFILL"
 .W $S($P(RX0,"^",8)'<60&($P(RX0,"^",8)'>89):" 0 1 2"_$S('CS:" 3 4 5",1:""),$P(RX0,"^",8)<60:" 0 1 2 3 4 5"_$S('CS:" 6 7 8 9 10 11",1:""),1:" 0 1"_$S('CS:" 2 3",1:"")),!
 I "ASH"[$E($P(RX0,"^",15)),PSTYPE D
 .W !?21,"DISCONTINUE/MD:" F T=1:1:30 W "_" I T=30 W "VA#:" F I=1:1:10 W "_" I I=10 W "DATE__________",!
 D:$D(^PSDRUG(+$P(RX0,"^",6),"CLOZ"))&($P($G(^("CLOZ1")),"^")'="PSOCLO1") PRINT^PSOLAB
RXN2 W ! K RX0,RX3,RX2,PRDT,LABEL,PHYS,PSI,PSII,PSIII,II,Y,SIG,X,FILL,FILLS,PHYS,Z9,PRICE,I,T,RXX
 Q
SIG K FSIG,BSIG I $P($G(^PSRX(RXN,"SIG")),"^",2) D FSIG^PSOUTLA("R",RXN,$S('PSORM:64,$E(IOST)="C":64,1:114)) F PSREV=1:1 Q:'$D(FSIG(PSREV))  S BSIG(PSREV)=FSIG(PSREV)
 K FSIG,PSREV I '$P($G(^PSRX(RXN,"SIG")),"^",2) D EN3^PSOUTLA1(RXN,$S('PSORM:64,$E(IOST)="C":64,1:114))
 Q
DUP ;DUP DRUG
 F Z4=0:0 Q:RFL>9  S FDT=$O(^TMP($J,"PRF",CLASS,DRUG,FDT)) Q:'FDT  D
 .F Z5=0:0 S Z5=$O(^TMP($J,"PRF",CLASS,DRUG,FDT,Z5)) Q:'Z5  S RX2=$S($D(^PSRX(Z5,2)):^(2),1:"") D:"DE"[$E($P(^TMP($J,"PRF",CLASS,DRUG,FDT,Z5),"^",15))
 ..K FILL S FILL(9999999-$P(RX2,"^",2))=+$P(RX2,"^",2)_"^"_$S($P(RX2,"^",15):"(R)",1:"") F II=0:0 S II=$O(^PSRX(Z5,1,II)) Q:'II  S FILL(9999999-$P(^PSRX(Z5,1,II,0),"^"))=$P(^PSRX(Z5,1,II,0),"^")_"^"_$S($P(^(0),"^",16):"(R)",1:"")
 ..F PSII=0:0 S PSII=$O(FILL(PSII)) Q:'PSII  W:($X+8)>$S('PSORM:80,1:IOM) !?9 S Y=FILL(PSII) W " ",$E($P(Y,"^"),4,5)_"-"_$E($P(Y,"^"),6,7)_"-"_($E($P(Y,"^"),1,3)+1700)_$P(Y,"^",2)
 ..K ^TMP($J,"PRF",CLASS,DRUG,FDT,Z5)
 Q
BAR ;barcode
 I PSOBAR4 S X="S",X2=PSOINST_"-"_RXN W !?15 S X1=$X W @PSOBAR3,X2,@PSOBAR2,$C(13) S $X=0
 Q
EIGHTY ;prints profile in 80 column format
 W !,$S('$D(^PSDRUG(+$P(RX0,"^",6),0)):"",+$P(^PSDRUG(+$P(RX0,"^",6),0),"^",9):"N/F",1:"")," ",$S($D(^PSDRUG(+$P(RX0,"^",6),0)):$P(^(0),"^"),1:"NOT ON FILE"),?45,"Rx #: "_$P(RX0,"^")
 I $G(^PSDRUG(+$P(RX0,"^",6),"PSO"))]"" W !," Message: "_$G(^PSDRUG(+$P(RX0,"^",6),"PSO"))
 N ACTS D ACTS
 W !?1,"Qty: "_$P(RX0,"^",7)_" for "_$P(RX0,"^",8)_" Days  "_ACTS,"  Exp: "_$E($P(RX2,"^",6),4,5)_"-"_$E($P(RX2,"^",6),6,7)_"-"_($E($P(RX2,"^",6),1,3)+1700)
 W ?48," Prov: "_$E(PHYS,1,30) I $P($G(^PSRX(J,3)),"^",3),$D(^VA(200,+$P($G(^(3)),"^",3),0)) W !,?43,"COSIGNER: "_$P($G(^VA(200,+$P(^PSRX(J,3),"^",3),0)),"^")
 S RXCNT=RXCNT+1 D SIG W !?9,"Sig: ",$G(BSIG(1))
 I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  W !?14,$G(BSIG(PSREV))
 K BSIG,PSREV
 S RFS=0 F RF=0:0 S RF=$O(^PSRX(RXN,1,RF)) Q:'RF  S RFS=RFS+1
 W !?10,"Filled: " F PSIII=0:0 S PSIII=$O(FILL(PSIII)) Q:'PSIII  S Y=FILL(PSIII) W:Y " ",$E($P(Y,"^"),4,5),"-",$E($P(Y,"^"),6,7),"-",($E($P(Y,"^"),1,3)+1700)_$P(Y,"^",2)
 S DUPD=$O(^TMP($J,"PRF",CLASS,DRUG,FDT)) I DUPD,RFL<6 D
 .S OLDRX2=RX2,OLDJ=J,OLDFILL=FDT,OLDRX=RXN W "  Past Fills:" D DUP S FDT=OLDFILL,J=OLDJ,RX2=OLDRX2,RXN=OLDRX K OLDJ,OLDRX2,OLDFILL,OLDRX
 W !?10,"Remaining Refills: "_($P(RX0,"^",9)-RFS),?45,"Clinic: ",$S($D(^SC(+$P(RX0,"^",5),0)):$E($P(^(0),"^"),1,30),1:"UNKNOWN")
 W !?10,"Price: " S PRICE=$S($D(^PSDRUG($P(RX0,"^",6),660)):$P(^(660),"^",6),1:0),COST=$P(RX0,"^",7)*PRICE S:COST<1 COST="0"_COST W "$",$J(COST,3,2),! K COST
 I 'PSTYPE D:$D(^PSDRUG(+$P(RX0,"^",6),"CLOZ"))&($P($G(^("CLOZ1")),"^")'="PSOCLO1") ^PSOLAB G RXN2
 G:$G(DOD(DFN))]"" RXN3
 D:+$G(PSOBAR4) BAR S PSRENW=0,PSODEA=$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^",3) I PSODEA'["1",PSODEA'["2",PSODEA'["W",$P($G(^PS(53,+$P(RX0,"^",3),0)),"^",5) S PSRENW=1
 S PSOIFSUP=$S(PSODEA']"":0,PSODEA["S":1,1:0),RXX=$P(RX0,"^"),RXX(1)="",RXX=$O(^PSRX("B",RXX,RXX(1)))
 W:$P($G(^PSRX(RXX,"IB")),"^") !?11,"****COPAY****" D PSRENW^PSOSD2
 I PSRENW W !?1,$S(PSOIFSUP:"",'$D(PSOPRINT):"",PSOPRINT]"":PSOPRINT,1:""),?6,"RENEW/MD:" F T=1:1:30 W "_" I T=30 W "VA#:" F I=1:1:10 W "_" I I=10 D
 .W "DATE__________",!?6,"REFILLS"
 .W $S($P(RX0,"^",8)'<60&($P(RX0,"^",8)'>89):" 0 1 2"_$S('CS:" 3 4 5",1:""),$P(RX0,"^",8)<60:" 0 1 2 3 4 5"_$S('CS:" 6 7 8 9 10 11",1:""),1:" 0 1"_$S('CS:" 2 3",1:"")),!
 I "ASH"[$E($P(RX0,"^",15)),PSTYPE D
 .W !?11,"DISCONTINUE/MD:" F T=1:1:26 W "_" I T=26 W "VA#:" F I=1:1:10 W "_" I I=10 W "DATE__________",!
 D:$D(^PSDRUG(+$P(RX0,"^",6),"CLOZ"))&($P($G(^("CLOZ1")),"^")'="PSOCLO1") PRINT^PSOLAB
RXN3 W ! K RX0,RX3,RX2,PRDT,LABEL,PHYS,PSI,PSII,PSIII,II,Y,SIG,X,FILL,FILLS,PHYS,Z9,PRICE,I,T,RXX
 Q
ACTS ;
 S ACTS=$S($P(RX0,"^",15)["PENDING":"PENDING",$P(RX0,"^",15)["Suspended":"Active/Susp",1:$P(RX0,"^",15))
 Q
