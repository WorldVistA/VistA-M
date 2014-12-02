ICD1862P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010 ; 10/5/11 3:21pm
 ;;18.0;DRG Grouper;**62**;Oct 20, 2000;Build 10
 ;
 ;This routine will kick off Routines needed for 
 ;updates to the DRG Grouper.
 ;Depending on the type of updates needed.
 ;
 Q
EN ; Start Update
 D ICDUPDDX^ICD1862L ;Updates to existing diagnosis codes
 D ICDUPDPX^ICD1862L ;Updates to existing procedure code identifiers
 Q
