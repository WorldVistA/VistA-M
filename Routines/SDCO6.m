SDCO6 ;ALB/RMO - Interview - Check Out;04 MAR 1993 10:00 am
 ;;5.3;Scheduling;**27,66,132**;08/13/93
 ;
EN ;Entry point for SDCO INTERVIEW protocol
 ; Input  -- SDOE
 S VALMBCK=""
 ;
 ; -- ok to edit?
 IF '$$EDITOK^SDCO3($G(SDOE),1) G INQ
 ;
 N SDCOQUIT
 D FULL^VALM1
 D INT(SDOE,.SDCOQUIT),PAUSE^VALM1:'$D(SDCOQUIT)
 I '$G(SCENFLG) D BLD^SDCO S SDCOXQB=1,VALMBCK="R"
INQ Q
 ;
INT(SDOE,SDCOQUIT) ;Inverview for Check Out
 ; Input  -- SDOE      Outpatient Encounter IEN
 ; Output -- SDCOQUIT  User entered '^' or timeout
 ;
 ; -- exit if child
 I $P($G(^SCE(+SDOE,0)),"^",6) G INTQ
 ;
 N SDAPTYP
 S X=$$INTV^PXAPI("INTV","SD","PIMS",$P($G(^SCE(+SDOE,0)),U,5),$P($G(^SCE(+SDOE,0)),U,4),$P($G(^SCE(+SDOE,0)),U,2))
 S:X<0 SDCOQUIT=""
 ;
INTQ Q
 ;
ASK(SDPMTDF) ;Ask if user wishes to see the check out screen
 ; Input  -- SDPMTDF   Prompt Default 1=Yes and 0=No  [Optional]
 ; Output -- Ask if user wishes to see check out screen
 N DIR,DIRUT,DTOUT,DUOUT,Y
 S DIR("A")="Do you wish to see the check out screen"
 S DIR("B")=$S($G(SDPMTDF):"YES",1:"NO"),DIR(0)="Y" W ! D ^DIR
 Q +$G(Y)
