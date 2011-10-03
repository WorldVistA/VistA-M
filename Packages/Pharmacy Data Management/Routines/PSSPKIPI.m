PSSPKIPI ;BIR/MHA-DEA/PKI Post-Inst DEA-CS FED SCH mismatch report ;08/08/02
 ;;1.0;PHARMACY DATA MANAGEMENT;**61**;9/30/97
 ;Reference to ^PSNDF(50.68 supported by DBIA 3735
START ;
 S ZZ="PSSPKI"
 K ^XTMP(ZZ,$J) N PSSX,PSSD,PSSJ,PSSK,PSSN,NDR
 S PSSX="" F  S PSSX=$O(^PSDRUG("B",PSSX)) Q:PSSX=""  D
 .S PSSN=0 F  S PSSN=$O(^PSDRUG("B",PSSX,PSSN)) Q:'PSSN  D
 ..Q:'$D(^PSDRUG(PSSN,0))
 ..I $P($G(^PSDRUG(PSSN,"I")),"^"),$P($G(^("I")),"^")<DT Q
 ..;Q:$P($G(^PSDRUG(PSSN,2)),"^",3)'["O"
 ..S PSSD=$P($G(^PSDRUG(PSSN,0)),"^",3) I PSSD="" D GCS Q
 ..I PSSD[1!(PSSD[2)!(PSSD[3)!(PSSD[4)!(PSSD[5)!($P($G(^PSDRUG(PSSN,2)),"^",3)["N") S PSSJ=0,NDR="" D  D:PSSJ REP
 ...I PSSD["A"&(PSSD["C"),+PSSD=2!(+PSSD=3) S PSSJ=3 Q
 ...S PSSL="",PSSK=$P($G(^PSDRUG(PSSN,"ND")),"^",3) I 'PSSK S PSSJ=2 Q
 ...S PSSL=$$GET1^DIQ(50.68,PSSK,19,"I") Q:'PSSL
 ...S PSSL=$E(PSSL)_$S(PSSL["n":"C",+PSSL=2!(+PSSL=3):"A",1:"")
 ...I $L(PSSL)=1,PSSD[PSSL Q
 ...I PSSD[$E(PSSL),PSSD[$E(PSSL,2) Q
 ...S PSSJ=1,NDR=$$GET1^DIQ(50.68,PSSK,.01),PSSL=$$GET1^DIQ(50.68,PSSK,19,"I")
 D REP4,SM Q
 ;
GCS S PSSL="",PSSK=$P($G(^PSDRUG(PSSN,"ND")),"^",3) Q:'PSSK
 S PSSL=$$GET1^DIQ(50.68,PSSK,19,"I") Q:'PSSL
 S PSSL=$E(PSSL)_$S(PSSL["n":"C",+PSSL=2!(+PSSL=3):"A",1:"")
 S:+PSSL $P(^PSDRUG(PSSN,0),"^",3)=PSSL
 Q
 ;
REP S ^XTMP(ZZ,$J,PSSJ,PSSX)=NDR_"^"_$P($G(^PSDRUG(PSSN,0)),"^",2)_"^"_PSSD_$S(PSSJ=1:"^"_PSSL,1:"")
 Q
SM K ^TMP($J),XMY
 F J=1,2,3,4 I $D(^XTMP(ZZ,$J,J)) D
 .N S1,S2 S $E(S1,42)="",$E(S2,12)="",K="",$P(UL,"=",79)=""
 .D:J=1
 ..S ^TMP($J,J,1)="The following active Controlled Substances were identified as having a"
 ..S ^TMP($J,J,2)="discrepancy between the CS FEDERAL SCHEDULE in the VA PRODUCT file (#50.68)"
 ..S ^TMP($J,J,3)="and the DEA,SPECIAL HDLG code in the DRUG file (#50). You may wish to update"
 ..S ^TMP($J,J,4)="the DEA,SPECIAL HDLG code for these drugs."
 ..S ^TMP($J,J,5)=""
 ..S ^TMP($J,J,6)="PLEASE NOTE:  The CS FEDERAL SCHEDULE will only identify DEA, SPECIAL HDLG"
 ..S ^TMP($J,J,8)="codes of 1, 2A, 2C, 3A, 3C, 4, or 5.  In addition to these codes, you may"
 ..S ^TMP($J,J,9)="also use other DEA, SPECIAL HDLG codes such as L, P,R, S, etc., as needed."
 ..S ^TMP($J,J,10)="",XX=11
 .D:J=2
 ..S ^TMP($J,J,1)="The following active Controlled Substances have not been matched to NDF."
 ..S ^TMP($J,J,2)="You may wish to match these drugs."
 ..S ^TMP($J,J,5)=""
 ..S ^TMP($J,J,6)="GENERIC NAME",$E(^TMP($J,J,6),43)="VA CLASS",$E(^TMP($J,J,6),53)="CURR DEA, SPECIAL HDLG"
 ..S ^TMP($J,J,7)=UL,^TMP($J,J,8)="",XX=9
 .D:J=3
 ..S ^TMP($J,J,1)="The following active drugs are defined as Controlled Substances, but"
 ..S ^TMP($J,J,2)="not classified correctly as Narcotics or Non-Narcotics."
 ..S ^TMP($J,J,3)="Please make sure they are defined correctly."
 ..S ^TMP($J,J,5)=""
 ..S ^TMP($J,J,6)="GENERIC NAME",$E(^TMP($J,J,6),43)="VA CLASS",$E(^TMP($J,J,6),53)="CURR DEA, SPECIAL HDLG"
 ..S ^TMP($J,J,7)=UL,^TMP($J,J,8)="",XX=9
 .D:J=4
 ..S ^TMP($J,J,1)="The following pharmacy orderable items are associated with active dispense"
 ..S ^TMP($J,J,2)="drugs that have a discrepancy within their DEA Special Hdlg fields. Please"
 ..S ^TMP($J,J,3)="correct all entries to identify these orderable items with a specific"
 ..S ^TMP($J,J,5)="Controlled Substance schedule."
 ..S ^TMP($J,J,6)=""
 ..S ^TMP($J,J,7)="PHARMACY ORDERABLE ITEM"
 ..S ^TMP($J,J,8)="   IEN   DISPENSE DRUG",$E(^TMP($J,J,8),52)="DEA SPEC. HDLG",$E(^TMP($J,J,8),67)="CS FED. SCHE."
 ..S ^TMP($J,J,9)=UL,^TMP($J,J,10)="",XX=11
 .F  S K=$O(^XTMP(ZZ,$J,J,K)) Q:K=""  D
 ..S:J'=4 QQ=^XTMP(ZZ,$J,J,K)
 ..I J=1 D PDET Q
 ..I J=4 D REPN Q
 ..S ^TMP($J,J,XX)=$E(K_S1,1,42)_$E($P(QQ,"^",2)_S2,1,10)_$E($P(QQ,"^",3)_S2,1,10),XX=XX+1
 .S XMY(DUZ)="",XMDUZ="Patch # - DEA/PKI Post-Install"
 .I $D(^XUSEC("PSNMGR")) F I=0:0 S I=$O(^XUSEC("PSNMGR",I)) Q:'I  S XMY(I)=""
 .I J=1 S XMSUB="CS FEDERAL SCHEDULE AND DEA, SPECIAL HDLG DISCREPANCIES"
 .I J=2 S XMSUB="CONTROLLED SUBSTANCES NOT MATCHED"
 .I J=3 S XMSUB="CONTROLLED SUBSTANCES NOT SET CORRECTLY"
 .I J=4 S XMSUB="DISCREPANCY IN DEA WITHIN DRUGS TIED TO AN OI"
 .S XMTEXT="^TMP($J,J," N DIFROM D ^XMD K XMY,^TMP($J,J)
END K ^XTMP(ZZ,$J),^TMP($J),XMY,XMDUZ
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
 .I I,J S I="" F  S I=$O(AR(I)) Q:'I  S AR=AR(I),^XTMP(ZZ,$J,4,$P(AR,"^",1,2),I)=$P(AR,"^",3,6)
 Q
REPN ;
 S DOS="" S DOS=$P(^PS(50.7,$P(K,"^",2),0),"^",2) I DOS S DOS=$P(^PS(50.606,DOS,0),"^")
 S ^TMP($J,J,XX)=$P(K,"^")_" "_DOS,XX=XX+1
 S I=0 F  S I=$O(^XTMP(ZZ,$J,J,K,I)) Q:'I  S QQ=$G(^XTMP(ZZ,$J,J,K,I)) D
 .S ^TMP($J,J,XX)="   "_$E(I_"      ",1,6)_$E($P(QQ,"^",2)_S1,1,43)_$E($P(QQ,"^",3)_"              ",1,13)_$P(QQ,"^",4),XX=XX+1
 S ^TMP($J,J,XX)="",XX=XX+1
 Q
