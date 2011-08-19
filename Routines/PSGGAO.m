PSGGAO ;BIR/CML3-PATIENT AND ORDER LOOK-UPS ;20 JUN 94 / 3:16 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
ENP ; get patient with active orders(UD & IV orders)
 N X,Y F  D ENDPT^PSGP D  Q:X!(PSGP<0)
 .  S X=0 Q:PSGP<0
 .  S X=$O(^PS(55,PSGP,5,"AUS",PSGDT)) Q:X
 .  F Y="A","C","H","P","S" S X=$O(^PS(55,PSGP,"IV","AIT",Y,PSGDT)) Q:X
 .  W:'X $C(7),!,"(Patient has NO active orders.)"
 Q
 ;
ENO ; get active order
 I $D(PSGP),PSGP S D="C",DIC(0)="QEAIS",DIC="^PS(55,"_PSGP_",5,",DIC("S")="I $D(^PS(55,"_PSGP_",5,+Y,2)),($P(^(2),""^"",4)>"_PSGDT_")",DIC("A")="Select ACTIVE ORDER: " W ! D IX^DIC K DIC Q
 ;
ENN ; get patient and their non-verified order
 F  D ENDPT^PSGP Q:$S(PSGP>0:$D(^PS(53.1,"AC",PSGP)),1:0)  W $C(7),!,"(Patient has NO non-verified orders.)"
 Q
 ;
ENNO S D="D",DIC("A")="Select NON-VERIFIED ORDER: ",DIC="^PS(53.1,",DIC(0)="QEAI",DIC("S")="I $D(^PS(53.1,""AC"","_PSGP_",+Y))" W ! D IX^DIC K DIC Q
 ;
ENAO ;
 F  D ENDPT^PSGP Q:$S(PSGP'>0:1,$O(^PS(55,PSGP,5,"AUS",+PSJPAD)):1,1:$D(^PS(53.1,"AC",PSGP)))  W !?3,"(Patient has no orders.)"
 Q
