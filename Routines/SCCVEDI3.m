SCCVEDI3 ;ALB/RMO,TMP - Disposition Conversion cont.; [ 04/05/95  8:12 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
SET(SCCVEVT,SCLOG,DFN,SCOE,SCCV) ;Set variables
 ; Input  -- SCCVEVT  Conversion event
 ;           SCLOG    Scheduling conversion log IEN
 ;           DFN      Patient IEN
 ; Output -- SCOE     Outpatient encounter IEN
 ;           SCCV     Conversion array:
 ;                    SCCV("EVT")       Conversion event
 ;                        ("LOG")       Scheduling conversion log IEN
 ;                        ("NEW")       Outpatient encounter
 ;                                       created by conversion flag
 ;                                       0 = no new encounter or visit
 ;                                       1 = new encounter and visit
 ;                                       2 = new visit only
 ;                        ("OE",0)      Outpatient encounter 0th node
 ;                        ("DISP",0)    Disposition log-in date/time 0th node
 ;                        ("ERR")       Code for specific error, if any
 ;                        ("VST")       Visit file IEN
 N SCOE0
 S SCCV("EVT")=SCCVEVT
 S SCCV("LOG")=+SCLOG,SCCV("ORG")=3
 S SCCV("DISP",0)=$G(^DPT(DFN,"DIS",9999999-SCDTM,0))
 I $D(SCCVDIS) D  ;Find default disp. clinic for division
 . S SCCV("LOC")=+$G(SCCVDIS(+$P(SCCV("DISP",0),U,4)))
 . I 'SCCV("LOC"),$G(SCCVDIS(0)) S SCCV("LOC")=SCCVDIS(0)
 S SCOE=+$P(SCCV("DISP",0),U,18),SCOE0=$G(^SCE(SCOE,0))
 ;
 ; On re-convert, delete previously converted data
 I SCCVEVT=2 D
 . ; only delete for reconvert if we created the encounter or completed
 . ;   the conversion by adding the visit
 . Q:'$$CCREATE^SCCVU(SCOE)
 . ;
 . D RECNVT^SCCVEAP3(SCOE,SCOE0,.SCCONS)
 . S SCOE0=$G(^SCE(SCOE,0)) S:SCOE0="" SCOE=0
 ;
 S SCCV("NEW")=$S('SCOE:1,'$P(SCOE0,U,5):2,1:0)
 ;
 I 'SCCV("NEW") G SETQ ;Already has enctr and visit
 ;
 ; If estimating, increment total number of encounters that would be
 ;  created by the conversion
 I 'SCCVEVT D INCRTOT^SCCVEGU1(.SCTOT,SCCV("NEW")+6,1) D EN^SCCVZZ("DIS-"_(SCCV("NEW")+6),SCOE,SCDTM)
 ;
 G:'SCCVEVT SETQ ;Estimate exits here
 ;
 I 'SCOE D  ;Needs both encounter and visit
 . N SCCVT
 . D SETSCCVT^SCCVEAP2(.SCCVT,.SCCONS)
 . S SCOE=$$GETDISP^SDVSIT2(DFN,SCDTM)
 . S:SCOE SCTOT(1.02)=$G(SCTOT(1.02))+1
 . ;Check if child add/edits were auto-added (no children should be auto-created)
 . I SCOE,$O(^SCE("APAR",SCOE,0)) D
 .. N SCOEC,SCOE00
 .. S SCOEC=0 F  S SCOEC=$O(^SCE("APAR",SCOE,SCOEC)) Q:'SCOEC  S SCOE00=$G(^SCE(SCOEC,0)) I $P(SCOE00,U,8)=2 D
 ... N SCCV
 ... S SCCV("NEW")=1
 ... D ENC^SCCVEDI1(SCOEC,.SCCV)
 ;
 S SCCV("OE")=SCOE
 S SCCV("OE",0)=$G(^SCE(SCOE,0))
 S SCCV("VST")=$P(SCCV("OE",0),U,5)
 S SCCV("REF")=9999999-SCDTM
 ;
 I 'SCCV("VST"),SCCV("NEW")'=1 D
 . S SCCV("VST")=$$VISIT^SCCVEAP2(SCDTM,.SCCV) ; create visit only
 ;
 I SCCVEVT,'$G(SCCV("VST")),'$P(SCCV("OE",0),U,4) S SCCV("ERR")=8
SETQ Q
 ;
