SDCO3 ;ALB/RMO - Provider - Check Out;08 DEC 1992 4:05 pm
 ;;5.3;Scheduling;**28,27,44,67,71,132,466**;08/13/93;Build 2
 ;
EN ;Entry point for SDCO PROVIDER protocol
 ; Input  -- SDOE
 ;
 S VALMBCK=""
 ;
 ; -- if OLD encounter, quit
 IF '$$EDITOK($G(SDOE),1) G ENQ
 ;
 ; -- call PCE interview
 N SDVISIT,SDHL
 S SDVISIT=$P($G(^SCE(+SDOE,0)),U,5)
 S X=$$INTV^PXAPI("PRV","SD","PIMS",SDVISIT)
 D BLD^SDCO S VALMBCK="R"
ENQ Q
 ;
PRASK(SDOE) ;Ask Provider on Check Out
 ; Input  -- SDOE      Outpatient Encounter IEN
 ; Output -- 0=No, 1=Yes/Required, 2=Yes/Not Required
 N SDCL,SDOE0,SDORG,Y
 S SDOE0=$G(^SCE(+SDOE,0)),SDCL=+$P(SDOE0,"^",4),SDORG=+$P(SDOE0,"^",8)
 I $$REQ^SDM1A(+SDOE0)'="CO" G PRASKQ
 I SDORG=1,'$$CLINIC^SDAMU(SDCL) G PRASKQ
 ;I "^1^2^"[("^"_SDORG_"^"),$$INP^SDAM2(+$P(SDOE0,"^",2),+SDOE0)="I" G PRASKQ  ;SD*5.3*466 allow provider check for inpatients 
 I +SDOE0<2961001 S Y=2 G PRASKQ
 I SDCL S Y=1 G PRASKQ
 I SDORG=3 S Y=1
PRASKQ Q +$G(Y)
 ;
SET(SDOE) ;Set-up Provider Array for Outpatient Encounter
 ; Input  -- SDOE      Outpatient Encounter IEN
 ; Output -- SDPRY     Provider Array Subscripted by a Number
 ;           SDCNT     Number of Array Entries
 N SDVA200,SDVPRV,SDPRVS
 K SDPRY
 D GETPRV^SDOE(SDOE,"SDPRVS")
 S (SDCNT,SDVPRV)=0
 F  S SDVPRV=$O(SDPRVS(SDVPRV)) Q:'SDVPRV  D
 . S SDVA200=+$G(SDPRVS(SDVPRV))
 . S SDCNT=SDCNT+1
 . S SDPRY(SDCNT)=SDVPRV_"^"_SDVA200
SETQ Q
 ;
LIST(SDPRY) ;List Provider Array
 ; Input  -- SDPRY     Provider Array Subscripted by a Number
 ; Output -- List Provider Array
 N I
 W !
 S I=0 F  S I=$O(SDPRY(I)) Q:'I  W !?2,I,"  ",$$PR^SDCO31(+$P(SDPRY(I),"^",2))
 Q
 ;
EDITOK(SDOE,SDMODE) ; -- ok to edit?
 ; input:  SDOE   := ien of 409.68                  [required]
 ;         SDMODE := 1 -- interactive ; 0 -- silent [required]
 ;
 ; returned:  1 -- yes, it's ok to edit or delete SDOE entry
 ;            0 -- no, cannot not change SDOE entry
 ;
 N DIR,SDOK
 S SDOK=$$NEW^SDPCE($P($G(^SCE(+$G(SDOE),0)),U))
 IF 'SDOK,SDMODE D OLDMSG
EDITOKQ Q SDOK
 ;
OLDMSG ; -- display message to user
 W !!,">>> Editing and deleting old encounters not allowed.",!
 N DIR
 S DIR(0)="E"
 S DIR("A")="Press Return key to continue"
 D ^DIR
 Q
 ;
