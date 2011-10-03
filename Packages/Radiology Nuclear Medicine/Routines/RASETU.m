RASETU ;HISC/DAD-Determine Order Status for an Exam Set ;6/17/97  11:17
 ;;5.0;Radiology/Nuclear Medicine;**15**;Mar 16, 1998
 ;
 ;Routine reads through all cases generated from a single order
 ;to gather information about the case statuses needed to determine
 ;what status the order should be updated to
 ;Input:   RADFN=Patient ien     <->     RAOIFN=order IEN
 ;Output:  RASTATUS array with status info about exam set passed back
 ;         format: min status_"^"_max status_"^"_$S(All_Statuses=0:1,1:0)
EN1(RAOIFN,RADFN) ;
 Q:'($D(^RADPT("AO",RAOIFN,RADFN))\10) "^^"
 ; save current RACNI so we'd know which exam to skip
 ; in the loop below if Exam Deletion is being processed, because
 ; 1. the exam node hasn't been killed off yet,
 ; 2. the exam node may have a non-cancelled exam status,
 ;    which would throw off the loop calculation below
 N RACNISAV S RACNISAV=$G(RACNI)
 ;
 N RACNI,RADTI,RAORDER,RAPROC,RASTATUS
 S RAORDER=$G(^RAO(75.1,RAOIFN,0))
 I RAORDER="" Q "^^"
 S RAPROC=+$P(RAORDER,U,2) ;             Procedure IEN
 S RASTATUS("ORD")=$P(RAORDER,U,5) ;     Initial status
 S RASTATUS("MAX")=-1 ;                  Largest status found
 S RASTATUS("MIN")=10 ;                  Smallest non-zero status found
 S RASTATUS("NUL")=1 ;                   $S(All_Statuses=0:1,1:0)
 ;
 S RADTI=0
 F  S RADTI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI)) Q:RADTI'>0  D
 . S RACNI=0
 . F  S RACNI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RACNI)) Q:RACNI'>0  D
 .. I $D(RADELFLG),RACNISAV=RACNI Q  ;skip if Exam Deletion
 .. S RASTATUS=+$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,3)
 .. S RASTATUS(0)=$P($G(^RA(72,RASTATUS,0)),U,3) Q:RASTATUS(0)=""
 .. I RASTATUS(0)>RASTATUS("MAX") S RASTATUS("MAX")=RASTATUS(0)
 .. I (RASTATUS(0)),(RASTATUS(0)<RASTATUS("MIN")) D
 ... S RASTATUS("MIN")=RASTATUS(0)
 ... Q
 .. I RASTATUS(0)>0 S RASTATUS("NUL")=0
 .. Q
 . Q
 Q RASTATUS("MIN")_"^"_RASTATUS("MAX")_"^"_RASTATUS("NUL")
 ;
PARNT(RAOIFN,RADFN) ; Based on the patient and the order number, determine
 ;                 if the exams are part of an exam set.
 ;  Input: 'RAOIFN' -> Order #            'RADFN' -> Patient ien
 ; Output: $S(Exam Set:1,1:0)
 ;
 Q:'($D(^RADPT("AO",RAOIFN,RADFN))\10) 0
 N RADTI,RARXM
 S RADTI=+$O(^RADPT("AO",RAOIFN,RADFN,0)) Q:'RADTI 0
 S RARXM(0)=$G(^RADPT(RADFN,"DT",RADTI,0))
 Q +$P(RARXM(0),"^",5)
