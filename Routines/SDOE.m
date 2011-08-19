SDOE ;ALB/MJK - ACRP APIs For An Encounter ;8/12/96
 ;;5.3;Scheduling;**131**;Aug 13, 1993
 ;
 ; ------------------------- cpt api's --------------------------
 ;
CPT(SDOE,SDERR) ; -- SDOE ASSIGNED A PROCEDURE                     [API ID: 65]
 D PREP^SDQUT
 Q $$CPT^SDOECPT(.SDOE,$G(SDERR))
 ;
GETCPT(SDOE,SDCPT,SDERR) ; -- SDOE GET PROCEDURES           [API ID: 61]
 D PREP^SDQUT
 G GETCPTG^SDOECPT
 ;
FINDCPT(SDOE,SDCPTID,SDERR) ; -- SDOE FIND PROCEDURE           [API ID: 71]
 D PREP^SDQUT
 Q $$FINDCPT^SDOECPT(.SDOE,.SDCPTID,$G(SDERR))
 ;
 ; ------------------------- dx api's --------------------------
 ;
DX(SDOE,SDERR) ; -- SDOE ASSIGNED A DIAGNOSIS                     [API ID: 64]
 D PREP^SDQUT
 Q $$DX^SDOEDX(.SDOE,$G(SDERR))
 ;
GETDX(SDOE,SDDX,SDERR) ; -- SDOE GET DIAGNOSES                    [API ID: 56]
 D PREP^SDQUT
 G GETDXG^SDOEDX
 ;
FINDDX(SDOE,SDDXID,SDERR) ; -- SDOE FIND DIAGNOSIS           [API ID: 70]
 D PREP^SDQUT
 Q $$FINDDX^SDOEDX(.SDOE,.SDDXID,$G(SDERR))
 ;
GETPDX(SDOE,SDERR) ; -- SDOE GET PRIMARY DIAGNOSIS            [API ID: 73]
 D PREP^SDQUT
 Q $$GETPDX^SDOEDX(.SDOE,$G(SDERR))
 ;
 ; ------------------------- provider api's --------------------------
 ;
PRV(SDOE,SDERR) ; -- SDOE ASSIGNED A PROVIDER                      [API ID: 63]
 D PREP^SDQUT
 Q $$PRV^SDOEPRV(.SDOE,$G(SDERR))
 ;
GETPRV(SDOE,SDPRV,SDERR) ; -- SDOE GET PROVIDERS            [API ID: 58]
 D PREP^SDQUT
 G GETPRVG^SDOEPRV
 ;
FINDPRV(SDOE,SDPRVID,SDERR) ; -- SDOE FIND PROVIDER            [API ID: 69]
 D PREP^SDQUT
 Q $$FINDPRV^SDOEPRV(.SDOE,.SDPRVID,$G(SDERR))
 ;
 ; --------------------------------oe api's--------------------------
 ;
GETOE(SDOE,SDERR) ; -- SDOE GET ZERO NODE                    [API ID: 98]
 D PREP^SDQUT
 Q $$GETOE^SDOEOE(.SDOE,$G(SDERR))
 ;
GETGEN(SDOE,SDAT,SDERR) ; -- SDOE GET GENERAL DATA                 [API ID: 76]
 D PREP^SDQUT
 G GETGENG^SDOEOE
 ;
PARSE(SDATA,SDFMT,SDY,SDERR) ; -- SDOE PARSE GENERAL DATA       [API ID: 78]
 D PREP^SDQUT
 G PARSEG^SDOEOE
 ;
EXAE(DFN,SDBEG,SDEND,SDFLAGS,SDERR) ; -- SDOE FIND FIRST STANDALONE [API ID: 72]
 D PREP^SDQUT
 Q $$EXAE^SDOEOE(.DFN,.SDBEG,.SDEND,$G(SDFLAGS),$G(SDERR))
 ;
GETLAST(DFN,SDBEG,SDFLAGS,SDERR) ; -- SDOE FIND LAST STANDALONE  [API ID: 75]
 D PREP^SDQUT
 Q $$GETLAST^SDOEOE(.DFN,.SDBEG,$G(SDFLAGS),$G(SDERR))
 ;
EXOE(DFN,SDBEG,SDEND,SDFLAGS,SDERR) ; -- SDOE FIND FIRST ENCOUNTER  [API ID: 74]
 D PREP^SDQUT
 Q $$EXOE^SDOEOE(.DFN,.SDBEG,.SDEND,$G(SDFLAGS),$G(SDERR))
 ;
ER(SDOE) ; -- api retrieves Extended Reference field
 ;              - not supported generically
 ;              - will be removed in the future
 ;              - you need IA to use!
 ;
 Q $P($G(^SCE(SDOE,0)),U,9)
 ;
