SDAPI ;ALB/MJK - Outpatient API ; 22 FEB 1994 11:30 am
 ;;5.3;Scheduling;**27,44,97,132**;08/13/93
 ;
EN(DFN,SDT,SDCL,SDEVENT,SDERR,SDVIEN) ; -- main entry point for api
 N SDROOT,SDMODE,SDRET,SDUZ,SDERROOT
 ;
 ; -- set init vars and do basic checks
 D INIT(DFN,SDT,SDCL,.SDEVENT,.SDROOT,.SDMODE,.SDRET,.SDUZ)
 IF $$ERRCHK^SDAPIER() G ENQ
 ;
 ; -- appointment check out event
 IF @SDROOT@("EVENT")="CHECK-OUT" D  G ENQ
 . N SDOE
 . S SDOE=$$EN^SDAPIAP(DFN,SDT,SDCL,SDUZ,SDMODE,$G(SDVIEN))
 . S SDRET=$$FINAL(SDOE)
 ;
 S SDT1=SDT ;this is to record the actual date for SDVSIT
 ; -- disposition event
 IF @SDROOT@("EVENT")="DISPOSITION" D  G ENQ
 . N SDOE
 . S SDOE=$$EN^SDAPIDP(DFN,SDT,SDCL,SDUZ,SDMODE,$G(SDVIEN))
 . S SDRET=$$FINAL(SDOE)
 ;
 ; -- add/edit check out event ; return list of iens
 IF @SDROOT@("EVENT")="ADD/EDIT CHECK-OUT" D  G ENQ
 . N SDOE
 . S SDOE=$$EN^SDAPIAE0(DFN,SDT,SDCL,SDUZ,SDMODE,+$G(SDVIEN))
 . S SDRET=$$FINAL(SDOE)
 ;
 ; -- delete appointment check out event
 IF @SDROOT@("EVENT")="CHECK-OUT DELETE",$G(SDVIEN) D  G ENQ
 . N SDOE
 . S SDOE=0
 . F SDOE=$O(^SCE("AVSIT",SDVIEN,SDOE)) Q:'SDOE  DO
 ..I $D(^SCE(+SDOE,0)) D EN^SDCODEL(SDOE,SDMODE,,"PCE")
 ..Q
 .Q
 ;
ENQ D HDL
 Q '$$ERRCHK^SDAPIER()_U_SDRET
 ;
INIT(DFN,SDT,SDCL,SDEVENT,SDROOT,SDMODE,SDRET,SDUZ) ; -- initialization of environment
 S SDMODE="",SDRET=""
 ; -- set error root
 S SDERROOT=$S($G(SDERR)]"":SDERR,1:"SDERR")
 ;
 ; -- set event root
 S SDROOT=$S($G(SDEVENT)]"":SDEVENT,1:"SDEVENT")
 ;
 ; -- error if no event data
 I $G(@SDROOT@("EVENT"))="" D ERRFILE^SDAPIER(1)
 ;
 ; -- kill evt drv handle
 D HDL
 ;
 ; -- error if no patient
 I '$D(^DPT(+$G(DFN),0)) D ERRFILE^SDAPIER(2,DFN)
 ;
 ; -- error if no user
 S SDUZ=+$G(@SDROOT@("USER")) I '$D(^VA(200,SDUZ,0)) D ERRFILE^SDAPIER(3,SDUZ)
 ;
 ; -- error if not a clinic
 I @SDROOT@("EVENT")'="DISPOSITION",$P($G(^SC(+$G(SDCL),0)),U,3)'="C" D ERRFILE^SDAPIER(4,SDCL)
 ;
 ; -- error if no encounter date
 I SDT="" D ERRFILE^SDAPIER(5)
 ;
INITQ Q
 ;
FINAL(SDOE) ; -- set up return value
 ; -- return ien and status if c/o attempted
 S SDRET=$S(SDOE:SDOE_U_$P($G(^SD(409.63,+$P($G(^SCE(SDOE,0)),U,12),0)),U),1:"")
 I SDOE,'$$CHK^SDCOM(SDOE) D COMDT^SDCODEL(SDOE,0)
 Q SDRET
 ;
 ;
HOST(PROTOCOL,MESSAGE) ; -- specify info by protocol
 Q
 N SDRESULT
 S SDRESULT=$$EN(DFN,SDT,SDCL,SDUZ,.SDEVENT)
 Q
 ;
HDL ; -- kill evt drv hanndle
 I $G(@SDROOT@("KILL HANDLE")) D HDLKILL^SDAMEVT()
 Q
 ;
