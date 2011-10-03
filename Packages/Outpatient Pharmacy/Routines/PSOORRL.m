PSOORRL ;BHAM ISC/SAB - returns patient's outpatient meds ;07/21/96
 ;;7.0;OUTPATIENT PHARMACY;**4,20,9,34,54,82,124,132,159,214,225**;DEC 1997;Build 29
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^VA(200 supported by DBIA 10060
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to OCL^PSJORRE supported by DBIA 2383
 ;External reference to OEL^PSJORRE1 supported by DBIA 2384
OCL(DFN,BDT,EDT,VIEW) ;entry point to return condensed list
 ; VIEW=0   -  This returns the list as it was returned prior to GUI 27
 ; VIEW=1   -  This returns the list in original view GUI 27
 ; VIEW=2   -  This is the new sort with GUI 27
 ; VIEW=3   -  New sort by Sort by Drug Name/status with GUI 27
 D @$S($G(VIEW)=3:"OCL^PSOORRL3",$G(VIEW)=1:"OCL^PSOORRLO",$G(VIEW)=2:"OCL^PSOORRLN",1:"ST")
 Q
 ;BHW;PSO*7*159;New SD* Variables
ST N SD,SDT,SDT1
 D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN)
 K ^TMP("PS",$J) S TFN=0,PSBDT=$G(BDT),PSEDT=$G(EDT) I +$G(PSBDT)<1 S X1=DT,X2=-120 D C^%DTC S PSBDT=X
 S EXDT=PSBDT-1,IFN=0
 F  S EXDT=$O(^PS(55,DFN,"P","A",EXDT)) Q:'EXDT  F  S IFN=$O(^PS(55,DFN,"P","A",EXDT,IFN)) Q:'IFN  D:$D(^PSRX(IFN,0))
 .Q:$P($G(^PSRX(IFN,"STA")),"^")=13
 .S TFN=TFN+1,RX0=^PSRX(IFN,0),RX2=$G(^(2)),RX3=$G(^(3)),STA=+$G(^("STA")),TRM=0,LSTFD=$P(RX2,"^",2),LSTRD=$P(RX2,"^",13),LSTDS=$P(RX0,"^",8)
 .F I=0:0 S I=$O(^PSRX(IFN,1,I)) Q:'I  S TRM=TRM+1,LSTFD=$P(^PSRX(IFN,1,I,0),"^"),LSTDS=$P(^(0),"^",10) S:$P(^(0),"^",18)]"" LSTRD=$P(^(0),"^",18)
 .S ^TMP("PS",$J,TFN,0)=IFN_"R;O"_"^"_$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^")_"^^"_$P(RX2,"^",6)_"^"_($P(RX0,"^",9)-TRM)_"^^^"_$P($G(^PSRX(IFN,"OR1")),"^",2)
 .S ^TMP("PS",$J,TFN,"P",0)=$P(RX0,"^",4)_"^"_$P($G(^VA(200,+$P(RX0,"^",4),0)),"^")
 .S ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 .S ST=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^ACTIVE/SUSP^^^^^DONE^EXPIRED^DISCONTINUED^DISCONTINUED^DISCONTINUED^DISCONTINUED (EDIT)^HOLD^","^",ST0+2)
 .S ^TMP("PS",$J,TFN,0)=^TMP("PS",$J,TFN,0)_"^"_ST_"^"_LSTFD_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",7)_"^^^"_$P(RX0,"^",13)_"^"_LSTRD_"^"_LSTDS
 .S ^TMP("PS",$J,TFN,"SCH",0)=0
 .S (SCH,SC)=0 F  S SC=$O(^PSRX(IFN,"SCH",SC)) Q:'SC  S SCH=SCH+1,^TMP("PS",$J,TFN,"SCH",SCH,0)=$P(^PSRX(IFN,"SCH",SC,0),"^"),^TMP("PS",$J,TFN,"SCH",0)=^TMP("PS",$J,TFN,"SCH",0)+1
 .S ^TMP("PS",$J,TFN,"MDR",0)=0,(MDR,MR)=0 F  S MR=$O(^PSRX(IFN,"MEDR",MR)) Q:'MR  D
 ..Q:'$D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0))  S MDR=MDR+1
 ..I $P($G(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),"^",3)]"" S ^TMP("PS",$J,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^",3)
 ..I $D(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0)),$P($G(^(0)),"^",3)']"" S ^TMP("PS",$J,TFN,"MDR",MDR,0)=$P(^PS(51.2,+^PSRX(IFN,"MEDR",MR,0),0),"^")
 ..S ^TMP("PS",$J,TFN,"MDR",0)=^TMP("PS",$J,TFN,"MDR",0)+1
 .S PSOELSE=0 I $D(^PSRX(IFN,"SIG")),'$P(^PSRX(IFN,"SIG"),"^",2) S PSOELSE=1 S X=$P(^PSRX(IFN,"SIG"),"^") D SIG1^PSOORRL1
 .I '$G(PSOELSE) S ITFN=1 D
 ..S ^TMP("PS",$J,TFN,"SIG",ITFN,0)=$G(^PSRX(IFN,"SIG1",1,0)),^TMP("PS",$J,TFN,"SIG",0)=+$G(^TMP("PS",$J,TFN,"SIG",0))+1
 ..F I=1:0 S I=$O(^PSRX(IFN,"SIG1",I)) Q:'I  S ITFN=ITFN+1,^TMP("PS",$J,TFN,"SIG",ITFN,0)=^PSRX(IFN,"SIG1",I,0),^TMP("PS",$J,TFN,"SIG",0)=+$G(^TMP("PS",$J,TFN,"SIG",0))+1
 K PSOELSE
 S IFN=0 F  S IFN=$O(^PS(52.41,"P",DFN,IFN)) Q:'IFN  S PSOR=^PS(52.41,IFN,0) D:$P(PSOR,"^",3)="" WAIT D:$P(PSOR,"^",3)'="DC"&($P(PSOR,"^",3)'="DE")&($P(PSOR,"^",3)'="")
 .Q:$P(PSOR,"^",3)="RF"
 .I $P(PSOR,"^",8)="",$P(PSOR,"^",9)="" D WAIT
 .I $P(PSOR,"^",8)="",$P(PSOR,"^",9)="" Q  ; QUIT IF STILL NULL AFTER WAITING
 .S TFN=TFN+1,^TMP("PS",$J,TFN,0)=IFN_"P;O^"_$S($P(PSOR,"^",9):$P($G(^PSDRUG($P(PSOR,"^",9),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^",8),0),"^",2),0),"^"))
 .S ^TMP("PS",$J,TFN,0)=^TMP("PS",$J,TFN,0)_"^^^^^^"_$P(PSOR,"^")_"^"_"PENDING^^^"_$P(PSOR,"^",10)_"^"
 .S ^TMP("PS",$J,TFN,0)=^TMP("PS",$J,TFN,0)_"^"_$S($P(PSOR,"^",3)="RNW":1,1:0)
 .S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,1,SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,TFN,"SCH",SD,0)=$P(^PS(52.41,IFN,1,SCH,1),"^"),^TMP("PS",$J,TFN,"SCH",0)=SD
 .S SD=0 F SCH=0:0 S SCH=$O(^PS(52.41,IFN,"SIG",SCH)) Q:'SCH  S SD=SD+1,^TMP("PS",$J,TFN,"SIG",SD,0)=$P(^PS(52.41,IFN,"SIG",SCH,0),"^"),^TMP("PS",$J,TFN,"SIG",0)=SD
 .S (IEN,SD)=1,INST=0 F  S INST=$O(^PS(52.41,IFN,2,INST)) Q:'INST  S (MIG,INST(INST))=^PS(52.41,IFN,2,INST,0),^TMP("PS",$J,TFN,"SIO",0)=SD D
 ..F SG=1:1:$L(MIG," ") S:$L($G(^TMP("PS",$J,TFN,"SIO",IEN,0))_" "_$P(MIG," ",SG))>80 IEN=IEN+1,SD=SD+1,^TMP("PS",$J,TFN,"SIO",0)=SD S ^TMP("PS",$J,TFN,"SIO",IEN,0)=$G(^TMP("PS",$J,TFN,"SIO",IEN,0))_" "_$P(MIG," ",SG)
 D NVA,OCL^PSJORRE(DFN,BDT,EDT,.TFN,+$G(VIEW)),END^PSOORRL1
 K SDT,SDT1,EDT,EDT1,BDT,DBT1,X
 Q
OEL(DFN,RXNUM) ;returns expanded list on specific order
 I $P(RXNUM,";",2)="I" D OEL^PSJORRE1(DFN,$P(RXNUM,";")) Q
 D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN) Q:RXNUM=""
 ;BHW;PSO*7*159;New SD
 N SD
 K INST,IFN,^TMP("PS",$J) S FL=$P(RXNUM,";"),IFN=+FL,RXNUM=$P(RXNUM,";",2)
 I $G(FL)["P"!($G(FL)["S") D PEN^PSOORRL1 Q
 I $G(FL)["N" D NVA^PSOORRL1 Q
 Q:'$D(^PSRX(IFN,0))
 S RX0=^PSRX(IFN,0),RX2=$G(^(2)),RX3=$G(^(3)),STA=+$G(^("STA")),TRM=0,LSTFD=$P(RX2,"^",2)
 S ^TMP("PS",$J,"RXN",0)=$P(RX0,"^")_"^"_$E($P(RX2,"^",13),1,7)_"^"_$S($P(RX0,"^",11)="W":"W",1:"M")_"^"_$P(RX3,"^",7)_"^"_$S($P($G(^PSRX(IFN,"OR1")),"^",5):$P(^PSRX(IFN,"OR1"),"^",5),1:"")_"^"_$E($P(RX2,"^",2),1,7)_"^"_$E($P(RX2,"^",13),1,7)
 D RSTC(0) ;set return to stock node for original
 F I=0:0 S I=$O(^PSRX(IFN,1,I)) Q:'I  S TRM=TRM+1,LSTFD=$P(^PSRX(IFN,1,I,0),"^") D
 .S ^TMP("PS",$J,"REF",I,0)=$P(^PSRX(IFN,1,I,0),"^")_"^"_$P(^(0),"^",10)_"^"_$P(^(0),"^",4)_"^"_$E($P(^(0),"^",18),1,7)_"^"_$S($P(^(0),"^",2)="W":"W",1:"M")_"^"_$P(^(0),"^",3)
 .I $P(^PSRX(IFN,1,I,0),"^",18) S $P(^TMP("PS",$J,"RXN",0),"^",2)=$E($P(^PSRX(IFN,1,I,0),"^",18),1,7)
 .S ^TMP("PS",$J,"REF",0)=$G(^TMP("PS",$J,"REF",0))+1
 .D RSTC(I) ;set return to stock node for refills
 F I=0:0 S I=$O(^PSRX(IFN,"P",I)) Q:'I  D
 .S ^TMP("PS",$J,"PAR",I,0)=$P(^PSRX(IFN,"P",I,0),"^")_"^"_$P(^(0),"^",10)_"^"_$P(^(0),"^",4)_"^"_$E($P(^(0),"^",19),1,7)_"^"_$S($P(^(0),"^",2)="W":"W",1:"M")_"^"_$P(^(0),"^",3)
 .S ^TMP("PS",$J,"PAR",0)=$G(^TMP("PS",$J,"PAR",0))+1
 S ^TMP("PS",$J,0)=$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^")_"^^"_$P(RX2,"^",6)
 S ^TMP("PS",$J,"P",0)=$P(RX0,"^",4)_"^"_$P($G(^VA(200,+$P(RX0,"^",4),0)),"^")
 S ST0=$S(STA<12&($P(RX2,"^",6)<DT):11,1:STA)
 S ST=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL FILL^HOLD^NON-VERIFIED^ACTIVE/SUSP^^^^^DONE^EXPIRED^DISCONTINUE^DISCONTINUED^DISCONTINUED^DISCONTINUED (EDIT)^HOLD^","^",ST0+2)
 S ^TMP("PS",$J,0)=^TMP("PS",$J,0)_"^"_($P(RX0,"^",9)-TRM)_"^"_$P(RX0,"^",13)_"^"_ST_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",7)_"^^^"_$P($G(^PSRX(IFN,"OR1")),"^",2)_"^"_LSTFD_"^^"
 S ^TMP("PS",$J,"DD",0)=1,^TMP("PS",$J,"DD",1,0)=$P(RX0,"^",6)_"^^"
 S COD=$S('$G(^PSDRUG(+$P(RX0,"^",6),"I")):1,+$G(^PSDRUG(+$P(RX0,"^",6),"I"))>DT:1,1:0)
 S ^TMP("PS",$J,"DD",1,0)=^TMP("PS",$J,"DD",1,0)_$S($P($G(^PSDRUG(+$P(RX0,"^",6),2)),"^",3)["U"&(COD):$P(RX0,"^",6),1:"") K COD
 S ^TMP("PS",$J,"SCH",0)=0,(SCH,SC)=0
 F  S SC=$O(^PSRX(IFN,"SCH",SC)) Q:'SC  S SCH=SCH+1,^TMP("PS",$J,"SCH",SCH,0)=$P(^PSRX(IFN,"SCH",SC,0),"^") D
 .S ^TMP("PS",$J,"SCH",0)=^TMP("PS",$J,"SCH",0)+1
 D MDR^PSOORRL1
 S PSOELSE=0 I $D(^PSRX(IFN,"SIG")),'$P(^PSRX(IFN,"SIG"),"^",2) S PSOELSE=1 S X=$P(^PSRX(IFN,"SIG"),"^") D SIG^PSOORRL1
 I '$G(PSOELSE) S ITFN=1 D
 .S ^TMP("PS",$J,"SIG",ITFN,0)=$G(^PSRX(IFN,"SIG1",1,0)),^TMP("PS",$J,"SIG",0)=+$G(^TMP("PS",$J,"SIG",0))+1
 .F I=1:0 S I=$O(^PSRX(IFN,"SIG1",I)) Q:'I  S ITFN=ITFN+1,^TMP("PS",$J,"SIG",ITFN,0)=^PSRX(IFN,"SIG1",I,0),^TMP("PS",$J,"SIG",0)=+$G(^TMP("PS",$J,"SIG",0))+1
 K PSOELSE
 S ^TMP("PS",$J,"PC",0)=0,ITFN=0
 F I=0:0 S I=$O(^PSRX(IFN,"PRC",I)) Q:'I  S ITFN=ITFN+1,^TMP("PS",$J,"PC",ITFN,0)=^PSRX(IFN,"PRC",I,0),^TMP("PS",$J,"PC",0)=^TMP("PS",$J,"PC",0)+1
 Q
 ;
WAIT ; IF PENDING ENTRY STILL BEING BUILT SEE IF IT COMPLETES WITHIN ANOTHER SECOND
 H 1 S PSOR=$G(^PS(52.41,IFN,0))
 Q
 ;
NVA ; Set Non-VA Med Orders in the ^TMP Global
 ;BHW;PSO*7*159;New SDT,SDT1 Variables
 N SDT,SDT1
 F I=0:0 S I=$O(^PS(55,DFN,"NVA",I)) Q:'I  S X=$G(^PS(55,DFN,"NVA",I,0)) D
 .Q:'$P(X,"^")
 .S DRG=$S($P(X,"^",2):$P($G(^PSDRUG($P(X,"^",2),0)),"^"),1:$P(^PS(50.7,$P(X,"^"),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(X,"^"),0),"^",2),0),"^"))
 .S SDT=$P(X,"^",9) I 'SDT D TMPBLD Q
 .I $E(SDT,4,5),$E(SDT,6,7) D
 ..;I $P(X,"^",9) D  Q
 ..I $G(BDT),SDT<BDT Q
 ..I $G(EDT),SDT>EDT Q
 ..I $G(BDT),$P(X,"^",7),$P(X,"^",7)<BDT Q
 ..D TMPBLD
 .I $E(SDT,4,5),'$E(SDT,6,7) D
 ..S SDT1=$E(SDT,1,5),BDT1=$E(+$G(BDT),1,5),EDT1=$E(+$G(EDT),1,5)
 ..I $G(BDT1),SDT1<BDT1 Q
 ..I $G(EDT1),SDT1>EDT1 Q
 ..I $G(BDT1),$P(X,"^",7),$E($P(X,"^",7),1,5)<BDT1 Q
 ..D TMPBLD
 .I '$E(SDT,4,5),'$E($P(X,"^",9),6,7) D
 ..;I $P(X,"^",9) D  Q
 ..S SDT1=$E(SDT,1,3),BDT1=$E(+$G(BDT),1,3),EDT1=$E(+$G(EDT),1,3)
 ..I $G(BDT1),SDT1<BDT1 Q
 ..I $G(EDT1),SDT1>EDT1 Q
 ..I $G(BDT1),$P(X,"^",7),$E($P(X,"^",7),1,3)<BDT1 Q
 ..D TMPBLD
 Q
TMPBLD S TFN=$G(TFN)+1,^TMP("PS",$J,TFN,0)=I_"N;O^"_DRG
 S $P(^TMP("PS",$J,TFN,0),"^",8)=$P(X,"^",8)_"^"_$S($P(X,"^",7):"DISCONTINUED",1:"ACTIVE")
 S ^TMP("PS",$J,TFN,"SCH",0)=1,^TMP("PS",$J,TFN,"SCH",1,0)=$P(X,"^",5)
 S ^TMP("PS",$J,TFN,"SIG",0)=1,^TMP("PS",$J,TFN,"SIG",1,0)=$P(X,"^",3)_" "_$P(X,"^",4)_" "_$P(X,"^",5)
 Q
RSTC(REF) ; return to stock
 F J=0:0 S J=$O(^PSRX(IFN,"A",J)) Q:'J  S II=$G(^(J,0)) I $P(II,"^",2)="I",$P(II,"^",4)=REF D
 .I REF=0,'$$RXRLDT^PSOBPSUT(IFN,0) S ^TMP("PS",$J,"RXN","RSTC")=$P(II,"^")_"^"_$P(II,"^",3)_"^"_$P(II,"^",5) Q
 .I REF>0,'$$RXRLDT^PSOBPSUT(IFN,REF) S ^TMP("PS",$J,"REF",REF,"RSTC")=$P(II,"^")_"^"_$P(II,"^",3)_"^"_$P(II,"^",5)
 Q
