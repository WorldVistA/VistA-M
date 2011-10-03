SDCOU1 ;ALB/RMO - Utilities Cont. - Check Out;28 DEC 1992 10:00 am
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
EVT(SDOE,SDCAP,SDHDL,SDATA,SDOE0) ;Check Out Event Driver Call
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;           SDCAP    Capture Mode (BEFORE or AFTER)
 ;           SDHDL    Event Handle
 ;           SDATA    Before/After Status Data
 ;           SDOE0    OE 0th node [Only required for check out deletion]
 ; Output -- Event Driver Call
 ;           Only for Appts, Disp Delete, A/E's
 N SDORG
 S SDORG=+$P($G(^SCE(+SDOE,0),$G(SDOE0)),"^",8) G EVTQ:'SDORG
 I SDCAP="BEFORE" S SDHDL=$$HANDLE^SDAMEVT(SDORG)
 I SDORG=1!(SDORG=2)!(SDORG=3) D
 .D OEVT^SDAMEVT(SDOE,SDCAP,SDHDL,.SDATA,$G(SDOE0))
EVTQ Q
