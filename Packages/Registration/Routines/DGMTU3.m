DGMTU3 ;ALB/MLI/GN/LBD - Internal Entry Number Utility Calls ; 2/20/03 8:45am
 ;;5.3;Registration;**33,45,137,182,300,433,499,518**;Aug 13, 1993
 ;
 ; This routine will return the IENs for the primary income
 ; test from various files.
 ;
MTIEN(TYPE,DFN,INVDT) ; get last primary income test for date
 ;
 ; Input  -- TYPE as 1 for means test, 2 for copay test
 ;           DFN as Patient IEN
 ;           INVDT as inverse date for search
 ; Output -- Record IEN
 ;
 N I
 F I=0:0 S I=$O(^DGMT(408.31,"AID",TYPE,DFN,INVDT,I)) Q:'I  I +$G(^DGMT(408.31,I,"PRIM")) Q
 Q I
 ;
 ;
IAI(REL,YEAR,DGMTYPT) ; get individual annual income IEN for primary income test/pt relation
 ;
 ; Input  -- REL as IEN of PATIENT RELATION file
 ;           YEAR as income year in question
 ;           DGMTYPT as type of test (optional if not defined means test
 ;                   will be assumed)
 ; Output -- Record IEN
 ;
 N DFN,I,IEN,INR,MTIEN,LAST,DGDT,LTCIEN
 S DFN=+$G(^DGPR(408.12,+REL,0)) I 'DFN G IAIQ
 ;
 ;DG*5.3*499, change to if structure and check for presence of DGMTI
 ; it is not defined when coming from Bene travel menus
 ;LTC Phase III (DG*5.3*518) - add setting of LTCIEN
 ;
 ; if user selects view option & DGMTI exists, set IEN=DGMTI
 I $G(DGMTACT)="VEW",$G(DGMTI) D
 . S (MTIEN,LTCIEN)=DGMTI
 E  D
 . S DGDT=$E(YEAR,1,3)+1_"1231.99"
 . S MTIEN=$$LST^DGMTU(DFN,DGDT,$S($G(DGMTYPT):DGMTYPT,1:1))
 . S LTCIEN=$S($G(DGMTI):DGMTI,1:$$LST^EASECU(DFN,(YEAR+1231.99),3))
 ;
 I MTIEN S LAST=0 D
 . F I=0:0 S I=$O(^DGMT(408.21,"AI",+REL,-YEAR,I)) Q:'I  S LAST=I,INR=$O(^DGMT(408.22,"AIND",I,"")) I +$G(^DGMT(408.22,+INR,"MT"))=+MTIEN Q
 . S IEN=LAST
 . ; The following was added for LTC Copay Phase II (DG*5.3*433)
 . ; If the IAI record is associated with a LTC Copay Test (type 3),
 . ; don't return it if DGMTYPT is not type 3.
 . Q:'$G(^DGMT(408.21,IEN,"MT"))
 . I $P($G(^DGMT(408.31,+^DGMT(408.21,IEN,"MT"),0)),U,19)=3,$G(DGMTYPT)'=3 S IEN=""
 . ; If DGMTYPT=3 make sure the IAI record is associated with the
 . ; correct LTC Copay test. Added for LTC Phase III (DG*5.3*518)
 . I $G(DGMTYPT)=3,+^DGMT(408.21,IEN,"MT")'=+LTCIEN S IEN=""
 ;
 ; if veteran doesn't have a mt
 I 'MTIEN D
 . ; The following was added for LTC Copay Phase II (DG*5.3*433)
 . ; If the IAI record is associated with a LTC Copay Test (type 3),
 . ; don't return it if DGMTYPT is not type 3.
 . S IEN="" F I=0:0 S I=$O(^DGMT(408.21,"AI",+REL,-YEAR,I)) Q:'I  S IEN=I Q:'$G(^DGMT(408.21,IEN,"MT"))  D  Q:IEN
 .. I $P($G(^DGMT(408.31,+^DGMT(408.21,IEN,"MT"),0)),U,19)=3,$G(DGMTYPT)'=3 S IEN=""
 .. ; If DGMTYPT=3 make sure the IAI record is associated with the
 .. ; correct LTC Copay test. Added for LTC Phase III (DG*5.3*518)
 .. I $G(DGMTYPT)=3,+^DGMT(408.21,IEN,"MT")'=+LTCIEN S IEN=""
IAIQ Q $G(IEN)
 ;
 ;
MTIENLT(TYPE,DFN,INVDTL) ; get last primary income test on or before date
 ;
 ; Input  -- TYPE as 1 for means test, 2 for copay test
 ;           DFN as Patient IEN
 ;           INVDTL as inverse date for search
 ; Output -- Record IEN
 ;
 N K
 S K=""
 F  S INVDTL=$O(^DGMT(408.31,"AID",TYPE,DFN,INVDTL)) Q:'INVDTL  S K=$$MTIEN(TYPE,DFN,INVDTL) Q:K
 Q K
