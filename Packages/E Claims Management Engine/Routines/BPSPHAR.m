BPSPHAR ;BHAM ISC/BEE - ECME MGR PHAR OPTION ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is called by the BPS SETUP PHARMACY menu option. It updates
 ; several fields in the BPS PHARMACIES file.
 ;
 Q
 ;
EN ; Main Entry Point
 N D0,DA,DI,DIC,DLAYGO,DIE,DIRUT,DQ,DR,DTOUT,DUOUT,X,Y
 ;
 ; First select the pharmacy or enter a new one
 W !! S DIC(0)="QEALM",(DLAYGO,DIC)=9002313.56,DIC("A")="Select BPS PHARMACIES NAME: "
 D ^DIC
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(Y)=-1) Q
 ;
 ;Pull internal entry
 S DA=$P($G(Y),U) Q:'$G(Y)
 ;
 ; If new BPS Pharmacy, default the CMOP Switch and Auto-Reversal Parameter
 I $P(Y,U,3)=1 D
 . N DIE,DR,DTOUT
 . S DIE=9002313.56,DR="1////0;.09////0"
 . D ^DIE
 ;
 ; Display the BPS Pharmacy name, NCPDP #, and NPI
 W !!,"NAME: ",$P($G(^BPS(9002313.56,DA,0)),U,1)
 W !,"STATUS: ",$$GET1^DIQ(9002313.56,DA,.1,"E")
 W !,"NCPDP #: ",$P($G(^BPS(9002313.56,DA,0)),U,2)
 W !,"NPI: ",$P($G(^BPS(9002313.56,DA,"NPI")),U,1)
 ;
 ; Now edit OUTPATIENT SITE, CMOP SWITCH, AUTO-REVERSE PARAMETER, 
 ;   and the DEFAULT DEA #
 S DIE=9002313.56
 S DR="13800;1;.09;.03"
 S DR(2,9002313.5601)=".01"
 D ^DIE
 ;
 Q
