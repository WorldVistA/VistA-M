SCCVEAP3 ;ALB/RMO,TMP - Appointment Conversion cont.; [ 04/05/95  10:19 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
SET(SCCVEVT,SCLOG,DFN,SCDTM,SCCLN,SCDA,SCOE,SCCV) ; Set variables
 ; Input  -- SCCVEVT  Conversion event
 ;           SCLOG    Scheduling conversion log IEN
 ;           DFN      Patient IEN
 ;           SCDTM    Appointment date/time
 ;           SCCLN    Clinic IEN
 ; Output -- SCDA     Clinic appt patient sub-file IEN
 ;           SCOE     Outpatient encounter IEN
 ;           SCCV     Conversion array:
 ;                    SCCV("EVT")       Conversion event
 ;                        ("LOG")       Scheduling conversion log IEN
 ;                        ("NEW")       Outpatient encounter
 ;                                       created by conversion flag
 ;                                       0 = no new encounter or visit
 ;                                       1 = new encounter and visit
 ;                                       2 = new visit only
 ;                        ("SCDA")      Multiple entry in ^SC for this pt
 ;                        ("OE",0)      Outpatient encounter 0th node
 ;                        ("PT",0)      Patient appt 0th node
 ;                        ("PT","R")    Patient appt "R" node (Remarks)
 ;                        ("CL1",0)     Clinic's 0th node
 ;                        ("CL",0)      Clinic appt patient 0th node
 ;                        ("CL","C")    Clinic appt patient "C" node (Check in/out)
 ;                        ("ERR")       Code for specific error, if any
 ;                        ("VST")       Visit file IEN
 ;
 N SCOE0,SCDATA,SCIENS
 ;
 S:'$G(SCDA) SCDA=+$$FIND^SDAM2(DFN,SCDTM,SCCLN) ; Find multiple entry in ^SC for this pt
 ;
 S SCOE=+$P($G(^DPT(DFN,"S",SCDTM,0)),U,20),SCOE0=$G(^SCE(SCOE,0))
 ;
 ; -- following is commented out ; left for reference purposes
 ; -- this 'if' should always fail ; CON^SCCVEAP1 has this covered
 ;IF 'SCOE,'SCDA S SCCV("ERR")=1 G SETQ
 ;
 S SCCV("SCDA")=SCDA
 S SCCV("EVT")=SCCVEVT
 ;
 S SCCV("LOG")=SCLOG
 S SCCV("PT",0)=$G(^DPT(DFN,"S",SCDTM,0)),SCCV("PT","R")=$G(^("R"))
 S SCCV("CL",0)=$G(^SC(SCCLN,"S",SCDTM,1,SCDA,0)),SCCV("CL","C")=$G(^("C"))
 S SCCV("CL1",0)=$G(^SC(SCCLN,0))
 ;
 ; On re-convert, delete previously converted data
 I SCCVEVT=2 D
 . N SCDATA
 . ; only delete for reconvert if we created the encounter or completed
 . ;   the conversion by adding the visit
 . Q:'$$CCREATE^SCCVU(SCOE)
 . ;
 . S SCCV("OE",0)=SCOE0
 . D RECNVT(SCOE,SCOE0,.SCCONS)
 . S SCOE0=$G(^SCE(SCOE,0)) S:SCOE0="" SCOE=0
 ;
 S SCCV("NEW")=$S('SCOE:1,'$P(SCOE0,U,5):2,1:0)
 ;
 G:'SCCV("NEW") SETQ ; Already has both an encounter and visit
 ;
 ; Increment total number of encounters/visits that would be created by
 ;   conversion (if estimating)
 I 'SCCVEVT D  G SETQ ; -- Estimate exits here
 . D INCRTOT^SCCVEGU1(.SCTOT,SCCV("NEW")+6,1)
 . D EN^SCCVZZ("APPT-"_(SCCV("NEW")+6),SCOE,SCDTM,$P($G(SCCV("PT",0)),U),+$P(SCOE0,U,6))
 . D CREDIT^SCCVEAP4(SCOE,SCDTM,.SCCV,0)
 ;
 I 'SCOE D  ; Create enctr/visit
 . N SCCVT
 . D SETSCCVT^SCCVEAP2(.SCCVT,.SCCONS)
 . IF 'SCDA F  L +^SC(SCCLN,"S",SCDTM,1,999999):5 IF $T S ^SC(SCCLN,"S",SCDTM,1,999999,0)=DFN Q
 . S SCOE=$$GETAPT^SDVSIT2(DFN,SCDTM,SCCLN,"")
 . IF 'SCDA K ^SC(SCCLN,"S",SCDTM,1,999999) L -^SC(SCCLN,"S",SCDTM,1,999999)
 . Q:'SCOE
 . I $P($G(^SCE(SCOE,0)),U,3) S SCCV("HIST")=1
 . S SCTOT(1.02)=$G(SCTOT(1.02))+1
 ;
 S SCCV("OE")=+SCOE
 S SCCV("OE",0)=$G(^SCE(+SCOE,0))
 S SCCV("VST")=$P(SCCV("OE",0),U,5)
 S SCCV("ORG")=1,SCCV("REF")=SCDA
 ;
 I 'SCCV("VST"),SCOE,SCCV("NEW")'=1 D
 . S SCCV("VST")=$$VISIT^SCCVEAP2(SCDTM,.SCCV) ; create visit if encounter already exists, but no visit
 . D CREDIT^SCCVEAP4(SCOE,SCDTM,.SCCV,SCCVEVT)
 ;
SETQ Q
 ;
RECNVT(SCOE,SCOE0,SCCONS) ;Delete data added by conversion
 ;
 N Z,SCVST,SCENC,SCENC0,SCCHLD,PXKNOEVT
 ;
 S PXKNOEVT=1 ;Don't want event driver to fire off
 ;
 S SCVST(0,SCOE,+$P(SCOE0,U,5))=+$G(^SCE(SCOE,"CNV")) ;Parent
 D DELPTR(SCOE)
 ;
 S SCENC=0 F  S SCENC=$O(^SCE("APAR",SCOE,SCENC)) Q:'SCENC  D
 . S SCVST(1,SCENC,+$P($G(^SCE(SCENC,0)),U,5))=+$G(^SCE(SCENC,"CNV"))
 . D DELPTR(SCENC)
 ;
 S SCCHLD="" F  S SCCHLD=$O(SCVST(SCCHLD)) Q:SCCHLD=""  S SCENC=0 F  S SCENC=$O(SCVST(SCCHLD,SCENC)) Q:'SCENC  S SCVST="" F  S SCVST=$O(SCVST(SCCHLD,SCENC,SCVST)) Q:SCVST=""  D
 . I SCVST(SCCHLD,SCENC,SCVST),$D(^SCE(SCENC,0)) D DELE^SCCVCST2(SCENC) ;Created by conversion - delete enctr
 . Q:'SCVST!SCCHLD  ;No need to delete children visits - they should go away w/parent
 . S Z=$$DELVFILE^PXAPI("ALL",SCVST,$G(SCCONS("PKG")),$G(SCCONS("SRCE")))
 Q
 ;
DELPTR(SCE) ; Delete visit pointer if encounter still exists
 ; SCE = encounter IEN
 N SCDATA
 I $P($G(^SCE(SCE,0)),U,5) S SCDATA(.05)="@" D UPD^SCCVDBU(409.68,SCE,.SCDATA)
 ;
 Q
 ;
