PSOPRF ;BHAM ISC/SAB - PRINTS A PROFILE ;11/18/92
 ;;7.0;OUTPATIENT PHARMACY;**19,132,300,320,326**;DEC 1997;Build 11
 ;External reference to File #55 supported by DBIA 2228
 ;External reference ^PS(50.606 supported by DBIA 2174
 ;External reference ^PS(50.7 supported by DBIA 2223
 ;External reference ^PSDRUG( supported by DBIA 221
 ;PHARMACIST IN REVEIWING RX'S WHEN ADDING A 'NEW' RX
Q D CUTDATE^PSOFUNC
QOLD D PLBL^PSORXL
 Q
 ;
DQ S:'$D(PFIO) PFIO=IO D START D KILL^%ZTLOAD Q
 ;
START D:('$D(PSOBMST)) EN1P^PSOBSET K Z S IOP=PFIO D ^%ZIS U IO I '$D(PSODTCUT) D CUTDATE^PSOFUNC
 S:'$D(Z) Z=1 S:'$D(NEW1) (NEW1,NEW11)="^" S %DT="",X="T" D ^%DT S DT=Y S X1=DT,X2=-365 D C^%DTC S EXPS=X S X1=DT,X2=-182 D C^%DTC S EXP=X
 K ^TMP($J,"PRF") S LINE="" F I=1:1:110 S LINE=LINE_"-"
 F RXX=0:0 S RXX=$O(^PS(55,DFN,"P",RXX)) Q:'RXX  S RXNN=+^(RXX,0) I $D(^PSRX(RXNN,0)),$P($G(^("STA")),"^")'=13 S RXPX=^PSRX(RXNN,0),$P(RXPX,"^",15)=$P($G(^("STA")),"^"),RXPX2=^(2) D CHK
 D HD I '$D(^TMP($J,"PRF")) W !!?Z+15,"****** NO RX DATA ******",! G PPP
 ;
SD F SD="A","C","S" W:SD="S" !,?Z+1,"SUPPLIES",$E(LINE,1,89) I $D(^TMP($J,"PRF",SD)) S DRNME="" D DRNME
PPP D PEND,NVA
 W !!,"NAME: "_$P(^DPT(DFN,0),"^"),!
 W:IOF]"" @IOF K ^TMP($J,"PRF"),A,B,DRNME,DRP,EXP,EXPS,I,II,ISSD,J,LINE,LN,MESS,MJK,NEW1,NEW11,PHYS,POP,QTY,TTTT,RFL,RFS,RXF,RXNN,RXPX,RXPX2,RXPNO,RXX,SD,SIG,STA,X,X1,X2,Y,Z
 Q
 ;
DRNME S DRNME=$O(^TMP($J,"PRF",SD,DRNME)) Q:DRNME=""  D ISSD G DRNME
 ;
ISSD F ISSD=0:0 S ISSD=$O(^TMP($J,"PRF",SD,DRNME,ISSD)) Q:'ISSD  S RXPNO="" D RXPNO
 Q
 ;
RXPNO S RXPNO=$O(^TMP($J,"PRF",SD,DRNME,ISSD,RXPNO)) Q:RXPNO=""  S RXNN=^(RXPNO) I $D(^PSRX(RXNN,0)) S RXPX=^(0),RXPX2=^(2) D PRT G RXPNO
 W "END***************"
 ;
CHK Q:PSODTCUT>$P(RXPX2,"^",6)
 I $P(^PSRX(RXNN,"STA"),"^")=12 S II=RXNN D LAST^PSORFL Q:PSODTCUT>RFDATE
 I $P(RXPX,"^",3)=7!($P(RXPX,"^",3)=8)&('PSOPRPAS) Q
 S J="^"_RXNN_"^" Q:(NEW1[J)!(NEW11[J)  Q:$P(RXPX,"^",13)<EXPS  S RXPNO=$P(RXPX,"^"),ISSD=$P(RXPX,"^",13)
 Q:'$D(^PSDRUG($P(RXPX,"^",6),0))  S DRP=^(0),SD=$S($P(DRP,"^",3)["S":"S",$P(RXPX,"^",15)=12:"C",1:"A"),DRNME=$P(DRP,"^"),^TMP($J,"PRF",SD,DRNME,ISSD,RXPNO)=RXNN
 Q
 ;
PRT S RFS=$P(RXPX,"^",9),QTY=$P(RXPX,"^",7)
 S PHYS=$S($D(^VA(200,$P(RXPX,"^",4),0)):$P(^(0),"^"),1:"UNKNOWN"),II=RXNN D LAST^PSORFL S RXF=0 F MJK=0:0 S MJK=$O(^PSRX(RXNN,1,MJK)) Q:'MJK  S RXF=RXF+1
 S STA=$S($P(^PSRX(RXNN,"STA"),"^")=14:"DC",$P(^PSRX(RXNN,"STA"),"^")=15:"DE",$P(^PSRX(RXNN,"STA"),"^")=16:"PH",1:$E("ANRHPS     ECD",(1+$P(^PSRX(RXNN,"STA"),"^")))),STA=$S(DT>$P(RXPX2,"^",6):"E",1:STA)
 W !,?Z+1,RXPNO,?Z+15,DRNME,?Z+55,$E(ISSD,4,5),"/",$E(ISSD,6,7)," ",$E(RFL,1,5)," ",?Z+67,$J(RFS,2)," ",$J(RXF,2)," ",?Z+73,$J(QTY,12)," ",?Z+86,STA," ",?Z+88,$E(PHYS,1,20)
 D SIG F TTTT=0:0 S TTTT=$O(FSIG(TTTT)) Q:'TTTT  W !,?Z+19,FSIG(TTTT)
 Q
 ;
HD D PID^VADPT
 W !,?Z+17,"PRESCRIPTION PROFILE AS OF ",$E(DT,4,5),"/",$E(DT,6,7),"/",($E(DT,1,3)+1700),!!,?Z+20,"NAME: "_$P(^DPT(DFN,0),"^")
 I $D(^PS(55,DFN,1)) S MESS=^(1),LN=$L(MESS),A=0 W ! F B=1:1 Q:$P(MESS," ",B,99)=""  W:$X>(Z+63) ! W ?Z+31,$P(MESS," ",B)," "
 I $$RDI^PSORMRX(DFN) W !!,"THIS PATIENT HAS PRESCRIPTIONS AT OTHER FACILITIES"
 W !!?Z+20,"PHARMACIST: ___________________________  DATE: ____________"
 W !!?Z+52,"   DATES   ",?Z+67,"REFS ",?Z+86,"S"
 W !?Z+1,"RX #     ",?Z+15,"DRUG/STRENGTH/SIG",?Z+55,"ISSD  LAST ",?Z+67,"AL AC",?Z+77,"QTY",?Z+86,"T",?Z+93,"PROVIDER"
 W !?Z+1,$E(LINE,1,12),?Z+15,$E(LINE,1,35),?Z+55,"----- -----",?Z+67,"-- --",?Z+73,"------------",?Z+86,"-",?Z+88,$E(LINE,1,20)
 Q
SIG ;Format Sig
 S PSPROSIG=$P($G(^PSRX(RXNN,"SIG")),"^",2) K FSIG,BSIG D
 .I PSPROSIG D FSIG^PSOUTLA("R",RXNN,80) Q
 .D EN2^PSOUTLA1(RXNN,80) F GGGGG=0:0 S GGGGG=$O(BSIG(GGGGG)) Q:'GGGGG  S FSIG(GGGGG)=BSIG(GGGGG)
 K PSPROSIG,GGGGG,BSIG Q
PEND ;Print Pending Orders
 N PSPCOUNT,PSPPEND,ZXXX,PSPSTAT,FSIGZZ,PZZDRUG,PSSODRUG,PZXZERO,PPPPP,GGGGG
 S PSPCOUNT=1,PSPPEND="" F PPPPP=0:0 S PPPPP=$O(^PS(52.41,"P",DFN,PPPPP)) Q:'PPPPP  S PSPSTAT=$P($G(^PS(52.41,PPPPP,0)),"^",3) I PSPSTAT="NW"!(PSPSTAT="HD")!(PSPSTAT="RNW") S PSPPEND(PSPCOUNT)=PPPPP,PSPCOUNT=PSPCOUNT+1
 Q:'$O(PSPPEND(0))
 W !!,?48,"PENDING ORDERS",!,LINE,!
 F ZXXX=0:0 S ZXXX=$O(PSPPEND(ZXXX)) Q:'ZXXX  S PZXZERO=$G(^PS(52.41,PSPPEND(ZXXX),0)) D:$P(PZXZERO,"^")
 .S PZZDRUG=$P(PZXZERO,"^",9),PZZODRUG=$P(PZXZERO,"^",8)
 .W !,"Drug: ",$S(PZZDRUG:$P($G(^PSDRUG(+PZZDRUG,0)),"^"),1:$P($G(^PS(50.7,+PZZODRUG,0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"))
 .W !?3,"Eff. Date: ",$E($P(PZXZERO,"^",6),4,5)_"/"_$E($P(PZXZERO,"^",6),6,7)_"/"_($E($P(PZXZERO,"^",6),1,3)+1700)
 .W ?25,"Qty: ",$P(PZXZERO,"^",10),?50,"Refills: ",$P(PZXZERO,"^",11),?65,"Provider: ",$P($G(^VA(200,+$P(PZXZERO,"^",5),0)),"^")
 .D FSIG^PSOUTLA("P",PSPPEND(ZXXX),100) W !?3,"Sig: ",$G(FSIG(1)) F FSIGZZ=1:0 S FSIGZZ=$O(FSIG(FSIGZZ)) Q:'FSIGZZ  W !?8,$G(FSIG(FSIGZZ))
 Q
NVA ;displays non-va meds
 Q:'$G(DFN)!('$O(^PS(55,DFN,"NVA",0)))
 W !!?48,"Non-VA MEDS (Not dispensed by VA)",!,LINE
 F NVA=0:0 S NVA=$O(^PS(55,DFN,"NVA",NVA)) Q:'NVA  D
 .S DUPRX0=^PS(55,DFN,"NVA",NVA,0) Q:'$P(DUPRX0,"^")
 .W !!,"Orderable Item: "_$P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")_"   Drug: "_$S($P(DUPRX0,"^",2):$P(^PSDRUG($P(DUPRX0,"^",2),0),"^"),1:"No Dispense Drug Selected")
 .W !,"Status: "_$S($P(DUPRX0,"^",7):"Discontinued ("_$$FMTE^XLFDT($P($P(DUPRX0,"^",7),"."))_")",1:"Active")
 .W !,"Drug Class: "_$S($P(DUPRX0,"^",2):$P(^PSDRUG($P(DUPRX0,"^",2),0),"^",2),1:"")
 .W !,"Dosage: "_$P(DUPRX0,"^",3),!,"Schedule: "_$P(DUPRX0,"^",5),!,"Medication Route: "_$P(DUPRX0,"^",4)
 .W !,"Start Date: "_$$FMTE^XLFDT($P(DUPRX0,"^",9)),?40,"CPRS Order #: "_$P(DUPRX0,"^",8)
 .W !,"Documented By: "_$P(^VA(200,$P(DUPRX0,"^",11),0),"^")_" on "_$$FMTE^XLFDT($P(DUPRX0,"^",10))
 W ! K NVA,DUPRXO
 Q
