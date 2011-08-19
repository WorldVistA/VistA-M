SCCVEAP2 ;ALB/RMO,TMP - Appointment Conversion cont.; [ 04/05/95  10:19 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
VISIT(SCDTM,SCCV) ;Create visit when encounter already exists
 ; Input  -- SCDTM    Appointment date/time
 ;           SCCV     Conversion array
 ; Output -- Visit file IEN
 N SCVSIT,SCDATA,SCCVT,SCOE
 IF '$G(SCCV("OE",0)) G VISITQ
 S SCOE=$G(SCCV("OE"))
 S SCVSIT("DFN")=$P(SCCV("OE",0),U,2)
 IF 'SCVSIT("DFN") G VISITQ
 ;
 S SCVSIT("CLN")=$S('$G(SCCV("CSC")):$P(SCCV("OE",0),U,3),1:SCCV("CSC"))
 ;
 S SCVSIT("DIV")=$P(SCCV("OE",0),U,11)
 S SCVSIT("ELG")=$P(SCCV("OE",0),U,13)
 S SCVSIT("LOC")=$P(SCCV("OE",0),U,4)
 S SCVSIT("TYP")=$P(SCCV("OE",0),U,10)
 S SCVSIT("STA")=$P(SCCV("OE",0),U,12)
 S SCVSIT("ORG")=$G(SCCV("ORG"))
 ;
 D SETSCCVT(.SCCVT,.SCCONS)
 IF $G(SCCV("PAR")) S SCVSIT("PAR")=SCCV("PAR")
 ;
 ; -- use parent's visit if a/e, location same, clinic stop same
 IF $G(SCVSIT("PAR")),SCVSIT("ORG")=2 D
 . N SCOEP0
 . S SCOEP0=$G(^SCE(SCVSIT("PAR"),0))
 . IF $P(SCOEP0,U,5),SCVSIT("LOC")=$P(SCOEP0,U,4),SCVSIT("CLN")=$P(SCOEP0,U,3) S SCVSIT("VST")=$P(SCOEP0,U,5)
 ;
 IF '$G(SCVSIT("VST")) D VISIT^SDVSIT0(SCDTM,.SCVSIT)
 ;
 IF $G(SCVSIT("VST")) S SCTOT(1.02)=$G(SCTOT(1.02))+1
 ;
 IF $G(SCVSIT("VST")),'$P(SCCV("OE",0),U,5) D
 . ; -- fix invalid date/time of a/e to sync w/visit
 . IF SCVSIT("ORG")=2,+SCCV("OE",0)'=SCDTM S SCDATA(.01)=SCDTM
 . S SCDATA(.05)=SCVSIT("VST")
 . D UPD^SCCVDBU(409.68,SCOE,.SCDATA)
 ;
 S SCCV("OE",0)=$G(^SCE(SCOE,0))
 S SCCV("VST")=$G(SCVSIT("VST"))
 ;
VISITQ Q $G(SCVSIT("VST"))
 ;
ANC(SCOEP,DFN,SCDTM,SCCLN,SCCV,SCLOG) ;Create stp code enctr/visit for ancillary tests
 ; Input  -- SCOEP    Parent encounter (if known)
 ;           DFN      Patient IEN
 ;           SCDTM    Appointment date/time
 ;           SCCLN    Clinic IEN
 ;           SCCV     Conversion array
 ;           SCLOG    Scheduling conversion log IEN [optional]
 ; Output -- None
 N SCANC,SCOE,SCSCD,SCSCDI,SCVSIT,SCT,SCADD
 I $G(SCCV("PT",0))=""!$S(SCCV("EVT"):$G(SCCV("OE",0))="",1:0) G ANCQ
 I $P(SCCV("PT",0),U,3)'="" S SCANC(108)=$P(SCCV("PT",0),U,3) ; lab
 I $P(SCCV("PT",0),U,4)'="" S SCANC(105)=$P(SCCV("PT",0),U,4) ; x-ray
 I $P(SCCV("PT",0),U,5)'="" S SCANC(107)=$P(SCCV("PT",0),U,5) ; ekg
 S SCSCD=""
 F  S SCSCD=$O(SCANC(SCSCD)) Q:'SCSCD  D
 . S SCSCDI=+$O(^DIC(40.7,"C",SCSCD,0))
 . ;
 . S SCADD=$$CHK(DFN,SCDTM,SCCLN,.SCCV,SCSCDI,.SCOE)
 . I SCADD D
 . . ;Increment number of ancillaries found (estimating only)
 . . S SCVSIT("DFN")=DFN
 . . I 'SCCVEVT D  Q
 . . . F SCT=2,SCADD+6 D
 . . . . N DFN
 . . . . D INCRTOT^SCCVEGU1(.SCTOT,SCT,1),EN^SCCVZZ("AE-"_SCT,SCOE,SCANC(SCSCD),$P($G(SCCV("PT",0)),U),+$G(SCOEP),SCVSIT("DFN"))
 . . ;
 . . I SCADD=1 D
 . . . S SCVSIT("CLN")=SCSCDI
 . . . S SCVSIT("DIV")=$P(SCCV("OE",0),U,11)
 . . . S SCVSIT("ELG")=$P(SCCV("OE",0),U,13)
 . . . S SCVSIT("LOC")=SCCLN
 . . . S SCVSIT("TYP")=$P(SCCV("OE",0),U,10)
 . . . S SCVSIT("PAR")=$G(SCOEP)
 . . . S SCVSIT("ORG")=2,SCVSIT("REF")=""
 . . . D SETSCCVT(.SCCVT,.SCCONS)
 . . . S SCOE=$$SDOE^SDVSIT(SCANC(SCSCD),.SCVSIT,"",$G(SCOEP))
 . . . I '$G(SCVSIT("VST")) D  Q
 . . . . D CREATERR^SCCVLOG1(DFN,SCDTM,SCOE,2,SCCLN,SCSCD,$G(SCLOG))
 . . . . S:$G(SCOE) ^XTMP("SCCV-ERR-"_+SCLOG,"NO-VIS",SCOE)=""
 . . . . S SCTOT(2.06)=$G(SCTOT(2.06))+1
 . . . Q:'SCOE
 . . . S SCTOT(1.02)=$G(SCTOT(1.02))+1
 . . . N SCCVX
 . . . S SCCVX("HIST")=0
 . . . S SCCVX("NEW")=1
 . . . D ENC^SCCVEAP1(SCOE,.SCCVX)
 . . ;
 . . I SCADD=2,SCOE D
 . . . N SCCVX,SCCVY
 . . . S SCCVY("OE")=SCOE
 . . . S SCCVY("OE",0)=$G(^SCE(SCOE,0))
 . . . S SCCVY("PAR")=$P(SCCVY("OE",0),U,6)
 . . . S SCCVY("ORG")=2
 . . . S SCVSIT("VST")=$$VISIT(+SCCVY("OE",0),.SCCVY) ; create visit
 . . . I 'SCVSIT("VST") D  Q
 . . . . D CREATERR^SCCVLOG1(DFN,+SCCVY("OE",0),SCOE,2,$P(SCCVY("OE",0),U,4),SCSCD,$G(SCLOG))
 . . . . S ^XTMP("SCCV-ERR-"_+SCLOG,"NO-VIS",SCOE)=""
 . . . . S SCTOT(2.06)=$G(SCTOT(2.06))+1
 . . . N SCCVX
 . . . S SCCVX("VST")=SCVSIT("VST") D ENC^SCCVEAP1(SCOE,.SCCVX)
 ;
ANCQ Q
 ;
CHK(DFN,SCDTM,SCCLN,SCCV,SCSCDI,SCOE) ;Check if stop code should be added for ancillary test
 ; Input  -- DFN      Patient IEN
 ;           SCDTM    Appointment date/time
 ;           SCCLN    Clinic IEN
 ;           SCCV     Conversion array
 ;           SCSCDI   Clinic Stop Code IEN
 ; Output -- 1=Add enctr and visit  2=Add only visit and  0=No,don't add
 ;           SCOE     IEN of the encounter for the anc test
 N Y,SCAEDTM,SCDA,SCOEC,SCOE00,SDQ
 S Y=1,SCOE=""
 ;
 I $P($G(^SC(SCCLN,0)),U,17)="Y" S Y=0 G CHKQ ; non-count clinic
 ;
 ; The following line is commented out because although it would be a valid check, it is much too tight and thus inconsistent with the rest of the conversion
 ;I $$REQ^SDM1A(SCDTM)="CO",'$P($G(SCCV("PT",0)),U,7) S Y=0 G CHKQ ; check out required but no checkout date, don't process
 ;
 S (SCOEC,SDQ)=0
 F  S SCOEC=$O(^SCE("APAR",+$G(SCOEP),SCOEC)) Q:'SCOEC  D  Q:SDQ
 . S SCOE00=$G(^SCE(SCOEC,0))
 . I $P(SCOE00,U,3)=SCSCDI D
 . . S SDQ=1
 . . I 'SCCVEVT,$P(SCOE00,U,8)=2 S Y=0 Q  ;Will be counted with add/edits
 . . I SCCVEVT<2 D  Q  ;Estimate/convert
 . . . I $P(SCOE00,U,5) S Y=0 Q  ;Already added
 . . . S Y=2,SCOE=SCOEC ;Add visit only
 . . I SCCVEVT=2 D  Q  ;Re-convert
 . . . D RECNVT^SCCVEAP3(SCOEC,SCOE00,.SCCONS)
 . . . I $D(^SCE(SCOEC,0)) S Y=2,SCOE=SCOEC Q  ;Re-add visit only
 . . . S Y=1 ;Re-add visit and encounter
 ;
CHKQ Q $G(Y)
 ;
CHLD(SCOEP,SCCV,SCLOG) ;Convert children
 ; Input  -- SCOEP    Parent outpatient encounter IEN
 ;           SCCV     Conversion array           
 ;           SCLOG    Scheduling conversion log IEN   [optional]
 ; Output -- None
 N SCERRMSG,SCOE0,SCOEC,SCX,SDVIEN
 S SCOEC=0
 F  S SCOEC=$O(^SCE("APAR",SCOEP,SCOEC)) Q:'SCOEC  D
 . S SCOE0=$G(^SCE(SCOEC,0))
 . S SDVIEN=$$SDVIEN^SCCVU(+$P(SCOE0,U,2),+SCOE0)
 . I 'SCCV("EVT"),$P(SCOE0,U,9) D  Q:'SCX
 . . F SCX=1:1:$L($P(SCOE0,U,9),":") I $P($G(^SDV(SDVIEN,"CS",+$P($P(SCOE0,U,9),":",SCX),0)),U,8)=SCOEC S SCX=0 Q  ;When estimating, these should be counted in the add/edit loop
 . I $P(SCOE0,U,8)=2,$P(SCOE0,U,9),'$P(SCOE0,U,5) D  ;convert child add/edit
 . . ;There should be only 1 ":" piece before 10/1/96, but this was
 . . ; included in the case of bad data
 . . F SCX=1:1:$L($P(SCOE0,U,9),":") D EN^SCCVEAE1(SCCV("EVT"),SDVIEN,+$P($P(SCOE0,U,9),":",SCX),SCOEP,$G(SCLOG))
 Q
 ;
SETSCCVT(SCCVT,SCCONS) ; Set the SCCVT array for source and service type
 S SCCVT("SOR")=SCCONS("SRCE")
 S SCCVT("SVC")="E"
 I $G(SCCV("ORG"))=3,$G(SCCV("LOC")) S SCCVT("LOC")=SCCV("LOC")
 Q
 ;
