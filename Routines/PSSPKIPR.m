PSSPKIPR ;BIR/MHA-DEA/PKI Post-Inst DEA-CS FED SCH mismatch report ;08/08/02
 ;;1.0;PHARMACY DATA MANAGEMENT;**61,76**;9/30/97
 ;Reference to ^PSNDF(50.68 supported by DBIA 3735
 Q:'$D(OP)
DEV ;
 K %ZIS,IO("Q"),POP,ZTSK S PSDIO=ION,%ZIS="QM" D ^%ZIS
 S ZZ="PSSPKI"
 I POP W !,"NO DEVICE SELECTED !!!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK D  G END
 .S ZTRTN="EN^PSSPKIPR",ZTDESC="PKI CS vs DEA-Spec-Hdlg inconsistent-discrepancy report"
 .N I F I="OP","ZZ" S ZTSAVE(I)=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
 W:$E(IOST)["C" !!,"......Compiling report, this may take a few minutes......",!,"......It is better to QUEUE this report!!........"
EN ;
 K ^XTMP(ZZ) N PSSX,PSSD,PSSJ,PSSK,PSSN,NDR
 S PSSX="" F  S PSSX=$O(^PSDRUG("B",PSSX)) Q:PSSX=""  D
 .S PSSN=0 F  S PSSN=$O(^PSDRUG("B",PSSX,PSSN)) Q:'PSSN  D
 ..Q:'$D(^PSDRUG(PSSN,0))
 ..I $P($G(^PSDRUG(PSSN,"I")),"^"),$P($G(^("I")),"^")<DT Q
 ..S PSSD=$P($G(^PSDRUG(PSSN,0)),"^",3) Q:PSSD=""
 ..I PSSD[1!(PSSD[2)!(PSSD[3)!(PSSD[4)!(PSSD[5)!($P($G(^PSDRUG(PSSN,2)),"^",3)["N") S PSSJ=0,NDR="" D  D:PSSJ REP
 ...I PSSD["A"&(PSSD["C"),+PSSD=2!(+PSSD=3) S PSSJ=3 Q
 ...S PSSL="",PSSK=$P($G(^PSDRUG(PSSN,"ND")),"^",3) I 'PSSK S PSSJ=2 Q
 ...S PSSL=$$GET1^DIQ(50.68,PSSK,19,"I") Q:'PSSL
 ...S PSSL=$E(PSSL)_$S(PSSL["n":"C",+PSSL=2!(+PSSL=3):"A",1:"")
 ...I $L(PSSL)=1,PSSD[PSSL Q
 ...I PSSD[$E(PSSL),PSSD[$E(PSSL,2) Q
 ...S PSSJ=1,NDR=$$GET1^DIQ(50.68,PSSK,.01),PSSL=$$GET1^DIQ(50.68,PSSK,19,"I")
 I OP=4!(OP="A") D REP4
 D EN1 Q
 ;
REP S ^XTMP(ZZ,PSSJ,PSSX)=NDR_"^"_$P($G(^PSDRUG(PSSN,0)),"^",2)_"^"_PSSD_$S(PSSJ=1:"^"_PSSL,1:"")
 Q
EN1 ;
 K ^TMP($J) N S1,S2 S $E(S1,42)="",$E(S2,12)=""
 F J=1,2,3,4 I $D(^XTMP(ZZ,J)) D
 .S K="",XX=1 F  S K=$O(^XTMP(ZZ,J,K)) Q:K=""  D
 ..S:J'=4 QQ=^XTMP(ZZ,J,K)
 ..I J=1 D PDET Q
 ..I J=4 D REPN Q
 ..S ^TMP($J,J,XX)=$E(K_S1,1,42)_$E($P(QQ,"^",2)_S2,1,10)_$E($P(QQ,"^",3)_S2,1,10),XX=XX+1
TST U IO S PG=1,QU=0,$P(UL,"=",80)="" S:OP="A" T=1 S:$G(OP) T=OP D HD
 I OP="A" I '$D(^TMP($J)) W !!,"**********    NO DATA TO PRINT   **********",!! Q
 I $G(OP) D  G END
 .I '$D(^TMP($J,OP)) W !!,"**********    NO DATA TO PRINT   **********",!! Q
 .D PR
 I OP="A" D  G END
 .F T=1,2,3,4 D  Q:QU
 ..I T'=1 S PG=1 D HD
 ..D PR Q:QU
PR S K="" F  S K=$O(^TMP($J,T,K)) Q:'K  W !,^TMP($J,T,K) D:($Y+4)>IOSL HD Q:QU
 Q
END K ^XTMP(ZZ),^TMP($J)
 W ! W:$E(IOST)'["C" @IOF D ^%ZISC
 K ZZ,AR,DIR,DIRUT,DOS,I,J,K,T,NDR,OP,PG,PSSD,PSSJ,PSSK,PSSL,PSSN,PSSX,QQ,QU,S1,S2,T,UL,XX,ZTSAVE
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
PDET ;
 S ^TMP($J,J,XX)="GENERIC NAME: "_K,XX=XX+1
 S ^TMP($J,J,XX)="VA PRODUCT NAME: "_$P(QQ,"^"),XX=XX+1
 S ^TMP($J,J,XX)="VA CLASS: "_$P(QQ,"^",2),XX=XX+1
 S ^TMP($J,J,XX)="CURRENT DEA, SPECIAL HDLG: "_$P(QQ,"^",3),XX=XX+1
 S ^TMP($J,J,XX)="CS FEDERAL SCHEDULE: "_$P(QQ,"^",4),XX=XX+1
 S ^TMP($J,J,XX)="",XX=XX+1
 Q
REP4 ;
 N OI S PSSL="" F  S PSSL=$O(^PSDRUG("ASP",PSSL)) Q:'PSSL  D
 .Q:'$D(^PS(50.7,PSSL,0))  S OI=$P(^PS(50.7,PSSL,0),"^")
 .S PSSN="" K AR S (I,J)=0 F  S PSSN=$O(^PSDRUG("ASP",PSSL,PSSN)) Q:'PSSN  D
 ..Q:'$D(^PSDRUG(PSSN,0))
 ..I $P($G(^PSDRUG(PSSN,"I")),"^"),$P($G(^("I")),"^")<DT Q
 ..S PSSD=$P($G(^PSDRUG(PSSN,0)),"^",3)
 ..Q:PSSD=""
 ..I PSSD["A"!(PSSD["C") I PSSD[1!(PSSD[2)!(PSSD[3)!(PSSD[4)!(PSSD[5)!($P($G(^PSDRUG(PSSN,2)),"^",3)["N") D
 ...S PSSK=$P($G(^PSDRUG(PSSN,"ND")),"^",3)
 ...S:PSSK PSSK=$$GET1^DIQ(50.68,PSSK,19,"I")
 ...S AR(PSSN)=OI_"^"_PSSL_"^"_PSSN_"^"_$P(^PSDRUG(PSSN,0),"^")_"^"_PSSD_"^"_PSSK
 ...I PSSD["A" S I=1 Q
 ...I PSSD["C" S J=1
 .I I,J S I="" F  S I=$O(AR(I)) Q:'I  S AR=AR(I),^XTMP(ZZ,4,$P(AR,"^",1,2),I)=$P(AR,"^",3,6)
 Q
REPN ;
 S DOS="" S DOS=$P(^PS(50.7,$P(K,"^",2),0),"^",2) I DOS S DOS=$P(^PS(50.606,DOS,0),"^")
 S ^TMP($J,J,XX)=$P(K,"^")_" "_DOS,XX=XX+1
 S I=0 F  S I=$O(^XTMP(ZZ,J,K,I)) Q:'I  S QQ=$G(^XTMP(ZZ,J,K,I)) D
 .S ^TMP($J,J,XX)="   "_$E(I_"      ",1,6)_$E($P(QQ,"^",2)_S1,1,43)_$E($P(QQ,"^",3)_"              ",1,13)_$P(QQ,"^",4),XX=XX+1
 S ^TMP($J,J,XX)="",XX=XX+1
 Q
GRP ;
 S PG=1,QU=0 S:OP="A" T=1 D HD
HD I PG>1,$E(IOST)="C" S DIR(0)="E" D ^DIR I $D(DIRUT) S QU=1 Q
 W @IOF D @("H"_T) W !,UL,! S PG=PG+1
 Q
H1 W !?5,"DEA Special Handling & CS Federal Schedule Discrepancies",?71,"Page: ",PG
 I PG=1 D
 .W !!,"The following active Controlled Substances were identified as having a"
 .W !,"discrepancy between the CS FEDERAL SCHEDULE in the VA PRODUCT file (#50.68)"
 .W !,"and the DEA,SPECIAL HDLG code in the DRUG file (#50). You may wish to update"
 .W !,"the DEA,SPECIAL HDLG code for these drugs."
 .W !!,"PLEASE NOTE:  The CS FEDERAL SCHEDULE will only identify DEA, SPECIAL HDLG"
 .W !,"codes of 1, 2A, 2C, 3A, 3C, 4, or 5.  In addition to these codes, you may"
 .W !,"also use other DEA, SPECIAL HDLG codes such as L, P,R, S, etc., as needed."
 Q
H2 W !?10,"Controlled Substances Not Matched to NDF",?71,"Page: ",PG
 I PG=1 D
 .W !!,"The following active Controlled Substances have not been matched to NDF."
 .W !,"You may wish to match these drugs."
 .W !!,"GENERIC NAME",?43,"VA CLASS",?53,"CURR DEA, SPECIAL HDLG"
 Q
H3 W !?7,"CS (DRUGS) with Inconsistent DEA Special Handling Field",?71,"Page: ",PG
 I PG=1 D
 .W !!,"The following active drugs are defined as Controlled Substances, but"
 .W !,"not classified correctly as Narcotics or Non-Narcotics."
 .W !,"Please make sure they are defined correctly."
 .W !!,"GENERIC NAME",?43,"VA CLASS",?53,"CURR DEA, SPECIAL HDLG"
 Q
H4 W !?3,"CS (ORDERABLE ITEMS) with Inconsistent DEA Special Handling Field",?71,"Page: ",PG
 I PG=1 D
 .W !!,"The following pharmacy orderable items are associated with active dispense"
 .W !,"drugs that have a discrepancy within their DEA Special Hdlg fields. Please"
 .W !,"correct all entries to identify these orderable items with a specific"
 .W !,"Controlled Substance schedule."
 .W !!,"PHARMACY ORDERABLE ITEM"
 .W !,"   IEN   DISPENSE DRUG",?52,"DEA SPEC. HDLG",?67,"CS FED. SCHE."
 Q
