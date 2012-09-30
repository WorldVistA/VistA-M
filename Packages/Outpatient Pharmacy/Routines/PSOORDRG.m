PSOORDRG ;BIR/SAB - order entry drug selection ;11/13/97
 ;;7.0;OUTPATIENT PHARMACY;**3,29,49,46,81,105,134,144,132,188,207,148,243,251,379**;DEC 1997;Build 28
 ;External references to ^PSJORUT2 supported by DBIA 2376
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.605 supported by DBIA 696
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PS(56 supported by DBIA 2229
 ;External reference to ^PS(50.416 supported by DBIA 692
 ;External reference to DDIEX^PSNAPIS supported by DBIA 2574
 ;External references to ^ORRDI1 supported by DBIA 4659
 ;Reference to $$GETNDC^PSSNDCUT supported by IA 4707
 ;
EN(PSODFN,DREN) ;
 K ^TMP($J,"DI"),^TMP($J,"DD"),^TMP($J,"DC"),^TMP($J,"DI"_PSODFN),PSOPHI S INDX=0
 ;build patient's drug profile outpat/inpat/non-va
 D BLD,ENCHK^PSJORUT2(PSODFN,.INDX),NVA
 ;collect drug info
DRG ;S X=DREN,DIC="^PSDRUG(",DIC(0)="MQNZO" D ^DIC K DIC,PSOY Q:Y<1  S PSOY=Y,PSOY(0)=Y(0) K X,Y
 N PSOICT S PSOICT=""
 S PSOY=DREN_"^"_$P($G(^PSDRUG(DREN,0)),"^"),PSOY(0)=$G(^PSDRUG(DREN,0)) K X,Y
 S PSODRUG("IEN")=+PSOY,PSODRUG("VA CLASS")=$P(PSOY(0),"^",2),PSODRUG("NAME")=$P(PSOY(0),"^")
 S:+$G(^PSDRUG(+PSOY,2)) PSODRUG("OI")=+$G(^(2)),PSODRUG("OIN")=$P(^PS(50.7,+$G(^(2)),0),"^")
 S PSODRUG("NDF")=$S($G(^PSDRUG(+PSOY,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 S PSODRUG("MAXDOSE")=$P(PSOY(0),"^",4),PSODRUG("DEA")=$P(PSOY(0),"^",3),PSODRUG("CLN")=$S($D(^PSDRUG(+PSOY,"ND")):+$P(^("ND"),"^",6),1:0)
 S PSODRUG("SIG")=$P(PSOY(0),"^",5),PSODRUG("NDC")=$$GETNDC^PSSNDCUT(+PSOY,$G(PSOSITE))
 S PSODRUG("DAW")=$$GET1^DIQ(50,+PSOY,81)
 S PSOX1=$G(^PSDRUG(+PSOY,660)),PSODRUG("COST")=$P($G(PSOX1),"^",6),PSODRUG("UNIT")=$P($G(PSOX1),"^",8),PSODRUG("EXPIRATION DATE")=$P($G(PSOX1),"^",9)
 K PSOX1,PSOY Q:$G(POERR)
 ;dup drug/class check
 S DNM=0 F  S DNM=$O(^TMP($J,"ORDERS",DNM)) Q:'DNM  D
 .S DRNM=$P(^TMP($J,"ORDERS",DNM),"^",3)
 .I PSODRUG("NAME")=DRNM S DD=$G(DD)+1,^TMP($J,"DD",DD,0)=PSODRUG("IEN")_"^"_PSODRUG("NAME")_"^"_$P(^TMP($J,"ORDERS",DNM),"^",4)_"^"_$P(^(DNM),"^",5) Q:'$G(PSOPHI)
 .I PSODRUG("VA CLASS")]"",$E(PSODRUG("VA CLASS"),1,4)=$E($P(^TMP($J,"ORDERS",DNM),"^"),1,4),DRNM'=PSODRUG("NAME") D
 ..I $E(PSODRUG("VA CLASS"),1,2)="HA",$E($P(^TMP($J,"ORDERS",DNM),"^"),1,2)="HA" Q
 ..S PSODC=$O(^PS(50.605,"B",PSODRUG("VA CLASS"),0)) Q:'PSODC
 ..S DC=$G(DC)+1,^TMP($J,"DC",DC,0)=PSODRUG("VA CLASS")
 ..S PSODC=$P(^PS(50.605,PSODC,0),"^",2),^TMP($J,"DC",DC,0)=^TMP($J,"DC",DC,0)_"^"_PSODC_"^"_$O(^PSDRUG("B",DRNM,0))_"^"_DRNM_"^"_$P(^TMP($J,"ORDERS",DNM),"^",4)_"^"_$P(^(DNM),"^",5)
 ;drug interaction check
 S DRG=0
 F  S DRG=$O(^TMP($J,"ORDERS",DRG)) Q:'DRG  S NDF=$P(^TMP($J,"ORDERS",DRG),"^",2) D
 .S IT=0,PSOICT=""
 .F  S IT=$O(^PS(56,"APD",NDF,PSODRUG("NDF"),IT)) Q:'IT  D
 ..Q:$$DDIEX^PSNAPIS($P(NDF,"A"),$P(NDF,"A",2))
 ..Q:$$DDIEX^PSNAPIS($P(PSODRUG("NDF"),"A"),$P(PSODRUG("NDF"),"A",2))
 ..Q:$P(^PS(56,IT,0),"^",7)&($P(^PS(56,IT,0),"^",7)<DT)
 ..I 'PSOICT S PSOICT=IT Q
 ..I $P($G(^PS(56,IT,0)),"^",4)=1 S PSOICT=IT Q
 ..Q
 .I 'PSOICT Q
 .S IT=PSOICT
 .S DRNM=$P(^TMP($J,"ORDERS",DRG),"^",3),ORN=$P(^(DRG),"^",4),RXN=$P(^(DRG),"^",5)
 .S DI=$G(DI)+1,^TMP($J,"DI",DI,0)=$O(^PSDRUG("B",DRNM,0))_"^"_DRNM_"^"_IT_"^"_$S($P(^PS(56,IT,0),"^",4)=1:"CRITICAL",1:"SIGNIFICANT")_"^"
 .S ^TMP($J,"DI",DI,0)=^TMP($J,"DI",DI,0)_$P(^PS(50.416,$P(^PS(56,IT,0),"^",2),0),"^")_"^"_$P(^PS(50.416,$P(^PS(56,IT,0),"^",3),0),"^")_"^"_ORN_"^"_RXN
 D REMOTE
 Q:$G(PSOPHI)
EXIT K ^TMP($J,"ORDERS"),DFN,DA,DNM,DUPRX0,RX,Y,ZZ,PSOCLOZ,PSOY,DRG,DNM,DD,DI,DC,IT,PSODRUG,PSOY,ORN,DRNM
 K PSOX,EXPDT,PSODRUG0,PSORX0,PSORX2,PSORX3,PSOST0,PSOVACL,X,Y,X1,X2,RXN
 Q
BLD K ^TMP($J,"ORDERS") I '$D(PSODFN)!('$D(DT)) G EXIT
 S X1=DT,X2=-120 D C^%DTC S PSODTCUT=X D BUILD G GETX
 Q
BUILD ;build profiles
 S EXPDT=PSODTCUT-1,RX=0
 F  S EXPDT=$O(^PS(55,PSODFN,"P","A",EXPDT)) Q:'EXPDT  F  S RX=$O(^PS(55,PSODFN,"P","A",EXPDT,RX)) Q:'RX  I $D(^PSRX(RX,0)) D GET
 S EN=0
 F PSOEN=0:0 S PSOEN=$O(^PS(52.41,"AOR",PSODFN,PSOEN)) Q:'PSOEN  D
 .F  S EN=$O(^PS(52.41,"AOR",PSODFN,PSOEN,EN)) Q:'EN  D
 ..Q:'$P(^PS(52.41,EN,0),"^",8)
 ..S PSOOI=^PS(52.41,EN,0)
 ..I $P(PSOOI,"^",3)'="DC"&($P(PSOOI,"^",3)'="DE") D
 ...I '$P(^PS(52.41,EN,0),"^",9) D BLDOI Q
 ...S PSODD=+$P(PSOOI,"^",9) D SETTMP
 D BUILDX
 Q
 ;
BLDOI ;If no DD/non-standard dose, get all drugs for OI
 N PSOI S PSOI=$P(PSOOI,"^",8) Q:'PSOOI
 S PSODD="" F  S PSODD=$O(^PSDRUG("ASP",PSOI,PSODD)) Q:'PSODD  D SETTMP
 Q
 ;
SETTMP ;Create ^TMP($J,"ORDERS"
 Q:$P(PSOOI,"^",3)="RF"
 S DRG=$S(PSODD:$P($G(^PSDRUG(PSODD,0)),"^"),1:"") Q:DRG']""
 S INDX=$G(INDX)+1,^TMP($J,"ORDERS",INDX)=$S(PSODD:$P(^PSDRUG(PSODD,0),"^",2),1:"")_"^"_$S($G(^PSDRUG(PSODD,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)_"^"_DRG_"^"_$P(^PS(52.41,EN,0),"^")_"^"_EN_"P;O"
 Q
 ;
BUILDX K EN,PSOOI,PSODD,PSOEN Q
 ;
GET ;data for profiles
 S PSORX0=^PSRX(RX,0),PSOST0=+^("STA") Q:PSOST0>5&(PSOST0'=16)
 S PSORX2=$G(^PSRX(RX,2)),PSORX3=$G(^(3)),ORN=$P($G(^("OR1")),"^",2) S:PSORX3="" PSORX3=$P(PSORX2,"^",2)
 S PSODRUG=+$P(PSORX0,"^",6) Q:'$D(^PSDRUG(PSODRUG,0))
 S PSODRUG0=^PSDRUG(PSODRUG,0),PSOVACL=$P(PSODRUG0,"^",2)
 ;
 I EXPDT<DT D
 .N DIE,DIC,DR,DA S STAT="SC",DIE=52,DA=RX,DR="100////11" D ^DIE K DIE,DIC,DR,DA
 .D ECAN^PSOUTL(RX) S DA=RX
 .S COMM="Prescription Expired",PHARMST="ZE" D EN^PSOHLSN1(DA,STAT,PHARMST,COMM)
 S INDX=$G(INDX)+1
 S ^TMP($J,"ORDERS",INDX)=PSOVACL_"^"_$S($G(^PSDRUG(PSODRUG,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)_"^"_$P(^PSDRUG(PSODRUG,0),"^")_"^"_ORN_"^"_RX_"R;O"
 Q
GETX ;
 K PSOX,EXPDT,PSODRUG,PSODRUG0,PSORX0,PSORX2,PSORX3,PSOST0,PSOVACL,X,Y,X1,X2,ORN
 Q
CLOZ ;
 S ANQRTN=$P(^PSDRUG(PSODRUG("IEN"),"CLOZ1"),"^"),ANQX=0,P(5)=PSODRUG("IEN"),DFN=PSODFN,X=ANQRTN
 X ^%ZOSF("TEST") I  D @("^"_ANQRTN) S:$G(ANQX) PSORX("DFLG")=1
 K P(5),ANQRTN,ANQX,X
 Q
DRGCHK(PSODFN,DREN,DDRUG)    ;Only check DREN against drug in DDRG()
 ;* PSODFN = Patient's DFN
 ;* DREN   = Dispense drug to be checked against the drug in the array
 ;* DDRUG  = The array of dispense drug in the buffer.
 ;*
 K ^TMP($J,"DI"),^TMP($J,"DD"),^TMP($J,"DC")
 NEW DDRUG0,DDRUGND,COD,PSJINX S COD="",PSJINX=0
 S DDRUG=0 F  S DDRUG=$O(DDRUG(DDRUG)) Q:'DDRUG  D DDRUG^PSJORUT2
 D DRG
 Q
OIDRG(PSODFN,PSOI) ;checks every drug tied to orderable item passed by package use
 K ^TMP($J,"DI"),^TMP($J,"DD"),^TMP($J,"DC"),DD,DC,DI N DREN S INDX=0,PSOPHI=1
 ;build patient's drug profile inpat/outpat/non-va
 D BLD,ENCHK^PSJORUT2(PSODFN,.INDX),NVA
 F DREN=0:0 S DREN=$O(^PSDRUG("ASP",PSOI,DREN)) Q:'DREN  I $D(^PSDRUG(DREN,O)) D DRG
 K PSOPHI D EXIT
 Q
NVA ;checks existing nva
 F I=0:0 S I=$O(^PS(55,PSODFN,"NVA",I)) Q:'I  D:$D(^PS(55,PSODFN,"NVA",I,0))
 .Q:$P(^PS(55,PSODFN,"NVA",I,0),"^",7)
 .S PSOI=$P(^PS(55,PSODFN,"NVA",I,0),"^"),DRG=$P(^(0),"^",2),ORN=$P(^(0),"^",8)
 .I DRG,$G(^PSDRUG(DRG,0))]"" D NVA1 K DRG Q
 .K DRG F DRG=0:0 S DRG=$O(^PSDRUG("ASP",PSOI,DRG)) Q:'DRG  D:$D(^PSDRUG(DRG,0)) NVA1
 K I,PSOOTC,ORN,PSOI,DRG,DRGN,PSOY,VACL,NDF
 Q
NVA1 S PSOY=$G(^PSDRUG(DRG,0)),DRGN=$P(PSOY,"^"),VACL=$P(PSOY,"^",2)
 S NDF=$S($G(^PSDRUG(DRG,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 S INDX=$G(INDX)+1,^TMP($J,"ORDERS",INDX)=VACL_"^"_NDF_"^"_DRGN_"^"_ORN_"^"_I_"N;O"
 Q
 ;
REMOTE ;
 I $T(HAVEHDR^ORRDI1)']"" Q
 I '$$HAVEHDR^ORRDI1 Q
 D REMOTE^PSOORRDI(PSODFN,DREN)
 K ^TMP($J,"DI"_PSODFN) ;THIS LEVEL ONLY NEEDED FOR BACKDOOR OUTPATIENT PHARMACY CHECKS
 Q
 ;
