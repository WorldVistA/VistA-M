PSOHCSUM ;BHAM ISC/SAB - gather data for outpatient rx health care summary ;03/01/96 8:29
 ;;7.0;OUTPATIENT PHARMACY;**4,35,48,54,46,103,132,214,200**;DEC 1997;Build 7
 ;External reference to File ^PS(55 supported by DBIA 2228
 ;External reference to File ^PSDRUG supported by DBIA 221
 ;External reference to File ^PS(50.7 supported by DBIA 2223
 ;External reference ^PS(50.606 supported by DBIA 2174
 ;External reference to ^SC supported by DBIA 10040
 ;Accepts DFN (assumed to be valid)
 ;Looks for PSOBEGIN as earliest expiration/cancel date for search
 ;If $D(PSOBEGIN)=0 use DT as earliest expiration/cancel date
 ;returns data in ^TMP("PSOO",$J,Inverse last fill date,0)
 ;data is ISSUE DATE^LAST FILL DATE^DRUG^PROVIDER^STATUS^RX#^QTY^#REFILLS^IFN^COST/FILL^EXP/CANC DATE
 ;and ^TMP("PSOO",$J,Inverse last fill date,n,0)=SIG
 ;NON-VA Meds: ^TMP("PSOO",$J,"NVA",n,0)=orderable item_" "_dose form^status (active or discontinued)^start date(fm format)^cprs order # (ptr to 100)^date/time documented (fm format)^documented by (ptr to 200_";"_.01)^dc date/time(fm format)
 ;^TMP("PSOO",$J,"NVA",n,1,0)=dosage^med route^schedule^drug (file #50_";"_.01)^clinic (file #44_";"_.01)
 ;^TMP("PSOO",$J,"NVA",n,"DSC",nn,0)=statement/explanation/comments
 ;
 ;returns PSOBEGIN (if sent or equal DT if not sent)
 ;
 ;If $D(PSOACT) loop thru PS(55,DFN,"P","A") from PSOBEGIN to get actives only
 ;otherwise loop through entire "P" multiple to get all Rx's
 ;
 S ACS=0
EN K ^TMP("PSOO",$J),PSONV
 S PSOBEGIN=$S($D(PSOBEGIN):PSOBEGIN,1:DT)
 I $D(PSOACT) F PSODT=PSOBEGIN-1:0 S PSODT=$O(^PS(55,DFN,"P","A",PSODT)) Q:'PSODT  F PSORXX=0:0 S PSORXX=$O(^PS(55,DFN,"P","A",PSODT,PSORXX)) Q:'PSORXX  D:$G(^PSRX(PSORXX,0))]"" GET
 I '$D(PSOACT) F PSOI=0:0 S PSOI=$O(^PS(55,DFN,"P",PSOI)) Q:'PSOI  S PSORXX=+^(PSOI,0) D:$G(^PSRX(PSORXX,0))]"" GET
 F I=0:0 S I=$O(^PS(55,DFN,"NVA",I)) Q:'I  S NVA=^PS(55,DFN,"NVA",I,0) D
 .Q:'$P(NVA,"^")  S PSONV=$G(PSONV)+1
 .S ^TMP("PSOO",$J,"NVA",PSONV,0)=$S($D(^PS(50.7,$P(+NVA,"^"),0)):$P(^PS(50.7,$P(+NVA,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"),1:"")_"^"
 .S ^TMP("PSOO",$J,"NVA",PSONV,0)=^TMP("PSOO",$J,"NVA",PSONV,0)_$S($P(NVA,"^",6):"Discontinued",1:"Active")_"^"_$P(NVA,"^",9)_"^"_$P(NVA,"^",8)_"^"_$P(NVA,"^",10)_"^"_$P(NVA,"^",11)_";"_$P($G(^VA(200,$P(NVA,"^",11),0)),"^")_"^"_$P(NVA,"^",7)
 .S ^TMP("PSOO",$J,"NVA",PSONV,1,0)=$P(NVA,"^",3)_"^"_$P(NVA,"^",4)_"^"_$P(NVA,"^",5)_"^"_$S($P(NVA,"^",2):$P(NVA,"^",2)_";"_$P(^PSDRUG($P(NVA,"^",2),0),"^"),1:"")_"^"
 .S ^TMP("PSOO",$J,"NVA",PSONV,1,0)=^TMP("PSOO",$J,"NVA",PSONV,1,0)_$S($D(^SC(+$P(NVA,"^",12),0)):$P(NVA,"^",12)_";"_$P(^SC($P(NVA,"^",12),0),"^"),1:"")
 .F S=0:0 S S=$O(^PS(55,DFN,"NVA",I,"DSC",S)) Q:'S  S ^TMP("PSOO",$J,"NVA",PSONV,"DSC",S,0)=^PS(55,DFN,"NVA",I,"DSC",S,0)
 ;
END K PSODT,PSOST,PSORXX,PSO0,PSO2,PSOIDD,PSOFD,PSODR,PSOPR,PSOREF,PSORFL,PSOI,PSOJ,PSOX,PSOCF,I,PSONV,NVA,PSOPN,PSORS
 Q
 ;
GET Q:$P($G(^PSRX(PSORXX,"STA")),"^")=13  S PSO0=^PSRX(PSORXX,0),PSO2=$G(^(2)),PSOFD=+$G(^(3)),PSODR=$P(PSO0,"^",6),PSOPR=$P(PSO0,"^",4),PSOREF=$P(PSO0,"^",9),PSOIDD=$P(PSO0,"^",13)
 I '$P(PSO0,"^",2)!('PSODR)!('PSOPR) Q
 I $D(^PS(55,$P(PSO0,"^",2),0)) D:$P($G(^PS(55,$P(PSO0,"^",2),0)),"^",6)'=2 EN^PSOHLUP($P(PSO0,"^",2))
 S PSOST=$P($G(^PSRX(PSORXX,"STA")),"^"),PSOPN=$P($G(^PSRX(PSORXX,"OR1")),"^",2)
 I '$D(PSOACT) D ODT I PSODT<PSOBEGIN Q
 I $D(PSOACT) Q:PSOST>10&(PSOST<16)
 S PSORS="" I PSOFD=+$P(PSO2,"^",2),+$P(PSO2,"^",15) S PSORS="R"
 I 'PSOFD S PSOFD=$P(PSO0,"^",13) F PSOJ=0:0 S PSOJ=$O(^PSRX(PSORXX,1,PSOJ)) Q:'PSOJ  I $D(^(PSOJ,0)),^(0)>PSOFD S PSOFD=+^(0)
 S PSOX=$S($D(^PSDRUG(PSODR,0)):$P(^(0),"^"),1:"NOT ON FILE"),PSODR=PSODR_";"_PSOX
 S PSOX=$G(^VA(200,PSOPR,0)) S PSOPR=PSOPR_";"_$P(PSOX,"^")
 S PSOX="A;ACTIVE" S:$D(^PS(52.4,PSORXX,0)) PSOX="N;NON-VERIFIED" S:$O(^PS(52.5,"B",PSORXX,0))&($G(^PS(52.5,+$O(^PS(52.5,"B",PSORXX,0)),"P"))'=1) PSOX="S;SUSPENDED"
 I PSOX["SUSPENDED",$G(ACS) S PSOX="S;ACTIVE/SUSP"
 S:PSODT<DT PSOX="E;EXPIRED" S:PSOST=4 PSOX="N;NON-VERIFIED" S:PSOST=3!(PSOST=16) PSOX="H;HOLD"
 S:PSOST=12!(PSOST=14)!(PSOST=15) PSOX="DC;DISCONTINUED"
 S PSOCF=+$P(PSO0,"^",17)*(+$P(PSO0,"^",7)) ; Cost/Fill
 S PSORFL=0 F PSOJ=0:0 S PSORFL=$O(^PSRX(PSORXX,1,PSORFL)) Q:PSORFL'>0  S PSOREF=PSOREF-1
 F PSOJ=9999999-PSOFD:.0001 Q:'$D(^TMP("PSOO",$J,PSOJ))
 S ^TMP("PSOO",$J,PSOJ,0)=PSOIDD_"^"_PSOFD_"^"_PSODR_"^"_PSOPR_"^"_PSOX_"^"_$P(PSO0,"^")_"^"_$P(PSO0,"^",7)_"^"_PSOREF_"^"_PSORXX_"^"_PSOCF_"^"_PSODT_"^"_PSOPN
 S:PSORS="R" ^TMP("PSOO",$J,PSOJ,0)=^TMP("PSOO",$J,PSOJ,0)_"^"_PSORS
 I '$P(^PSRX(PSORXX,"SIG"),"^",2) D SIG Q
 F I=0:0 S I=$O(^PSRX(PSORXX,"SIG1",I)) Q:'I  S ^TMP("PSOO",$J,PSOJ,I,0)=^PSRX(PSORXX,"SIG1",I,0)
 Q
SIG ;formats backdoor SIG
 S X=$P(^PSRX(PSORXX,"SIG"),"^") D SIGONE^PSOHELP S SIG=$E($G(INS1),2,250),ENT=1
 F SG=1:1:$L(SIG) S:$L($G(^TMP("PSOO",$J,PSOJ,ENT,0))_" "_$P(SIG," ",SG))>80 ENT=ENT+1 S:$P(SIG," ",SG)'="" ^TMP("PSOO",$J,PSOJ,ENT,0)=$G(^TMP("PSOO",$J,PSOJ,ENT,0))_" "_$P(SIG," ",SG)
 K SIG,ENT,SG,X Q
ODT ;canceled or expiration date
 I +PSOST=12!(PSOST=14)!(PSOST=15) D  Q
 .I $P(^PSRX(PSORXX,3),"^",5) S PSODT=$P(^PSRX(PSORXX,3),"^",5) Q
 .S PSODT=0 F PSOJ=0:0 S PSOJ=$O(^PSRX(PSORXX,"A",PSOJ)) Q:PSOJ'>0  I $D(^(PSOJ,0)),$P(^(0),"^",2)="C",+$P(^(0),"^")>PSODT S PSODT=+$P(^(0),"^")
 S PSODT=+$P(PSO2,"^",6)
 Q
ACS ;call from OE/RR to get the new active/susp status
 S ACS=1 D EN
 Q
