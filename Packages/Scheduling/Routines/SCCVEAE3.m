SCCVEAE3 ;ALB/RMO,TMP - Add/Edit Conversion cont.; [ 04/05/95  8:46 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
SET(SCCVEVT,SCLOG,SCDTM,SCVALDT,SCDA,SCOEP,SCOE,SCCV) ; Set variables, add encounter/visit
 ; Input  -- SCCVEVT  Conversion event
 ;           SCLOG    Scheduling conversion log IEN
 ;           SCDTM    Visit date/time (IEN)
 ;           SCVALDT  Valid converted Visit date/time (SCDTM)
 ;           SCDA     Clinic stop code sub-file IEN
 ;           SCOEP    Parent outpatient encounter IEN [optional]
 ; Output -- SCOE     Outpatient encounter IEN
 ;           SCCV     Conversion array:
 ;                    SCCV("EVT")       Conversion event
 ;                        ("LOG")       Scheduling conversion log IEN
 ;                        ("NEW")       Outpatient encounter or visit
 ;                                       created by conversion flag
 ;                                       0 = no new encounter or visit
 ;                                       1 = new encounter and visit
 ;                                       2 = new visit only
 ;                        ("OE",0)      Outpatient encounter 0th node
 ;                        ("CS",0)      Clinic stop code 0th node
 ;                        ("CS",1)      Clinic stop code 1 node
 ;                        ("CS","PR")   Clinic stop code 'PR' node
 ;                        ("ERR")       Code for specific error, if any
 ;                        ("VST")       Visit file IEN
 ;
 N SCCVSIT,SCV0,DA,DR,DE,DQ,DIE,SDVSIT,SCOE0,SCCVT,X
 S SCCV("EVT")=SCCVEVT
 S SCCV("LOG")=SCLOG
 ;
 ; If estimating, increment the total number of encounters and visits
 ;  that would be created by the conversion
 ; If converting, create a new encounter and/or visit
 ;
 I '$G(^SDV(SCDTM,0)) S SCCV("ERR")=4 G SETQ
 S SCCVSIT=^SDV(SCDTM,0),SDVSIT("DFN")=$P(SCCVSIT,U,2)
 I 'SDVSIT("DFN") S SCCV("ERR")=5 G SETQ
 ;
 I '$D(^SDV(SCDTM,"CS",SCDA,0)) S SCCV("ERR")=9 G SETQ
 S SCV0=^SDV(SCDTM,"CS",SCDA,0),SCCV("CS","PR")=$G(^("PR"))
 ;
 S SCOE=+$P(SCV0,U,8),SCOE0=$G(^SCE(SCOE,0))
 ;
 ; On re-convert, delete previously converted data for parents only
 I SCCVEVT=2,'$P(SCOE0,U,6) D
 . ; only delete for reconvert if we created the encounter or completed
 . ;   the conversion by adding the visit
 . Q:'$$CCREATE^SCCVU(SCOE)
 . ;
 . D RECNVT^SCCVEAP3(SCOE,SCOE0,.SCCONS)
 . S SCOE0=$G(^SCE(SCOE,0)) S:SCOE0="" SCOE=0
 ;
 S SCCV("NEW")=$S('SCOE:1,'$P(SCOE0,U,5):2,1:0)
 ;
 I 'SCCV("NEW") G SETQ ; Already has an encounter and visit
 ;
 I 'SCCVEVT D  G SETQ ; Estimate exits here
 . ; -- don't incrment if child will use parent's visit ien
 . IF SCCV("NEW")=2,$G(SCOEP),$D(^SCE(SCOEP,0)),$P(^(0),U,3)=$P(SCOE0,U,3),$P(^(0),U,4)=$P(SCOE0,U,4) Q
 . D INCRTOT^SCCVEGU1(.SCTOT,SCCV("NEW")+6,1)
 . D EN^SCCVZZ("AE-"_(SCCV("NEW")+6),SCOE,SCDTM,SCDA,$S(SCOEP:SCOEP,$P($G(^SCE(SCOE,0)),U,6):+$P(^(0),U,6),1:0),SDVSIT("DFN"))
 ;
 S SDVSIT("DIV")=+$P($G(^SC(+$P(SCV0,U,3),0)),U,15)
 S:'SDVSIT("DIV") SDVSIT("DIV")=+$P(SCCVSIT,U,3)
 S SDVSIT("DIV")=$$DIV(SDVSIT("DIV"))
 I 'SDVSIT("DIV") S SCCV("ERR")=6 G SETQ
 ;
 S SDVSIT("CLN")=+SCV0
 I $P($G(^DIC(40.7,+SCV0,0)),U,2)=900 S SDVSIT("CLN")=+$P($G(^SC(+$P(SCV0,U,3),0)),U,7)
 I 'SDVSIT("CLN") S SCCV("ERR")=7 G SETQ
 ;
 S:$P(SCV0,U,3) SDVSIT("LOC")=$P(SCV0,U,3)
 S:$P(SCV0,U,4) SDVSIT("ELG")=$P(SCV0,U,4)
 S:$P(SCV0,U,5) SDVSIT("TYP")=$P(SCV0,U,5)
 S SDVSIT("ORG")=2,SDVSIT("REF")=SCDA
 D SETSCCVT^SCCVEAP2(.SCCVT,.SCCONS)
 ;
 S:$G(SCOEP) SDVSIT("PAR")=SCOEP
 ;
 I SCCV("NEW")=2 D  G:'$G(SDVSIT("VST")) SETQ ; -- Has encounter, needs visit
 . S SCOE=$P(SCV0,U,8),SDVSIT("OE",0)=SCOE0
 . S SDVSIT("OE")=SCOE
 . S X=$$VISIT^SCCVEAP2(SCVALDT,.SDVSIT) ; -- Add visit only
 . S SCOE0=SDVSIT("OE",0)
 ;
 I SCCV("NEW")=1 D  ; -- Needs both encounter and visit added
 .S SCOE=$$SDOE^SDVSIT(SCVALDT,.SDVSIT),SCOE0=$G(^SCE(+SCOE,0))
 .S:SCOE SCTOT(1.02)=$G(SCTOT(1.02))+1
 ;
 G SETQ:'SCOE
 ;
 I $G(SDVSIT("VST")),'$P(SCOE0,U,5) S SCDATA(.05)=SDVSIT("VST") D UPD^SCCVDBU(409.68,SCOE,.SCDATA) K SCDATA
 ;
 ; Update 'CS' node with encounter pointer
 I SCCV("NEW")=1 S SCDATA(8)=SCOE,SCIENS=SCDA_","_SCDTM D UPD^SCCVDBU(409.51,SCIENS,.SCDATA) K SCDATA
 ;
 M SCCV=SDVSIT
 S SCCV("OE",0)=$G(^SCE(SCOE,0))
 S SCCV("VST")=$P($G(SCCV("OE",0)),U,5)
 S SCCV("CS",0)=$G(^SDV(SCDTM,"CS",SCDA,0)),SCCV("CS",1)=$G(^(1))
 ;
 IF SCCV("NEW")=1 D CSCAN(SCDTM,.SCCV)
 ;
SETQ Q
 ;
DIV(DIV) ; -- determine med div
 I $P($G(^DG(43,1,"GL")),U,2),$D(^DG(40.8,+DIV,0)) G DIVQ ; multi-div?
 S DIV=+$O(^DG(40.8,0))
DIVQ Q DIV
 ;
CSCAN(SCDTM,SCCV) ; -- update 900 "CS" nodes with same clinic
 N SCLN,SCS,SCS0,SCNT,SCEXT
 S SCLN=+$P($G(SCCV("CS",0)),U,3)
 S SCOE=+$P($G(SCCV("CS",0)),U,8)
 S SCEXT=$P(SCCV("OE",0),U,9)
 ;
 IF 'SCCV900!('SCLN)!('SCOE)!(SCEXT="") G CSCANQ
 ;
 S SCNT=0
 ; -- scan for "CS" nodes that are 900's, same clinic & no encounter
 S SCS=0 F  S SCS=$O(^SDV(SCDTM,"CS",SCS)) Q:'SCS  S SCS0=$G(^(SCS,0)) D
 . IF +SCS0=SCCV900,+$P(SCS0,U,3)=SCLN,'$P(SCS0,U,8) D
 . . N SCDATA,SCIENS
 . . S SCDATA(8)=SCOE ; -- set sce ien
 . . S SCDATA(9)=1    ; -- mark converted
 . . S SCIENS=SCS_","_SCDTM
 . . D UPD^SCCVDBU(409.51,SCIENS,.SCDATA)
 . . S SCEXT=SCEXT_":"_SCS
 . . S SCNT=SCNT+1
 ;
 IF 'SCNT G CSCANQ
 ;
 N SCDATA
 S SCDATA(.09)=SCEXT D UPD^SCCVDBU(409.68,SCOE,.SCDATA)
 S SCCV("OE",0)=$G(^SCE(SCOE,0))
 ;
CSCANQ Q
 ;
