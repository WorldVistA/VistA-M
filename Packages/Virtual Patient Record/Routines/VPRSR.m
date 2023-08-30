VPRSR ;SLC/MKB -- Surgery interface ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,15,17,20,30**;Sep 01, 2011;Build 9
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
