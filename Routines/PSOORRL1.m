PSOORRL1 ;BHAM ISC/SAB,TJH - sub-module for PSOORRL ;01/14/99
 ;;7.0;OUTPATIENT PHARMACY;**20,46,132,159**;DEC 1997
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.607 supported by DBIA 2221
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PS(51 supported by DBIA 2224
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(55 supported by DBIA 2228
 ;
MDR ;
 S ^TMP("PS",$J,"MDR",0)=0,(MDR,MR)=0 F  S MR=$O(^PSRX(IFN,"MEDR",MR)) Q:'MR  D
 .Q:'$D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0))  S MDR=MDR+1
 .I $P($G(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),"^",3)]"" S ^TMP("PS",$J,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^",3)
 .I $D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),$P($G(^(0)),"^",3)']"" S ^TMP("PS",$J,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^")
 .S ^TMP("PS",$J,"MDR",0)=^TMP("PS",$J,"MDR",0)+1
 Q
 ;
PEN ;
 ;BHW;PSO*7*159;New SD Variable
 N SD
 Q:'$D(^PS(52.41,IFN,0))!($P($G(^PS(52.41,IFN,0)),"^",3)="RF")  S PSOR=^PS(52.41,IFN,0)
 S ^TMP("PS",$J,0)=$S($P(PSOR,"^",9):$P($G(^PSDRUG($P(PSOR,"^",9),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^",8),0),"^",2),0),"^"))
 I $P(PSOR,"^",9) D
 .S ^TMP("PS",$J,"DD",0)=1
 .S COD=$S('$G(^PSDRUG($P(PSOR,"^",9),"I")):1,+$G(^PSDRUG($P(PSOR,"^",9),"I"))>DT:1,1:0)
 .S ^TMP("PS",$J,"DD",1,0)=$P(PSOR,"^",9)_"^^"_$S($P($G(^PSDRUG($P(PSOR,"^",9),2)),"^",3)["U"&(COD):$P(PSOR,"^",9),1:"") K COD
 S ^TMP("PS",$J,0)=^TMP("PS",$J,0)_"^"_$S($G(^PS(51.2,+$P(PSOR,"^",15),0))]"":$P(^PS(51.2,+$P(PSOR,"^",15),0),"^",3),1:"")_"^^"_$P(PSOR,"^",11)_"^"_$P($P(PSOR,"^",6),".")_"^"_$S($P(PSOR,"^",3)'="HD":"PENDING",1:" ON HOLD")_"^^"_$P(PSOR,"^",10)
 S $P(^TMP("PS",$J,0),"^",11)=$P(PSOR,"^")
 S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,1,SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,"SCH",SD,0)=$P(^PS(52.41,IFN,1,SCH,1),"^"),^TMP("PS",$J,"SCH",0)=SD
 S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,"SIG",SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,"SIG",SD,0)=$P(^PS(52.41,IFN,"SIG",SCH,0),"^"),^TMP("PS",$J,"SIG",0)=SD
 S (IEN,SD)=1,INST=0 F  S INST=$O(^PS(52.41,IFN,2,INST)) Q:'INST  S (MIG,INST(INST))=^PS(52.41,IFN,2,INST,0),^TMP("PS",$J,"SIO",0)=SD D
 .F SG=1:1:$L(MIG," ") S:$L($G(^TMP("PS",$J,"SIO",SD,0))_" "_$P(MIG," ",SG))>80 SD=SD+1,^TMP("PS",$J,"SIO",0)=SD S ^TMP("PS",$J,"SIO",SD,0)=$G(^TMP("PS",$J,"SIO",SD,0))_" "_$P(MIG," ",SG)
END K FL,SD,SCH,%T,Y,ST,ST0,PSBDT,PSEDT,IFN,EXDT,RX0,RX2,RX3,TRM,I,X,Z1,Z0,PSOX1,PSOX2,PSOR,STA,TFN,X1,X2,SC,MDR,MR,IFN,MIG,INST
 K BDT,EDT,IEN,ITFN,RXNUM
 Q
NVA ;non-va meds display
 Q:'$D(^PS(55,DFN,"NVA",IFN,0))!('$P($G(^PS(55,DFN,"NVA",IFN,0)),"^"))
 S PSOR=^PS(55,DFN,"NVA",IFN,0)
 S ^TMP("PS",$J,0)=$S($P(PSOR,"^",2):$P($G(^PSDRUG($P(PSOR,"^",2),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^"),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^"),0),"^",2),0),"^"))
 I $P(PSOR,"^",2) D
 .S ^TMP("PS",$J,"DD",0)=1
 .S COD=$S('$G(^PSDRUG($P(PSOR,"^",2),"I")):1,+$G(^PSDRUG($P(PSOR,"^",2),"I"))>DT:1,1:0)
 .S ^TMP("PS",$J,"DD",1,0)=$P(PSOR,"^",2)_"^^"_$S($P($G(^PSDRUG($P(PSOR,"^",2),2)),"^",3)["U"&(COD):$P(PSOR,"^",2),1:"") K COD
 S ^TMP("PS",$J,0)=^TMP("PS",$J,0)_"^^^N/A^"_$P($P(PSOR,"^",9),".")_"^"_$S('$P(PSOR,"^",7):"ACTIVE",1:"DISCONTINUED")_"^^N/A^^^"_$P(PSOR,"^",8)
 S ^TMP("PS",$J,"SCH",1,0)=$P(PSOR,"^",5),^TMP("PS",$J,"SCH",0)=1
 S ^TMP("PS",$J,"SIG",1,0)=$P(PSOR,"^",3)_" "_$P(PSOR,"^",4)_" "_$P(PSOR,"^",5),^TMP("PS",$J,"SIG",0)=1
 S ^TMP("PS",$J,"SIO",1,0)=$P(PSOR,"^",3)_" "_$P(PSOR,"^",4)_" "_$P(PSOR,"^",5),^TMP("PS",$J,"SIO",0)=1
 K PSOR
 Q
 ;
SIG ;expands SIG expanded list
 F Z0=1:1:$L(X," ") G:Z0="" EN S Z1=$P(X," ",Z0) D
 .D:$D(X)&($G(Z1)]"")
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
 .I $G(^TMP("PS",$J,"SIG",1,0))']"" S ^TMP("PS",$J,"SIG",1,0)=Z1,^TMP("PS",$J,"SIG",0)=1 Q
 .F PSOX1=0:0 S PSOX1=$O(^TMP("PS",$J,"SIG",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 .I $L(^TMP("PS",$J,"SIG",PSOX2,0))+$L(Z1)<245 S ^TMP("PS",$J,"SIG",PSOX2,0)=^TMP("PS",$J,"SIG",PSOX2,0)_" "_Z1
 .E  S PSOX2=PSOX2+1,^TMP("PS",$J,"SIG",PSOX2,0)=Z1
EN K Z1,Z0,PSOX1 Q
 ;
SIG1 ;expands SIG for condensed list
 F Z0=1:1:$L(X," ") G:Z0="" EN S Z1=$P(X," ",Z0) D
 .D:$D(X)&($G(Z1)]"")
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
 .I $G(^TMP("PS",$J,TFN,"SIG",1,0))']"" S ^TMP("PS",$J,TFN,"SIG",1,0)=Z1,^TMP("PS",$J,TFN,"SIG",0)=1 Q
 .F PSOX1=0:0 S PSOX1=$O(^TMP("PS",$J,TFN,"SIG",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 .I $L(^TMP("PS",$J,TFN,"SIG",PSOX2,0))+$L(Z1)<245 S ^TMP("PS",$J,TFN,"SIG",PSOX2,0)=^TMP("PS",$J,TFN,"SIG",PSOX2,0)_" "_Z1
 .E  S PSOX2=PSOX2+1,^TMP("PS",$J,TFN,"SIG",PSOX2,0)=Z1
 Q
