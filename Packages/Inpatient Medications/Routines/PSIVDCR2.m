PSIVDCR2 ;BIR/PR,MLM-CONT. PRINT DRUG COST REPORT ;07 OCT 97 / 9:30 AM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
P1 ;Print drug name and bag counts
 S I=" BAGS",N=""
 F Q=0:0 S N=$O(^UTILITY($J,V,DC,N)) Q:N=""  S G=^(N,0) D:I2="HIGH" HI I OK D:$D(SMO) P2 I '$D(SMO) D F W !!,$E(N,1,34),?37,$P(G,U,20)_I,?61,$P(G,U,22)_I,?78,$P(G,U,21)_I,?97,$P(G,U,23)_I,?122,$P(G,U,20)-$P(G,U,21)-$P(G,U,23)_I W ! D P2
 Q
P2 ;Sum bags for summary, get unit measure, print total drug cost and units
 S B1=B1+$P(G,U,20),B2=B2+$P(G,U,22),B3=B3+$P(G,U,21),B4=B4+$P(G,U,23)
 S C=$P(G,U),CC=$P(^DD(52.6,2,0),U,3),CC=$P(CC,";",C),CC=$P(CC,":",2),C=CC D @S
 I '$D(BRIEF) D F W !,?30,L1,?53,L1,?71,L1,?90,L1,?117,L1,!?10,"TOTAL DRUG UNITS:",?30,$J(U1,14,2)_" "_C,?53,$J(U2,14,2),?74,$J(U3,11,2),?93,$J(U4,11,2),?114,$J(U1-U3-U4,17,2)
 I '$D(SMO) D F W !,?30,L1,?53,L1,?71,L1,?90,L1,?117,L1,!?10,"TOTAL DRUG COST:",?29,"$",$J(C1,14,2),?52,"$",$J(C2,14,2),?70,"$",$J(C3,14,2),?89,"$",$J(C4,14,2),?113,"$",$J(WT,17,2) W !
 Q
NO ;No patient data. This is indirection @S
 S (U1,U2,U3,U4,WT,C1,C2,C3,C4)=0
BRIEF ;Run a condensed report if $D(BRIEF). A condensed report will never
 ;include patient data.
 S N1="" F Q=0:0 D F S N1=$O(^UTILITY($J,V,DC,N,N1)) Q:N1=""  I N1'=0 S G=^(N1,"NO",0) W:'$D(BRIEF) !?2,"WARD: ",N1,?30,$J($P(G,U,8),14,2)_" "_C,?53,$J($P(G,U,10),14,2),?74,$J($P(G,U,9),11,2),?93,$J($P(G,U,11),11,2),?113,"$",$J($P(G,U),17,2) D 1
 Q
Y ;Patient data. This is indirection @S
 S (U1,U2,U3,U4,WT,C1,C2,C3,C4)=0
 F Q=0:0 S (P1,P2,P3,P4,P5,V1,V2,V3,V4)=0 D F S N1=$O(^UTILITY($J,V,DC,N,N1)) Q:N1=""  I N1'=0 W !?2,"WARD: ",N1 F J=0:0 D F S P=$O(^UTILITY($J,V,DC,N,N1,P)) D:P="" 2 Q:P=""  S G=^(P,0) D Y1
 Q
Y1 ;Patient data continued
 W !?3,$E($P(P,"/"),1,18)," (",$E($P(^DPT($P(P,"/",2),0),U,9),6,9),")",?30,$J($P(G,U,8),14,2)_" "_C,?53,$J($P(G,U,10),14,2),?74,$J($P(G,U,9),11,2),?93,$J($P(G,U,11),11,2),?113,"$",$J($P(G,U),17,2) D 1
 Q
1 ;Sum ward or patient units to get total drug units (U1-U4)
 ;Sum ward or patient costs to get total drug cost (C1-C4)
 S U1=U1+$P(G,U,8),U2=U2+$P(G,U,10),U3=U3+$P(G,U,9),U4=U4+$P(G,U,11),WT=WT+$P(G,U),G5=G5+$P(G,U)
 S C1=C1+$P(G,U,40),C2=C2+$P(G,U,42),C3=C3+$P(G,U,41),C4=C4+$P(G,U,43),G1=G1+$P(G,U,40),G2=G2+$P(G,U,42),G3=G3+$P(G,U,41),G4=G4+$P(G,U,43)
 ;
 ;Sum total patient units to get total ward units.
 ;Sum total patient cost to get total ward cost.
 I $D(PQ) S P1=P1+$P(G,U,8),P2=P2+$P(G,U,10),P3=P3+$P(G,U,9),P4=P4+$P(G,U,11),P5=P5+$P(G,U),V1=V1+$P(G,U,40),V2=V2+$P(G,U,42),V3=V3+$P(G,U,41),V4=V4+$P(G,U,43)
 Q
2 ;If patient data, print total ward units and total ward costs
 D F W !?30,L2,?53,L2,?71,L2,?90,L2,?117,L2,!?6,"TOTAL WARD UNITS:",?30,$J(P1,14,2)_" "_C,?53,$J(P2,14,2),?74,$J(P3,11,2),?93,$J(P4,11,2),?114,$J(P1-P3-P4,17,2)
 D F W !?30,L2,?53,L2,?71,L2,?90,L2,?117,L2,!?6,"TOTAL WARD COST:",?29,"$",$J(V1,14,2),?52,"$",$J(V2,14,2),?70,"$",$J(V3,14,2),?89,"$",$J(V4,14,2),?113,"$",$J(P5,17,2) W !
 Q
HI ;Check low/high cost
 ;S DCO=$P(G,U,5) I DCO'>UCO&(DCO'<LCO) S OK=1,^UTILITY("PSIV",$J,$S($D(^PS(59.5,V,0)):$P(^(0),U),1:"NF"),999999999999999999-DCO,N)=DCO
 S DCO=$P(G,U,5) I DCO'>UCO&(DCO'<LCO) S OK=1,^UTILITY("PSIV",$J,$S($D(^PS(59.5,V,0)):$P(^(0),U),1:"NF"),-DCO,N)=DCO
 E  S OK=0
 Q
F ;Form feed
 D:$Y+5>IOSL H^PSIVDCR1
 Q
