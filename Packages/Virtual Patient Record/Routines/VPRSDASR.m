VPRSDASR ;SLC/MKB -- SDA Surgery utilities ;7/29/22  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Sep 01, 2011;Build 9
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
 ;
QRY ; -- get Surgeries
 ; Query called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 N VPRY,VPRN,I,X
 D LIST^SROESTV(.VPRY,DFN,DSTRT,DSTOP,DMAX,1)
 S VPRN=0 F  S VPRN=$O(@VPRY@(VPRN)) Q:VPRN<1  I $G(@VPRY@(VPRN)) D
 . S I=+$O(@VPRY@(VPRN,0)) Q:I<1
 . S X=$G(@VPRY@(VPRN,I)) ;TIU ien ^ $$RESOLVE^TIUSRVLO data string
 . I $P(X,U,7)'="completed",$P(X,U,7)'="amended" Q
 . I $P(X,U,2)["Addendum to " Q
 . S DLIST(VPRN)=+$G(@VPRY@(VPRN))
 K @VPRY
 Q
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
