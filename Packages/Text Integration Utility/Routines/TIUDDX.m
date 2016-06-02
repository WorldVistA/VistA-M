TIUDDX ;SLC/MKB,ASMR/BL - Event Cross-references ; 10/16/15 2:12pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**106**;Jun 20, 1997;Build 328
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; TIU^HMPEVNT                  6299
 ;
 ; Set/Kill Logic to broadcast updates to TIU Document file
 ;
 ; No cross reference nodes are set or killed.
 ; Subscribers must read-only the DA, X arrays provided by FileMan.
 ;
DOC ; -- AEVT index on #8925
 N DFN S DFN=$G(X(12))
 D:$L($T(TIU^VPREVNT)) TIU^VPREVNT(DFN,DA)
 D:$L($T(TIU^HMPEVNT)) TIU^HMPEVNT(DFN,DA)  ;DBIA 6299
 Q
