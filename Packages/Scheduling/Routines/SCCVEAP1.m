SCCVEAP1 ;ALB/RMO,TMP - Appointment Conversion cont.; [ 04/05/95  10:19 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
CON(SCCVEVT,DFN,SCDTM) ; Should conversion event be processed for appointment
 ; Input  -- SCCVEVT  Conversion event
 ;           DFN      Patient IEN
 ;           SCDTM    Appointment date/time
 ;
 ; Output -- 1=Yes and 0=No
 ;
 N SCECSTAT,Y,SCOE,SCAPT0
 S SCAPT0=$G(^DPT(DFN,"S",SCDTM,0))
 S SCOE=+$P(SCAPT0,U,20)
 S SCECSTAT=$P(SCAPT0,U,23)
 ;
 S Y=1
 IF Y,$P(SCDTM,".")>SCCVACRP S Y=0 ; Greater than ACRP date
 IF SCCVEVT=1,SCECSTAT S Y=0       ; Convert/already converted
 IF Y,SCCVEVT=2,'SCECSTAT S Y=0    ; Re-convert/never converted
 IF Y,'SCCVEVT,SCECSTAT S Y=0      ; Estimate/already converted
 ;
 ; -- if check out required then must have a co completion date/time
 IF Y,$$REQ^SDM1A(SCDTM)="CO",'$P($G(^SCE(SCOE,0)),U,7) S Y=0
 ;
 ; -- following is commented out ; left for reference purposes
 ; -- if no enc and no ^sc appt node (purged) then don't convert
 ;IF Y,'SCOE,'$$FIND^SDAM2(DFN,SCDTM,+SCAPT0) S Y=0
 Q +$G(Y)
 ;
EN(SCCVEVT,DFN,SCDTM,SCCLN,SCDA,SCLOG) ; Entry point to convert an appointment
 ; Input  -- SCCVEVT  Conversion event
 ;                    0=Estimate   1=Convert   2=Re-convert
 ;           DFN      Patient IEN
 ;           SCDTM    Appointment date/time
 ;           SCCLN    Clinic IEN
 ;           SCDA     Clinic appt patient sub-file IEN [optional]
 ;           SCLOG    Scheduling conversion log IEN    [optional]
 ;
 N SCCV,SCOE,SCCONS,SCEST
 ;
 S SCCONS("SRCE")="SD TO PCE DB CONV"
 S SCCONS("PKG")=$O(^DIC(9.4,"C","SD",0))
 ;
 ; Check if appointment should be processed
 IF '$$CON(SCCVEVT,DFN,SCDTM) G ENQ
 ;
 ; Set-up conversion array and variables
 D SET^SCCVEAP3(SCCVEVT,+$G(SCLOG),DFN,SCDTM,SCCLN,.SCDA,.SCOE,.SCCV)
 ;
 I 'SCCVEVT,$G(SCCV("ERR")) G ENQ ; if error found - ignore for estimate
 ;
 ; Don't process no new enctr or visit needed & no error to log
 I '$G(SCCV("NEW")),'$D(SCCV("ERR")) G ENQ
 ;
 ; -- saved for reference
 ; I $S('SCCVEVT:'$G(SCCV("NEW")),'$G(SCCV("NEW")):'$D(SCCV("ERR")),1:0) G ENQ
 ;
 ; Increment number of appointments found (estimating only)
 I 'SCCVEVT D
 . D INCRTOT^SCCVEGU1(.SCTOT,3,1)
 . D EN^SCCVZZ("APPT-3",SCOE,SCDTM,$P($G(SCCV("PT",0)),U),+$P($G(SCCV("OE",0)),U,6))
 ;
 ; Log error if there is no encounter or visit/exit if no encounter
 I SCCVEVT,$S('$G(SCOE):1,1:'$P($G(SCCV("OE",0)),U,5)) D  G:'$G(SCOE) ENQ
 . N SCE,SCERRIP,Y
 . S SCERRIP(1)=$P($G(^DPT(DFN,0)),U)
 . S Y=SCDTM D D^DIQ S SCERRIP(2)=Y
 . S SCERRIP(3)=$P($G(^SC(SCCLN,0)),U)
 . S SCERRIP(4)=$S('$G(SCOE):"Outpatient encounter",1:"Visit")
 . S SCERRIP(5)=$$OTHERR^SCCVU2($G(SCCV("ERR")))
 . S SCE("DFN")=DFN,SCE("ENC")=$G(SCOE),SCE("VSIT")="",SCE("DATE")=SCDTM
 . D GETERR^SCCVLOG1(4049005.002,.SCE,.SCERRIP,$G(SCLOG),0,.SCERRMSG)
 . S SCTOT(2.06)=$G(SCTOT(2.06))+1
 . S:$G(SCOE) ^XTMP("SCCV-ERR-"_+$G(SCLOG),"NO-VIS",SCOE)=""
 ;
 G:$G(SCCV("ERR")) ENQ
 ;
 ; Create stop codes, visit for ancillary tests
 D ANC^SCCVEAP2($G(SCOE),DFN,SCDTM,SCCLN,.SCCV,$G(SCLOG))
 ;
 ; Convert children 
 D CHLD^SCCVEAP2(SCOE,.SCCV,$G(SCLOG))
 ;
 ; Invoke DATA-TO-PCE call, store any errors
 I $S('SCCVEVT:1,1:$P($G(^SCE(SCOE,0)),U,5)) D DATA2PCE^SCCVPCE(SCOE,.SCCONS,SCCVEVT,$G(SCOEP),"","",.SCEST)
 ;
 I 'SCCVEVT D  G ENQ ;Estimate exits here
 .F Z=1:1:3 I $P(SCEST,U,Z) D INCRTOT^SCCVEGU1(.SCTOT,Z+8,$P(SCEST,U,Z)) D EN^SCCVZZ("APPT-"_(Z+8),SCOE,SCDTM,$P($G(SCCV("PT",0)),U),+$P($G(SCCV("OE",0)),U,6),$P(SCEST,U,Z))
 ;
 ; Convert additional appt data
 D ENC(SCOE,.SCCV)
 ;
 ; Update appointment as converted
 D DONE(DFN,SCDTM,1)
 ;
 ; Update last entry and number of records
 I $G(SCLOG) D UPDREC^SCCVLOG(SCLOG,SCOE,"CST")
 I '$G(SCLOG) S SCTOT("OK")=1
 ;
ENQ Q
 ;
ENC(SCOE,SCCV) ; Update additional appt data for encounter
 ; Input  -- SCOE     Outpatient encounter IEN
 ;           SCCV     Conversion array
 ; Output -- None
 N SCDATA,SCOEC
 I $G(SCCV("VST")),'$P(^SCE(SCOE,0),U,5) S SCDATA(.05)=SCCV("VST")
 S:$G(SCCV("NEW"))=1 SCDATA(901)=1 ; Created by conversion
 ;
 I $G(SCCV("HIST")) D  ; Stop code created historically
 . I '$P($G(^SCE(SCOE,"CNV")),U,3),$P($G(^(0)),U,3) S SCDATA(903)=1
 . Q:'$O(^SCE("APAR",SCOE,0))
 . S SCOEC=0 F  S SCOEC=$O(^SCE("APAR",SCOE,SCOEC)) Q:'SCOEC  S SCOEC(SCOEC)=""
 ;
 I $P($G(^SCE(SCOE,0)),U,5) D ENCCNV(.SCDATA)
 I $D(SCDATA) D UPD^SCCVDBU(409.68,SCOE,.SCDATA) ;Update parent
 ;
 I $O(SCOEC(0)) D  ; update children of encounter
 . N SCDATC
 . S SCOEC=0
 . F  S SCOEC=$O(SCOEC(SCOEC)) Q:'SCOEC  D
 .. N SCDATC
 .. I '$G(^SCE(SCOEC,"CNV")),$G(SCCV("NEW"))=1 S SCDATC(901)=1
 .. I $P($G(^SCE(SCOEC,0)),U,3),'$P($G(^("CNV")),U,3) S SCDATC(903)=1
 .. I $P($G(^SCE(SCOEC,0)),U,5) D ENCCNV(.SCDATC)
 .. I $D(SCDATC) D UPD^SCCVDBU(409.68,SCOEC,.SCDATC)
 ;
ENCQ Q
 ;
DONE(DFN,SCDTM,SCECSTAT) ; Update appointment encounter conversion status
 ; Input  -- DFN      Patient IEN
 ;           SCDTM    Appointment date/time
 ;           SCECSTAT Encounter conversion status
 ; Output -- None
 N SCDATA,SCIENS
 S SCIENS=SCDTM_","_DFN
 S:'$P($G(^DPT(DFN,"S",SCDTM,0)),U,23) SCDATA(23.1)=SCECSTAT ; encounter conversion status
 I $D(SCDATA) D UPD^SCCVDBU(2.98,SCIENS,.SCDATA)
 Q
 ;
ENCCNV(DATA) ; Set nodes to update 'conversion processed' fields in encounter
 S DATA(904)=1,DATA(905)=+$E($$NOW^XLFDT(),1,12)
 I $G(SCCV("NEW"))=2 S DATA(101)=$G(DUZ),DATA(102)=DATA(905)
 Q
 ;
