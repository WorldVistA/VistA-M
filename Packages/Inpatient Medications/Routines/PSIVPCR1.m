PSIVPCR1 ;BIR/PR,MV-PRINT PROVIDER COST REPORT ;07 OCT 97 / 9:49 AM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
P ;
 S:'$D(PT) (PT,GT)=0 S (P,DG)=""
 I $D(BRIEF) D BRIEF Q
 F V=0:0 D F S V=$O(^UTILITY($J,V)) Q:'V  W !,"IV ROOM: "_$P(^PS(59.5,V,0),U),! D P1
 D F W !!?17,"GRAND TOTAL:",?116,"================",!?114,"$",$J(GT,17,2) D TM^PSIVDCR1 G K
 Q
P1 ;
 S P1="" F J=0:0 D F S P1=$O(^UTILITY($J,V,P1)) Q:P1=""  W !?1,"PROVIDER: ",P1,! D P2
 Q
P2 ;
 F J=0:0 S DG=$O(^UTILITY($J,V,P1,DG)) Q:DG=""  D P3
 D F W !,?116,"----------------"
 D F W !?5,"TOTAL FOR PROVIDER: ",P1,?114,"$",$J(PT,17,2),!! S GT=GT+PT,PT=0
 Q
P3 ;
 S G=^UTILITY($J,V,P1,DG)
 S C=$P(G,U,2),X=$P(^DD(52.6,2,0),U,3),X=$P(X,";",C),X=$P(X,":",2),C=X
 I $D(BRIEF) S PT=PT+$P(G,U,4) Q
 D F W !?2,$E(DG,1,33),?36,$J($P(G,U,3),8,2)_" "_C,?59,$J($P(G,U,6),8,2),?73,$J($P(G,U,5),9,2),?96,$J($P(G,U,7),9,2),?114,"$",$J($P(G,U,4),17,2) S PT=PT+$P(G,U,4)
 Q
F ;
 I $Y+5>IOSL D H^PSIVPCR
 Q
BRIEF ;***Print the condensed Provider cost report.
 S (P1,DG)="" F V=0:0 D F S V=$O(^UTILITY($J,V)) Q:'V  W !!!?10,"IV ROOM: "_$P(^PS(59.5,V,0),U),! D
 . F  S P1=$O(^UTILITY($J,V,P1)) Q:P1=""  D
 .. F  S DG=$O(^UTILITY($J,V,P1,DG)) Q:DG=""  S PT=PT+$P(^UTILITY($J,V,P1,DG),U,4)
 .. W !,P1,?45,"$",$J(PT,17,2),! S GT=GT+PT,PT=0
 W !!,?46,"=================",!,?20,"GRAND TOTAL:",?45,"$",$J(GT,17,2)
 D TM^PSIVDCR1
 D K
 Q
K ;
 S:$D(ZTQUEUED) ZTREQ="@"
 K VA,DA,DAT,DES,P,P1,DG,G,G2,GT,H,I,V,J,JJ,NA,PG,UR,SS,S,PT,CO,UD,UM,Y,I7,I8,I6,I2,C,UC,D,I1,ZTSK,Z,Y,^UTILITY($J),I9,I10,I11,I4,I15,%
 Q
