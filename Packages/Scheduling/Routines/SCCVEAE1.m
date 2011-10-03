SCCVEAE1 ;ALB/RMO,TMP - Add/Edit Conversion cont.; [ 04/05/95  8:46 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
CON(SCCVEVT,SCDTM,SCVALDT,SCDA) ;Should conversion event be processed for add/edit
 ; Input  -- SCCVEVT  Conversion event
 ;           SCDTM    Visit date/time
 ;           SCVALDT  Valid converted Visit date/time (SCDTM)
 ;           SCDA     Clinic stop code sub-file IEN
 ; Output -- 1=Yes and 0=No
 ;
 N SC0,SCECSTAT,Y,SCOE,SCSTOP,SCLN,DFN
 S DFN=+$P($G(^SDV(SCDTM,0)),U,2)
 S SC0=$G(^SDV(SCDTM,"CS",SCDA,0))
 S SCSTOP=+SC0
 S SCLN=+$P(SC0,U,3)
 S SCOE=+$P(SC0,U,8)
 S SCECSTAT=$P(SC0,U,9)
 ;
 ; -- do checks
 S Y=1
 IF Y,$P(SCVALDT,".")>SCCVACRP S Y=0 ; Greater than ACRP date
 IF Y,SCCVEVT=1,SCECSTAT S Y=0       ; Convert/already converted
 IF Y,SCCVEVT=2,'SCECSTAT S Y=0      ; Re-convert/never converted
 IF Y,'SCCVEVT,SCECSTAT S Y=0        ; Estimate/already converted
 ;
 ; -- if check out required then must have a co completion date/time
 IF Y,$$REQ^SDM1A(SCDTM)="CO",'$P($G(^SCE(SCOE,0)),U,7) S Y=0
 ;
 ; -- if a/e for 900 stop, same clinic, no enounter
 ;    and lower "CS" ien then current then don't convert
 IF Y,SCCV900=SCSTOP,SCLN D
 . N SCS,SCS0
 . S SCS=0
 . F  S SCS=$O(^SDV(SCDTM,"CS",SCS)) Q:'SCS!(SCS=SCDA)  S SCS0=$G(^(SCS,0)) IF +SCS0=SCCV900,+$P(SCS0,U,3)=SCLN,'$P(SCS0,U,8) S Y=0 Q
 ;
 ; -- if not a 900, did stop get added via appts? if so, don't convert.
 IF Y,SCCV900'=SCSTOP D
 . N SCAP,SCAP0,SCEND
 . S SCAP=$P(SCDTM,"."),SCEND=SCAP+.24
 . F  S SCAP=$O(^DPT(DFN,"S",SCAP)) Q:'SCAP!(SCAP>SCEND)  S SCAP0=$G(^(SCAP,0)) D  Q:'Y
 . . ; -- must be valid made appt
 . . IF $P(SCAP0,U,2)'="",$P(SCAP0,U,2)'="I" Q
 . . ; -- if clinic specified then appt must be for same clinic
 . . IF SCLN,SCLN'=+SCAP0 Q
 . . ; -- if enc exists & c/o, compare enc stop code with sdv stop code
 . . IF $P(SCAP0,U,20) D  Q
 . . . IF $P($G(^SCE($P(SCAP0,U,20),0)),U,3)=SCSTOP,$P($G(^SCE($P(SCAP0,U,20),0)),U,7) S Y=0
 . . ; -- compare clinic's stop code with sdv stop code
 . . IF $P($G(^SC(+SCAP0,0)),U,7)=SCSTOP S Y=0 Q
 ;
 Q +$G(Y)
 ;
EN(SCCVEVT,SCDTM,SCDA,SCOEP,SCLOG) ; Entry point to convert an add/edit
 ; Input  -- SCCVEVT  Conversion event
 ;                    0=Estimate   1=Convert   2=Re-convert
 ;           SCDTM    ien of SDV entry (~Visit date/time)
 ;           SCDA     Clinic stop code sub-file IEN
 ;           SCOEP    Parent outpatient encounter IEN [optional]
 ;           SCLOG    Scheduling conversion log IEN   [optional]
 N SCCV,SCOE,SCDATA,SCCONS,SCEST,Z,SCVALDT
 ;
 ; -- make sure sdv d/t is valid 
 S SCVALDT=$$DATECHCK^SDVSIT(SCDTM)
 ;
 S SCCONS("SRCE")="SD TO PCE DB CONV"
 S SCCONS("PKG")=$O(^DIC(9.4,"C","SD",0))
 ;
 ; Check if add/edit should be processed
 IF '$$CON(SCCVEVT,SCDTM,SCVALDT,SCDA) G ENQ
 ;
 ; Set-up conversion array and variables
 D SET^SCCVEAE3(SCCVEVT,+$G(SCLOG),SCDTM,SCVALDT,SCDA,.SCOEP,.SCOE,.SCCV)
 ;
 I 'SCCVEVT,$G(SCCV("ERR")) G ENQ
 ;
 ; Skip if no new enctr or visit needed & no error to log
 I '$G(SCCV("NEW")),'$D(SCCV("ERR")) G ENQ
 ;
 ; Increment number of add/edits found (estimating only)
 I 'SCCVEVT D EN^SCCVZZ("AE-1",SCOE,SCDTM,SCDA,+$P($G(SCCV("OE",0)),U,6),+$P($G(SCCV("OE",0)),U,2)) D INCRTOT^SCCVEGU1(.SCTOT,1,1)
 ;
 ; Log error if no encounter or no visit, exit if no encounter
 I SCCVEVT,$S('$G(SCOE):1,1:'$P($G(SCCV("OE",0)),U,5)) D  G:'$G(SCOE) ENQ
 . N SCERRIP,Y,SCE
 . S Y=SCDTM D D^DIQ S SCERRIP(1)=Y
 . S SCERRIP(2)=SCDA
 . S SCERRIP(5)=$$OTHERR^SCCVU2($G(SCCV("ERR")))
 . S SCERRIP(4)=$S('$G(SCOE):"Outpatient encounter",1:"Visit")
 . S SCE("DFN")=$P($G(^SDV(SCDTM,0)),U,2),SCE("ENC")=$G(SCOE),SCE("VSIT")="",SCE("DATE")=SCDTM
 . D GETERR^SCCVLOG1(4049005.001,.SCE,.SCERRIP,$G(SCLOG),0,.SCERRMSG)
 . S SCTOT(2.06)=$G(SCTOT(2.06))+1
 . S:$G(SCOE) ^XTMP("SCCV-ERR-"_+$G(SCLOG),"NO-VIS",SCOE)=""
 ;
 G:$G(SCCV("ERR")) ENQ
 ;
 ; Invoke DATA-TO-PCE call, store any errors
 S SCEST=""
 I $S('SCCVEVT:1,1:$P($G(^SCE(SCOE,0)),U,5)) D DATA2PCE^SCCVPCE(SCOE,.SCCONS,SCCVEVT,$S(SCCVEVT:$G(SCOEP),1:$P($G(^SCE(SCOE,0)),U,6)),SCDTM,SCDA,.SCEST)
 ;
 I 'SCCVEVT D  G ENQ ;Estimate exits here
 .F Z=1:1:3 I $P(SCEST,U,Z) D INCRTOT^SCCVEGU1(.SCTOT,Z+8,$P(SCEST,U,Z)) D EN^SCCVZZ("AE-"_(Z+8),SCOE,SCDTM,SCDA,+$G(SCOEP),$P(SCEST,U,Z))
 ;
 ; Convert additional add/edit data
 D ENC(SCOE,.SCCV)
 ;
 ; Update add/edit as converted
 D DONE(SCDTM,SCDA,1)
 ;
 ; Update last entry and number of records
 I $G(SCLOG),'$G(SCOEP) D UPDREC^SCCVLOG(SCLOG,SCOE,"CST")
 I '$G(SCLOG),$G(SCTOT("A/E")) S SCTOT("OK")=1
ENQ Q
 ;
ENC(SCOE,SCCV) ; Convert additional add/edit data for encounter
 ; Input  -- SCOE     Outpatient encounter IEN
 ;           SCCV     Conversion array
 ; Output -- None
 N SCDATA
 I $G(SCCV("VST")),'$P($G(^SCE(SCOE,0)),U,5) S SCDATA(.05)=SCCV("VST") ; visit file entry
 I SCCV("NEW")=1 D  ;Only if conversion adds the encounter
 . I $P($G(SCCV("CS",0)),U,6)'="" S SCDATA(202)=$P(SCCV("CS",0),U,6)
 . I $P($G(SCCV("CS",0)),U,2)'="" S SCDATA(101)=$P(SCCV("CS",0),U,2)
 . I $P($G(SCCV("CS",1)),U)'="" S SCDATA(201)=$P(SCCV("CS",1),U)
 . I $P($G(SCCV("CS",0)),U,7)'="" S SCDATA(902)=$P(SCCV("CS",0),U,7)
 . S SCDATA(901)=1 ; created by conversion
 I $G(SCCV("VST")) D ENCCNV^SCCVEAP1(.SCDATA)
 I $D(SCDATA) D UPD^SCCVDBU(409.68,SCOE,.SCDATA)
ENCQ Q
 ;
DONE(SCDTM,SCDA,SCECSTAT) ; Update add/edit encounter conversion status
 ; Input  -- SCDTM    Visit date/time
 ;           SCDA     Clinic stop code sub-file IEN
 ;           SCECSTAT Encounter conversion status
 ; Output -- None
 N SCDATA,SCIENS
 S SCIENS=SCDA_","_SCDTM
 S:'$P($G(^SDV(SCDTM,"CS",SCDA,0)),U,9) SCDATA(9)=SCECSTAT ; encounter conversion status
 I $D(SCDATA) D UPD^SCCVDBU(409.51,SCIENS,.SCDATA)
 Q
 ;
