ICD1820P   ;;ALB/JAT - 2006 FY DRG GROUPER UPDATE; 7/27/05 14:50
 ;;18.0;DRG Grouper;**20**;Oct 13,2000
 ;       
 ; fix Remedy tickets
 D REMEDY^ICD1820E
 ; add new DRGs
 D ADDDRG^ICD1820A
 ; update operation/procedure codes
 D PRO^ICD1820A
 ; update diagnosis codes
 D DIAG^ICD1820C
 ; DRG reclassification changes
 D DRGRECL^ICD1820D
 S ^DD(80.2,0,"VRRV")="20^3051001"
 Q
