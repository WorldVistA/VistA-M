DGYVPRE ;ALB/LD - Patch DG*5.3*64 Pre-Init ; 8/24/95
 ;;5.3;Registration;**64**;Aug 13, 1993
 ;
 ;
 ;-- Delete existing Treating Specialty file (#42.4) and restore
 ;-- (file with data contained in init).
 ;-- Delete Census Date multiple in Facility Treating Specialty (#45.7)
 ;-- file.  This multiple was added as part of MAS V5.0 but was never
 ;-- used or populated (Census Date multiple now resides in Med Ctr 
 ;-- Division file).
 ;
EN ;-- Entry point
 W !!,">>> Deleting Treating Specialty (#42.4) file with data."
 W !,"    It will be restored."
 S DIU="^DIC(42.4,",DIU(0)="D" D EN^DIU2 K DIU
 W !!,">>> Deleting Census Date multiple from Facility Treating Specialty (#45.7) file.",!?4,"This multiple resides in the Medical Center Division (#40.8) file and was",!?4,"never used in this file."
 S DIU=45.702,DIU(0)="SD" D EN^DIU2 K DIU
ENQ Q
