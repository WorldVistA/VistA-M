PSOORDER ;BHAM ISC/SAB- utility routine to return Rx data ; 04/09/96 10:30 am
 ;;7.0;OUTPATIENT PHARMACY;**11,20,9,46,103,165**;DEC 1997
 ;^PS(55 supported by DBIA 2228
 ;^PSDRUG supported by DBIA 221
 ;^VA(200 supported by DBIA 10060
 ;^SC supported by DBIA 10040
 ;^DPT supported by DBIA 10035
 ;^PSNAPIS supported by DBIA 2531
 ;^PSNDF supported by DBIA 2195
 ;^PS(50.7 supported by DBIA 2223
 ;^PS(50.606 supported by DBIA 2174
 ;^PS(51.2 supported by DBIA 2226
 ;^PS(50.607 supported by DBIA 2221
 ;
 ;for full break down of data returned see DBIA #1878
 ;
EN(DFN,RX) ;
 K ^TMP("PSOR",$J)
 N SIG,SG,IEN,CMOP,CMIN,CMIND,HDST,I,LSFD,PSO2,PSOCF,PSOCST,PSODR,PSODT,PSOLFD,PSOFD,PSOID,PSOJ,PSOPR,PSOPLCL,PSOPLPR,PSOREF,PSORF,PSORFCL,PSORFPR,PSOST,PSOX,RX0,RX0,RX1,RX3,RX3,RXH,RXP,ST0,SUS,FPN
 Q:'$D(^PSRX(RX,0))!('$D(^PSRX(RX,2)))!('$D(^PSRX(RX,3)))!($G(^PSRX(RX,"STA"))=13)
 I $G(DFN)'="",$P($G(^PSRX(RX,0)),"^",2)'=$G(DFN) Q
 I '$G(DFN) S DFN=+$P($G(^PSRX(RX,0)),"^",2)
 K PSOLOUD D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN)
 S:$G(^PSRX(RX,"IB"))]"" ^TMP("PSOR",$J,RX,"IB")=$P(^PSRX(RX,"IB"),"^",1,2)
 S RX0=^PSRX(RX,0),RX2=^(2),RX3=^(3),RXH=$G(^("H")),PSORF=$P(RX0,"^",9),LSFD=$P(RX2,"^",2),ST0=$P($G(^("STA")),"^"),OERR=$G(^("OR1")) D
 .F I=0:0 S I=$O(^PSRX(RX,1,I)) Q:'I  I $D(^PSRX(RX,1,I,0)) S RX1(I)=^PSRX(RX,1,I,0),PSORF=PSORF-1,LSFD=+RX1(I),PSOCST=$P(RX1(I),"^",4)*+$P(RX1(I),"^",11) D
 ..S PSORFPR=$P(RX0,"^",4) I PSORFPR S PSORFPR=PSORFPR_";"_$P($G(^VA(200,PSORFPR,0)),"^")
 ..S PSORFCL=$P(RX1(I),"^",7) I PSORFCL S PSORFCL=PSORFCL_";"_$P($G(^VA(200,PSORFCL,0)),"^")
 ..S ^TMP("PSOR",$J,RX,"REF",I,0)=+RX1(I)_"^"_$G(PSORFPR)_"^"_$G(PSORFCL)_"^"_$P(RX1(I),"^",4)_"^"_+$P(RX1(I),"^",10)_"^"_+$P(RX1(I),"^",11)_"^"
 ..S ^TMP("PSOR",$J,RX,"REF",I,0)=^TMP("PSOR",$J,RX,"REF",I,0)_PSOCST_"^"_$P(RX1(I),"^",18)_"^"_$P(RX1(I),"^",16)_"^"
 ..S ^TMP("PSOR",$J,RX,"REF",I,0)=^TMP("PSOR",$J,RX,"REF",I,0)_$S($P(RX1(I),"^",2)="M":"M;MAIL",1:"W;WINDOW")_"^"_$P(RX1(I),"^",9)_"^"_$P(RX1(I),"^",8)_"^"_$P($G(^PSRX(RX,1,I,1)),"^",3)
 .F I=0:0 S I=$O(^PSRX(RX,"P",I)) Q:'I  I $D(^PSRX(RX,"P",I,0)) S RXP(I)=^PSRX(RX,"P",I,0) D
 ..S PSOCST=$P(RXP(I),"^",4)*+$P(RXP(I),"^",11)
 ..S PSOPLPR=$P(RX0,"^",4) I PSOPLPR S PSOPLPR=PSOPLPR_";"_$P($G(^VA(200,PSOPLPR,0)),"^")
 ..S PSOPLCL=$P(RXP(I),"^",7) I PSOPLCL S PSOPLCL=PSOPLCL_";"_$P($G(^VA(200,PSOPLCL,0)),"^")
 ..S ^TMP("PSOR",$J,RX,"RPAR",I,0)=+RXP(I)_"^"_$G(PSOPLPR)_"^"_$G(PSOPLCL)_"^"_$P(RXP(I),"^",4)_"^"_+$P(RXP(I),"^",10)_"^"
 ..S ^TMP("PSOR",$J,RX,"RPAR",I,0)=^TMP("PSOR",$J,RX,"RPAR",I,0)_+$P(RXP(I),"^",11)_"^"_PSOCST_"^"_$P(RXP(I),"^",19)_"^"_$P(RXP(I),"^",16)_"^"
 ..S ^TMP("PSOR",$J,RX,"RPAR",I,0)=^TMP("PSOR",$J,RX,"RPAR",I,0)_$S($P(RXP(I),"^",2)="M":"M;MAIL",1:"W;WINDOW")_"^"_$P(RXP(I),"^",9)_"^"_$P(RXP(I),"^",8)_"^"_$P(RXP(I),"^",12)
 .S MI=0 F I=0:0 S I=$O(^PSRX(RX,6,I)) Q:'I  S RP(I)=^PSRX(RX,6,I,0) D
 ..S UN=$P(RP(I),"^",3) I UN S PSOX=$G(^PS(50.607,UN,0)) S UN=UN_";"_$P(PSOX,"^")
 ..S RT=$P(RP(I),"^",7) I RT S PSOX=$G(^PS(51.2,RT,0)) S RT=RT_";"_$P(PSOX,"^")
 ..S MI=MI+1,^TMP("PSOR",$J,RX,"MI",MI,0)=$P(RP(I),"^")_"^"_$P(RP(I),"^",2)_"^"_UN_"^"_$P(RP(I),"^",4)_"^"_$P(RP(I),"^",5)_"^"_$P(RP(I),"^",6)_"^"_RT_"^"_$P(RP(I),"^",8)_"^"_$P(RP(I),"^",9)
 .F I=0:0 S I=$O(^PSRX(RX,"INS1",I)) Q:'I  S ^TMP("PSOR",$J,RX,"PI",I,0)=^PSRX(RX,"INS1",I,0)
 K MI,RP,PSOX,UN,RT
 S PSOLFD=+$G(RX3),PSODR=+$P(RX0,"^",6),PSOPR=$P(RX0,"^",4),PSOREF=$P(RX0,"^",9),PSOID=$P(RX0,"^",13),PSOST=$P($G(^PSRX(RX,"STA")),"^"),PSODT=$P(RX2,"^",6)
 D ODT S PSOFD=$P(RX2,"^",2),PSOX=$S($D(^PSDRUG(PSODR,0)):$P(^(0),"^"),1:"NOT ON FILE"),PSODR=PSODR_";"_PSOX
 S PSOPR=$P(RX0,"^",4) I PSOPR S PSOX=$G(^VA(200,PSOPR,0)) S PSOPR=PSOPR_";"_$P(PSOX,"^")
 S CLK=$P(RX0,"^",16) I CLK S PSOX=$G(^VA(200,CLK,0)) S CLK=CLK_";"_$P(PSOX,"^")
 S VPR=$P(RX2,"^",10) I VPR S PSOX=$G(^VA(200,VPR,0)) S VPR=VPR_";"_$P(PSOX,"^")
 S FPN=$P(OERR,"^",5) I FPN S PSOX=$G(^VA(200,FPN,0)) S FPN=FPN_";"_$P(PSOX,"^")
 S CLN=$P(RX0,"^",5) I CLN S PSOX=$G(^SC(CLN,0)) S CLN=CLN_";"_$P(PSOX,"^")
 S RXP=$P(RX0,"^",3)_";"_$P($G(^PS(53,+$P(RX0,"^",3),0)),"^")
 S MW=$S($P(RX0,"^",11)="W":"W;WINDOW",1:"M;MAIL")
 S PSOX="A;ACTIVE" S:$D(^PS(52.4,RX,0)) PSOX="N;NON-VERIFIED" S:$O(^PS(52.5,"B",RX,0))&($G(^PS(52.5,+$O(^PS(52.5,"B",RX,0)),"P"))'=1) PSOX="S;SUSPENDED"
 I ST0<12,$P(RX2,"^",6)<DT S ST0=11
 S PSOX=$P("Error^A;Active^N;Non-Verified^R;Refill^H;Hold^N;Non-Verified^S;Suspended^^^^^D;Done^E;Expired^DC;Discontinued^D;Deleted^DC;Discontinued^DC;Discontinued (Edit)^H;Provider Hold^","^",ST0+2)
 D:PSOX="H;Hold"
 .S RXH=$G(^PSRX(RX,"H"))
 .S HDST=$S(+RXH=1:"Insufficient QTY in Stock",+RXH=2:"Drug Interaction",+RXH=3:"Patient Reaction",+RXH=4:"Physician to be Contacted",+RXH=5:"Allergy Reactions",+RXH=6:"Drug Reaction",1:"Other--See Comments")
 .S ^TMP("PSOR",$J,RX,"HOLD",0)=HDST_"^"_$P(RXH,"^",2)_"^"_$P(RXH,"^",3)
 S PSOCF=+$P(RX0,"^",17)*(+$P(RX0,"^",7)) ;cost of original fill;
 S ^TMP("PSOR",$J,RX,0)=PSOID_"^"_PSOFD_"^"_PSOLFD_"^"_$G(PSOX)_"^"_$P(RX0,"^")_"^"_$P(RX0,"^",7)_"^"_$P(RX0,"^",8)_"^"_$P(RX0,"^",9)_"^"_$G(PSORF)_"^"_+$P(RX0,"^",17)_"^"_$G(PSOCF)_"^"_$G(PSODT)_"^"_$P(RX2,"^",13)_"^"_$P(RX2,"^",15)
 S ^TMP("PSOR",$J,RX,0)=^TMP("PSOR",$J,RX,0)_"^"_$S($P($G(^PSRX(RX,"PC")),"^"):"Yes",1:"No")_"^"_$G(DFN)_";"_$P($G(^DPT(+$G(DFN),0)),"^")_"^"_$P(RX2,"^")
 S ^TMP("PSOR",$J,RX,1)=PSOPR_"^"_CLK_"^"_VPR_"^"_CLN_"^"_RXP_"^"_MW_"^"_$P(RX2,"^",9)_"^"_$P(OERR,"^",2)_"^"_FPN_"^"_$P(RX2,"^",7)_"^"_$P($G(^PSRX(RX,"TPB")),"^")
 S ^TMP("PSOR",$J,RX,"DRUG",0)=$G(PSODR)
 I +$G(^PSDRUG(+$P(RX0,"^",6),"ND")),+$P($G(^("ND")),"^",3) D
 .I $T(^PSNAPIS)]"" S PSOXN=$$PROD2^PSNAPIS($P(^PSDRUG(+$P(RX0,"^",6),"ND"),"^"),$P(^PSDRUG(+$P(RX0,"^",6),"ND"),"^",3)) S ^TMP("PSOR",$J,RX,"DRUG",0)=^TMP("PSOR",$J,RX,"DRUG",0)_"^"_$P($G(PSOXN),"^")_"^"_$P($G(PSOXN),"^",2) D  Q
 ..S ^TMP("PSOR",$J,RX,"DRUG",0)=^TMP("PSOR",$J,RX,"DRUG",0)_"^"_$P(^PSDRUG(+$P(RX0,"^",6),0),"^",2) K PSOXN
 .S ^TMP("PSOR",$J,RX,"DRUG",0)=^TMP("PSOR",$J,RX,"DRUG",0)_"^"_$P($G(^PSNDF($P(^PSDRUG(+$P(RX0,"^",6),"ND"),"^"),5,+$P(^PSDRUG(+$P(RX0,"^",6),"ND"),"^",3),2)),"^")_"^"_$P($G(^(2)),"^",2)_"^"_$P(^PSDRUG(+$P(RX0,"^",6),0),"^",2)
 S ^TMP("PSOR",$J,RX,"DRUGOI",0)=$S(+$P(OERR,"^"):$P(OERR,"^")_";"_$P($G(^PS(50.7,+$P(OERR,"^"),0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"),1:"Not Matched to an Orderable Item")
 ;returns activity log
 F I=0:0 S I=$O(^PSRX(RX,"A",I)) Q:'I  D
 .S ZR=$P(^PSRX(RX,"A",I,0),"^",2),RF=+$P(^(0),"^",4)
 .S RFT=$S(RF>0&(RF<6):"REFILL "_RF,RF=6:"PARTIAL",RF>6:"REFILL "_(RF-1),1:"ORIGINAL") D
 ..S REA=$S(ZR="H":"HOLD",ZR="U":"UNHOLD",ZR="C":"DISCONTINUED",ZR="E":"EDIT",ZR="L":"RENEWED",ZR="P":"PARTIAL",ZR="R":"REINSTATE",ZR="W":"REPRINT REQUEST",ZR="S":"SUSPENDED",ZR="I":"RETURNED TO STOCK",ZR="V":"INTERVENTION",1:0) I REA'=0 Q
 ..S REA=$S(ZR="D":"DELETED",ZR="A":"PENDING/DRUG INTERACTION",ZR="B":"PROCESSED",ZR="X":"X-INTERFACE",1:"EDIT")
 .S ^TMP("PSOR",$J,RX,"ACT",I,0)=$P(^PSRX(RX,"A",I,0),"^")_"^"_REA_"^"_$S($P(^(0),"^",3):$P(^(0),"^",3)_";"_$P($G(^VA(200,$P(^(0),"^",3),0)),"^"),1:"Unknown")_"^"_RFT_"^"_$P(^PSRX(RX,"A",I,0),"^",5) K REA,ZR,RFT,RF
 S SUS=$O(^PS(52.5,"B",RX,0)) I SUS D
 .S ^TMP("PSOR",$J,RX,"SUS",0)=$S(+$G(^PS(52.5,SUS,"P")):"Printed",1:"Not Printed")
 .I $P($G(^PS(52.5,SUS,0)),"^",7)]"" S CMIN=$P(^PS(52.5,SUS,0),"^",7) D
 ..S CMIND=$S(CMIN="Q":"Queued for Transmission",CMIN="X":"Transmission Completed",CMIN="L":"Loading Transmission",1:"Printed Locally"),^TMP("PSOR",$J,RX,"SUS",0)=^TMP("PSOR",$J,RX,"SUS",0)_"^"_CMIND
 I '$P($G(^PSRX(RX,"SIG")),"^",2) S ^TMP("PSOR",$J,RX,"SIG",1,0)=$P($G(^PSRX(RX,"SIG")),"^") D  G CMOP
 .;expands and save SIG
 .S IEN=1,(SIG,X)=$P($G(^PSRX(RX,"SIG")),"^") D:'$G(PSUPSO) SIGONE^PSOHELP S SIG=$E($G(INS1),2,250)
 .F SG=1:1:$L(SIG) S:$L($G(^TMP("PSOR",$J,RX,"SIG1",IEN,0)))>75 IEN=IEN+1 S:$P(SIG," ",SG)'="" ^TMP("PSOR",$J,RX,"SIG1",IEN,0)=$G(^TMP("PSOR",$J,RX,"SIG1",IEN,0))_" "_$P(SIG," ",SG)
 E  F I=0:0 S I=$O(^PSRX(RX,"SIG1",I)) Q:'I  S ^TMP("PSOR",$J,RX,"SIG",I,0)=$G(^PSRX(RX,"SIG1",I,0)),^TMP("PSOR",$J,RX,"SIG1",I,0)=$G(^(0))
CMOP F I=0:0 S I=$O(^PSRX(RX,4,I)) Q:'I  I $D(^PSRX(RX,4,I,0)) S CMOP=^PSRX(RX,4,I,0) D
 .S ^TMP("PSOR",$J,RX,"CMOP",I,0)=$P(CMOP,"^")_"^"_$P(CMOP,"^",2)_"^"_$P(CMOP,"^",3)_"^"_$S($P(CMOP,"^",4)=1:"1;Dispensed",$P(CMOP,"^",4)=2:"2;Retransmitted",$P(CMOP,"^",4)=3:"3;Not Dispensed",1:"0;Transmitted")_"^"_$P(CMOP,"^",5)
 .S ^TMP("PSOR",$J,RX,"CMOP",I,0)=^TMP("PSOR",$J,RX,"CMOP",I,0)_"^"_$P(CMOP,"^",8)
 .S:$P(CMOP,"^",4)=3 ^TMP("PSOR",$J,RX,"CMOP",1,1,0)=$G(^PSRX(RX,4,I,1,0))
 K SIG,SG,IEN,CMOP,CMIN,CMIND,HDST,I,LSFD,PSO2,PSOCF,PSOCST,PSODR,PSODT,PSOLFD,PSOFD,PSOID,PSOJ,PSOPR,PSOPLCL,PSOPLPR,PSOREF,PSORF,PSORFCL,PSORFPR,PSOST,PSOX,RX,RX0,RX0,RX1,RX3,RX3,RXH,RXP,ST0,SUS,FPN
 Q
ODT ;canceled or expiration date
 I +PSOST=12!(+PSOST=14)!(+PSOST=15) D
 .I $P(^PSRX(RX,3),"^",5) S PSODT=$P(^PSRX(RX,3),"^",5) Q
 .F PSOJ=0:0 S PSOJ=$O(^PSRX(RX,"A",PSOJ)) Q:PSOJ'>0  I $P($G(^PSRX(RX,"A",PSOJ,0)),"^")<PSODT,+$P($G(^(0)),"^",2)="C" S PSODT=+$P($G(^(0)),"^")
 Q
