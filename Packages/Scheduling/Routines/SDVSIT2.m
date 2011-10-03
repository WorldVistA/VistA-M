SDVSIT2 ;ALB/RMO/MJK - Encounter Utilities;28 DEC 1992 10:00 am
 ;;5.3;Scheduling;**27,44,132**;08/13/93
 ;; ;
 ;
GETAPT(DFN,SDT,SDCL,SDVIEN) ;Look-up Outpatient Encounter IEN for Appt
 ; Input  -- DFN      Patient file IEN
 ;           SDT      Appointment Date/Time
 ;           SDCL     Hospital Location file IEN for Appt
 ;           SDVIEN   Visit file pointer [optional]
 ; Output -- Outpatient Encounter file IEN
 N Y
 S Y=+$P($G(^DPT(DFN,"S",SDT,0)),"^",20)
 I 'Y D APPT^SDVSIT(DFN,SDT,SDCL,$G(SDVIEN)) S Y=+$P($G(^DPT(DFN,"S",SDT,0)),"^",20)
 IF Y D VIEN(Y,$G(SDVIEN))
 Q +$G(Y)
 ;
GETAE(SDVIEN,SDATYPE,SDOPE) ;Look-up Outpatient Encounter IEN for add/edit
 ; Input  -- SDVIEN   Visit file pointer
 ;           SDATYPE  Appointment Type     [optional]
 ;           SDOEP    Parent encounter ien [optional]
 ;           
 ; Output -- Outpatient Encounter file IEN
 N Y
 S Y=+$O(^SCE("AVSIT",SDVIEN,0))
 I 'Y D AEUPD^SDVSIT(SDVIEN,$G(SDATYPE),$G(SDOPE)) S Y=+$O(^SCE("AVSIT",SDVIEN,0))
 IF Y D VIEN(Y,SDVIEN)
 Q +$G(Y)
 ;
GETDISP(DFN,SDT,SDVIEN) ;Look-up Outpatient Encounter IEN for disposition
 ; Input  -- DFN      Patient file IEN
 ;           SDT      Disposition Date/Time
 ;           SDVIEN   Visit file pointer [optional]
 ; Output -- Outpatient Encounter file IEN
 N Y
 S Y=+$P($G(^DPT(DFN,"DIS",9999999-SDT,0)),"^",18)
 I 'Y D DISP^SDVSIT(DFN,SDT,$G(SDVIEN)) S Y=+$P($G(^DPT(DFN,"DIS",9999999-SDT,0)),"^",18)
 IF Y D VIEN(Y,$G(SDVIEN))
 Q +$G(Y)
 ;
OKAE(SDOE) ; -- is add/edit ok for credit
 N Y,X S Y=1
 S X=$G(^SCE(SDOE,0))
 I $$REQ^SDM1A(+X)="CO",'$P(X,U,7) S Y=0
 Q Y
 ;
VIEN(SDOE,SDVIEN) ; -- stuff in Visit IEN if not already set
 ;                 -- needed for those sites that don't have
 ;                    scheduling turned on in Visit Tracking
 ; Required input   SDOE = Outpatient Encounter pointer
 ;                SDVIEN = Visit file pointer or null or zero
 ;
 ; -- quit if no vien passed
 G VIENQ:'SDVIEN
 N Y,SDOE0
 S SDOE0=$G(^SCE(+SDOE,0))
 ; -- quit is no encounter
 G VIENQ:SDOE0=""
 ; -- set visit ien if vien not already set
 IF '$P(SDOE0,U,5) D
 . N DIE,DA,DR
 . S DIE="^SCE(",DA=SDOE,DR=".05////"_SDVIEN D ^DIE
 IF '$P(SDOE0,U,4) D
 . N DIE,DA,DR,SDLOC
 . S SDLOC=$P($G(^AUPNVSIT(SDVIEN,0)),U,22)
 . IF SDLOC S DIE="^SCE(",DA=SDOE,DR=".04////"_SDLOC D ^DIE
VIENQ Q
 ;
