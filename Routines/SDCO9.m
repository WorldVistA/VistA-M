SDCO9 ;ALB/MTC - Procedure - Check Out;30 APR 1996 1:10 pm
 ;;5.3;Scheduling;**27,132**;08/13/93
 ;
EN ;Entry point for SDCO CPT protocol
 ; Input  -- SDOE
 N I,SDCLI,SDCLOEY,SDCOMF,SDCOQUIT,SDCTI,SDI,SDLINE,SDSEL,SDSELY,SDAPTYP,SDHL
 S VALMBCK=""
 ;
 ;-- is this an old encounter, if so quit
 IF '$$EDITOK^SDCO3($G(SDOE),1) G ENQ
 ;
 N SDVISIT
 S SDVISIT=$P($G(^SCE(+SDOE,0)),U,5)
 S X=$$INTV^PXAPI("CPT","SD","PIMS",SDVISIT)
 D BLD^SDCO S VALMBCK="R"
ENQ ;
 Q
