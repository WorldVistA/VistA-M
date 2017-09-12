ICD184P ;BPOIFO/ESW - ICD/DRG; 6/22/01 2:43pm ; 9/26/02 11:16am
 ;;18.0;DRG Grouper;**4**;Oct 13,2000
 ;
 ;
EN ;- Post-Install entry point
 ;
 ;- Add new Diagnoses
 D ADDDIAG^ICD184P2
 D ADDDIAG^ICD184P6
 S ^DD(80,0,"VR")="20.0"
 ;
 ;- Add new Procedures
 D ADDPROC^ICD184P1
 S ^DD(80.1,0,"VR")="20.0"
 ;
 ;- Inactivate/revise Diagnoses
 D CHGDIAG^ICD184P3
 ;
 ;- Inactivate/revise Procedures
 D CHGPROC^ICD184P3
 ;
 ;- Update Diagnoses with AGE and SEX
 D ^ICD184P4
 ;
 ;- Update Diagnoses w/complications/comorbidities
 ; This part will be included in a follow up patch
 ;D EN^ICD184P5
 ;
 Q
 ;
