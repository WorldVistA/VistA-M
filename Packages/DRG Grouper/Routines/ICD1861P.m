ICD1861P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010 ; 10/5/11 3:21pm
 ;;18.0;DRG Grouper;**61**;Oct 20, 2000;Build 18
 ;
 ;This routine will kick off Routines needed for 
 ;updates to the DRG Grouper.
 ;Depending on the type of updates needed.
 ;
 Q
EN ; Start Update
 D ICDDX^ICD1861L ;Updates to existing diagnosis code identifiers
 D ICDPX^ICD1861L ;Updates to existing procedure code identifiers 
 Q
