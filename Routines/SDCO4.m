SDCO4 ;ALB/RMO - Diagnosis - Check Out;08 DEC 1992 4:05 pm
 ;;5.3;Scheduling;**32,27,44,67,77,85,132,466**;08/13/93;Build 2
 ;
EN ;Entry point for SDCO DIAGNOSIS protocol
 ; Input  -- SDOE
 ;
 S VALMBCK=""
 ;
 ; -- if OLD encounter, quit
 IF '$$EDITOK^SDCO3($G(SDOE),1) G ENQ
 ;
 ; -- call PCE interview
 N SDVISIT,SDHL
 S SDVISIT=$P($G(^SCE(+SDOE,0)),U,5)
 S X=$$INTV^PXAPI("POV","SD","PIMS",SDVISIT)
 D BLD^SDCO S VALMBCK="R"
ENQ Q
 ;
DXASK(SDOE) ;Ask Diagnosis on Check Out
 ; Input  -- SDOE      Outpatient Encounter IEN
 ; Output --  0=No, 1=Yes/Required, 2=Yes/Not Required
 N SDCL,SDOE0,SDORG,Y
 S SDOE0=$G(^SCE(+SDOE,0)),SDCL=+$P(SDOE0,"^",4),SDORG=+$P(SDOE0,"^",8)
 I $$REQ^SDM1A(+SDOE0)'="CO" G DXASKQ
 I $$OCASN(SDOE) G DXASKQ
 I SDORG=1,'$$CLINIC^SDAMU(SDCL) G DXASKQ
 ;I "^1^2^"[("^"_SDORG_"^"),$$INP^SDAM2(+$P(SDOE0,"^",2),+SDOE0)="I" G DXASKQ  ;SD*5.3*466 allow diagnosis check for inpatients
 I +SDOE0<2961001 S Y=2 G DXASKQ
 I SDCL S Y=1 G DXASKQ
 I SDORG=3 S Y=1
DXASKQ Q +$G(Y)
 ;
OCASN(SDOE) ;determines if this is an occasion of service.
 ;  returns a 1 if and occasion 0 if not
 ;
 N ANS
 S ANS=$$CHKOCC^SCMSVDG1(SDOE)
 Q +$G(ANS)
 ;
SET(SDOE) ;Set-up Diagnosis Array for Outpatient Encounter
 ; Input  -- SDOE      Outpatient Encounter IEN
 ; Output -- SDDXY     Diagnosis Array Subscripted by a Number
 ;           SDCNT     Number of Array Entries
 N SDICD9,SDVPOV,SDDXS
 K SDDXY
 D GETDX^SDOE(SDOE,"SDDXS")
 S (SDCNT,SDVPOV)=0
 F  S SDVPOV=$O(SDDXS(SDVPOV)) Q:'SDVPOV  D
 . S SDICD9=+$G(SDDXS(SDVPOV))
 . S SDCNT=SDCNT+1
 . S SDDXY(SDCNT)=SDVPOV_"^"_SDICD9
SETQ Q
 ;
LIST(SDDXY) ;List Diagnosis Array
 ; Input  -- SDDXY     Diagnosis Array Subscripted by a Number
 ; Output -- List Diagnosis Array
 N I,SDDXD
 W !
 S I=0 F  S I=$O(SDDXY(I)) Q:'I  S SDDXD=$$DX^SDCO41(+$P(SDDXY(I),"^",2)) W !?2,I,"  ",$P(SDDXD,"^"),?15,$P(SDDXD,"^",2)
 Q
 ;
