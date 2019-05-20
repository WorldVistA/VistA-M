VPRPROC ;SLC/MKB -- Clinical Procedures interface ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Supported by DBIA #4749
 ;
 ; ---------------- Update Triggers ----------------
 ;
UPD(DFN,IEN,STS) ; -- updated procedure request [from #702 AVPR index]
 S DFN=+$G(DFN),IEN=+$G(IEN) Q:DFN<1
 D CP^VPREVNT(DFN,IEN)
 Q
 ;
DEL(DFN,IEN) ; -- delete procedure request [from #702 AVPR index]
 S DFN=+$G(DFN),IEN=+$G(IEN) Q:DFN<1
 D CP^VPREVNT(DFN,IEN,"@")
 Q
