DGRP5 ;ALB/MRL - REGISTRATION SCREEN 5/INSURANCE INFORMATION ;06 JUN 88@2300
 ;;5.3;Registration;**190,366,570**;Aug 13, 1993
 S DGRPW=1,DGRPS=5 D H^DGRPU S Z=1 D WW^DGRPV W " Covered by Health Insurance: " S Z=$S($D(^DPT(DFN,.31)):$P(^(.31),"^",11),1:""),Z=$S(Z="Y":"YES",Z="N":"NO",Z="U":"UNKNOWN",1:"NOT ANSWERED"),Z1=15 D WW1^DGRPV
 W ! D DISP^DGIBDSP
 W ! S DGRPX=$G(^DPT(DFN,.38)),Z=2 D WW^DGRPV W " Eligible for MEDICAID: ",$S(+DGRPX:"YES",$P(DGRPX,"^",1)=0:"NO",1:DGRPU)
 S Y=$P(DGRPX,"^",2) I Y X ^DD("DD") W "   [last updated ",Y,"]"
 ;; *** Added for Medicaid information
 W ! S Z=3 D WW^DGRPV W " Medicaid Number: ",$P(DGRPX,U,3) ;previous $S($P(DGRPX,U,3)>0:$P(DGRPX,U,3),1:"")
 G ^DGRPP
IN ; This code is no longer called, replaced by DISP^IBCNSP2
 Q
