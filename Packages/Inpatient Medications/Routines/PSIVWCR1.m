PSIVWCR1 ;BIR/PR-PRINT WARD COST REPORT ;16 DEC 97 / 1:40 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
P K K F W=0:0 D F W:$D(K) !,?117,"---------------",!,?6,ZF,Z,?114,"$",$J(K,17,2),!! D F S K=0,W=$O(^UTILITY($J,V,W)) Q:'W  D P1
 Q
P1 ;
 S Z=$S($D(^DIC(42,W,0)):$P(^(0),U),1:"OUT-PT") D F W !?1,Z F Y=0:0 S AL=$O(^UTILITY($J,V,W,AL)) Q:AL=""  S K=K+$P(^(AL),U,4) D P2
 Q
P2 S G3=^UTILITY($J,V,W,AL),C=$P(G3,U,2),X=$P(^DD(52.6,2,0),U,3),X=$P(X,";",C),X=$P(X,":",2),C=X
 S TD=TD+$P(G3,U,3),TC=TC+$P(G3,U,4) D F W !,?2,$E(AL,1,36),?38,$J($P(G3,U,3),10,2)_" "_C,?57,$J($P(G3,U,6),10,2) W ?78,$J($P(G3,U,5),7,2),?96,$J($P(G3,U,7),7,2),?114,"$",$J($P(G3,U,4),17,2)
 Q
T ;Print grand total
 D F W !,?117,"==============="
 D F W !,?17,"GRAND TOTAL:",?114,"$",$J(TC,17,2) D TM^PSIVDCR1
 Q
F ;
 I $Y+5>IOSL D H^PSIVWCR
 Q
K K VA,AL,%,^UTILITY($J),V,B,C,DA,NOW,DG,F,H,L,G,G2,S,J,K,LN,NA,PC,I2,I3,UR,ST,TC,TD,CO,UD,UM,W,Y,Z,G3,I7,I8,ZF,DEST,UC,I9,I10,I11 Q
