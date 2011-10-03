DGQEMPS ;RWA/SLC-DHW/OKC - EMBOSSER SPECIAL SUBROUTINES;04/08/85  4:36 PM ; 04 Oct 85  2:13 PM
 ;;5.3;Registration;;Aug 13, 1993
END Q
 ;
 ;FileMan data reference
 ;      Need only: DFN = patient internal number
 ;                   Y = field number desired
FM ;
 Q
 ;
 ;CALCULATE 'SPECIAL CODE' FIELD FOR PATIENT DATA CARD
SPEC D PER S Y=$S(Y=1:"WWI",Y=3:"SAW",1:"")
 I $D(^DPT(DFN,.362)) S D=^(.362),Y=$S($P(D,"^",12)["Y":"AA",1:"")_Y
 I $D(^DPT(DFN,.362)) S D=^(.362),Y=$S($P(D,"^",13)["Y":"HB",1:"")_Y
 I $D(^DPT(DFN,.52)),$P(^(.52),"^",5)="Y" S Y=Y_"POW"
 S Y="       "_Y,D=$L(Y),Y=$E(Y,D-6,D) Q
 ;
 ;CALCULATE ELIGIBILITY CODE
ELIG S Y="" I $D(^DPT(DFN,.36)) S X=$P(^(.36),"^",1) I X,$D(^DIC(8,X,0)) S Y=$P(^(0),"^",4)
 Q
 ;
 ;CALCULATE 'MODIFIER' FIELD FOR PATIENT DATA CARD
MOD S Y="" I $D(^DPT(DFN,.321)),^(.321)?1"Y".E S Y="V"
 Q
 ;
 ;CALCULATE PERIOD OF SERVICE CODE
PER S Y="" I $D(^DPT(DFN,.32)) S X=$P(^(.32),"^",3) I X,$D(^DIC(21,X,0)) S Y=$P(^(0),"^",3)
 Q
