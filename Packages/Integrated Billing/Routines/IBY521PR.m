IBY521PR ;ALB/GEF - Pre install routine for patch 521 ; 10-NOV-14
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
 ; INDXDD^IBY521PR will run in the pre-install to delete old x-refs
 ; POINDX^IBY521PO will run post-install to set in new format
 ;
INDXDD ; PRE-INSTALL comes here
 ; DELETE old cross-references for fields 8.01 & 8.04 (HOD & NIF) from DD and file
 D MES^XPDUTL("Removing old HPID & NIF ID cross-references in INSURANCE COMPANY file ")
 N IBFLD
 F IBFLD=8.01,8.04 D DELIX^DDMOD(36,IBFLD,1,"KW")
 Q
