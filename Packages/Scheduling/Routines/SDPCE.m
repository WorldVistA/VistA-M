SDPCE ;MJK/ALB - Process PCE Event Data ;31 MAY 2005
 ;;5.3;Scheduling;**27,91,132,150,244,325,441**;Aug 13, 1993;Build 14
 ;
 ; **** See SDPCE0 for variable definitions ****
 ;
EN ; -- main entry pt for PCE event processing
 ;
 ; -- start rt monitor
 D:$D(XRTL) T0^%ZOSV
 ;
 N SDVSIT,SDVSIT0,SDEVENT,SDERR,SDCLST,SDCS,SDPCNT,SDVDT,SDELAP
 S SDVSIT0=0,SDEVENT="SDEVENT"
 ; -- process each visit (initially will only be 1)
 F  S SDVSIT0=$O(^TMP("PXKCO",$J,SDVSIT0)) Q:'SDVSIT0  D
 . I $$HISTORIC^VSIT(SDVSIT0) Q
 . S SDVSIT("AFTER")=$G(^TMP("PXKCO",$J,SDVSIT0,"VST",SDVSIT0,0,"AFTER")),SDVSIT("BEFORE")=$G(^("BEFORE"))
 .;
 .; -- new or old visit 
 . IF SDVSIT("AFTER")]"",SDVSIT("BEFORE")]""!(SDVSIT("BEFORE")="") D ADD(.SDVSIT0,.SDEVENT,.SDERR) Q
 .;
 .; -- deleted visit
 . IF SDVSIT("AFTER")="",SDVSIT("BEFORE")]"" D DEL(.SDVSIT0,.SDEVENT,.SDERR) Q
 ;
 ; -- stop rt monitor
 IF $D(XRT0) S XRTN=$T(+0) D T1^%ZOSV
 ;
 Q
 ;
ADD(SDVSIT0,SDEVENT,SDERR) ; -- add/update encounter data
 N DFN,SDT,SDCL,SDRESULT,SDTYPE,SDOE,SDDIS,SDPVSIT,SDELAP
 ; -- get patient/encounter data
 D PAT(SDVSIT("AFTER"),.DFN,.SDT,.SDCL)
 S SDVSIT=$S($P(SDVSIT("AFTER"),U,12):$P(SDVSIT("AFTER"),U,12),1:SDVSIT0)
 ; --  get encounter data
 S SDOE=$O(^SCE("AVSIT",+SDVSIT,0)),SDDIS=$P($G(^SCE(+SDOE,0)),U,8)
 I 'SDDIS,$G(SDOEP) S SDDIS=$P($G(^SCE(+SDOEP,0)),U,8)
 ;
 ; -- get elig for visit
 S @SDEVENT@("ELIGIBILITY")=$S($P(SDVSIT("AFTER"),U,21):$P(SDVSIT("AFTER"),U,21),1:"")
 ;
 ; -- get appt type
 S SDELAP=$G(^TMP("PXKCO",$J,SDVSIT0,"VST",SDVSIT0,"ELAP","AFTER"))
 S @SDEVENT@("APPT TYPE")=$S($P(SDELAP,U,3):$P(SDELAP,U,3),1:"")
 ;
 ; -- get co d/t
 S @SDEVENT@("DATE/TIME")=$S($P(SDVSIT("AFTER"),U,18):$P(SDVSIT("AFTER"),U,18),1:"")
 ;
 ; -- determine the type of event
 IF SDCL,SDCL=+$G(^DPT(DFN,"S",SDT,0)) D
 . S @SDEVENT@("EVENT")="CHECK-OUT"
 ;
 ELSE  I SDDIS,SDDIS=3 D
 . S @SDEVENT@("EVENT")="DISPOSITION"
 ;
 ELSE  D  Q:$$DELAE()
 . S @SDEVENT@("EVENT")="ADD/EDIT CHECK-OUT"
 . I SDVSIT S SDPVSIT=SDVSIT D ENCEVENT^PXKENC(SDPVSIT)
 ;
 ; -- get user
 S @SDEVENT@("USER")=$S($D(^VA(200,+$G(DUZ),0)):+DUZ,1:.5)
 D CLASS(.SDVSIT,.SDEVENT)
 S @SDEVENT@("VISIT CHANGE FLAGS")=$$CHANGE(.SDVSIT0)
 I $G(SDPVSIT),'$D(@SDEVENT@("CLASSIFICATION")) D CLASSAE(SDPVSIT,.SDEVENT)
 ; -- call api
 D API(DFN,SDT,SDCL,.SDEVENT,.SDERR,SDVSIT,"ADDITION")
 K ^TMP("PXKENC",$J)
 Q
 ;
DEL(SDVSIT0,SDEVENT,SDERR) ; -- delete co info when visit delete
 N DFN,SDT,SDCL
 S SDVSIT=$S($P(SDVSIT("AFTER"),U,12):$P(SDVSIT("AFTER"),U,12),1:SDVSIT0)
 D PAT(SDVSIT("BEFORE"),.DFN,.SDT,.SDCL)
 S @SDEVENT@("USER")=$S($P(SDVSIT("BEFORE"),U,23):$P(SDVSIT("BEFORE"),U,23),1:.5)
 S @SDEVENT@("EVENT")="CHECK-OUT DELETE"
 D API(DFN,SDT,SDCL,.SDEVENT,.SDERR,SDVSIT,"DELETION")
 Q
 ;
DELAE() ; -- delete standalone encounter if no cpt, dx and providers
 N SDDEL
 S SDDEL=0
 IF '$D(^TMP("PXKENC",$J,SDVSIT,"CPT")),'$D(^("POV")),'$D(^("PRV")) D
  . S @SDEVENT@("USER")=$S($P(SDVSIT("BEFORE"),U,23):$P(SDVSIT("BEFORE"),U,23),1:.5)
  . S @SDEVENT@("EVENT")="CHECK-OUT DELETE"
  . D API(DFN,SDT,SDCL,.SDEVENT,.SDERR,SDVSIT,"DELETION")
  . K ^TMP("PXKENC",$J)
  . S SDDEL=1
 Q SDDEL
 ;
API(DFN,SDT,SDCL,SDEVENT,SDERR,SDVSIT,SDACT) ;
 N SDRET,SDSOR
 S SDRET=$$EN^SDAPI(DFN,SDT,SDCL,.SDEVENT,.SDERR,SDVSIT)
 ;
 ; -- is it ok to send bulletin if needed
 S SDSOR=+$O(^TMP("PXKCO",$J,SDVSIT,"SOR",0))
 IF SDSOR,'$P($G(^TMP("PXKCO",$J,SDVSIT,"SOR",SDSOR,0,"AFTER")),U,9) D
 . Q
 ELSE  D
 . D BULL^SDPCE2(DFN,SDT,SDCL,.SDEVENT,.SDERR,SDVSIT,SDACT)
 Q
 ;
PAT(SDVSIT0,DFN,SDT,SDCL) ; -- return patient/encounter data for visit
 S DFN=+$P(SDVSIT0,U,5),SDT=+SDVSIT0,SDCL=+$P(SDVSIT0,U,22)
 Q
 ;
CLASS(SDVSIT,SDEVENT) ; -- set-up classification data from visit data
 N SD800A,SD800B,SDI,CLASS,SDA,SDB
 S SD800A=$G(^TMP("PXKCO",$J,SDVSIT,"VST",SDVSIT,800,"AFTER")),SD800B=$G(^("BEFORE"))
 ; -- process each piece
 F SDI=1:1:8 D
 . S CLASS=$P("SC^AO^IR^EC^MST^HNC^CV^SHAD",U,SDI),SDA=$P(SD800A,U,SDI),SDB=$P(SD800B,U,SDI)
 .; -- changed or same class data
 . IF SDA]"",SDB]"" S @SDEVENT@("CLASSIFICATION",$S(SDA'=SDB:"CHANGE",1:"ADD"),CLASS)=$$CLASSVAL(SDA) Q
 .; -- new class data
 . IF SDA]"",SDB="" S @SDEVENT@("CLASSIFICATION","ADD",CLASS)=$$CLASSVAL(SDA) Q
 .; -- deleted class data
 . IF SDA="",SDB]"" S @SDEVENT@("CLASSIFICATION","DELETE",CLASS)="" Q
 Q
CLASSVAL(Y) ; -- yes/no processing
 Q $S(Y=1:"Y",Y=0:"N",1:"??")
 ;
CLASSAE(SDVSIT,SDEVENT) ; -- set-up classification data from visit data
 N SD800A,SD800B,SDI,CLASS,SDA,SDB
 S SD800A=$G(^TMP("PXKENC",$J,SDVSIT,"VST",SDVSIT,800,"AFTER")),SD800B=$G(^("BEFORE"))
 ; -- process each piece
 F SDI=1:1:8 D
 . S CLASS=$P("SC^AO^IR^EC^MST^HNC^CV^SHAD",U,SDI),SDA=$P(SD800A,U,SDI),SDB=$P(SD800B,U,SDI)
 .; -- changed or same class data
 . IF SDA]"",SDB]"" S @SDEVENT@("CLASSIFICATION",$S(SDA'=SDB:"CHANGE",1:"ADD"),CLASS)=$$CLASSVAL(SDA) Q
 .; -- new class data
 . IF SDA]"",SDB="" S @SDEVENT@("CLASSIFICATION","ADD",CLASS)=$$CLASSVAL(SDA) Q
 .; -- deleted class data
 . IF SDA="",SDB]"" S @SDEVENT@("CLASSIFICATION","DELETE",CLASS)="" Q
 Q
 ;
ELAP(DFN,SC) ; -- This function will return Elig and Appt Type data
 ;  INPUT: DFN - Patient, SC - Clinic IEN
 ; OUTPUT: Elig ptr^ Elig text^ Appt Ptr^ Appt Text
 ;
 N VAEL,VADM,X,Y,SDAPTYP,SDATD,SDEMP,SDDECOD,SDEC,SDAMBAE
 S SDAMBAE=1
 ;-- get appt type
 D TYPE^SDM4
 S SDEMP=""
 ;-- get elig if more than 1
 I $O(VAEL(1,0))>0 S SDEMP="" D ELIG^SDM4:"369"[SDAPTYP S SDEMP=$S(SDDECOD:SDDECOD,1:SDEMP)
 I 'SDEMP S SDEMP=VAEL(1)
 ;
 Q +SDEMP_U_$P($G(^DIC(8,+SDEMP,0)),U)_U_+SDAPTYP_U_$P($G(^SD(409.1,+SDAPTYP,0)),U)
 ;
NEW(DATE) ;-- This function will return 1 if SD is turned on for
 ;   Visit Tracking and optionally check if the date is past
 ;   the cut over date for the new PCE interface.
 ; INPUT : DATE (Optional) Date to check for cut over.
 ; OUTPUT: 1 Yes, 0 No
 N SDRES,SDX,SDY
 I '$G(DATE) S DATE=DT
 ;-- is Scheduling on ?
 S SDRES=0,SDY=$$PKGON^VSIT("SD")
 ;-- if date is it pass cut over?
 S SDX=1 I $G(DATE) S SDX=$$SWITCHCK^PXAPI(DATE)
 ;-- And together
 I SDX,SDY S SDRES=1
 Q SDRES
 ;
STATUS(SDVSIT) ; Return status of an encounter
 ;  Input:  SDOE = Visit File IEN
 ; Output:  Status of the encounter Internal IEN^External Value
 ;
 N SDINT,SDEXT,SDOE
 S SDOE=$O(^SCE("AVSIT",+SDVSIT,0))
 S SDINT=$P($G(^SCE(+SDOE,0)),U,12)
 S SDEXT=$P($G(^SD(409.63,+SDINT,0)),U)
STATQ Q SDINT_"^"_SDEXT
 ;
CHANGE(SDVST) ; -- set flags for overall visit change
 N SDI,SDFLAGS
 ;
 ; -- initalize chnage flags
 ; -- cpt changed ^ provider data changed ^ dx changed
 S SDFLAGS="0^0^0"
 ;
 ; -- set cpt change flag
 S SDI=0
 F  S SDI=$O(^TMP("PXKCO",$J,SDVST,"CPT",SDI)) Q:'SDI  IF $G(^TMP("PXKCO",$J,SDVST,"CPT",SDI,0,"BEFORE"))'=$G(^("AFTER")) S $P(SDFLAGS,U,1)=1
 ;
 ; -- set provider change flag
 S SDI=0
 F  S SDI=$O(^TMP("PXKCO",$J,SDVST,"PRV",SDI)) Q:'SDI  IF $G(^TMP("PXKCO",$J,SDVST,"PRV",SDI,0,"BEFORE"))'=$G(^("AFTER")) S $P(SDFLAGS,U,2)=1
 ;
 ; -- set dx change flag
 S SDI=0
 F  S SDI=$O(^TMP("PXKCO",$J,SDVST,"POV",SDI)) Q:'SDI  IF $G(^TMP("PXKCO",$J,SDVST,"POV",SDI,0,"BEFORE"))'=$G(^("AFTER")) S $P(SDFLAGS,U,3)=1
 ;
 Q SDFLAGS
 ;
