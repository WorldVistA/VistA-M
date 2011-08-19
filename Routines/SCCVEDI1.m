SCCVEDI1 ;ALB/RMO,TMP - Disposition Conversion cont.; [ 04/05/95  8:12 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
CON(SCCVEVT,DFN,SCDTM,SCCVDIS) ; Should conversion event be processed for disposition
 ; Input  -- SCCVEVT  Conversion event
 ;           DFN      Patient IEN
 ;           SCDTM    Visit date/time
 ;           SCCVDIS  Array of disposition clinics
 ;
 ; Output -- 1=Yes and 0=No
 ;
 N SCECSTAT,Y,SCOE,SCDIS0,SCTYPE,SCDIV
 S SCDIS0=$G(^DPT(DFN,"DIS",9999999-SCDTM,0))
 S SCTYPE=$P(SCDIS0,U,2)
 S SCDIV=+$P(SCDIS0,U,4)
 S SCOE=+$P(SCDIS0,U,18)
 S SCECSTAT=$P(SCDIS0,U,19)
 ;
 ; -- do checks
 S Y=1
 ; -- don't use if date is greater than ACRP date
 IF Y,$P(SCDTM,".")>SCCVACRP S Y=0
 ; -- don't use if application w/o exam
 IF Y,SCTYPE=2 S Y=0
 ; -- don't use if no dispo clinic division & > 1 defined for site
 IF Y,'$G(SCCVDIS(SCDIV)),'$G(SCCVDIS(0)) S Y=0
 ; -- don't use if convert and already converted
 IF Y,SCCVEVT=1,SCECSTAT S Y=0
 ; -- don't use if re-convert and not converted
 IF Y,SCCVEVT=2,'SCECSTAT S Y=0
 ; -- don't use if estimate and converted
 IF Y,'SCCVEVT,SCECSTAT S Y=0
 ; -- if check out required then must have a co completion date/time
 IF Y,$$REQ^SDM1A(SCDTM)="CO",'$P($G(^SCE(SCOE,0)),U,7) S Y=0
 Q +$G(Y)
 ;
EN(SCCVEVT,DFN,SCDTM,SCLOG) ; Entry point to convert a disposition
 ; Input  -- SCCVEVT  Conversion event
 ;                    0=Estimate   1=Convert   2=Re-convert
 ;           DFN      Patient IEN
 ;           SCDTM    Visit date/time
 ;           SCLOG    Scheduling conversion log IEN [optional]
 N SCCV,SCOE,SCCONS,SCEST
 ;
 S SCCONS("SRCE")="SD TO PCE DB CONV"
 S SCCONS("PKG")=$O(^DIC(9.4,"C","SD",0))
 ;
 ;Set up the array for extracting a default disp clinic for the division
 I '$D(SCCVDIS) D
 . N SCCL,SCDIV,Z
 . S Z=0 F  S Z=$O(^PX(815,1,"DHL",Z)) Q:'Z  S SCCL=+$G(^(Z,0)),SCDIV=$P($G(^SC(SCCL,0)),U,15) I SCDIV,'$D(SCCVDIS(SCDIV)) S SCCVDIS(SCDIV)=SCCL
 . ; Default (0) is used if division does not have a valid disp clinic
 . S SCCVDIS(0)=+$P($G(^SD(404.91,1,"CNV")),U,2)
 ;
 ; Check if disposition should be processed
 IF '$$CON(SCCVEVT,DFN,SCDTM,.SCCVDIS) G ENQ
 ;
 ; Set-up conversion array and variables
 D SET^SCCVEDI3(SCCVEVT,+$G(SCLOG),DFN,.SCOE,.SCCV)
 ;
 I 'SCCVEVT,$G(SCCV("ERR")) G ENQ
 ;
 ; Don't process no new enctr or visit needed & no error to log
 I '$G(SCCV("NEW")),'$D(SCCV("ERR")) G ENQ
 ;
 ; Increment number of dispositions found (estimating only)
 I 'SCCVEVT D INCRTOT^SCCVEGU1(.SCTOT,5,1),EN^SCCVZZ("DIS-5",SCOE,SCDTM)
 ;
 ; Log error if no encounter or no visit - exit if no encounter
 I SCCVEVT,$S('$G(SCOE):1,1:'$P($G(SCCV("OE",0)),U,5)) D  G:'$G(SCOE) ENQ
 . N SCE,SCERRIP,Y
 . S SCERRIP(1)=$P($G(^DPT(DFN,0)),U)
 . S Y=SCDTM D D^DIQ S SCERRIP(2)=Y
 . S SCERRIP(5)=$$OTHERR^SCCVU2($G(SCCV("ERR")))
 . S SCERRIP(4)=$S('$G(SCOE):"Outpatient encounter",1:"Visit")
 . S SCE("DFN")=DFN,SCE("ENC")=$G(SCOE),SCE("VSIT")="",SCE("DATE")=SCDTM
 . D GETERR^SCCVLOG1(4049005.003,.SCE,.SCERRIP,$G(SCLOG),0,.SCERRMSG)
 . S:$G(SCOE) ^XTMP("SCCV-ERR-"_+SCLOG,"NO-VIS",SCOE)=""
 . S SCTOT(2.06)=$G(SCTOT(2.06))+1
 ;
 G:$G(SCCV("ERR")) ENQ
 ;
 ; Convert additional disposition data
 I SCCVEVT D ENC(SCOE,.SCCV)
 ;
 ; Convert children
 D CHLD^SCCVEAP2(SCOE,.SCCV,$G(SCLOG))
 ;
 ; Invoke DATA-TO-PCE call, store any errors
 I $S('SCCVEVT:1,1:$P($G(^SCE(SCOE,0)),U,5)) D DATA2PCE^SCCVPCE(SCOE,.SCCONS,SCCVEVT,$G(SCOEP),"","",.SCEST)
 ;
 I 'SCCVEVT D  G ENQ ;Estimate exits here
 .F Z=1:1:3 I $P(SCEST,U,Z) D INCRTOT^SCCVEGU1(.SCTOT,Z+8,$P(SCEST,U,Z)) D EN^SCCVZZ("DIS-"_(Z+8),SCOE,SCDTM,"","",$P(SCEST,U,Z))
 ;
 ; Update disposition as converted
 D DONE(DFN,SCDTM,1)
 ;
 ; Update last entry and number of records
 I $G(SCLOG) D UPDREC^SCCVLOG(SCLOG,SCOE,"CST")
 I '$G(SCLOG) S SCTOT("OK")=1
 ;
ENQ Q
 ;
ENC(SCOE,SCCV) ; Convert additional disposition data for the encounter
 ; $$GETDISP^SDVIST2 creates the encounter and seeds it with disp data
 ; Input  -- SCOE     Outpatient encounter IEN
 ;           SCCV     Conversion array
 ; Output -- None
 N SCDATA
 I $G(SCCV("VST")),'$P($G(^SCE(SCOE,0)),U,5) S SCDATA(.05)=SCCV("VST") ; visit file entry
 S:$G(SCCV("NEW"))=1 SCDATA(901)=1 ; created by conversion
 I $G(SCCV("VST")) D ENCCNV^SCCVEAP1(.SCDATA)
 I $D(SCDATA) D UPD^SCCVDBU(409.68,SCOE,.SCDATA)
 ;
ENCQ Q
 ;
DONE(DFN,SCDTM,SCECSTAT) ; Update disposition encounter conversion status
 ; Input  -- DFN      Patient IEN
 ;           SCDTM    Visit date/time
 ;           SCECSTAT Encounter conversion status
 ; Output -- None
 N SCDATA,SCIENS
 S SCIENS=(9999999-SCDTM)_","_DFN
 S:'$P($G(^DPT(DFN,"DIS",+SCIENS,0)),U,19) SCDATA(19)=SCECSTAT ; encounter conversion status
 I $D(SCDATA) D UPD^SCCVDBU(2.101,SCIENS,.SCDATA)
 Q
 ;
