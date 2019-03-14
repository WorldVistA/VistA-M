VPRSR ;SLC/MKB -- Surgery interface ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Supported by DBIA #4750
 ;
 ; ---------------- Update Triggers ----------------
 ;
NEW(IEN,DFN,STS) ; -- new surgery request [from SROERR]
 Q  ;don't want until completed
 S IEN=+$G(IEN),DFN=+$G(DFN) Q:DFN<1
 D SR^VPREVNT(DFN,IEN)
 Q
 ;
UPD(IEN,DFN,STS) ; -- updated surgery request [from SROERR0]
 S IEN=+$G(IEN),DFN=+$G(DFN) Q:DFN<1  Q:$G(STS)'["COMPLETED"
 N VPRSR,I,SRDOC
 D ONE^SROESTV("VPRSR",IEN) S SRDOC=0
 S I=0 F  S I=$O(VPRSR(IEN,I)) Q:I<1  I $P($G(VPRSR(IEN,I)),U,7)'?1"un".E S SRDOC=1 Q
 I SRDOC D SR^VPREVNT(DFN,IEN) ;has report(s),visit#
 Q
 ;
DEL(IEN,DFN) ; -- delete surgery request [from SROERR]
 S IEN=+$G(IEN),DFN=+$G(DFN) Q:DFN<1
 D SR^VPREVNT(DFN,IEN,"@")
 Q
