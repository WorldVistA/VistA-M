SDEC25B ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
CO(SDOE,DFN,SDT,SDCL,SDCODT,SDECAPTID,SDQUIET,VPRV,APIERR) ;EP; called to ask check-out date/time   ;SAT ADDED PARAMETERS SDCODT, SDECAPTID, & SDQUIET
 ;  Called by SDCO1
 ; SDOE      = Outpatient Encounter IEN
 ;  DFN      = Patient IEN
 ;  SDT      = Appointment Date/Time
 ; SDCL      = Clinic IEN
 ; SDCODT    = APPOINTMENT CHECKOUT TIME [OPTIONAL - USED WHEN SDQUIET=1] USER ENTERED FORMAT
 ; SDECAPTID = APPOINTMENT ID - POINTER TO ^SDECAPPT
 ; SDQUIET   = ALLOW NO TERMINAL INPUT/OUTPUT 0=ALLOW; 1=DO NOT ALLOW
 ; VPRV      = V Provider IEN - pointer to V PROVIDER file
 ; APIERR    = Returned Array of errors
 ;             APIERR = counter
 ;             APIERR(counter)=message -- <Prog name>: <message>
 ;
 I '$G(SDOE) D ^%ZTER Q  ;lets trap an error here to see what is causing the problem
 N DIE,DA,DR,SDECNOD,SDN,SDV,AUPNVSIT
 S DIE="^SC("_SDCL_",""S"","_SDT_",1,"
 S DA(2)=SDCL,DA(1)=SDT,(DA,SDN)=$$SCIEN^SDECU2(DFN,SDCL,SDT)
 ;S DA(4)=SDCL,DA(3)="S",DA(2)=SDT,DA(1)=1,(DA,SDN)=$$SCIEN^SDECU2(DFN,SDCL,SDT)
 ;CHECK THAT APPOINTMENT IS CHECKED IN
 I $P($G(^SC(+SDCL,"S",SDT,1,SDN,"C")),U)="" D  Q
 . S APIERR=$G(APIERR)+1 S APIERR(APIERR)="SDEC25B: Patient not checked in"
 . Q
 ;
 S DR="303///"_$$FMTE^XLFDT(SDCODT)_";304///`"_DUZ_";306///"_$$NOW^XLFDT
 D ^DIE
 ;
 ; if checked out and status not updated, do it now
 I $P($G(^SC(+SDCL,"S",SDT,1,DA,"C")),U,3)]"" D
 . ;UPDATE APPOINTMENT SCHEDULE GLOBAL ^SDEC(409.84
 . I $G(SDECAPTID) D
 . . S PSTAT=$P(^SCE(SDOE,0),U,12)
 . . S DIE="^SDEC(409.84,"
 . . S DA=SDECAPTID
 . . S DR=".14///"_$G(SDCODT)_";.19///"_PSTAT
 . . D ^DIE
 . . ;possibly update VProvider
 . . S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 . . I $G(VPRV),+$P(SDECNOD,U,15) D
 . . . ;get SDEC appointment schedule
 . . . S DIE="^AUPNVPRV("
 . . . S DA=$P(SDECNOD,U,15)
 . . . S DR=".01///"_VPRV
 . . . D ^DIE
 . ;
 . Q:$$GET1^DIQ(409.68,SDOE,.12)="CHECKED OUT"
 . S DIE=409.68,DA=SDOE,DR=".12///14;101///"_DUZ_";102///"_$$NOW^XLFDT
 . D ^DIE
 . ;
 . ; if visit pointer stored, update visit checkout date/time
 . S SDV=$$GET1^DIQ(409.68,SDOE,.05,"I") Q:'SDV
 . Q:'$D(^AUPNVSIT(SDV,0))  Q:$$GET1^DIQ(9000010,SDV,.05,"I")'=DFN
 . Q:$$GET1^DIQ(9000010,SDV,.11,"I")=1    ;deleted
 . ;
 . ;cmi/maw 5/1/2009 PATCH 1010 RQMT 34
 . S DIE="^AUPNVSIT(",DA=SDV
 . S DR=".18///"_$P($G(^SC(+SDCL,"S",SDT,1,SDN,"C")),U,3)
 . D ^DIE
 Q
 ;
CO1(SDECAPTID,SDCODT,SDOE,VPRV)  ;external checkout called from FILE^SDAPIAP to update SDEC APPOINTMENT from VistA appointment check out
 ;INPUT:
 ; SDECAPTID = Appt ID pointer to SDEC APPOINTMENT file
 ; SDCODT    = Checkout date/time in fm format
 ; SDOE      = outpatient encounter pointer to OUTPATIENT ENCOUNTER file 409.68
 ; VPRV      = V Provider pointer to V PROVIDER file
 N DA,DR,PSTAT,SDEDNOD
 I $G(SDECAPTID) D
  . S PSTAT=$P(^SCE(SDOE,0),U,12)
  . S DIE="^SDEC(409.84,"
  . S DA=SDECAPTID
  . S DR=".14///"_$G(SDCODT)_";.19///"_PSTAT
  . D ^DIE
  . ;possibly update VProvider
  . S SDECNOD=^SDEC(409.84,SDECAPTID,0)
  . I $G(VPRV),+$P(SDECNOD,U,15) D
  . . ;get SDEC appointment schedule
  . . S DIE="^AUPNVPRV("
  . . S DA=$P(SDECNOD,U,15)
  . . S DR=".01///"_VPRV
  . . D ^DIE
 Q
