RANPRO1 ;BPFO/DTG - NEW RADIOLOGY PROCEDURE ; 27 Oct 2016  4:57 PM
 ;;5.0;Radiology/Nuclear Medicine;**138**;Mar 16, 1998;Build 22
 ;
 ; This section of the routine emulates DESC^RAUTL17 for parent and descendents
 ;
DESC(RAD0,RAY) ; Detemine if a procedure qualifies as a descendent for this
 ; parent procedure.  Descendent must be either a detailed or series
 ; type procedure, must be of same imaging type of the parent, and must
 ; not be inactive.  Called from ^DD(71.1105,.01,0)
 ; 'RAD0' ien of parent procedure in file 71.11
 ; 'RAY'  ien of pointed to procedure in file 71
 ; Returns: 'RA' i.e, 0:invalid procedure, 1:valid procedure
 ; RAPARNT: zero node of parent procedure
 ; RAPARNT(12): i-type of parent procedure
 ; RADESC     : zero node of descendent procedure
 ; RADESC("I"): inactivation date (if any) of descendent
 ; RADESC(6)  : procedure type of descendent
 ; RADESC(12) : i-type of descendent procedure
 Q:RAD0'>0!(RAY'>0) 0
 Q:'$D(^RAMRPF(71.11,RAD0,0))!('$D(^RAMIS(71,RAY,0))) 0
 N RA,RAI,RADESC,RAPARNT S RA=0
 S RAPARNT=$G(^RAMRPF(71.11,RAD0,0)),RAPARNT(12)=+$P(RAPARNT,U,12)
 S RADESC=$G(^RAMIS(71,RAY,0)),RADESC(6)=$P(RADESC,U,6)
 S RADESC(12)=$P(RADESC,U,12)
 S RADESC("I")=+$G(^RAMIS(71,RAY,"I"))
 S RAI=$S(RADESC("I")=0:1,RADESC("I")>DT:1,1:0)
 I RADESC(12)=RAPARNT(12),("^D^S^"[(U_RADESC(6)_U)),(RAI) S RA=1
 Q RA
 ;
