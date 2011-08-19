EASECSC2 ;ALB/PHH,LBD - LTC Copay Test Screen Insurance Information ;18 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,40,45**;Mar 15, 2001
 ;
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  LTC Co-Pay Test Action
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ;           DGVPRI   Veteran Patient Relation IEN
 ; Output -- None
 ;
 ; ** For LTC Phase IV (EAS*1*40) this routine has been modified to
 ;    display the patient's insurance information instead of 
 ;    eligibility
 ;
EN ;Entry point
 D ^DGRPV
 D EASECRP5
 S X="^3"
 S:$$PAUSE(0) X="^"
 K DGRP,DGRPCM,DGRPLAST,DGRPNA,DGRPS,DGRPSCE1,DGRPTYPE,DGRPU,DGRPV,DGRPVV,DGRPW,DGRPX,Z1
 G EN1^EASECSCR
 Q
PAUSE(RESP) ; Prompt user for next page or quit
 N DIR,DIRUT,DUOUT,DTOUT,I,X,Y
 F I=$Y:1:20 W !
 S DIR(0)="E"
 D ^DIR
 I 'Y S RESP=1
 Q RESP
 ;
EASECRP5 ; Display the screen
 ; Note: This section was copied from ^DGRP5 and modified specifically
 ;       to work with LTC.
 ;
 S DGRPW=1,(DGRPS,DGMTSCI)=2 D HD^EASECSCU S Z=1 D WW W " Covered by Health Insurance: " S Z=$S($D(^DPT(DFN,.31)):$P(^(.31),"^",11),1:""),Z=$S(Z="Y":"YES",Z="N":"NO",Z="U":"UNKNOWN",1:"NOT ANSWERED"),Z1=15 D WW1^DGRPV
 W ! D DISP^DGIBDSP
 W ! S DGRPX=$G(^DPT(DFN,.38)),Z=2 D WW W " Eligible for MEDICAID: ",$S(+DGRPX:"YES",$P(DGRPX,"^",1)=0:"NO",1:DGRPU)
 S Y=$P(DGRPX,"^",2) I Y X ^DD("DD") W "   [last updated ",Y,"]"
 ;; *** Added for Medicaid information
 W ! S Z=3 D WW W " Medicaid Number: ",$P(DGRPX,U,3) ;previous $S($P(DGRPX,U,3)>0:$P(DGRPX,U,3),1:"")
 Q
IN Q  ; 
 ;
WW ;Write number on screens for display and/or edit (Z=number)
 ; NOTE: This section was copied from WW^DGRPV and modified specifically
 ;       for LTC.  The code calling ^DGRPV has been redirected here.
 W:DGRPW !
 Q
