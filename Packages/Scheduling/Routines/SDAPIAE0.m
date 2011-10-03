SDAPIAE0 ;ALB/MJK - Outpatient API/Standalone Add/Edits ; 22 FEB 1994 11:30 am
 ;;5.3;Scheduling;**27,78,97,132**;08/13/93
 ;
EN(DFN,SDT,SDCL,SDUZ,SDMODE,SDVIEN) ; -- check api for appts
 N SDOE
 S SDOE=0
 ;
 ; -- verify that check-out can occur
 D CHECK(DFN,SDT,SDCL) I $$ERRCHK^SDAPIER() G ENQ
 ;
 ; -- file check-out data and get back ien
 S SDOE=$$FILE(SDVIEN,SDUZ,SDMODE)
 ;
ENQ Q SDOE
 ;
CHECK(DFN,SDT,SDCL) ; -- check if event can occur/allowed
 ;
 ; -- error if appt date if after today
 I SDT>(DT+.24) D ERRFILE^SDAPIER(104,SDT) G CHECKQ
CHECKQ Q
 ;
FILE(SDVIEN,SDUZ,SDMODE) ; -- file data & return iens
 N SDHDL,SDOE,SDOE0,SDOEP,SDX,DR,DIE,SDDR,DA,SDCOMPF,SDLOG,SDAEVT
 ;
 S SDHDL=$$HANDLE^SDAMEVT(2)
 ;
 ; -- get encounter ien ; error if none returned
 S SDOE=+$O(^SCE("AVSIT",SDVIEN,0))
 ;
 ; -- setup event driver data for existing encounter
 IF SDOE D BEFORE^SDAMEVT2(SDOE,SDHDL)
 ;
 ; -- get encounter / set appt type if not set
 IF 'SDOE D  G:'SDOE FILEQ
 . S SDOE=$$GETAE^SDVSIT2(SDVIEN,$G(@SDROOT@("APPT TYPE")))
 . IF 'SDOE D ERRFILE^SDAPIER(110) Q
 . S SDOE0=$G(^SCE(SDOE,0)),SDAEVT=6       ; -- add a/e event
 . Q:$P(SDOE0,U,10)                        ; -- quit if appt type set
 . S SDLOG("CG")=1                         ; -- set computer generated?
 . S SDX=$$TYPE(SDOE,$P(SDOE0,U,6))        ; -- determine appt type
 . S SDLOG("APPT TYPE")=+SDX               ; -- set appt type
 . S:+SDX=10 SDLOG("REASON")=$P(SDX,U,2)   ; -- set reason
 ;
 ; -- log user, date/time and standalone specific data
 D LOGDATA^SDAPIAP(SDOE,.SDLOG)
 ;
 ; -- process data
 D FILE^SDAPICO(SDOE,SDUZ)
 ;
 ; -- update co if deletion occurred
 IF SDOE,'$$CHK^SDCOM(SDOE) D COMDT^SDCODEL(SDOE,0)
 ;
 ; -- update check-out completion
 D EN^SDCOM(SDOE,SDMODE,SDHDL,.SDCOMPF)
 ;
 ; -- set visit change flag for event driver
 D CHANGE^SDAMEVT4(.SDHDL,$P($G(^SCE(SDOE,0)),U,8),$G(@SDROOT@("VISIT CHANGE FLAGS")))
 ;
 ; -- get after values and invoke event driver
 D EVT^SDAMEVT2(SDOE,$G(SDAEVT,7),SDHDL)
 ;
 ; -- cleanup event driver vars
 D CLEAN^SDAMEVT(SDHDL)
FILEQ Q SDOE
 ;
TYPE(SDOE,SDOEP) ; -- Get Appt Type
 ;     Input:    SDOE  - Outpatient Encounter pointer
 ;               SDOEP - Outpatient Parent Encounter pointer
 ;    Output:  Appointment Type ^ reason for computer generated
 ;
 N SDD,SDD1,SDI,SDCP,SDOE0,SDATE,X1,X2,X,VAERR,VAEL,SDX,SDQ,SDATYPE
 S SDCP=0
 ;
 ;--If SDOEP exists, use its appointment type
 IF $G(SDOEP) S SDATYPE=$P($G(^SCE(SDOEP,0)),U,10) IF SDATYPE G TYPEQ
 ;
 ;--search last 3 days + today in Outpatient Encounter file
 S SDOE0=$G(^SCE(SDOE,0)),SDATE=$P(+SDOE0,".")
 S X1=SDATE,X2="-3" D C^%DTC S SDD1=X,SDD=SDD1-.1 K X,%H,X1,X2
 F  S SDD=$O(^SCE("ADFN",DFN,SDD)) Q:'SDD!($P(SDD,".")>SDATE)!(SDCP)  D
 . S SDI=0
 . F  S SDI=$O(^SCE("ADFN",SDD,SDI)) Q:'SDI!(SDCP)  IF $P($G(^SCE(SDI,0)),U,10)=1 S SDCP=1
 ;
 ;;search last 3 days + today in Patient File
 I 'SDCP S SDD=SDD1-.1 F  S SDD=$O(^DPT(DFN,"S",SDD)) Q:SDD'>0!(SDCP)!($P(SDD,".")>SDATE)  IF $P($G(^(SDD,0)),U,16)=1 S SDCP=1
 ;
 I SDCP S SDATYPE=10 G TYPEQ
 ;
 ;if no comp and pen appts, try to determine based on eligibility
 S SDATYPE=0 D ELIG^VADPT
 I VAERR!'$G(VAEL(1)) S SDATYPE=10 G TYPEQ
 S VAEL(1)=$P(^DIC(8,+VAEL(1),0),U,9)
 S SDFLAG=$S(+VAEL(1)=9:8,+VAEL(1)=13:7,+VAEL(1)=14:4,1:0)
 ; *** rebuild Elig array from VAEL(1,#) using pointers to MAS ELIGIBILITY CODE File,
 ; #8.1,  Check for SHARING AGREEMENT (9), COLLATERAL OF VET. (13) or EMPLOYEE (14)
 ;
 I $D(VAEL(1))=11 D  G:$G(SDQ) TYPEQ
 . N ELG
 . S SDX=0 F  S SDX=$O(VAEL(1,SDX)) Q:'SDX  D
 .. S ELG(+$P($G(^DIC(8,+VAEL(1,SDX),0)),U,9))=""
 . I $D(ELG(9))!($D(ELG(13)))!($D(ELG(14)))!SDFLAG S SDATYPE=10,SDQ=1
 ;
 S SDATYPE=$S($D(VAEL(1))=1&(SDFLAG):SDFLAG,1:9)
 ;
 ; -- Appointment Type ^ reason for computer generated
TYPEQ Q SDATYPE_U_$S(SDCP:2,SDATYPE=10:1,1:"")
 ;
