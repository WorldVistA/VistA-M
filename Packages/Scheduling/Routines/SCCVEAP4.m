SCCVEAP4 ;ALB/RMO,TMP - Appointment Conversion cont.; [ 04/05/95  10:19 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
CREDIT(SCOE,SCDTM,SCCV,SCCVEVT) ; Add/delete visit for credit stop
 ;  (for add encounter and visit - ^SDVSIT does it)
 ;Input:
 ;           SCOE     Parent encounter ien
 ;           SCDTM    Appointment date/time
 ;           SCCV     Conversion array
 ;           SCCVEVT  Conversion event (0/1/2)
 N SCCRST,SCOE00,SCOEC,SCHIST,SCOESV,SCCVX,SCVSIT,SCQ,SCX,X
 ; Credit stop code may need a visit, too
 ; Find 'child' clinic stop code encounter, if there
 S (SCHIST,SCOEC,SCQ,SCX)=0,SCOE00=""
 F  S SCOEC=$O(^SCE("APAR",SCOE,SCOEC)) Q:'SCOEC  D  Q:SCQ
 . S SCOE00=$G(^SCE(SCOEC,0))
 . I $P(SCOE00,U,8)=4 S SCHIST=+$P($G(^SCE(SCOEC,"CNV")),U,3),SCQ=1 Q
 . I 'SCX,$P(SCOE00,U,8)=2,$P(SCOE00,U,9),+$G(^SDV($$SDVIEN^SCCVU(+$P(SCOE00,U,2),SCDTM),"CS",+$P(SCOE00,U,9),0))=$P(SCCV("CL1",0),U,18) S SCX=SCOEC
 ;
 I SCOE,'SCOEC G CREDITQ ;Appt enc exists, so credit enc should have
 ;                        existed if valid at time of appt enc creation
 I 'SCOEC D
 . I SCX S SCOEC=SCX Q
 . S SCHIST=1
 ;
 I $P($G(^SCE(+SCOEC,0)),U,5) G CREDITQ ; Already has visit
 ;
 I SCHIST,$P(SCCV("CL1",0),U,17)="Y" G CREDITQ ; non-count clinic
 ;
 S SCCRST=$S('SCHIST:$P(SCOE00,U,3),1:$P($G(SCCV("CL1",0)),U,18))
 ;
 G:'SCCRST CREDITQ ; no credit stop code assigned to this appt
 IF SCHIST,SCCRST=$P(SCCV("CL1",0),U,7) G CREDITQ ; credit stop code same as stop code for this clinic
 ;
 I SCHIST S SCQ=0 D  G:SCQ CREDITQ
 . S X=$P($G(^DIC(40.7,SCCRST,0)),U,3)
 . I $S('X:0,1:(SCDTM\1)'<X) S SCQ=1 ; stop code was inactive
 ;
 I 'SCCVEVT D  Q  ;estimate exits here
 .N ZZZ
 .S ZZZ=$S(SCOEC:SCOEC,1:0)
 .D INCRTOT^SCCVEGU1(.SCTOT,8-SCHIST,1),INCRTOT^SCCVEGU1(.SCTOT,4,1),EN^SCCVZZ("CREDIT-"_(8-SCHIST),ZZZ,SCDTM,$P($G(SCCV("PT",0)),U),SCOE),EN^SCCVZZ("CREDIT-4",ZZZ,SCDTM,$P($G(SCCV("PT",0)),U),SCOE)
 ;
 I SCCVEVT=2,SCOEC,$P(SCOE00,U,5) D
 . D RECNVT^SCCVEAP3(SCOEC,SCOE00,.SCCONS) ;Re-converting - delete old visit/enctr
 . I '$D(^SCE(SCOEC,0)) S SCHIST=1
 ;
 ;If historical, we need to add both the encounter and the visit
 I SCHIST D  G CREDITQ
 . N SCOEX,SCCVT
 . S SCVSIT("DFN")=$P(SCCV("OE",0),U,2)
 . S SCVSIT("CLN")=SCCRST
 . S SCVSIT("DIV")=$P(SCCV("OE",0),U,11)
 . S SCVSIT("ELG")=$P(SCCV("OE",0),U,13)
 . S SCVSIT("LOC")=$P(SCCV("PT",0),U)
 . S SCVSIT("TYP")=$P(SCCV("OE",0),U,10)
 . S SCVSIT("PAR")=SCOE
 . S SCVSIT("ORG")=4,SCVSIT("REF")=0
 . D SETSCCVT^SCCVEAP2(.SCCVT,.SCCONS)
 . S SCOEX=$$SDOE^SDVSIT(SCDTM,.SCVSIT,"",SCVSIT("PAR"))
 . ;
 . I SCOEX D
 .. N SCCVX
 .. S SCTOT(1.02)=$G(SCTOT(1.02))+1
 .. S SCCVX("HIST")=1,SCCVX("NEW")=1
 .. D ENC^SCCVEAP1(SCOEX,.SCCVX)
 . ;
 . I 'SCOEX!'$G(SCVSIT("VST")) D  ;Encounter or visit not created
 .. D CREATERR^SCCVLOG1(SCVSIT("DFN"),SCDTM,+SCOEX,4,SCVSIT("LOC"),SCCRST,$G(SCLOG))
 .. S:SCOEX ^XTMP("SCCV-ERR-"_+SCLOG,"NO-VIS",SCOEX)=""
 .. S SCTOT(2.06)=$G(SCTOT(2.06))+1
 ;
 ;Add visit only if encounter, but no visit exists
 G:$P($G(^SCE(SCOEC,0)),U,5) CREDITQ
 ;
 M SCVSIT=SCCV
 S SCVSIT("OE")=SCOEC
 S SCVSIT("OE",0)=$G(^SCE(SCOEC,0))
 S SCVSIT("CSC")=SCCRST,SCVSIT("PAR")=SCOE,SCVSIT("ORG")=4
 S SCVSIT("VST")=$$VISIT^SCCVEAP2(SCDTM,.SCVSIT) ; create visit
 ;
 I 'SCVSIT("VST") D  ;No visit
 . D CREATERR^SCCVLOG1(+$P($G(SCVSIT("OE",0)),U,2),SCDTM,+SCOEC,4,$P($G(SCCV("PT",0)),U),SCCRST,$G(SCLOG))
 . S ^XTMP("SCCV-ERR-"_+SCLOG,"NO-VIS",SCOEC)=""
 . S SCTOT(2.06)=$G(SCTOT(2.06))+1
 ;
 I SCVSIT("VST") S SCCVX("VST")=SCCV("VST") D ENC^SCCVEAP1(SCOEC,.SCCVX)
 ;
CREDITQ Q
 ;
