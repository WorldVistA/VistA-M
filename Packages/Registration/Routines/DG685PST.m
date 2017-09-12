DG685PST ;BAY/ALS;cleanup Patient Date Review exceptions ; 11/15/05
 ;;5.3;Registration;**685**;Aug 13,1993
 ;
 ; This is a post-install routine for DG*5.3*685
 ; The purpose is to cleanup Patient Data Review exceptions.
 ; When an entry exists in the PATIENT DATA EXCEPTION (391.98) file
 ; and the corresponding data is missing from the PATIENT DATA
 ; ELEMENT (391.99) file the exception will be retired. 
 ;
EN ; 
 N DGPDR,IEN
 S IEN=0
 F  S IEN=$O(^DGCN(391.98,IEN)) Q:'IEN  D
 . I '$O(^DGCN(391.99,"B",IEN,0)) D
 .. I $P($G(^DGCN(391.98,IEN,0)),"^",4)'=6 S DGPDR=$$EDIT^VAFCEHU1(IEN,"RD")
 Q
