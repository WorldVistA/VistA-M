IBY521PO ;ALB/GEF - Post install routine for patch 521 ; 7-NOV-14
 ;;2.0;INTEGRATED BILLING;**521**;21-MAR-94;Build 33
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; XPDUTL calls are DBIA#10141
 ;
DOC ;
 ; HPID Build 1 created 4 new fields in file 36.  
 ; 2 had cross-references which were set up to allow as look-ups.
 ; Build 2 changes those cross-references to be non-lookup.
 ; This change requires they now start with "A":
 ; 8.01 - HPID/OEID - was "HOD", now will be "AHOD"
 ; 8.04 - NID IF - was "NIF", now will be "ANIF"
 ;
 ; PRINDX^IBY521PR will run in the pre-install to delete old x-refs
 ; POINDX^IBY521PO will run post-install to set in new format
 ;
POINDX ; POST-INSTALL comes here
 ; run triggers on new cross-refs for fields 8.01 & 8.04 (AHOD & ANIF)
 D MES^XPDUTL("Re-index of HPID & NIF ID cross-references in INSURANCE COMPANY file ")
 N DIK,FLD
 ; file 36, top level
 S DIK="^DIC(36,"
 F FLD=8.01,8.04 S DIK(1)=FLD D ENALL^DIK
 Q
