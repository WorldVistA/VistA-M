PSOMHV1 ;BIR/MHA - MHV API, Build patient medication ; 4/20/05 8:54am
 ;;7.0;OUTPATIENT PHARMACY;**204**;DEC 1997
 ;External reference ^PS(55 supported by DBIA 2228
 ;External reference ^PSDRUG( supported by DBIA 221
 ;External reference to ^PS(51 supported by DBIA 2224
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ; Input variables: dfn, start date, cut off date
EN(DFN,BDT,EDT) ;entry point to return medication list
 Q:'$G(DFN)
 N DRG,DRGN,EXD,I,IFN,MIG,LSTFD,ORD,PEN,PSOBD,PSOED,PSODD,PSOOI,PSOSD,RX,RX0,RX2,RX3,TFN,TD,TR,TRM,SC,SCH,ST0,STA,PSODIV
 I '$G(DT) S DT=$$DT^XLFDT
 K ^TMP("PSO",$J) S PSOBD=$G(BDT),PSOED=$G(EDT)
 I +$G(PSOBD)<1 S X1=DT,X2=-120 D C^%DTC S PSOBD=X
 S EXD=PSOBD-1
 I PSOED="" S PSOED=9999999
 F  S EXD=$O(^PS(55,DFN,"P","A",EXD)) Q:'EXD  Q:EXD>PSOED  D
 .S RX=0 F  S RX=$O(^PS(55,DFN,"P","A",EXD,RX)) Q:'RX  D:$D(^PSRX(RX,0)) GET
 S STA="ACT^NVR^REF^HLD^NVR^SUS^^^^^^EXP^DCD^DEL^DCD^DCD^HLD"
 S DRG="" F  S DRG=$O(PSOSD(DRG)) Q:DRG=""  D:$G(PSOSD(DRG))]"" 
 .S PSOSD($P(STA,"^",$P(PSOSD(DRG),"^",2)+1),DRG)=PSOSD(DRG) K PSOSD(DRG)
 D PEN D:$D(PSOSD) BLD
 Q
EN2(DFN,RXLIST) ;Entry point to return data for specified RX #s
 Q:DFN<1
 Q:'RXLIST
 N DRG,DRGN,EXD,I,IFN,MIG,LSTFD,ORD,PEN,PSOBD,PSOED,PSODD,PSOOI,PSOSD,RX,RX0,RX2,RX3,TFN,TD,TR,TRM,SC,SCH,ST0,STA,PSORX,J,PSOERR,RX,PSRXD,PSODIV,PSOSTA
 I '$G(DT) S DT=$$DT^XLFDT
 K ^TMP("PSO",$J)
 S PSOSTA="ACT^NVR^REF^HLD^NVR^SUS^^^^^^EXP^DCD^DEL^DCD^DCD^HLD"
 F J=1:1 S PSORX=$P(RXLIST,"^",J) Q:PSORX=""  D
 . I '$D(^PSRX("B",PSORX)) Q
 . I $O(^PSRX("B",PSORX,""))="" Q
 . S RX=$O(^PSRX("B",PSORX,"")),PSRXD=$G(^PSRX(RX,0))
 . Q:PSRXD=""
 . Q:$P(PSRXD,"^",2)'=DFN
 . Q:$P($G(^PSRX(RX,"STA")),"^")=13
 . Q:$P($G(^PSRX(RX,"STA")),"^")=15
 . Q:'$D(^PSDRUG($P(PSRXD,"^",6),0))
 . S IFN=RX,TR=$P(PSOSTA,"^",$P($G(^PSRX(RX,"STA")),"^")+1)
 . S TD=$P(^PSDRUG($P(PSRXD,"^",6),0),"^")
 . D RXD
 . Q
 Q
 ;
EN3(DFN,BDT,EDT) ;entry point to return prescription history
 Q:'$G(DFN)
 N DRG,DRGN,EXD,I,IFN,MIG,LSTFD,ORD,PEN,PSOBD,PSOED,PSODD,PSOOI,PSOSD,RX,RX0,RX2,RX3,TFN,TD,TR,TRM,SC,SCH,ST0,STA,PSODIV
 I '$G(DT) S DT=$$DT^XLFDT
 K ^TMP("PSO",$J) S PSOBD=$G(BDT),PSOED=$G(EDT)
 I +$G(PSOBD)<1 S X1=DT,X2=-120 D C^%DTC S PSOBD=X
 S EXD=PSOBD-1
 I PSOED="" S PSOED=9999999
 F  S EXD=$O(^PS(55,DFN,"P","A",EXD)) Q:'EXD  Q:EXD>PSOED  D
 .S RX=0 F  S RX=$O(^PS(55,DFN,"P","A",EXD,RX)) Q:'RX  D:$D(^PSRX(RX,0)) GET1
 S STA="ACT^NVR^REF^HLD^NVR^SUS^^^^^^EXP^DCD^DEL^DCD^DCD^HLD"
 ; Uses RX (Rx IEN) instead of DRUG as a subscript in PSOSD and thus
 ; in ^TMP("PSO",$J).  Other entry points use DRUG
 S RX="" F  S RX=$O(PSOSD(RX)) Q:RX=""  D:$G(PSOSD(RX))]""
 .S PSOSD($P(STA,"^",$P(PSOSD(RX),"^",2)+1),RX)=PSOSD(RX) K PSOSD(RX)
 D:$D(PSOSD) BLD
 Q
 ;
PEN F PEN=0:0 S PEN=$O(^PS(52.41,"P",DFN,PEN)) Q:'PEN  D
 .S ORD=^PS(52.41,PEN,0) Q:$P(ORD,"^",2)'=DFN  S DRG=""
 .Q:$P(ORD,"^",3)="DC"!($P(ORD,"^",3)="DE")!($P(ORD,"^",3)="")!($P(ORD,"^",3)="RF")
 .S PSOOI=$P(ORD,"^",8),PSODD=+$P(ORD,"^",9)
 .S DRG=$S(PSODD:$P($G(^PSDRUG(PSODD,0)),"^"),+PSOOI&('PSODD):$P(^PS(50.7,+PSOOI,0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,+PSOOI,0),"^",2),0),"^"),1:"")
 .Q:DRG']""
 .I $D(PSOSD("PEN",DRG)) S DRG=DRG_"^"_PEN
 .S PSOSD("PEN",DRG)=PEN
 Q
GET ;
 Q:$P($G(^PSRX(RX,"STA")),"^")=13
 Q:$P($G(^PSRX(RX,"STA")),"^")=15
 Q:'$P(^PSRX(RX,0),"^",2)
 Q:$P(^PSRX(RX,0),"^",2)'=DFN
 S RX0=^PSRX(RX,0),RX2=^PSRX(RX,2)
 S DRG=$P(^PSRX(RX,0),"^",6),STA=+^("STA") Q:'$D(^PSDRUG(DRG,0))
 S DRGN=$P(^PSDRUG(DRG,0),"^"),ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 I $D(PSOSD(DRGN)),ST0>10 Q:$P(PSOSD(DRGN),"^",2)<11  Q:$P(PSOSD(DRGN),"^",2)>10&($P(RX0,"^",13)<$P(^PSRX(+$P(PSOSD(DRGN),"^"),0),"^",13))
 I $D(PSOSD(DRGN)),$P(PSOSD(DRGN),"^",2)<10,ST0<10 S PSOSD(DRGN_"^"_RX)=RX_"^"_ST0
 E  S PSOSD(DRGN)=RX_"^"_ST0
 Q
GET1 ;
 Q:'$P(^PSRX(RX,0),"^",2)
 Q:$P(^PSRX(RX,0),"^",2)'=DFN
 S RX0=^PSRX(RX,0),RX2=^PSRX(RX,2)
 S DRG=$P(^PSRX(RX,0),"^",6),STA=+^("STA") Q:'$D(^PSDRUG(DRG,0))
 S DRGN=$P(^PSDRUG(DRG,0),"^"),ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 S PSOSD(RX)=RX_"^"_ST0
 Q
BLD ;
 S TR="" F  S TR=$O(PSOSD(TR)) Q:TR=""  D
 .S TFN=0,TD="" F  S TD=$O(PSOSD(TR,TD)) Q:TD=""  S IFN=+PSOSD(TR,TD) D @$S(TR="PEN":"PND",1:"RXD")
 Q
RXD ;
 Q:'$D(^PSRX(IFN,0))
 S RX0=^PSRX(IFN,0),RX2=$G(^(2)),RX3=$G(^(3)),STA=+$G(^("STA")),TRM=0,LSTFD=$P(RX2,"^",2)
 S ^TMP("PSO",$J,TR,TD,"RXN",0)=$P(RX0,"^")_"^"_$E($P(RX2,"^",13),1,7)_"^"_$S($P(RX0,"^",11)="W":"W",1:"M")_"^"_$P(RX3,"^",7)
 S ^TMP("PSO",$J,TR,TD,"RXN",0)=^TMP("PSO",$J,TR,TD,"RXN",0)_"^"_$S($P($G(^PSRX(IFN,"OR1")),"^",5):$P(^PSRX(IFN,"OR1"),"^",5),1:"")_"^"_$E($P(RX2,"^",2),1,7)_"^"_$E($P(RX2,"^",13),1,7)_"^^"_IFN
 S I=0 F  S I=$O(^PSRX(IFN,1,I)) Q:'I  S TRM=TRM+1,LSTFD=$P(^PSRX(IFN,1,I,0),"^") D
 .S ^TMP("PSO",$J,TR,TD,"REF",I,0)=$P(^PSRX(IFN,1,I,0),"^")_"^"_$P(^(0),"^",10)_"^"_$P(^(0),"^",4)_"^"_$E($P(^(0),"^",18),1,7)_"^"_$S($P(^(0),"^",2)="W":"W",1:"M")_"^"_$P(^(0),"^",3)
 .I $P(^PSRX(IFN,1,I,0),"^",18) S $P(^TMP("PSO",$J,TR,TD,"RXN",0),"^",2)=$E($P(^PSRX(IFN,1,I,0),"^",18),1,7)
 .S ^TMP("PSO",$J,TR,TD,"REF",0)=$G(^TMP("PSO",$J,TR,TD,"REF",0))+1
 S I=0 F  S I=$O(^PSRX(IFN,"P",I)) Q:'I  D
 .S ^TMP("PSO",$J,TR,TD,"PAR",I,0)=$P(^PSRX(IFN,"P",I,0),"^")_"^"_$P(^(0),"^",10)_"^"_$P(^(0),"^",4)_"^"_$E($P(^(0),"^",19),1,7)_"^"_$S($P(^(0),"^",2)="W":"W",1:"M")_"^"_$P(^(0),"^",3)
 .S ^TMP("PSO",$J,TR,TD,"PAR",0)=$G(^TMP("PSO",$J,TR,TD,"PAR",0))+1
 S ^TMP("PSO",$J,TR,TD,0)=$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^")_"^^"_$P(RX2,"^",6)
 S ^TMP("PSO",$J,TR,TD,"P",0)=$P(RX0,"^",4)_"^"_$P($G(^VA(200,+$P(RX0,"^",4),0)),"^")
 S ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 S SC=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DELETED^DISCONTINUED^DISCONTINUED (EDIT)^HOLD^","^",ST0+2)
 S ^TMP("PSO",$J,TR,TD,0)=^TMP("PSO",$J,TR,TD,0)_"^"_($P(RX0,"^",9)-TRM)_"^"_$P(RX0,"^",13)_"^"_SC_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",7)_"^^^"_$P($G(^PSRX(IFN,"OR1")),"^",2)_"^"_LSTFD_"^^"
 S ^TMP("PSO",$J,TR,TD,"DD",0)=1,^TMP("PSO",$J,TR,TD,"DD",1,0)=$P(RX0,"^",6)_"^^"
 S (SCH,SC)=0
 F  S SC=$O(^PSRX(IFN,"SCH",SC)) Q:'SC  S SCH=SCH+1,^TMP("PSO",$J,TR,TD,"SCH",SCH,0)=$P(^PSRX(IFN,"SCH",SC,0),"^") D
 .S ^TMP("PSO",$J,TR,TD,"SCH",0)=$G(^TMP("PSO",$J,TR,TD,"SCH",0))+1
 D MDR
 S SC=0 I $D(^PSRX(IFN,"SIG")),'$P(^PSRX(IFN,"SIG"),"^",2) S SC=1 S X=$P(^PSRX(IFN,"SIG"),"^") D SIG
 I '$G(SC) S SCH=1 D
 .S ^TMP("PSO",$J,TR,TD,"SIG",SCH,0)=$G(^PSRX(IFN,"SIG1",1,0)),^TMP("PSO",$J,TR,TD,"SIG",0)=SCH
 .F I=1:0 S I=$O(^PSRX(IFN,"SIG1",I)) Q:'I  S SCH=SCH+1,^TMP("PSO",$J,TR,TD,"SIG",SCH,0)=^PSRX(IFN,"SIG1",I,0),^TMP("PSO",$J,TR,TD,"SIG",0)=SCH
 S (I,SC)=0
 F  S I=$O(^PSRX(IFN,"PRC",I)) Q:'I  S SC=SC+1 D
 .S ^TMP("PSO",$J,TR,TD,"PC",SC,0)=^PSRX(IFN,"PRC",I,0),^TMP("PSO",$J,TR,TD,"PC",0)=SC
 S PSODIV=$P(RX2,"^",9)
 I PSODIV'="",$D(^PS(59,PSODIV,0)) S ^TMP("PSO",$J,TR,TD,"DIV",0)=PSODIV_"^"_^PS(59,PSODIV,0)
 Q
MDR ;
 S (SCH,SC)=0
 F  S SC=$O(^PSRX(IFN,"MEDR",SC)) Q:'SC  D
 .Q:'$D(^PS(51.2,+^PSRX(IFN,"MEDR",SC,0),0))  S SCH=SCH+1
 .S ^TMP("PSO",$J,TR,TD,"MDR",SCH,0)=$S($P(^PS(51.2,+^PSRX(IFN,"MEDR",SC,0),0),"^",3)]"":$P(^(0),"^",3),1:$P(^(0),"^"))
 .S ^TMP("PSO",$J,TR,TD,"MDR",0)=SCH
 Q
PND Q:'$D(^PS(52.41,IFN,0))
 S ORD=^PS(52.41,IFN,0) Q:$P(ORD,"^",2)'=DFN
 Q:$P(ORD,"^",3)="DC"!($P(ORD,"^",3)="DE")
 S PSOOI=+$P(ORD,"^",8),PSODD=+$P(ORD,"^",9)
 S DRG=$S(PSODD:$P($G(^PSDRUG(PSODD,0)),"^"),1:$P(^PS(50.7,PSOOI,0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,PSOOI,0),"^",2),0),"^"))
 S ^TMP("PSO",$J,TR,TD,0)=DRG
 S:PSODD ^TMP("PSO",$J,TR,TD,"DD",0)=1,^TMP("PSO",$J,TR,TD,"DD",1,0)=PSODD_"^^"
 S ^TMP("PSO",$J,TR,TD,0)=^TMP("PSO",$J,TR,TD,0)_"^"_$S($G(^PS(51.2,+$P(ORD,"^",15),0))]"":$P(^PS(51.2,+$P(ORD,"^",15),0),"^",3),1:"")
 S ^TMP("PSO",$J,TR,TD,0)=^TMP("PSO",$J,TR,TD,0)_"^^"_$P(ORD,"^",11)_"^"_$P($P(ORD,"^",6),".")_"^"_$S($P(ORD,"^",3)'="HD":"PENDING",1:" ONHOLD")_"^^"_$P(ORD,"^",10)
 S $P(^TMP("PSO",$J,TR,TD,0),"^",11)=$P(ORD,"^")
 S (SC,SCH)=0 F  S SC=$O(^PS(52.41,IFN,1,SC)) Q:'SC  D
 .S SCH=SCH+1,^TMP("PSO",$J,TR,TD,"SCH",SCH,0)=$P(^PS(52.41,IFN,1,SC,1),"^"),^TMP("PSO",$J,TR,TD,"SCH",0)=SCH
 S (SC,SCH)=0 F  S SC=$O(^PS(52.41,IFN,"SIG",SC)) Q:'SC  D
 .S SCH=SCH+1,^TMP("PSO",$J,TR,TD,"SIG",SCH,0)=$P(^PS(52.41,IFN,"SIG",SC,0),"^"),^TMP("PSO",$J,TR,TD,"SIG",0)=SCH
 S SC=1,PEN="" F  S PEN=$O(^PS(52.41,IFN,2,PEN)) Q:'PEN  D
 .S MIG=^PS(52.41,IFN,2,PEN,0),^TMP("PSO",$J,TR,TD,"SIO",0)=SC D
 ..F SCH=1:1:$L(MIG," ") S:$L($G(^TMP("PSO",$J,TR,TD,"SIO",SC,0))_" "_$P(MIG,"",SCH))>80 SC=SC+1,^TMP("PSO",$J,TR,TD,"SIO",0)=SC D
 ...S ^TMP("PSO",$J,TR,TD,"SIO",SC,0)=$G(^TMP("PSO",$J,TR,TD,"SIO",SC,0))_" "_$P(MIG," ",SCH)
 Q
SIG ;
 N Z0,Z1,PSOX1,PSOX2 F Z0=1:1:$L(X," ") Q:Z0=""  S Z1=$P(X," ",Z0) D
 .D:$D(X)&($G(Z1)]"")
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
 .I $G(^TMP("PSO",$J,TR,TD,"SIG",1,0))']"" S ^TMP("PSO",$J,TR,TD,"SIG",1,0)=Z1,^TMP("PSO",$J,TR,TD,"SIG",0)=1 Q
 .F PSOX1=0:0 S PSOX1=$O(^TMP("PSO",$J,TR,TD,"SIG",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 .I $L(^TMP("PSO",$J,TR,TD,"SIG",PSOX2,0))+$L(Z1)<245 S ^TMP("PSO",$J,TR,TD,"SIG",PSOX2,0)=^TMP("PSO",$J,TR,TD,"SIG",PSOX2,0)_" "_Z1
 .E  S PSOX2=PSOX2+1,^TMP("PSO",$J,TR,TD,"SIG",PSOX2,0)=Z1
 Q
