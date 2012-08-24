ICD1855P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010 ; 10/5/11 3:21pm
 ;;18.0;DRG Grouper;**55**;Oct 20, 2000;Build 20
 ;
 ;This routine will kick off Routines needed for 
 ;updates to the DRG Grouper.
 ;Depending on the type of updates needed.
 ;
 Q
EN ; Start Update
 D ICDDX^ICD1855L ;Updates to existing diagnosis codes
 D ICDPX^ICD1855L ;Updates to existing procedure code identifiers
 D ICDPX1^ICD1855L ;Updates to existing procedure codes Major O.R. procedure 
 Q
