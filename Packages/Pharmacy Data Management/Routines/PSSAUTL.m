PSSAUTL ;BIR/LTL-Utility Routine for FM functions ; 09/02/97 8:28
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
DALINK ;check for Primary already linked to DA location
 I $O(^PSD(58.8,"P",X,0)) W $C(7),!!,$P($G(^PSD(58.8,+$O(^PSD(58.8,"P",X,0)),0)),U)," is already linked to ",$$INVNAME^PRCPUX1(X) K X Q
 Q
FI N PSA S PSA=$O(^PSDRUG("AB",+X,0)) S:PSA=DA PSA=$O(^(DA)) W:$G(PSA) $C(7),!!,$P($G(^PSDRUG(+$O(^PSDRUG("AB",+X,"")),0)),U)," is already linked to",!!,"Item #",X,"  ",$$DESCR^PRCPUX1(0,X) S:$G(PSA) X="" Q
 ;
ITEM(PSA) ;return Item Master # ^PRC(441
 ;PSA = NDC from ^PSDRUG(
 S PSA(1)=$O(^PRC(441,"F",PSA,0))
 D:'PSA(1)
 .S:$L($P(PSA,"-"))<6 PSA(1)=$O(^PRC(441,"F",0_PSA,0))
 .S:'PSA(1)&($L($P(PSA,"-"))=4) PSA(1)=$O(^PRC(441,"F","00"_PSA,0))
 .I 'PSA(1),'$E(PSA),$L($P(PSA,"-"))>4 S PSA(1)=$O(^PRC(441,"F",$E(PSA,2,14),0))
 .I 'PSA(1),'$E(PSA,1,2),$L($P(PSA,"-"))=6 S PSA(1)=$O(^PRC(441,"F",$E(PSA,3,14),0))
 Q PSA(1)
