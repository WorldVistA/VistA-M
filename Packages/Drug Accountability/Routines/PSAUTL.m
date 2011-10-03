PSAUTL ;BIR/LTL-GIP Utility ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine is a utility that checks for Primarys already linked to
 ;a pharmacy location. It also returns the ITEM MASTER file's internal
 ;entry number of an item. It is called by PSALNA, PSALND, PSALNM, and;
 ;PSATI.
 ;
DALINK ;check for Primary already linked to DA location
 I $O(^PSD(58.8,"P",X,0)) S PSA=$P($G(^PSD(58.8,+$O(^PSD(58.8,"P",X,0)),0)),U)_" is already linked to "_$$INVNAME^PRCPUX1(X)_"." D EN^DDIOL(PSA) K PSA,X Q
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
 ;
