VPRSR ;SLC/MKB -- Surgery interface ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,15,17,20**;Sep 01, 2011;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Supported by DBIA #4750
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SRF                          5675
 ; DIQ                           2056
 ; SROESTV                       3533
 ;
 ; ---------------- Update Triggers ----------------
 ;
 ; NOT IN USE: Surgery updates now triggered via TIU
 ;             (only completed procedures w/visit)
 ;
NEW(IEN,DFN,STS) ; -- new surgery request [from SROERR]
 Q  ;don't want until completed
 S IEN=+$G(IEN),DFN=+$G(DFN) Q:DFN<1
 D POST^VPRHS(DFN,"Procedure",IEN_";130")
 Q
 ;
UPD(IEN,DFN,STS) ; -- updated surgery request [from SROERR0]
 Q  ;hit too often, now trigger off the TIU document event
 S IEN=+$G(IEN),DFN=+$G(DFN) Q:DFN<1  Q:$G(STS)'["COMPLETED"
 N VPRSR,I,SRDOC,VST
 D ONE^SROESTV("VPRSR",IEN)
 S I=+$O(VPRSR(IEN,0)),SRDOC=+$G(VPRSR(IEN,I)) Q:'SRDOC
 S VST=$$GET1^DIQ(8925,SRDOC,.03,"I")
 D:VST POST^VPRHS(DFN,"Procedure",IEN_";130",,VST)
 Q
 ;
DEL(IEN,DFN) ; -- delete surgery request [from SROERR]
 Q  ;not used (only saving completed procedures)
 S IEN=+$G(IEN),DFN=+$G(DFN) Q:DFN<1
 D POST^VPRHS(DFN,"Procedure",IEN_";130","@")
 Q
 ;
 ; ---------------- SDA ENTITY CODE -------------------
 ;
 ; The following api's support the VPR SURGERY entities
 ;     and expect VPRSR(#130 ien) = data node
 ;     as built by the SROESTV api's
 ;
PROC(IEN) ; -- returns primary CPT code^name[^CPT-4] for surgery IEN in
 ; VALUE = procedure code^name
 ;  DATA = Prin Procedure name
 N X,SROP,SDT
 I $G(VPRSR(+$G(IEN)))="" Q
 S X=$P(VPRSR(IEN),U,2),SDT=$P(VPRSR(IEN),U,3)
 ; Use CPT ien if defined
 S SROP=$$GET1^DIQ(136,IEN_",",.02,"I")
 S:'SROP SROP=$P($G(^SRF(IEN,"OP")),U,2)
 I SROP S VALUE=$$CPT^VPRSDA(SROP,SDT),DATA=X Q
 ; else use procedure name for both pieces
 S VALUE=X_U_X
 Q
 ;
RPTS(IEN) ; -- put Op Reports into DLIST(#) = TIU ien
 N I,X S IEN=+$G(IEN)
 S I=0 F  S I=$O(VPRSR(IEN,I)) Q:I<1  S X=$G(VPRSR(IEN,I)) I X D
 . ;X = ien ^ $$RESOLVE^TIUSRVLO data string
 . I $P(X,U,7)'="completed",$P(X,U,7)'="amended" Q
 . I $P(X,U,2)["Addendum to " Q
 . S DLIST(I)=+X_";TIU"
 . ; X["OPERATION REPORT"!(X["PROCEDURE REPORT") S SURG("opReport")=X
 Q
