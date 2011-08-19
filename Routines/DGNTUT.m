DGNTUT ;ALB/RPM - Utility functions for N/T Radium Treatments ; 7/16/01 3:04pm
 ;;5.3;Registration;**397**;Aug 13, 1993
 Q
 ;
CHANGE(DGDFN,DGNTN,DGENR) ;Did the answers change?
 ;  Input
 ;      DGDFN    - Patients DFN
 ;      DGNTN("HNC")  - Head/Neck Cancer Diagnosis "Y,N"
 ;      DGNTN("NTR") - NTR Status code, "Y,N,U"
 ;      DGNTN("AVI")  - Aviator code, "Y,N"
 ;      DGNTN("SUB")  - Sub Training code, "Y,N"
 ;      DGNTN("VER") - Verification method, "S,M,N"
 ;      DGENR    - Enrollment Z11 update [optional default=0]
 ;
 ;  Output
 ;      Returns 0 if no status change
 ;              1 if status changed
 ;
 N DGCHG  ;change flag
 N DGIEN  ;IEN of existing NTR record
 N DGNTO  ;original values from $$GETCUR
 N DGX    ;generic index
 ;
 I +$G(DGDFN)'>0 Q 0
 S DGNTN("HNC")=$G(DGNTN("HNC"))
 S DGNTN("NTR")=$G(DGNTN("NTR"))
 S DGNTN("AVI")=$G(DGNTN("AVI"))
 S DGNTN("SUB")=$G(DGNTN("SUB"))
 S DGNTN("VER")=$G(DGNTN("VER"))
 S DGENR=+$G(DGENR)
 S DGCHG=0
 S DGIEN=+$$GETCUR^DGNTAPI(DGDFN,"DGNTO")
 I DGIEN>0 D
 . ;if this is an Enrollment update don't overlay a "M"ilitary Medical
 . ;Record verified record with a "S"ervice Record verified record.
 . I DGENR,$P($G(DGNTO("VER")),"^")="M",DGNTN("VER")="S" Q
 . F DGX="HNC","NTR","AVI","SUB","VER" D  Q:DGCHG
 . . I $P($G(DGNTO(DGX)),"^")'=DGNTN(DGX) S DGCHG=1
 I DGIEN=0 S DGCHG=1  ;new record
CHNGQ Q DGCHG
 ;
SITE(DGSITE) ;Convert a station number into a pointer to the
 ; INSTITUTION file (#4).  If called with a null parameter then
 ; the pointer to the INSTITUTION file (#4) of the primary site
 ; will be returned.
 ;
 ;  Input
 ;    DGSITE - Station number (optional)
 ;
 ;  Output
 ;    Return Site IEN to INSTITUTION file (#4)
 ;
 S DGSITE=$G(DGSITE)
 I DGSITE]"",$D(^DIC(4,"D",DGSITE)) D
 . S DGSITE=$O(^DIC(4,"D",DGSITE,0))
 E  D
 . S DGSITE=$P($$SITE^VASITE,U)
 I +DGSITE'>0 S DGSITE=""
 Q DGSITE
 ;
INTERP(DGINTR) ;Create external status interpretation
 ;
 ;  Input
 ;    DGINTR  - NTR record values array
 ;
 ;  Output
 ;    DGINTRP - function return
 ;                NO
 ;                YES,PENDING BOTH DOCUMENTATION AND DIAGNOSIS
 ;                YES,PENDING DIAGNOSIS
 ;                YES,VERIFIED
 ;
 N DGINTRP  ;interpretation
 N DGX      ;generic index
 N DGINT    ;temp array
 F DGX="HNC","NTR","VER" S DGINT(DGX)=$P($G(@DGINTR@(DGX)),"^")
 S DGINTRP="NO"
 I DGINT("NTR")="Y"!(DGINT("NTR")="U") D
 . I DGINT("VER")="" D
 . . S DGINTRP="YES,PENDING BOTH DOCUMENTATION AND DIAGNOSIS"
 . . I DGINT("HNC")="Y" D
 . . . S DGINTRP="YES,PENDING DOCUMENTATION"
 . I DGINT("VER")="M"!(DGINT("VER")="S") D
 . . S DGINTRP="YES,PENDING DIAGNOSIS"
 . . I DGINT("HNC")="Y" D
 . . . S DGINTRP="YES,VERIFIED"
 Q DGINTRP
 ;
STATUS(DGARR) ;Determine if screening status is complete
 ;  Input
 ;    DGARR - result array of $$GETCUR^DGNTAPI
 ;
 ;  Output - function result
 ;             0 - incomplete
 ;             1 - complete
 ;
 N DGRSLT
 N DGST   ;temp array
 S DGRSLT=0
 S DGST("NTR")=$P($G(DGARR("NTR")),"^")
 S DGST("HNC")=$P($G(DGARR("HNC")),"^")
 S DGST("VER")=$P($G(DGARR("VER")),"^")
 I DGST("NTR")="N" S DGRSLT=1
 I DGST("NTR")="Y"!(DGST("NTR")="U") D
 . S DGRSLT=2
 . I ",S,M,"[(","_DGST("VER")_",") D
 . . S DGRSLT=3
 . . I DGST("HNC")="Y" D
 . . . S DGRSLT=$S(DGST("VER")="M":4,1:5)
 . I DGST("VER")="N" S DGRSLT=6
 Q DGRSLT
