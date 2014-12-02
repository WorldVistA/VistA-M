ICD1869P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010 ; 10/5/11 3:21pm
 ;;18.0;DRG Grouper;**69**;Oct 20, 2000;Build 4
 ;
 ;This routine will kick off Routines needed for 
 ;updates to the DRG Grouper.
 ;Depending on the type of updates needed.
 ;
 Q
EN ; Start Update
 D ICDUPDDX^ICD1869L ;Updates to existing diagnosis codes
 D ICDUPDPX^ICD1869L ;Updates to existing procedure code identifiers
 D ICDECUP1^ICD1869L ;Updates PTF EXPANDED CODE (#45.89) file
 D ICDECUP2^ICD1869L ;Updates PTF EXPANDED CODE (#45.89) file
 Q
