PXRMUID ;SLC/PKR - Coding systems that can be used in a dialog. ;05/22/2017
 ;;2.0;CLINICAL REMINDERS;**42**;Feb 04, 2005;Build 80
 ;
 ;=========================================
UIDOK(CODESYS) ;List of coding systems that can be in a dialog.
 I CODESYS="10D" Q 1
 I CODESYS="CPC" Q 1
 I CODESYS="CPT" Q 1
 I CODESYS="ICD" Q 1
 I CODESYS="SCT" Q 0
 Q 0
 ;
