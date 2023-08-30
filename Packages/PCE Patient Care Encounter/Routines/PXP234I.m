PXP234I ;SLC/PKR - Init routine for PX*1.0*234 ;04/28/2023
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**234**;Aug 12, 1996;Build 6
 ;======================
PRE ;Pre-init
 Q
 ;
 ;======================
LCSHFMEASDEF ;Make sure measurements are defined for the
 ;LCS health factors: LCS PACKS/DAY and LCS YEARS SMOKED.
 N LCSPACKDAY,LCSYEARSSMOKED
 S LCSPACKDAY=$O(^AUTTHF("B","LCS PACKS/DAY",""))
 I LCSPACKDAY'="" D
 . D BMES^XPDUTL("Setting the measurement definition for the health factor LCS PACKS/DAY.")
 . S ^AUTTHF(LCSPACKDAY,220)="0^10^2^623^Packs/day^N"
 S LCSYEARSSMOKED=$O(^AUTTHF("B","LCS YEARS SMOKED",""))
 I LCSYEARSSMOKED'="" D
 . D BMES^XPDUTL("Setting the measurement definition for the health factor LCS YEARS SMOKED.")
 . S ^AUTTHF(LCSYEARSSMOKED,220)="0^80^1^623^# of years^N"
 Q
 ;
 ;======================
POST ;Post-init
 D LCSHFMEASDEF^PXP234I
 D TASKREPAIR^PXHFMEASREPAIR
 Q
 ;
